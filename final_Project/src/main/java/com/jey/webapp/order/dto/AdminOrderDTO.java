package com.jey.webapp.order.dto;

import oracle.sql.DATE;

public class AdminOrderDTO {
	private int id;
	private int aid;
	private String reciever;
	private int phone;
	private String address;
	private String paytype;
	private int total;
	private DATE pdate;
	private DATE ddate;
	private String status;
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
	public String getReciever() {
		return reciever;
	}
	public void setReciever(String reciever) {
		this.reciever = reciever;
	}
	public int getPhone() {
		return phone;
	}
	public void setPhone(int phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPaytype() {
		return paytype;
	}
	public void setPaytype(String paytype) {
		this.paytype = paytype;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public DATE getPdate() {
		return pdate;
	}
	public void setPdate(DATE pdate) {
		this.pdate = pdate;
	}
	public DATE getDdate() {
		return ddate;
	}
	public void setDdate(DATE ddate) {
		this.ddate = ddate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
