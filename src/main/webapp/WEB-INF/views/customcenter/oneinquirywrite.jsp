<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1문의 작성</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/ex/resources/css/1대1문의 글쓰기.css?ver=1">
    
    <script>
    	function oneWrite(){
    		var f=document.writeForm;
			var title= document.getElementsByName("title")[0].value;
			var contents=document.getElementsByName("contents")[0].value;
			if(title=="" || contents==""){
				alert("비어있는 내용을 입력하세요!")
			}else{
				f.action="/ex/customcenter/oneinquirywrite";
				f.submit();
			}
    	}
    
    </script>
</head>

<body>
	<div id="wrap">
		<%@include file="../include/header.jsp"%>
		<div id="customwrap">
			<%@include file="../include/customcentermenu.jsp"%>
			
			<form name="writeForm" method="post">
			<div id="cright">
				<div id="cright_header">1:1문의</div>
				<div id="cright_middle">
					<table id="cright_middle_table">
						<tr>
							<th>제목</th>
							<td><select name="category" id="category" class="selectBtn">
									<option disabled selected>선택해주세요.</option>
									<option value="배송지연/불만">배송지연/불만</option>
									<option value="반품문의">반품문의</option>
									<option value="A/S문의">A/S문의</option>
									<option value="환불문의">환불문의</option>
							</select><br> <input type="text" style="width: 630px;"
								class="input_20px" name="title" id="title"></td>
						</tr>
						<tr>
							<th>사용자</th>
							<td><input type="text" value="${sessionScope.userID}" readonly
								class="input_20px" name="userID">
						</tr>
						<tr>
							<th>내용</th>
							<td>
								<p>1:1 문의 작성 전 확인해주세요!</p> <br>
								<p>반품/ 환불</p> - 제품 하자 혹은 이상으로 반품(환불)이 필요한 경우 사진과 함께 구체적인 내용을
								남겨주세요.<br> <br>
								<p>주문취소</p> - 배송 단계별로 주문취소 방법이 상이합니다.<br>
								&nbsp;&nbsp;[입금확인]단계: [마이컬리>주문내역 상세페이지]에서 직접 취소 가능<br>
								&nbsp;&nbsp;[입금확인]이후 단계: 고객행복센터로 문의<br> <br> - 생산이 시작된
								[상품 준비중] 이후에는 취소가 제한되는 점 고객님의 양해 부탁드립니다.<br> - 일부 예약상품은 배송
								3~4일 전에만 취소가 가능합니다.<br> - 주문 상품의 부분 취소는 불가능합니다. 전체 주문 취소 후
								재구매 해주세요.<br> <br> <span>※ 전화번호, 이메일, 주소, 계좌번호
									등의 상세 개인정보가 들어가지 않도록 주의해 주시기 바랍니다.</span><br><br> 
								<textarea id="context_box" name="contents" placeholder="내용을 입력하세요..."></textarea>
							</td>
						</tr>
					</table>
				</div>
				<div id="cright_footer">
					<input type="button" onclick="oneWrite()" id="storeBtn" value="저장">
				</div>
			</div>
			</form>
		</div>
		<%@include file="../include/footer.jsp"%>
	</div>
</body>
</html>