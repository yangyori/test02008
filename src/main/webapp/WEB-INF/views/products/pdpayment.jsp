<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제(주문서)</title>
<link rel="stylesheet" href="/ex/resources/css/주문서.css?ver=0">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script>
	    function deleteBtn(){
	        if(document.getElementById("article_top2_hide").style.display =='block'){
	            document.getElementById("article_top2_hide").style.display ='none';
	            document.getElementById("article_top2").style.display ='block';                
	            document.getElementById("deleteBtn").innerText="▼"
	        }
	        else{
	            document.getElementById("article_top2_hide").style.display ='block';
	            document.getElementById("article_top2").style.display ='none';
	            document.getElementById("deleteBtn").innerText="▲"
	        } 
	    }
	    
	    function lastOrder(){
	    	if (confirm("결제 하시겠습니까?")==true) {	    	
	    		alert("결제 했습니다.");
	    		f=document.orderForm;
	           	f.action="/ex/products/pay";
	           	f.submit();    	
	    	}        
	    }
	    
	    
    </script>
</head>
<body>
	<div id="wrap">
		<%@include file="../include/header.jsp"%>
		<div id="headertitle">주문서</div>
		<div id="article">
			<div id="article_top1">
				주문상품
				<button id="deleteBtn" onclick="deleteBtn()">▼</button>
			</div>
			
			<c:choose>
			<c:when test="${bCount==1}">
			<div class="article_top2">[${cbfdto.psubject}] 상품을 주문합니다.</div>
			</c:when>
			<c:otherwise>
			<div class="article_top2">${cbfdto.psubject}외 ${bCount-1}개의 상품을 주문합니다.</div>
			</c:otherwise>
			</c:choose>
			
			
			<form name="orderForm"  method="POST">
			<div id="article_top2_hide">
				
				<c:forEach items="${ckblist}" var="cbdto">
				<ul>
					<li style="width: 70px;"><img src="/ex/resources/img/마켓이미지/${cbdto.subcategory}/${cbdto.pCode }/${cbdto.pimg}"
						class="tb_img"></li>
					<li style="width: 685px;">${cbdto.psubject}</li>
					<li style="width: 170px;">${cbdto.orderCnt}개</li>
					<li><fmt:formatNumber value="${cbdto.orderCnt*cbdto.price}" pattern="#,##0"/>원</li>
				</ul>
				<input type="hidden" name="bkNum" value="${cbdto.bkNum}">
				<input type="hidden" name="pCode" value="${cbdto.pCode}">
				<input type="hidden" name="orderCnt" value="${cbdto.orderCnt}">
				<!-- 반복문  구역 -->
				</c:forEach>
	
			</div>		
			
			<div id="article_top3">주문자 정보</div>
			<div id="article_top4">
				<div id="article_top4_left">
					보내는 분<br> 휴대폰<br> 이메일
				</div>
				<div id="article_top4_right">
					${mbdto.userName}<br> ${mbdto.phone}<br> ${mbdto.email}<br> 이메일을
					통해 주문처리과정을 보내드립니다.<br> 정보변경은 개인정보 수정 메뉴에서 가능합니다.
				</div>
			</div>
			<div class="clear"></div>
			<div id="article_middle_left">
				<div id="article_top5">
					배송 정보
					<div id="article_top5_right">
						배송지 변경 안내 <span class="material-icons"
							style="width: 8px; height: 8px;"> help_outline </span>
					</div>
				</div>
				<div id="article_top6">
					<div id="article_top6_left">배송지</div>
					<div id="article_top6_right">
						<div>기본배송지</div>
						${ddto.addr1} ${ddto.addr2}						
						<input type="hidden" name="addr1" value="${ddto.addr1}">
						<input type="hidden" name="addr2" value="${ddto.addr2}">
					</div>
				</div>
				<div class="clear"></div>
				<div id="article_top6">
					<div id="article_top6_left">상세 정보</div>
					<div id="article_top6_right">
						<input type="hidden" name="recipient" value="${ddto.recipient}">
						<input type="hidden" name="phoneNum" value="${ddto.phoneNum}">
						<span name="recieveInfo">${ddto.recipient}, ${ddto.phoneNum}</span><br>
						
					</div>
				</div>
			</div>
			<div id="article_middle_right">
				<div id="article_top7">결제금액</div>
				<div id="article_top8">
					<div id="article_top8_top">
						<div id="article_top8_prd">
							주문금액
							<p><span><fmt:formatNumber value="${totalprice}" pattern="#,##0"/></span>원</p>
						</div>
						<div id="article_top8_del">
							배송비
							<p>0원</p>
						</div>
						<div id="article_top8_coupon">
							쿠폰할인금액
							<p>0원</p>
						</div>
					</div>
					<div id="article_top8_bottom">
						최종결제금액
						<p><span><fmt:formatNumber value="${totalprice}" pattern="#,##0"/></span>원</p>
						<input type="hidden" name="payment" value="${totalprice}">
					</div>
				</div>
				<input type="button" id="orderBtn" onclick="lastOrder()" value="total_price 결제하기">
				
			</div>
			</form>
			<div class="clear"></div>
		</div>
		<%@include file="../include/footer.jsp"%>
	</div>
</body>
</html>