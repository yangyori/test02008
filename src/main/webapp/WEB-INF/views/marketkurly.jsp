<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>마켓컬리</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <link rel="stylesheet" href="/ex/resources/css/marketkurly.css">

    <script>

        var pos = 0;
        var totalSlides;
        var sliderWidth;

        $(document).ready(function () {

            totalSlides = $('#slider-wrap ul li').length;
            sliderWidth = $('#slider-wrap').width();

            $('#slider-wrap ul#slider').width(sliderWidth * totalSlides);

     
            $('#next').click(function () {
                slideRight();
            });


            $('#previous').click(function () {
                slideLeft();
            });


            var autoSlider = setInterval(slideRight, 3000);

            $.each($('#slider-wrap ul li'), function () {

                var li = document.createElement('li');
                $('#pagination-wrap ul').append(li);
            });

            countSlides();

            pagination();

            $('#slider-wrap').hover(
                function () { $(this).addClass('active'); clearInterval(autoSlider); },
                function () { $(this).removeClass('active'); autoSlider = setInterval(slideRight, 3000); }
            );

        });

        function slideLeft() {
            pos--;
            if (pos == -1) { pos = totalSlides - 1; }
            $('#slider-wrap ul#slider').css('left', -(sliderWidth * pos));

            countSlides();
            pagination();
        }


        function slideRight() {
            pos++;
            if (pos == totalSlides) { pos = 0; }
            $('#slider-wrap ul#slider').css('left', -(sliderWidth * pos));

            countSlides();
            pagination();
        }


        function countSlides() {
            $('#counter').html(pos + 1 + ' / ' + totalSlides);
        }

        function pagination() {
            $('#pagination-wrap ul li').removeClass('active');
            $('#pagination-wrap ul li:eq(' + pos + ')').addClass('active');
        }
        
        
        var result2 = '${message}'
            if(result2 == 'updateSuccess'){
            	alert("회원정보가 수정되었습니다.");
            }
    </script>

</head>

<body>
    <div id="wrap">
		<%@include file="include/header.jsp"%>

        <div id="wrapper">
            <div id="slider-wrap">
                <ul id="slider">
                    <li>
                        <img src="/ex/resources/img/배너/배너1.jpg">
                    </li>
    
                    <li>
                        <img src="/ex/resources/img/배너/배너2.jpg">
                    </li>
    
                    <li>
                        <img src="/ex/resources/img/배너/배너3.jpg">
                    </li>
    
                    <li>
                        <img src="/ex/resources/img/배너/배너4.jpg">
                    </li>
    
                </ul>
    
                <!--controls-->
                <div class="btns" id="next"><i class="fa fa-arrow-right"></i></div>
                <div class="btns" id="previous"><i class="fa fa-arrow-left"></i></div>
                <div id="counter"></div>
    
                <!--controls-->
    
            </div>
    
        </div>
        
        <div class="clear"></div>
        
        <div id="list">
            <div id="item_category">
                <h1>인기상품</h1>
            </div>
			
			<!-- 반복문  구역 -->
            <div class="item">
                <div class="item_img"><a href="#"><img src="/ex/resources/img/상품/샐러드.png"></a></div>
                <div class="psubject">[스윗밸런스] 오늘의 샐러드 6종</div>
                <div class="price">4,900원</div>
                
            </div>
            <!-- 반복문  구역 -->

            <div class="item">
                <div class="item_img"><a href="#"><img src="/ex/resources/img/상품/브리또.PNG"></a></div>
                <div class="psubject">[남향푸드또띠아] 간편 간식 브리또 10종]</div>
                <div class="price">2,900원</div>
                
            </div>

            <div class="item">
                <div class="item_img"><a href="#"><img src="/ex/resources/img/상품/우유.PNG"></a></div>
                <div class="psubject">[연세우유x마켓컬리] 전용목장우유</div>
                <div class="price">1,850원</div>
                
            </div>

            <div class="item">
                <div class="item_img"><a href="#"><img src="/ex/resources/img/상품/도시락.PNG"></a></div>
                <div class="psubject">[스윗밸런스] 오늘의 샐러드 6종</div>
                <div class="price">4,900원</div>
                
            </div>
        </div>

    	<%@include file="include/footer.jsp"%>
    </div>
</body>

</html>