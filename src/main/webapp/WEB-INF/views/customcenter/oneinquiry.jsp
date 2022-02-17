<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1문의</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/ex/resources/css/1대1문의.css?var=77">

<script>

$(document).ready(function () {
    const acoAco = $('.QnA-dropdown .QnA-main');

    acoAco.on('click', function () {
        const item = $(this);
        let speed = 100;

        acoAco.parent().find('.QnA-textbox').stop().slideUp(speed);

        if (item.hasClass('active')) {
            item.find('.QnA-textbox').stop().slideUp(speed);
            item.removeClass('active');
        } else {
            item.parent().find('.QnA-textbox').stop().slideDown(speed);
            acoAco.removeClass('active');
            item.addClass('active');
        }

    });
    
    $(".delbtn").on("click", function(event){
    	
		var that = $(this);
		var qNum = $(this).attr("data-src");

		$.ajax({
			type:'delete',
			url: '/ex/customcenter/oneinquiry/'+qNum,
			headers:{
				"Content-Type":"application/json"
			},
			dataType:'text',
			success:function(result){					
				if(result=='SUCCESS'){
					alert("1:1문의에서 삭제되었습니다.");
					document.location.reload();
				}
			}				
		})		

	});
    
    $(".replyBtn").on("click",function(){
    	var	qNum=$("#qNumber").val();
    	var replytext=$("#newReplyText").val();
		var replyer=$("#newReplyeWriter").val();	//사용자 입력값을 불러올때 value를 씀
		
		$.ajax({
			type:'post',
			url:'/ex/customcenter/replies',
			headers:{
				"Content-Type":"application/json"
			},
			dataType:'text',
			data:JSON.stringify({
				qNum:qNum,
				replyText:replytext,
				replyer:replyer
			}),
			success: function(result){
				if(result == 'SUCCESS'){
					alert("등록 되었습니다.")
					document.location.reload();
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
		<div id="customwrap">
			<%@include file="../include/customcentermenu.jsp"%>
			<div id="cright">
				<div id="cright_header">1:1문의</div>
				<div id="article_right_middle1">
					<ul class="QnA-dropdown">
						<li>
							<div class="QnA-header" style=" border-bottom: solid 1px #e7e6e6;">
								<div class="qnatd1">번호</div>
								<div class="qnatd2">카테코리</div>
								<div class="qnatd3">제목</div>
								<div class="qnatd1">작성자</div>
							</div> 
							<c:choose>
								<c:when test="${count > 0}">
									<c:forEach items="${list}" var="inquirydto">
										<div class="border_line">
											<div class="QnA-main">
												<div class="qnatd1">${inquirydto.qNum}</div>
												<div class="qnatd2">${inquirydto.category}</div>
												<div class="qnatd3">${inquirydto.title}</div>
												<div class="qnatd1">${inquirydto.userID}</div>
											</div>
											
											<div class="QnA-textbox" style="display: none; font-size: 14px;">
												<div>
													<span>Q :</span>  &nbsp; ${inquirydto.title}<br><br>
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- ${inquirydto.contents}<br><br>
													<div class="deldiv"><a class="delbtn" data-src="${inquirydto.qNum}">삭제</a></div>
												</div>
												<div class="clear"></div>

												<c:forEach items="${qrdto}" var="qrdto">
													<c:if test="${qrdto.qNum == inquirydto.qNum}">
														<div class="replies">
															<span>A : </span> &nbsp; ${qrdto.replyText }<br><br>
															&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${qrdto.replyer} 올림
															<div id="replydate">작성일자 : <fmt:formatDate value="${qrdto.replyDate}" type="date" dateStyle="medium"/></div>
															<div class="clear"></div>
														</div>
														<div class="clear"></div>
													</c:if>
												</c:forEach>
												
												<div class="clear"></div>
												
											</div>
											
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<ul id="middle2_ul2">
										<li id="middle2_li2">1:1문의 내역이 존재하지 않습니다.</li>
									</ul>
								</c:otherwise>
							</c:choose>
						</li>
					</ul>
				</div>
				<div style="text-align: center;">
					<c:choose>
						<c:when test="${count > 0}">
							<div class="pagination">
								<c:if test="${pageMaker.page !=1}">
									<a href='oneinquiry${pageMaker.makeSearch(1)}'>&laquo;</a>
								</c:if>
								<c:if test="${pageMaker.prev }">
									<a
										href='oneinquiry${pageMaker.makeSearch(pageMaker.startPage-1)}'>&lt;</a>
								</c:if>

								<c:forEach begin="${pageMaker.startPage }"
									end="${ pageMaker.endPage}" var="idx">
									<a href='oneinquiry${pageMaker.makeSearch(idx)}'
										<c:out value="${pageMaker.page==idx?' class=active ':'' }"/>>${idx}</a>
								</c:forEach>

								<c:if test="${pageMaker.next }">
									<a
										href='oneinquiry${pageMaker.makeSearch(pageMaker.endPage+1)}'>&gt;</a>
								</c:if>

								<c:if test="${pageMaker.page != pageMaker.totalEndPage}">
									<a
										href='oneinquiry${pageMaker.makeSearch(pageMaker.totalEndPage)}'>&raquo;</a>
								</c:if>
							</div>
						</c:when>
						<c:otherwise>
							<div>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
				<div id="article_right_footer">			
					<a href="/ex/customcenter/oneinquirywrite"><button id="writeBtn" style="cursor: pointer;">글쓰기</button></a>
				</div>
			</div>
		</div>
		<%@include file="../include/footer.jsp"%>
	</div>
</body>
</html>