package com.jey.webapp.product.controller;

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
import com.jey.webapp.order.dto.ReviewDTO;
import com.jey.webapp.product.dto.ProductDTO;
import com.jey.webapp.product.dto.ProductRecommendDTO;
import com.jey.webapp.product.dto.ProductSearchDTO;
import com.jey.webapp.product.service.ProductService;


@Controller
@RequestMapping(value = "/product")
public class ProductController {
	@Autowired
	private ProductService product;

	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public ModelAndView main(@ModelAttribute ProductSearchDTO search, HttpServletRequest request, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		List<ProductDTO> productlist = null;
		List<Integer> liked = new ArrayList<Integer>();
		List<ProductDTO> likedProduct = null;
		
		session = request.getSession();
		AccountDTO account = null;
		// 로그인 사용자의 경우 -> 하트 표시 
		if(session.getAttribute("logined") != null && (boolean)session.getAttribute("logined")) {
			if(session.getAttribute("account") != null) {
				account = (AccountDTO) session.getAttribute("account");
				// 세션 + 필터로 관리자만 active 'n'인 상품 보기 가능 
				search.setAid(account.getId());  
				liked = new ArrayList<Integer>();
				likedProduct = product.getAllLikePid(account.getId());  
				for(ProductDTO lk : likedProduct) {
					liked.add(lk.getId());
				}
			}
		}
		System.out.println("dmd? "+session.getAttribute("logined"));
		if(search.getPtype() == 0 && search.getSearchtype() == null) {
			productlist = product.findAll(search);
		} else if (search.getSearch() == "") {
			productlist = product.findAll(search);
		} else {
			productlist = product.findList(search);
		}

		
		mv.setViewName("product/main");
		mv.addObject("productlist", productlist);
		mv.addObject("producttypes", product.getProductTypes());
		mv.addObject("liked", liked);
		System.out.println(liked);
		return mv;
	}
	
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public ModelAndView detail(HttpServletRequest request, @RequestParam int id) throws Exception {
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		
		ProductDTO item = product.findId(id);
		if(item.getId() != -1 && item.getActive().equals("y")) {
			List<ProductRecommendDTO> recommend = product.findSimilarList(item);
			List<ReviewDTO> reviews = product.findReviewList(item);
			mv.addObject("newline", "\n");
			mv.addObject("item", item);
			mv.addObject("recommend", recommend);
			mv.addObject("reviews", reviews);
			mv.addObject("oldListCnt", reviews.size());
			mv.setViewName("product/detail");
		} else {
			mv.setViewName("error/noitem");
		}
		return mv;
	}
	
}