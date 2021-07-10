package com.jey.webapp.cart.controller;


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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.jey.webapp.account.dto.AccountDTO;
import com.jey.webapp.alert.AlertHandler;
import com.jey.webapp.cart.dto.CartDTO;
import com.jey.webapp.cart.service.CartService;

@Controller
@RequestMapping(value = "/cart")
public class CartController {
	
	@Autowired
	private CartService cart;
	
	/* 장바구니 조회 */
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String cartList(Model m, @ModelAttribute CartDTO dto,HttpServletRequest request) throws Exception {
		
		String forward = "";
		HttpSession session = request.getSession();
		AccountDTO accountDTO = (AccountDTO) session.getAttribute("account");
		int userid = accountDTO.getId();
		System.out.println("userid 확인 :" + userid);
		
//		if(accountDTO == null) {
//			forward = "redirect:/account/login";
//		}else {
//			forward = "cart/mycart";
//			dto.setAid(userid);
//			List<CartDTO> cartlist = cart.findAll(dto);
//			m.addAttribute("cartlist",cartlist);			
//		}
//	
		dto.setAid(userid);
		List<CartDTO> cartlist = cart.findAll(dto);
		
		int sumMoney = cart.sumMoney(dto);
		int totalMoney = 0;
		int delfee = 0; //배송비
		
		if(sumMoney>=30000) {
			delfee = 0;
			totalMoney = sumMoney;
			m.addAttribute("totalMoney",totalMoney);
			m.addAttribute("delfee",delfee);
			
		}else {
			delfee = 3000;
			totalMoney = sumMoney + delfee;
			m.addAttribute("totalMoney",totalMoney);
			m.addAttribute("delfee",delfee);
		}
		
		System.out.println("sumMoney :" +sumMoney);
		m.addAttribute("cartlist",cartlist);
		m.addAttribute("sumMoney",sumMoney);
		//m.addAttribute("totalMoney", totalMoney);
		
		return "cart/mycart";
	}	
	
}