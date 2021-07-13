package com.jey.webapp.ajax.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jey.webapp.account.dto.AccountAddressDTO;
import com.jey.webapp.account.dto.AccountDTO;
import com.jey.webapp.account.service.AccountService;
import com.jey.webapp.order.dto.OrderDTO;
import com.jey.webapp.order.dto.OrderDetailDTO;


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
	   @RequestMapping(value = "/address/delete", method = RequestMethod.POST, produces = "application/json; charset=utf-8" )
	   @ResponseBody
	   public String deleteAddress(@ModelAttribute AccountAddressDTO dto, HttpServletResponse resp,HttpServletRequest request) throws Exception {
	      
	      JSONObject json = new JSONObject();         
	      System.out.println("id 확인!"+dto.getId());
	      // deliver_address에서 data 삭제 
	      account.deleteAddress(dto);
	      json.put("result", "주소가 삭제되었습니다.");
	      json.put("redirect", request.getContextPath() + "/account/update_view");
	     
	      return json.toJSONString();
	   }
	   @RequestMapping(value = "/address/delete/new", method = RequestMethod.POST, produces = "application/json; charset=utf-8" )
	   @ResponseBody
	   public String deletenewAddress(@ModelAttribute AccountAddressDTO dto, HttpServletResponse resp,HttpServletRequest request) throws Exception {
	      
	      JSONObject json = new JSONObject();         
	      System.out.println("address 확인!"+dto.getAddress());
	      // deliver_address에서 data 삭제 
	      account.deletenewAddress(dto);
	      
	      //주소 조회
	      HttpSession session = request.getSession();
	      //계정 정보 확인
	      AccountDTO accountdto = (AccountDTO) session.getAttribute("account");
	      dto.setAid(accountdto.getId());
	      List<AccountAddressDTO> address_arr =  account.getList(dto.getAid());
	      
	      json.put("result", "주소가 삭제되었습니다.");
	      json.put("redirect", request.getContextPath() + "/account/update_view");
	      //json.put("address_arr", address_arr);
	      return json.toJSONString();
	   }
	
	
}