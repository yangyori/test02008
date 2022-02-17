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

    <link rel="stylesheet" type="text/css" href="/ex/resources/css/productlist.css?ver=1">

</head>

<body>
    <div id="wrap">
    	<%@include file="../include/header.jsp"%>
    	<div id="item_category">
            <div id="hcategory">채소</div>
            <div id="detailctg">
                <ul id="detailmenu">
                    <% String subcategory = (String)request.getParameter("subcategory"); %>
                    <li><a href="/ex/products/pdlist?subcategory=전체보기&od=5" class="tree" <% if ("전체보기".equals(subcategory)) { %>id="selected"<% } %>>전체보기</a></li>
                    <li><a href="/ex/products/pdlist?subcategory=친환경&od=5" class="tree" <% if ("친환경".equals(subcategory)) { %>id="selected"<% } %>>친환경</a></li>
                    <li><a href="/ex/products/pdlist?subcategory=고구마감자당근&od=5" class="tree" <% if ("고구마감자당근".equals(subcategory)) { %>id="selected"<% } %>>고구마‧당근‧감자</a></li>
                    <li><a href="/ex/products/pdlist?subcategory=시금치쌈채소나물&od=5" class="tree" <% if ("시금치쌈채소나물".equals(subcategory)) { %>id="selected"<% } %>>시금치‧쌈채소‧나물</a></li>
                    <li><a href="/ex/products/pdlist?subcategory=브로콜리파프리카양배추&od=5" class="tree" <% if ("브로콜리파프리카양배추".equals(subcategory)) { %>id="selected"<% } %>>브로콜리‧파프리카‧양배추</a></li>
                    <li><a href="/ex/products/pdlist?subcategory=양파대파마늘배추&od=5" class="tree" <% if ("양파대파마늘배추".equals(subcategory)) { %>id="selected"<% } %>>양파‧대파‧마늘‧배추</a></li>
                    <li><a href="/ex/products/pdlist?subcategory=오이호박고추&od=5" class="tree" <% if ("오이호박고추".equals(subcategory)) { %>id="selected"<% } %>>오이‧호박‧고추</a></li>
                    <li><a href="/ex/products/pdlist?subcategory=콩나물버섯&od=5" class="tree" <% if ("콩나물버섯".equals(subcategory)) { %>id="selected"<% } %>>콩나물‧버섯</a></li>
                </ul>
            </div>
        </div>
        <div class="clear"></div>
        <div id="cntorderby">
            <div id="totalcnt">총 ${pCount}개</div>
            <div id="orderby">
                <ul id="lineup">
                    <% String od = (String)request.getParameter("od"); %>
                    <li class="oli1"><a href="/ex/products/pdlist?subcategory=${subcategory}&od=1" <% if ("1".equals(od)) { %>id="selected"<% } %>>신상품순</a></li>
                    <li class="oli2"><a href="/ex/products/pdlist?subcategory=${subcategory}&od=2" <% if ("2".equals(od)) { %>id="selected"<% } %>>판매량수</a></li>
                    <li class="oli3"><a href="/ex/products/pdlist?subcategory=${subcategory}&od=3" <% if ("3".equals(od)) { %>id="selected"<% } %>>낮은 가격순</a></li>
                    <li class="oli4"><a href="/ex/products/pdlist?subcategory=${subcategory}&od=4" <% if ("4".equals(od)) { %>id="selected"<% } %>>높은 가격순</a></li>
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
        <%@include file="../include/footer.jsp"%>
    </div>
</body>
</html>