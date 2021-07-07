package com.jey.webapp.order.dto;

import java.util.*;

public class ReviewDTO {
	private int id;
	private int pid;
	private String pname;
	private int aid;
	private String aname;
	private String contents;
	private int rating;
	private Date cdate;
	private String cdate2;
	private String profile_img; //account 프로필 이미지

	
	
	public String getProfile_img() {
		
		return profile_img;
	}
	public void setProfile_img(String profile_img) {
		System.out.println("경로 확인!!"+profile_img);
		this.profile_img = profile_img;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getAid() {
		return aid;
	}
	public String getAname() {
		return aname;
	}
	public void setAname(String aname) {
		this.aname = aname;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public Date getCdate() {
		return cdate;
	}
	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}
	public String getCdate2() {
		return cdate2;
	}
	public void setCdate2(String cdate2) {
		this.cdate2 = cdate2;
	}
	
	
}