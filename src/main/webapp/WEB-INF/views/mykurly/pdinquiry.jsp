<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 문의</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/ex/resources/css/상품문의.css?ver=0">

    <script>
	    function modalOn(a) {
			modal = "modal" + a;
			modal = document.getElementById("modal" + a);
			modal.style.display = "flex"
	
		}
	
		function modalOff(a) {
			modal = "modal" + a;
			modal = document.getElementById("modal" + a);
			modal.style.display = "none"
		}
		
        $(document).ready(function () {
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
            
            $(".delbtn").on("click", function(event){
            	
    			var that = $(this);
    			var qNum = $(this).attr("data-src");

    			$.ajax({
	    			type:'delete',
	    			url: '/ex/mykurly/pdinquiry/'+qNum,
	    			headers:{
	    				"Content-Type":"application/json"
	    			},
	    			dataType:'text',
	    			success:function(result){					
	    				if(result=='SUCCESS'){
	    					alert("상품문의에서 삭제되었습니다.");
	    					document.location.reload();
	    				}
	    			}				
    			})		
    	
    		});
            
            $(".modifybtn").on("click", function(event){
	   			var that = $(this);
	   			var qNum = $(this).attr("data-src");
	   			var m= $(".modifybtn").index(this);
	
	   			var qTitle=$(".qTitle:eq("+m+")").html();
	   			var qContents=$(".qContents:eq("+m+")").html();
	   			
	   			$(".mqTitle").val(qTitle);
	   			$(".mqContents").html(qContents);
	   			$(".qNum").val(qNum);
	   			
	   			modalOn(0)
	   			$.ajax({
					type:'put',
					url: '/ex/mykurly/pdcart/'+qNum,
					headers:{
						"Content-Type":"application/json"
					},
					dataType:'text',
					data:JSON.stringify({
					}),
					success:function(result){					
						if(result=='SUCCESS'){						
							alert("장바구니에서 삭제되었습니다.");
							location.reload();
						}
					}				
				})
   			});
            
            $(".modifyWrite").on("click", function(event){
	   	
	   			var qNum = $(".qNum").val();	
	   			var qTitle=$(".mqTitle").val();
	   			var qContents=$(".mqContents").val();
				
	   			if(qTitle=="" || qContents==""){
	   				alert("비어있는 내용을 다 채워 주세요.")
	   			}else{
		   			$.ajax({
						type:'put',
						url: '/ex/mykurly/updateqna',
						headers:{
							"Content-Type":"application/json"
						},
						dataType:'text',
						data:JSON.stringify({
							qNum:qNum,
							qTitle:qTitle,
							qContents:qContents
						}),
						success:function(result){					
							if(result=='SUCCESS'){						
								alert("수정되었습니다.");
								document.location.reload();
							}
						}				
					})
	   			}
	   			modalOff(a);
	   			
   			});

        });
        

        
    </script>
</head>

<body>
    <div id="wrap">
        <%@include file="../include/header.jsp"%>

        <div id="mywrap">
            <%@include file="../include/mykurlymenu.jsp"%>


            <div class="pqboard_list_wrap">
                <div id="article_right_header">
                    <p> 상품문의 </p>
                </div>
                
                <ul class="aco_list">
                    <li class="lith">
                        <div class="divth2">제목</div>
                        <div class="divth3">작성일</div>
                        <div class="divth4">답변상태</div>
                    </li>

					<c:choose>
					<c:when test="${empty qnadto}">
					<div class="noinquiry">문의한 글이 없습니다.</div>
					</c:when>
					<c:otherwise>
					
                    <!-- 반복 -->
					<c:forEach items="${qnadto}" var="qdto">
						<div class="litd">
							<li>
								<div class="acoclick">
									<div class="divth1">
										<img src="/ex/resources/img/마켓이미지/${qdto.subcategory}/${qdto.pCode}/${qdto.pimg}">
									</div>
									<div
										style="width: 413px; padding: 8px 0px 5px 0px; text-align: left;">
										<p class="qTitle">${qdto.qTitle}</p>
									</div>
									<div class="divth3" style="padding-top: 15px;"><fmt:formatDate value="${qdto.created}" type="date" dateStyle="medium"/></div>
								
									<c:choose>
		                              <c:when test="${qdto.rStatus==0}">
		                                 <div class="divth4" style="padding-top: 15px;">답변대기</div>
		                              </c:when>
		                              <c:otherwise>
		                                 <div class="divth4" style="padding-top: 15px;">답변완료</div>
		                              </c:otherwise>
		                            </c:choose>
							
								</div>
								<div class="text_box">
									<div style="width: 774px; padding: 15px 0px 0px 50px; font-size: 14px;" >
										<span>Q :</span>${qdto.qTitle}<br><br>
										<p style="font-size: 12px; color: rgb(58, 58, 58);" class="qContents">${qdto.qContents}</p><br><br><br>
									</div>
									<div style="width: 774px; margin-bottom: 20px;">
										<ul>
											<li class="lileft"><div class="modifybtn" data-src="${qdto.qNum}">수정</div></li>
											<li><a class="delbtn" data-src="${qdto.qNum}">삭제</a></li>
										</ul>
									</div>
								</div>
							</li>
						</div>
					</c:forEach>
					<!-- 반복 -->
					</c:otherwise>
					</c:choose>
                </ul>
            </div>
            			<!--모달창 화면 시작-->
			<form action="/ex/mykurly/pdquewrite" method="post">
			<div id="modal0" class="modal-overlay">
				<div class="modal-window">
					<div class="modaltop">
						<div class="object">상품 문의하기</div>
						<div class="close-area" onclick="modalOff(0)">X</div>
					</div>
					<input type="hidden" class="qNum" name="qNum" value="">
					<table class="modaltable">
						<tr>
							<td></td>
							<td class="veg">&nbsp;&nbsp;&nbsp;${pdto.psubject}</td>
						</tr>
						<tr>
							<td class="boardtitle">제목</td>
							<td><input class="iptext mqTitle" type="text" name="qTitle"
								placeholder="제목을 입력해주세요" style="width: 630px; height: 30px;">
							</td>
						</tr>
						<tr>
							<td class="contents">내용</td>
							<td><textarea
									placeholder=""
									style="width: 630px; height: 300px;" name="qContents" class="mqContents"></textarea></td>
						</tr>
					</table>

					<div class="modalbtns">
						<input type="button" class="popmodal_btn" onclick="modalOff(0)" value="취소">
						<input class="popmodal_btn modifyWrite" id="btn_showChkList" type="button" name="btn_showChkList" value="등록">
					</div>

				</div>
			</div>
			</form>
		</div>

		<!--모달창 화면 끝-->
        </div>
         <%@include file="../include/footer.jsp"%>


    </div>
</body>



</html>