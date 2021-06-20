package com.jey.webapp.admin.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.jey.webapp.order.dto.OrderDTO;
import com.jey.webapp.order.service.OrderService;

@Controller
@RequestMapping(value = "/admin/order")
public class AdminOrderController {
	
	@Autowired
	private OrderService order;

	
	/* 주문확인 후 상태표시 */
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String login() throws Exception {
		return "admin/order/list";
	}
	
	@RequestMapping(value = "/check", method = RequestMethod.POST)
	public String userLogin(Model m, @ModelAttribute OrderDTO dto, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String forward = "";
		return forward;
	}
	
	/* 주문확인, 배송중, 배송완료, 취소요청, 취소완료 */
	
	@RequestMapping(value = "/checked", method = RequestMethod.GET)
	public ModelAndView checked(@ModelAttribute OrderDTO dto) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("redirect:/order");
		
		return mv;
	}
	
}
