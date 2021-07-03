package com.jey.webapp.email.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jey.webapp.email.dto.EmailDTO;
import com.jey.webapp.email.service.EmailService;

@Controller
@RequestMapping(value = "/email")
public class EmailController {

	@Autowired
	EmailService emailService;
	
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String emailWrite() throws Exception {
		return "email/write";
	}
	
	@RequestMapping(value = "/send", method = RequestMethod.POST)
	public String emailSend(@ModelAttribute EmailDTO dto, Model m) throws Exception {
		emailService.sendMail(dto);		
		m.addAttribute("message", "메일 발송에 성공하였습니다!");
		System.out.println("메일 발송 성공!");
		return "email/write";
	}
}