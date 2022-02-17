<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문내역</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/ex/resources/css/주문내역상세.css?ver=3">
    
    <script>
    
    function modalOn() {
        modal.style.display = "flex"
    }
    function isModalOn() {
        return modal.style.display === "flex"
    }
    function modalOff() {
        modal.style.display = "none"
    }
    
    $(document).ready(function(){

    	
        //모달창 닫기
        $('.cartCancel').click(function () {

            modalOff();
        });
        
        //모달창 열기
        $('.cartbtn').click(function () {
        	var n = $('.cartbtn').index(this);
            var title = $(this).data("title");
            var price = $(this).data("price");
            var pCode = $(this).attr("data-src");
            
            $("#mpCode").val(pCode);
        	$("#morderCnt").val(1);
        	$(".num").val(1);
            $(".ititle").html(title);
            $(".iprice").html(new Intl.NumberFormat().format(price));
            $(".tprice").html(new Intl.NumberFormat().format(price));
        	
            modalOn();
        });
    	
    	//상품 개수 증가 감소       
        $('.pmbtn').click(function(){
        	 
        	var pmbtn=$(this).data("pmbtn");
             
             if($(".num").val()>1 || pmbtn=="p"){
            	 var num = $(".num").val();
            	 
            	 if(pmbtn=="p"){
    					num = $(".num").val(num * 1 + 1);  //증가
                 } else if(pmbtn=="m"){
                 	num = $(".num").val(num * 1 - 1);  //감소
                 }  
            	 
            	 num = $(".num").val();
                 
                 var textprice=$(".iprice").html();
             	var regex = /[^0-9]/g;
             	var price=parseInt(textprice.replace(regex, ""));   	

                 var count=parseInt(num);
                 $("#morderCnt").val(count);
                 var totalprice=price*count;
                 $(".tprice").html(new Intl.NumberFormat().format(totalprice));
            	 
             }else{
                 alert("최소 수량은 1개입니다.");
             }	
        	
        });
    	
      //장바구니 담기
        $(".cartOk").on("click",function(){			
    		
    		var userID="${sessionScope.userID}";
    		var pCode=$("#mpCode").val();
    		var orderCnt=$("#morderCnt").val();
    		
    		
    		$.ajax({
    			type:'post',
    			url: '/ex/products/pdcart',
    			headers:{
    				"Content-Type":"application/json"
    			},
    			dataType:'text',
    			data:JSON.stringify({
    				userID:userID,
    				pCode:pCode,
    				orderCnt:orderCnt
    			}),
    			success:function(result){
    				
    				if(result=='SUCCESS'){					
    					alert("장바구니에 담겼습니다.");
    					modalOff();
    					
    				}else{
    					alert("이미 장바구니에 담겨있습니다.")
    					modalOff();
    				}
    			}				
    		})
    	});
    	
    });
    
    
   
    
    </script>
    
    
</head>

<body>
    <div id="wrap">
        <%@include file="../include/header.jsp"%>

        <div id="mywrap">
            <%@include file="../include/mykurlymenu.jsp"%>


            <div id="myright">
                <div id="right_header">
                    주문 내역 상세
                </div>
                <div id="rwrap">
                    <div class="rvpyes">
                        <div class="plist">
                            <div class="ordernumber">
                                주문번호 ${orderNum}
                            </div>
                            <div class="orderborder">
                            
                                                  
                                <!-- 반복 -->
								<c:forEach items="${odlist}" var="oddto">
                                <div class="orderlist">
                                    <div class="pimg"><img src="/ex/resources/img/마켓이미지/${oddto.subcategory}/${oddto.pCode}/${oddto.pimg}"></div>
                                    <div class="pinfo">
                                        <div class="ptitle"><a href="/ex/products/pdinfo?pCode=${oddto.pCode}">${oddto.psubject}</a></div>
                                        <div class="psubinfo">                                        
                                            <span class="pprice"><fmt:formatNumber value="${oddto.price*oddto.cnt}" pattern="#,##0"/>원</span>
                                            <span class="pdiv">|</span>
                                            <span class="pcnt">${oddto.cnt}개</span>
                                        </div>
                                    </div>
                                    <div class="pwrite">
                                        <button class="cartbtn" data-src="${oddto.pCode}" data-title="${oddto.psubject}" data-price="${oddto.price}">장바구니 담기</button>
                                    </div>
    
                                </div>
								</c:forEach>
								
                               
                            </div>
                        </div>

                    </div>            

                    
                </div>
            </div>
        </div>
        
        <!-- 모달창 -->
		<div id="modal" class="modal-overlay">
            <div class="modal-window">
                <div class="mptitle"><p class="ititle"></p></div>
                <div class="priceCount">
                    <div class="productprice"><span class="iprice"></span>원</div>
                    <div class="countbtn">
                        <div class="quantityBtn">
                            <button type="button" class="quantity pmbtn bt_down" data-pmbtn="m">-</button>
                            <input type="text" class="quantity num" value="1" readonly="readonly" />
                            <button type="button" class="quantity pmbtn bt_up" data-pmbtn="p">+</button>
                        </div>
                    </div>
                </div>

                <div class="productResult">
                    <div class="total">합계</div>
                    <div class="totalprice"><span class="tprice"></span>원</div>
                </div>
				<input type="hidden" id="mpCode" name="pCode">
				<input type="hidden" id="morderCnt" name="orderCnt">
                <div class="cartBtnGroup">
                    <input type="button" class="cartCancel" value="취소">
                    <input type="button" class="cartOk" value="장바구니 담기">                    
                </div>
              
            </div>
        </div>
        
        <%@include file="../include/footer.jsp"%>

    </div>
</body>

</html>