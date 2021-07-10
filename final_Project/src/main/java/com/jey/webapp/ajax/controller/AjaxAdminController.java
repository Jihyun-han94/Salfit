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
import com.jey.webapp.admin.dto.AdminOrderDTO;
import com.jey.webapp.admin.dto.AdminOrderDetailDTO;
import com.jey.webapp.admin.dto.Criteria;
import com.jey.webapp.admin.service.AdminService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jey.webapp.product.dto.LikeDTO;
import com.jey.webapp.product.dto.ProductDTO;
import com.jey.webapp.product.dto.ReviewSearchDTO;
import com.jey.webapp.product.service.ProductService;


@Controller
@RequestMapping("/ajax/admin/order")
public class AjaxAdminController {
	
	@Autowired
	private AdminService order;

	
	/* 주문확인 후 배송 상태표시 */
	
	@RequestMapping(value = "/checked", produces = "application/text;charset=UTF-8", method=RequestMethod.POST)
	@ResponseBody
	public String checkOrder(@ModelAttribute AdminOrderDTO dto) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		boolean res = order.updateStatus(dto);
		
		JSONObject json = new JSONObject();			
		if(res) {
			json.put("res", "true");
		}
		
		return json.toJSONString();
	}
	
	/* 디테일 배송중 */
	
	@RequestMapping(value = "/delivery", produces = "application/text;charset=UTF-8", method=RequestMethod.POST)
	@ResponseBody
	public String checkdelivery(AdminOrderDTO ord, @ModelAttribute AdminOrderDetailDTO dto) throws Exception {
		ModelAndView mv = new ModelAndView();
		boolean res = false;
		
		ord.setId(dto.getOid());
		ord.setStatus(dto.getStatus());
		
		if(order.updateDetailStatus(dto)) {
			res = order.updateStatus(ord);
		}
		
		JSONObject json = new JSONObject();			
		if(res) {
			json.put("res", "true");
		}
		
		return json.toJSONString();
	}
	
	
	/* 디테일 배송완료 */
	@RequestMapping(value = "/delivered", produces = "application/text;charset=UTF-8", method=RequestMethod.POST)
	@ResponseBody
	public String delivered(AdminOrderDTO ord, @ModelAttribute AdminOrderDetailDTO dto) throws Exception {
		ModelAndView mv = new ModelAndView();
		boolean res = false;
		
		
		ord.setId(dto.getOid());
		ord.setStatus(dto.getStatus());
		
		res = order.updateDetailStatus(dto); 
//			 order.updateStatus(ord); 	-> 이부분은 고객이 하는걸로 
		
		System.out.println("ddd: " + dto.getOid() +","+dto.getStatus());
		
		JSONObject json = new JSONObject();			
		if(res) {
			json.put("res", "true");
		}
		
		return json.toJSONString();
	}
	
	
	/* 주문 취소완료 */
	
	@RequestMapping(value = "/cancel", produces = "application/text;charset=UTF-8", method=RequestMethod.POST)
	@ResponseBody
	public String confirmCancel(@ModelAttribute AdminOrderDTO dto) throws Exception {
		ModelAndView mv = new ModelAndView();
		System.out.println("status : " +dto.getStatus());
		boolean res = order.updateStatus(dto);
		System.out.println("res" + res);
		JSONObject json = new JSONObject();			
		if(res) {
			json.put("res", "true");
		}
		
		return json.toJSONString();
	}
	
	
}
