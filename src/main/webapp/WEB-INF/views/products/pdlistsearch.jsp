<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 리스트</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/ex/resources/css/productlist2.css">



</head>

<body>
    <div id="wrap">
    	<%@include file="../include/header.jsp"%>
    	<div id="item_category">
            <div id="hcategory">상품검색</div>
            <div id="detailctg">
            <form action="/ex/products/pdlistsearch" method="POST">
                <div id="searchkeyword">
                    <span>검색조건</span>
                    <input class="searchkey" type="text" name="search" value="${keyword}">
                    <div class="sdiv"><button class="searchbtn" type="submit">검색하기</button></div>
                </div>
            </form>
            </div>
        </div>
        <div class="clear"></div>
        
        <c:choose>
        <c:when test="${empty plist}">
        <div id="nosearch">검색된 상품이 없습니다.</div>
        </c:when>
        <c:otherwise>
        <div id="cntorderby">
            <div id="totalcnt">총 ${pCount}개</div>
            <div id="orderby">
                <ul id="lineup">
                    <li class="oli1"><a href="/ex/products/pdlistsearch?subject=created&ord=d&keyword=${keyword}">신상품순</a></li>
                    <li class="oli2"><a href="/ex/products/pdlistsearch?subject=salesvolume&ord=d&keyword=${keyword}">판매량수</a></li>
                    <li class="oli3"><a href="/ex/products/pdlistsearch?subject=price&ord=a&keyword=${keyword}">낮은 가격순</a></li>
                    <li class="oli4"><a href="/ex/products/pdlistsearch?subject=price&ord=d&keyword=${keyword}">높은 가격순</a></li>
                </ul>
            </div>
        </div>
        <div id="list">
        
        	<c:forEach items="${plist}" var="pdto" varStatus="status">	
	        	<!-- 반복문  구역 -->
	            <div class="item">
	                <div class="item_img" name="pimg"><a href="/ex/products/pdinfo?pCode=${pdto.pCode}"><img src="/ex/resources/img/마켓이미지/${pdto.subcategory}/${pdto.pCode }/${pdto.pimg}"></a></div>
	                <div class="psubject" name="psubject">${pdto.psubject}</div>
	                <div class="price" name="price"><fmt:formatNumber value="${pdto.price}" pattern="#,#00"/>원</div>
	                <div class="pinfo" name="pinfo">${pdto.pinfo}</div>
	            </div>
				<!-- 반복문  구역 -->
			</c:forEach>
            
        </div>
        </c:otherwise>
        </c:choose>
        <%@include file="../include/footer.jsp"%>
    </div>
</body>
</html>