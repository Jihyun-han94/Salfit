package com.jey.webapp.order.dto;

import java.sql.Date;

public class OrderDTO {
	
	private int id; //주문 번호 
	private int aid; // 주문자 식별 번호(account.id)
	private String receiver; // 수령인
	private String address; // 배송지
	private int total; //총 결제 금액
	private Date pdate; //결제 일시
	private Date ddate; //배송 예정일
	private String status; //주문 상태
	private String title;
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public Date getPdate() {
		return pdate;
	}
	public void setPdate(Date pdate) throws Exception {
		this.pdate = pdate;
	}
	public Date getDdate() {
		return ddate;
	}
	public void setDdate(Date ddate) throws Exception {
	
		this.ddate = ddate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
	
}