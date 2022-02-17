<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터메뉴</title>
<link rel="stylesheet" href="/ex/resources/css/고객센터메뉴.css">
<script>
function notlongin(){
	alert("로그인하셔야 서비스를 이용하실 수 있습니다.");
	self.location ="/ex/member/login";
}
</script>
</head>
<body>
	<div id="cleft">
		<div id="ckurly">
			<div id="cleft_header">고객센터</div>
			<div id="side_menu">
				<ul id="side_list">
					<li><a href="/ex/customcenter/noticelist">공지사항</a></li>
					<li><a href="/ex/customcenter/oftenqna">자주하는 질문</a></li>
					<c:choose>
                	<c:when test="${not empty sessionScope.userID}">
					<li><a href="/ex/customcenter/oneinquiry">1:1문의</a></li>
					</c:when>
					<c:otherwise>
					<li style="cursor: pointer;" onclick="notlongin()"><a>1:1문의</a></li>
					</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>