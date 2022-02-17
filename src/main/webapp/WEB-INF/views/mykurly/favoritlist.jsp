<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찜한 상품</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/ex/resources/css/찜한상품.css?var=5">

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
	//찜상품 삭제
    $(".delbtn").on("click", function(event){
    	
			var that = $(this);
			var fNum = $(this).attr("data-src");

			$.ajax({
			type:'delete',
			url: '/ex/mykurly/favoritlist/'+fNum,
			headers:{
				"Content-Type":"application/json"
			},
			dataType:'text',
			success:function(result){					
				if(result=='SUCCESS'){
					alert("찜목록에서 삭제되었습니다.");
					that.closest(".plist").remove();
					document.location.reload();
				}
			}				
		})
	});
    
    //모달창 닫기
    $('.cartCancel').click(function () {

        modalOff();
    });
    
    //모달창 열기
    $('.likecartbtn').click(function () {
    	var n = $('.likecartbtn').index(this);
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
		
		//alert(userID+"::"+pCode+"::"+orderCnt);
		
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
					//getPageList(page);
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
				<div id="right_header">찜한 상품(${count})</div>
				<div id="rwrap">
					<div class="rvpyes">
					
						<c:choose>
							<c:when test="${count > 0}">
								<c:forEach items="${favoritlist}" var="favoritdto">
									<div class="plist">
										<div class="orderborder">
											<div class="orderlist">
												<div class="pimg">
													<a href="/ex/products/pdinfo?pCode=${favoritdto.pCode}"><img src="/ex/resources/img/마켓이미지/${favoritdto.subcategory}/${favoritdto.pCode}/${favoritdto.pimg}"></a>
												</div>
												<div class="pinfo">												
													<div class="ptitle"><a href="/ex/products/pdinfo?pCode=${favoritdto.pCode}">${favoritdto.psubject}</a></div>
													<div class="pcnt"><a href="/ex/products/pdinfo?pCode=${favoritdto.pCode}"><span><fmt:formatNumber value="${favoritdto.price}" pattern="#,##0"/></span>원</a></div>
												</div>
												<div class="pwrite">
													<button class="delbtn" data-src="${favoritdto.fNum}">삭제</button>
													<button class="likecartbtn" data-src="${favoritdto.pCode}" data-title="${favoritdto.psubject}" data-price="${favoritdto.price}">담기</button>
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<!-- like No-->
								<div class="content-main01">
									<div>
										<img src="/ex/resources/img/아이콘/하트아이콘.svg">
									</div>
									<div>
										<span class="content-span">찜한 상품이 없습니다.</span>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
		<div class="clear"></div>
		
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