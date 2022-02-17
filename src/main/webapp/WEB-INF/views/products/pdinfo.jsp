<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품상세설명</title>
<link
	href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined"
	rel="stylesheet">
<link
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="/ex/resources/css/productinfo.css?var=71">

<script>
	$(document).ready(function() {

		const acoAco = $('.article_middle_ul2');

		acoAco.on('click', function() {
			const item = $(this);
			var m=$('.article_middle_ul2').index(this);
			
			acoAco.parent().find('.article_middle_ul3').stop().slideUp(0);

			if (item.hasClass('active')) {
				item.find('.article_middle_ul3').stop().slideUp(0);
				item.removeClass('active');
			} else {
				item.parent().find('.article_middle_ul3').stop().slideDown(0);
				acoAco.removeClass('active');
				item.addClass('active');

				var rNum=$(this).attr("data-src");
				var cnt=parseInt($(".cnt:eq("+m+")").html());
				//조회수 증가
				$.ajax({
					type:'put',
					url: '/ex/products/previewCnt/'+rNum,
					headers:{
						"Content-Type":"application/json"
					},
					dataType:'text',
					data:JSON.stringify({
					}),
					success:function(result){
						if(result=='SUCCESS'){
							$(".cnt:eq("+m+")").html(cnt+1);
						}
					}				
				})
				
			}

		})

		const acoAco1 = $('.acoclick');

		acoAco1.on('click', function() {
			const item = $(this);

			acoAco1.parent().find('.text_box').stop().slideUp(0);

			if (item.hasClass('active')) {
				item.find('.text_box').stop().slideUp(0);
				item.removeClass('active');
			} else {
				item.parent().find('.text_box').stop().slideDown(0);
				acoAco1.removeClass('active');
				item.addClass('active');
			}

		})

  		//장바구니 담기
		$("#cartbtn").on("click",function(){			
		
			var userID="${sessionScope.userID}";
			var pCode=${pdto.pCode};
			var orderCnt = parseInt(document.getElementById("result").innerText);
			
			
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
						
					}else{
						alert("이미 장바구니에 담겨있습니다.")
					}
				}				
			})
		});
  		
		//찜
		$("#fav_yes").on("click",function(){
			
			var pCode=${pdto.pCode};
			var userID="${sessionScope.userID}";
			
			$.ajax({
				type:'post',
				url: '/ex/mykurly/favoritlist',
				headers:{
					"Content-Type":"application/json"
				},
				dataType:'text',
				data:JSON.stringify({
					pCode:pCode,
					userID:userID
				}),
				success:function(result){
					if(result=='SUCCESS'){
						alert("찜 목록에 담겼습니다.");
						document.location.reload();
					}
				}				
			})
		});
		
	    //후기쓰기
		$("#writeBtn").on("click", function(){
			
			var pCode=${pdto.pCode};
			
			//주문해야 후기 쓸수 있게 확인작업
			$.ajax({
				type:'post',
				url: '/ex/products/preview/'+pCode,
				headers:{
					"Content-Type":"application/json"
				},
				dataType:'text',
				success:function(result){
					
					if(result=='SUCCESS'){						
						alert("주문 후에 후기를 작성 할 수 있습니다.");						
					}else{
						location.href = '/ex/mykurly/pdreview';
					}
				}				
			})
			
		});
		  
		
		$(".replyBtn").on("click",function(){
	    	var	qNum=$("#qNumber").val();
	    	var replytext=$("#newReplyText").val();
			var replyer=$("#newReplyeWriter").val();	//사용자 입력값을 불러올때 value를 씀
			
			$.ajax({
				type:'post',
				url:'/ex/products/replies',
				headers:{
					"Content-Type":"application/json"
				},
				dataType:'text',
				data:JSON.stringify({
					qNum:qNum,
					replyText:replytext,
					replyer:replyer
				}),
				success: function(result){
					if(result == 'SUCCESS'){
						alert("등록 되었습니다.")
						document.location.reload();
					}
				}
			})
		});
		
		$(window).scroll(function(){
			if ($(this).scrollTop() > 200 ){
				$('.top').fadeIn();
			}else{
				$('.top').fadeOut();
			}
		});
			
		$('.top').click(function(){
			$('html, body').animate({ scrollTop : 0 }, 400);
			return false;
		});
		
	});
	  
	function modalOn(a) {
		modal = "modal" + a;
		modal = document.getElementById("modal" + a);
		modal.style.display = "flex"

	}

	function modalOff(a) {
		modal = "modal" + a;
		modal = document.getElementById("modal" + a);
		modal.style.display = "none"
	}

	function count(type) {
		const result = document.getElementById('result');
		const totalprice = document.getElementById('totalprice');
		var number = result.innerText;

		if (type == "plus") {
			number = parseInt(number) + 1;
		} else if (type == "minus") {
			if (number > 1) {
				number = parseInt(number) - 1;
			} else {
				number = 1;
				alert("최소 수량은 1개입니다.");
			}
		}
		result.innerText = number;
		
		var totalp=number*${pdto.price};
		
		totalprice.innerText = new Intl.NumberFormat().format(totalp);
	}

	function tabcolor(evt) {
		var i, tabcolor;

		tabcolor = document.getElementsByClassName("tabcolor");

		for (i = 0; i < tabcolor.length; i++) {
			tabcolor[i].className = tabcolor[i].className.replace(" tactive","");
		}

		evt.currentTarget.className += " tactive";
	}
	  
     function notlongin(){
     	alert("로그인하셔야 서비스를 이용하실 수 있습니다.");
     	self.location ="/ex/member/login";
     }
</script>
</head>

<body>
	<div id="wrap">
		<%@include file="../include/header.jsp"%>
		<!--product 정보 -->
		<div id="pdinfowrap">
			<div id="pmain_left">
				<div id="leftimg">
					<!--  <img src="/ex/resources/img/상품/당근.PNG"> -->
					<img src="/ex/resources/img/마켓이미지/${pdto.subcategory}/${pdto.pCode }/${pdto.pimg}">
					
				</div>
			</div>

			<div id="pmain_right">
				<div id="info">
					<table id="infotable">
						<tr>
							<td id="ptitle" colspan="2">${pdto.psubject}</td>
						</tr>
						<tr>
							<td id="pprice" colspan="2"><fmt:formatNumber value="${pdto.price}" pattern="#,#00"/>원</td>
						</tr>
						<tr>
							<td class="ptd1">판매단위 </td>
							<td class="ptd2">${pdto.unit}</td>
						</tr>
						<tr>
							<td class="ptd1">원산지</td>
							<td class="ptd2">${pdto.origin}</td>
						</tr>
						<tr>
							<td class="ptd1">유통기한</td>
							<td class="ptd2">${pdto.shelfLife} </td>
						</tr>
						<tr>
							<td class="ptd1">구매수량</td>
							<td>
								<div id="quantityBtn">
									<button class="quantity" onclick='count("minus")'>-</button>
									<div id="result" class="quantity">1</div>
									<button class="quantity" onclick='count("plus")'>+</button>
								</div>
							</td>
						</tr>
					</table>

					<div id="total">
						총 상품금액:						
						<div id="totalprice"><fmt:formatNumber value="${pdto.price}" pattern="#,#00"/></div>
						원
					</div>
					<div id="fcbtns">
					<c:choose>
					<c:when test="${not empty sessionScope.userID}">
						<button id="cartbtn" class="cartbtns">장바구니 담기</button>
						<c:choose>
							<c:when test="${fdto.pCode == pdto.pCode}">
								<div class="favDiv" id="fav_no">♥</div>
							</c:when>
							<c:otherwise>
								<div class="favDiv" id="fav_yes">♡</div>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<button class="cartbtns" onclick="notlongin()">장바구니 담기</button>
						<div style="cursor: pointer;" onclick="notlongin()" class="favDiv">♡</div>				
					</c:otherwise>
					</c:choose>
					</div>
				</div>
			</div>
		</div>
		<div class="clear"></div>

		<!--product tab -->
		<div id="proinfotab">
			<ul id="titletab">
				<li class="tabcolor tactive" onclick="tabcolor(event)"><a
					href="#productexplain">상품설명</a></li>
				<li class="tabcolor" onclick="tabcolor(event)"><a
					href="#detailinfo">상세정보</a></li>
				<li class="tabcolor" onclick="tabcolor(event)"><a
					href="#reviewwrap">후기</a></li>
				<li class="tabcolor" onclick="tabcolor(event)"><a
					href="#qnawrap">문의</a></li>
			</ul>
		</div>

		<div class="clear"></div>

		<!-- 상품설명 -->
		<div id="productexplain">
		
			<!-- 반복문  구역 -->
			<c:forEach items="${pExImg }" var="pdto">
			<img src="/ex/resources/img/마켓이미지/${pdto.subcategory}/${pdto.pCode}/${pdto.explainimg}">
			</c:forEach>
			<!-- 반복문  구역 -->
			
		</div>


		<div class="clear"></div>

		<!-- 상세정보 -->
		<div id="detailinfo">
		
			<!-- 반복문  구역 -->
			<c:forEach items="${pDetailImg }" var="pdto">
			<img src="/ex/resources/img/마켓이미지/${pdto.subcategory}/${pdto.pCode}/${pdto.detailimg}">
			</c:forEach>
			
		</div>

		<div class="clear"></div>

        <!--product REVIEW -->
        <div id="reviewwrap">
            <div id="article_top">
                <div id="article_top_left">
                    <p>PRODUCT REVIEW</p>
                    • 상품에 대한 문의를 남기는 공간입니다. 해당 게시판의 성격과 다른 글은 사전동의 없이 담당 게시판으로 이동될 수 있습니다.<br>
                    • 배송관련, 주문(취소/교환/환불)관련 문의 및 요청사항은 마이컬리 내 <a href="1대1 문의.html">1:1문의</a>에 남겨주세요.
                </div>
                <div id="article_top_right">
                    <select name="review_select" id="review_select">
                        <option value="recently">최근등록순</option>
                        <option value="like">좋아요많은순</option>
                        <option value="inquiry">조회많은순</option>
                    </select>
                </div>
            </div>
            <div id="article_middle">
                <ul id="article_middle_ul1">
                    <li style="width: 100px;" class="content_li1">번호</li>
                    <li style="width: 580px;" class="content_li1">제목</li>
                    <li style="width: 100px;" class="content_li1">작성자</li>
                    <li style="width: 130px;" class="content_li1">작성일</li>
                    <li style="width: 70px;" class="content_li1">조회</li>
                </ul>
                <div class="acowrap">
                    <ul class="article_middle_ul2">
                        <li style="width: 100px;" class="content_li1">공지</li>
                        <li style="width: 580px;"class="content_li2">금주의 BEST 후기 안내</li>
                        <li style="width: 100px;" class="content_li1">MarKetKurly</li>
                        <li style="width: 130px;" class="content_li1">2019-11-01</li>
                        <li style="width: 70px;" class="content_li1 cnt">472258</li>
                    </ul>
                    <ul class="article_middle_ul3">
                        <li>
                            고객님 안녕하세요. 마켓컬리입니다.<br><br>
                            ■ BEST후기 당첨자 안내<br><br>
                            정성껏 후기를 작성해주신 모든 고객님께 감사드립니다.<br><br>
                            Best 후기는 아래 게시판을 통해 확인 가능합니다.
                        </li>
                    </ul>
                </div>
				
				<c:forEach items="${pReviewlist}" var="prdto">
                <div>
                    <ul class="article_middle_ul2" data-src="${prdto.rNum}">
                        <li style="width: 100px;" class="content_li1">${prdto.rNum}</li>
                        <li style="width: 580px;"class="content_li2" name="title">${prdto.title}</li>
                        <li style="width: 100px;" class="content_li1" name="userID">${prdto.userID }</li>
                        <li style="width: 130px;" class="content_li1" name="created"><fmt:formatDate value="${prdto.created}" pattern="yyyy-MM-dd" /></li>
                        <li style="width: 70px;" class="content_li1 cnt">${prdto.cnt}</li>
                    </ul>
                    <ul class="article_middle_ul3">
                        <li name="contents">
                        	${prdto.contents}                        
                        </li>
                    </ul>
                </div>
                </c:forEach>
                
            </div>
            <c:if test="${not empty sessionScope.userID}">
            <div id="article_bottom">
                <button id="writeBtn">후기쓰기</button>
            </div>
            </c:if>
        </div>



		<div class="clear"></div>
		<!--product Q&A -->
		<div id="qnawrap">
            <div id="article_top">
                <div id="article_top_left">
                    <p>PRODUCT Q&A</p>
					• 상품에 대한 문의를 남기는 공간입니다. 해당 게시판의 성격과 다른 글은 사전동의 없이 담당 게시판으로 이동될 수
					있습니다.<br> • 배송관련, 주문(취소/교환/환불)관련 문의 및 요청사항은 마이컬리 내1:1문의에 남겨주세요.
                </div>
            </div>
            <div id="article_middle">
				<ul id="article_middle_ul1">
					<li style="width: 120px;" class="content_li1">번호</li>
					<li style="width: 640px;" class="content_li1">제목</li>
					<li style="width: 100px;" class="content_li1">작성자</li>
					<li style="width: 130px;" class="content_li1">작성일</li>
				</ul>
				<c:forEach items="${qlist}" var="qdto">
					<div>
						<ul class="article_middle_ul2">
							<li style="width: 120px;" class="content_li1">${qdto.qNum}</li>
							<li style="width: 640px;" class="content_li2" name="title">${qdto.qTitle}</li>
							<li style="width: 100px;" class="content_li1" name="userID">${qdto.userID}</li>
							<li style="width: 130px;" class="content_li1" name="created"><fmt:formatDate
									value="${qdto.created}" pattern="yyyy-MM-dd" /></li>
						</ul>
						<ul class="article_middle_ul3">
							<li name="contents" class="replies_li">
								<div>
									<span>Q :</span>  &nbsp; ${qdto.qTitle}<br><br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- ${qdto.qContents}<br><br>
								</div>
								<c:forEach items="${qnardto}" var="qnardto">
									<c:if test="${qnardto.qNum == qdto.qNum}">
										<div class="replies">
											<span>A : </span> &nbsp; ${qnardto.replyText }<br><br>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${qnardto.replyer} 올림
											<div id="replydate">작성일자 : <fmt:formatDate value="${qnardto.replyDate}" type="date" dateStyle="medium"/></div>
											<div class="clear"></div>
										</div>
									</c:if>
								</c:forEach>
								<div class="clear"></div>
							</li>
						</ul>
					</div>
				</c:forEach>
			</div>
			<div style="text-align: center;">
				<div class="pagination">
					<c:if test="${pageMaker.page !=1}">
						<a href='oneinquiry${pageMaker.makeSearch(1)}'>&laquo;</a>
					</c:if>
					<c:if test="${pageMaker.prev }">
						<a
							href='oneinquiry${pageMaker.makeSearch(pageMaker.startPage-1)}'>&lt;</a>
					</c:if>

					<c:forEach begin="${pageMaker.startPage }"
						end="${ pageMaker.endPage}" var="idx">
						<a href='oneinquiry${pageMaker.makeSearch(idx)}'
							<c:out value="${pageMaker.page==idx?' class=active ':'' }"/>>${idx}</a>
					</c:forEach>

					<c:if test="${pageMaker.next }">
						<a
							href='oneinquiry${pageMaker.makeSearch(pageMaker.endPage+1)}'>&gt;</a>
					</c:if>

					<c:if test="${pageMaker.page != pageMaker.totalEndPage}">
						<a
							href='oneinquiry${pageMaker.makeSearch(pageMaker.totalEndPage)}'>&raquo;</a>
					</c:if>
				</div>
				<div class="qnabtn" style="margin-top: 10px;">

				<c:if test="${not empty sessionScope.userID}">
					<button onclick="modalOn(0)" class="btn-modal">상품 문의</button>
				</c:if>


				</div>
			</div>

			<!--문의하기 버튼 클릭 -->

			<div class="clear"></div>
			<!--모달창 화면 시작-->
			<form action="/ex/mykurly/pdquewrite" method="post">
			<div id="modal0" class="modal-overlay">
				<div class="modal-window">
					<div class="modaltop">
						<div class="object">상품 문의하기</div>
						<div class="close-area" onclick="modalOff(0)">X</div>
					</div>
					<input type="hidden" name="pCode" value="${pdto.pCode}">
					<table class="modaltable">
						<tr>
							<td><img src="/ex/resources/img/마켓이미지/${pdto.subcategory}/${pdto.pCode }/${pdto.pimg}" width="80" height="80"></td>
							<td class="veg">&nbsp;&nbsp;&nbsp;${pdto.psubject}</td>
						</tr>
						<tr>
							<td class="boardtitle">제목</td>
							<td><input class="iptext" type="text" name="qTitle"
								placeholder="제목을 입력해주세요" style="width: 630px; height: 30px;">
							</td>
						</tr>
						<tr>
							<td class="contents">내용</td>
							<td><textarea
									placeholder="상품문의 작성 전 확인해 주세요.&#13;&#10;·답변은 영업일 기준2-3일 소요됩니다.&#13;&#10;·해당 게시판의 성격과 다른 글은 사전동의 없이 담당 게시판으로 이동될 수 있습니다.&#13;&#10;·배송 관련, 주소(취소/교환/환불)관련 문의 및 요청사항은 마이컬리 내 1:!문의에 남겨주세요.&#13;&#10;
												제품&#13;&#10;·입고일 : 품절 상품 입고 일이 확정된 경우, 섬네일에 기재되어 있습니다.&#13;&#10;(종 모양을 클릭하여,재입고 알림 설정가능)&#13;&#10;·제품 상세정보:영양성분 및 함량,용량,보관 및 취급방법 등 제품 정보는 상세이미지 또는 상세정보에서 확인하세요."
									style="width: 630px; height: 300px;" name="qContents"></textarea></td>
						</tr>
					</table>

					<div class="modalbtns">
						<button class="popmodal_btn" onclick="modalOff(0)">취소</button>
						<button class="popmodal_btn" id="btn_showChkList" type="submit" name="btn_showChkList">등록</button>
					</div>

				</div>
			</div>
			</form>
		</div>

		<!--모달창 화면 끝-->
		
	</div>
	<a href="#" class="top"><div class="topwrap">↑</div></a>
	<%@include file="../include/footer.jsp"%>

	
	<script>
		$(document).ready(function() {
			$("#fav_no").on("click", function() {

				var fNum = ${fdto.fNum};

				$.ajax({
					type : 'delete',
					url : '/ex/mykurly/favoritlist/' + fNum,
					headers : {
						"Content-Type" : "application/json"
					},
					dataType : 'text',
					success : function(result) {
						if (result == 'SUCCESS') {
							alert("찜목록에서 삭제되었습니다.");
							document.location.reload();
						}
					}
				})
			});
		});
	</script>
</body>

</html>