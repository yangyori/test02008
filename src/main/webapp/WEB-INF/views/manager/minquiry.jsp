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
    <link rel="stylesheet" href="/ex/resources/css/관리자상품문의.css?var=100">

    <script>
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
            
          	//상품문의 답글쓰기
        	$(".rbtn2").on("click", function(){
        	
       			var qNum = $(this).attr("data-src");
    			location.href="/ex/manager/minquirywrite?qNum="+qNum;
    		});

          	//상품문의 답글 삭제
			$(".replydelbtn").on("click", function(event){
            	
    			var that = $(this);
    			var rqNum = $(this).attr("data-src");

    			$.ajax({
    			type:'delete',
    			url: '/ex/manager/minquirydelete/'+rqNum,
    			headers:{
    				"Content-Type":"application/json"
    			},
    			dataType:'text',
    			success:function(result){					
    				if(result=='SUCCESS'){
    					alert("상품문의 답글이 삭제되었습니다.");
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

        <div id="mywrap">
            <%@include file="../include/managermenu.jsp"%>


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
										<p>${qdto.qTitle}</p>
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
									<div style="width: 774px; padding: 15px 0px 0px 30px; font-size: 14px;" >
										<span>Q :</span>  ${qdto.qTitle}<br><br>
										<p style="font-size: 12px; color: rgb(58, 58, 58);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${qdto.qContents}</p><br><br><br>
									</div>
									<div class="clear"></div>
									
									<c:forEach items="${qnardto}" var="qrdto">
										<c:if test="${qrdto.qNum == qdto.qNum}">
											<div class="replies">
												<span>A : </span> &nbsp; ${qrdto.replyText }<br><br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${qrdto.replyer} 올림
												<div id="replydate">작성일자 : <fmt:formatDate value="${qrdto.replyDate}" type="date" dateStyle="medium"/></div>
												<div class="clear"></div>
												<div style="float: right;"><button class="replydelbtn" data-src="${qrdto.rqNum}">삭제</button></div>
											</div>
											<div class="clear"></div>
										</c:if>
									</c:forEach>
									
									<div style="width: 774px; margin-bottom: 20px;">
										<ul>
											<li class="lileft">
												<c:choose>
                              						<c:when test="${qdto.rStatus==0}">
                                 						<div>
															<button class="rbtn2" data-src="${qdto.qNum}">답변달기</button>
														</div>
                              						</c:when>
                              						<c:otherwise>
                                 						<div>
															<button class="rbtn1">답변달기</button>
														</div>
                              						</c:otherwise>
                            					</c:choose>
											</li>
											<li><a class="delbtn" data-src="${qdto.qNum}">삭제</a></li>
										</ul>
									</div>
								</div>
							</li>
						</div>
					</c:forEach>
					<!-- 반복 -->
                </ul>
            </div>
        </div>
         <%@include file="../include/footer.jsp"%>


    </div>
</body>



</html>