<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문내역</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/ex/resources/css/주문내역.css?ver=0">
    
</head>

<body>
    <div id="wrap">
        <%@include file="../include/header.jsp"%>

        <div id="mywrap">
            <%@include file="../include/mykurlymenu.jsp"%>


            <div id="myright">
                <div id="orderinfo">
                    <div id="right_header">
                        주문 내역
                    </div>
                    <div id="orderlist">
                    	<c:choose>
						<c:when test="${empty olist}">
                    	<div class="order" style="text-align: center;">주문 내역이 없습니다.</div>
                    	</c:when>
                        <c:otherwise>
                    	<!-- 반복 -->
                    	<c:forEach items="${olist}" var="odto">
                        <div class="order">
                            <div class="ordertime" name="created"><fmt:formatDate value="${odto.order_Date}" pattern="yyyy.MM.dd" /></div>
                            <div class="orderdetail">
                                <div class="orderwrap">
                                	<c:choose>
									<c:when test="${odto.orderCount==1}">
									<div class="ordertitle"><a href="/ex/mykurly/orderdetaillist?orderNum=${odto.orderNum}">${odto.psubject}</a></div>
									</c:when>
									<c:otherwise>
									<div class="ordertitle"><a href="/ex/mykurly/orderdetaillist?orderNum=${odto.orderNum}">${odto.psubject} 외  ${odto.orderCount-1}건</a></div>
									</c:otherwise>
									</c:choose>
                                    
                                    <div class="detail">
                                        <table>
                                            <tr>
                                                <td rowspan="3" class="td1"><img src="/ex/resources/img/마켓이미지/${odto.subcategory}/${odto.pCode}/${odto.pimg}"></td>
                                                <td class="td2">주문번호</td>
                                                <td class="td3">${odto.orderNum}</td>
                                                <td rowspan="3" class="td4"></td>
                                            </tr>
                                            <tr>
                                                <td class="td2">결재금액</td>
                                                <td class="td3"><span><fmt:formatNumber value="${odto.payment}" pattern="#,##0"/></span>원</td>
                                            </tr>
                                            <tr>
                                                <td class="td2">주문상태</td>
                                                <td class="td3">배송완료</td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </c:forEach>
                        <!-- 반복 -->
                        </c:otherwise>  
                        </c:choose>                               
                    </div>
                    
                    
                </div>
            </div>
        </div>
        <%@include file="../include/footer.jsp"%>

    </div>
</body>

</html>