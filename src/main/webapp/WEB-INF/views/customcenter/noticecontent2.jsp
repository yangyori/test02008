<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 내용</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="/ex/resources/css/공지사항내용2.css?var=100">

<script>
	$(document).ready(function () {
		$(".delbtn").on("click", function(event){
			
			var that = $(this);
			var ntNum = $(this).attr("data-src");
		
			$.ajax({
			type:'delete',
			url: '/ex/customcenter/noticecontent2/'+ntNum,
			headers:{
				"Content-Type":"application/json"
			},
			dataType:'text',
			success:function(result){					
				if(result=='SUCCESS'){
					alert("공지사항 목록이 삭제되었습니다.");
					document.location.href= "/ex/manager/mnotice";
				}
			}				
			})
		});
	});
</script>

</head>
<body>
	<div id="wrap">
		<%@include file="../include/header.jsp"%>
		<div class="notice-total">
			<div class="notice_content-header">
				공지사항
				<p>컬러의 새로운 소식들과 유용한 정보들을 한곳에서 확인하세요.</p>
			</div>
			<div class="notice_content-middle">
				<table class="notice_content-table">
					<tr>
						<th class="notice_th1">제목</th>
						<td colspan="3">${ndto.title}</td>
					</tr>

					<tr class="notice_tr">
						<th class="notice_th1 td02">작성자</th>
						<td class="td02" colspan="3">${ndto.manager}</td>
					</tr>
					<tr>
						<th class="notice_th1">작성일</th>
						<td class="td01"><fmt:formatDate pattern="yyyy-MM-dd" value="${ndto.created}" /></td>
						<th class="notice_th1">조회수</th>
						<td>${ndto.cnt}</td>
					</tr>

				</table>
			</div>
			<div style="margin:20px 0 0 20px; text-align: left; font-size: 14px;">
				${ndto.contents}
			</div>

			<div class="notice_list">
				<button class="delbtn" data-src="${ndto.ntNum}">삭제</button>
				<a href="/ex/customcenter/noticelist"><button>목록</button></a>
			</div>
		</div>
		<%@include file="../include/footer.jsp"%>
	</div>
</body>
</html>