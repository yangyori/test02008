package com.market.dto;

import java.util.Date;

public class OdersDTO {
	private int orderNum;
	private String userID;
	private String recipient;
	private String addr1;
	private String addr2;
	private int phoneNum;
	
	//@DateTimeFormat(pattern ="yyyy-MM-dd'T'HH:mm")
	private Date order_Date;
	
	private int payment;
	
	private String pCode;
	private String psubject;
	private String subcategory;
	private String pimg;
	private int orderCount;
	
	public int getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getRecipient() {
		return recipient;
	}
	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public int getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(int phoneNum) {
		this.phoneNum = phoneNum;
	}
	public Date getOrder_Date() {
		return order_Date;
	}
	public void setOrder_Date(Date order_Date) {
		this.order_Date = order_Date;
	}
	public int getPayment() {
		return payment;
	}
	public void setPayment(int payment) {
		this.payment = payment;
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
	public int getOrderCount() {
		return orderCount;
	}
	public void setOrderCount(int orderCount) {
		this.orderCount = orderCount;
	}
	
	public String getpCode() {
		return pCode;
	}
	public void setpCode(String pCode) {
		this.pCode = pCode;
	}
	
	@Override
	public String toString() {
		return "OdersDTO [orderNum=" + orderNum + ", userID=" + userID + ", recipient=" + recipient + ", addr1=" + addr1
				+ ", addr2=" + addr2 + ", phoneNum=" + phoneNum + ", order_Date=" + order_Date + ", payment=" + payment
				+ ", pCode=" + pCode + ", psubject=" + psubject + ", subcategory=" + subcategory + ", pimg=" + pimg
				+ ", orderCount=" + orderCount + "]";
	}
	
	



	
	
}
