package com.jey.webapp.product.dto;

public class ProductSearchDTO {
	private int ptype;
	private int aid;
	private String searchtype;
	private String search;
	private int startIndex;
	private int endIndex;
	private int oldListCnt;
	public int getStartIndex() {
		return startIndex;
	}
	public void setStartIndex(int startIndex) {
		this.startIndex = startIndex;
	}
	public int getEndIndex() {
		return endIndex;
	}
	public void setEndIndex(int endIndex) {
		this.endIndex = endIndex;
	}
	public int getOldListCnt() {
		return oldListCnt;
	}
	public void setOldListCnt(int oldListCnt) {
		this.oldListCnt = oldListCnt;
	}
	
	public int getPtype() {
		return ptype;
	}
	
	public void setPtype(int ptype) {
		this.ptype = ptype;
	}
	
	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
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
