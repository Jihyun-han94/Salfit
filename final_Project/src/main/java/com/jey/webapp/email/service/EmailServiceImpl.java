package com.jey.webapp.email.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jey.webapp.email.repository.EmailRepository;

@Service
public class EmailServiceImpl implements EmailService {
	@Autowired
	EmailRepository dao;
	
}
