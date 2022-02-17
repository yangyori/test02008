<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/ex/resources/css/userDelete.css">
    <style>
       

    </style>
    <script>
    function checkCurrentPassword(){
    	$.ajax({
    		url : "/ex/member/reCheck",
    		type : "post",
    		dataType : "json",
    		data : {"password1" : $("#Ptext").val(),
    			"userID" : $("#userID").val()},
    		success : function(data){
    			if(data==0){
    				alert("비밀번호가 일치하지 않습니다.");
    				return;
    			} else {
    				document.form1.action = "${path}/ex/member/userDelete";
    				document.form1.submit();
    			}
    		}
    	});  	
    }

    </script>
    <script>
	function cancle(){
		self.location = "/ex/";
	}
    </script>
</head>
<body>
    <div id = "wrap">
        <%@include file="../include/header.jsp"%>

        <div class="clear"></div>
        
        <div id = "delwrap">
            <div id = "dheader">
                <h2>회원탈퇴안내</h2>
            </div>
            
            <form name = "form1" method = "POST">
            <div id = "article">
                <div id="table_area">
                    <table>
                        <tr>
                            <td class = "table-left">회원탈퇴안내</td>
                            <td class = "table-right">고객님께 회원 탈퇴를 원하신다니 저희 쇼핑몰의 서비스가 많이 부족하고 미흡했나봅니다.<br>불편하셨던 점이나 불만사항을 알려주시면
                                적극 반영해서 불편함을 해결해 드리도록 노력하겠습니다.<br></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td class = "consider"><br>아울러 회원 탈퇴시의 아래 사항을 숙지하시기 바랍니다.</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td class = "table-right"><br>1.회원 탈퇴 시 고객님의 정보는 상품 반품 및 A/S를 위해 전자상거래 등에서의 소비자<br> 보호에 관한 법률에 의거한 고객정보
                                보호정책에따라 관리 됩니다.<br>
                                2.탈퇴 시 고객님께서 보유하셨던 적립금은 모두 삭제 됩니다.<br>
                                3.회원 탈퇴 후 30일간 재가입이 불가능합니다.<br>
                                4.회원 탈퇴 시 컬리패스 해지는 별도로 고객행복센터(1644-1107)를 통해서 가능합니다.<br> 직접 해지를 요청하지 않으면 해지 처리가 되지 않습니다.<br></td>
                        </tr>
                        <tr>
                            <td class = "table-left">비밀번호 확인</td>
                            <td class = "table-right"><input id = "Ptext" type = "password" name = "password1"></td>
                        </tr>
                    </table>
                </div>
                <div id = "button_area">
                    <button type = "button" onclick = "cancle()">취소</button>
                    <button type = "button" id = "deleteID" onclick = "checkCurrentPassword()">탈퇴</button>
                </div>                    
            </div>
            	<input type = "text" id = "userID" name = "userID" value="${sessionScope.userID}" style = display:none>
            </form>
        </div>        
        <%@include file="../include/footer.jsp"%>
    </div>
</body>
</html>