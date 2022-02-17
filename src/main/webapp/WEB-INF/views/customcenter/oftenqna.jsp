<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주하는 질문</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/ex/resources/css/자주하는 질문.css">
    <script>
    $(document).ready(function () {
        const acoAco = $('.QnA-dropdown .QnA-main');

        acoAco.on('click', function () {
            const item = $(this);
            let speed = 100;

            acoAco.parent().find('.QnA-textbox').stop().slideUp(speed);

            if (item.hasClass('active')) {
                item.find('.QnA-textbox').stop().slideUp(speed);
                item.removeClass('active');
            } else {
                item.parent().find('.QnA-textbox').stop().slideDown(speed);
                acoAco.removeClass('active');
                item.addClass('active');
            }

        })
  
    });
    
    </script>
    <style>

    </style>
</head>

<body>
	<div id="wrap">
		<%@include file="../include/header.jsp"%>
		<div id="customwrap">
			<%@include file="../include/customcentermenu.jsp"%>
            <div id="cright">
                <div id="cright_header">
                    자주하는 질문 <p>고객님들께서 가장 자주하는 질문을 모두 모았습니다.</p>
                </div>

                <!--드랍다운 게시판 시작-->                
                <ul class="QnA-dropdown">
                    <li>
                        <div class="QnA-header">
                            <div class="qnath1">번호</div>
                            <div class="qnath2">카테코리</div>
                            <div class="qnath3">제목</div>
                        </div>

                        <div class="border_line">
                            <div class="QnA-main">
                                <div class="qnatd1">5</div>
                                <div class="qnatd2">회원</div>
                                <div class="qnatd3">아이디,비밀번호를 잃어버렸습니다.</div>
                            </div>

                            <div class="QnA-textbox">
                                <div><img src="/ex/resources/img/자주하는질문 이미지.png"> 아이디, 비밀번호 찾기 안내<br><br>
                                    -하기 경로를 통해 아이디 및 비밀번호를 찾기가 가능하며, 임시 비밀번호의 경우 회원가입 시 등록한 이메일 주소로 발송 됩니다.<br><br>

                                    (PC)컬러홀 상단 [로그인] > 화면 아래 [아이디 찾기][비밀번호 찾기]<br><br>
                                    (모바일)아래 탭에서 [마이컬리]>로그인 화면 아래[아이디 찾기] [비밀번호 찾기]<br><br>

                                    [참고]
                                    가입시 기재한 메일 주소가 기억나지 않으시거나 오류가 발생하는 경우 고객센테로 문의 바랍니다.<br><br>
                                    상담시에는 고객님의 개인정보보호를 위해 기존에 사용하시던 비밀번호는 안내가 불가하며, 개인정보 확인 후 임시비밀번호를 설정 해 드립니다.
                                </div>
                            </div>
                        </div>

                        <div class="border_line">
                            <div class="QnA-main">
                                <div class="qnatd1">4</div>
                                <div class="qnatd2">서비스 이용</div>
                                <div class="qnatd3">1:1 게시판으로 문의 남기는 방법은 없나요 ?</div>
                            </div>
        
                            <div class="QnA-textbox">
                                <div><img src="/ex/resources/img/자주하는질문 이미지.png">
                                    -1:1 게시판 상담 문의<br><br>
                                    -하기 경로를 통해 문의/불만 내용을 남겨주시면 상담시 확인하여 빠르게 도움 드리도록 하겠습니다.<br><br>
                                    (PC) 컬러홀 상단 고객센터 > 1:1 문의 하기<br><br>
                                    (모바일) 마이컬리 > 1:1 문의 하기<br><br>
                                    [참고]<br><br>
                                    제품 하자/제품 이상 등으로 반품(환불)이 필요한 경우 사진과 함께 구체적인 내용을 남겨주세요.</div>
                            </div>

                        </div>

                        <div class="border_line">
                            <div class="QnA-main">
                                <div class="qnatd1">3</div>
                                <div class="qnatd2">이벤트/쿠폰/적립금</div>
                                <div class="qnatd3">이벤트/쿠폰/적립금 아이디,비밀번호를 잃어버렸습니다.</div>
                            </div>
        
                            <div class="QnA-textbox">
                                <div><img src="/ex/resources/img/자주하는질문 이미지.png">
                                    -쿠폰 사용 오류 발생<br><br>
                                    -간혹, 모바일 네트워크가 불안정한 경우, 쿠폰을 불러오는 동안 해당 문구가 노출될 수 있습니다.<br><br>
                                    쿠폰이 불러오는 동안 조금만 기다려주시고, 이 후에도 동일한 문제가 발생할 경우 고객센터로 문의 바랍니다.</div>
                            </div>
                            
                        </div>

                        <div class="border_line">
                            <div class="QnA-main">
                                <div class="qnatd1">2</div>
                                <div class="qnatd2">주문/결제/대량주문</div>
                                <div class="qnatd3">주문/결제/대량주문</div>
                            </div>
        
                            <div class="QnA-textbox">
                                <div><img src="/ex/resources/img/자주하는질문 이미지.png">
                                    -주문 내역 조회<br><br>
                                    -하기 경로를 통해 구매하신 주문건의 이력을 확인할 수 있습니다.<br><br>
                                    (PC) 컬리홈 상단 [회원명]클릭 > 주문 내역<br><br>
                                    (모바일) 마이컬리 > 주문 내역</div>
                            </div>
                            
                        </div>

                        <div class="border_line">
                            <div class="QnA-main">
                                <div class="qnatd1">1</div>
                                <div class="qnatd2">상품</div>
                                <div class="qnatd3">친환경/유기농/무농약이 어떻게 다른가요?</div>
                            </div>
        
                            <div class="QnA-textbox">
                                <div><img src="/ex/resources/img/자주하는질문 이미지.png">
                                    -친환경 인증이란 ? <br><br>
                                    친환경 농산물은 인체와 생태환경에 해로운 화학비료, 농약, 제초제 등을최대한 사용하지 않고 재배한 농산물을 일컬으며 이 중, 화학비료와 농약 사용량에 따라 ㄹ저농약,
                                    무농약, 유기농으로 구분됩니다.<br><br>
                                    - 저농약 : 일반 농산물 대비 적은 양의 농약을 사용한 농산물<br>
                                    - 무농약 : 농약을 사용하지 않되, 화학비료를 사용한 농산물<br>
                                    - 유기농 : 화학비료와 농약을 일체 사용하지 않고 재배한 농산물<br><br>
                                    [참고]<br><br>
                                    인증서와 관련 된 다양한 정보는 아래 경로를 상세히 확인 할 수 있습니다.<br><br>
                                    (웹) 컬리홈 > 메인 페이지 맨 마지막 하단 > "컬리소개" 클릭 > "1. 컬리의 품질기준" 조회<br><br>
                                    (모바일) 컬리APP > 하단 오른쪽 마이컬리 > "콜리소개"를 클릭 > "1.컬리의 품질기준" 클릭
                                </div>
                            </div>
                            
                        </div>
                    </li>
                </ul>
            

                <div class="QnA-footer">
                    
                </div>


            </div>
        </div>
        <%@include file="../include/footer.jsp"%>
    </div>
</body>

</html>