package com.jey.webapp.account.controller;


import java.awt.image.BufferedImage;
import java.io.File;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.jey.webapp.account.dto.AccountDTO;
import com.jey.webapp.account.service.AccountService;
import com.jey.webapp.product.dto.ProductDTO;

@Controller
@RequestMapping(value = "/account")
public class AccountController {
	
	@Autowired
	private AccountService account;

	/* 회원가입 */
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join() throws Exception {
		return "account/join";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String userJoin(Model m, @ModelAttribute AccountDTO dto) throws Exception {
		boolean res = account.join(dto);
		if(res) {
			m.addAttribute("dto",dto);
			return "account/joinres";
		} else {
			m.addAttribute("error","회원가입 실패!");
			return "account/joinres";
		}
	}
	
	/* 로그인 */
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() throws Exception {
		return "account/login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String userLogin(Model m, @ModelAttribute AccountDTO dto, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String forward = "";
		dto = account.login(dto);
		if(dto != null && dto.getId() > 0) {
			HttpSession session = request.getSession();
			// session.setMaxInactiveInterval(60*60);
			
			session.setAttribute("account", dto);
			session.setAttribute("logined", true);
			m.addAttribute("dto",dto);

			if(dto.getAtype().equals("a")) {
				forward = "redirect:/admin/product";
			} else {
				forward = "redirect:/";
			}
		} else {
			m.addAttribute("error", "아이디 또는 비밀번호를 다시 입력하세요.");
			forward = "redirect:/account/login";
		}
		return forward;
	}
	
	/* 로그아웃 */
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		session.invalidate();
		System.out.println("로그아웃 되었습니다.");
		return "redirect:/";
	}
	
	/* 회원정보 수정 */
	
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public ModelAndView modify(HttpServletRequest request, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("account/update");
		session = request.getSession();
		AccountDTO dto = (AccountDTO) session.getAttribute("account");
		System.out.println(dto.getId());
		mv.addObject("account", dto);
		return mv;
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String modify(HttpServletRequest request, Model m, HttpSession session) throws Exception {
		AccountDTO dto = (AccountDTO) session.getAttribute("account");
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String phone = request.getParameter("phone");
		dto.setName(name);
		dto.setPassword(password);
		dto.setPhone(phone);
		System.out.println(dto.getName() + dto.getPassword() + dto.getPhone());
		m.addAttribute("account", account.updateProfile(dto));
		return "redirect:/";
	}
	
	/* 프로필 사진 추가 */
	@RequestMapping(value = "/profile_update", method = RequestMethod.POST)
	public String profile_modify(@RequestParam MultipartFile file,
			HttpServletRequest req) {
		// 1. 사용자가 업로드한 이미지를 추출한다. --> file 자체로 추출 함 (하나기 때문)
		
		// 2. 추출한 이미지를 특정 경로(설정)에 이미지파일로 저장한다.
		String root = req.getServletContext().getRealPath("/");
		FileUpload fileupload = new FileUpload(root, "/resources/file/");
		// 3. 저장된 이미지를 불러온다.
		// 4. 불러온 이미지의 크기를 조정한다.
		// 5. 조정된 이미지를 저장한다.
		// 6. 이미지 저장된 경로를 DB에 저장한다.
//		String srcImg = "";
//		BufferedImage destImg = Scalr.resize(srcImg, Scalr.Method.AUTOMATIC, 150, 150, 150);
		return "redirect:/update";
	}
	
	/* 회원탈퇴 */
	@RequestMapping(value = "/signout", method = RequestMethod.GET)
	public String signout(HttpServletRequest request, Model m, @ModelAttribute AccountDTO dto) throws Exception {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/product";
	}
	
}
