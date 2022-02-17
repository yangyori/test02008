package com.market.dto;

public class DeliveryDTO {
   private int deliNum;
   private String userID;
   private String addr1;
   private String addr2;
   private String recipient;   
   private String phoneNum; 
   private int basicAdd;
   
   
   public int getDeliNum() {
      return deliNum;
   }
   public void setDeliNum(int deliNum) {
      this.deliNum = deliNum;
   }
   public String getUserID() {
      return userID;
   }
   public void setUserID(String userID) {
      this.userID = userID;
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
   public String getRecipient() {
      return recipient;
   }
   public void setRecipient(String recipient) {
      this.recipient = recipient;
   }
   public String getPhoneNum() {
      return phoneNum;
   }
   public void setPhoneNum(String phoneNum) {
      this.phoneNum = phoneNum;
   }
   public int getBasicAdd() {
      return basicAdd;
   }
   public void setBasicAdd(int basicAdd) {
      this.basicAdd = basicAdd;
   }
@Override
public String toString() {
	return "DeliveryDTO [deliNum=" + deliNum + ", userID=" + userID + ", addr1=" + addr1 + ", addr2=" + addr2
			+ ", recipient=" + recipient + ", phoneNum=" + phoneNum + ", basicAdd=" + basicAdd + "]";
}
   
   

   
}