<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송지 등록</title>
<link rel="stylesheet" href="/ex/resources/css/deliveryCartPop.css?ver=0">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script>
    
    
	    function deliveryUpdate(deliNum)
	    {
	        
	    	self.location ="/ex/products/deliveryCartPopUpdate?deliNum="+deliNum;
	                
	    }
	    
	    function deliveryAdd()
	    {
	    	self.location ="/ex/products/deliveryCartPopInsert";
	                   
	    }


        $(document).ready(function() {

        	//배송지 추가
        	$("#dbtn2").click(function(){        	
        	
        		var addr1=$("#sample6_address").val();
                var addr2=$("#sample6_detailAddress").val();
                var recipient=$("#cuserName").val();
                var phoneNum=$("#cphoneNum").val();                
                
              	if(addr1==""&&addr2==""&&recipient==""&&phoneNum==""){
              		alert("빈칸을 모두 채워주세요.");
              	}else{                
	        		$.ajax({
	    				type : 'post',
	    				url : '/ex/mykurly/deliveryAdd',
	    				headers : {
	    					"Content-Type" : "application/json"
	    				},
	    				dataType : 'text',
	    				data : JSON.stringify({
	    					addr1:addr1,
	    					addr2:addr2,
	    					recipient:recipient,
	    					phoneNum:phoneNum
	    				}),
	    				success : function(result) {
	    					alert("새로운 배송지를 추가했습니다.");
	    					opener.parent.location.reload();
	    					window.close();
	    				}
	    			}) 
              	}
        	});
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
	   					alert("기본배송지가 변경되었습니다.");
	   					opener.parent.location.reload();
    					window.close();
	   				}
	   			})	        
          	});
        	
        });
        

   </script>
</head>

<body>
   <div id="wrap">
		
		<div id="header">
        <div id="header_title">배송지</div>
     	<div id="header_insert" onclick="deliveryAdd()">+ 새 배송지 추가</div>
        </div>

        <div id="mywrap">
            <div id="divtable">
                <div id="divtrh">
                    <div id="divth1">선택</div>
                    <div id="divth2">배송정보</div>
                    <div id="divth3">수정</div>
                </div>

				<c:forEach items="${dlist}" var="ddto">
                <div class="divtr">
                	<c:choose>
                    <c:when test="${ddto.basicAdd==1}">
                    <div class="divtd1"><input type="radio" name="basicAdd" class="basicAdd" checked="checked"></div>
                    </c:when>
                    <c:otherwise>
                    <div class="divtd1"><input name="basicAdd" class="basicAdd" type="radio" data-src="${ddto.deliNum}"></div>
                    </c:otherwise>
                    </c:choose>
                    <div class="divtd2">
                        <div class="addr">${ddto.addr1} ${ddto.addr2}</div>
                        <div class="recipient">${ddto.recipient}</div>
                        <div class="phonNumer">${ddto.phoneNum}</div>
                    </div>
                    <div class="divtd3">
                        <div class="upd" onclick="deliveryUpdate(${ddto.deliNum})"><span class="material-icons">edit</span></div>
                    </div>
                </div>
				</c:forEach>

            </div>   
        </div>

        

    </div>
</body>

</html>