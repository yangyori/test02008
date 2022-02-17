<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/ex/resources/css/관리자1대1문의.css?var=0">

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
    
            })

			
	
            $(".changecolor").on("mouseover", function () {
                $(".active").removeClass("active");
            });
            
			$(".delbtn").on("click", function(event){
            	
    			var that = $(this);
    			var qNum = $(this).attr("data-src");

    			$.ajax({
    			type:'delete',
    			url: '/ex/manager/moneinquiry/'+qNum,
    			headers:{
    				"Content-Type":"application/json"
    			},
    			dataType:'text',
    			success:function(result){					
    				if(result=='SUCCESS'){
    					alert("1:1문의 목록이 삭제되었습니다.");
    					document.location.reload();
    				}
    			}				
    			})
    		});
			
			//상품문의 답글쓰기
        	$(".rbtn2").on("click", function(){
        	
       			var qNum = $(this).attr("data-src");
    			location.href="/ex/manager/moneinquirywrite?qNum="+qNum;
    		});
			
        	//상품문의 답글 삭제
			$(".replydelbtn").on("click", function(event){
            	
    			var that = $(this);
    			var rqNum = $(this).attr("data-src");

    			$.ajax({
    			type:'delete',
    			url: '/ex/manager/moneinquirydelete/'+rqNum,
    			headers:{
    				"Content-Type":"application/json"
    			},
    			dataType:'text',
    			success:function(result){					
    				if(result=='SUCCESS'){
    					alert("1:1문의 답글이 삭제되었습니다.");
    					document.location.reload();
    				}
    			}				
    			})
    		});
        });
        
        function openCategory(evt, categorydiv) {
            var i, tabcontent, tablinks;

            tabcontent = document.getElementsByClassName("tabcontent");

            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }

            tablinks = document.getElementsByClassName("tablinks");

            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");

            }
            document.getElementById(categorydiv).style.display = "block";
            evt.currentTarget.className += " active";


        }
    </script>
</head>

<body>
    <div id="wrap">
		
		<%@include file="../include/header.jsp"%>

        <div class="clear"></div>
		
        <div id="mywrap">
        	<%@include file="../include/managermenu.jsp"%>

            <div class="pqboard_list_wrap">
                <div id="article_right_header">
                    <p> 1:1문의 </p>
                </div>
                
                <ul class="aco_list">
						<li>
							<div class="lith" style=" border-bottom: solid 1px #e7e6e6;">
								<div class="divth1">번호</div>
                        		<div class="divth2">제목</div>
                        		<div class="divth3">작성자</div>
                        		<div class="divth4">작성일</div>
                        		<div class="divth4">답변상태</div>
							</div> 
							<c:choose>
								<c:when test="${count > 0}">
									<c:forEach items="${list}" var="inquirydto">
										<div class="border_line">
											<div class="acoclick">
												<div class="divtd1">${inquirydto.qNum}</div>
												<div class="divtd2">${inquirydto.title}</div>
												<div class="divtd3">${inquirydto.userID}</div>
												<div class="divtd4"><fmt:formatDate value="${inquirydto.created}" type="date" dateStyle="medium"/></div>
												<div class="divtd4">
													<c:choose>
		                              					<c:when test="${inquirydto.rStatus==0}">
		                              				    	<div class="divth4">답변대기</div>
		                              					</c:when>
		                              					<c:otherwise>
		                                 					<div class="divth4">답변완료</div>
		                              					</c:otherwise>
		                            				</c:choose>
												</div>
											</div>

										<div class="text_box" style="display: none; font-size: 14px;">
											<div style="padding: 15px 0px 0px 30px;">
												<span>Q :</span> &nbsp;[${inquirydto.category}]&nbsp;${inquirydto.title}<br>
												<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-
												${inquirydto.contents}<br>
												<br>
											</div>
											<div class="clear"></div>

											<c:forEach items="${qrdto}" var="qrdto">
												<c:if test="${qrdto.qNum == inquirydto.qNum}">
													<div class="replies">
														<span>A : </span> &nbsp; ${qrdto.replyText }<br><br>
														&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${qrdto.replyer} 올림
														<div id="replydate">작성일자 : <fmt:formatDate value="${qrdto.replyDate}" type="date" dateStyle="medium"/></div>
														<div class="clear"></div>
														<div style="float: right;"><button class="replydelbtn" data-src="${qrdto.rqNum}">삭제</button></div>
														<div class="clear"></div>
													</div>
													<div class="clear"></div>
												</c:if>
											</c:forEach>

											<div style="width: 774px; margin-bottom: 10px;">
												<ul>
													<li class="lileft">
														<c:choose>
		                              						<c:when test="${inquirydto.rStatus==0}">
		                                 						<div>
																	<button class="rbtn2" data-src="${inquirydto.qNum}">답변달기</button>
																</div>
		                              						</c:when>
		                              						<c:otherwise>
		                                 						<div>
																	<button class="rbtn1">답변달기</button>
																</div>
		                              						</c:otherwise>
		                            					</c:choose>
													</li>
													<li><a class="delbtn" data-src="${inquirydto.qNum}">삭제</a></li>
												</ul>
											</div>
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
                <div style="text-align: center;">
					<c:choose>
						<c:when test="${count > 0}">
							<div class="pagination">
								<c:if test="${pageMaker.page !=1}">
									<a href='moneinquiry${pageMaker.makeSearch(1)}'>&laquo;</a>
								</c:if>
								<c:if test="${pageMaker.prev }">
									<a
										href='moneinquiry${pageMaker.makeSearch(pageMaker.startPage-1)}'>&lt;</a>
								</c:if>

								<c:forEach begin="${pageMaker.startPage }"
									end="${ pageMaker.endPage}" var="idx">
									<a href='moneinquiry${pageMaker.makeSearch(idx)}'
										<c:out value="${pageMaker.page==idx?' class=active ':'' }"/>>${idx}</a>
								</c:forEach>

								<c:if test="${pageMaker.next }">
									<a
										href='moneinquiry${pageMaker.makeSearch(pageMaker.endPage+1)}'>&gt;</a>
								</c:if>

								<c:if test="${pageMaker.page != pageMaker.totalEndPage}">
									<a
										href='moneinquiry${pageMaker.makeSearch(pageMaker.totalEndPage)}'>&raquo;</a>
								</c:if>
							</div>
						</c:when>
						<c:otherwise>
							<div>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
            </div>
        </div>

		<div class="clear"></div>

		<%@include file="../include/footer.jsp"%>

    </div>
</body>



</html>