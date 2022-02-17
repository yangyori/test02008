<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송지 등록</title>
<link rel="stylesheet" href="/ex/resources/css/deliveryPopup.css?ver=2">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>

        function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                
                var addr = ''; 
                var extraAddr = ''; 
              
                if (data.userSelectedType === 'R') { 
                    addr = data.roadAddress;
                } else { 
                    addr = data.jibunAddress;
                }

                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
             
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
            
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }                 
         
                document.getElementById("sample6_address").value = addr;
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
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
	    					location.href = '/ex/products/deliveryCartPop';
	    				}
	    			}) 
              	}
        	})
        	
        })
        

   </script>
</head>

<body>
    <div id="delivery_head">
        <div id="delivery_title">배송정보</div>        
    </div>
    <div id="btnaddress">          
        <input id="sbtn" type="button" onclick="sample6_execDaumPostcode()" value="주소 찾기">
    </div>

    <div id="delivery_contents">        
        <div>
            <span>주소</span><br>
            <input name="addr1" type="text" id="sample6_address" placeholder="주소">
        </div>
        <div>
            <span>상세주소</span><br>
            <input name="addr2" type="text" id="sample6_detailAddress" placeholder="상세주소">
        </div>
        <div>
            <span>받으실 분</span><br>
            <input name="recipient" type="text" id="cuserName" placeholder="이름을 입력해 주세요">
        </div>
        <div>
            <span>휴대폰</span><br>
            <input name="phoneNum" type="text" id="cphoneNum" placeholder="숫자만 입력해주세요">
        </div>
        <input type="hidden" name="basicAdd">
    </div>
    <div id="delivery_bottom">
        <input id="dbtn1" type="button" value="취소" onclick="window.close()">
        <input id="dbtn2" type="button" value="저장" >
    </div>
</body>

</html>