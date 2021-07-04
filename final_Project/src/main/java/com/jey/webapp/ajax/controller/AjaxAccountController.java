package com.jey.webapp.ajax.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jey.webapp.account.dto.AccountAddressDTO;
import com.jey.webapp.account.dto.AccountDTO;
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
		if(res) {
			json.put("result", true);
		} else {
			json.put("result", false);
		}
		return json.toJSONString();
	}
	
	@RequestMapping(value = "/address/add", method = RequestMethod.POST, produces = "application/json; charset=utf-8" )
	@ResponseBody	// ViewResolver 를 사용하지 않음.
	public String addAddress(@RequestParam String address, HttpSession session) throws Exception {
		AccountDTO dto = (AccountDTO) session.getAttribute("account");
		
		int aid = dto.getId();
		AccountAddressDTO addressDTO = new AccountAddressDTO();
		addressDTO.setAid(aid);
		
		 boolean res = account.addAddress(aid, address);
		 JSONObject json = new JSONObject();
		 if(res) {
		 	json.put("res", "success");
		 	json.put("address", address);
		 } else {
			 json.put("res", "fail");
		 }
		
		 return json.toJSONString();
	}
	
//	@RequestMapping(value = "/address/delete", method = RequestMethod.GET, produces = "application/json; charset=utf-8" )
//	@ResponseBody	// ViewResolver 를 사용하지 않음.
//	public String deleteAddress(@RequestParam String email) throws Exception {
//		boolean res = account.checkEmail(email);
//		
//		JSONObject json = new JSONObject();
//		if(res) {
//			json.put("result", true);
//		} else {
//			json.put("result", false);
//		}
//		return json.toJSONString();
//	}
}