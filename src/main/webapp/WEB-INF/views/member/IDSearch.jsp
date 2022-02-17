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
    <title>아이디찾기</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/ex/resources/css/idsearch.css">
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
    	$(function(){
    		$("#CheckID").click(function(){
    			var userName = $("#userName").val();
    			var phone = $("#phone").val();
    			if(userName == ""){
    				alert("이름을 입력하세요.");
    				$("#userName").focus();
    				return;
    			}
    			if(phone == ""){
    				alert("핸드폰 번호를 입력하세요.");
    				$("#phone").focus();
    				return;
    			}
    			document.form1.action = "${path}/ex/member/IDSearch";
    			document.form1.submit();
    		});
    	});
    </script>
    <script>
    	var result = '${message}'
    	if(result == 'error'){
    		alert("이름 또는 핸드폰 번호가 일치하지 않습니다.");
    	}
    </script>
 
</head>
<body>
        <div id = "wrap">
            <%@include file="../include/header.jsp"%>
    
            <div class="clear"></div><br><hr>
            
            <div id = "instruction">
                <h5>아이디 찾기</h5>                
            </div>
            <div id = "searchtable">
                <form name = "form1" method = "POST">
                    <table>
                        <tr class="space1">
                            <td class = "inputTitle">이름</td>
                        </tr>
                        <tr>
                            <td class = "inputText"><input type = "text" id = "userName" class = "textInput" name = "userName" placeholder="이름을 입력해 주세요"></td>
                        </tr>
                        <tr  id = "phoneNum" class="space1">
                            <td class = "inputTitle">휴대폰 번호</td>
                        </tr>
                        <tr>
                            <td class = "inputText"><input type = "text" id = "phone" class = "textInput" name = "phone" placeholder="휴대폰 번호를 입력해 주세요"></td>
                        </tr>
                         <c:forEach items="${dto}" var="dto">
                        <tr>			
							<td>당신의 아이디는 ${dto.userID } 입니다</td>
						</tr>
                         </c:forEach>
                    </table>
                    <div id = "submitArea">
                        <div class="searchbtn"><button type = "button" value = "인증하기" id = "CheckID" class = "bu4" onclick = "CheckID">아이디 찾기</button></div>
                    </div>
                </form>
            </div>
            <%@include file="../include/footer.jsp"%>
        </div>
</body>
</html>