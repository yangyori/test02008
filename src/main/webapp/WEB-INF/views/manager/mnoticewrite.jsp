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
<link rel="stylesheet" href="/ex/resources/css/관리자공지사항내용작성.css?var=100">

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
    </script>
</head>

<body>
	<div id="wrap">
		<%@include file="../include/header.jsp"%>

		<div id="mywrap">

			<%@include file="../include/managermenu.jsp"%>

			<form action="/ex/manager/mnoticewrite" method="POST">
			<div id="myright">
				<div id="right_header">공지사항 글쓰기</div>
				<div id="rvwrap">
					<div id="rvtablewrap">
						<table id="rvtable">
							<tr>
								<td class="rvtd1" style="height: 50px;">제목</td>
								<td class="rvtd2"><input class="ipt"
									style="width: 610px; height: 25px;" type="text"
									placeholder="제목을 입력해주세요." name="title"></td>
							</tr>
							<tr>
								<td class="rvtd1" style="height: 30px;">작성자</td>
								<td class="rvtd2"><input class="ipt"
									style="width: 610px; height: 25px;" type="text" 
									name="manager" value="admin" readonly="readonly"></td>
							</tr>
							<tr>
								<td class="rvtd1" style="height: 250px;">내용</td>
								<td class="rvtd2"><textarea name="contents" id="ipta"
										style="width: 610px; height: 225px;"></textarea>
								</td>
							</tr>
						</table>
					</div>
					<div id="rvbtns">
						<button type="submit">등록하기</button>
					</div>
				</div>
			</div>
			</form>
		</div>
		<%@include file="../include/footer.jsp"%>


	</div>


</body>

</html>