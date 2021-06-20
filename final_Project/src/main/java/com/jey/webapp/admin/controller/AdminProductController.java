package com.jey.webapp.admin.controller;


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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.jey.webapp.product.dto.ProductDTO;
import com.jey.webapp.product.service.ProductService;

@Controller
@RequestMapping(value = "/admin/product")
public class AdminProductController {
	
	@Autowired
	private ProductService product;

	/* 상품 조회(조회수, 수정, 삭제, 리뷰에 대댓글 버튼 ) */
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String list() throws Exception {
		return "admin/product/main";
	}
	
	
	
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public ModelAndView detail(@RequestParam int id) throws Exception {
		ModelAndView mv = new ModelAndView("product/detail");
		mv.addObject("item", product.findId(id));
		return mv;
	}
	
	@RequestMapping(value = "/detail", method = RequestMethod.POST)
	public ModelAndView detail(HttpServletRequest request, @ModelAttribute ProductDTO item) throws Exception {
		ModelAndView mv = new ModelAndView("product/detail");
		
		HttpSession session = request.getSession();
		
		item = product.findId(item.getId());
		
		if(item.getId() != -1 || item.getActive().equals("y")) {
			
			mv.addObject("newline", "\n");
			mv.addObject("item", item);
		
			mv.setViewName("admin/product/detail");
		} else {
			mv.setViewName("/error/noitem");
		}
		
		return mv;
		
	}
	
	/* 상품 등록 */
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public ModelAndView write() throws Exception {
		ModelAndView mv = new ModelAndView("admin/product/add");
		mv.addObject("boardtypes", product.getProductTypes());
		return mv;
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String write(Model m, @ModelAttribute ProductDTO dto) throws Exception {
		String forward = "";
		
		boolean res = product.add(dto);
		
		if(res) {
			forward = "redirect:/admin/product/detail?id=" + dto.getId();
		} else {
			m.addAttribute("data", dto);
			forward = "admin/product/add";
		}
		
		return forward;
	}
	
	/* 상품 수정 */
	
	@RequestMapping(value = "/product/edit", method = RequestMethod.GET)
	public String edit() throws Exception {
		return "admin/product/edit";
	}
	
	@RequestMapping(value = "/product/edit", method = RequestMethod.POST)
	public String edit(Model m, @ModelAttribute ProductDTO dto) throws Exception {
		return "redirect:main";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public ModelAndView modify(int id) throws Exception {
		ModelAndView mv = new ModelAndView("product/update");
		mv.addObject("ptypes", product.getProductTypes());
		mv.addObject("item", product.findId(id));
		return mv;
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String modify(Model m, @ModelAttribute ProductDTO dto) throws Exception {
		String forward = "";
		
		
		boolean res = product.update(dto);
		
		if(res) {
			forward = "redirect:/admin/product/detail?id=" + dto.getId();
		} else {
			m.addAttribute("ptypes", product.getProductTypes());
			m.addAttribute("item", dto);
			forward = "admin/product/edit";
		}
		
		return forward;
	}
	
	/* 상품 삭제 */
	
	
	@RequestMapping(value = "/product/delete", method = RequestMethod.POST)
	public String userJoin(Model m, @ModelAttribute ProductDTO dto) throws Exception {
		return "redirect:main";
	}
	
}
