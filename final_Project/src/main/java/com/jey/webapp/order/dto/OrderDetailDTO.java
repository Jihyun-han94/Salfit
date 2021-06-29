package com.jey.webapp.order.dto;

import java.util.*;

import oracle.sql.DATE;

public class OrderDetailDTO {
	
	private int id; //시퀀스
	private int oid; // = ordered.id
	private int pid; // = product.id
	private int qty; // 제품 수량
	private String status; // 주문상태 (paid,shipping,delivered, holding)
	private int price; //제품 가격
	
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getOid() {
		return oid;
	}
	public void setOid(int oid) {
		this.oid = oid;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}