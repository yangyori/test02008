<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true" %>
<%
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마켓컬리</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="<%=cp%>/resources/css/headerbar.css?ver=2">
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
        
        function notlongin(){
        	alert("로그인하셔야 서비스를 이용하실 수 있습니다.");
        	self.location ="/ex/member/login";
        }

    </script>
</head>

<body>
    <div id="wrap">
        <div id="header">
            <ul id="top_menu">
             	<c:choose>
                <c:when test = "${not empty sessionScope.userID}">
                <c:choose>
                <c:when test = "${sessionScope.userID eq 'admin' }">
	                <li id="logincheck" class="li4"><a href="/ex/manager/moneinquiry"><span class="span01">웰컴</span>관리자▼</a>
	                    <ul>
	                    	<li><a href="/ex/manager/mnotice">공지사항</a></li>
	                        <li><a href="/ex/manager/moneinquiry">1:1 문의</a></li> 
	                        <li><a href="/ex/manager/minquiry">상품문의</a></li>
	                        <li><a href="/ex/member/logout">로그아웃</a></li>	   
	                    </ul>
	                </li>
                </c:when>
                <c:otherwise>
              	<li id="logincheck" class="li4"><a href="/ex/mykurly/orderlist"><span class="span01">웰컴</span>${sessionScope.userName}님▼</a>
                    <ul>
                        <li><a href="/ex/mykurly/orderlist">주문 내역</a></li> 
                        <li><a href="/ex/mykurly/favoritlist">찜한 상품</a></li>
                        <li><a href="/ex/mykurly/deliverylist">배송지 관리</a></li>
                        <li><a href="/ex/mykurly/pdreview">상품 후기</a></li>
                        <li><a href="/ex/mykurly/pdinquiry">상품 문의</a></li>
                        <li><a href="/ex/member/personalInfo">개인정보수정</a></li>
                        <li><a href="/ex/member/logout">로그아웃</a></li>
                    </ul>
                </li>
                </c:otherwise>
                </c:choose>
                </c:when>
                <c:otherwise>
	                <li class="li1"><a href="/ex/member/join">회원가입</a></li>
	                <li class="li2"><a href="/ex/member/login">로그인</a></li>
                </c:otherwise>
              </c:choose>
                 
                <!-- 로그인 했을때-->

                <li class="li3"><a href="/ex/customcenter/noticelist">고객센터▼</a>
                    <ul>
                        <li><a href="/ex/customcenter/noticelist">공지사항</a></li>
                        <li><a href="/ex/customcenter/oftenqna">자주하는 질문</a></li>
                        <c:choose>
                		<c:when test="${not empty sessionScope.userID}">
                        	<li><a href="/ex/customcenter/oneinquiry">1:1문의</a></li>
                        </c:when>
                        <c:otherwise>
                        	<li style="cursor: pointer;" onclick="notlongin()"><a>1:1문의</a></li>
                        </c:otherwise>
                        </c:choose>
                    </ul>
                </li>
            </ul>
        </div>

        <div class="clear"></div>

        <div id="logo">
            <a href="/ex"><img src="/ex/resources/img/logo.png"></a>
        </div>

        <div class="clear"></div>

        <div id="main_bar">
            <div id="main_left">
                <ul id="main_menu">
                    <div class="mdropdown">
                        <li class="mdropbtn"><a href="#" class="changecolor"><span
                                    class="material-icons-outlined">view_headline</span>전체 카테고리</a>
                            <div class="mdrpwrap">
                                <div class="mdropdown-content">
                                    <div class="mcategory">
                                        <ul id="main_sidebar">
                                            <li class="tablinks" onmouseover="openCategory(event, 'vegetable')"><a
                                                    href="#">채소</a></li>
                                            <li class="tablinks" onmouseover="openCategory(event, 'fruit')"><a
                                                    href="#">과일‧견과‧쌀</a></li>
                                            <li class="tablinks" onmouseover="openCategory(event, 'seafood')"><a
                                                    href="#">수산‧해산‧건어물</a></li>
                                            <li class="tablinks" onmouseover="openCategory(event, 'meat')"><a
                                                    href="#">정육‧계란</a></li>
                                            <li class="tablinks" onmouseover="openCategory(event, 'dish')"><a
                                                    href="#">국‧반찬‧메인요리</a></li>
                                            <li class="tablinks" onmouseover="openCategory(event, 'salad')"><a
                                                    href="#">샐러드‧간편식</a></li>
                                            <li class="tablinks" onmouseover="openCategory(event, 'noodle')"><a
                                                    href="#">면‧앙념‧오일</a></li>
                                        </ul>
                                    </div>
                                    <div class="mcontents">
                                        <div id="vegetable" class="tabcontent">
                                            <ul>
                                                <li><a href="/ex/products/pdlist?subcategory=친환경&od=5">친환경</a></li>
                                                <li><a href="/ex/products/pdlist?subcategory=고구마감자당근&od=5">고구마 ‧ 당근 ‧ 감자 </a></li>
                                                <li><a href="/ex/products/pdlist?subcategory=시금치쌈채소나물&od=5">시금치 ‧ 쌈채소 ‧ 나물</a></li>
                                                <li><a href="/ex/products/pdlist?subcategory=브로콜리파프리카양배추&od=5">브로콜리 ‧ 파프리카 ‧ 양배추</a></li>
                                                <li><a href="/ex/products/pdlist?subcategory=양파대파마늘배추&od=5">양파 ‧ 대파 ‧ 마늘 ‧ 배추</a></li>
                                                <li><a href="/ex/products/pdlist?subcategory=오이호박고추&od=5">오이 ‧ 호박 ‧ 고추</a></li>
                                                <li><a href="/ex/products/pdlist?subcategory=콩나물버섯&od=5">콩나물 ‧ 버섯</a></li>
                                            </ul>
                                        </div>

                                        <div id="fruit" class="tabcontent">
                                            <ul>
                                                <li><a href="#">친환경</a></li>
                                                <li><a href="#">제철과일</a></li>
                                                <li><a href="#">국산과일</a></li>
                                                <li><a href="#">수입과일</a></li>
                                                <li><a href="#">견과류</a></li>
                                                <li><a href="#">쌀 ‧ 잡곡</a></li>
                                                <li><a href="#"></a></li>
                                            </ul>
                                        </div>

                                        <div id="seafood" class="tabcontent">
                                            <ul>
                                                <li><a href="#">제철수산</a></li>
                                                <li><a href="#">생선류</a></li>
                                                <li><a href="#">굴비 ‧ 반건류</a></li>
                                                <li><a href="#">쌀 ‧ 잡곡</a></li>
                                                <li><a href="#">쌀 ‧ 잡곡</a></li>
                                                <li><a href="#">쌀 ‧ 잡곡</a></li>
                                                <li><a href="#"></a></li>
                                            </ul>
                                        </div>

                                        <div id="meat" class="tabcontent">
                                            <ul>
                                                <li><a href="#">제철수산</a></li>
                                                <li><a href="#">생선류</a></li>
                                                <li><a href="#">굴비 ‧ 반건류</a></li>
                                                <li><a href="#">쌀 ‧ 잡곡</a></li>
                                                <li><a href="#">쌀 ‧ 잡곡</a></li>
                                                <li><a href="#">쌀 ‧ 잡곡</a></li>
                                                <li><a href="#"></a></li>
                                            </ul>
                                        </div>

                                        <div id="dish" class="tabcontent">
                                            <ul>
                                                <li><a href="#">제철수산</a></li>
                                                <li><a href="#">생선류</a></li>
                                                <li><a href="#">굴비 ‧ 반건류</a></li>
                                                <li><a href="#">쌀 ‧ 잡곡</a></li>
                                                <li><a href="#">쌀 ‧ 잡곡</a></li>
                                                <li><a href="#">쌀 ‧ 잡곡</a></li>
                                                <li><a href="#"></a></li>
                                            </ul>
                                        </div>

                                        <div id="salad" class="tabcontent">
                                            <ul>
                                                <li><a href="#">제철수산</a></li>
                                                <li><a href="#">생선류</a></li>
                                                <li><a href="#">굴비 ‧ 반건류</a></li>
                                                <li><a href="#">쌀 ‧ 잡곡</a></li>
                                                <li><a href="#">쌀 ‧ 잡곡</a></li>
                                                <li><a href="#">쌀 ‧ 잡곡</a></li>
                                                <li><a href="#"></a></li>
                                            </ul>
                                        </div>

                                        <div id="noodle" class="tabcontent">
                                            <ul>
                                                <li><a href="#">제철수산</a></li>
                                                <li><a href="#">생선류</a></li>
                                                <li><a href="#">굴비 ‧ 반건류</a></li>
                                                <li><a href="#">쌀 ‧ 잡곡</a></li>
                                                <li><a href="#">쌀 ‧ 잡곡</a></li>
                                                <li><a href="#">쌀 ‧ 잡곡</a></li>
                                                <li><a href="#"></a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </div>
                    <li class="mli2"><a href="/ex/products/newpdlist" class="a">신상품</a></li>
                    <li class="mli3"><a href="/ex/products/bestpdlist" class="a">베스트</a></li>
                    <li class="mli4"><a href="/ex/products/cheappdlist" class="a">알뜰쇼핑</a></li>
                    <li class="mli5"><a href="#" class="a">특가/혜택</a></li>
                </ul>

            </div>
            <div id="main_right">
            
            	<form action="/ex/products/pdlistsearch" method="POST">
                <div id="search">                    
                        <input type="text" placeholder="검색어를 입력해주세요" name="search" >
                        <button type="submit"><span class="material-icons-outlined">search</span></button>               
                </div>
                </form>
                   
                <div id="location" class="lfc">
                    <a href="#"><span class="material-icons-outlined">room</span></a>
                </div>
                <c:choose>
                <c:when test="${not empty sessionScope.userID}">
	                <div id="favorit" class="lfc">
	                    <a href="/ex/mykurly/favoritlist"><span class="material-icons-outlined">favorite_border</span></a>
	                </div>
	                <div id="cart" class="lfc">
	                    <a href="/ex/products/pdcart"><span class="material-icons-outlined">shopping_cart</span></a>
	                </div>
                </c:when>
                <c:otherwise>
	                <div id="favorit" class="lfc">
	                    <a style="cursor: pointer;" onclick="notlongin()"><span class="material-icons-outlined">favorite_border</span></a>
	                </div>
	                <div id="cart" class="lfc">
	                    <a style="cursor: pointer;" onclick="notlongin()"><span class="material-icons-outlined">shopping_cart</span></a>
	                </div>
                
                </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="clear"></div>

    </div>
</body>
</html>