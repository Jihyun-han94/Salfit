package com.jey.web.app.kakaopay.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/pay")
public class KakaoPayController {

	@RequestMapping(value="")
	public String payment() throws Exception {
		String forward  = "kakaopay/payment";
		return forward;
	}
}
