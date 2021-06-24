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
	public ModelAndView main(@ModelAttribute ProductSearchDTO search) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		List<ProductDTO> productlist = null;
		
		// 세션 + 필터로 관리자만 active 'n'인 상품 보기 가능 
		search.setAid(0); // 추후 개인 아이디로 바꿀예정 

		if(search.getPtype() == 0 && search.getSearchtype() == null) {
			productlist = product.findAll(search);
		} else if (search.getSearch() == "") {
			productlist = product.findAll(search);
		} else {
			productlist = product.findList(search);
		}
		
		List<Integer> liked = new ArrayList<Integer>();
		List<ProductDTO> likedProduct = product.getAllLikePid(1); // session user Id 값 
		System.out.println(likedProduct);
		for(ProductDTO lk : likedProduct) {
			System.out.println(lk.getId());
			liked.add(lk.getId());
		}
		
		mv.setViewName("product/main");
		mv.addObject("productlist", productlist);
		mv.addObject("producttypes", product.getProductTypes());
		mv.addObject("liked", liked);
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