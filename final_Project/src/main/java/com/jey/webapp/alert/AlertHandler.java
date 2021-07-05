package com.jey.webapp.alert;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component(value = "alertHandler")
public class AlertHandler extends TextWebSocketHandler {
	
	@Autowired
	private SqlSession sqlSession;

	
	public List<WebSocketSession> sockList = new ArrayList<WebSocketSession>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 웹소켓 연결이 완료되었을 때 자동으로 동작.
		sockList.add(session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 웹소켓을 통해 메시지 전송이 되었을 때 자동으로 동작

	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// 웹소켓 연결이 종료되었을 때 자동으로 동작.
		sockList.remove(session);
	}
}