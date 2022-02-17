package com.market.dto;

import java.util.Date;

public class QnaDTO {
	private int qNum;
	private int pCode;
	private String userID;
	private String qTitle;
	private String qContents;
	private Date created;
	private int rStatus;

	private String subcategory;
	private String psubject;
	private String pimg;
	
	
	public int getqNum() {
		return qNum;
	}
	public void setqNum(int qNum) {
		this.qNum = qNum;
	}
	public int getpCode() {
		return pCode;
	}
	public void setpCode(int pCode) {
		this.pCode = pCode;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getqTitle() {
		return qTitle;
	}
	public void setqTitle(String qTitle) {
		this.qTitle = qTitle;
	}
	public String getqContents() {
		return qContents;
	}
	public void setqContents(String qContents) {
		this.qContents = qContents;
	}
	public Date getCreated() {
		return created;
	}
	public void setCreated(Date created) {
		this.created = created;
	}
	public int getrStatus() {
		return rStatus;
	}
	public void setrStatus(int rStatus) {
		this.rStatus = rStatus;
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
	public String getPsubject() {
		return psubject;
	}
	public void setPsubject(String psubject) {
		this.psubject = psubject;
	}
	@Override
	public String toString() {
		return "QnaDTO [qNum=" + qNum + ", pCode=" + pCode + ", userID=" + userID + ", qTitle=" + qTitle
				+ ", qContents=" + qContents + ", created=" + created + ", rStatus=" + rStatus + ", subcategory="
				+ subcategory + ", psubject=" + psubject + ", pimg=" + pimg + "]";
	}
	
	
	
	
}
