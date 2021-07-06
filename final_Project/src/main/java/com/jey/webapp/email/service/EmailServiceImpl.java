package com.jey.webapp.email.service;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.jey.webapp.email.dto.EmailDTO;

@Service
public class EmailServiceImpl implements EmailService {
	@Autowired
    JavaMailSender mailSender;

	@Override
	public void sendMail(EmailDTO dto) throws Exception {
		// 이메일 객체
        MimeMessage msg = mailSender.createMimeMessage();
        String receiveMail = "salfit.contact@gmail.com";
        
        // 받는 사람 설정 
        msg.addRecipient(RecipientType.TO, new InternetAddress(receiveMail));
        
        // 보내는 사람(이메일주소+이름) 설정
        msg.addFrom(new InternetAddress[] { new InternetAddress(dto.getSenderMail(), dto.getSenderName(), "utf-8") });
//        msg.setFrom(new InternetAddress(dto.getSenderMail()));
        System.out.println("이메일 주소 : " + dto.getSenderMail());
        // 이메일 제목
        msg.setSubject("[문의 메일드립니다.]", "utf-8");
        // 이메일 본문
        StringBuffer buffer = new StringBuffer();
        buffer.append("문의자 : " + dto.getSenderName() + "\r\n");
        buffer.append("답변할 메일 주소 : " + dto.getSenderMail() + "\r\n");
        buffer.append("내용 : " + dto.getMessage());
        msg.setText(buffer.toString(), "utf-8");

        // 이메일 보내기
        mailSender.send(msg);
	}
}