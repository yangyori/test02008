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
    <title>개인 정보 수정</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://code.jquery.com/jquery-2.2.4.min.js" ></script>
    <link rel="stylesheet" href="/ex/resources/css/userUpdate.css">

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

        function sample6_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                        var addr = ''; // 주소 변수
                        var extraAddr = ''; // 참고항목 변수
                        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                        } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }
                        // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById("sample6_address").value = addr;
                        // 커서를 상세주소 필드로 이동한다.
                    document.getElementById("sample6_detailAddress").focus();
                }
            }).open();
        }
    </script>
    <script>
    $(function(){
    	$("#userUpdate").click(function(){
    		var password1 = $("#password1").val();
    		var password2 = $("#password2").val();
    		var userName = $("#userName").val();
    		var email = $("#email").val();
    		var phone = $("#phone").val();
    		var birth = $("#birth").val();
    		if(userID == ""){
    			alert("아이디를 입력해주세요.");
    			$("#userID").focus();
    			return;
    		} else if(!/^[a-zA-Z0-9!@#$%^&*()?_~]{6,20}$/.test(password1)){
    			alert("비밀번호는 영문, 숫자, 특수문자 조합으로 6~20 자리를 사용해야 합니다.");
    			return false;
    		} else if(password1 == ""){
    			alert("비밀번호를 입력해주세요.");
    			$("#password1").focus();
    			return;
    		} else if(password2 == ""){
    			alert("비밀번호 확인을 입력해주세요.");
    			$("#password2").focus();
    			return;
    		} else if(userName == ""){
    			alert("이름을 입력해주세요.");
    			$("#userName").focus();
    			return;
    		} else if(email == ""){
    			alert("이메일을 입력해주세요.");
    			$("#email").focus();
    			return;
    		} else if(phone == ""){
    			alert("핸드폰 번호를 입력해주세요.");
    			$("#phone").focus();
    			return;
    		} else if(birth == ""){
    			alert("생년월일을 입력해주세요.");
    			$("#birth").focus();
    			return;
    		}
    		document.form1.action = "${path}/ex/member/userUpdate";
    		document.form1.submit();
    	});
    });
    </script>
    <script>
    function checkCurrentPassword(){
        $.ajax({
            url : "/ex/member/reCheck",
            type : "post",
            dataType : "json",
            data : {"password1" : $("#pwd").val(),
         	   "userID" : $("#userID").val()},
            success : function(data){
                if(data==0){
                	alert("비밀번호가 일치하지 않습니다.");
                }
            }
        })
}
    </script>
</head>
<body>
	
    <div id="wrap">
		<%@include file="../include/header.jsp"%>

        <div class="clear"></div>
	
        <form method = "POST" name = "form1">
        <input type = "hidden" name = "${_csrf.parameterName}" value = "${_csrf.token}">
        <div class = "jcontainer">
            <div class = "insert">
                <table>
                    <caption><h2>개인정보수정</h2></caption>
                    <tr>
                        <td class="col1">아이디</td>
                        <td class="col2">
                            <input type="text" id = "userID" name= "userID" maxlength="10" value = "${userID}" readonly />
                        </td>
                    </tr>
                    <tr>
                        <td class="col1">현재 비밀번호</td>
                        <td class="col2"><input type="password" name = "password1" id = "pwd"  maxlength="16" onblur = "checkCurrentPassword()">
                        	
                        <c:if test = "${message == 'pwSuccess'}">
                        <p><span class="num">* 비밀번호가 일치합니다.</span></p>
                        </c:if>
                        </td>
                    </tr>
                    <tr>
                        <td class = "col1">새 비밀번호</td>
                        <td class = "col2">
                            <input type = "password" id = "password1" name="password1" maxlength="16">
                            <p>※비밀번호는 <span class="num">문자, 숫자, 특수문자(~!@#$%^&*)의 조합
                                10 ~ 16자리</span>로 입력이 가능합니다.</p>
                        </td>
                    </tr>
                    <tr>
                        <td class="col1">새 비밀번호 확인</td>
                        <td class="col2"><input type="password" id = "password2" name="password2" maxlength="16"></td>
                    </tr>
                    <tr>
                        <td class="col1">이름</td>
                        <td class="col2"><input type="text" id = "userName" name="userName" value="${mdto.userName}" maxlength="5"></td>
                        
                    </tr>
                    <tr>
                        <td class="col1">이메일</td>
                        <td class="col2">
                            <input type="text" id = "email" name="email" value="${mdto.email}">
                        </td>
                    </tr>
                    <tr>
                        <td class="col1">휴대폰</td>
                        <td class="col2"><input type="text" id = "phone" name="phone" maxlength="20" value="${mdto.phone}"></td>
                    </tr>
               
                    <tr>
                        <td class="col1">성별</td>
                        <td class="col2">
                        <c:choose>
                        <c:when test="${mdto.gender eq 'g1'}">
                            <select name="gender" class = "select">
                                <option value="slc1">선택</option>
                                <option value="g1" selected>남자</option>
                                <option value="g2">여자</option>
                            </select>
                        </c:when>
                        <c:otherwise>
                        	<select name="gender" class = "select">
                                <option value="slc1" selected>선택</option>
                                <option value="g1">남자</option>
                                <option value="g2" selected>여자</option>
                            </select>
                        </c:otherwise>                            
                        </c:choose>
                        </td>
                    </tr>

                    <tr>
                        <td class = "col1">생년월일</td>
                        <td class = "col2">
                            <input type = "text" name="birth" id = "birth" placeholder = "YYMMDD" value="${mdto.birth}">&nbsp;<span>ex) 220214</span>
                        </td> 
                    </tr>
                </table>
            </div>
            <div class="create">
                <button class="but4" type="button" value="회원수정" id = "userUpdate">회원정보수정</button>
                <button class="but3" type="button" value="회원탈퇴" onclick = "location.href='/ex/member/userDelete'" id = "userDelete">탈퇴하기</button>
            </div>
        </div>
        </form>
        <%@include file="../include/footer.jsp"%>
    </div>
</body>
</html>