package com.wang.controller;


import com.wang.service.DepotcardService;
import com.wang.service.ParkspaceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wang.dto.ParkinfoallData;
import com.wang.service.ParkinfoallService;
import com.wang.utils.Msg;


@Controller
public class DepotController {

	@Autowired
	private ParkinfoallService parkinfoallService;
	@Autowired
	private DepotcardService depotcardService;
	@Autowired
	private ParkspaceService parkspaceService;

	@ResponseBody
	@RequestMapping("/index/depot/findParkinfoById")
	public Msg findParkinfo(@RequestParam("id") Integer id)
	{
		ParkinfoallData parkinfoall=parkinfoallService.findById(id.intValue());
		if(parkinfoall!=null)
		{
			return Msg.success().add("parkinfoall", parkinfoall);
		}
		return Msg.fail().add("va_msg", "系统出错，找不到该停车信息。");
	}

	@ResponseBody
	@RequestMapping("/index/depot/checkTem")
	public Msg checkTem()
	{
		int cardcount=depotcardService.findAllDepotcardCount("");
		int parkcount=parkspaceService.findAllParkspaceCount(0);
		//没有多余临时停车位
		if(cardcount+5>=parkcount)
		{
			return Msg.fail();
		}
		return Msg.success();
	}

}
