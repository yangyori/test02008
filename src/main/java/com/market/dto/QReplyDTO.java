package com.market.dto;

import java.util.Date;

public class QReplyDTO {
	private int rqNum;
	private String qNum;
	private String replyText;
	private String replyer;
	private Date replyDate;
	
	
	public int getRqNum() {
		return rqNum;
	}
	public void setRqNum(int rqNum) {
		this.rqNum = rqNum;
	}
	public String getqNum() {
		return qNum;
	}
	public void setqNum(String qNum) {
		this.qNum = qNum;
	}
	public String getReplyText() {
		return replyText;
	}
	public void setReplyText(String replyText) {
		this.replyText = replyText;
	}
	public String getReplyer() {
		return replyer;
	}
	public void setReplyer(String replyer) {
		this.replyer = replyer;
	}
	public Date getReplyDate() {
		return replyDate;
	}
	public void setReplyDate(Date replyDate) {
		this.replyDate = replyDate;
	}
}
