<%@ page language="java" contentType="text/html; charset=UTF-8"     pageEncoding="UTF-8"%>    
<%@ include file="./includes/header.jsp" %>
		<script type="text/javascript">
        var newItemsSlider = "";
        var bestItemsSlider = "";
        var newProductCategory = "";
        var bestProductCategory = "";
        var checkInstagramInfo = false;
        var allLinkTemp = [];
        var allUrlTemp = [];
        var allCaptionTemp = [];
        var allIndex = 0;
        var accountCount = 0;
        var horiz = $(".horiz_topbanner").length;
        
        var rate_en = "";
        var symbol_en = "";
        var rate_zh = "";
        var symbol_zh = "";
        
        $(document).ready(function(){
            var todayDate = new Date();         
         	
            if(horiz > 0) {
                $("#mainNoticeWrap").css("top","230px");
                $(".popWrap1901").css("top", "78px");
            }
            
            mainSlider1903();
            edtSlider1903();
            videoPlay1903();
//             신상품, 베스트 상품, 매거진 리스트 조회에 ajax 이용
            $.ajax({
            	type: "get",
            	url : "/ko/intro/mainCategoryList",
                async : true,
                contentType : "application/json",
                error : function( request, status, error ){
                    console.log( "code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
                }, 
                success : function( result ) {
                	if(result.length > 0) {
                		var newHtml = "";
                		var bestHtml = "";
                		var newCount = 0;
                		var bestCount = 0;
                		var isoCode = "ko";
                		var categoryName = "";
                		
                		for(var i=0; i < result.length; i++) {
                			if(isoCode == "ko") {
                				categoryName = result[i].categoryName;
                			}
                			// displayTypeYn은 메인에 보여줄 카테고리인지 체크
                			// displayType이 true이면 신상품, false이면 베스트
               				if(result[i].displayTypeYn == true) {
	                			if(result[i].displayType == true) {
		                			if(newCount == 0) {
		                				newProductCategory = result[i].categoryCode;
		                				newHtml += '<li class="on">';
		                			} else {
		                				newHtml += '<li>';
		                			}
		                			
		                			newHtml += '	<a href="javascript:getNewProductList(\''+result[i].categoryCode+'\')" onclick="GA_Event(\'메인\', \'신상품\', \''+categoryName+'\');">'+categoryName+'</a>';
		                			newHtml += '</li>';
		                			newCount++;
	                			} else if(result[i].displayType == false) {
	                				if(bestCount == 0) {
	                					bestProductCategory = result[i].categoryCode;
	                					bestHtml += '<li class="on">';
		                			} else {
		                				bestHtml += '<li>';
		                			}
		                			
	                				bestHtml += '	<a href="javascript:getBestProductList(\''+result[i].categoryCode+'\')" onclick="GA_Event(\'메인\', \'베스트\', \''+categoryName+'\');">'+categoryName+'</a>';
	                				bestHtml += '</li>';
	                				bestCount++;
	                			}
               				}
                		}
                		$(".nbe_cnt.new .product_left_menu > ul").html(newHtml);
                		tabNew();
                		getNewProductList(newProductCategory);
                		$(".nbe_cnt.best .product_left_menu > ul").html(bestHtml);
                		tabBest();
                		getBestProductList(bestProductCategory);
                	}
                }
            });
            
            getMagazineList();
            
            var getUrlParameter = function getUrlParameter(sParam) {//URL에 포함된 파라미터 이용하기
                var sPageURL = window.location.search.substring(1),
                    sURLVariables = sPageURL.split('&'),
                    sParameterName,
                    i;
                for (i = 0; i < sURLVariables.length; i++) {
                    sParameterName = sURLVariables[i].split('=');
                    if (sParameterName[0] === sParam) {
                        return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
                    }
                }
            };
            //layerPopup front test (노출 기한 상관 없이 pk 이용하여 메인에서 팝업 보기)
            var pop1 = getUrlParameter('pop1'); 
            if (typeof pop1 == "undefined") pop1 = "N";
            // 공지사항
            $.ajax({
                type: "get",
                url : "/ko/svcenter/mainNotice",
                cache : false,
                data: {"pop1":pop1},
                async : true,
                contentType : "application/json",
                error : function( request, status, error ){     
                    console.log( "code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
                }, 
                success : function( result ) {
                    var todayDate = new Date(); 
                    var switchMain = "";
                    if(result.length > 0) switchMain = result[0].readCount;
                    if("N" != switchMain){//switchMain = "N" 이면 메인팝업 기존방식(하드코딩)으로 돌리기 
                        if(result.length > 0) {
                            var documentResult="";
                            var isocode = "ko";
                            for(var i = 0 ; i < result.length ; i ++ ){
                                var showYn = "N";
                                if(getCookie(result[i].pk+isocode) != todayDate.getDate()) showYn = "Y"; // 오늘은 그만보기
                                if(pop1 != "N") showYn = "Y"; //팝업 미리보기
                                if(showYn == "Y") {
                                     if(null != result[i].bgImage && "" != result[i].bgImage.trim()) {
                                        documentResult += "<div class='popwrap_renewal1910 txtonimg add1' id='"+result[i].pk+isocode+"'>";
                                        documentResult += "<img src='"+result[i].bgImage+"' alt='' class='pop_backimg'>";
                                     } else {
                                         documentResult += "<div class='popwrap_renewal1910' id='"+result[i].pk+isocode+"'>";
                                     }
                                     documentResult += "    <div class='pop_cnt'>";
                                     if(null != result[i].noticeContentsYN && result[i].noticeContentsYN) {//단순 텍스트 출력 시 title 노출, html 포함 출력 시 title 비노출(html 코드에 title 포함)
                                         if(null != result[i].noticeTitle && "" != result[i].noticeTitle.trim()) {
                                             var noticeTitle = result[i].noticeTitle;
                                             var replacedTitle = noticeTitle.replace(/(?:\r\n|\r|\n)/g, '<br>');
                                             documentResult += '<h3 class="pop_tlt">'+replacedTitle+'</h3>';
                                         }
                                     } 
                                     if(null != result[i].noticeContents && "" != result[i].noticeContents.trim()){
                                         if(result[i].noticeContentsYN) {
                                             documentResult += "        <p class='pop_txt'>";
                                         } else {//html 코드 출력
                                             documentResult += "        <p class='pop_txt' style='min-height: 0; padding: 25px 0 0 0;'>";
                                         }
                                         var noticeContents = result[i].noticeContents;
                                         var replacedContents = noticeContents.replace(/(?:\r\n|\r|\n)/g, '<br>');
                                         documentResult +=                replacedContents;
                                         documentResult += "        </p>";
                                     }
                                     if(null != result[i].bannerLink && "" != result[i].bannerLink.trim()){
                                         documentResult += "        <div class='linkbox'>";
                                         documentResult += "            <a href='"+result[i].bannerLink+"'>";
                                        if(null != result[i].bannerLinkText && "" != result[i].bannerLinkText.trim()) documentResult += result[i].bannerLinkText;
                                         documentResult += "            </a>";
                                         documentResult += "        </div>";
                                     }
                                     documentResult += "    </div>";
                                     documentResult += "    <div class='btnwrap'>";
                                     documentResult += "        <input type='button' class='btn stoptoday closeLayerPopup' value=\"오늘은 그만보기 \">";
                                     documentResult += "        <input type='button' class='btn close closeLayerPopup' value=\"닫기\">";
                                     documentResult += "    </div>";
                                     documentResult += "    <a href='#' class='btn_close closeLayerPopup'><img src='/resources/_ui/desktop/common/images/popup/ico_close.png' alt=\"닫기\"></a>";
                                     documentResult += "</div>";
                                }
                            }
                            $("#mainNoticeWrap").html(documentResult);
                            
                            $(".closeLayerPopup").on("click", function(){
                                if($(this).hasClass("stoptoday")){//오늘은 그만보기
                                    var todayDate = new Date(); 
                                    var cookieId = $(this).parents(".popwrap_renewal1910").attr("id");
                                    setCookie(cookieId, todayDate.getDate(),1);
                                }
                                $(this).parents(".popwrap_renewal1910").css("display","none");
                            });
                            
                        }
                    } else {
                        // 한섬마일리지 조회/사용불가
                        if(getCookie('HSlayerPopup3') != todayDate.getDate()) {
                            var startDate1 = new Date('2018/12/28 16:00:00'), endDate1 = new Date('2019/02/31 00:00:00');
                            if (todayDate.getTime() >= startDate1.getTime() && todayDate.getTime() <= endDate1.getTime()) {
                                //layerPopup6('open');
                            }
                        }
                    }
                }
            });
                     
            $(".closeLayerPopup").on("click", function(){
                if($(this).hasClass("stoptoday")){//오늘은 그만보기
                    var todayDate = new Date(); 
                    var cookieId = $(this).parents(".popwrap_renewal1910").attr("id");
                    setCookie(cookieId, todayDate.getDate(),1);
                }
                $(this).parents(".popwrap_renewal1910").css("display","none");
            });
            
            
            var todayDate = new Date();
            
            //전환된 회원일 경우 처리
                    // 여기 확인 비로그인시 주석처리
                    setCookie("memberTransPopup", 'Y', 90);
                
            
            //전환가입유도 팝업
            
           
            //자동로그인 팝업
                    // 여기 확인 비로그인시 주석 해제
                    // var ssoUrl = "https://sso.h-point.co.kr:29865" + "/co/setSsoReqJSONP.hd";
                    // gfnSsoReqAjax(ssoUrl, ssoTokenSuc);
        	
        });
      
	    // 메인페이지 Ajax 
	    // getNewProductList 함수로 카테고리 코드 받아옴.
	    // 여성 WE , 남성 ME, 포인트 ACC WE03, 셀렉티드 WE01
        function getNewProductList(categoryCode) {
        	$.ajax({
        		type: "get",
            	url : "/ko/intro/mainNewProductList"+"?categoryCode="+categoryCode,
                dataType : "json",
                async : true,
                contentType : "application/json",
                error : function( request, status, error ){
                    console.log( "code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
                }, 
                success : function( result ) {
                	var html = "";
                	if(result.length > 0) {
                	    window.sessionStorage.setItem('main_new_ecommerceDataList', JSON.stringify(result));
                		html += '<div class="nbe_cnt_inner swiper-container" id="newListSlider">';
                		html += '	<ul class="items_list swiper-wrapper">';
                		for(var i=0; i < result.length; i++) {
               			html += '		<li class="swiper-slide">';
               			html += '			<div class="item_box">';
                		html += '				<a href="/product/productDetail?pid='+result[i].productCode+'" class="item_info1" onclick="javascript:GA_main(\'newImg\',$(this));setEcommerceData('+ i +', \'NEW\', \''+categoryCode+'\');">';
               			html += '					<span class="item_img">';
               			html += '						<img src="'+result[i].t01imageUrl+'/dims/resize/234x353" alt="" name="'+result[i].productName+'" class="respon_image">';
//                			html += '					</span>';
               			html += '				</a>';
               			html += '				<a href="/product/productDetail?pid='+result[i].productCode+'" class="item_info2" onclick="javascript:GA_main(\'new\',$(this));setEcommerceData('+ i +', \'NEW\', \''+categoryCode+'\');">';
               			html += '					<span class="brand">'+result[i].brandName+'</span>';
               			html += '					<span class="price">'+ getExchangePrice(result[i].price) +'</span>';
               			html += '				</a>';
               			html += '			</div>';
               			html += '		</li>';
                		}
                		html += '	</ul>';
                		html += '<div class="swiper-button-next"></div>';
                        html += '<div class="swiper-button-prev"></div>';
                		html += '</div>';
                		$(".product_list1903 .nbe_cnt.new .nbe_cnt_inner_wrap").html(html);
			        	newProductListSlider1903();
                	} else {
                		$(".product_list1903 .nbe_cnt.new .nbe_cnt_inner_wrap").html(html);
                	}
                }
        	});
        }
        
        function getBestProductList(categoryCode) {
        	$.ajax({
        		type: "get",
            	url : "/ko/intro/mainBestProductList"+"?categoryCode="+categoryCode,
                dataType : "json",
                async : true,
                contentType : "application/json",
                error : function( request, status, error ){
                    console.log( "code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
                }, 
                success : function( result ) {
                	var html = "";
                	if(result.length > 0) {
                	    window.sessionStorage.setItem('main_best_ecommerceDataList', JSON.stringify(result));
                		html += '<div class="nbe_cnt_inner swiper-container" id="bestListSlider">';
                		html += '	<ul class="items_list swiper-wrapper">';
                		for(var i=0; i < result.length; i++) {
               			html += '		<li class="swiper-slide">';
               			html += '			<div class="item_box">';
               			html += '				<a href="/product/productDetail?pid='+result[i].productCode+'" class="item_info1" onclick="javascript:setEcommerceData('+ i +', \'BEST\', \''+categoryCode+'\');">';
               			html += '					<span class="item_img">';
               			html += '						<img src="'+result[i].t01imageUrl+'/dims/resize/234x353" alt="" name="'+result[i].productName+'" class="respon_image" onclick="GA_main(\'bestImg\',$(this))">';
               			html += '					</span>';
               			html += '				</a>';
               			html += '				<a href="/product/productDetail?pid='+result[i].productCode+'" class="item_info2" onclick="javascript:GA_main(\'best\',$(this));setEcommerceData('+ i +', \'BEST\', \''+categoryCode+'\');">';
               			html += '					<span class="brand">'+result[i].brandName+'</span>';
               			html += '					<span class="price">'+ getExchangePrice(result[i].price) +'</span>';
               			html += '				</a>';
               			html += '			</div>';
               			html += '		</li>';
                		}
                		html += '	</ul>';
                		html += '<div class="swiper-button-next"></div>';
                        html += '<div class="swiper-button-prev"></div>';
                		html += '</div>';
                		$(".product_list1903 .nbe_cnt.best .nbe_cnt_inner_wrap").html(html);
	                	bestProductListSlider1903();
                	}else {
                    	$(".product_list1903 .nbe_cnt.best .nbe_cnt_inner_wrap").html(html);
                    }
                }
        	});
        }
        
        function getMagazineList() {
        	$.ajax({
        		type: "get",
            	url : "/ko/intro/mainMagazine",
                cache : false,
                dataType : "json",
                async : true,
                contentType : "application/json",
                error : function( request, status, error ){
                    console.log( "code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
                }, 
                success : function( result ) {
                	var categoryText = "";
                	var url = "";
                	var html = "";
                	if(result.length > 0) {
                		for(var i=0; i < result.length; i++) {
                			if(result[i].category == "뉴스") {
                				categoryText = "뉴스";
                			} else if(result[i].category == "SPOTLIGHT_ON") {
                				categoryText = "위클리 픽";
                			} else if(result[i].category == "HANDSOME_PEOPLE") {
                				categoryText = "핸썸피플";
                			} else if(result[i].category == "TREND_TO_KNOW") {
                				categoryText = "셀렉션";
                			} else if(result[i].category == "HOW_TO_STYLE") {
                				categoryText = "커버스토리";
                			} else if(result[i].category == "EDITORS_PICK") {
                				categoryText = "스타일 가이드";
                			} else if(result[i].category == "PLAY_PLAY") {
                				categoryText = "플레이";
                			} else if(result[i].category == "SHARP_SOME") {
                                categoryText = "#SOME";
                            }
                			
                			html += '<li class="swiper-slide">';
                			if(result[i].category == "뉴스") {
                			html += '	<a href="/ko/magazine/newsDetail'+result[i].template+'?newsCode='+result[i].pk+'" class="img_wrap" onclick="GA_main(\''+i+'theMagazine\',$(this));">';
                			} else {
                			html += '	<a href="/ko/magazine/editorials/'+result[i].pk+'" class="img_wrap" onclick="GA_main(\''+i+'theMagazine\',$(this));">';
                			}
                			if(result[i].imageUrl.indexOf(".mp4") > -1){
                			    html += '          <video autoplay muted playsinline loop preload="auto" style="width:100%; max-height:352px; auto;outline:none;" poster="">';
                			    html += '          <source src="'+result[i].imageUrl+'" type="video/mp4">';
                			    html += '          </video>';
                            }else{
                                html += '       <img src="'+result[i].imageUrl+'/dims/resize/348x352" alt="매거진이미지">';
                            }
                			
                			
                			html += '	</a>';
                			html += '	<div class="txt_wrap">';
                			html += '		<p class="magazine_tit">'+categoryText+'</p>';
                			html += '		<p class="tit">'+result[i].desktopTitle+'</p>';
                			html += '		<p class="s_t">'+result[i].desktopSubTitle+'</p>';
                			if(result[i].category == "뉴스") {
                			html += '		<a href="/ko/magazine/newsDetail'+result[i].template+'?newsCode='+result[i].pk+'" class="detail" onclick="GA_main(\''+i+'theMagazine\',$(this));">자세히 보기</a>';
                			} else {
                			html += '		<a href="/ko/magazine/editorials/'+result[i].pk+'" class="detail" onclick="GA_main(\''+i+'theMagazine\',$(this));">자세히 보기</a>';
                			}
                			html += '	</div>';
                			html += '</li>';
                			html += '';
                		}
                		$(".the_magazine_wrap1903 .magazine_slider1903 > ul").html(html);
        				magazinSlider1903();
                	}
                }
        	});
        }
        
         // 상단 띠 배너 닫기
        function popClose03() {
            $('.horiz_topbanner, .horiz_topbanner_inner').slideUp();
            if(horiz > 0) {
                $("#mainNoticeWrap").css("top","150px");
            }
        };
		
    function mainSlider1903() {
        $('.big_banner_inner').each(function(){
            if($(this).hasClass('init')){
                $(this).removeClass('init');
            }
        });
        
        /* 슬라이드 갯수에 따른 loop추가 및 제거(20210222) */
        var bannerIndex1 = $('#mainSlider1903_0 .swiper-slide').length;
        var bannerIndex2 = $('#mainSlider1903_1 .swiper-slide').length;
        var bannerIndex3 = $('#mainSlider1903_2 .swiper-slide').length;
        
        var interleaveOffset = 1;
        var swiperOptions0 = {
            initialSlide:0,
            loop: bannerIndex1 === 1 ? false:true,
            autoplay: {
                delay: 4000,
                autoplayDisableOnInteraction: true,// 쓸어 넘기거나 버튼 클릭 시 자동 슬라이드 정지.
                disableOnInteraction: false,//180911 스와이핑 후에도 자동 롤링 되도록 추가
            },
            loopAdditionalSlides: 6,
            speed: 1000,
            pagination: {
                el: '.swiper-pagination',
                clickable: true,
             	// 20200914 페이징 처리를 위한 주석처리
                /* type: 'progressbar', */
            },
            navigation: {
                nextEl: '.swiper-button-next.bigb',
                prevEl: '.swiper-button-prev.bigb',
            },
            simulateTouch:false,
            parallax: true,
            grabCursor: true,
            watchSlidesProgress: true,
            slidesPerView: 'auto',
            centeredSlides:true,
            on: {
                progress: function(){
                    var swiper = this;
                    for (var i = 0; i < swiper.slides.length; i++) {
                        var slideProgress = swiper.slides[i].progress,
                                innerOffset = swiper.width * interleaveOffset,
                                innerTranslate = slideProgress * innerOffset;
                        swiper.slides[i].querySelector(".slide-bgimg").style.transform =
                            "translate3d(" + innerTranslate + "px, 0, 0)";
                    }
                },
                touchStart: function() {
                    var swiper = this;
                    for (var i = 0; i < swiper.slides.length; i++) {
                        swiper.slides[i].style.transition = "";
                    }
                },
                setTransition: function(speed) {
                    var swiper = this;
                    for (var i = 0; i < swiper.slides.length; i++) {
                        swiper.slides[i].style.transition = speed + "ms";
                        swiper.slides[i].querySelector(".slide-bgimg").style.transition =
                            speed + "ms";
                    }
                }
            }
        }
            var swiperOptions1 = {
                initialSlide:1,
                loop: bannerIndex2 === 1 ? false:true,
                autoplay: {
                    delay: 4000,
                    autoplayDisableOnInteraction: true,// 쓸어 넘기거나 버튼 클릭 시 자동 슬라이드 정지.
                    disableOnInteraction: false,//180911 스와이핑 후에도 자동 롤링 되도록 추가
                },
                loopAdditionalSlides: 6,
                speed: 1000,
                navigation: {
                    nextEl: '.swiper-button-next.bigb',
                    prevEl: '.swiper-button-prev.bigb',
                },
                parallax: true,
                grabCursor: true,
                watchSlidesProgress: true,
                slidesPerView: 'auto',
                centeredSlides:true,
                on: {
                    progress: function(){
                        var swiper = this;
                        for (var i = 0; i < swiper.slides.length; i++) {
                            var slideProgress = swiper.slides[i].progress,
                                    innerOffset = swiper.width * interleaveOffset,
                                    innerTranslate = slideProgress * innerOffset;
                            swiper.slides[i].querySelector(".slide-bgimg").style.transform =
                                "translate3d(" + innerTranslate + "px, 0, 0)";
                        }
                    },
                    touchStart: function() {
                        var swiper = this;
                        for (var i = 0; i < swiper.slides.length; i++) {
                            swiper.slides[i].style.transition = "";
                        }
                    },
                    setTransition: function(speed) {
                        var swiper = this;
                        for (var i = 0; i < swiper.slides.length; i++) {
                            swiper.slides[i].style.transition = speed + "ms";
                            swiper.slides[i].querySelector(".slide-bgimg").style.transition =
                                speed + "ms";
                        }
                    }
                }
            }
        var swiper2length = $("#mainSlider1903_2 > ul > li").length;
        if(swiper2length > 0){
            swiper2length -= 1;
        }
                var swiperOptions2 = {
                    initialSlide: swiper2length ,
                    loop: bannerIndex3 === 1 ? false:true,
                    autoplay: {
                        delay: 4000,
                        autoplayDisableOnInteraction: true,// 쓸어 넘기거나 버튼 클릭 시 자동 슬라이드 정지.
                        disableOnInteraction: false,//180911 스와이핑 후에도 자동 롤링 되도록 추가
                    },
                    loopAdditionalSlides: 6,
                    speed: 1000,
                    navigation: {
                        nextEl: '.swiper-button-next.bigb',
                        prevEl: '.swiper-button-prev.bigb',
                    },
                    parallax: true,
                    grabCursor: true,
                    watchSlidesProgress: true,
                    slidesPerView: 'auto',
                    centeredSlides:true,
                    on: {
                        progress: function(){
                            var swiper = this;
                            for (var i = 0; i < swiper.slides.length; i++) {
                                var slideProgress = swiper.slides[i].progress,
                                        innerOffset = swiper.width * interleaveOffset,
                                        innerTranslate = slideProgress * innerOffset;
                                swiper.slides[i].querySelector(".slide-bgimg").style.transform =
                                    "translate3d(" + innerTranslate + "px, 0, 0)";
                            }
                        },
                        touchStart: function() {
                            var swiper = this;
                            for (var i = 0; i < swiper.slides.length; i++) {
                                swiper.slides[i].style.transition = "";
                            }
                        },
                        setTransition: function(speed) {
                            var swiper = this;
                            for (var i = 0; i < swiper.slides.length; i++) {
                                swiper.slides[i].style.transition = speed + "ms";
                                swiper.slides[i].querySelector(".slide-bgimg").style.transition =
                                    speed + "ms";
                            }
                        }
                    }
        };
        
        $("#mainSlider1903_1").find("div.a_txt_wrap").hide();
        $("#mainSlider1903_2").find("div.a_txt_wrap").hide();
        var swiper01 = new Swiper("#mainSlider1903_0", swiperOptions0);
        var swiper02 = new Swiper("#mainSlider1903_1", swiperOptions1);
        var swiper03 = new Swiper("#mainSlider1903_2", swiperOptions2);
    }
    
    
    function edtSlider1903(){//기획전 슬라이더
        $('.edt_banner_wrap1903 .edt_list1903').each(function(idx){
            var swiper1903 = new Swiper('#edtSlider1903_'+idx, {
                    slidesPerView: 3,
                    freeMode: false,
                    spaceBetween: 11,
                    simulateTouch:true,
                    /* scrollbar: {
                        el: '.swiper-scrollbar.bar'+idx,
                        hide: false,
                    }, */
                    pagination: {
						el: '.edt-swiper-pagination',
					},
                    navigation: {
                        nextEl: '.swiper-button-next.btn'+idx,
                        prevEl: '.swiper-button-prev.btn'+idx,
                    }
            });
            
            if($(this).find('.swiper-slide').length < 4){
                $(this).find('.swiper-button-next, .swiper-button-prev').hide();
            }
        });
    }
    
    function newProductListSlider1903(){//신상품 슬라이더
        var swiper1903 = new Swiper('#newListSlider', {
                slidesPerView: 'auto',
                freeMode: false,
//                 spaceBetween: 7,
                simulateTouch:false,
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                }
        });
    }
    function bestProductListSlider1903(){//베스트 슬라이더
        var swiper1903 = new Swiper('.product_list1903 .nbe_cnt.best .nbe_cnt_inner', {
                slidesPerView: 'auto',
                freeMode: false,
//                 spaceBetween: 7,
                simulateTouch:false,
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                }
        });
    }
    function tabNew(){
        var $newMenu = $('.product_list1903 .nbe_cnt.new .product_left_menu');
        var $newProd = $('.product_list1903 .nbe_cnt.new .nbe_cnt_inner');
        $newMenu.find('a').on('click',function(){
            $newMenu.find('li').removeClass('on');
            $(this).closest('li').addClass('on');
        });
    }
    function tabBest(){
        var $bestMenu = $('.product_list1903 .nbe_cnt.best .product_left_menu');
        var $bestProd = $('.product_list1903 .nbe_cnt.best .nbe_cnt_inner');
        $bestMenu.find('a').on('click',function(){
            $bestMenu.find('li').removeClass('on');
            $(this).closest('li').addClass('on');
        });
    }
    
    function magazinSlider1903(){
        var swiper1903 = new Swiper('#magazinSlider1903', {
               slidesPerView: 3,
               freeMode: false,
               spaceBetween: 20,
               navigation: {
                   nextEl: '.themagazine_arrow.next',
                   prevEl: '.themagazine_arrow.prev',
               }
        });
        
        $(".the_magazine_wrap1903 .themagazine_arrow.prev").css("opacity", "1");
        $(".the_magazine_wrap1903 .themagazine_arrow.next").css("opacity", "1");
        $(".the_magazine_wrap1903 .magazine_slider1903 ul").css("opacity", "1");
    }//더매거진 슬라이더
    
    function videoWidth(){
        var target = $('.video_area1903').attr('id');
        var idx = 0;
        var width = $("#"+ target +" div:eq("+idx+")").width();
        var height = $("#"+ target +"  div:eq("+idx+")").height();
        $('#'+target).find('video').css({'width':width+'px','height':height+'px'});
        $('#'+target).css({'width':width+'px','height':height+'px'});
    }
    function videoPlay1903(){
	    $('.video_area1903').children('a').on('click',function(){
	        $(this).find('.video_main').next('video').show();
	        $(this).find('.video_main').hide();
	        $('#video')[0].play();
	    });
    }
    function videoEnded(target, idx){
	    $("#"+ target +" video").hide();
	    $("#"+ target +" div:eq("+idx+")").show();
    }

    	function GA_main(action,e){
    		var index;
    		var label;
    		var eventAction;
    		if(action == "banner"){
    			label = escape(e.find('.title').text());
    			index = parseInt(e.parent().attr('data-swiper-slide-index')) + 1;
    			eventAction = "배너_"+index;
    			
    		} else if (action == "eventBanner"){
    			eventAction = "이벤트_배너";
    			label = escape(e.find('.s_title').text());
    			
    		} else if (action == "exhibitionBanner"){
    			eventAction = "기획전_배너";
    			label = escape(e.find('.s_title').text());
    			
    		} else if (action == "exhibitionListImage0"){
    			eventAction = "기획전_리스트";
    			label = escape(e.parents().find('.edt_banner_inner1 .s_title').text())+"_"+escape(e.parent().find('.title').html());
    			
    		} else if (action == "exhibitionList0"){
    			eventAction = "기획전_리스트";
    			label = escape(e.parents().find('.edt_banner_inner1 .s_title').text())+"_"+escape(e.find('.title').html());
    			
    		} else if (action == "exhibitionListImage1"){
    			eventAction = "기획전_리스트";
    			label = escape(e.parents().find('.edt_banner_inner3 .s_title').text())+"_"+escape(e.parent().find('.title').html());
    			
    		} else if (action == "exhibitionList1"){
    			eventAction = "기획전_리스트";
    			label = escape(e.parents().find('.edt_banner_inner3 .s_title').text())+"_"+escape(e.find('.title').html());
    			
    		} else if (action == "newImg") {
    			eventAction = "신상품";
    			label = escape(e.parents().find('.nbe_cnt.new li.on').text())+"_"+escape(e.find('img').attr('name'));
    			
    		} else if (action == "new") {
    			eventAction = "신상품";
    			label = escape(e.parents().find('.nbe_cnt.new li.on').text())+"_"+escape(e.parent().find('img').attr('name'));
    			
    		} else if (action == "bestImg") {
    			eventAction = "베스트";
    			label = escape(e.parents().find('.nbe_cnt.best li.on').text())+"_"+escape(e.attr('name'));
    			
    		} else if (action == "best") {
    			eventAction = "베스트";
    			label = escape(e.parents().find('.nbe_cnt.best li.on').text())+"_"+escape(e.parent().find('img').attr('name'));
    			
    		} else if (action == "exhibitionVideo"){    		
    			eventAction = "기획영상";
    			label = escape(e.parents().find('.video_main_wrap p.tit').text());
    			
    		} else if (action.indexOf("theMagazine") > -1){
    			action.split("the");
    			index = parseInt(action[0])+1;
    			eventAction = "더매거진";
    			label = index+"_"+ escape(e.parent().find('p.tit').text());
    		} else if (action == "recommend"){
    			eventAction = "당신만을위한추천";
    			label = escape(e.parent().find('.title').text());
    		} else if (action == "moment"){
    			eventAction = "한섬모먼트";
    			label = e.find('.account p').text().substring(1);
    		}
    	
    		
    		GA_Event("메인", eventAction,label);
    	}
    	
        //CMS 컴포넌트 처리용 GA 전자상거래 메인데이터
    	function setEcommerceDataCompnt(productCode, brandName, productName, location){
    	    var listNm = "";
    	    var position;
    	    if(location == "0"){
    	        listNm = "메인_기획전";
    	        position = 1;
    	    }else if(location == "1"){
                listNm = "메인_기획전_하단";
                position = 2;
            }
    	    
            dataLayer.push({
	                'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
	                'ecommerce': {
	                'currencyCode': 'KRW', //통화
	                'click': {
	                'actionField': { 'list': listNm }, //상품 리스트명
	                'products':
		                [{
			                "id": productCode.indexOf("_") > -1 ? productCode.split("_")[0] : productCode, //상품코드
			                "name": productName.replace(/\&#039;/gi,"'"), //상품명
			                "brand": brandName.replace(/\&#039;/gi,"'"), //상품 브랜드
			                "category": "", //상품 카테고리
			                "position": position //상품 위치
		                }]
	                }
                }
            });
            /* Ecommerce data 초기화
            dataLayer에 남아 있는 경우에는 전자상거래 단계만을 위해 사용하는
            필드들이 세팅되어 있으므로 undefined를 통해 초기화합니다. */
            dataLayer.push({
	            'layerCategory' : undefined,
	            'layerAction' : undefined,
	            'nonInteraction' : false,
	            'ecommerce' : undefined
            });
        }
    	
    	//기본 GA 전자상거래 메인데이터
    	function setEcommerceData(idx, type, categoryCode){
    	    var listNm = "";
    	    var position;
    	    var prodList;
    	    
    	    if(type == "NEW"){
    	        prodList = JSON.parse(window.sessionStorage.getItem('main_new_ecommerceDataList'));
    	        if(categoryCode == "WE"){
                    listNm += "메인_신상품_여성";
                    position = 3;
                }else if(categoryCode == "ME"){
                    listNm += "메인_신상품_남성";
                    position = 4;
                }
    	    }else if(type == "BEST"){
    	        prodList = JSON.parse(window.sessionStorage.getItem('main_best_ecommerceDataList'));
    	        if(categoryCode == "WE"){
                    listNm += "메인_베스트_여성";
                    position = 5;
                }else if(categoryCode == "ME"){
                    listNm += "메인_베스트_남성";
                    position = 6;
                }
            }else if(type == "RECOMMEND"){
                
                prodList = JSON.parse(window.sessionStorage.getItem('main_recommend_ecommerceDataList'));
                listNm += "메인_개인화 추천";
                position = 7;
                
    	    }
    	    
    	    if(prodList != null && typeof prodList != undefined){
                if(prodList.length > 0){
                    var prodInfo = prodList[idx];
                    
                    if(listNm != ""){
			    	    dataLayer.push({
					        'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
					        'ecommerce': {
					        'currencyCode': 'KRW', //통화
					        'click': {
						        'actionField': { 'list': listNm }, //상품 리스트명
						        'products':
							        [{
		                                'id': prodInfo.baseProductCode.indexOf("_") > -1 ? prodInfo.baseProductCode.split("_")[0] : prodInfo.baseProductCode,  //상품코드
		                                'name': prodInfo.productName, //상품명
		                                'brand': prodInfo.brandName, //상품 브랜드
		                                'category': '', //상품 카테고리
		                                'position': position //상품 위치
		                            }]
						        }
					        }
				        });
			    	    /* Ecommerce data 초기화
			            dataLayer에 남아 있는 경우에는 전자상거래 단계만을 위해 사용하는
			            필드들이 세팅되어 있으므로 undefined를 통해 초기화합니다. */
				        dataLayer.push({
					        'layerCategory' : undefined,
					        'layerAction' : undefined,
					        'nonInteraction' : false,
					        'ecommerce' : undefined
				        });
                    }
                    
                    if(type == "RECOMMEND"){
                        brazeLogCustomEvent(type, idx);
                    }
                }
    	    }
    	}

		// 환율 정보    	
		function getExchangeRate() {
			$.ajax({
				type : "get",
				url : "/ko/intro/getExchageRate",
				dataType : "json",
				async : false,
				success : function( result ) {
					if(result.length > 0) {
						for(var i=0; i < result.length; i++) {
							if(result[i].currencyCode == "USD") {
								rate_en = result[i].exchangeRate;
								symbol_en = result[i].symbol;
							} else {
								rate_zh = result[i].exchangeRate;
								symbol_zh = result[i].symbol;
							}
						}
					}
				}
			});
		}
		
		function getExchangePrice(price) {
			var exchangePrice = "";
			
					exchangePrice = "₩" + addComma(parseInt(price));
				
			
			return exchangePrice;
		}
        
	</script>

    <!-- bodyWrap -->
<div id="bodyWrap" style="padding-bottom:0;">
        <!-- layer pop-->
        <div class="notice_pop" id="mainNoticeWrap"></div>
        <div id="mainPopwrap1"></div>
        <div id="mainPopwrap2"></div>
        <div id="nightEventPopup"></div>
        <div id="membershipInfoMainWrap"></div>
        <!-- //layer pop -->
        <!-- main_container-->
        <div class="big_banner1903">
            <div class="swiper-container big_banner_inner" id="mainSlider1903_0">
                <div class="big_banner_frame"></div>
                <ul class="slides swiper-wrapper">
                   <li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220502-A-liquidesbar-07.jpg?context=bWFzdGVyfGltYWdlc3w1MDMyN3xpbWFnZS9qcGVnfGltYWdlcy9oZjIvaGY0LzkyOTU4MjM5MjkzNzQuanBnfDZmOWE0MjVmMjI3Y2ZkZmMzN2Y0YmNlMzU0MTJlOWRiNGYwY2ZlOWUzMjAyNWZkNzlkYzdiZmZlMDI0MjVmZjU);"></div>
            <a href="/ko/magazine/exhibitions/8812640949944"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">배우 이제훈이 선택한<br>리퀴드 퍼퓸바의 대표 브랜드를 소개합니다</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220502-A-liquidesbar-07.jpg?context=bWFzdGVyfGltYWdlc3w1MDMyN3xpbWFnZS9qcGVnfGltYWdlcy9oZjIvaGY0LzkyOTU4MjM5MjkzNzQuanBnfDZmOWE0MjVmMjI3Y2ZkZmMzN2Y0YmNlMzU0MTJlOWRiNGYwY2ZlOWUzMjAyNWZkNzlkYzdiZmZlMDI0MjVmZjU" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220502-pc-main-A-01.jpg?context=bWFzdGVyfGltYWdlc3wxOTAwMzF8aW1hZ2UvanBlZ3xpbWFnZXMvaGY3L2hlYi85Mjk1ODIwNTU0MjcwLmpwZ3xiZWVlNDBmN2JiMGVhZGM2MGI0NGM2NDk3MDhjNzJlYWFhZTVhYzIzZjM2OGMwMDk5ZTIzNWRiNTVjNTM5MGU4);"></div>
            <a href="/ko/magazine/events/8803990165376"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">AweSOME GIFT</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">더한섬닷컴 X 켈리박 구매 기프트<br>정상 40만원 이상 구매 시 증정</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">이벤트 자세히 보기</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220502-pc-main-A-01.jpg?context=bWFzdGVyfGltYWdlc3wxOTAwMzF8aW1hZ2UvanBlZ3xpbWFnZXMvaGY3L2hlYi85Mjk1ODIwNTU0MjcwLmpwZ3xiZWVlNDBmN2JiMGVhZGM2MGI0NGM2NDk3MDhjNzJlYWFhZTVhYzIzZjM2OGMwMDk5ZTIzNWRiNTVjNTM5MGU4" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220428-A-time-01-pc.jpg?context=bWFzdGVyfGltYWdlc3wyNjE0MTN8aW1hZ2UvanBlZ3xpbWFnZXMvaGJhL2g4ZC85Mjk1NDMwMzIwMTU4LmpwZ3xiNmVmZTAxYWQwM2ZjODJlZDNmNWFjYWFkNWM2MjA2MTVjYWJmMzFhNzQxZDRjZjQ0NjIyZjU1YTk3NTA3NDA4);"></div>
            <a href="/ko/magazine/exhibitions/8812575610552"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">The TIMEing</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">자신만의 '포에틱 시퀀스'를 찾아가는<br>타임의 무한한 여정이 펼쳐집니다</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220428-A-time-01-pc.jpg?context=bWFzdGVyfGltYWdlc3wyNjE0MTN8aW1hZ2UvanBlZ3xpbWFnZXMvaGJhL2g4ZC85Mjk1NDMwMzIwMTU4LmpwZ3xiNmVmZTAxYWQwM2ZjODJlZDNmNWFjYWFkNWM2MjA2MTVjYWJmMzFhNzQxZDRjZjQ0NjIyZjU1YTk3NTA3NDA4" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220428-A-timehomme-02.jpg?context=bWFzdGVyfGltYWdlc3wxMzgxMTF8aW1hZ2UvanBlZ3xpbWFnZXMvaDY1L2hkZi85Mjk1NDM4MjE3MjQ2LmpwZ3w0NmQzMzI4YTk3NmI2YWZjOWE3N2E4M2FjNDYzMmQ4YzdlYzdiMmRiODlhNjE1NTllNDUwOTdmMGIwZmRjNTcx);"></div>
            <a href="/ko/magazine/editorials/8805989013576"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">타임옴므가 꿈꾸는 여름</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">데님과 파스텔 컬러가 조화로운<br>타임옴므 온라인 전용 컬렉션</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">Check Out Now</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220428-A-timehomme-02.jpg?context=bWFzdGVyfGltYWdlc3wxMzgxMTF8aW1hZ2UvanBlZ3xpbWFnZXMvaDY1L2hkZi85Mjk1NDM4MjE3MjQ2LmpwZ3w0NmQzMzI4YTk3NmI2YWZjOWE3N2E4M2FjNDYzMmQ4YzdlYzdiMmRiODlhNjE1NTllNDUwOTdmMGIwZmRjNTcx" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220428-A-brand-01.jpg?context=bWFzdGVyfGltYWdlc3w4NjU3MXxpbWFnZS9qcGVnfGltYWdlcy9oMjYvaDBkLzkyOTUyMjI3MzQ4NzguanBnfDA5ZDNkMjk5MmU1NThmZTYzODE4YmZhZjY5MmYxY2ZlOGYyOTkxMjM5YTc5NmI4ODExZTE0OTU5NWQwOWM0NWM);"></div>
            <a href="/ko/magazine/exhibitions/8812608542392"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">HOLIDAY GIFT</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">고마운 마음을 전하는 계절<br>특별한 선물로 마음을 표현하세요</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220428-A-brand-01.jpg?context=bWFzdGVyfGltYWdlc3w4NjU3MXxpbWFnZS9qcGVnfGltYWdlcy9oMjYvaDBkLzkyOTUyMjI3MzQ4NzguanBnfDA5ZDNkMjk5MmU1NThmZTYzODE4YmZhZjY5MmYxY2ZlOGYyOTkxMjM5YTc5NmI4ODExZTE0OTU5NWQwOWM0NWM" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220429-A-fitguide-01.jpg?context=bWFzdGVyfGltYWdlc3wxMDExMDV8aW1hZ2UvanBlZ3xpbWFnZXMvaGNhL2hmZC85Mjk1NTQ0ODQ0MzE4LmpwZ3w3YjcwYzEyYzIwMTczNTk4ZGViNmRhYzY1NzcxZTk0Nzk5ZjVmYTBjNGI2MDg4NGUwOGNlNDY4OTIyM2VjYjRj);"></div>
            <a href="/ko/magazine/exhibitions/8812640917176"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">PANTS FIT GUIDE</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">핏가이드로 똑똑하게 쇼핑하는 법<br>더한섬닷컴 X 와이즐리 사은품 EVENT</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220429-A-fitguide-01.jpg?context=bWFzdGVyfGltYWdlc3wxMDExMDV8aW1hZ2UvanBlZ3xpbWFnZXMvaGNhL2hmZC85Mjk1NTQ0ODQ0MzE4LmpwZ3w3YjcwYzEyYzIwMTczNTk4ZGViNmRhYzY1NzcxZTk0Nzk5ZjVmYTBjNGI2MDg4NGUwOGNlNDY4OTIyM2VjYjRj" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220427-A-5new-03.jpg?context=bWFzdGVyfGltYWdlc3wxMjg1NTh8aW1hZ2UvanBlZ3xpbWFnZXMvaDI5L2hkZS85Mjk1ODEyNjU3MTgyLmpwZ3w5NDE4MDg5MDVkMWNiNjU3NTMxZGE0ZjY5NWRiMjFiM2RlOWVjY2VhMTJhZTI2OGMxZjMyYjYxODA2ZTQ0ZTE0);"></div>
            <a href="/ko/magazine/events/8803957397376"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">5월의 신규가입 Event</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">첫 구매하신 고객님께 드리는<br>산뜻한 음료 기프티콘 혜택</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">이벤트 자세히 보기</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220427-A-5new-03.jpg?context=bWFzdGVyfGltYWdlc3wxMjg1NTh8aW1hZ2UvanBlZ3xpbWFnZXMvaDI5L2hkZS85Mjk1ODEyNjU3MTgyLmpwZ3w5NDE4MDg5MDVkMWNiNjU3NTMxZGE0ZjY5NWRiMjFiM2RlOWVjY2VhMTJhZTI2OGMxZjMyYjYxODA2ZTQ0ZTE0" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220428-A-puma-02.jpg?context=bWFzdGVyfGltYWdlc3wxODg0NzV8aW1hZ2UvanBlZ3xpbWFnZXMvaGY0L2hlMy85Mjk1MjQwODIyODE0LmpwZ3xmNzdiMTMzMzVjMGM4MGM2MjQ2NzNkMTBmMjYzMzVlMGNkNjExMDI5NTkzYjFkYWY5MGFmMzI2YzYxODE3N2Q0);"></div>
            <a href="/ko/magazine/exhibitions/8812510435000"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">PUMA X GARFIELD</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">퓨마의 새로운 콜라보레이션<br>가필드와 함께한 재치있는 스트릿 웨어</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220428-A-puma-02.jpg?context=bWFzdGVyfGltYWdlc3wxODg0NzV8aW1hZ2UvanBlZ3xpbWFnZXMvaGY0L2hlMy85Mjk1MjQwODIyODE0LmpwZ3xmNzdiMTMzMzVjMGM4MGM2MjQ2NzNkMTBmMjYzMzVlMGNkNjExMDI5NTkzYjFkYWY5MGFmMzI2YzYxODE3N2Q0" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220429-A-weeklypick-03.jpg?context=bWFzdGVyfGltYWdlc3w2NzU3OXxpbWFnZS9qcGVnfGltYWdlcy9oYzcvaGM4LzkyOTU1NTEyOTk2MTQuanBnfDU2M2YzZmE5NDlmMDg3MDQ3NDBhNThkNjg2NjFiNjQ5ZTk4MDQ0ODNjMDg1NzIwMWE4Zjg4MGRiZWFkYWU2NTg);"></div>
            <a href="/ko/magazine/editorials/8805989046344"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">WOMEN'S T-SHIRTS</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">디자인별 여성 티셔츠 스타일<br>더한섬닷컴 PICK 티셔츠 추천</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">Check Out Now</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220429-A-weeklypick-03.jpg?context=bWFzdGVyfGltYWdlc3w2NzU3OXxpbWFnZS9qcGVnfGltYWdlcy9oYzcvaGM4LzkyOTU1NTEyOTk2MTQuanBnfDU2M2YzZmE5NDlmMDg3MDQ3NDBhNThkNjg2NjFiNjQ5ZTk4MDQ0ODNjMDg1NzIwMWE4Zjg4MGRiZWFkYWU2NTg" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
</ul>
            <div class="swiper-pagination"></div>
            </div>
            <div class="swiper-container big_banner_inner init" id="mainSlider1903_1" style="margin-top:-480px;left:1035px;">
                <div class="big_banner_frame"></div>
                <ul class="slides swiper-wrapper">
                   <li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220502-A-liquidesbar-07.jpg?context=bWFzdGVyfGltYWdlc3w1MDMyN3xpbWFnZS9qcGVnfGltYWdlcy9oZjIvaGY0LzkyOTU4MjM5MjkzNzQuanBnfDZmOWE0MjVmMjI3Y2ZkZmMzN2Y0YmNlMzU0MTJlOWRiNGYwY2ZlOWUzMjAyNWZkNzlkYzdiZmZlMDI0MjVmZjU);"></div>
            <a href="/ko/magazine/exhibitions/8812640949944"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">배우 이제훈이 선택한<br>리퀴드 퍼퓸바의 대표 브랜드를 소개합니다</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220502-A-liquidesbar-07.jpg?context=bWFzdGVyfGltYWdlc3w1MDMyN3xpbWFnZS9qcGVnfGltYWdlcy9oZjIvaGY0LzkyOTU4MjM5MjkzNzQuanBnfDZmOWE0MjVmMjI3Y2ZkZmMzN2Y0YmNlMzU0MTJlOWRiNGYwY2ZlOWUzMjAyNWZkNzlkYzdiZmZlMDI0MjVmZjU" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220502-pc-main-A-01.jpg?context=bWFzdGVyfGltYWdlc3wxOTAwMzF8aW1hZ2UvanBlZ3xpbWFnZXMvaGY3L2hlYi85Mjk1ODIwNTU0MjcwLmpwZ3xiZWVlNDBmN2JiMGVhZGM2MGI0NGM2NDk3MDhjNzJlYWFhZTVhYzIzZjM2OGMwMDk5ZTIzNWRiNTVjNTM5MGU4);"></div>
            <a href="/ko/magazine/events/8803990165376"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">AweSOME GIFT</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">더한섬닷컴 X 켈리박 구매 기프트<br>정상 40만원 이상 구매 시 증정</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">이벤트 자세히 보기</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220502-pc-main-A-01.jpg?context=bWFzdGVyfGltYWdlc3wxOTAwMzF8aW1hZ2UvanBlZ3xpbWFnZXMvaGY3L2hlYi85Mjk1ODIwNTU0MjcwLmpwZ3xiZWVlNDBmN2JiMGVhZGM2MGI0NGM2NDk3MDhjNzJlYWFhZTVhYzIzZjM2OGMwMDk5ZTIzNWRiNTVjNTM5MGU4" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220428-A-time-01-pc.jpg?context=bWFzdGVyfGltYWdlc3wyNjE0MTN8aW1hZ2UvanBlZ3xpbWFnZXMvaGJhL2g4ZC85Mjk1NDMwMzIwMTU4LmpwZ3xiNmVmZTAxYWQwM2ZjODJlZDNmNWFjYWFkNWM2MjA2MTVjYWJmMzFhNzQxZDRjZjQ0NjIyZjU1YTk3NTA3NDA4);"></div>
            <a href="/ko/magazine/exhibitions/8812575610552"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">The TIMEing</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">자신만의 '포에틱 시퀀스'를 찾아가는<br>타임의 무한한 여정이 펼쳐집니다</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220428-A-time-01-pc.jpg?context=bWFzdGVyfGltYWdlc3wyNjE0MTN8aW1hZ2UvanBlZ3xpbWFnZXMvaGJhL2g4ZC85Mjk1NDMwMzIwMTU4LmpwZ3xiNmVmZTAxYWQwM2ZjODJlZDNmNWFjYWFkNWM2MjA2MTVjYWJmMzFhNzQxZDRjZjQ0NjIyZjU1YTk3NTA3NDA4" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220428-A-timehomme-02.jpg?context=bWFzdGVyfGltYWdlc3wxMzgxMTF8aW1hZ2UvanBlZ3xpbWFnZXMvaDY1L2hkZi85Mjk1NDM4MjE3MjQ2LmpwZ3w0NmQzMzI4YTk3NmI2YWZjOWE3N2E4M2FjNDYzMmQ4YzdlYzdiMmRiODlhNjE1NTllNDUwOTdmMGIwZmRjNTcx);"></div>
            <a href="/ko/magazine/editorials/8805989013576"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">타임옴므가 꿈꾸는 여름</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">데님과 파스텔 컬러가 조화로운<br>타임옴므 온라인 전용 컬렉션</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">Check Out Now</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220428-A-timehomme-02.jpg?context=bWFzdGVyfGltYWdlc3wxMzgxMTF8aW1hZ2UvanBlZ3xpbWFnZXMvaDY1L2hkZi85Mjk1NDM4MjE3MjQ2LmpwZ3w0NmQzMzI4YTk3NmI2YWZjOWE3N2E4M2FjNDYzMmQ4YzdlYzdiMmRiODlhNjE1NTllNDUwOTdmMGIwZmRjNTcx" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220428-A-brand-01.jpg?context=bWFzdGVyfGltYWdlc3w4NjU3MXxpbWFnZS9qcGVnfGltYWdlcy9oMjYvaDBkLzkyOTUyMjI3MzQ4NzguanBnfDA5ZDNkMjk5MmU1NThmZTYzODE4YmZhZjY5MmYxY2ZlOGYyOTkxMjM5YTc5NmI4ODExZTE0OTU5NWQwOWM0NWM);"></div>
            <a href="/ko/magazine/exhibitions/8812608542392"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">HOLIDAY GIFT</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">고마운 마음을 전하는 계절<br>특별한 선물로 마음을 표현하세요</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220428-A-brand-01.jpg?context=bWFzdGVyfGltYWdlc3w4NjU3MXxpbWFnZS9qcGVnfGltYWdlcy9oMjYvaDBkLzkyOTUyMjI3MzQ4NzguanBnfDA5ZDNkMjk5MmU1NThmZTYzODE4YmZhZjY5MmYxY2ZlOGYyOTkxMjM5YTc5NmI4ODExZTE0OTU5NWQwOWM0NWM" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220429-A-fitguide-01.jpg?context=bWFzdGVyfGltYWdlc3wxMDExMDV8aW1hZ2UvanBlZ3xpbWFnZXMvaGNhL2hmZC85Mjk1NTQ0ODQ0MzE4LmpwZ3w3YjcwYzEyYzIwMTczNTk4ZGViNmRhYzY1NzcxZTk0Nzk5ZjVmYTBjNGI2MDg4NGUwOGNlNDY4OTIyM2VjYjRj);"></div>
            <a href="/ko/magazine/exhibitions/8812640917176"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">PANTS FIT GUIDE</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">핏가이드로 똑똑하게 쇼핑하는 법<br>더한섬닷컴 X 와이즐리 사은품 EVENT</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220429-A-fitguide-01.jpg?context=bWFzdGVyfGltYWdlc3wxMDExMDV8aW1hZ2UvanBlZ3xpbWFnZXMvaGNhL2hmZC85Mjk1NTQ0ODQ0MzE4LmpwZ3w3YjcwYzEyYzIwMTczNTk4ZGViNmRhYzY1NzcxZTk0Nzk5ZjVmYTBjNGI2MDg4NGUwOGNlNDY4OTIyM2VjYjRj" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220427-A-5new-03.jpg?context=bWFzdGVyfGltYWdlc3wxMjg1NTh8aW1hZ2UvanBlZ3xpbWFnZXMvaDI5L2hkZS85Mjk1ODEyNjU3MTgyLmpwZ3w5NDE4MDg5MDVkMWNiNjU3NTMxZGE0ZjY5NWRiMjFiM2RlOWVjY2VhMTJhZTI2OGMxZjMyYjYxODA2ZTQ0ZTE0);"></div>
            <a href="/ko/magazine/events/8803957397376"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">5월의 신규가입 Event</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">첫 구매하신 고객님께 드리는<br>산뜻한 음료 기프티콘 혜택</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">이벤트 자세히 보기</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220427-A-5new-03.jpg?context=bWFzdGVyfGltYWdlc3wxMjg1NTh8aW1hZ2UvanBlZ3xpbWFnZXMvaDI5L2hkZS85Mjk1ODEyNjU3MTgyLmpwZ3w5NDE4MDg5MDVkMWNiNjU3NTMxZGE0ZjY5NWRiMjFiM2RlOWVjY2VhMTJhZTI2OGMxZjMyYjYxODA2ZTQ0ZTE0" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220428-A-puma-02.jpg?context=bWFzdGVyfGltYWdlc3wxODg0NzV8aW1hZ2UvanBlZ3xpbWFnZXMvaGY0L2hlMy85Mjk1MjQwODIyODE0LmpwZ3xmNzdiMTMzMzVjMGM4MGM2MjQ2NzNkMTBmMjYzMzVlMGNkNjExMDI5NTkzYjFkYWY5MGFmMzI2YzYxODE3N2Q0);"></div>
            <a href="/ko/magazine/exhibitions/8812510435000"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">PUMA X GARFIELD</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">퓨마의 새로운 콜라보레이션<br>가필드와 함께한 재치있는 스트릿 웨어</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220428-A-puma-02.jpg?context=bWFzdGVyfGltYWdlc3wxODg0NzV8aW1hZ2UvanBlZ3xpbWFnZXMvaGY0L2hlMy85Mjk1MjQwODIyODE0LmpwZ3xmNzdiMTMzMzVjMGM4MGM2MjQ2NzNkMTBmMjYzMzVlMGNkNjExMDI5NTkzYjFkYWY5MGFmMzI2YzYxODE3N2Q0" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220429-A-weeklypick-03.jpg?context=bWFzdGVyfGltYWdlc3w2NzU3OXxpbWFnZS9qcGVnfGltYWdlcy9oYzcvaGM4LzkyOTU1NTEyOTk2MTQuanBnfDU2M2YzZmE5NDlmMDg3MDQ3NDBhNThkNjg2NjFiNjQ5ZTk4MDQ0ODNjMDg1NzIwMWE4Zjg4MGRiZWFkYWU2NTg);"></div>
            <a href="/ko/magazine/editorials/8805989046344"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">WOMEN'S T-SHIRTS</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">디자인별 여성 티셔츠 스타일<br>더한섬닷컴 PICK 티셔츠 추천</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">Check Out Now</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220429-A-weeklypick-03.jpg?context=bWFzdGVyfGltYWdlc3w2NzU3OXxpbWFnZS9qcGVnfGltYWdlcy9oYzcvaGM4LzkyOTU1NTEyOTk2MTQuanBnfDU2M2YzZmE5NDlmMDg3MDQ3NDBhNThkNjg2NjFiNjQ5ZTk4MDQ0ODNjMDg1NzIwMWE4Zjg4MGRiZWFkYWU2NTg" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
</ul>                
            </div>
            <div class="swiper-container big_banner_inner init" id="mainSlider1903_2" style="margin-top:-480px;left:-1035px;">
                <div class="big_banner_frame"></div>
                <ul class="slides swiper-wrapper">
                   <li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220502-A-liquidesbar-07.jpg?context=bWFzdGVyfGltYWdlc3w1MDMyN3xpbWFnZS9qcGVnfGltYWdlcy9oZjIvaGY0LzkyOTU4MjM5MjkzNzQuanBnfDZmOWE0MjVmMjI3Y2ZkZmMzN2Y0YmNlMzU0MTJlOWRiNGYwY2ZlOWUzMjAyNWZkNzlkYzdiZmZlMDI0MjVmZjU);"></div>
            <a href="/ko/magazine/exhibitions/8812640949944"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">배우 이제훈이 선택한<br>리퀴드 퍼퓸바의 대표 브랜드를 소개합니다</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220502-A-liquidesbar-07.jpg?context=bWFzdGVyfGltYWdlc3w1MDMyN3xpbWFnZS9qcGVnfGltYWdlcy9oZjIvaGY0LzkyOTU4MjM5MjkzNzQuanBnfDZmOWE0MjVmMjI3Y2ZkZmMzN2Y0YmNlMzU0MTJlOWRiNGYwY2ZlOWUzMjAyNWZkNzlkYzdiZmZlMDI0MjVmZjU" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220502-pc-main-A-01.jpg?context=bWFzdGVyfGltYWdlc3wxOTAwMzF8aW1hZ2UvanBlZ3xpbWFnZXMvaGY3L2hlYi85Mjk1ODIwNTU0MjcwLmpwZ3xiZWVlNDBmN2JiMGVhZGM2MGI0NGM2NDk3MDhjNzJlYWFhZTVhYzIzZjM2OGMwMDk5ZTIzNWRiNTVjNTM5MGU4);"></div>
            <a href="/ko/magazine/events/8803990165376"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">AweSOME GIFT</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">더한섬닷컴 X 켈리박 구매 기프트<br>정상 40만원 이상 구매 시 증정</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">이벤트 자세히 보기</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220502-pc-main-A-01.jpg?context=bWFzdGVyfGltYWdlc3wxOTAwMzF8aW1hZ2UvanBlZ3xpbWFnZXMvaGY3L2hlYi85Mjk1ODIwNTU0MjcwLmpwZ3xiZWVlNDBmN2JiMGVhZGM2MGI0NGM2NDk3MDhjNzJlYWFhZTVhYzIzZjM2OGMwMDk5ZTIzNWRiNTVjNTM5MGU4" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220428-A-time-01-pc.jpg?context=bWFzdGVyfGltYWdlc3wyNjE0MTN8aW1hZ2UvanBlZ3xpbWFnZXMvaGJhL2g4ZC85Mjk1NDMwMzIwMTU4LmpwZ3xiNmVmZTAxYWQwM2ZjODJlZDNmNWFjYWFkNWM2MjA2MTVjYWJmMzFhNzQxZDRjZjQ0NjIyZjU1YTk3NTA3NDA4);"></div>
            <a href="/ko/magazine/exhibitions/8812575610552"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">The TIMEing</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">자신만의 '포에틱 시퀀스'를 찾아가는<br>타임의 무한한 여정이 펼쳐집니다</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220428-A-time-01-pc.jpg?context=bWFzdGVyfGltYWdlc3wyNjE0MTN8aW1hZ2UvanBlZ3xpbWFnZXMvaGJhL2g4ZC85Mjk1NDMwMzIwMTU4LmpwZ3xiNmVmZTAxYWQwM2ZjODJlZDNmNWFjYWFkNWM2MjA2MTVjYWJmMzFhNzQxZDRjZjQ0NjIyZjU1YTk3NTA3NDA4" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220428-A-timehomme-02.jpg?context=bWFzdGVyfGltYWdlc3wxMzgxMTF8aW1hZ2UvanBlZ3xpbWFnZXMvaDY1L2hkZi85Mjk1NDM4MjE3MjQ2LmpwZ3w0NmQzMzI4YTk3NmI2YWZjOWE3N2E4M2FjNDYzMmQ4YzdlYzdiMmRiODlhNjE1NTllNDUwOTdmMGIwZmRjNTcx);"></div>
            <a href="/ko/magazine/editorials/8805989013576"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">타임옴므가 꿈꾸는 여름</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">데님과 파스텔 컬러가 조화로운<br>타임옴므 온라인 전용 컬렉션</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">Check Out Now</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220428-A-timehomme-02.jpg?context=bWFzdGVyfGltYWdlc3wxMzgxMTF8aW1hZ2UvanBlZ3xpbWFnZXMvaDY1L2hkZi85Mjk1NDM4MjE3MjQ2LmpwZ3w0NmQzMzI4YTk3NmI2YWZjOWE3N2E4M2FjNDYzMmQ4YzdlYzdiMmRiODlhNjE1NTllNDUwOTdmMGIwZmRjNTcx" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220428-A-brand-01.jpg?context=bWFzdGVyfGltYWdlc3w4NjU3MXxpbWFnZS9qcGVnfGltYWdlcy9oMjYvaDBkLzkyOTUyMjI3MzQ4NzguanBnfDA5ZDNkMjk5MmU1NThmZTYzODE4YmZhZjY5MmYxY2ZlOGYyOTkxMjM5YTc5NmI4ODExZTE0OTU5NWQwOWM0NWM);"></div>
            <a href="/ko/magazine/exhibitions/8812608542392"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">HOLIDAY GIFT</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">고마운 마음을 전하는 계절<br>특별한 선물로 마음을 표현하세요</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220428-A-brand-01.jpg?context=bWFzdGVyfGltYWdlc3w4NjU3MXxpbWFnZS9qcGVnfGltYWdlcy9oMjYvaDBkLzkyOTUyMjI3MzQ4NzguanBnfDA5ZDNkMjk5MmU1NThmZTYzODE4YmZhZjY5MmYxY2ZlOGYyOTkxMjM5YTc5NmI4ODExZTE0OTU5NWQwOWM0NWM" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220429-A-fitguide-01.jpg?context=bWFzdGVyfGltYWdlc3wxMDExMDV8aW1hZ2UvanBlZ3xpbWFnZXMvaGNhL2hmZC85Mjk1NTQ0ODQ0MzE4LmpwZ3w3YjcwYzEyYzIwMTczNTk4ZGViNmRhYzY1NzcxZTk0Nzk5ZjVmYTBjNGI2MDg4NGUwOGNlNDY4OTIyM2VjYjRj);"></div>
            <a href="/ko/magazine/exhibitions/8812640917176"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">PANTS FIT GUIDE</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">핏가이드로 똑똑하게 쇼핑하는 법<br>더한섬닷컴 X 와이즐리 사은품 EVENT</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220429-A-fitguide-01.jpg?context=bWFzdGVyfGltYWdlc3wxMDExMDV8aW1hZ2UvanBlZ3xpbWFnZXMvaGNhL2hmZC85Mjk1NTQ0ODQ0MzE4LmpwZ3w3YjcwYzEyYzIwMTczNTk4ZGViNmRhYzY1NzcxZTk0Nzk5ZjVmYTBjNGI2MDg4NGUwOGNlNDY4OTIyM2VjYjRj" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220427-A-5new-03.jpg?context=bWFzdGVyfGltYWdlc3wxMjg1NTh8aW1hZ2UvanBlZ3xpbWFnZXMvaDI5L2hkZS85Mjk1ODEyNjU3MTgyLmpwZ3w5NDE4MDg5MDVkMWNiNjU3NTMxZGE0ZjY5NWRiMjFiM2RlOWVjY2VhMTJhZTI2OGMxZjMyYjYxODA2ZTQ0ZTE0);"></div>
            <a href="/ko/magazine/events/8803957397376"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">5월의 신규가입 Event</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">첫 구매하신 고객님께 드리는<br>산뜻한 음료 기프티콘 혜택</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">이벤트 자세히 보기</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220427-A-5new-03.jpg?context=bWFzdGVyfGltYWdlc3wxMjg1NTh8aW1hZ2UvanBlZ3xpbWFnZXMvaDI5L2hkZS85Mjk1ODEyNjU3MTgyLmpwZ3w5NDE4MDg5MDVkMWNiNjU3NTMxZGE0ZjY5NWRiMjFiM2RlOWVjY2VhMTJhZTI2OGMxZjMyYjYxODA2ZTQ0ZTE0" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220428-A-puma-02.jpg?context=bWFzdGVyfGltYWdlc3wxODg0NzV8aW1hZ2UvanBlZ3xpbWFnZXMvaGY0L2hlMy85Mjk1MjQwODIyODE0LmpwZ3xmNzdiMTMzMzVjMGM4MGM2MjQ2NzNkMTBmMjYzMzVlMGNkNjExMDI5NTkzYjFkYWY5MGFmMzI2YzYxODE3N2Q0);"></div>
            <a href="/ko/magazine/exhibitions/8812510435000"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">PUMA X GARFIELD</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">퓨마의 새로운 콜라보레이션<br>가필드와 함께한 재치있는 스트릿 웨어</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220428-A-puma-02.jpg?context=bWFzdGVyfGltYWdlc3wxODg0NzV8aW1hZ2UvanBlZ3xpbWFnZXMvaGY0L2hlMy85Mjk1MjQwODIyODE0LmpwZ3xmNzdiMTMzMzVjMGM4MGM2MjQ2NzNkMTBmMjYzMzVlMGNkNjExMDI5NTkzYjFkYWY5MGFmMzI2YzYxODE3N2Q0" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(/resources/medias/220429-A-weeklypick-03.jpg?context=bWFzdGVyfGltYWdlc3w2NzU3OXxpbWFnZS9qcGVnfGltYWdlcy9oYzcvaGM4LzkyOTU1NTEyOTk2MTQuanBnfDU2M2YzZmE5NDlmMDg3MDQ3NDBhNThkNjg2NjFiNjQ5ZTk4MDQ0ODNjMDg1NzIwMWE4Zjg4MGRiZWFkYWU2NTg);"></div>
            <a href="/ko/magazine/editorials/8805989046344"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">WOMEN'S T-SHIRTS</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">디자인별 여성 티셔츠 스타일<br>더한섬닷컴 PICK 티셔츠 추천</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">Check Out Now</div>
                    </div>
                <div class="v_img">
                    <img src="/medias/220429-A-weeklypick-03.jpg?context=bWFzdGVyfGltYWdlc3w2NzU3OXxpbWFnZS9qcGVnfGltYWdlcy9oYzcvaGM4LzkyOTU1NTEyOTk2MTQuanBnfDU2M2YzZmE5NDlmMDg3MDQ3NDBhNThkNjg2NjFiNjQ5ZTk4MDQ0ODNjMDg1NzIwMWE4Zjg4MGRiZWFkYWU2NTg" alt="" class="entity-img"/>
                </div>
            </a>
                </li>
</ul>                
            </div>
            <div class="swiper-button-prev bigb"></div>
            <div class="swiper-button-next bigb"></div>
        </div>
        <div class="main_container">
            <div class="mid_banner" style="display:none;">
                <div class="banner1 banner1_N" style="display:none;">
			        <a href="/ko/c/we09v/#1_0_0_0_0_14_0_0_0"  onclick="GA_main('eventBanner',$(this));" >
			            <img src="/medias/220428-2-1-mine-01.jpg?context=bWFzdGVyfGltYWdlc3wxMjI4MnxpbWFnZS9qcGVnfGltYWdlcy9oZjYvaDRkLzkyOTUyMjEwNjM3MTAuanBnfGE4Yzc1YTZjNjEzYjA5MTIwYjZiZDE2MGE5N2FjN2I4YzY5NDNkNGI4YjFjYjA3MjUyNDU3YWI1NGMzYjVjMTQ" alt="banner image" />
		                <div class="ban_txt_wrap">
		                    <p class="title">CODE MINE : E</p>
		                    <p class="s_title">마인식으로 새롭게 정의한 아웃도어</p>
		                </div>
			        </a>
			    </div>
			 	<div class="banner1 banner1_N" style="display:none;">
			        <a href="/ko/magazine/exhibitions/8812444309176"  onclick="GA_main('eventBanner',$(this));" >
			            <img src="/medias/220421-2-1-tom-01.jpg?context=bWFzdGVyfGltYWdlc3wxNzAyMXxpbWFnZS9qcGVnfGltYWdlcy9oM2YvaDEwLzkyOTMzMzQ5NzAzOTguanBnfDkyMzFkNmU1N2E5MGYxOTdmNTdkMTZkM2ExZTBjZjk1ZTE0NDFhMjQ4MGY3OWMxYTNiY2I4ZGIyODJkYjVhZmQ" alt="banner image" />
		                <div class="ban_txt_wrap">
		                    <p class="title"><font color=white>TOM LIFESTYLE</font></p>
		                    <p class="s_title"><font color=white>봄의 에너지를 담은 테이블웨어</font></p>
		                </div>
			        </a>
			    </div>
			    <div class="banner2 banner2_N" style="display:none;">
			        <a href="/ko/magazine/events/8804022966144"  onclick="GA_main('eventBanner',$(this));" >
			            <img src="/medias/220428-2-2-payco-02.jpg?context=bWFzdGVyfGltYWdlc3wxNTEwOXxpbWFnZS9qcGVnfGltYWdlcy9oNjQvaDgyLzkyOTU4Mjg3NDYyNzAuanBnfDFmM2Q4MmMxZGEzZDhjMThhMjc5N2I0NDI5Y2FiNTgyNGVhMmJiYWMyNzliZDdhOTZhNTA4NDEyMjlkYWI5OGY" alt="banner image" />
		                <div class="ban_txt_wrap">
		                    <p class="title"><font color=white>PAYCO 결제 혜택</font> </p>
		                    <p class="s_title"><font color=white>최대 2% 포인트 리워드를 드려요!</font></p>
		                </div>
			        </a>
			    </div>
			 	<div class="banner2 banner2_N" style="display:none;">
			        <a href="/ko/c/we094/#1_0_0_0_0_14_0_0_0"  onclick="GA_main('eventBanner',$(this));" >
			            <img src="/medias/220429-2-2-sjsj-01.jpg?context=bWFzdGVyfGltYWdlc3wxNDQyNHxpbWFnZS9qcGVnfGltYWdlcy9oNmUvaGIxLzkyOTU1NDQ5NzUzOTAuanBnfDBmMjlkODM4YmEyNGNhZjY1ZTBjNjZhZjliMGFmMmM0NTM1ZjBhNjFmMTY0YTU4ODQyZmNjMTgxNDJlMDY5NGM" alt="banner image" />
		                <div class="ban_txt_wrap">
		                    <p class="title"><font color=white>Scent in Tales</font> </p>
		                    <p class="s_title"><font color=white>향을 품은 SJSJ의 캡슐 컬렉션</font></p>
		                </div>
			        </a>
			    </div>
			 </div>
            <div class="edt_banner_wrap1903">
              <h4 class="tit">기획전</h4>
              <div class="edt_banner_inner1">
 <div class="edt_banner">
       <a href="/ko/magazine/exhibitions/8812510271160"  onclick="GA_main('exhibitionBanner',$(this));">
           <img src="/resources/medias/220428-B-obzee.jpg?context=bWFzdGVyfGltYWdlc3w4NTQwM3xpbWFnZS9qcGVnfGltYWdlcy9oNzAvaDNiLzkyOTUyMjE2ODYzMDIuanBnfGRkYTRiNWJmY2IxYTBlNTFjNTZiODM2MTQ2MWZhODhiYmNhNDRiYTRjY2EzYTY1YjgzMWM1ZWExMTc2YTcwYTM" alt="기획전 배너">
           <div class="ban_txt_wrap">
               <span class="sticker" style="background:#99a5d7;">style guide</span>
               <p class="s_title">
                   <font color="#FFFFFF">써머 리조트룩을 재해석한 뉴 컬렉션</font>
               </p>
               <p class="title">
                   <span class="bar-in">
                       <font color="#FFFFFF">YACHTIE OBZÉÉ</font>
                       <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
					   <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                   </span>
               </p>
           </div>
       </a>
   </div>
   <div class="edt_list1903">
       <!-- 여기 확인. 오브제 써머 반복 -->
       <div class="edt_list_inner swiper-container" id="edtSlider1903_0">
           <p class="tit">OBZÉÉ SUMMER</p>
           <ul class="swiper-wrapper">
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/ko/p/OB2C4WOP536W_BL" class="item_info1" onclick="GA_main('exhibitionListImage0',$(this));setEcommerceDataCompnt('OB2C4WOP536W_BL','OBZEE','[YACHTIE] 프린팅 노트 플리츠 드레스', '0');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/OB/2C/SS/OB2C4WOP536W_BL_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/ko/p/OB2C4WOP536W_BL" class="item_info2" onclick="GA_main('exhibitionList0',$(this));setEcommerceDataCompnt('OB2C4WOP536W_BL','OBZEE','[YACHTIE] 프린팅 노트 플리츠 드레스', '0');">
                           <span class="brand">OBZEE</span>
                           <span class="title">[YACHTIE] 프린팅 노트 플리츠 드레스</span>
                           <span class="price">₩745,000</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/ko/p/OB2C4WVT049W_LB" class="item_info1" onclick="GA_main('exhibitionListImage0',$(this));setEcommerceDataCompnt('OB2C4WVT049W_LB','OBZEE','[YACHTIE] 세일러 칼라 체인 베스트', '0');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/OB/2C/SS/OB2C4WVT049W_LB_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/ko/p/OB2C4WVT049W_LB" class="item_info2" onclick="GA_main('exhibitionList0',$(this));setEcommerceDataCompnt('OB2C4WVT049W_LB','OBZEE','[YACHTIE] 세일러 칼라 체인 베스트', '0');">
                           <span class="brand">OBZEE</span>
                           <span class="title">[YACHTIE] 세일러 칼라 체인 베스트</span>
                           <span class="price">₩995,000</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/ko/p/OB2C4WPC324W_CR" class="item_info1" onclick="GA_main('exhibitionListImage0',$(this));setEcommerceDataCompnt('OB2C4WPC324W_CR','OBZEE','[YACHTIE] 린넨 블렌드 핀턱 와이드 팬츠', '0');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/OB/2C/SS/OB2C4WPC324W_CR_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/ko/p/OB2C4WPC324W_CR" class="item_info2" onclick="GA_main('exhibitionList0',$(this));setEcommerceDataCompnt('OB2C4WPC324W_CR','OBZEE','[YACHTIE] 린넨 블렌드 핀턱 와이드 팬츠', '0');">
                           <span class="brand">OBZEE</span>
                           <span class="title">[YACHTIE] 린넨 블렌드 핀턱 와이드 팬츠</span>
                           <span class="price">₩425,000</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/ko/p/OB2C4WOP530W_AB" class="item_info1" onclick="GA_main('exhibitionListImage0',$(this));setEcommerceDataCompnt('OB2C4WOP530W_AB','OBZEE','[YACHTIE] 벌룬 슬리브 프릴 칼라 드레스', '0');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/OB/2C/SS/OB2C4WOP530W_AB_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/ko/p/OB2C4WOP530W_AB" class="item_info2" onclick="GA_main('exhibitionList0',$(this));setEcommerceDataCompnt('OB2C4WOP530W_AB','OBZEE','[YACHTIE] 벌룬 슬리브 프릴 칼라 드레스', '0');">
                           <span class="brand">OBZEE</span>
                           <span class="title">[YACHTIE] 벌룬 슬리브 프릴 칼라 드레스</span>
                           <span class="price">₩695,000</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/ko/p/OB2C4WJC047W_YN" class="item_info1" onclick="GA_main('exhibitionListImage0',$(this));setEcommerceDataCompnt('OB2C4WJC047W_YN','OBZEE','[YACHTIE] 린넨 블렌드 벨티드 싱글 재킷', '0');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/OB/2C/SS/OB2C4WJC047W_YN_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/ko/p/OB2C4WJC047W_YN" class="item_info2" onclick="GA_main('exhibitionList0',$(this));setEcommerceDataCompnt('OB2C4WJC047W_YN','OBZEE','[YACHTIE] 린넨 블렌드 벨티드 싱글 재킷', '0');">
                           <span class="brand">OBZEE</span>
                           <span class="title">[YACHTIE] 린넨 블렌드 벨티드 싱글 재킷</span>
                           <span class="price">₩645,000</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/ko/p/OB2C4WPC338W_BK" class="item_info1" onclick="GA_main('exhibitionListImage0',$(this));setEcommerceDataCompnt('OB2C4WPC338W_BK','OBZEE','[YACHTIE] 핀턱 와이드 쇼츠', '0');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/OB/2C/SS/OB2C4WPC338W_BK_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/ko/p/OB2C4WPC338W_BK" class="item_info2" onclick="GA_main('exhibitionList0',$(this));setEcommerceDataCompnt('OB2C4WPC338W_BK','OBZEE','[YACHTIE] 핀턱 와이드 쇼츠', '0');">
                           <span class="brand">OBZEE</span>
                           <span class="title">[YACHTIE] 핀턱 와이드 쇼츠</span>
                           <span class="price">₩395,000</span>
                       </a>
                   </div>
               </li>
               </ul>
           <div class="edt-swiper-pagination"></div>
       </div>
       <div class="swiper-button-next btn0"></div>
       <div class="swiper-button-prev btn0"></div>
    </div>
</div>
<div class="edt_banner_inner2">
   <div class="edt_banner">
      <ul>
 <li> 
     <!-- 하드코딩 -->
            <a href="/ko/magazine/exhibitions/8812509845176"  target="_blank" onclick="GA_main('exhibitionBanner',$(this));">
                <img src="/resources/medias/220428-C-fourm.jpg?context=bWFzdGVyfGltYWdlc3w1Njk0NXxpbWFnZS9qcGVnfGltYWdlcy9oNzcvaGI0LzkyOTUyMjE4ODI5MTAuanBnfDFmN2VlMjFmYTc1N2UwYWY5MDg0MTk0MDgzZDljNDhmYWI0MzE2OWVjZjE2ZDhjOWQ1NDNlYTdjZjg1NWU5YWM" alt="기획전 배너">
                <div class="ban_txt_wrap">
                   <span class="sticker" style="background:#86B404">exclusive</span>
                   <p class="s_title"><font color="#FFFFFF">봄과 여름 사이, 폼더스토어의 새로운 팔레트</font></p>
                   <p class="title"><font color="#FFFFFF">NEW PALETTE</font></p>
               </div>
            </a>
        </li>
<li>
            <a href="/ko/magazine/exhibitions/8812477109944"  onclick="GA_main('exhibitionBanner',$(this));">
                <img src="/resources/medias/220428-C-phillip.jpg?context=bWFzdGVyfGltYWdlc3wxMDk1ODR8aW1hZ2UvanBlZ3xpbWFnZXMvaDI0L2gwMy85Mjk1MjIyMDEzOTgyLmpwZ3xhN2E1MjAzOWE3NWJkNmU0ZTYyYWE3NmNjNjFhODc3MmQ2NDQzZDkwNjg4N2NiNmZhMTBjOWRiNWZkNWUyNjA4" alt="기획전 배너">
                <div class="ban_txt_wrap">
                   <span class="sticker" style="background:#e16a6a;">new</span>
                   <p class="s_title"><font color="#ffffff">현대인을 위한 필립림의 쿨 이지웨어</font></p>
                   <p class="title"><font color="#ffffff">LIVE FREE</font></p>
               </div>
            </a>
        </li>
<li>
            <a href="/ko/magazine/exhibitions/8812477601464"  onclick="GA_main('exhibitionBanner',$(this));">
                <img src="/resources/medias/220428-C-brand.jpg?context=bWFzdGVyfGltYWdlc3w2NTk4NnxpbWFnZS9qcGVnfGltYWdlcy9oNDYvaDQ1LzkyOTUyMjIyMTA1OTAuanBnfGE4NjE3YjVkYjM0OWJiNjFiMDNjZjhiMTZlNmZjNjExNzgzYWIxNjJhZWFkZjE2NjQ5MGZhMzVlZjkxYjVhZjc" alt="기획전 배너">
                <div class="ban_txt_wrap">
                   <span class="sticker" style="background:#e99143;">we love</span>
                   <p class="s_title"><font color="#FFFFFF">발리의 새로운 아이코닉 라인 #CABANA</font></p>
                   <p class="title"><font color="#FFFFFF">BALLY CABANA</font></p>
               </div>
            </a>
        </li>
</ul>
    </div>
</div>
<div class="edt_banner_inner3">
<div class="edt_banner">
       <a href="/ko/magazine/exhibitions/8812182394552"  onclick="GA_main('exhibitionBanner',$(this));">
           <img src="/resources/medias/220428-B-clubmonaco.jpg?context=bWFzdGVyfGltYWdlc3w1OTU2NnxpbWFnZS9qcGVnfGltYWdlcy9oZWYvaDMxLzkyOTUyMjIyNzYxMjYuanBnfDg0Yzg0ZDhkOTYzYzdmMGRkMDE4ODE4Nzk1YjJkODhiN2ViODRmMmNiMDgyMDAwZjRmOGY2YWRlYWQ2NWZhNDA" alt="기획전 배너">
           <div class="ban_txt_wrap">
               <span class="sticker" style="background:#e16a6a;">new</span>
               <p class="s_title">
                   <font color="#ffffff">클럽모나코 22SS 티셔츠 컬렉션</font>
               </p>
               <p class="title">
                   <span class="bar-in">
                       <font color="#ffffff">MODERN & MINIMAL</font>
                       <span class="ab-bar left" style="background-color:#ffffff;"></span>
					   <span class="ab-bar right" style="background-color:#ffffff;"></span>
                   </span>
               </p>
           </div>
       </a>
   </div>
   <!-- 여기도 스와이퍼. 반복 처리 고민 -->
   <div class="edt_list1903">
       <div class="edt_list_inner swiper-container" id="edtSlider1903_1">
           <p class="tit">CLUB MONACO</p>
           <ul class="swiper-wrapper">
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/ko/p/MM2C3TTS025H4A_MB" class="item_info1" onclick="GA_main('exhibitionListImage1',$(this));setEcommerceDataCompnt('MM2C3TTS025H4A_MB','CLUB MONACO','오픈 칼라 티셔츠', '1');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/MM/2C/SS/MM2C3TTS025H4A_MB_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/ko/p/MM2C3TTS025H4A_MB" class="item_info2" onclick="GA_main('exhibitionList1',$(this));setEcommerceDataCompnt('MM2C3TTS025H4A_MB','CLUB MONACO','오픈 칼라 티셔츠', '1');">
                           <span class="brand">CLUB MONACO</span>
                           <span class="title">오픈 칼라 티셔츠</span>
                           <span class="price">₩158,000</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/ko/p/MM2C3TTS022H4A_BL" class="item_info1" onclick="GA_main('exhibitionListImage1',$(this));setEcommerceDataCompnt('MM2C3TTS022H4A_BL','CLUB MONACO','컬러 라인 피케 티셔츠', '1');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/MM/2C/SS/MM2C3TTS022H4A_BL_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/ko/p/MM2C3TTS022H4A_BL" class="item_info2" onclick="GA_main('exhibitionList1',$(this));setEcommerceDataCompnt('MM2C3TTS022H4A_BL','CLUB MONACO','컬러 라인 피케 티셔츠', '1');">
                           <span class="brand">CLUB MONACO</span>
                           <span class="title">컬러 라인 피케 티셔츠</span>
                           <span class="price">₩128,000</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/ko/p/MM2C3TTS035H5A_MB" class="item_info1" onclick="GA_main('exhibitionListImage1',$(this));setEcommerceDataCompnt('MM2C3TTS035H5A_MB','CLUB MONACO','히든 버튼 칼라 티셔츠', '1');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/MM/2C/SS/MM2C3TTS035H5A_MB_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/ko/p/MM2C3TTS035H5A_MB" class="item_info2" onclick="GA_main('exhibitionList1',$(this));setEcommerceDataCompnt('MM2C3TTS035H5A_MB','CLUB MONACO','히든 버튼 칼라 티셔츠', '1');">
                           <span class="brand">CLUB MONACO</span>
                           <span class="title">히든 버튼 칼라 티셔츠</span>
                           <span class="price">₩158,000</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/ko/p/MM2C3TTS025H4E_MT" class="item_info1" onclick="GA_main('exhibitionListImage1',$(this));setEcommerceDataCompnt('MM2C3TTS025H4E_MT','CLUB MONACO','오픈 칼라 티셔츠', '1');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/MM/2C/SS/MM2C3TTS025H4E_MT_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/ko/p/MM2C3TTS025H4E_MT" class="item_info2" onclick="GA_main('exhibitionList1',$(this));setEcommerceDataCompnt('MM2C3TTS025H4E_MT','CLUB MONACO','오픈 칼라 티셔츠', '1');">
                           <span class="brand">CLUB MONACO</span>
                           <span class="title">오픈 칼라 티셔츠</span>
                           <span class="price">₩158,000</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/ko/p/MM2C4WTO605MP_BK" class="item_info1" onclick="GA_main('exhibitionListImage1',$(this));setEcommerceDataCompnt('MM2C4WTO605MP_BK','CLUB MONACO','오픈 칼라 티셔츠', '1');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/MM/2C/SS/MM2C4WTO605MP_BK_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/ko/p/MM2C4WTO605MP_BK" class="item_info2" onclick="GA_main('exhibitionList1',$(this));setEcommerceDataCompnt('MM2C4WTO605MP_BK','CLUB MONACO','오픈 칼라 티셔츠', '1');">
                           <span class="brand">CLUB MONACO</span>
                           <span class="title">오픈 칼라 티셔츠</span>
                           <span class="price">₩198,000</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/ko/p/MM2C3TTS023H4A_WT" class="item_info1" onclick="GA_main('exhibitionListImage1',$(this));setEcommerceDataCompnt('MM2C3TTS023H4A_WT','CLUB MONACO','일러스트 프린팅 티셔츠', '1');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/MM/2C/SS/MM2C3TTS023H4A_WT_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/ko/p/MM2C3TTS023H4A_WT" class="item_info2" onclick="GA_main('exhibitionList1',$(this));setEcommerceDataCompnt('MM2C3TTS023H4A_WT','CLUB MONACO','일러스트 프린팅 티셔츠', '1');">
                           <span class="brand">CLUB MONACO</span>
                           <span class="title">일러스트 프린팅 티셔츠</span>
                           <span class="price">₩118,000</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/ko/p/MM2C4TTO606M_NY" class="item_info1" onclick="GA_main('exhibitionListImage1',$(this));setEcommerceDataCompnt('MM2C4TTO606M_NY','CLUB MONACO','스트라이프 버튼 티셔츠', '1');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/MM/2C/SS/MM2C4TTO606M_NY_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/ko/p/MM2C4TTO606M_NY" class="item_info2" onclick="GA_main('exhibitionList1',$(this));setEcommerceDataCompnt('MM2C4TTO606M_NY','CLUB MONACO','스트라이프 버튼 티셔츠', '1');">
                           <span class="brand">CLUB MONACO</span>
                           <span class="title">스트라이프 버튼 티셔츠</span>
                           <span class="price">₩258,000</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/ko/p/MM2C3KTS042H6E_DG" class="item_info1" onclick="GA_main('exhibitionListImage1',$(this));setEcommerceDataCompnt('MM2C3KTS042H6E_DG','CLUB MONACO','라운드넥 니트 티셔츠', '1');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/MM/2C/SS/MM2C3KTS042H6E_DG_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/ko/p/MM2C3KTS042H6E_DG" class="item_info2" onclick="GA_main('exhibitionList1',$(this));setEcommerceDataCompnt('MM2C3KTS042H6E_DG','CLUB MONACO','라운드넥 니트 티셔츠', '1');">
                           <span class="brand">CLUB MONACO</span>
                           <span class="title">라운드넥 니트 티셔츠</span>
                           <span class="price">₩258,000</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/ko/p/MM2C3KTS012H6E_CR" class="item_info1" onclick="GA_main('exhibitionListImage1',$(this));setEcommerceDataCompnt('MM2C3KTS012H6E_CR','CLUB MONACO','라운드넥 니트 티셔츠', '1');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/MM/2C/SS/MM2C3KTS012H6E_CR_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/ko/p/MM2C3KTS012H6E_CR" class="item_info2" onclick="GA_main('exhibitionList1',$(this));setEcommerceDataCompnt('MM2C3KTS012H6E_CR','CLUB MONACO','라운드넥 니트 티셔츠', '1');">
                           <span class="brand">CLUB MONACO</span>
                           <span class="title">라운드넥 니트 티셔츠</span>
                           <span class="price">₩238,000</span>
                       </a>
                   </div>
               </li>
               </ul>
           <div class="edt-swiper-pagination"></div>
       </div>
       <div class="swiper-button-next btn1"></div>
       <div class="swiper-button-prev btn1"></div>
    </div>
</div>
</div>
             
            <!-- new & best -->
            <!-- ajax 이용해서 ul안에 여성, 남성, 포인트ACC, 셀렉티드  카테고리의 상품들 나오도록함 -->
            <div class="product_list1903">
                <div class="nbe_cnt new">
                    <div class="product_left_menu"> <!-- 상품 카테고리 -->
                        <h4 class="tit">신상품</h4>
                        <ul>
                        </ul>
                    </div>
                    <div class="nbe_cnt_inner_wrap"> <!-- 상품 이미지 리스트  -->
                    </div>
                </div>
                <div class="nbe_cnt best">
                    <div class="product_left_menu">
                        <h4 class="tit">베스트</h4>
                        <ul>
                        </ul>
                    </div>
                    <div class="nbe_cnt_inner_wrap">
                    </div>
                </div>
            </div>
            <!-- new & best -->
        </div>
        <!-- //main_container-->
        <!-- video_main_wrap-->
        <!-- 랑방 22 SS 컬렉션 동영상 재생 -->
        <div class="video_main_wrap">
					<h4 class="tit"><spring:theme code="main.video.title" /></h4>
					<div class="video_area1903" id="videoDiv1903">
						<a href="javascript:void(0);" onclick="GA_main('exhibitionVideo',$(this));">
							<div class="video_main" style="display: block;">
								<span class="play_btn"></span>
								<img src="/resources/medias/220428-D-lanvin-05.jpg?context=bWFzdGVyfGltYWdlc3w2NDY2OHxpbWFnZS9qcGVnfGltYWdlcy9oZWEvaDZlLzkyOTUyMjI2NjkzNDIuanBnfGQyZWVlMmMxMjQxNjAwZTA4YzAyZWQ5ZTBjODJhODA0MjEyYWJkMTAzNzJhYzk3ZTJmM2Y3ZDk3NzYzN2NjYWE" alt="poster">
							</div>
							<video id="video" class="video-js" controls="auto" preload="auto" style="display: none; width:884px; height:auto;" onended="videoEnded('videoDiv1903',0)" width="884" height="auto">
								<source src="http://s3.ap-northeast-2.amazonaws.com/cdn.thehandsome.com-kr/pc/0_main_video/220427_lanvin/lanvin%20collection_22SS.mp4" type="video/mp4">
							</video>
						</a>
					</div>
					<div class="txt">
						<p class="tit">JOIE VIVE LANVIN<br>SYNDROME</p>
						<p class="s_t">초현실적인 공간에서 만난 랑방컬렉션의<br>명화 같은 2022 SS COLLECTION</p>
					</div>
				</div>
			<!--// video_main_wrap-->
        <!-- main_container-->
        <div class="main_container">
            <!-- the_magazine_wrap1903-->
            <div class="the_magazine_wrap1903">
                <h4 class="tit">THE 매거진</h4>
                <div class="magazine_slider1903 swiper-container" id="magazinSlider1903">
                    <ul class="swiper-wrapper">
                    </ul>
                </div>
                <!--add arrow -->
                <div class="themagazine_arrow next">다음</div>
                <div class="themagazine_arrow prev">이전</div>
            </div>
            <!-- //the_magazine_wrap1903-->
            <!--배너영역 -->
            <!--//배너영역 -->
            
        </div>
        <!-- //main_container-->

<!-- footerWrap -->

<script type="text/javascript">
//<![CDATA[ 

$(document).ready(function(){
    var ua = navigator.userAgent.toLowerCase();
    // 익스플로러 브라우저 아닐 때만 인스타 링크버튼 노출
    if((ua.indexOf('trident') == -1) && (ua.indexOf("msie") == -1) ){
        $("#f_insta").show();
    }
});

getNewsList("/ko/magazine");


// 2022.03.29 푸터 공지사항 추가
getFooterNotices("/ko/svcenter");


function moveMobile(){
// 	location.href = location.href.replace("?uiel=Desktop", "") + "?uiel=Mobile";
	location.href = "/ko/?uiel=Mobile";
}


function setLogout(){
    var ssoUrl = 'https://sso.h-point.co.kr:29865' + "/co/setDscdToknJSONP.hd";
    gfnSsoDscdToknReqAjax(ssoUrl, hplogoutSuccess);
}

function hplogoutSuccess(data){
    deletecookie("UID");   
    deletecookie("criteoEmail"); 
    deletecookie("memberGb");
    location.href = "/ko/logout";
}

//]]>
</script>


<%@ include file="./includes/footer.jsp" %>