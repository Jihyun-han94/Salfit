package com.jey.webapp.email.service;

import com.jey.webapp.email.dto.EmailDTO;

public interface EmailService {
	public void sendMail(EmailDTO dto) throws Exception;
}