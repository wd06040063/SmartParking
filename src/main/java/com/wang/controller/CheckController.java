package com.wang.controller;

import static org.hamcrest.CoreMatchers.nullValue;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wang.dto.CouponData;
import com.wang.dto.FormData;
import com.wang.entity.Depotcard;
import com.wang.entity.IllegalInfo;
import com.wang.entity.Income;
import com.wang.entity.ParkInfo;
import com.wang.entity.Parkinfoall;
import com.wang.entity.User;
import com.wang.service.CouponService;
import com.wang.service.DepotcardService;
import com.wang.service.IllegalInfoService;
import com.wang.service.IncomeService;
import com.wang.service.ParkinfoService;
import com.wang.service.ParkinfoallService;
import com.wang.service.ParkspaceService;
import com.wang.service.UserService;
import com.wang.utils.Constants;
import com.wang.utils.Msg;


@Controller
public class CheckController {

	@Autowired
	private ParkinfoService parkinfoservice;
	@Autowired
	private ParkspaceService parkspaceService;
	@Autowired
	private DepotcardService depotcardService;
	@Autowired
	private UserService userService;
	@Autowired
	private IllegalInfoService illegalInfoService;
	@Autowired
	private ParkinfoallService parkinfoallService;
	@Autowired
	private IncomeService incomeService;
	@Autowired
	private CouponService couponService;

	static int i=0;
	@RequestMapping("/index/check/checkIn")
	@ResponseBody
	@Transactional
	// 入库操作
	public Msg checkIn(Model model, FormData data) {
		Depotcard depotcard=depotcardService.findByCardnum(data.getCardNum());
		if(data.getParkTem()!=1)
		{
			if(depotcard!=null)
			{
				if(depotcard.getIslose()==1)
				{
					return Msg.fail().add("va_msg", "该卡已挂失！");
				}
			}else{
				return Msg.fail().add("va_msg", "该卡不存在！");
			}
		}
		parkinfoservice.saveParkinfo(data);
		parkspaceService.changeStatus(data.getId(), 1);
		return Msg.success();
	}

	@RequestMapping("/index/check/checkOut")
	@ResponseBody
	@Transactional
	// 出库操作（0扣费，1不用扣费，9付钱）
	public Msg checkOut(Model model, FormData data) {
		int pay_money=data.getPay_money();
		Date parkout=new Date();
		Parkinfoall parkinfoall=new Parkinfoall();
		ParkInfo parkInfo=parkinfoservice.findParkinfoByParknum(data.getParkNum());
		if(data.getPay_type()==9)
		{
			Depotcard depotcard=depotcardService.findByCardnum(data.getCardNum());
			IllegalInfo illegalInfo=illegalInfoService.findByCardnumParkin(data.getCardNum(),parkInfo.getParkin());
			Income income=new Income();
			List<CouponData> coupons=couponService.findAllCouponByCardNum(data.getCardNum(), "");
			if(coupons!=null&&coupons.size()>0)
			{
				couponService.deleteCoupon(coupons.get(0).getId());
			}
			depotcardService.addMoney(data.getCardNum(), 0);
			income.setMoney(pay_money);
			income.setMethod(data.getPayid());
			income.setCardnum(data.getCardNum());
			income.setCarnum(data.getCarNum());
			if(depotcard!=null)
			{
				income.setType(depotcard.getType());
			}
			if(illegalInfo!=null)
			{
				income.setIsillegal(1);
			}
			income.setSource(1);
			income.setTime(parkout);
			Date parkin=parkInfo.getParkin();
			long day=parkout.getTime()-parkin.getTime();
			long time=day/(1000*60);
			if(day%(1000*60)>0){
				time+=1;
			}
			income.setDuration(time);
			incomeService.save(income);
		}else{
			if(data.getPay_type()==9)
			{
				return Msg.fail().add("va_msg", "系统出错！");
			}else if(data.getPay_type()==0)
			{
				//正常扣费，月卡或年卡过期
				Depotcard depotcard=depotcardService.findByCardnum(data.getCardNum());
				IllegalInfo illegalInfo=illegalInfoService.findByCardnumParkin(data.getCardNum(),parkInfo.getParkin());
				double money=depotcard.getMoney();
				List<CouponData> coupons=couponService.findAllCouponByCardNum(data.getCardNum(), "");
				if(coupons!=null&&coupons.size()>0)
				{
					money-=coupons.get(0).getMoney();
					couponService.deleteCoupon(coupons.get(0).getId());
				}
				money-=pay_money;
				depotcardService.addMoney(depotcard.getCardnum(),money);
				/*Income income=new Income();
				income.setMoney(pay_money);
				income.setMethod(data.getPayid());
				income.setCardnum(data.getCardNum());
				income.setCarnum(data.getCarNum());
				income.setType(depotcard.getType());
				if(illegalInfo!=null)
				{
					income.setIsillegal(1);
				}
				income.setSource(1);
				income.setTime(parkout);*/
				/*Date parkin=parkInfo.getParkin();
				long day=parkout.getTime()-parkin.getTime();
				long time=day/(1000*60);
				if(day%(1000*60)>0){
				time+=1;
				}
				income.setDuration(time);
				income.setTrueincome(1);
				incomeService.save(income);*/
			}else{
				//月卡或年卡在期
			}
		}
		parkinfoall.setCardnum(parkInfo.getCardnum());
		parkinfoall.setCarnum(parkInfo.getCarnum());
		parkinfoall.setParkin(parkInfo.getParkin());
		parkinfoall.setParknum(data.getParkNum());
		parkinfoall.setParkout(parkout);
		parkinfoall.setParktemp(parkInfo.getParktem());
		parkinfoallService.save(parkinfoall);
		parkspaceService.changeStatusByParkNum(data.getParkNum(),0);
		parkinfoservice.deleteParkinfoByParkNum(data.getParkNum());
		return Msg.success();
	}

	@RequestMapping("/index/check/findParkinfoByParknum")
	@ResponseBody
	// 根据停车位号查找停车位信息
	public Msg findParkinfoByParknum(@RequestParam("parkNum") int parknum) {
		ParkInfo parkInfo = parkinfoservice.findParkinfoByParknum(parknum);
		System.out.println("查找停车信息为："+parkInfo);
		if(parkInfo.getCardnum()!=null){
			return Msg.success().add("parkInfo", parkInfo);
		}else{
			return Msg.fail();
		}
	}

	@RequestMapping("/index/check/findParkinfoByCardnum")
	@ResponseBody
	// 根据停车位号/车牌号查找停车位信息
	public Msg findParkinfoByCardnum(@RequestParam("cardnum") String cardnum) {
		ParkInfo parkInfo = parkinfoservice.findParkinfoByCardnum(cardnum);
		//System.out.println("ello"+parkInfo.getId());
		if(parkInfo!=null)
		{
			return Msg.success().add("parkInfo", parkInfo);
		}else {
			return Msg.fail();
		}

	}
	@RequestMapping("/index/check/findParkinfoByCarnum")
	@ResponseBody
	// 根据车牌号查找停车位信息
	public Msg findParkinfoByCarnum(@RequestParam("carnum") String carnum) {
		ParkInfo parkInfo = parkinfoservice.findParkinfoByCarnum(carnum);
		System.out.println("ello"+parkInfo);
		if(parkInfo!=null)
		{
			return Msg.success().add("parkInfo", parkInfo);
		}else {
			return Msg.fail();
		}

	}
	@RequestMapping("/index/check/findParkinfoDetailByParknum")
	@ResponseBody
	//根据停车位号查找停车详细信息
	public Msg findParkinfoDetailByParknum(@RequestParam("parkNum") int parknum)
	{
		ParkInfo parkInfo = parkinfoservice.findParkinfoByParknum(parknum);
		if(parkInfo==null)
		{
			return Msg.fail();
		}
		Date date=parkInfo.getParkin();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String parkin=formatter.format(date);
		System.out.println(parkInfo.toString());
		String cardnum=parkInfo.getCardnum();
		Depotcard depotcard=depotcardService.findByCardnum(cardnum);
		int cardid=0;
		User user =null;
		if(depotcard!=null)
		{
			cardid=depotcard.getId();
			user =userService.findUserByCardid(cardid);
		}
		return Msg.success().add("parkInfo", parkInfo).add("user", user).add("parkin", parkin);
	}

	@RequestMapping("/index/check/illegalSubmit")
	@ResponseBody
	@Transactional
	//违规提交
	public Msg illegalSubmit( HttpSession httpSession,FormData data)
	{

		User currentUser=(User) httpSession.getAttribute("user"); //获取添加违规管理员信息
		ParkInfo parkInfo=parkinfoservice.findParkinfoByCarnum(data.getCarNum()); //获取违规车牌号
		System.out.println("获取到前端提交违规数据："+data);
		IllegalInfo info=new IllegalInfo();
		IllegalInfo illegalInfo=illegalInfoService.findByCarnum(data.getCarNum(),parkInfo.getParkin()); //判断是否该车有违规信息
		System.out.println(illegalInfo);
		if(illegalInfo!=null)
		{
			return Msg.fail().add("va_msg", "添加失败,已经有违规！");
		}
		if(data.getCardNum()!=null){
			info.setCardnum(data.getCardNum());
		}

		info.setCarnum(data.getCarNum()); //设置车牌号
		Date date=new Date();  //设置违规时间
		info.setTime(date);
		info.setIllegalInfo(data.getIllegalInfo());//违规信息
		if(currentUser.getId()==1){
			info.setUid(1);
		}else{
			info.setUid(2);
		}
		info.setParkin(parkInfo.getParkin());
		info.setDelete("N");

		try {
			illegalInfoService.save(info);

		} catch (Exception e) {
			e.printStackTrace();
			return Msg.fail().add("va_msg", "违规添加失败");
		}
		return Msg.success().add("va_msg", "违规添加成功");
	}

	/*是否需要支付
	 * type:0是正常扣费
	 * type:1是月卡年卡没到期*/
	@RequestMapping("/index/check/ispay")
	@ResponseBody
	public Msg ispay(@RequestParam("parknum") Integer parknum)
	{
		ParkInfo parkInfo=parkinfoservice.findParkinfoByParknum(parknum.intValue());
		Date date=new Date();
		Date parkin;
		long time=0;
		long day=0;
		int illegalmoney=0;
		//临时停车（10块）
		if(parkInfo==null)
		{
			return Msg.fail().add("type", 9);
		}
		//是否有违规需要缴费
		IllegalInfo illegalInfo=illegalInfoService.findByCarnum(parkInfo.getCarnum(),parkInfo.getParkin());
		if(illegalInfo!=null)
		{
			illegalmoney=Constants.ILLEGAL;
		}
		if(StringUtils.isEmpty(parkInfo.getCardnum()))
		{
			//需要现金或扫码支付,1小时10块
			parkin=parkInfo.getParkin();
			day=date.getTime()-parkin.getTime();
			time=day/(1000*60*60);
			if(day%(1000*60*60)>0){
				time+=1;
			}
			return Msg.success().add("money_pay", time*Constants.TEMPMONEY+illegalmoney).add("va_msg", "临时停车"+(illegalmoney>0? ",有违规："+illegalInfo.getIllegalInfo():""));
		}
		String cardnum=parkInfo.getCardnum();
		Depotcard depotcard=depotcardService.findByCardnum(cardnum);
		//正常卡（8块）
		if(depotcard!=null&&depotcard.getType()==1)
		{
			//卡中余额
			double balance=depotcard.getMoney();
			int money=0;
			List<CouponData> coupons=couponService.findAllCouponByCardNum(cardnum, "");
			if(coupons!=null&&coupons.size()>0)
			{
				money=coupons.get(0).getMoney();
			}
			parkin=parkInfo.getParkin();
			day=date.getTime()-parkin.getTime();
			time=day/(1000*60*60);
			if(day%(1000*60*60)>0){
				time+=1;
			}
			if(balance+money-illegalmoney<time*Constants.HOURMONEY)
			{
				return Msg.success().add("money_pay", time*Constants.HOURMONEY+illegalmoney-money-balance).add("va_msg", "余额不足"+(illegalmoney>0? ",有违规："+illegalInfo.getIllegalInfo():""));
			}else{
				return Msg.fail().add("type", 0).add("money_pay", time*Constants.HOURMONEY+illegalmoney-money);
			}
		}
		Date deductedtime=depotcard.getDeductedtime();
		if(depotcard.getType()>1)
		{
			day=date.getTime()-deductedtime.getTime();
		}
		if(depotcard.getType()==3){
			time=day/(1000*60*60*24*30);
		}
		if(depotcard.getType()==4){
			time=day/(1000*60*60*24*365);
		}
		//如果月卡或年卡没到期，直接出库
		if(time<1)
		{
			return Msg.fail().add("type", 1);
		}else{
			//否则查看停车卡余额是否足够扣费，不够则需要现金或扫码
			//卡中余额
			double balance=depotcard.getMoney();
			int money=0;
			List<CouponData> coupons=couponService.findAllCouponByCardNum(cardnum, "");
			if(coupons!=null&&coupons.size()>0)
			{
				money=coupons.get(0).getMoney();
			}
			parkin=parkInfo.getParkin();
			day=date.getTime()-parkin.getTime();
			time=day/(1000*60*60);
			if(day%(1000*60*60)>0){
				time+=1;
			}
			if(balance+money-illegalmoney<time*Constants.HOURMONEY)
			{
				return Msg.success().add("money_pay", time*Constants.HOURMONEY+illegalmoney-money-balance).add("va_msg", "余额不足"+(illegalmoney>0? ",有违规："+illegalInfo.getIllegalInfo():""));
			}else{
				return Msg.fail().add("type", 0);
			}
		}
	}

}
