<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <link rel="stylesheet" href="/ex/resources/css/login.css?ver=10">

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

        function login(){
            var form = document.loginFrm;
            if(form.userID.value == ""){
                alert("아이디를 입력해주세요.");               
            }
            else if(form.password1.value == ""){
                alert("비밀번호를 입력해주세요.");
             
            }else{
            	form.action="/ex/member/login";
            	form.submit;
            }
        }
    </script>
	<script>
	let result = '${message}'
    	if(result == 'Joinsuccess'){
    		alert("회원가입을 축하드립니다.");
    	}
    </script>
   <script>
	let result = '${message}'
    	if(result == 'updateSuccess'){
    		alert("회원수정이 완료되었습니다.");
    	}
    </script>
</head>
<body>
    <div id="wrap">
        <%@include file="../include/header.jsp"%>
    
        <div class = "logincontainer">
            <div class = "row">
                <div class="mkimg">
                    <img src = "/ex/resources/img/loginimg.jpg" >
                </div>
                <div class="logarea">
                    <div class="loginhead">
                        <h1>MarketKurly</h1>
                    </div>

                    <form action = "" name = "loginFrm" method = "POST">
                    <input type = "hidden" name = "${_csrf.parameterName}" value = "${_csrf_token}">
                        <div>
                            <div>
                                <input class="idinput" type = "text" placeholder= "아이디" id = "userID" name = "userID">
                            </div>
                            <div class="pwdiv">
                                <input class="pwinput" type = "password" placeholder= "비밀번호" id = "password1" name = "password1">
                            </div>
                        </div>
                     
                        <div class="logbtndiv">
                            <button id = "btnLogin" onclick = "login()" class = "logbtn">Login</button>
                        </div>
                        
                         <div class="exdiv">
                         <p><a href = "/ex/member/IDSearch">아이디를 잊어버리셨나요?</a></p>
                            <p><a href = "/ex/member/passwordSearch">비밀번호를 잊어버리셨나요?</a></p>                            
                            <p><a href = "/ex/member/join">회원등록하기</a></p>		
                        </div>
                        
                        <c:if test = "${message == 'error' }">
                            <div class="msgidpw">
                                *아이디 또는 비밀번호가 일치하지 않습니다.
                            </div>
                        </c:if>
                        
                    </form>
                </div>
            </div>
        </div>
        <%@include file="../include/footer.jsp"%>
    </div>
</body>
</html>