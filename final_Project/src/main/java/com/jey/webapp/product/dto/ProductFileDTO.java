package com.jey.webapp.product.dto;

import java.util.*;

public class ProductFileDTO {
	private int id;
	private int pid;
	private String name;
	private String path;
	private String url;
	public int getId() {
		return id;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	
}