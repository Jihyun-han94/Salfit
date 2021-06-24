package com.jey.webapp.product.dto;

public class ReviewSearchDTO {

	private int startIndex;
	private int endIndex;
	private int pid;
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
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getOldListCnt() {
		return oldListCnt;
	}
	public void setOldListCnt(int oldListCnt) {
		this.oldListCnt = oldListCnt;
	}
}
