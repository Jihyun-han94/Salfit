package com.jey.webapp.product.dto;

public class ProductSearchDTO {
	private int ptype;
	private String searchtype;
	private String search;
	
	public int getPtype() {
		return ptype;
	}
	
	public void setPtype(int ptype) {
		this.ptype = ptype;
	}
	
	public String getSearchtype() {
		return searchtype;
	}
	
	public void setSearchtype(String searchtype) {
		this.searchtype = searchtype;
	}
	
	public String getSearch() {
		return search;
	}
	
	public void setSearch(String search) {
		this.search = search;
	}
}
