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
    <title>회원가입</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://code.jquery.com/jquery-2.2.4.min.js" ></script>
    <script language="javascript" src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="/ex/resources/css/join.css">

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

        function fn_idChk(){
            $.ajax({
                url : "/ex/member/idChk",
                type : "post",
                dataType : "json",
                data : {"userID" : $("#userID").val()},
                success : function(data){
                    if(data == 1){
                        alert("중복된 아이디입니다.");
                    } else if(data == 0){
                        $("#idChk").attr("value", "Y");
                        alert("사용가능한 아이디입니다.");
                    }
                }
            })
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
        
        $(function(){
        	$("#btnJoin").click(function(){
        		var userID = $("#userID").val();
        		var password1 = $("#password1").val();
        		var password2 = $("#password2").val();
        		var userName = $("#userName").val();
        		var email = $("#email").val();
        		var phone = $("#phone").val();
        		var sample6_address = $("#sample6_address").val();
        		var sample6_detailAddress = $("#sample6_detailAddress").val();
        		var birth = $("#birth").val();
        		if(userID == ""){
        			alert("아이디를 입력해주세요.");
        			$("#userID").focus();
        			return false;
        		} else if(!/^[a-zA-Z0-9!@#$%^&*()?_~]{6,20}$/.test(password1)){
        			alert("비밀번호는 영문, 숫자, 특수문자 조합으로 6~20 자리를 사용해야 합니다.");
        			return false;
        		} else if(password1 == ""){
        			alert("비밀번호를 입력해주세요.");
        			$("#password1").focus();
        			return false;
        		} else if(password1 != password2) {
        			alert("비밀번호가 일치하지 않습니다.");
        			return false;
        		} else if(password2 == ""){
        			alert("비밀번호 확인을 입력해주세요.");
        			$("#password2").focus();
        			return false;
        		} else if(userName == ""){
        			alert("이름을 입력해주세요.");
        			$("#userName").focus();
        			return false;
        		} else if(email == ""){
        			alert("이메일을 입력해주세요.");
        			$("#email").focus();
        			return false;
        		} else if(phone == ""){
        			alert("핸드폰 번호를 입력해주세요.");
        			$("#phone").focus();
        			return false;
        		} else if(sample6_address == ""){
        			alert("주소를 입력해주세요.");
        			return false;
        		} else if(sample6_detailAddress == ""){
        			alert("상세주소를 입력해주세요.");
        			return false;
        		} else if(birth == ""){
        			alert("생년월일을 입력해주세요.");
        			$("#birth").focus();
        			return false;
        		}
        		document.form1.action = "${path}/ex/member/join";
        		document.form1.submit();
        	});
        });
    </script>
    <script>
    	function loginLoca(){
    		self.location = "/ex/";
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
                    <caption><h2>회원가입</h2></caption>
                    <tr>
                        <td class="col1">아이디</td>
                        <td class="col2">
                            <input type="text" id = "userID" name="userID" maxlength="10" />
                            <button type="button" value="N" id = "idChk" onclick="fn_idChk()">중복확인</button>
                        </td>
                    </tr>
                    <tr>
                        <td class = "col1">비밀번호</td>
                        <td class = "col2">
                            <input type = "password" id = "password1" name = "password1" maxlength="16">
                            <p><span class="num">비밀번호는 영문, 숫자, 특수문자 조합으로 6~20 자리를 사용해야 합니다.</p>
                        </td>
                    </tr>
                    <tr>
                        <td class="col1">비밀번호 확인</td>
                        <td class="col2"><input type="password" id = "password2" name="password2" maxlength="16"></td>
                    </tr>
                    <tr>
                        <td class="col1">이름</td>
                        <td class="col2"><input type="text" id = "userName" name="userName" maxlength="5"></td>
                    </tr>
                    <tr>
                        <td class="col1">이메일</td>
                        <td class="col2">
                            <input type="text" id = "email" name="email">
                        </td>
                    </tr>
                    <tr>
                        <td class="col1">휴대폰</td>
                        <td class="col2"><input type="text" id = "phone" name="phone" maxlength="20"></td>
                    </tr>
                    <tr>
                        <td class = "col1">주소찾기</td>
                        <td class = "col2">
                            <input type = "button" id = "seasrchAddr" onclick = "sample6_execDaumPostcode()" value = "우편번호 찾기"><br>
                    </td>
                    </tr>
                    <tr>
                        <td class = "col1">상세주소</td>
                        <td class = "col2">
                        <input type = "text" name = "addr1" id = "sample6_address" placeholder="주소"><br>
                        <input type = "text" name = "addr2" id = "sample6_detailAddress" placeholder="상세주소">

                    </td>
                    </tr>
                    <tr>
                    <td class="col1">성별</td>
                    <td class="col2"><select name="gender" class = "select">
                        <option value="slc1" selected>선택</option>
                        <option value="g1">남자</option>
                        <option value="g2">여자</option>
                    </select>
                    </td>
                    </tr>
                    <tr>
                        <td class = "col1">생년월일</td>
                    <td class = "col2">
                        <input type = "text" id = "birth" name = "birth" placeholder = "YYMMDD">&nbsp;<span>ex) 220214</span>
                    </td> 
                    </tr>
                </table>
            </div>
            <div class="create">
                <button class="but3" type= "button" value="가입취소" onclick="loginLoca()">가입취소</button>
                <button class="but4" type= "button" value="회원가입" id = "btnJoin">회원가입</button>
            </div>
        </div>
        </form>
        
        <%@include file="../include/footer.jsp"%>
    </div>
</body>
</html>