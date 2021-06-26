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

import com.jey.webapp.account.dto.AccountDTO;
import com.jey.webapp.order.dto.AdminOrderDTO;
import com.jey.webapp.order.dto.OrderDTO;
import com.jey.webapp.order.service.OrderService;

@Controller
@RequestMapping(value = "/admin/order")
public class AdminOrderController {
	
	@Autowired
	private OrderService order;

	/* 주문번호 생성 */
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String createOrder(Model m, @ModelAttribute OrderDTO dto, HttpServletRequest request, HttpSession session) throws Exception {
		
		
		// 주문 임의 설정 
		dto.setAid(2);
		dto.setReciever("최예림");
		dto.setAddress("수원시 영통구 하동 광교호수로 152번길 23 2302동 1903호");
		dto.setPaytype("신용카드");
		dto.setTotal(10380);
		dto.setStatus("delived");
		
		
		boolean res = order.add(dto);
		
		if(res == true) {
			return "admin/order/manage";
		}
		
		return "error/default";
	}
	
	
	/* 주문확인 */
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String manageOrder(Model m, @ModelAttribute OrderDTO dto, HttpServletRequest request, HttpSession session) throws Exception {
//		session = request.getSession();
//		AccountDTO account = (AccountDTO) session.getAttribute("account");
//		System.out.println(account.getId());
//		m.addAttribute("account", account);
		
		List<OrderDTO> orderlist = order.findList(dto);
//		System.out.println(orderlist.get(0).getReciever());
//		System.out.println(orderlist.get(0).getDdate().toString());
		m.addAttribute("orderlist",orderlist);
		m.addAttribute("dto",dto);
		return "admin/order/manage";
	}
	
	
	/* 주문확인, 배송중, 배송완료, 취소요청, 취소완료 */
	
	
	
}
