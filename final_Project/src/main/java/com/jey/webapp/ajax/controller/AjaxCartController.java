package com.jey.webapp.ajax.controller;


import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jey.webapp.cart.dto.CartDTO;
import com.jey.webapp.cart.service.CartService;

@Controller
@RequestMapping("/ajax/cart")
public class AjaxCartController {
	
	@Autowired
	private CartService cart;
	
	
	/* 장바구니 아이템 수량 조정 -> update 하나로 통합하고 매개변수에 +/- 정보 넣기 -> 동적 sql 사용  */
	
	@RequestMapping(value = "/changeQty", method = RequestMethod.GET, produces = "application/json; charset=utf-8" )
	@ResponseBody	
	public String plusQty(@ModelAttribute CartDTO dto) throws Exception {
		boolean res = cart.changeQty(dto);
		
		JSONObject json = new JSONObject();			
		json.put("result", res);
		
		return json.toJSONString();
	}
	
	
	/* 장바구니 아이템 삭제 */
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST, produces = "application/json; charset=utf-8" )
	@ResponseBody	
	public String deleteVisit(@RequestParam int id, @ModelAttribute CartDTO dto, HttpServletRequest request) throws Exception {
		JSONObject json = new JSONObject();		
		boolean res;
		if(res = cart.remove(dto)) {
			json.put("result", res);
			json.put("redirect", request.getContextPath() + "/cart/mycart");
		} else {
			json.put("result", "fail");
		}
		return json.toJSONString();
	}
	
}
