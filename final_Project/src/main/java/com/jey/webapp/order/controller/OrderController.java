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

import com.jey.webapp.order.dto.OrderDTO;
import com.jey.webapp.order.dto.OrderDetailDTO;
import com.jey.webapp.order.service.OrderService;


@Controller
@RequestMapping(value = "/order")
public class OrderController {
	@Autowired
	private OrderService order;

	/* 주문 내역 전체 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public ModelAndView list(@ModelAttribute OrderDTO dto) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("order/list");
		
		return mv;
	}
	
	/* 주문내역 디테일 */
	
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public ModelAndView detailList(@ModelAttribute OrderDTO dto) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("order/detail");
		
		return mv;
	}
	
	/* 리뷰작성 */
	
	@RequestMapping(value = "/review/add", method = RequestMethod.GET)
	public ModelAndView add(@ModelAttribute OrderDetailDTO dto) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("order/addreview");
		
		return mv;
	}
	
	
	
}