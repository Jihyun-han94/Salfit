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

import com.jey.webapp.cart.dto.CartDTO;
import com.jey.webapp.cart.service.CartService;

@Controller
@RequestMapping(value = "/cart")
public class CartController {
	
	@Autowired
	private CartService cart;

	
	/* 장바구니 조회 */
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String cartList(Model m, @ModelAttribute CartDTO dto) throws Exception {
		return "cart/mycart";
	}	
	
	
	/* 장바구니에 상품 담기 */
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addToCart(Model m, @ModelAttribute CartDTO dto) throws Exception {
		return "redirect:/cart";
	}
	
	/* 장바구니에서 상품 제거 -> Ajax 로도 가능함.*/
	
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String rmFromCart(Model m, @ModelAttribute CartDTO dto) throws Exception {
		return "redirect:/cart";
	}
	
}
