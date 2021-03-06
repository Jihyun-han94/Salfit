package com.jey.webapp.order.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.jey.webapp.account.dto.AccountDTO;
import com.jey.webapp.order.dto.OrderDTO;
import com.jey.webapp.order.dto.OrderDetailDTO;
import com.jey.webapp.order.dto.ReviewDTO;
import com.jey.webapp.order.service.OrderService;
//머지용

@Controller
@RequestMapping(value = "/order")
public class OrderController {
	
	@Autowired
	private OrderService order;

	/* 주문 내역 전체 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public ModelAndView list(@ModelAttribute OrderDTO dto,HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		AccountDTO accountdto = (AccountDTO) session.getAttribute("account");
		session.setMaxInactiveInterval(60*60);
		
		if(accountdto ==null ) {
			mv.setViewName("account/login");
			
		}else {
			int userid = accountdto.getId();
			String username = accountdto.getName();
			System.out.println("username 확인!!"+ username);
			mv.addObject("username", username);
			System.out.println("userid 확인 : "+userid);
			dto.setAid(userid);
			
			try {
				List<OrderDTO> orderlist = order.findList(dto);
				mv.addObject("orderlist", orderlist);
				mv.setViewName("order/list");
			
			}catch(Exception e){
				mv.addObject("result", "주문하신 제품이 없습니다.");	
			}
			
		}
		
		
		return mv;
	}
	
	/* 주문내역 디테일 */
	
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public ModelAndView detailList(@ModelAttribute OrderDTO dto) throws Exception {
		ModelAndView mv = new ModelAndView();
		int orderid = dto.getId();
		System.out.println("orderid :" + orderid);
		OrderDetailDTO orderdetaildto = new OrderDetailDTO();
		orderdetaildto.setOid(orderid);
		List<OrderDetailDTO> orderdetaillist = order.selectall(orderdetaildto);
		
		mv.addObject("orderdetaillist", orderdetaillist);
		mv.setViewName("order/detail");
		
		return mv;
	}
	
	/* 리뷰작성 */
	
	@RequestMapping(value = "/review/add", method = RequestMethod.GET)
	public ModelAndView add(@ModelAttribute OrderDetailDTO dto) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("order/addreview");
		mv.addObject("orderdetail", dto);
		
		return mv;
	}
	@RequestMapping(value = "/review/add", method = RequestMethod.POST)
	public ModelAndView add(@ModelAttribute ReviewDTO dto,HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		HttpSession session = request.getSession();
		AccountDTO accountDTO = (AccountDTO) session.getAttribute("account");
		int userid = accountDTO.getId();
		dto.setAid(userid);
		
	    String [] rCheck = request.getParameterValues("rating");
	    dto.setRating(rCheck.length);	
		boolean result = order.add(dto);
	
		mv.setViewName("redirect:/product/detail?id="+dto.getPid());
	
		return mv;
	}
	
	
}