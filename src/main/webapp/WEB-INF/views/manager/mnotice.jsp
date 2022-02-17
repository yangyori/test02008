<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" href="/ex/resources/css/관리자공지사항.css?var=100">

<script>
	var result = '${msg}';

	if (result == 'success') {
		alert("처리가 완료되었습니다.");
	}
	
	$(document).ready(function() {
		
		const acoAco = $('.aco_list .acoclick');
	    
        acoAco.on('click', function () {
            const item = $(this);
            let speed = 100;

            acoAco.parent().find('.text_box').stop().slideUp(speed);

            if (item.hasClass('active')) {
                item.find('.text_box').stop().slideUp(speed);
                item.removeClass('active');
            } else {
                item.parent().find('.text_box').stop().slideDown(speed);
                acoAco.removeClass('active');
                item.addClass('active');
            }

        });
		
		$('#searchBtn').on("click", function(event) {
			alert("list" + '${pageMaker.makePage(1)}'
				+ '&searchType='
				+ $("select option:selected").val()
				+ "&keyword=" + $('#keywordInput').val()); // ?page=1 & perpage=10 & searchType= 등등이 나오도록하는 검색 버튼
			self.location = "list" + '${pageMaker.makePage(1)}'
				+ '&searchType='
				+ $("select option:selected").val()
				+ "&keyword=" + $('#keywordInput').val();
		});
	});
</script>
</head>

<body>
	<div id="wrap">
		<%@include file="../include/header.jsp"%>
		<div id="customwrap">
			<%@include file="../include/managermenu.jsp"%>
			<div id="cright">
				<div id="cright_header">공지사항</div>
				<div class="cright">
					<form role="form" method="get">
					<table class="right_middle_table">
						<tr>
							<th style="width: 50px; height: 48px;">번호</th>
							<th style="width: 500px;">제목</th>
							<th style="width: 140px;">작성자</th>
							<th style="width: 100;">작성일</th>
							<th style="width: 30px;">조회</th>
						</tr>
						<tr>
							<td style="text-align: center;">공지</td>
							<td style="text-align: left;"><a href="/ex/customcenter/noticecontent">마켓컬리 배송 안내</a></td>
							<td style="text-align: center;">admin</td>
							<td style="text-align: center; width: 70px; height: 50px;">2016-01-08</td>
							<td style="text-align: center;">2994239</td>
						</tr>
						<c:forEach items="${list}" var="noticedto">
							<tr>
								<td style="text-align: center;">${noticedto.ntNum}</td>
								<td style="text-align: left;"><a href="/ex/customcenter/noticecontent2?ntNum=${noticedto.ntNum}">${noticedto.title}</a></td>
								<td style="text-align: center;">${noticedto.manager}</td>
								<td style="text-align: center; width: 70px; height: 50px;">
									<fmt:formatDate pattern="yyyy-MM-dd"
										value="${noticedto.created}" />
								</td>
								<td style="text-align: center;">${noticedto.cnt}</td>
							</tr>
						</c:forEach>
					</table>
					<div style="text-align: center;">
						<div class="pagination" style="padding: 60px 0 20px 0;">
							<c:if test="${pageMaker.page !=1}">
								<a href='mnotice${pageMaker.makeSearch(1)}'>&laquo;</a>
							</c:if>
							<c:if test="${pageMaker.prev }">
								<a
									href='mnotice${pageMaker.makeSearch(pageMaker.startPage-1)}'>&lt;</a>
							</c:if>

							<c:forEach begin="${pageMaker.startPage }"
								end="${ pageMaker.endPage}" var="idx">
								<a href='mnotice${pageMaker.makeSearch(idx)}'
									<c:out value="${pageMaker.page==idx?' class=active ':'' }"/>>
									${idx}</a>
							</c:forEach>

							<c:if test="${pageMaker.next }">
								<a href='mnotice${pageMaker.makeSearch(pageMaker.endPage+1)}'>&gt;</a>
							</c:if>


							<c:if test="${pageMaker.page != pageMaker.totalEndPage}">
								<a
									href='mnotice${pageMaker.makeSearch(pageMaker.totalEndPage)}'>&raquo;</a>
							</c:if>

						</div>
					</div>

					<div class="right_bottom" style="border-top: solid 1px black;">
						<table class="right_bottom-table">
							<tr>
								<td style="width: 800px; height: 80px; text-align: right;">
									<div>
										<select name="searchType">
											<option value="n"
												<c:out value="${pageMaker.searchType==null?'selected':'' }"/>>----</option>
											<option value="t"
												<c:out value="${pageMaker.searchType eq 't'?'selected':'' }"/>>제목</option>
											<option value="c"
												<c:out value="${pageMaker.searchType eq 'c'?'selected':'' }"/>>내용</option>
											<option value="w"
												<c:out value="${pageMaker.searchType eq 'w'?'selected':'' }"/>>작성자</option>
											<option value="tc"
												<c:out value="${pageMaker.searchType eq 'tc'?'selected':'' }"/>>제목
												및 내용</option>
										</select> <input type="text" name="keyword" id="keywordInput"
											value="${pageMaker.keyword}">
										<button id="searchBtn">검색하기</button>
									</div>
								</td>
							</tr>
						</table>
					</div>
					</form>
					<div style="float: right;">
						<a href="/ex/manager/mnoticewrite" id="writeBtnA"><button id="writeBtn">공지글쓰기</button></a>
					</div>
				</div>
			</div>
		</div>
		<%@include file="../include/footer.jsp"%>
	</div>
</body>
</html>