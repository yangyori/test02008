<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 내용</title>
<link rel="stylesheet" href="/ex/resources/css/공지사항내용.css">
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
						<td colspan="3">마켓컬리 배송 안내</td>
					</tr>

					<tr class="notice_tr">
						<th class="notice_th1 td02">작성자</th>
						<td class="td02" colspan="3">MarketKurly</td>
					</tr>
					<tr>
						<th class="notice_th1">작성일</th>
						<td class="td01">2016-01-08</td>
						<th class="notice_th1">조회수</th>
						<td>295816</td>
					</tr>

				</table>
			</div>
			<div class="notice_content-main">
				<img src="/ex/resources/img/공지사항 이미지01.png"> <img
					src="/ex/resources/img/공지사항 이미지02.png"> <img
					src="/ex/resources/img/공지사항 이미지03.png"> <img
					src="/ex/resources/img/공지사항 이미지04.png"> <img
					src="/ex/resources/img/공지사항 이미지05.png"> <img
					src="/ex/resources/img/공지사항 이미지06.png">

			</div>

			<div class="notice_list">
				<a href="/ex/customcenter/noticelist"><button>목록</button></a>
			</div>
		</div>
		<%@include file="../include/footer.jsp"%>
	</div>
</body>
</html>