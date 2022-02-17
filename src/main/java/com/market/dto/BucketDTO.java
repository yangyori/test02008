package com.market.dto;

public class BucketDTO {
	private int bkNum;
	private String userID;
	private int pCode;
	private int orderCnt;
	
	private String psubject;
	private String subcategory;
	private String pimg;
	private int price;
	
	private int totalpay;
	
	private String chkbucket;
	
	public int getBkNum() {
		return bkNum;
	}
	public void setBkNum(int bkNum) {
		this.bkNum = bkNum;
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
	public int getOrderCnt() {
		return orderCnt;
	}
	public void setOrderCnt(int orderCnt) {
		this.orderCnt = orderCnt;
	}
	public String getPimg() {
		return pimg;
	}
	public void setPimg(String pimg) {
		this.pimg = pimg;
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
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getChkbucket() {
		return chkbucket;
	}
	public void setChkbucket(String chkbucket) {
		this.chkbucket = chkbucket;
	}
	@Override
	public String toString() {
		return "BucketDTO [bkNum=" + bkNum + ", userID=" + userID + ", pCode=" + pCode + ", orderCnt=" + orderCnt + "]";
	}
	public int getTotalpay() {
		return totalpay;
	}
	public void setTotalpay(int totalpay) {
		this.totalpay = totalpay;
	}
	
	
}
