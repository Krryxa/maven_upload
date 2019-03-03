package com.krry.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * KrryController
 * controller层，作为请求转发
 * @author asusaad
 *
 */
@Controller  //表示是多例模式，每个用户返回的web层是不一样的
public class KrryController {
	
	@RequestMapping("/index")
	public String index(){
//		ModelAndView modelAndView = new ModelAndView();
//		modelAndView.setViewName("index/login"); //跳到此页面
//		return modelAndView;
		return "index";
	}
	
}



