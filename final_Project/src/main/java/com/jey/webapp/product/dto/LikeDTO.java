package com.jey.webapp.product.dto;

public class LikeDTO {
	private int id;
	private int rnum;
	private int pid;
	private int aid;
	private String cancel;
	private int gcnt;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public String getCancel() {
		return cancel;
	}
	public void setCancel(String cancel) {
		this.cancel = cancel;
	}
	public int getGcnt() {
		return gcnt;
	}
	public void setGcnt(int gcnt) {
		this.gcnt = gcnt;
	}
	
	
}
