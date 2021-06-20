package com.jey.webapp.ajax.controller;


import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jey.webapp.account.service.AccountService;


@Controller
@RequestMapping("/ajax/account")
public class AjaxAccountController {
	
	@Autowired
	private AccountService account;
	
	@RequestMapping(value = "/email", method = RequestMethod.GET, produces = "application/json; charset=utf-8" )
	@ResponseBody	// ViewResolver 를 사용하지 않음.
	public String checkEmail(@RequestParam String email) throws Exception {
		boolean res = account.checkEmail(email);
		
		JSONObject json = new JSONObject();			
		json.put("result", res);
		
		return json.toJSONString();
	}
}
