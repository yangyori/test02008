package com.market.dto;

public class OrderDetailDTO {
	private int oddtNum;
	private String userID;
	private int pCode;
	private int cnt;
	private int orderNum;
	
	private String psubject;
	private String subcategory;
	private String pimg;
	private int price;
	
	
	
	public int getOddtNum() {
		return oddtNum;
	}
	public void setOddtNum(int oddtNum) {
		this.oddtNum = oddtNum;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getpCode() {
		return pCode;
	}
	public void setpCode(int pCode) {
		this.pCode = pCode;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
	}
	
	public String getPsubject() {
		return psubject;
	}
	public void setPsubject(String psubject) {
		this.psubject = psubject;
	}
	public String getSubcategory() {
		return subcategory;
	}
	public void setSubcategory(String subcategory) {
		this.subcategory = subcategory;
	}
	public String getPimg() {
		return pimg;
	}
	public void setPimg(String pimg) {
		this.pimg = pimg;
	}
	
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}


	
	
	
	
}
