package com.jey.webapp.admin.dto;

public class SummaryDTO {
	private String month;
	private int numOfOrders;
	private int revenue;
	private int numOfProducts;
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public int getNumOfOrders() {
		return numOfOrders;
	}
	public void setNumOfOrders(int numOfOrders) {
		this.numOfOrders = numOfOrders;
	}
	public int getRevenue() {
		return revenue;
	}
	public void setRevenue(int revenue) {
		this.revenue = revenue;
	}
	public int getNumOfProducts() {
		return numOfProducts;
	}
	public void setNumOfProducts(int numOfProducts) {
		this.numOfProducts = numOfProducts;
	}

}
