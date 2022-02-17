<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송지 등록</title>
<link rel="stylesheet" href="/ex/resources/css/deliveryPopup.css?ver=2">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>

<body>
    <div id="delivery_head">
        <div id="delivery_title">배송정보 수정</div>        
    </div>
	
	<form action="/ex/products/deliveryCartPopUpdate" method="POST">
    <div id="delivery_contents">
        <div style="margin-bottom:20px; font-weight:bold;">
            <span>주소</span><br>
            <div>${ddto.addr1}</div>
        </div>
        <div>
            <span>상세주소</span><br>
            <input name="addr2" type="text" id="sample6_detailAddress" placeholder="상세주소" value="${ddto.addr2}">
        </div>
        <div>
            <span>받으실 분</span><br>
            <input name="recipient" type="text" id="cuserName" placeholder="이름을 입력해 주세요" value="${ddto.recipient}">
        </div>
        <div>
            <span>휴대폰</span><br>
            <input name="phoneNum" type="text" id="cphoneNum" placeholder="숫자만 입력해주세요" value="${ddto.phoneNum}">
        </div>
        <input type="hidden" name="deliNum" id="deliNum" value="${ddto.deliNum}">
        <input type="hidden" name="basicAdd" id="basicAdd" value="${ddto.basicAdd}">
    </div>
    <div id="delivery_bottom">
        <input id="dbtn2" type="submit" value="수정">
    </div>
    </form>
</body>

</html>