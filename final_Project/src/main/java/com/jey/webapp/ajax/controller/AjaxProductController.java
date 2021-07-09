package com.jey.webapp.ajax.controller;


import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jey.webapp.order.dto.ReviewDTO;
import com.jey.webapp.product.dto.LikeDTO;
import com.jey.webapp.product.dto.ProductDTO;
import com.jey.webapp.product.dto.ProductSearchDTO;
import com.jey.webapp.product.dto.ReviewSearchDTO;
import com.jey.webapp.product.service.ProductService;


@Controller
@RequestMapping("/ajax/product")
public class AjaxProductController {
	
	@Autowired
	private ProductService product;
	
	/* 상품 좋아요 */
	
	@RequestMapping(value = "/like", produces = "application/text;charset=UTF-8", method=RequestMethod.POST)
	@ResponseBody
	public void like(@ModelAttribute LikeDTO like, HttpServletResponse resp) throws Exception {
		PrintWriter out = resp.getWriter();
		boolean res = false;
		if(like.getCancel().equals("true") ) {
			if(product.checkLikeExist(like)) {
				res = product.dislike(like);
			}
			like.setCancel("false");
		} else {
			if(!product.checkLikeExist(like)) {
				res = product.like(like);
			}
			like.setCancel("true");
		}
		ProductDTO dto = product.findId(like.getPid());
		int gcnt = dto.getGcnt();
		JSONObject json = new JSONObject();	
		json.put("res", res);
		json.put("gcnt", gcnt);
		json.put("cancel", like.getCancel());
		out.print(json.toJSONString());
		
	}
	/* 리뷰 더보기 */
	
	@RequestMapping(value = "/moreReviews", produces = "application/text;charset=UTF-8", method=RequestMethod.POST)
	@ResponseBody
	public String searchMoreNotify(@ModelAttribute ReviewSearchDTO search, HttpServletResponse resp) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd, a hh:mm:ss");
		// startIndex ~ endIndex 범위에 해당하는 list 조회 
		List<ReviewDTO> addList = product.searchOldReviewList(search);
		for(ReviewDTO dto : addList) {	// 날짜 포맷 변경
			dto.setCdate2(sdf.format(dto.getCdate()));
		}
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(addList);
		return jsonStr;
		
	}

	
	/* 상품 더보기 */
	
	@RequestMapping(value = "/moreProducts", produces = "application/text;charset=UTF-8", method=RequestMethod.GET)
	@ResponseBody
	public String searchMoreProducts(@ModelAttribute ProductSearchDTO search, HttpServletResponse resp) throws Exception {
		List<ProductDTO> productlist = product.searchOldProductList(search);
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(productlist);
		return jsonStr;
		
	}
	
	
}
