<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/ex/resources/css/personalInfo.css">
<head>

   <script>
        $(document).ready(function () {
            
            $(".changecolor").on("mouseover", function () {
                $(".active").removeClass("active");
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
    <script>
    function checkBtn(){
        $.ajax({
            url : "/ex/member/reCheck",
            type : "post",
            dataType : "json",
            data : {"password1" : $("#password1").val(),
            	   "userID" : $("#userID").val()},
            success : function(data){
                if(data == 1){
                    location.href = "/ex/member/userUpdate";
                } else if(data == 0){
                    alert("아이디 또는 비밀번호가 일치하지 않습니다.");
                }
            }
        });
	}
    </script>
</head>
<body>
    <div id = "wrap">
        <%@include file="../include/header.jsp"%>
		<div id="mywrap">
	        <%@include file="../include/mykurlymenu.jsp"%>
	
	        <div id="article_right">
	            <div id = "instructions">
	                <p>개인 정보 수정<p>
	            </div>
	            <div id="article_right_middle1">
	                <span class="sp1">비밀번호 재확인</span>
	                <span class="sp2">회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인해주세요.</span>
	            </div>
	            <form action = "/ex/member/reCheck" method = "POST">
	            <div id = "article">                
	                <table>
	                    <tr>
	                        <td class = "table_left">아이디</td>
	                        <td class = "table_right"><input type = "text" id = "userID" name = "userID" readonly value="${sessionScope.userID}"></td>
	                    </tr>
	                    <tr>
	                        <td class = "table_left">비밀번호</td>
	                        <td class = "table_right"><input type = "password" id = "password1" name = "password1"></td>
	                    </tr>
	                </table>
	            </div>
	            <div id = "checkBtn">
	                <button type = "button" id = "checkip" onclick = "checkBtn()">확인</button>
	            </div>
	        </form>
	        </div>
        </div>
    </div>
</body>
</html>