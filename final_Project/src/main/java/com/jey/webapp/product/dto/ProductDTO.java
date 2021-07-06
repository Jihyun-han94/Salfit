package com.jey.webapp.product.dto;

import java.util.*;

public class ProductDTO {
	private int id;
	private int ptype;
	private String tname;
	private int aid;
	private String title;
	private int price;
	private String contents;
	private int imgid;
	private String img;
	private String imguuid;
	private String url;
	private int vcnt;
	private int gcnt;
	private int bcnt;
	private Date cdate;
	private Date udate;
	private String active;
	
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPtype() {
		return ptype;
	}
	public void setPtype(int ptype) {
		this.ptype = ptype;
	}
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	
	public int getImgid() {
		return imgid;
	}
	public void setImgid(int imgid) {
		this.imgid = imgid;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	
	public String getImguuid() {
		return imguuid;
	}
	public void setImguuid(String imguuid) {
		this.imguuid = imguuid;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getVcnt() {
		return vcnt;
	}
	public void setVcnt(int vcnt) {
		this.vcnt = vcnt;
	}
	public int getGcnt() {
		return gcnt;
	}
	public void setGcnt(int gcnt) {
		this.gcnt = gcnt;
	}
	public int getBcnt() {
		return bcnt;
	}
	public void setBcnt(int bcnt) {
		this.bcnt = bcnt;
	}
	public Date getCdate() {
		return cdate;
	}
	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}
	public Date getUdate() {
		return udate;
	}
	public void setUdate(Date udate) {
		this.udate = udate;
	}
	public String getActive() {
		return active;
	}
	public void setActive(String active) {
		if(active == null) {
			this.active = "n";
		} else if(active.equals("on") || active.equals("y")) {
			this.active = "y";
		} else {
			this.active = "n";
		}
	}
	public void setCdate(String format) {
		this.cdate = cdate;
		
	}
	public void setUdate(String format) {
		this.udate = udate;
		
	}
	
	
}
