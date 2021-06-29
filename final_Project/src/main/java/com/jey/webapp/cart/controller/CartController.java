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

import com.jey.webapp.account.dto.AccountDTO;
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
	
//	
//	/* 장바구니에 상품 담기 */
//	
//	@RequestMapping(value = "/add", method = RequestMethod.POST)
//	public String addToCart(Model m, @ModelAttribute CartDTO dto, HttpSession session) throws Exception {
//		
//		//로그인 여부 체크하기 위해 세션에 저장된 아이디 확인
//		String id = (String)session.getAttribute("id");
//		int aid = Integer.parseInt(id);
//		
//		if(id == null) {
//			return "redirect:/account/login";
//		}
//			dto.setAid(aid);
//			cart.add(dto); //cart 테이블에 저장됨
//		
//			return "redirect:/cart";
//	}
//	
	/* 장바구니에서 상품 제거 -> Ajax 로도 가능함.*/
	
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String rmFromCart(Model m, @ModelAttribute CartDTO dto) throws Exception {
		return "redirect:/cart";
	}
	
}
