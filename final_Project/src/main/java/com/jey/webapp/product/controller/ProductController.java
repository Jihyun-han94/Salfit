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
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.jey.webapp.account.dto.AccountDTO;
import com.jey.webapp.alert.AlertHandler;
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
	public ModelAndView scroll( @ModelAttribute ProductSearchDTO search, HttpServletRequest request, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("product/pagingmain");
		
		List<ProductDTO> productlist = null;
		List<Integer> liked = new ArrayList<Integer>();
		List<ProductDTO> likedProduct = null;
		
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
		if(search.getPtype() != 0 && search.getSearchtype() != null) {
			productlist = product.findList(search);
		} else {
			productlist = product.findAll(search);
		}
		System.out.println("product size : "+productlist.size());
		mv.addObject("productlist", productlist);
		mv.addObject("producttypes", product.getProductTypes());
		mv.addObject("liked", liked);
		mv.addObject("oldListCnt", productlist.size());
		
		return mv;
	}
	
	
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public ModelAndView detail(HttpServletRequest request, @RequestParam int id, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		session = request.getSession();
		AccountDTO account = null;
		account = (AccountDTO) session.getAttribute("account");
		
		// --조회수(중복 제거)--
		HashMap<String, String> hashmap = (HashMap) session.getAttribute("viewCnt");
		
		if(hashmap == null) {
			hashmap = new HashMap<String, String>();
		}
		
		if(hashmap.get(Integer.toString(id)) == null) {
			hashmap.put(Integer.toString(id), "true");
			session.setAttribute("viewCnt", hashmap);
			
			product.incview(id);
		}
		
		ProductDTO item = product.findId(id);
		if(item.getId() != -1 && item.getActive().equals("y")) {
			List<ProductRecommendDTO> recommend = product.findSimilarList(item);
			List<ReviewDTO> reviews = product.findReviewList(item);
			
			if(account == null) {
				mv.addObject("logined", false);	
			} else {
				mv.addObject("account", account);
			}
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