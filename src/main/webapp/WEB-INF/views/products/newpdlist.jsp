<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 리스트</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <link rel="stylesheet" type="text/css" href="/ex/resources/css/newproductlist.css?var=100">
<script>
</script>

</head>

<body>
    <div id="wrap">
    	<%@include file="../include/header.jsp"%>
    	<div id="item_category">
            <div id="hcategory">신상품</div>
        </div>
        <div class="clear"></div>
        <div id="cntorderby">
            <div id="totalcnt">총 ${count}개</div>
            <div id="orderby">
                <ul id="lineup">
                    <li class="oli1"><a href="#">신상품순</a></li>
                    <li class="oli2"><a href="#">판매량수</a></li>
                    <li class="oli3"><a href="#">낮은 가격순</a></li>
                    <li class="oli4"><a href="#">높은 가격순</a></li>
                </ul>
            </div>
        </div>
        <div id="list">
        
        	<c:forEach items="${newlist}" var="pdto" varStatus="status">	
	        	<!-- 반복문  구역 -->
	            <div class="item">
	                <div class="item_img" name="pimg"><a href="/ex/products/pdinfo?pCode=${pdto.pCode}"><img src="/ex/resources/img/마켓이미지/${pdto.subcategory}/${pdto.pCode }/${pdto.pimg}"></a></div>
	                <div class="psubject" name="psubject">${pdto.psubject}</div>
	                <div class="price" name="price">${pdto.price}원</div>
	                <div class="pinfo" name="pinfo">${pdto.pinfo}</div>
	            </div>
				<!-- 반복문  구역 -->
			</c:forEach>
            
        </div>
        <%@include file="../include/footer.jsp"%>
    </div>
</body>
</html>