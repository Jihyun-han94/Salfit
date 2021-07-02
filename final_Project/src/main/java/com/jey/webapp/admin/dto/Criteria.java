package com.jey.webapp.admin.dto;

import org.springframework.web.util.UriComponentsBuilder;

public class Criteria {
	private int id;
	private int page;
	private int perPageNum;
	private String status;
	
	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
		this.status="";
	}
	
	//pageStart를 반환
	public int getPageStart() {
		return (this.page - 1)*perPageNum;
	}
	
	public String makeQuery() {
		return UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("perPageNum", this.perPageNum)
				.queryParam("status", this.status)
				.build().encode().toString();
	}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}

	public int getPage() {
		return page;
	}
	
	public void setPage(int page) {
		if(page <= 0) {
			this.page = 1;
		}else {
			this.page = page;
		}
	}
	public int getPerPageNum() {
		return perPageNum;
	}
	public void setPerPageNum(int perPageNum) {
		if(perPageNum <=0 || perPageNum > 100) {
			this.perPageNum = 10;
		}else {
			this.perPageNum = perPageNum;
		}
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + ", status=" + status + "]";
	}
}
