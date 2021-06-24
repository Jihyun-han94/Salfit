package com.jey.webapp.account.controller;


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

import com.jey.webapp.account.dto.AccountDTO;
import com.jey.webapp.account.service.AccountService;

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
			forward = "redirect:/";
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
	public String update(HttpServletRequest request, Model m, @ModelAttribute AccountDTO dto) throws Exception {
		HttpSession session = request.getSession();
		session.invalidate();
		return "account/update";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String userUpdate(HttpServletRequest request, Model m, @ModelAttribute AccountDTO dto) throws Exception {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/account/updateres";
	}
	
	
	/* 회원탈퇴 */
	@RequestMapping(value = "/signout", method = RequestMethod.GET)
	public String signout(HttpServletRequest request, Model m, @ModelAttribute AccountDTO dto) throws Exception {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/product";
	}
	
}
