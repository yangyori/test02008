<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송지 관리</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/ex/resources/css/배송지관리.css?ver=1">
    
    <script>
    var openWin;
    
    function deliveryAdd()
    {
        window.name = "parentForm";
        openWin = window.open("/ex/mykurly/deliveryPopup",
                "childForm", "width=500, height=600, resizable = no, scrollbars = no");    
    }
    
    function deliveryUpdate(deliNum)
    {
        window.name = "parentForm";
        openWin = window.open("/ex/mykurly/deliveryUpdate?deliNum="+deliNum,
                "childForm", "width=500, height=600, resizable = no, scrollbars = no");    
    }
    
    $(document).ready(function(){
        
    	//기본배송지 변경
		 $('.basicAdd').click(function(){
			
			var deliNum = $(this).attr("data-src");	 			
	   	
   			$.ajax({
				type : 'put',
				url : '/ex/mykurly/basicAddrUpdate',
				headers : {
					"Content-Type" : "application/json"
				},
				dataType : 'text',
				data : JSON.stringify({
					deliNum:deliNum
				}),
				success : function(result) {
					alert("기본배송지가 변경되었습니다.")
				}
			})	        
       	});    
    })
    </script>
</head>

<body>
    <div id="wrap">
        <%@include file="../include/header.jsp"%>

        <div id="mywrap">
            <%@include file="../include/mykurlymenu.jsp"%>


            <div id="article_right">
                <div id="article_right_header">
                    <p>배송지 관리</p>
                    <div id="explanation">배송지에 따라 상품정보 및 배송유형이 달라질 수 있습니다.</div>
                    <div id="add_address" onclick="deliveryAdd()">+ 새 배송지 추가</div>
                </div>
                <div id="article_right_middle1">
                    <ul>
                        <li style="width: 70px;">선택</li>
                        <li style="width: 305px;">주소</li>
                        <li style="width: 100px;">받으실 분</li>
                        <li style="width: 100px;">연락처</li>
                        <li style="width: 80px;">배송유형</li>
                        <li style="width: 80px;">수정</li>
                    </ul>
                </div>
                <div class="article_right_middle2">
                    
                    <c:forEach items="${ddlist}" var="ddto">
                    <ul class="middle2_ul1">
                    <c:choose>
                    <c:when test="${ddto.basicAdd==1 }">                    
                        <li style="width: 70px;" class="middle2_li1">
                           <input type="radio" name="basicAdd" class="basicAdd" checked="checked">
                        </li>                    
                    </c:when>
                    <c:otherwise>
                    	<li style="width: 70px;" class="middle2_li1">
                           <input type="radio" name="basicAdd" class="basicAdd" data-src="${ddto.deliNum}">
                        </li>
                    </c:otherwise>
                    </c:choose>
                        <li style="width: 305px;" class="middle2_li2">${ddto.addr1} ${ddto.addr2}</li>
                        <li style="width: 100px;" class="middle2_li1">${ddto.recipient}</li>
                        <li style="width: 100px;" class="middle2_li1">${ddto.phoneNum}</li>
                        <li style="width: 80px;" class="middle2_li1">정기배송</li>
                        <li style="width: 80px;" class="middle2_li1">
                            <div class="edit1" onclick="deliveryUpdate(${ddto.deliNum})"><span class="material-icons">
                                edit
                            </span></div>
                        </li>
                    </ul>
                    </c:forEach>
                    
                </div>
            </div>
        </div>
        <%@include file="../include/footer.jsp"%>


    </div>
</body>

</html>