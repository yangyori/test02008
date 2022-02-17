<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link rel="stylesheet" href="/ex/resources/css/장바구니.css?ver=0">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script>
    	var openWin;
    	//배송지변경
	    function deliveryCartUpdate() {
	    	window.name = "parentForm";
            openWin = window.open("/ex/products/deliveryCartPop",
                    "childForm", "width=560, height=600, resizable = no, scrollbars = no");    
	    }
               
        $(document).ready(function(){
        	
        	//장바구니 삭제
            $(".delbtn").on("click", function(event){
	   			var that = $(this);
	   			var bkNum = $(this).attr("data-src");

	   			$.ajax({
					type:'delete',
					url: '/ex/products/pdcart/'+bkNum,
					headers:{
						"Content-Type":"application/json"
					},
					dataType:'text',
					success:function(result){					
						if(result=='SUCCESS'){						
							alert("장바구니에서 삭제되었습니다.");
							location.reload();
						}
					}				
				})
   			});
            

            //장바구니 상품 개수 증가 감소
 			 $('.pmbtn').click(function(){
 				var n=$(this).data("index");
 				
 				var pmbtn=$(this).data("pmbtn");
                
                if($(".num:eq(" + n + ")").val()>1 || pmbtn=="p"){         
	                
	                var num = $(".num:eq(" + n + ")").val();
	
					if(pmbtn=="p"){
						num = $(".num:eq(" + n + ")").val(num * 1 + 1);  //증가
	                } else if(pmbtn=="m"){
	                	num = $(".num:eq(" + n + ")").val(num * 1 - 1);  //감소
	                }        	               
	          	                
	                //증가후 현재 값
	                orderCnt = parseInt($(".num:eq(" + n + ")").val());                            
	                
	                var that = $(this);
		   			var bkNum = $(this).attr("data-src");
		   			price = $(this).data("price");			   			
		   				   			
		   			var totalprice=orderCnt*price;		   			 			
		   	
		   			$.ajax({
						type : 'put',
						url : '/ex/products/pdcart/' + bkNum,
						headers : {
							"Content-Type" : "application/json"
						},
						dataType : 'text',
						data : JSON.stringify({
							orderCnt : orderCnt
						}),
						success : function(result) {
							$(".totalprice:eq("+n+")").html(new Intl.NumberFormat().format(totalprice));

						}
					})
					
					if($("input[name=chkproduct]:eq("+n+")").is(":checked") == true ){
	                	textprice=$(".totalpay:eq(0)").html();
	                	regex = /[^0-9]/g;
	 		        	totalpay=parseInt(textprice.replace(regex, ""));
	 		        	if(pmbtn=="p"){
	 		        		result=totalpay+price;
	 		        	}else if(pmbtn=="m"){
	 		        		result=totalpay-price;
	 		        	}
	 		        	$(".totalpay").html(new Intl.NumberFormat().format(result));
	                }
                }else{
                    alert("최소 수량은 1개입니다.");
                }				
                
                
             
            });    
          	

        	//장바구니 가격
	     	$("input[name=chkproduct]").change(function(){
	     		 
	     		   var n = $('input[name=chkproduct]').index(this);
	     		  	textprice1=$(".totalprice:eq("+n+")").html(); //totalprice
		        	textprice2=$(".totalpay:eq(0)").html(); //totalpay
		        	regex = /[^0-9]/g;
		        	price=parseInt(textprice1.replace(regex, ""));
		        	total=parseInt(textprice2.replace(regex, ""));
	     		
	 		       if( $(this).is(":checked") == true ){
	 		        	resultprice=total+price;
	 		        
	 		       }else if( $(this).is(":checked") == false ){
	 		        	
	 		        	resultprice=total-price;
	 		 
	 		       }
	 		      $(".totalpay").html(new Intl.NumberFormat().format(resultprice));
	 		    
	 		     
	     	})
	     	
	    	
	    	//전체체크
	    	$("#cbx_chkAll").click(function() {
				if($("#cbx_chkAll").is(":checked")){
                    $("input[name=chkproduct]").prop("checked", true);
                    total=0;
                    $(".totalprice").each(function(index){                    	
                    	textprice=$(".totalprice:eq("+index+")").html();
                    	regex = /[^0-9]/g;
                    	price=parseInt(textprice.replace(regex, ""));
                    	total+=price;
					})
					$(".totalpay").html(new Intl.NumberFormat().format(total));
                    
                }else{
                    $("input[name=chkproduct]").prop("checked", false);
                    $(".totalpay").html(new Intl.NumberFormat().format(0));
                    
                } 
			});
			
	    	//전체체크 안되어 있을때 풀림
			$("input[name=chkproduct]").click(function() {
				var total = $("input[name=chkproduct]").length;
				var checked = $("input[name=chkproduct]:checked").length;
				
				if(total != checked){
                     $("#cbx_chkAll").prop("checked", false);
                }else{
                     $("#cbx_chkAll").prop("checked", true); 
                }
							
			});          	
        })
        
        function order(){
        	
        	totalpay=$(".totalpay:eq(0)").html();
        	
        	if(totalpay==0){
        		alert("주문 할 상품을 선택해주세요.")
        	}else{
        		f=document.cartForm;
            	f.action="/ex/products/pdpayment";
            	f.submit();
        	}   
        }
    </script>
</head>
<body>
	<div id="wrap">
		<%@include file="../include/header.jsp"%>
		<div id="headertitle">장바구니</div>
		
		<form name="cartForm" method="POST">
		<div id="article">
			<div id="article_left">
				<div id="a_l_table">
					<div id="a_l_t_div1">
						<ul id="select_ul">
							<li><input type="checkbox" id=cbx_chkAll></li>
							<li>전체선택</li>
						</ul>
					</div>
					<div class="clear"></div>
					
					<c:choose>
					<c:when test="${empty bklist}">
					<div class="pdt">
						<p>현재 장바구니에 담긴 상품이 없습니다.</p>
					</div>
					<div class="clear"></div>
					</c:when>
					<c:otherwise>
					<!-- 반복 -->
					<c:forEach items="${bklist}" var="bdto" varStatus="status">
					<div class="pdt">
						<ul class="pdt_ul">
							<li><input type="checkbox" name="chkproduct" value="${bdto.bkNum}"></li>
							<li><img src="/ex/resources/img/마켓이미지/${bdto.subcategory}/${bdto.pCode }/${bdto.pimg}" class="tb_img"></li>
							<li style="width: 300px;">${bdto.psubject}</li>
							<li style="width: 100px;">
								<div class="quantityBtn">
									<button type="button" class="quantity pmbtn" data-index="${status.index}" data-price="${bdto.price}" data-pmbtn="m" data-src="${bdto.bkNum}">-</button>
									<input type="text" value="${bdto.orderCnt}" data-count="${bdto.orderCnt}" class="quantity num" readonly="readonly" />
									<button type="button" class="quantity pmbtn" data-index="${status.index}" data-price="${bdto.price}" data-pmbtn="p" data-src="${bdto.bkNum}">+</button>
								</div>
							</li>
							<li style="width: 110px;"><span name="totalprice" class="totalprice"><fmt:formatNumber value="${bdto.orderCnt*bdto.price}" pattern="#,##0"/></span>원</li>
							<li class="delbtn" data-src="${bdto.bkNum}">x</li>
						</ul>
					</div>
					<div class="clear"></div>
					</c:forEach>
					<!-- 반복 -->
					</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div id="article_right">
				<div id="a_r_table">
					<div id="a_r_t_div1" class="order_top">
						<span class="material-icons"> location_on </span> 배송지<br> ${ddto.addr1} ${ddto.addr2}<br>
						일반배송<br>
						<div id="deliveryBtn" onclick="deliveryCartUpdate()">배송지 변경</div>
					</div>
					<div id="a_r_t_div2" class="order_top">
						<div id="order_mid1" class="order_middle">
							상품금액
							<p><span class="totalpay">0</span>원</p>
						</div>
						<div class="order_middle">
							상품할인금액
							<p>0원</p>
						</div>
						<div id="order_mid3" class="order_middle">
							배송비
							<p>0원</p>
						</div>
						<div id="order_bot">
							결제예정금액
							<p id="total_p"><span class="totalpay">0</span>원</p>
						</div>
					</div>
					<div><input type="button" onclick="order()" id="orderBtn" value="주문하기"></div>
					
				</div>
			</div>
		</div>
		</form>
		<%@include file="../include/footer.jsp"%>
	</div>
</body>
</html>