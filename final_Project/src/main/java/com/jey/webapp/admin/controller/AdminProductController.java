package com.jey.webapp.admin.controller;


import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.jey.webapp.account.dto.AccountDTO;
import com.jey.webapp.admin.dto.PtypeDTO;
import com.jey.webapp.admin.service.AdminService;
import com.jey.webapp.alert.AlertHandler;
import com.jey.webapp.order.dto.ReviewDTO;
import com.jey.webapp.product.dto.ProductDTO;
import com.jey.webapp.product.dto.ProductFileDTO;
import com.jey.webapp.product.dto.ProductSearchDTO;
import com.jey.webapp.product.dto.ProductTypeDTO;
import com.jey.webapp.product.service.ProductService;

@Controller
@RequestMapping(value = "/admin/product")
public class AdminProductController {
	
	@Autowired
	private ProductService product;
	
	@Autowired
	private AdminService order;

	/* 상품 조회(조회수, 수정, 삭제, 리뷰에 대댓글 버튼 ) */
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public ModelAndView list(@ModelAttribute ProductSearchDTO search, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		session.getAttribute("account");
		
		ModelAndView mv = new ModelAndView();
		
		List<ProductDTO> productlist = null;
		
		// 세션 + 필터로 관리자만 해당 컨트롤에 접속 가능 
		search.setAid(1);
		
		if(search.getPtype() != 0 || search.getSearchtype() != null) {
			productlist = product.findList(search);
		} else {
			productlist = product.findAll(search);
		}
		
		mv.setViewName("admin/product/main");
		mv.addObject("productlist", productlist);
		mv.addObject("producttypes", product.getProductTypes());
		
		return mv;
	}
	
	
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public ModelAndView detail(HttpServletRequest request, @ModelAttribute ProductDTO item) throws Exception {
		ModelAndView mv = new ModelAndView("product/detail");
		
		HttpSession session = request.getSession();
		
		
		item = product.findId(item.getId());
		
		if(item.getId() != -1 ) {
			// 리뷰갯수 추가 
			List<ReviewDTO> reviews = product.findReviewList(item);
			
			mv.addObject("newline", "\n");
			mv.addObject("item", item);
			mv.addObject("oldListCnt", reviews.size());
		
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
		mv.addObject("producttypes", product.getProductTypes());
		return mv;
	}
	
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String write(Model m, @ModelAttribute ProductDTO dto,
			@RequestParam MultipartFile file,
			HttpServletRequest req) throws Exception {
		
		String forward = "admin/product/add";
		String origin_name = "";
		String change_name = "";
		String file_ext = "";
		
		ArrayList<String> permit_ext = new ArrayList<String>();
		permit_ext.add("jpg");	permit_ext.add("png"); permit_ext.add("gif");	permit_ext.add("tif");
		
		if(!file.isEmpty()) {
			if(file.getSize() <= 10 * 1024 * 1024) {
				UUID uuid = UUID.randomUUID();
				
				origin_name = file.getOriginalFilename();
//				origin_name = StringUtils.cleanPath(new String(file.getOriginalFilename().getBytes("ISO-8859-1"), StandardCharsets.UTF_8));
//				origin_name = URLEncoder.encode(file.getOriginalFilename(), "euc-kr");
				change_name = uuid.toString() + "_" + origin_name;
				file_ext = FilenameUtils.getExtension(file.getOriginalFilename());
				
				
				System.out.println("원본 파일명 : " + origin_name);
				System.out.println("변경된 파일명 : " + change_name);
				System.out.println("확장자 : " + file_ext);
				System.out.println("파일 크기(바이트) : " + file.getSize());

				if(permit_ext.contains(file_ext)) {
//					String root_path = req.getServletContext().getRealPath("/");
					File save_path = new File(req.getServletContext().getRealPath("/") + "/resources/upload/product/");
					System.out.println(save_path);
					if(!save_path.exists()) {
						Files.createDirectories(save_path.toPath());
					}
//							file.transferTo(new File(save_path + "/" + origin_name));
					File path = new File(save_path + "/" + change_name);
					file.transferTo(path);
					dto.setImg(origin_name);
					dto.setImguuid(change_name);
					dto.setUrl("/resources/upload/product/" + change_name);
				} else {
					System.out.println("해당 확장자는 업로드 할 수 없습니다.");
					forward = "error/default";
				}
			} else {
				System.out.println("업로드 파일의 크기가 큽니다.");
				forward = "error/default";
			}
		} else {
			//default 이미지 
			dto.setImg("default.png");
			dto.setImguuid("default.png");
			dto.setUrl("/resources/upload/product/default.png");
		}
		
		if(dto.getActive() == null) {
			dto.setActive(dto.getActive());
		}
		boolean res = product.add(dto);
		
		if(res) {
			m.addAttribute("result", "registerOK");
			forward = "redirect:/admin/product";
		} else {
			m.addAttribute("data", dto);
			forward = "redirect:/admin/product/add";
		}
		
		return forward;
	}
	
	/* 상품 수정 */
	
	
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public ModelAndView modify(int id) throws Exception {
		ModelAndView mv = new ModelAndView("admin/product/update");
		mv.addObject("ptypes", product.getProductTypes());
		mv.addObject("item", product.findId(id));
		return mv;
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public ModelAndView modify(Model m, @ModelAttribute ProductDTO dto,
			@RequestParam MultipartFile file,
			HttpServletRequest req) throws Exception {
		ModelAndView mv = new ModelAndView("admin/product/update");
		String origin_name = "";
		String change_name = "";
		String file_ext = "";
		
		ArrayList<String> permit_ext = new ArrayList<String>();
		permit_ext.add("jpg");	permit_ext.add("png"); permit_ext.add("gif");	permit_ext.add("tif");
		
		if(!file.isEmpty()) {
			if(file.getSize() <= 10 * 1024 * 1024) {
				UUID uuid = UUID.randomUUID();
				
				origin_name = file.getOriginalFilename();
//				origin_name = StringUtils.cleanPath(new String(file.getOriginalFilename().getBytes("ISO-8859-1"), StandardCharsets.UTF_8));
//				origin_name = new String(file.getOriginalFilename().getBytes("8859_1"),"utf-8");

				System.out.println("origin name : " + origin_name);
				change_name = uuid.toString() + "_" + origin_name;
				file_ext = FilenameUtils.getExtension(file.getOriginalFilename());
				
				System.out.println("원본 파일명 : " + origin_name);
				System.out.println("변경된 파일명 : " + change_name);
				System.out.println("확장자 : " + file_ext);
				System.out.println("파일 크기(바이트) : " + file.getSize());

				if(permit_ext.contains(file_ext)) {
//					String root_path = req.getServletContext().getRealPath("/");
					File save_path = new File(req.getServletContext().getRealPath("/") + "/resources/upload/product/");
					System.out.println(save_path);
					if(!save_path.exists()) {
						Files.createDirectories(save_path.toPath());
					}
//							file.transferTo(new File(save_path + "/" + origin_name));
					File path = new File(save_path + "/" + change_name);
					file.transferTo(path);
					dto.setImg(origin_name);
					dto.setImguuid(change_name);
					dto.setUrl("/resources/upload/product/" + change_name);
					System.out.println(path);
				} else {
					System.out.println("해당 확장자는 업로드 할 수 없습니다.");
					mv.setViewName("error/default"); 
				}
			} else {
				System.out.println("업로드 파일의 크기가 큽니다.");
				mv.setViewName("error/default"); 
			}
		} else {
			dto.setImg(product.findId(dto.getId()).getImg());
			dto.setImguuid(product.findId(dto.getId()).getImguuid());
			dto.setUrl(product.findId(dto.getId()).getUrl());
		}
		
		if(dto.getActive() == null) {
			dto.setActive(dto.getActive());
		}

		boolean res = product.update(dto);
		
		if(res) {
			mv.addObject("newline", "\n\r");
			mv.addObject("ptypes", product.getProductTypes());
			mv.addObject("item", dto);
			m.addAttribute("result", "updateOK");
			mv.setViewName("redirect:/admin/product/detail?id=" + dto.getId());
		} else {
			m.addAttribute("ptypes", product.getProductTypes());
			m.addAttribute("item", dto);
			mv.setViewName("redirect:/admin/product/update?id=" + dto.getId());
		}
		
		return mv;
	}
	
	/* 상품 삭제 */
	
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String deleteProduct(Model m, @ModelAttribute ProductDTO dto) throws Exception {
		String forward = "";
				
				
		if(order.findOrderedProduct(dto)) {
			m.addAttribute("result", "removeFail");
			forward = "redirect:/admin/product";
		} else {
			boolean res = product.remove(dto);
			if(res) {
				m.addAttribute("result", "removeOK");
				forward = "redirect:/admin/product";
			} else {
				forward = "error/default";
			}
		}
		return forward;
	}
	
	
	/* 카테고리 추가 */
	@RequestMapping(value = "/ptype/add", method = RequestMethod.POST)
	public String newCategory(Model m, @ModelAttribute ProductTypeDTO dto,
			@RequestParam MultipartFile file,
			HttpServletRequest req) throws Exception {
		
		String forward = "admin/product";
		String origin_name = "";
		String change_name = "";
		String file_ext = "";
		
		ArrayList<String> permit_ext = new ArrayList<String>();
		permit_ext.add("jpg");	permit_ext.add("png"); permit_ext.add("gif");	permit_ext.add("tif");
		
		if(!file.isEmpty()) {
			if(file.getSize() <= 10 * 1024 * 1024) {
				UUID uuid = UUID.randomUUID();
				
				origin_name = file.getOriginalFilename();
				change_name = uuid.toString() + "_" + origin_name;
				file_ext = FilenameUtils.getExtension(file.getOriginalFilename());
				
				if(permit_ext.contains(file_ext)) {
					File save_path = new File(req.getServletContext().getRealPath("/") + "/resources/upload/category/");
					if(!save_path.exists()) {
						Files.createDirectories(save_path.toPath());
					}
					file.transferTo(new File(save_path + "/" + change_name));
					dto.setImgurl("/resources/upload/category/" + change_name);
				} else {
					System.out.println("해당 확장자는 업로드 할 수 없습니다.");
					forward = "error/default";
				}
			} else {
				System.out.println("업로드 파일의 크기가 큽니다.");
				forward = "error/default";
			}
		} else {
			dto.setImgurl("/resources/upload/category/default.png");
		}

		boolean res = product.addPtype(dto);
		if(res) {
			m.addAttribute("result", "addOK");
			forward = "redirect:/admin/product";
		} else {
			m.addAttribute("result", "addFail");
			forward = "redirect:/admin/product";
		}
		
		return forward;
	}
	
	/* 카테고리 삭제 */
	
	
	@RequestMapping(value = "/ptype/delete", method = RequestMethod.GET)
	public String deletePtype(Model m, @ModelAttribute ProductTypeDTO dto) throws Exception {
		String forward = "";
		boolean res = product.deletePtype(dto);
		if(res) {
			m.addAttribute("result", "deleteOK");
			forward = "redirect:/admin/product";
		} else {
			forward = "error/default";
		}
		
		return forward;
	}
	
}