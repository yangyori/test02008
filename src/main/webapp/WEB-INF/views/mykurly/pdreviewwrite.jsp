<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 후기 작성</title>
<link
	href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined"
	rel="stylesheet">
<link
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="/ex/resources/css/후기작성.css?ver=1">

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

		function reviewWrite(){
			
			var f=document.writeForm;
			var title= document.getElementsByName("title")[0].value;
			var contents=document.getElementsByName("contents")[0].value;
			if(title=="" || contents==""){
				alert("비어있는 내용을 입력하세요!")
			}else{
				f.action="/ex/mykurly/pdreviewwrite";
				f.submit();
			}
			//
		}
    </script>
</head>

<body>
	<div id="wrap">
		<%@include file="../include/header.jsp"%>

		<div id="mywrap">

			<%@include file="../include/mykurlymenu.jsp"%>

			<form name="writeForm" method="POST">
			<div id="myright">
				<div id="right_header">후기작성</div>
				<div id="rvwrap">
					<div id="rvsubject">${pdto.psubject}</div>
					<input type="hidden" name="pCode" value="${pdto.pCode}">
					<div id="rvtablewrap">
						<table id="rvtable">
							<tr>
								<td class="rvtd1" style="height: 50px;">제목</td>
								<td class="rvtd2"><input class="ipt"
									style="width: 610px; height: 25px;" type="text"
									placeholder="제목을 입력해주세요." id="title" name="title"></td>
							</tr>
							<tr>
								<td class="rvtd1" style="height: 250px;">후기작성</td>
								<td class="rvtd2"><textarea name="contents" class="" id="ipta"
										style="width: 610px; height: 225px;" type=""
										placeholder="자세한 후기는 다른 고객의 구매에 많은 도움이 되며,&#13;&#10;일반식품의 효능이나 효과 등에 오해의 소지가 있는 내용을 작성 시 검토 후 비공개 조치될 수 있습니다.&#13;&#10;반품/환불 문의는 1:1문의로 가능합니다."></textarea>
								</td>
							</tr>
						</table>
					</div>
					<div id="rvbtns">
						<input type="button" onclick="reviewWrite()" value="등록하기">
					</div>
				</div>
			</div>
			</form>
		</div>
		<%@include file="../include/footer.jsp"%>


	</div>


</body>

</html>