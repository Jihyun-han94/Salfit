package com.jey.webapp.product.dto;

public class ProductRecommendDTO {
	private int id;
	private int ptype;
	private String title;
	private int price;
	private int imgid;
	private String img;
	private String imgname;
	private String url;
	private int gcnt;
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
	public String getImgname() {
		return imgname;
	}
	public void setImgname(String imgname) {
		this.imgname = imgname;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getGcnt() {
		return gcnt;
	}
	public void setGcnt(int gcnt) {
		this.gcnt = gcnt;
	}
	public String getActive() {
		return active;
	}
	public void setActive(String active) {
		this.active = active;
	}
	
}
