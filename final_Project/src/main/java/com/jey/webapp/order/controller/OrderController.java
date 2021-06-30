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

import com.jey.webapp.account.dto.AccountDTO;
import com.jey.webapp.order.dto.OrderDTO;
import com.jey.webapp.order.dto.OrderDetailDTO;
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
		
		//계정 정보 확인
		AccountDTO accountdto = (AccountDTO) session.getAttribute("account");
		session.setMaxInactiveInterval(60*60); //세션 한시간 만료
		
		if(accountdto ==null ) {
			mv.setViewName("account/login");
			
		}else {
			//account.id로 ordered table 조회 (주문내역 전체)
			int userid = accountdto.getId();
			System.out.println("userid 확인 : "+userid);
			dto.setAid(userid);
			List<OrderDTO> orderlist = order.findList(dto);
			System.out.println("디버깅1"+orderlist.get(0).getAid());
			System.out.println("디버깅1"+orderlist.get(0).getTotal());
			System.out.println("pdate :"+orderlist.get(0).getPdate());	
			mv.addObject("orderlist", orderlist);
			System.out.println("디버깅2");
			OrderDetailDTO orderdetail_dto = new OrderDetailDTO();
			System.out.println("디버깅4");
			//제품이름 때문에 orderdetail 조회해야함 (ordered.id로) 
			for(OrderDTO data : orderlist) {
				orderdetail_dto.setOid(data.getId());
				System.out.println("디버깅5");
				List<OrderDetailDTO> orderdetail_arr = order.selectall(orderdetail_dto);
				System.out.println("디버깅6");
				mv.addObject("orderdetaillist", orderdetail_arr);
				
				System.out.println("디버깅7");
			
				System.out.println("디버깅8");
			}
			mv.setViewName("order/list");
		}
		
		
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