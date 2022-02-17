<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 후기</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/ex/resources/css/상품후기.css?ver=77">

    <script>

        function openCity(evt, cityName) {
            var i, rwtabcontent, rwtablinks;
            rwtabcontent = document.getElementsByClassName("rwtabcontent");
            for (i = 0; i < rwtabcontent.length; i++) {
                rwtabcontent[i].style.display = "none";
            }
            rwtablinks = document.getElementsByClassName("rwtablinks");
            for (i = 0; i < rwtablinks.length; i++) {
                rwtablinks[i].className = rwtablinks[i].className.replace(" rwactive", "");
            }
            document.getElementById(cityName).style.display = "block";
            evt.currentTarget.className += " rwactive";
        }

        window.onload = function () {
            document.getElementById("defaultOpen").click();
        }
        

        $(document).ready(function(){
        	
        	//후기쓰기
        	$(".writebtn").on("click", function(){
        	
       			var pCode = $(this).attr("data-src");
    			location.href="/ex/mykurly/pdreviewwrite?pCode="+pCode;
    		});
        	
        	//후기수정
        	$(".cpmodify").on("click", function(){
        	
       			var rNum = $(this).attr("data-src");
       			
    			location.href="/ex/mykurly/pdreviewupdate?rNum="+rNum;
    		});
        	
        	//후기삭제
        	$(".cpdelete").on("click", function(event){
	   			var that = $(this);
	   			var rNum = $(this).attr("data-src");

	   			$.ajax({
					type:'delete',
					url: '/ex/mykurly/prdel/'+rNum,
					headers:{
						"Content-Type":"application/json"
					},
					dataType:'text',
					success:function(result){					
						if(result=='SUCCESS'){						
							//getPageList(page);
							alert("후기가 삭제되었습니다.");
							//that.closest("div").remove();
							location.reload();
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

            <%@include file="../include/mykurlymenu.jsp"%>


            <div id="myright">
                <div id="right_header">
                    상품 후기
                </div>
                <div id="rwrap">
                    <div class="tab">
                        <button class="rwtablinks" onclick="openCity(event, 'rvpossible')" id="defaultOpen">작성가능
                            후기</button>
                        <button class="rwtablinks" onclick="openCity(event, 'rvcomplete')">작성완료 후기</button>
                    </div>

                    <div class="clear"></div>

                    <div id="rvpossible" class="rwtabcontent">
                    	<c:choose>
						<c:when test="${empty olist}">
                        <div class="rvpno">작성가능 후기 내역이 없습니다.</div>
                        </c:when>
                        <c:otherwise>
                        <c:forEach items="${olist }" var="odto">
                        <div class="rvpyes">
                            <div class="plist">
                                <div class="ordernum">
                                    주문번호 ${odto.orderNum}
                                </div>
                                <c:forEach items="${odlist}" var="oddto">
                                <c:if test="${odto.orderNum==oddto.orderNum }">
                                <div class="orderborder">
                                    <div class="orderlist">
                                        <div class="pimg"><img src="/ex/resources/img/마켓이미지/${oddto.subcategory}/${oddto.pCode}/${oddto.pimg}"></div>
                                        <div class="pinfo">
                                            <div class="ptitle"><a href="/ex/products/pdinfo?pCode=${oddto.pCode}">${oddto.psubject}</a></div>
                                            <div class="pcnt">${oddto.cnt}개 구매</div>
                                        </div>
                                        <div class="pwrite"><button class="writebtn" data-src="${oddto.pCode}">후기쓰기</button></div>
                                    </div>
                                </div>
                                </c:if>
                         		</c:forEach>                                
                            </div>
                        </div>
                        </c:forEach>
                        </c:otherwise>
						</c:choose>
                    </div>
                    
                    <div class="clear"></div>

                    <div id="rvcomplete" class="rwtabcontent">
                    	<c:choose>
						<c:when test="${empty prlist}">
                        <div class="rvpno">작성한 후기가 없습니다.</div>
                        </c:when>
                        
                        <c:otherwise>   
                        <c:forEach items="${prlist}" var="prdto">                  
                        <div class="rvpyes">                        
                            <div class="cplist">
                                <div class="cpsubject">
                                    ${prdto.psubject}
                                </div>                               
                                <div class="corderlist">
                                    <div class="pheader">
                                        <div class="cptitle">${prdto.title}</div>
                                        <div class="cpcreated"><fmt:formatDate value="${prdto.created}" pattern="yyyy.MM.dd" /></div>
                                    </div>
                                    <div class="pcontent">
                                       	${prdto.contents }
                                    </div>                                    
                                </div>
                                <div class="cpbtns">
                                    <div class="cpdelete" data-src="${prdto.rNum}">삭제하기</div>
                                    <div class="cpmodify" data-src="${prdto.rNum}">수정</div>
                                </div>
                            </div>						
                        </div>
                        </c:forEach> 
                        </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="../include/footer.jsp"%>


    </div>
</body>

</html>