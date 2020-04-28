package com.wang.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wang.entity.User;
import com.wang.service.UserService;
import com.wang.utils.Msg;


@Controller
public class LoginController {
	@Autowired
	private UserService userService;

	@RequestMapping("/login/login")
	public String login(){
		return "login";
	}
	@RequestMapping("/login")
	public String login1(){
		return "login";
	}
	@RequestMapping("/")
	public String login3(){return "login";}
	@ResponseBody
	@RequestMapping("/login/index")
	public Msg loginIndex(User user,HttpSession httpSession,HttpServletRequest request) {
		User user1 = userService.findUserByUsername(user.getUsername());
		String code = request.getParameter("code");
		System.out.println("code="+code);
		String vcode = (String) request.getSession().getAttribute("verifycode");

		if (code.equals(vcode)) {
			if (user1.getPassword().equals(user.getPassword())) {
				httpSession.setAttribute("user", user1);
				return Msg.success();

			} else {
				return Msg.fail().add("va_msg", "密码错误");
			}
		}else {
			return Msg.codeFail().add("va_msg","验证码错误");
		}
	}
	//ajax校验username是否存在
	@ResponseBody
	@RequestMapping("/login/checkUsernameExit")
	public Msg checkUsernameExit(@RequestParam("username")String username){
		System.out.println("username:"+username);
		User user=userService.findUserByUsername(username);
		if(user==null)
		{
			return Msg.fail().add("va_msg", "用户名不存在");
		}
		return Msg.success();
	}
	@ResponseBody
	@RequestMapping("/login/checkVerifyCode")
	public Msg checkVerifyCode(@RequestParam("verifyCode")String verifyCode, HttpServletRequest request){
		System.out.println("vericyCode:"+verifyCode);
		String vcode =(String)request.getSession().getAttribute("verifycode");
		if(!verifyCode.equals(vcode.toLowerCase()))
		{
			return Msg.codeFail().add("va_msg", "验证码错误");
		}
		return Msg.success();
	}
}
