package com.jey.webapp.ajax.controller;


import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jey.webapp.product.service.ProductService;


@Controller
@RequestMapping("/ajax/product")
public class AjaxProductController {
	
	@Autowired
	private ProductService product;
	
	/* 상품 카테고리 선택 후 포커스 이동 */
	
	/* 상품 좋아요 */
	
	
	/* 리뷰 더보기 */

	
	
}
