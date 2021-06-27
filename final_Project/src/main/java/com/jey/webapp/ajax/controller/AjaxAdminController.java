package com.jey.webapp.ajax.controller;


import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jey.webapp.order.dto.OrderDTO;
import com.jey.webapp.order.dto.ReviewDTO;
import com.jey.webapp.order.service.OrderService;
import com.jey.webapp.product.dto.LikeDTO;
import com.jey.webapp.product.dto.ProductDTO;
import com.jey.webapp.product.dto.ReviewSearchDTO;
import com.jey.webapp.product.service.ProductService;


@Controller
@RequestMapping("/ajax/admin/order")
public class AjaxAdminController {
	
	@Autowired
	private OrderService order;

	
	/* 주문확인 후 배송 상태표시 */
	
	@RequestMapping(value = "/checked", produces = "application/text;charset=UTF-8", method=RequestMethod.POST)
	@ResponseBody
	public String checkOrder(@ModelAttribute OrderDTO dto) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		boolean res = order.updateStatus(dto);
		
		JSONObject json = new JSONObject();			
		if(res) {
			json.put("res", "true");
		}
		
		return json.toJSONString();
	}
	
	
}
