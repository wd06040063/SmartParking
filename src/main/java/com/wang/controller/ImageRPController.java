package com.wang.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.istack.logging.Logger;
import com.wang.utils.Msg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.wang.dto.FormData;
import com.wang.entity.ParkInfo;
import com.wang.entity.Result;
import com.wang.service.CouponService;
import com.wang.service.DepotcardService;
import com.wang.service.IllegalInfoService;
import com.wang.service.IncomeService;
import com.wang.service.ParkinfoService;
import com.wang.service.ParkinfoallService;
import com.wang.service.ParkspaceService;
import com.wang.service.PlateRecognise;
import com.wang.service.UserService;
import com.wang.serviceImpl.PlateRecogniseImpl;

import static org.bytedeco.javacpp.opencv_highgui.imread;
import static com.wang.core.CoreFunc.getPlateType;
import static com.wang.core.CoreFunc.projectedHistogram;
import static com.wang.core.CoreFunc.showImage;

import java.util.Vector;

import org.bytedeco.javacpp.opencv_core.Mat;
import com.wang.core.CharsIdentify;
import com.wang.core.CharsRecognise;
import com.wang.core.CoreFunc;
import com.wang.core.PlateDetect;
import com.wang.core.PlateLocate;
@Controller
public class ImageRPController {

	private static final Logger logger = Logger.getLogger(ImageRPController.class);

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

	@RequestMapping(value = "/fileUpload")
	public String fileUpload() {

		return "error";
	}
	@RequestMapping(value = "update/fileUpload")
	@ResponseBody
	public Msg upload(@RequestParam("fileupdate") MultipartFile file, @RequestParam("id")int id, HttpServletResponse response, HttpServletRequest request) {
		int parkId=id;
		ParkInfo parkInfo=new ParkInfo();
		FormData formData=new FormData();
		System.out.println(parkId);

		String fileName = file.getOriginalFilename();
		@SuppressWarnings("unused")
		String suffixName = fileName.substring(fileName.lastIndexOf("."));
		String filePath= request.getServletContext().getRealPath("/image/");
		System.out.println("上传路径为："+filePath);
		//String filePath = "C:/springUpload/image/";
		// fileName = UUID.randomUUID() + suffixName;
		File dest = new File(filePath + fileName);
		if (!dest.getParentFile().exists()) {
			dest.getParentFile().mkdirs();
		}
		try {
			file.transferTo(dest);
			PlateRecognise plateRecognise = new PlateRecogniseImpl();
			String img = filePath + fileName;
			logger.info(img);
			PlateDetect plateDetect = new PlateDetect();
			plateDetect.setPDLifemode(true);
			List<String> res = plateRecognise.plateRecognise(filePath + fileName);

			if (res.size() < 1 || res.contains("")) {
				logger.info("识别失败！不如换张图片试试？");

				return Msg.fail().add("va_msg", "识别失败，请重新识别！");

			}
			String carNum=res.get(0);
			Result result = new Result(201, plateRecognise.plateRecognise(filePath + fileName),
					new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			logger.info(result.toString());
			if (depotcardService.findCardnumByCarnum(carNum)!=null) {
				formData.setCardNum(depotcardService.findCardnumByCarnum(carNum));
				formData.setCarNum(carNum);
				formData.setParkNum(parkId);
				formData.setParkTem(0);
			}else {
				formData.setCardNum("");
				formData.setCarNum(carNum);
				formData.setParkNum(parkId);
				formData.setParkTem(1);
			}
			parkinfoservice.saveParkinfo(formData);
			parkspaceService.changeStatus(parkId, 1);

			return Msg.success().add("vb_msg",carNum);
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return Msg.fail().add("va_msg","车牌识别失败！请重试.......");
	}





	@RequestMapping(method = RequestMethod.GET, value = "/plateRecognise")
	public List<String> plateRecognise(@RequestParam("imgPath") String imgPath) {
		PlateRecognise plateRecognise = new PlateRecogniseImpl();
		return plateRecognise.plateRecognise(imgPath);
	}
}
