<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="shortcut icon"
	href="http://cdn.thehandsome.com/_ui/desktop/common/images/common/thehandsome_ic_16x16.ico" />
<link rel="stylesheet" type="text/css"
	href="../../../resources/css/font_80.css" media="all" />

<link rel="stylesheet" type="text/css"
	href="../../../resources/css/common.css" media="all" />
<link rel="stylesheet" type="text/css"
	href="../../../resources/css/layout.css" media="all" />
<link rel="stylesheet" type="text/css"
	href="../../../resources/css/popup.css" media="all" />
<link rel="stylesheet" type="text/css"
	href="../../../resources/css/jquery-ui.min.css" media="all" />

<link rel="stylesheet" type="text/css"
	href="../../../resources/css/brand.css" media="all" />
<link rel="stylesheet" type="text/css"
	href="../../../resources/css/swiper.css" media="all" />
<link rel="stylesheet" type="text/css"
	href="../../../resources/css/main_201903.css" media="all" />
<link rel="stylesheet" type="text/css"
	href="../../../resources/css/footer.css" media="all" />
<style type="text/css" media="print">
@IMPORT url("../../../resources/blueprint/print.css");
</style>
<script type="text/javascript"
	src="../../../resources/js/jquery.vticker.js"></script>
<!-- Enliple Tracker Start -->
    <script type="text/javascript">

//<![CDATA[

var intervalLoopCnt = 0;
var colorArray = [];
var sizeArray = [];
var fileIdx = 1;
var cartQuantity = {};
var obj;

function setColor(i) {
	console.log(obj[i].ccolorcode);
	var split_arr = obj[i].cimage1.split('_');
	$("#pcolor").val(split_arr[1]);
	console.log($("#pcolor").val());
}

$(document).ready(function(){
    reScroll();
    bodyReSize();
    resizeEtcImage();
    
    $(window).resize(function(){
        reScroll();
        bodyReSize();
        resizeEtcImage();
        btnPosition();
    });
   
    // 상품 컬러 리스트 가져오는 ajax 호출
    $.ajax({
        url: "/product/productColor?pid="+"${productInfo.pid}",
        type: "GET",
        dataType:"json",
        async : false,
        error : function( request, status, error ){
            console.log( "code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
        }, 
        success : function( result ) {
        	var html="";
        	obj = result;
        	if(result.length > 0){
        		html += '<ul class="color_chip clearfix">';
        		for(var i=0; i<result.length; i++) {
        			console.log(result);
        			var split_arr = result[i].cimage1.split('_');
        			html += '<li id="'+result[i].pid+'">';
        			html += '<input type="hidden" id="pcolor" name="pcolor" class="colorNameVal" value="'+split_arr[1]+'"/>';
        			if(i == 0) html += '<a href="#;"  onclick="setColor('+i+')" class="beige on" style="background:'+result[i].ccolorcode+' url('+result[i].cimage1+'"></a></li>';
        			else  html += '<a href="#;" onclick="setColor('+i+')" class="beige" style="background:'+result[i].ccolorcode+' url('+result[i].cimage1+'"></a></li>';

        			$("#pcolor").val(split_arr[1]);
        			console.log($("#pcolor").val());
        		}
        		html += '</ul>';
        	}
        	$("#getcolor").html(html);
        }
    });
    var testerChkCode = "IL2C5WSH942W_DN";
    if(testerChkCode.indexOf("_") > -1) {
        testerChkCode = testerChkCode.split("_")[0];
    }
    $(document).on("click", ".prev" , function(){
        slidPrev();
    });
    $(document).on("click", ".next" ,  function(){
        slidNext();
    });
    
    $("body").on('click', function(){
        
        $("#cardBenefit, #popupDelivery, #sizeQuickReferenceLayer, #addMileageInfo").on('click', function(e){
            e.stopPropagation();
        });
        
        $("#cardBenefit").hide();
        $("#popupDelivery").hide();
        $("#sizeQuickReferenceLayer").hide();
        $("#addMileageInfo").hide();
    });
    
    $(document).on("click","#fourpmCheck , #athomeCheck, #quickCheck" ,function(){
        setFourmpmAthomeProcess(this.id);
    });
    
    $("#postalcode").on("change",function(){
        var tempShortstreet = $("#streetname").val();
        var shortstreet = tempShortstreet.split(" ");
        $("#deliveryStreetTitle").html('서비스 가능 지역');
        if( tempShortstreet != null && tempShortstreet != '') {
            $("#deliveryStreet").html('<span class="athome_adr">'+shortstreet[0]+' '+shortstreet[1]+' '+shortstreet[2]+'</span> 기준');
        }
    });
    
    $("#quickPostalcode").on("change",function(){
        var tempQuickShortstreet = $("#quickStreetname").val();
        var quickShortstreet = tempQuickShortstreet.split(" ");
        $("#quickDeliveryStreetTitle").html('서비스 가능 지역');
        if( tempQuickShortstreet != null && tempQuickShortstreet != '') {
            $("#quickDeliveryStreet").html('<span class="quick_adr">'+quickShortstreet[0]+' '+quickShortstreet[1]+' '+quickShortstreet[2]+'</span> 기준');
        }
    });
    
    /* //2018.07.18 장바구니개편 시작
    //수령매장 주소선택, 날짜선택
    $(document).on('click',':radio[name="sel_cp"]',function(){
        $('.receive_date_wrap1807').stop().hide();
        $(this).parents('tr').next('tr').stop().slideDown('fast');
        
        var dateBtn='.receive_date_wrap1807 .receive_date ul li a';
        $(dateBtn).each(function(){
            $(this).removeClass('on');
        });
    }); */
    
    var dateBtn='.receive_date_wrap1807 .receive_date ul li a';
    $(document).on('click',dateBtn,function(){
        $(dateBtn).removeClass('on');
        $(this).addClass('on');
    });
    //2018.07.18 장바구니개편 끝
    
    /* // 구매옵션 변경 슬라이드
    $('.pop_cnt.options1811 .options_change').click(function(){
        $('.select_options_wrap').show(); // 색상,사이즈 박스
        $('.select_checkbox').show(); // 상품 매장구매 체크박스
        $('.options_change').hide(); // 변경하기 버튼
        $("#purchased_color_size").css("display", "none"); 
        $('#orderWriteChk').val('Y');
       // $('#purchaseProdYN').val('Y');
    }); */
});
        			
// 장바구니에 추가하는 함수
function addToCart(buyNow)
{
    //2019.09.09 주문 불가능한 상품 선택시
    if(selectSize == false){
        var la = new layerAlert('사이즈를 선택해 주세요.');
        return;
    }
    // 로그인이 안되어있을 경우 로그인페이지로 이동
    if("${sessionScope.member.mid}" == ""){
    	location.href="/member/login";
    	return;
    }
    if(addToCartProcess){
        addToCartProcess = false;
        var pid = $('form[name=addToCartForm] input[name=pid]').val();
        var psize = $('form[name=addToCartForm] input[name=psize]').val();
        var pamount = $('form[name=addToCartForm] input[name=pamount]').val();
        var pcolor = $("#pcolor").val();
        if(pcolor == null) {
        	var split_arr = pid.split('_');
        	pcolor = split_arr[1];
        }
        console.log(pcolor);
        
        /* console.log(pid, psize, pcolor, pamount); */
        // 장바구니 등록하는 ajax 호출
        $.ajax({
            url: "/shoppingbag",
            method: "post",
            data : {
            	mid : "${sessionScope.member.mid}",
            	pid : pid,
            	psize : psize,
            	pcolor : pcolor,
            	pamount : pamount
            },
            success: function (data) {
                alert("완료되었습니다.");
                location.href='/shoppingbag';
            },
            error : function( request, status, error ){
                console.log( "code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
            }
        });
        
    }
}
    
    
function setFourpmAthomeCode(data,selectSize,type){
    tempSetClass();
    $(document).find(".color_size_qty ul.color_chip > li").each(function(){
        if(data.indexOf($(this).attr("id")) == -1){
            $(this).find(" > a").attr("class","no_color");
        }
    });
    
    var checkSizeCode = false;
    $(document).find(".color_size_qty .size_chip > li").each(function(){
        if(!$(this).find(" > a").hasClass("not_stock")){
            if(data.indexOf($(this).attr("id")) == -1){
                $(this).find(" > a").addClass("not_stock");
            }
        }
        
        if($(this).find(" > a").hasClass("on")){
            if(data.indexOf($(this).attr("id")) == -1){
                checkSizeCode = true;
            }
        }
    });
    
    if(selectSize){
        if(checkSizeCode){
            var msg = "";
            if(type == "fourpm"){
                msg = '선택한 색상,사이즈는 {0}PM 서비스</br>대상이 아닙니다.</br>옵션을 다시 선택해주세요.';
            }else if(type == "athome"){
                msg = '선택한 색상,사이즈는 앳홈 서비스</br>대상이 아닙니다.</br>옵션을 다시 선택해주세요.';
            }else if(type == "pickup"){
                msg = '선택한 사이즈는 매장수령</br>대상이 아닙니다.</br>옵션을 다시 선택해주세요.';
            }else if(type == "quick"){
                msg = '선택한 사이즈는 퀵배송</br>대상이 아닙니다.</br>옵션을 다시 선택해주세요.';
            }
            
            var la = new layerAlert(msg);
            la.confirmAction = function(){
                return;
            };
            $('form[name=addToCartForm] input[name=productCodeType]').val("ApparelStyleVariantProduct");
        }
    }
    
    
}

function tempSetOriginClass(){
    $(".color_size_qty ul.color_chip > li").each(function(idx){
        $(this).find(" > a").attr("class",colorArray[idx]);
    });
    
    $(".color_size_qty .size_chip > li").each(function(idx){
        if(sizeArray[idx] == ""){
            $(this).find(" > a").removeClass("not_stock");
        }
    });
}

function tempSetClass(){
    $(".color_size_qty ul.color_chip > li").each(function(idx){
        colorArray[idx] = $(this).find(" > a").attr("class");
    });
    
    $(".color_size_qty .size_chip > li").each(function(idx){
        if($(this).find(" > a").hasClass("not_stock")){
            sizeArray[idx] = "not_stock";
        }else{
            sizeArray[idx] = "";
        }
    });
}

function showExchangeRate(){ 
    var productPrice = $("#productPrice").val() == null || $("#productPrice").val() == 0 ? 0 : $("#productPrice").val();
    var addHtml = "<p>₩"+addComma(productPrice); +"</p>";
    $("#exchangeDiv").html(addHtml);
    //$(".tlt_ship .delch_box").css("display","block");
    
}

function btnPosition(){
    
    var layerImgWidth = $(".gallery-wrapper ul li img").width();
    var layerBtn = $(".gallery-wrapper .close");
    
    $(layerBtn).css("margin-right",-(layerImgWidth/2+60));

};


function resizeEtcImage(){
    var widthLi = $(".adaptive_wrap").width() / 6;
    $(".productSlide li").css("padding","0").css("width","auto");
    $(".productSlide li img").css("width","96%").css("padding","0 2%");
    $(".hidden_wrap ul li").width(widthLi);
    $(".lookbook_list191211 ul li").css({'width':'auto','height':'216px'});
	$(".lookbook_list191211 ul li img").css({'width':'auto','height':'100%','padding':'0 5px'});

}

$(document).on("keyup","#height",function(){
    $("#thHeight").css("color", "black");
    $("#thHeight").css("font-weight","normal");
    $(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
    if ($("#height").val().length > 0) {
        var inputNumberchk = /^[0-9]+$/; // 숫자 체크
        if (!inputNumberchk.test($("#height").val())){
            $(this).val($(this).val().replace(/[^0-9]/gi,""));
	        var la = new layerAlert("숫자만 입력 가능합니다.");
	        la.confirmAction = function(){};
        }    
    }
});

$(document).on("keyup","#enjoySize",function(){
    $("#thEnjoySize").css("color", "black");
    $("#thEnjoySize").css("font-weight","normal");
    $(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
    if ($("#enjoySize").val().length > 0) {
        var inputHangulchk = /[^ㄱ-ㅎ|ㅏ-ㅣ]+$/; // 초성(자음/모음) 체크
        if (!inputHangulchk.test($("#enjoySize").val())){
            $(this).val($(this).val().replace(/[^a-z0-9]/gi,""));
	        var la = new layerAlert("영문/숫자만 입력 가능합니다.");
	        la.confirmAction = function(){};
        }
    }
});

function qnawWriteCheck()
{
    var title = $("#inquiryTitle").val();
    var content = $("#inquiryContents").val();
    var hp2 = $("#inquiryMobileNo2").val();
    var hp3 = $("#inquiryMobileNo3").val();
    var emailAddress = $("#inquiryEmailAddress").val();
    var emailDomain = $("#inquiryEmailDomain").val();
    
    if(title == null || title.trim() == ''){
        var la = new layerAlert('제목을 입력해 주세요.');        
        la.confirmAction = function(){
            $("#productQnAWriteDiv").attr("tabindex", -1).focus();
        };
        return false;       
    }
    
    if(content == null || content.trim() == ''){
        var la = new layerAlert('내용을 입력해 주세요.');
        la.confirmAction = function(){
            $("#productQnAWriteDiv").attr("tabindex", -1).focus();
        };
        return false;
        
    }
    
    if(content.trim().length < 1 && content.trim().length > 200){
        var la = new layerAlert('내용은 1 ~ 200자 사이입니다.');
        la.confirmAction = function(){
            $("#productQnAWriteDiv").attr("tabindex", -1).focus();
        };
        return false;
    }
    
	if($("#inquirySmsNoticeYn").is(":checked")) {
		if((hp2 == null || hp2.trim() == '') || (hp3 == null || hp3.trim() == '')) {
			var la = new layerAlert('SMS를 받을 전화번호를 입력해 주세요.');
			la.confirmAction = function() {
				$("#productQnAWriteDiv").attr("tabindex", -1).focus();
			};
			return false;
		}
	}
	
	if(emailAddress == null || emailAddress.trim() == '') {
		var la = new layerAlert('답변받을 이메일은 필수 항목입니다.');
		la.confirmAction = function() {
			$("#productQnAWriteDiv").attr("tabindex", -1).focus();
		};
		return false;
	}
	
	if(emailDomain == null || emailDomain.trim() == '') {
		var la = new layerAlert('답변받을 이메일은 필수 항목입니다.');
		la.confirmAction = function() {
			$("#productQnAWriteDiv").attr("tabindex", -1).focus();
		};
		return false;
	}
	
    return true;
}

//2018.01.16 로그인 팝업
function goLoginPopup(pageType){    
    
    var url = '/ko/member/login';    
    var param = "?returnType="+pageType+"&loginType=loginPop&productCode="+ $("#productCode").val();
    
    centerPopup(url+param, 'LoginPopup', '520', '709' );
}

function goLogin(pageType){
    
    var url = '/ko/p';
    url += "/"+$("#productCode").val()+"/login";
    var param = "?returnType="+pageType;
    window.location.href=url+param;
}
var intervalId = -1;
function bodyReSize(){
    var imgHeight = $("#imageDiv").height();        //상단 이미지
    var mainHeight = $("#clearfix").height();       //매인
    
    //개별 이미지 높이
    var imageDivSize = 0;
    var imageDivMaxHeight = 0;
    $("#imageDiv > ul > li").each(function(index){
        imageDivSize = index+1; 
        if(imageDivMaxHeight < $(this).height()) {
            imageDivMaxHeight = $(this).height();
        }
    });

    if(imgHeight < ((imageDivMaxHeight+10)*imageDivSize)) {
        intervalLoopCnt = 0;
        intervalId = setTimeout(bodyReSize, 100);
//      intervalId = setInterval(bodyReSize, 100);
        return false;
    } else {
        if(intervalLoopCnt < imageDivSize) {
            intervalLoopCnt = intervalLoopCnt + 1;
            intervalId = setTimeout(bodyReSize, 100);
//          intervalId = setInterval(bodyReSize, 100);
            return false;
        } else {
            clearTimeout(intervalId);
//          clearInterval(intervalId);  
        }
    }

    $("#productDetailEtc").css("display", "block");
    $("#footerWrap").css("display", "block");

    var contentHeight = $("#contentDiv").height();  //상단 detail 내용
    var offset = $("#imageDiv").offset();
    
    if(imgHeight > contentHeight){
        $("#clearfix").height(imgHeight+50);
    }else if(imgHeight < contentHeight){
        $("#clearfix").height(contentHeight+50);
    }
    
    
    var outerWidth = $(window).outerWidth();
    var imgWidth = $("#imageDiv").width();
    var resizeWidth = $("#imageDiv").width() + $('#contentDiv').innerWidth();
    var leftWidth = (outerWidth - resizeWidth) / 2
    var contentWidth = leftWidth + imgWidth;
    
    if($("#contentDiv").css('position') == 'absolute'){
        $("#contentDiv").css('left', imgWidth);
    }else{
        if(outerWidth < 1210){
            $("#contentDiv").css('left', imgWidth);
        }else{
            $("#contentDiv").css('left', contentWidth+2);
        }
    }
}

function reScroll(){
    var $btnwrap = $('.btnwrap.clearfix');
    var btnwrapHeight = $btnwrap.height();
    var btnMarginBottom = 44;

    // WIDTH
    var outerWidth = $(window).outerWidth();
    var imgWidth = $("#imageDiv").width();
    var leftWidth = $("#imageDiv").offset().left;
    var contentWidth = leftWidth + imgWidth;
    
    $(window).scroll(function(){
        
        var scrollTop = $(this).scrollTop();
        var outerHeight = $(window).outerHeight();
        var scrollHeight = parseFloat($("#imageDiv").height() - $('#contentDiv').height());
        
        if(scrollHeight > 0){
            
            if (scrollTop < 100) {
                $('#contentDiv').css({'top':'0','left':imgWidth,'margin-top':'20px'});
                $('#imageDiv').css({'margin-top':'20px'});
                
            } else if ((scrollTop>=100) && (scrollTop<=scrollHeight)) {
                //$('#contentDiv').css({'position': 'fixed', 'top':139,'left':contentWidth});
                $('#contentDiv').css({'margin-top':'0px'});
                if(outerWidth < 1210){
                    //$('#contentDiv').css({'position': 'fixed', 'top':139,'left':imgWidth});
                }
            } else {
                $('#contentDiv').css({'top':scrollHeight,'left':imgWidth});
            }
        }else{
            $('#contentDiv').css({'top':'0','left':imgWidth,'margin-top':'20px'});
            $('#imageDiv').css({'margin-top':'20px'});
        }
        
        var btnwrapOffset = $btnwrap.offset();
        var curBtnwrapMarginTop = parseInt( $btnwrap.css('margin-top') );
        var btnwrapMarginTop = Math.min( scrollTop + outerHeight - btnwrapOffset.top - btnwrapHeight - btnMarginBottom + curBtnwrapMarginTop, 0);

        $btnwrap.css({
            'margin-top': btnwrapMarginTop,
            'margin-bottom': -btnwrapMarginTop
        });
        
        
    }).trigger('scroll');
}

function fn_sumPriceCal(){
    
    var productPrice = $("#productPrice").val() == null || $("#productPrice").val() == 0 ? 0 : $("#productPrice").val();
    var qty = $("#txtqty").val();
    var sumPrice = parseFloat(productPrice * qty);
    
    if("ko" != "ko") {
    	var addHtml = "";
        
        
        	if("ko" == "en") {
        		if("CNY" == "USD") {
		            var rate = "189.55";
		            var simbol = "¥";
		            
		            var exchangeAmt = Math.round(parseFloat(sumPrice) / parseFloat(rate) * 100) / 100 ;
		            
		            addHtml += simbol + addComma(exchangeAmt);
        		}
        	} else {
        		if("CNY" == "CNY") {
	        		var rate = "189.55";
		            var simbol = "¥";
		            
		            var exchangeAmt = Math.round(parseFloat(sumPrice) / parseFloat(rate) * 100) / 100 ;
		            
		            addHtml += simbol + addComma(exchangeAmt);
        		}
        	}
        
        	if("ko" == "en") {
        		if("USD" == "USD") {
		            var rate = "1265.8";
		            var simbol = "$";
		            
		            var exchangeAmt = Math.round(parseFloat(sumPrice) / parseFloat(rate) * 100) / 100 ;
		            
		            addHtml += simbol + addComma(exchangeAmt);
        		}
        	} else {
        		if("USD" == "CNY") {
	        		var rate = "1265.8";
		            var simbol = "$";
		            
		            var exchangeAmt = Math.round(parseFloat(sumPrice) / parseFloat(rate) * 100) / 100 ;
		            
		            addHtml += simbol + addComma(exchangeAmt);
        		}
        	}
        
        
        $("#sumPrice").text(addHtml);
    } else {
    	$("#sumPrice").text('₩' + addComma(sumPrice));
    }
    
}

function fn_qtySubtraction()
{
    var qty  = $("#txtqty").val();
    if(qty < 2){
        return;
    }
    	
    //GA 이벤트 태깅
    GA_Event('상품_상세','수량','-');
    
    $("#txtqty").val(parseInt(qty)-1);
    fn_sumPriceCal();
    
    fn_chkReserveSaleStockpile(parseInt($('#txtqty').val()));
    
    
}

function fn_qtyAdd(){
    var productType = $('form[name=addToCartForm] input[name=productCodeType]').val();
    if(productType != 'ApparelSizeVariantProduct'){
        var la = new layerAlert('사이즈를 선택해 주세요.');
        return;
    }
    
    var qty         = parseInt($("#txtqty").val());
    var stockCnt        = ($("#storePickupCheck").is(":checked")) ? parseInt(stockOnlineStockpile[$("#productCode").val()]) : parseInt($("#stockCnt").val());
    var reserveSaleYn = false;
    var cartCnt = 0;
    if(cartQuantity[$("#productCode").val()] != null && cartQuantity[$("#productCode").val()] != "undefined"){
        cartCnt = cartQuantity[$("#productCode").val()];
    }
    
  	//#2610 [주문] 가상계좌 결제수단 제외 및 중복 구매 제한 처리 요청 건 20220215 hyunbae
    var productCategory = 'WE013';
    if(qty + 1 > 2 && productCategory){
    	var baseCategoryCode = productCategory.substring(0,2);
    	if('WE' === baseCategoryCode || 'ME' === baseCategoryCode){
    		$("#txtqty").val("2");
    		var la = new layerAlert('동일 상품(사이즈/컬러)은<br/>최대 2개까지 선택 가능합니다.');
            return;	
    	}
    }
    
    if($("input[id^=reserveSalesStockpile_]").length > 0){
        reserveSaleYn = true;
    }
    
    if("ko" != "ko" && stockCnt==1){
        layerAlert('구매가능한 재고는 1개 입니다.');
        return;
    }
    
    if(reserveSaleYn){
//      if ( stockCnt != '' && parseInt(qty)+parseInt(1) > stockCnt ) {
        if(!fn_chkReserveSaleStockpile(qty+1)) {
            //  var la = new layerAlert("재고가 부족합니다.");
            //var la = new layerAlert("예약 상품 주문 가능 수량을 초과하였습니다.<br/>예약 구매 가능한 수량은 " + stockCnt +"개 입니다.");
            var la = new layerAlert("예약 상품 주문 가능 수량을 초과하였습니다.<br/>예약 구매 가능한 수량은 "+qty+"개 입니다.");
            return;
        }
    } else {
        /* PC의 경우 수량 선택 시 쇼핑백 담기나 바로 구매 중 어떤 것을 선택할지 모르기 때문에 주석 처리
        if("ko" == "ko"){
            if (qty >= stockCnt - cartCnt) {
                if(cartCnt > 0){
                    msgCnt = (stockCnt - cartCnt) < 0?0:stockCnt - cartCnt;
                
                    var la = new layerAlert("이미 쇼핑백에 담겨 있습니다.<br/>구매 가능한 재고 "+(msgCnt)+"개만 선택하실 수 있습니다.");
                }else{
                    var la = new layerAlert("구매 가능한 재고 "+stockCnt+"개만 선택하실 수 있습니다.");
                }
                return;
            }
        }else{
            if (qty >= stockCnt) {
                var la = new layerAlert("재고가 부족합니다.");            
                return;
            }
        }
        */
        if (qty >= stockCnt) {
            if("ko" == "ko"){
                var la = new layerAlert("구매 가능한 재고 "+stockCnt+"개만 선택하실 수 있습니다.");
        	}else{
        	    var la = new layerAlert("재고가 부족합니다.");
        	}
            return;
        }
    }
    
//     if(reserveSaleYn && !fn_chkReserveSaleStockpile(qty+1)) {
//         return;
//     }
    
    //GA 이벤트 태깅
    GA_Event('상품_상세','수량','+');
    
    $("#txtqty").val(qty+1);
    fn_sumPriceCal();
    
    
}

function promotionProduct(){
    var la = new layerAlert('동일 옵션(컬러/사이즈)으로 최대 1개 구매 가능합니다.');
}
    
function chgEnMonth(){
    if($("#deliveryPlanDate").html() != ""){
        if($("#deliveryPlanYear").val() != "" && $("#deliveryPlanMounth").val() != "" && $("#deliveryPlanDay").val() != ""){
            var reMsg = '{0}년 {1}월 {2}일부터 순차배송 예정입니다.';
            var month = convertNumberToMonth($("#deliveryPlanMounth").val());
            
            reMsg = reMsg.replace("{0}",$("#deliveryPlanYear").val());
            reMsg = reMsg.replace("{1}",month);
            reMsg = reMsg.replace("{2}",$("#deliveryPlanDay").val());
            
            $("#deliveryPlanDate").html(reMsg);
        }
        
    }
}


function fn_chkReserveSaleStockpile(qty){
    var rsl = $("input[id^=reserveSalesStockpile_]").length;
    var resultFlag = false;
    for(var i=0; i<rsl; i++){
        var reserveSalesStockpile = parseInt($('#reserveSalesStockpile_'+i).val());
        
        if(reserveSalesStockpile >= qty) {
            
            var erpWorkOrderNumber  = $('#erpWorkOrderNumber_'+i).val();
            var deliveryPlanYear        = $('#deliveryPlanYear_'+i).val();
            var deliveryPlanMounth  = $('#deliveryPlanMounth_'+i).val();
            var deliveryPlanDay     = $('#deliveryPlanDay_'+i).val();
            
            
            var deliveryPlanDateTxt = '{0}년 {1}월 {2}일부터 순차배송 예정입니다.';
            
            deliveryPlanDateTxt = deliveryPlanDateTxt.replace('{0}',deliveryPlanYear);
            deliveryPlanDateTxt = deliveryPlanDateTxt.replace('{1}',deliveryPlanMounth);
            deliveryPlanDateTxt = deliveryPlanDateTxt.replace('{2}',deliveryPlanDay);
            
            $('#erpWorkOrderNumber').val(erpWorkOrderNumber);
            $('#deliveryPlanYear').val(deliveryPlanYear);
            $('#deliveryPlanMounth').val(deliveryPlanMounth);
            $('#deliveryPlanDay').val(deliveryPlanDay);
            
            $('#deliveryPlanDate').html(deliveryPlanDateTxt);
            resultFlag = true;
            break;
        }
    }
    return resultFlag;
}

var addToCartProcess = true;
var selectSize = false;
function setSize() {
	selectSize = true;
}


// 기존로직
function addtoCartProcessFunction(){
    
    var productCode = $('form[name=addToCartForm] input[name=productCodePost]').val();
    var productType = $('form[name=addToCartForm] input[name=productCodeType]').val();
    var qty = $("#txtqty").val();
    
    	
    if(qty < 1){
        var la = new layerAlert('productdetail.basket.errormag.qty');
        addToCartProcess = true;
        return;
    }
    
    $('form[name=addToCartForm] input[name=qty]').val(qty);
    
    
    $('#workOrder').val($('#erpWorkOrderNumber').val());
    
    //추천상품 

    if('' != null) {
        $('#recommendProduct').val("recommendProd");
    }
    
    if($("#storePickupCheck").is(":checked") && $("#fourpmCheck").is(":checked")){
        var scrollTop = $(document).scrollTop();
        var la = new layerAlert('매장수령과 {0}PM는 동시에 선택할 수 없습니다.');
        var top = $(".popwrap.w_type_1").css("margin-top").replace("px","");
        $(document).scrollTop(scrollTop);
        $(".popwrap.w_type_1").css("margin-top",Number(scrollTop)+Number(top)+"px");
        la.confirmAction = function(){
            return;
        };
        addToCartProcess = true;
        return false;
    }

    var checkQuickProcess = false;
    var checkAthomeProcess = false;
    var check4pmProcess = false;
    var check4pmOver = false;
    if($("#fourpmCheck").is(":checked")){
        $("#deliveryKind").val("4pm");
        $.ajax({
             url: '/ko/shoppingbag/check4pm',
             type: "GET",            
             data: $('form[name=addToCartForm]').serialize(),
             async : false,
             success: function(data){
                 //data가 0 또는 4pm의 경우 담기
                 if(data == "normal"){
                     var scrollTop = $(document).scrollTop();
                     var la = new layerAlert('쇼핑백에 {0}PM 상품이 아닌 일반배송 상품이 담겨 있습니다. 쇼핑백에서 일반배송 상품을&nbsp; 삭제 후 {0}PM 버튼을 클릭해 주세요.');
                     var top = $(".popwrap.w_type_1").css("margin-top").replace("px","");
                     $(document).scrollTop(scrollTop);
                     $(".popwrap.w_type_1").css("margin-top",Number(scrollTop)+Number(top)+"px");
                     la.confirmAction = function(){
                        return;
                     };
                     check4pmProcess = true;
                 }else if(data == "pm_over"){
                    check4pmOver = true;
                    $("#deliveryKind").val("");
                 }else if(data == "store"){
                     var scrollTop = $(document).scrollTop();
                     var la = new layerAlert('쇼핑백에 {0}PM 상품이 아닌 매장수령 상품이 담겨 있습니다. 쇼핑백에서 매장수령 상품을&nbsp; 삭제 후 {0}PM 버튼을 클릭해 주세요.');
                     var top = $(".popwrap.w_type_1").css("margin-top").replace("px","");
                     $(document).scrollTop(scrollTop);
                     $(".popwrap.w_type_1").css("margin-top",Number(scrollTop)+Number(top)+"px");
                     la.confirmAction = function(){
                        return;
                     };
                     check4pmProcess = true;
                 }else if(data == "athome"){
                     var scrollTop = $(document).scrollTop();
                     var la = new layerAlert('쇼핑백에 {0}PM 상품이 아닌 앳홈 상품이 담겨 있습니다. 쇼핑백에서 앳홈 상품을&nbsp; 삭제 후 {0}PM 버튼을 클릭해 주세요.');
                     var top = $(".popwrap.w_type_1").css("margin-top").replace("px","");
                     $(document).scrollTop(scrollTop);
                     $(".popwrap.w_type_1").css("margin-top",Number(scrollTop)+Number(top)+"px");
                     la.confirmAction = function(){
                        return;
                     };
                     check4pmProcess = true;
                 }
             },
             error: function(xhr, Status, error) {
                 var la = new layerAlert(error);
                 la.confirmAction = function(){
                        return;
                 };
             }
        });
    }else if($("#athomeCheck").is(":checked")){
        if($("#postalcode").val() == ""){
              addToCartProcess = true;
              layerAlert('앳홈 서비스 불가능 지역 입니다.<br/>(강남,강동,동작,마포,서초,송파,영등포,용산만 가능)');
              return false;
        }
          
        $("#deliveryKind").val("athome");
        $.ajax({
             url: '/ko/shoppingbag/checkAtHome',
             type: "GET",            
             data: $('form[name=addToCartForm]').serialize(),
             async : false,
             success: function(data){
                 if(data == "normal"){
                     var scrollTop = $(document).scrollTop();
                     var la = new layerAlert('쇼핑백에 앳홈 상품이 아닌 일반배송 상품이 담겨 있습니다. 쇼핑백에서 일반배송 상품을&nbsp; 삭제 후 주문 진행이 가능합니다.');
                     var top = $(".popwrap.w_type_1").css("margin-top").replace("px","");
                     $(document).scrollTop(scrollTop);
                     $(".popwrap.w_type_1").css("margin-top",Number(scrollTop)+Number(top)+"px");
                     la.confirmAction = function(){
                        return;
                     };
                     checkAthomeProcess = true;
                 }else if(data == "store"){
                     var scrollTop = $(document).scrollTop();
                     var la = new layerAlert('쇼핑백에 앳홈 상품이 아닌 매장수령 상품이 담겨 있습니다. 쇼핑백에서 매장수령 상품을&nbsp; 삭제 후 주문 진행이 가능합니다.');
                     var top = $(".popwrap.w_type_1").css("margin-top").replace("px","");
                     $(document).scrollTop(scrollTop);
                     $(".popwrap.w_type_1").css("margin-top",Number(scrollTop)+Number(top)+"px");
                     la.confirmAction = function(){
                        return;
                     };
                     checkAthomeProcess = true;
                 }else if(data == "login"){
                     var scrollTop = $(document).scrollTop();
                     var la = new layerAlert('신청 가능합니다.');
                     var top = $(".popwrap.w_type_1").css("margin-top").replace("px","");
                     $(document).scrollTop(scrollTop);
                     $(".popwrap.w_type_1").css("margin-top",Number(scrollTop)+Number(top)+"px");
                     la.confirmAction = function(){
                        var url = '/ko/member/login';
                        window.location.href=url;
                     };
                     checkAthomeProcess = true;
                 }else if(data == "fourpm"){
                     var scrollTop = $(document).scrollTop();
                     var la = new layerAlert('쇼핑백에 앳홈 상품이 아닌 상품이 담겨 있습니다. 쇼핑백에서 상품을&nbsp; 삭제 후 주문 진행이 가능합니다.');
                     var top = $(".popwrap.w_type_1").css("margin-top").replace("px","");
                     $(document).scrollTop(scrollTop);
                     $(".popwrap.w_type_1").css("margin-top",Number(scrollTop)+Number(top)+"px");
                     la.confirmAction = function(){
                        return;
                     };
                     checkAthomeProcess = true;
                 }
             },
             error: function(xhr, Status, error) {
                 var la = new layerAlert(error);
                 la.confirmAction = function(){
                        return;
                 };
             }
        });
        
        if(!checkAthomeProcess){
            if($("#txtqty").val() != "1"){
                var scrollTop = $(document).scrollTop();
                var la = new layerAlert('앳홈 서비스는 하나의 수량만 가능 합니다.');
                var top = $(".popwrap.w_type_1").css("margin-top").replace("px","");
                $(document).scrollTop(scrollTop);
                $(".popwrap.w_type_1").css("margin-top",Number(scrollTop)+Number(top)+"px");
                la.confirmAction = function(){
                return;
                };
                checkAthomeProcess = true;
                addToCartProcess = true;
                return false;
            }
        }
    }else if($("#quickCheck").is(":checked")){
        if($("#quickPostalcode").val() == ""){
            addToCartProcess = true;
            layerAlert('퀵배송 서비스 불가능  지역입니다.</br>배송지 변경 후 이용해 주세요.<br/>(서울 전 지역 가능, 향후 서비스 확대 예정입니다.)');
            return false;
        }
        
        if($("#txtqty").val() > 3){
            var scrollTop = $(document).scrollTop();
            var la = new layerAlert('퀵배송 주문은 총 수량이 3개까지만 가능합니다.');
            var top = $(".popwrap.w_type_1").css("margin-top").replace("px","");
            $(document).scrollTop(scrollTop);
            $(".popwrap.w_type_1").css("margin-top",Number(scrollTop)+Number(top)+"px");
            la.confirmAction = function(){
            return;
            };
            checkQuickProcess = true;
            addToCartProcess = true;
            return false;
        }
        
        if(!checkQuickProcess){
            $("#deliveryKind").val("quick");
            $.ajax({
                 url: '/ko/shoppingbag/checkQuick',
                 type: "GET",            
                 data: {zipcode:$("#quickPostalcode").val(),productCode:$("input[name=productCodePost]").val()},
                 async : false,
                 success: function(data){
                     if(data == "time"){
                         var scrollTop = $(document).scrollTop();
                         var la = new layerAlert('퀵배송 주문이 종료 되었습니다. 내일 다시 이용해 주세요.');
                         var top = $(".popwrap.w_type_1").css("margin-top").replace("px","");
                         $(document).scrollTop(scrollTop);
                         $(".popwrap.w_type_1").css("margin-top",Number(scrollTop)+Number(top)+"px");
                         la.confirmAction = function(){
                            return;
                         };
                         checkQuickProcess = true;
                     }else if(data == "zipcode"){
                         var scrollTop = $(document).scrollTop();
                         var la = new layerAlert('퀵배송 서비스 불가능  지역입니다.</br>배송지 변경 후 이용해 주세요.<br/>(서울 전 지역 가능, 향후 서비스 확대 예정입니다.)');
                         var top = $(".popwrap.w_type_1").css("margin-top").replace("px","");
                         $(document).scrollTop(scrollTop);
                         $(".popwrap.w_type_1").css("margin-top",Number(scrollTop)+Number(top)+"px");
                         la.confirmAction = function(){
                            return;
                         };
                         checkQuickProcess = true;
                     }else if(data == "MaxQty"){
                         var scrollTop = $(document).scrollTop();
                         var la = new layerAlert('퀵배송 주문이 마감되었습니다. 내일 다시 이용해 주세요.');
                         var top = $(".popwrap.w_type_1").css("margin-top").replace("px","");
                         $(document).scrollTop(scrollTop);
                         $(".popwrap.w_type_1").css("margin-top",Number(scrollTop)+Number(top)+"px");
                         la.confirmAction = function(){
                            return;
                         };
                         checkQuickProcess = true;
                     }else if(data == "stock"){
                         var scrollTop = $(document).scrollTop();
                         var la = new layerAlert('퀵배송 대상 상품의 빠른 재고 소진으로<br/>서비스 대상에서 제외되었습니다.');
                         var top = $(".popwrap.w_type_1").css("margin-top").replace("px","");
                         $(document).scrollTop(scrollTop);
                         $(".popwrap.w_type_1").css("margin-top",Number(scrollTop)+Number(top)+"px");
                         la.confirmAction = function(){
                            return;
                         };
                         checkQuickProcess = true;
                     }
                 },
                 error: function(xhr, Status, error) {
                     var la = new layerAlert(error);
                     la.confirmAction = function(){
                            return;
                     };
                 }
            });
        }
    }else{
        if($("#deliveryKind").val() != "normal"){
            $("#deliveryKind").val("");
        }
    }
    
    if(check4pmProcess || checkAthomeProcess || checkQuickProcess){
        $("#deliveryKind").val("");
        addToCartProcess = true;
        return false;
    }
    
    if(!checkAthomeProcess && $("#deliveryKind").val() == "athome"){
        var athomeProcessCheck = true;
        var athomeMsg = '<span style="color:red;">앳홈 서비스</span>로 <span style="color:red;">결제 없이</span><br><span style="color:red;">홈피팅</span> 하시겠습니까?<br>앳홈 서비스로 <span style="color:red">최대 3개 까지</span><br>이용하실 수 있습니다.';
        var scrollTop = $(document).scrollTop();
        var lc = new layerConfirm(athomeMsg, '앳홈 신청하기', "계속 쇼핑하기");
        var top = $(".popwrap.w_type_1").css("margin-top").replace("px","");
        $(".layerArea #clsBtn").remove();
        $(document).scrollTop(scrollTop);
        $(".popwrap.w_type_1").css("margin-top",Number(scrollTop)+Number(top)+"px");
        lc.confirmAction = function(){
            $(".btn_close").trigger("click");
            addtoCartFunction(qty,check4pmOver);
        };
        addToCartProcess = true;
    }else{
        addtoCartFunction(qty,check4pmOver);
        addToCartProcess = true;
    }
}

function addtoCartFunction(qty,check4pmOver){
    $.ajax({
         url: '/ko/shoppingbag/add',
         cache : false,
         async : false,
         type: "GET",            
         data: $('form[name=addToCartForm]').serialize(),
         success: function(msg){
             var errorMsg = msg;
             if(errorMsg == null || errorMsg == ''){
                _A_pl=Array(productCode); 
                AEC_F_D(productCode, 'i', qty);
                
                var reserveSaleYn = (typeof $("#erpWorkOrderNumber_0").val() != "undefined") ? true : false;
                
                if(reserveSaleYn) {//예약상품일경우
                    
                    var reserveOrderAddToCartMsg = "";
                    
                    if($("#buyNowYn").val()=='false') {//쇼핑백담기
                        reserveOrderAddToCartMsg= "예약상품이 쇼핑백에 담겼습니다.<br/><p style='color:red'>{0}년 {1}월 {2}일부터</p><font style='color:red'>순차적으로 배송</font> 예정 입니다."; 
                    } else {//예약주문
                        reserveOrderAddToCartMsg= "<p style='color:red'>{0}년 {1}월 {2}일부터</p><font style='color:red'>순차적으로 배송</font> 예정 입니다.<br/>(입고예정일은 제작상황에 따라<br />변경될 수 있습니다.)";
                    }
                    reserveOrderAddToCartMsg    = reserveOrderAddToCartMsg.replace("{0}", $('#deliveryPlanYear').val());
                    reserveOrderAddToCartMsg    = reserveOrderAddToCartMsg.replace("{1}", $('#deliveryPlanMounth').val());
                    reserveOrderAddToCartMsg    = reserveOrderAddToCartMsg.replace("{2}", $('#deliveryPlanDay').val());
                    
                    if($("#buyNowYn").val()=='false') {//쇼핑백담기
                        var lc = new layerConfirm(reserveOrderAddToCartMsg, "쇼핑백 바로가기", "계속 쇼핑하기");
                        lc.confirmAction = function(){
                            $(".btn_close").trigger("click");
                            
                            var cartUrl = "/ko/shoppingbag";
                            
                            if($("#storePickupCheck").is(":checked")) {
                                cartUrl += "?cartDivision=store";
                            } else if($("#athomeCheck").is(":checked")) {
                                cartUrl += "?cartDivision=athome";
                            } else if($("#quickCheck").is(":checked")) {
                                cartUrl += "?cartDivision=quick";
                            }
                            
                            window.location.href=cartUrl;
                        };
                        lc.cancelAction = function(){
                        	window.location.reload();
                        }
                    } else {//예약주문
                        var lc = new layerConfirm(reserveOrderAddToCartMsg, "예약상품 바로주문하기");
                        $("#clsBtn").remove();
                        
                        lc.confirmAction = function(){
                            $(".btn_close").trigger("click");
                            buynow(check4pmOver);
                        };
                        lc.cancelAction = function(){
                        	window.location.reload();
                        }
                    } 
                    
                } else {//바로주문
                    buynow(check4pmOver);
                }
                
                if(!check4pmOver){
                    var cnt = $("#cartCount").text();
                    cnt = cnt == null || cnt == "" ? 1 : parseInt(cnt) + parseInt(1);
                    $("#cartCount").text(cnt);
                }
             }else{
                if(msg.indexOf("당일출고") > -1){
                    var scrollTop = $(document).scrollTop();
                    var lc = new layerConfirm(msg, "쇼핑백 담기", "취소");
                    var top = $(".popwrap.w_type_1").css("margin-top").replace("px","");
                    $(document).scrollTop(scrollTop);
                    $(".popwrap.w_type_1").css("margin-top",Number(scrollTop)+Number(top)+"px");
                    lc.confirmAction = function(){
                        $("#deliveryKind").val("normal");
                        addToCart();
                    };
                }else{
                    var la = new layerAlert(errorMsg);
                    la.confirmAction = function(){
                        return;
                    };               
                }
             }
         },
         error: function(xhr, Status, error) {
             
             var la = new layerAlert(error);
             la.confirmAction = function(){
                    return;
             };
         }
    });
}
function buynow(check4pmOver)
{
    if($('form[name=addToCartForm] input[name=buyNowYn]').val() == "true") {
        $("#addToCartButton, #addToCartBuyNowButton").off("click").on("click",  function(e) {
            new layerAlert("처리중입니다.");
            return false;
        });
        
        $("#addToCartButton").prop("href", "");
        $("#addToCartBuyNowButton").prop("onclick", "");
        
        if("false" == "true"  &&  "ko" == "ko"){
        	NetFunnel_Action({action_id:"buy_now"},function(ev,ret){
        		
                //checkout1(바로주문) 액션은 주문서페이지에서 일괄적으로 처리
                //setEcommerceData("Checkout1(바로주문)");
                location.replace("/ko/checkout/ordersheet");
                    
        
            });
        }else{
        	
            //checkout1(바로주문) 액션은 주문서페이지에서 일괄적으로 처리
            //setEcommerceData("Checkout1(바로주문)");
            location.replace("/ko/checkout/ordersheet");
            
        }
        
    } else {
        var layerMsg = "";
        if(check4pmOver){
            layerMsg = '오후{0}시 이후 주문시 일반배송으로 변경됩니다.';
        }else{
            layerMsg = "쇼핑백에 담겼습니다.<br />확인하시겠습니까?";
        }
        
        var scrollTop = $(document).scrollTop();
        var lc = new layerConfirm(layerMsg, "쇼핑백 바로가기", "계속 쇼핑하기");
        var top = $(".popwrap.w_type_1").css("margin-top").replace("px","");
        $(document).scrollTop(scrollTop);
        $(".popwrap.w_type_1").css("margin-top",Number(scrollTop)+Number(top)+"px");
        lc.confirmAction = function(){
            $(".btn_close").trigger("click");
            
            var cartUrl = "/ko/shoppingbag";
            
            if($("#storePickupCheck").is(":checked")) {
                cartUrl += "?cartDivision=store"; 
            } else if($("#athomeCheck").is(":checked")) {
                cartUrl += "?cartDivision=athome"; 
            } else if($("#quickCheck").is(":checked")) {
                cartUrl += "?cartDivision=quick";
            }
            
            window.location.href=cartUrl;
        };
        lc.cancelAction = function(){
        	window.location.reload();
        }
    }
    
}

function addWishList(){
    
    var productCode = $("#productCode").val();
    
    $.ajax({
         url: '/ko/wishlist/add-product-action',
         type: "GET",            
         data: {productCode: productCode
                ,type:'toggle'},
         success: function(errorMsg){
             
             var wishMessageTimer = false;
             
             if(errorMsg != null && errorMsg != ''){
                 if(errorMsg == "erroor1"){
                     var la = new layerAlert('로그인을 해야 합니다.');
                 }else{
                     var cnt = $("#wishlistCount").text();
                     cnt = cnt == null || cnt == "" ? 1 : parseInt(cnt) - parseInt(1);
                     $("#wishlistCount").text(cnt);                  
                     //var la = new layerAlert('위시리스트에서 삭제했습니다.');
                     //addWishListClick();
                     wishMessageTimer = true;
                 }
             }else{
                 var cnt = $("#wishlistCount").text();
                 cnt = cnt == null || cnt == "" ? 1 : parseInt(cnt) + parseInt(1);
                 $("#wishlistCount").text(cnt);
                 wishMessageTimer = true;
             }
             
             if(wishMessageTimer == true) {
                $('.wishlist1803').stop().toggleClass('on');
                $('.' + productCode + 'LIKE').stop().toggleClass('on');
                
                $('.toast_popup').stop().toggleClass('on');
                $('.toast_popup p').stop().show();
                if($('.wishlist1803').hasClass('on')){
                    $('.toast_popup p').text('위시리스트에 담았습니다.');
                    $('.toast_popup').stop().addClass('on');
                }else{
                    $('.toast_popup p').text('위시리스트에서 삭제했습니다.');
                    $('.toast_popup').stop().removeClass('on');
                }
                $('.toast_popup p').stop().animate({'top':'-42px','opacity':1});
                setTimeout(function(){
                    $('.toast_popup p').stop().animate({'top':0,'opacity':0});
                },1750);
                setTimeout(function(){
                    $('.toast_popup p').stop().fadeOut();
                },2000);
             }
         },
         error: function(xhr, Status, error) {
             var la = new layerAlert(error);
             la.confirmAction = function(){
                return;
            };  
         }
    });
}

function addWishListClick()
{   
    if(!$('.wishlist1803').hasClass('on')){
        //brazeLogCustomEvent
        brazeLogCustomEvent("Wish", "");
        //brazeCustomAttribute
        brazeCustomAttribute("Wish", "add");
    }else{
        //brazeCustomAttribute
        brazeCustomAttribute("Wish", "remove");
    }
    
    addWishList();
    
}
function imageZoom(){
    
    var layerTag = '<div class="layerArea" style="z-index:8;">';
    layerTag +='<div id="imgLayerArea" class="layerBg" style="background:#FFFFFF; position: inherit;z-index:7;width:100%;height:auto;outline:none;">';
    layerTag +='    <div id="item_vsl_modal"> ';
    layerTag +='        <div class="gallery-wrapper" id="productImagePop"> ';
    layerTag +='            <a class="close productImagePopClose" href="javascript:void(0);"/> ';
    layerTag +='        </div>';
    layerTag +='    </div>';
    layerTag +='</div>';
    layerTag +='</div>';
    
    var thisLayer = $(layerTag).appendTo($('.item_detail > .adaptive_wrap'));
    
    $("#productImagePop").append($("#imageDivW ul").clone());
    
    /* $("#productImagePop ul").children('li').each(function(index){
        var arrLenChk = $(this).children('img').attr('src').split("_P").length;
        alert(arrLenChk +", :"+ $(this).children('img').attr('src'));
        if(arrLenChk > 2) {
            var arrLen = $(this).children('img').attr('src').split("_").length - 1;
            var arrImg = $(this).children('img').attr('src').split("_");
            var arrLen = $(this).children('img').attr('src').split("_").length - 1;
            arrImg[arrLen] = arrImg[arrLen].replace("P0", "W0");
            $(this).children('img').attr('src', arrImg.join("_"));
        } else {
            //$(this).children('img').attr('src', $(this).children('img').attr('src').replace("_P0", "_W0"));
            var imgsrc = $(this).children('img').attr('src').split("/dims")[0];
            //$(this).children('img').attr('src', imgsrc.replace("_P0", "_W0"));
        }
    });  */
    btnPosition();
    
    thisLayer.find(".layerBg").css("width", $('.item_detail > .adaptive_wrap').width() + 4);
    var height = $("#bodyWrap").height();
    $("#bodyWrap").height($("#item_vsl_modal").height());
    
    thisLayer.find('.productImagePopClose').click(function(){
        thisLayer.remove();
        $("#bodyWrap").css("height", "");
        $(window).scrollTop("0");
        return false;
    });
}

function fn_popAddMileageInfo(){ // 추가적립 안내 팝업
    //fn_parentLayer();
    $("#addMileageInfo").show();
}

function fn_cardBenefit(){
    //fn_parentLayer();
    $("#cardBenefit").show();
}

function fn_popupDelivery(){
    //fn_parentLayer();
    $("#popupDelivery").show();
}

function fn_popupSizeQuickReference(){
    //fn_parentLayer();
    $("#sizeQuickReferenceLayer").show();
}

function fn_parentLayer(){
    
    $("#productLayer .layerBg").addClass("white");
    
    $("#productLayer").show();
}

function fn_reName(str){
    var name = str.split("");
    var reName = "";
    for(var i=0; i<name.length;i++){
        if(i != 1){
            reName += name[i];  
        }else{
            reName +="*";
        }
    }
    return reName;
}

function fn_popupProductQnA(pageNum){
    
    if(pageNum == null || pageNum == ''){
        pageNum=1;
    }
    
    var productCode = $("#productCode").val();
    
    $.ajax({
         url: '/ko/p/productQnA',
         type: "GET",
         dataType:"json",
         data: {"productCode":productCode, "pageNum":pageNum, "pageSize":10 },
         success: function(data){
             qaAHtml(data);          
         },
         error: function(xhr, Status, error) {
            var la = new layerAlert(error);
            la.confirmAction = function(){
                return;
            };
         }
    });
    
}

function showProductLayer(backgroud) {
    $("#productLayer").show();
}
function hideProductLayer() {
	
	$("#customerReviewWriteDiv #reviewFileCd").val('');
	$("#customerReviewWriteDiv #reviewFileCd1").val('');
	$("#customerReviewWriteDiv #reviewFileCd2").val('');
	$("#customerReviewWriteDiv #reviewFileCd3").val('');
	$("#customerReviewWriteDiv #reviewFileCd4").val('');
    $("#productLayer .layerBg").removeClass("white");
    $("#productLayer").hide();
    
}
function qnaFilesubmit(){
    
    var tUrl = "";
    if($('#qnaFile').val() == null || $('#qnaFile').val() == ''){
        
        $.ajax({
             url: '/ko/p/qnaWriteNofile',
             type: "GET",
             data: $('form#productQnAForm').serialize(),
             success: function(data){
                 qnaWriteSuccess(data);
             },
             error: function(xhr, Status, error) {
                 var la = new layerAlert(error);                 
                    la.confirmAction = function(){
                        return;
                    };
             }
        });
        
    }else{
        $('form#productQnAForm').ajaxSubmit({
            type : "post", 
            url : "/ko/p/qnaWrite" + "?CSRFToken=ec35065f-63f2-4b5d-8f20-aec5bd737cbc",
            //dataType : "json",
            error : function( request, status, error ){
                var la = new layerAlert(error);
            }, 
            success : function(data){
                if(data.fileCheck == "success"){
                    qnaWriteSuccess(data);                  
                }else{
                    var la = new layerAlert('파일 확장자를 확인해 주세요.'); // 확장자를 확인해 주세요
                }
            }
        });
    }
    
}

var layerAlertNew = function(msg){
    var t = this;
    
    this.confirmAction = function(){};

    var scrollTop = $(window).scrollTop()+"px";
    var tp=($(window).height()-250)/2+"px";

    var alertTag = '<div class="layerArea" style="z-index:1110">';
    alertTag +='<div class="layerBg"></div> ';
    alertTag +='<div class="popwrap w_type_1" style="z-index:150;top:'+scrollTop+';margin-top:'+tp+'">';
    alertTag +='<div class="pop_cnt">';
    alertTag +='<h3 class="pop_tlt copy">'+msg+'</h3>';
    alertTag +='<div class="btnwrap">';
    alertTag +='<input type="button" class="btn gray_s mr0" value="확인" />';
    alertTag +='</div>';
    alertTag +='</div>';
    alertTag +='<a href="javascript:void(0);" class="btn_close"><img src="/_ui/desktop/common/images/popup/ico_close.png" alt="닫기"></a>';
    alertTag +='</div>';
    alertTag +='</div>';

    var $alertLayer = $(alertTag).appendTo('body');

    $alertLayer.find('.btn.gray_s').click(function(){
        $alertLayer.remove();
        t.confirmAction();
    });
    
    $alertLayer.find('.btn.wt_s, .btn_close').click(function(){
        $alertLayer.remove();
    });
}

function slidPrev(){
    
    var objDiv;
    
    if(status == 1 ){
        return;
    }
    status = 1;
    $("#productDetailEtc .productEtcDiv").each(function(){
        
        if( $(this).css('display') == 'block' ){
            objDiv = $(this);
        }
    });
    
    var slidUl = objDiv.find("ul");
    
    //상품평이 아닐 때 
    if(document.getElementById("customerReviewDiv").style.display == "none"){
      //추천상품,최근본상품
        var liWidth = slidUl.find("li").width()*6;
        var max = (slidUl.find("li").size()) * slidUl.find("li").width();
        
        var marginLeft = slidUl.css("marginLeft").replace("px", "");
        
        var rest = slidUl.find("li").size()%6;
        
        if((marginLeft*-1)<liWidth){
            liWidth = slidUl.find("li").width()*rest;
        }
        //추천상품,최근본상품끝
        
        //룩북
        $("#productEctTab ul li").each(function(){
            if($(this).find("a").text().indexOf("룩북") > -1 && $(this).find("a").attr('class') == 'on'){
                liWidth = slidUl.find("li").width();
                max = (slidUl.find("li").size() - 4) * liWidth;
            }
        });
        //룩북끝
    }
    
    if( marginLeft >= 0 ){
        status = 0;
        return false;
    }
    slidUl.stop().animate({'marginLeft': '+='+liWidth+'px'}, 'normal', function(){status = 0;});
    
    return false;
}


function slidNext(){
    
    var objDiv;
    
    if(status == 1 ){
        return;
    }
    status = 1;
    $("#productDetailEtc .productEtcDiv").each(function(){
        
        if( $(this).css('display') == 'block' ){
            objDiv = $(this);
        }
    });
    
    var slidUl = objDiv.find("ul");
    
    //상품평이 아닐 때 
    if(document.getElementById("customerReviewDiv").style.display == "none") {
        //추천상품,최근본상품
        var liWidth = slidUl.find("li").width()*6;
        var max = (slidUl.find("li").size()) * slidUl.find("li").width();
        
        var marginLeft = slidUl.css("marginLeft").replace("px", "");
        
        marginLeft = parseFloat(marginLeft)-liWidth;
          
        var rest = slidUl.find("li").size()%6;
        
        if((max+marginLeft)<liWidth){
            liWidth = slidUl.find("li").width()*rest;
        }
        //추천상품끝
        
        //룩북
        $("#productEctTab ul li").each(function(){
            if($(this).find("a").text().indexOf("룩북") > -1 && $(this).find("a").attr('class') == 'on'){
                liWidth = slidUl.find("li").width();
                max = (slidUl.find("li").size() - 4) * liWidth;
                marginLeft = slidUl.css("marginLeft").replace("px", "");
            }
        });
        //룩북끝
     }
    
    if( (parseFloat(max) + parseFloat(marginLeft)) <= 0 ){
        status = 0;
        return;
    }
    
    slidUl.stop().animate({'marginLeft': '-='+liWidth+'px'}, 'normal', function(){status = 0;});
    
    return false;
}

function goDetailPage(productCode){
    var url = '/ko/p';
    url += "/"+productCode;
    window.location.href=url;
}

function goDetailPagebyRecommend(productCode, clickUrl){

    var url = '/ko/p' + "/" + productCode;
    var host = "http://"+ $(location).attr('host') + url +"?type=recommendProd";
    
    var tempUrl = clickUrl + "&url=" + encodeURI(host);
        
    window.location.href=tempUrl;
}

function fn_goCategori(categori){
    window.location.href= "/ko/c/"+categori+"/"+categori;
}

function fn_goOuCategori(categori){
    window.location.href= "/ko/c/ou_"+categori+"/ou";
}

function fn_goSubCategori(categori, subBrandCd){
    window.location.href= "/ko/c/"+categori+"/"+categori+"?subBrand="+subBrandCd;
}

function fn_layerAlert(text) {
    var la = new layerAlert(text);
    return;
}
function mileageInfoView(){//noti 자세히 보기
    $('.mileage_info_wrap1906 .btn_noti_box > span').on('click',function(){
        if($(this).parents('.mileage_info_wrap1906').find('.noti_box').css("display") == "none"){
            $(this).parents('.mileage_info_wrap1906').find('.noti_box').stop().slideDown('fast');
            $(this).closest('.btn_noti_box').addClass('on');
            $(this).text('닫기');
            
            GA_Event('상품평','마일리지 자세히 보기','클릭');
        }else{
            $(this).parents('.mileage_info_wrap1906').find('.noti_box').stop().slideUp('fast');
            $(this).closest('.btn_noti_box').removeClass('on');
            $(this).text('자세히 보기');
        }
    });
}

function onErrorImg(washCode){

    if(washCode.tagName == "IMG"){          // 정상 이미지 일 때
	    $("#newHowToWash img").each(function(){
	        if($(this).attr("alt") == washCode.alt){
	            $(this).hide();
	            $(this).parent().find(".code_num").css("display", "block");
	        }
	    });
    } else if(washCode.tagName == "SPAN"){   // 에러 이미지 대체 화면 일 때
        
        $("#newHowToWash img").each(function(){
            
            var origin = $(washCode).parent().find("img").attr("alt");
            
            if($(this).attr("alt") == origin){
                $(this).show();
                $(this).parent().find(".code_num").css("display", "none");
            }
        });
    }
}
function lastImgMove(){
	if(moveYn){
		var isChrome = navigator.userAgent.toLowerCase().indexOf('chrome') > -1;
		var viewpordWidth = $('#lookbookListContent .bx-viewport').width();
		var viewpordOffsetRight = $('#lookbookListContent .bx-viewport').offset().left + viewpordWidth;
	
		var liLastWidth = $('#lookbookListContent .productSlide li:last').width();
		var liLastOffsetRight = $('#lookbookListContent .productSlide li:last').offset().left + liLastWidth;
		
		var moveImageWidth = liLastOffsetRight - viewpordOffsetRight;
		
		if(moveImageWidth > 5){
			if($.browser.msie == true && Number($.browser.version) <= 9) { 
				var nowSlider = parseInt(lookBookbxslider.css('left'));
				prevMoveImageWidth = nowSlider;
				lookBookbxslider.stop().animate({'left':(nowSlider-moveImageWidth)+'px'});
			}else{
				if(isChrome){
					var nowSlider = parseInt(lookBookbxslider.css('transform').split(',').reverse()[1]);
				}else{
					var nowSlider = parseInt(lookBookbxslider.css('transform').split(',').reverse()[3]);
				}
				
				prevMoveImageWidth = nowSlider;
			
				lookBookbxslider.css('transition-duration','0.5s');
				lookBookbxslider.css('transform','translate3d('+(nowSlider-moveImageWidth)+'px,0px,0px)');
			}
			$(".bx-prev").hide();
			$(".lookbook_prev").show();
			
			moveYn=false;
		}
	}
}
function prevImgMove(){
	if($.browser.msie == true && Number($.browser.version) <= 9) { 
		lookBookbxslider.stop().animate({'left':prevMoveImageWidth+'px'});
	
	}else{
		lookBookbxslider.css('transition-duration','0.5s');
		lookBookbxslider.css('transform','translate3d('+prevMoveImageWidth+'px,0px,0px)');
	}
	$(".bx-prev").show();
	$(".lookbook_prev").hide();
	moveYn=true;
}

function brazeCustomAttribute(action, type){
    var attributeNm = "";
    var baseCode = "IL2C5WSH942W_DN";
    if("IL2C5WSH942W_DN".indexOf("_") > -1) {
        baseCode = "IL2C5WSH942W_DN".split("_")[0];
    }
    
    if(action == "Wish"){
        attributeNm = "wishAddRemoveAttribute";
    }else if(action == "Cart"){
        attributeNm = "cartAddRemoveAttribute";
    }
    if(type == "remove"){
        appboy.getUser().removeFromCustomAttributeArray(
            attributeNm,
            baseCode
        );
    }else{ // add
        appboy.getUser().addToCustomAttributeArray(
            attributeNm,
            baseCode
        );
    }
}

//]]>
</script>

    <div id="globalMessages">
        </div>
    <div id="bodyWrap" class="item_detail">
        <div id="oneEventLayer"></div>

        <div class="adaptive_wrap">
            <div class="clearfix prd_detail1905" id="clearfix">
		<div class="clearfix image_view3">
	<a href="javascript:imageZoom()" id="btn_zoom" class="btn_zoom" onclick="GA_Event('상품_상세','크게보기','클릭')">크게보기</a><!-- 버튼 클릭시 item_visual 에 zoom 클래스 추가 -->
	<!-- 2021.08.18 동영상 재생 수정, 상품 imageDivisionCode에 VOD가 있는 경우 동영상 url 세팅 -->
	<div class="image_view1" id="image_view1">
		<div class="item_visual" id="imageDiv" style="margin-top: 20px;">
			<ul>
				<li><img src="${productInfo.t01_imageurl }" class="respon_image" alt="${productInfo.pname }" onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img1.jpg'" /></li>
				<li><img src="${productInfo.t02_imageurl }" class="respon_image" alt="${productInfo.pname }" onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img1.jpg'" /></li>
				<li><img src="${productInfo.t03_imageurl }" class="respon_image" alt="${productInfo.pname }" onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img1.jpg'" /></li>
			</ul>
		</div>
	</div>
	<div class="item_visual" id="imageDivW" style="display:none">
        <ul>
            <li><img src="${productInfo.t01_imageurl }" class="respon_image" alt="${productInfo.pname }" onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img1.jpg'" /></li>
            <li><img src="${productInfo.t02_imageurl }" class="respon_image" alt="${productInfo.pname }" onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img1.jpg'" /></li>
            <li><img src="${productInfo.t03_imageurl }" class="respon_image" alt="${productInfo.pname }" onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img1.jpg'" /></li>
        </ul>
    </div>
    <!--동영상 삽입 180710-->
    <!--//동영상 삽입 180710-->
<!--  2021.08.18 동영상 재생 영역  -->
    </div>
<!-- 품절상품포함 여부 -->
<script type="text/javascript">
//<![CDATA[
var stockOnlineStockpile = {};
var warehouseStockpile = {};

$(document).ready(function() {
    cartQuantity = {};
    
    
    $(".btn_star_score li a").on("click", function(){
        $("#rating").val($(this).attr('value'));
    });
    
    $('#offlineQty').click(function(){
        fn_stockconfirm();
    });

    var productCode = $("#productCode").val();

		stockOnlineStockpile["IL2C5WSH942W_DN_82"] = "7";
		warehouseStockpile["IL2C5WSH942W_DN_82"] = "0";
	
		stockOnlineStockpile["IL2C5WSH942W_DN_88"] = "4";
		warehouseStockpile["IL2C5WSH942W_DN_88"] = "0";
	
	$(".btn_close").on("click", function(){
		hideProductLayer(); 
		$(".popwrap").hide();
	});	
	
	$('.toggle_type1>dt').click(function() {
		
		$(this).addClass('on');
		$(this).siblings('dt').removeClass('on');
		
		var beforeHeight = $(".toggle_type1").height();
		var afterHeight = 0;
		var scrolltop = $(window).scrollTop();
		
		var checkElement = $(this).next();
		
		if((checkElement.is('dd')) && (checkElement.is(':visible'))) {
			$(this).removeClass('on');
	 		checkElement.slideUp('fast', 
	 				function(){
	 					afterHeight = $(".toggle_type1").height();
// 	 					bodyScroll();
	 				});
	 		
		}
		var fitGuide = false;
		if((checkElement.is('dd')) && (!checkElement.is(':visible'))) {
		    var v_label = "";
		    var v_type = $(this).children().attr("id");
		    //21.11.03 상품상세 정보 영역 변경 관련 GA이벤트태깅 추가 및 변경
		    if(v_type == "NEW_DETAIL_INFO_EVT"){
		        v_label = "상품상세정보";
		    }else if(v_type == "DETAIL_INFO_EVT"){
		        if ('ko' == 'ko') {
		            v_label = "상품정보제공고시";
		        }else{
		            v_label = "상품상세정보";
		        }
		    }else if(v_type == "REAL_SIZE_EVT"){
                v_label = "실측사이즈";
            }else if(v_type == "DELI_RETURN_EVT"){
                v_label = "배송 및 반품";
            }else if(v_type == "FIT_GUIDE_EVT"){
                fitGuide = true;
            }
		    
		    if(!fitGuide) {
		        GA_Event('상품_상세','정보',v_label);
		    }
		    
			$('.toggle_type1>dd:visible').slideUp('fast');
			
			checkElement.slideDown('fast', 
	 				function(){
					afterHeight = $(".toggle_type1").height();
// 					bodyScroll();
				});
		}
		
		if(fitGuide) {
		    fitGuide_Swiper_Slide(1);
		}
		
		var bodyScroll = function(){
			
			$('body,html').animate({scrollTop:parseFloat(scrolltop + (beforeHeight - afterHeight))}, 
					function(){
						bodyReSize();
					}
			);
		}
		
		if($(this).next('dd').length == 0) {
			return true;
		} else {
			return false; 
		}      
	});
	
	if ( 'en' == 'ko' || 'zh' == 'ko' ) {
		showExchangeRate();
	}
	
	$("#restock_tlt").mouseover(function(){
// // 		showExchangeRate();
		$("#restock_delch_box").css("display","block");
	});
	
	$("#restock_tlt").mouseout(function(){
		$("#restock_delch_box").css("display","none");
	});
	
	if($('#referencesListContent ul:eq(0) > li').length > 3) {
		matchItemSlider();
	}else {
	    $(".related_evt .matches_list > ul > li").css("margin-right", "10px");
	}

	//타임옴므 실측사이즈
	if("BR31" == "BR06"){
		var checkShow = false;
		var checkCode = "IL2C5WSH942W";
		var checkLanguage = "ko";
		if(checkCode == "TH1H7WPC500M" || checkCode == "TH1I3WPC505M" || checkCode == "TH1H8WPC503M" || checkCode == "TH1HAWPC505M"  || checkCode == "TH1HAWPC505MP1" ){
			$(".timehomme_pants_fit").addClass("slim");
			$(".timehomme_pants_fit").removeClass("straight");
			$(".timehomme_pants_fit").removeClass("comfort");
			checkShow = true;			
		}else if(checkCode == "TH1H8WPC510M" || checkCode == "TH1H8WPC530M" || checkCode == "TH1H8WPC540M" || checkCode == "TH1HBWPC535M" || checkCode == "TH1HAWPC545M" || checkCode == "TH1HAWPC525M"  || checkCode == "TH1HAWPC525MP1" ){
			$(".timehomme_pants_fit").removeClass("slim");
			$(".timehomme_pants_fit").addClass("straight");
			$(".timehomme_pants_fit").removeClass("comfort");
			checkShow = true;			
		}
		
		if(checkShow){
			if(checkLanguage == "ko"){
				$(".timehomme_pants_fit").addClass("ko");
			}else if(checkLanguage == "en"){
				$(".timehomme_pants_fit").addClass("en");
			}else if(checkLanguage == "zh"){
				$(".timehomme_pants_fit").addClass("zh");
			}
			
			$(".timehomme_pants_fit").show();
		}
	}
	
	//at home,quick 배송지 변경
	$(".btn_chg").on("click",function(){
	    if($(this).parent().parent().attr("id") == "athome_svc"){
	        searchAddressLayer("streetname","streetnumber","postalcode");	        
	    }else if($(this).parent().parent().attr("id") == "quick_svc"){
	        searchAddressLayer("quickStreetname","quickStreetnumber","quickPostalcode");
	    }
	});
   
});

var starscore = 0;
function getStarScore(starscore){
    var average = starscore;
    var starWidth=0;
    if(1 <= average && average < 1.25){
        starWidth=20;
    } else if(1.25 <= average && average < 1.75){
        starWidth=30;
    } else if(1.75 <= average && average < 2.25){
        starWidth=40;
    } else if(2.25 <= average && average < 2.75){
        starWidth=50;
    } else if(2.75 <= average && average < 3.25){
        starWidth=60;
    } else if(3.25 <= average && average < 3.75){
        starWidth=70;
    } else if(3.75 <= average && average < 4.25){
        starWidth=80;
    } else if(4.25 <= average && average < 4.75){
        starWidth=90;
    } else if(4.75 <= average && average <= 5){
        starWidth=100;
    }
    return starWidth;
}

function setOneClick(){
    
}

function fnSharePin(sUrl){
	var sImg = "http://newmedia.thehandsome.com/IL/2C/SS/IL2C5WSH942W_DN_C01.jpg";
	var sTxt = "[LÄTT] 시스루 패널 캡 슬리브 셔츠";
	
	if(sImg.indexOf("_C01") > 0) {
		sImg = sImg.replace("_C01", "_W01");
	}
	
	var href = "http://www.pinterest.com/pin/create/button/?url="+sUrl+"&media="+sImg+"&description="+encodeURIComponent(sTxt);
	var a = window.open(href, 'pinterest', 'width=800, height=500');
	if ( a ) {
		a.focus();
	}
}

function addHidden(ptag, hname, hvl) {
    
    if($("#"+hname).length >0){
        $("#"+hname).remove();
    }
    return $('<input/>').attr('type'    , 'hidden')
                        .attr('id'      , hname)
                        .attr('name'    , hname)
                        .attr('value'   , hvl)
                        .appendTo(ptag);
}

/* 주문서간편결제 : 결제 인증 후 콜백
원클릭구매 : iframe 안에서 실행되기 때문에, target 을 _top으로 지정합니다
 */
var checkoutPaymentAuthCallback = function (resultCode, resultMsg, result) {
    console.log(document.cookie);
    switch(resultCode) {
	case "2406": // 쿠키정보가 없습니다.
		//layerWpayCookieSettingView();
		//WPAY.close();
		//window.parent.postMessage({layerClose:'layerClose'},'*');
		//window.parent.postMessage({inicisPopOpen:'inicisPopOpen'},'*');
		
		console.log("쿠키 정보가 없음");
		break;
	case "0000":	    
	    $("body").append('<div class="layerArea" id="productLayer"><div class="layerBg"></div></div>');
	    
	    $(".layerArea .layerBg").css('background','none');
	    
		// 토스트 팝업 추가
		var toastPopup = '<div class="pop_loading_oneclick200210" style="background:#444;width:290px;height:120px;position:fixed;top:30%;left:50%;margin-left:-145px;margin-top:-60px;z-index:9999;">';
		toastPopup += '<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/Spinner_1s_105px.png" alt="loading" style="display:block;width:32px;height:32px;margin:30px auto 15px auto;">';
		toastPopup += '<p style="color:#fff;text-align:center;">';
	    toastPopup += '<span style="background:url(\'http://cdn.thehandsome.com/pc/products/one_click_pay_w.png\') left 2px no-repeat;color:#fff;font-size:15px;padding-left:93px;">가 진행중입니다.</span>';
	    toastPopup += '</p>';
	    toastPopup += '</div>';
	        
		$("body").append(toastPopup);

	    //상품상세와 결제페이지 구분이 안되기 때문에 
	    //window.parent.postMessage({loadingShow:'loadingShow'},'*');
        
		var $PAY_FORM = $("#PAY_FORM");
		addHidden($PAY_FORM, 'wtid'	, result.wtid);
		
		$PAY_FORM.attr({
			'method': 'POST',
			'action': '/ko/inicis/inipaywpay/sop/response',
			'target': '_top'
		});
		
		$PAY_FORM.submit();
		break;
	default:
		new layerAlert(resultMsg);
		//WPAY.close();
		//window.parent.postMessage({layerClose:'layerClose'},'*');
		break;
	}
}



function addWishListProdClick(productBaseCode) {    
    
    
    addWishListProd(productBaseCode);
}

function addWishListProd(productBaseCode){
    $.ajax({
         url: "/ko/wishlist/add-product-action",
         type: "GET",            
         data: {productCode: productBaseCode ,type: 'toggle'},
         success: function(msg){	 
        	 
			if(msg !== 'erroor1'){
				if(productBaseCode === 'IL2C5WSH942W_DN'){
        			$('.wishlist1803').toggleClass('on'); 
        		}
            	$('.' + productBaseCode + 'LIKE').each(function(index, ele){
            		$(ele).toggleClass('on'); 
            	})
         	}
 			
        	 
        	 
         }
    });
}


function chngColorChip(ele, sourceProd, targetProd) {
	
	var $this = $('#chipbtn_' + targetProd);
	var $thisChips = $this.closest('.we-codi-colorchip');
	//$thisChips.find('a').removeClass('on');
 
	$.ajax({
		url		: '/ko/product/reloadCoordiSize',
		type	: 'GET',
		datatype: 'json',
		data	: {
			'productcode'	: targetProd
		},
		success	: function(data) {
			var product = data.product;
			var images;
			
			var txtHtml = '';
			var lookbookTxtHtml = '';
			/* 가격변경 */
			var priceHtml = '';
			
			 priceHtml = product.price.formattedValue;
			
            if(priceHtml != ''){
				$('#prod_'+sourceProd+' .info_wrap .price').html(priceHtml);
            }
			
			if ( product.productImages != null ) {
				
				for ( var i=0; i<product.productImages.length; i++ ) {
					images = product.productImages[i];
					
					if ( images.imageDivisionCode.code === 'S01' ) {
						txtHtml = images.image.url;	
						break;
					}
				}
			}
			
			
			$(ele).parent().closest('#prod_'+sourceProd).find('img').attr('src', txtHtml);
			
			
		}
	});
	

}

// 210728 oera 신규 추가 S
function fn_popupOeraMileage(){ 
    //fn_parentLayer();
    $("#popupOeraMileage").show();
}
</script>

<div class="item_detail_info float_right" id="contentDiv" style="margin-top: 20px;">
	<div class="info">
		<div class="info_sect">
			<h4 class="item_name">
				<div class="brand-name">
					<a href="javascript:fn_goCategori('br31')" onclick="GA_Detail('brand',$(this))">${productInfo.bname }</a>
				</div>
				<span class="name ko_fir_spel">
					${productInfo.pname }<input type="hidden" id="brandName" value="LÄTT"/>
					<input type="hidden" id="productName" value="${productInfo.pname }"/>
					<input type="hidden" id="productCode" value="${productInfo.pid }"/>
				</span>
			</h4>
			
			<div class="flag">
			</div>
			
			<p class="price">
				<span>₩<fmt:formatNumber value="${productInfo.pprice }" type="number" pattern="###,###" /></span>
						<input type="hidden" id="productPrice" value="${productInfo.pprice }"/>
			</p>
			<!-- 상품추가설명 -->
			<p class="selling_point"></p>
			<!-- 20200914이후 추가 상품설명 (신) -->
		            <div class="prod-detail-con-box">
		                    <strong class="number-code">상품품번 &#58; <span>${productInfo.pid }</span></strong>
		                    <div class="round-style">
		                        <p>${productInfo.pdetail }</p>
		                    </div>
		                    </div>
		            <!-- 20200914 이전 상품설명(구) -->
		            </div>
                 <div class="info_sect">
			<ul class="point_delivery">
				<li>
					<span class="title">한섬마일리지</span>
					<span class="txt"><fmt:formatNumber value="${productInfo.pprice * 0.05 }" type="number" pattern="###,###" />&nbsp;M&nbsp;(5%)</span>
				</li>
				<li>
                    <span class="title">H.Point</span>
                     <span class="txt"><fmt:formatNumber value="${productInfo.pprice * 0.001 }" type="number" pattern="###,###" />&nbsp;P&nbsp;(0.1%)</span>
                        <a href="javascript:fn_cardBenefit();" id="cardbenef" class="etc_info" onclick="GA_Event('상품_상세','카드사_혜택안내','클릭');">카드사 혜택안내</a>
                    <script type="text/javascript">
$(document).ready(function(){
	
	
		fn_tableMerge($("#noInterestTable").attr("id"));
	
		fn_tableMerge($("#partNoInterestTable").attr("id"));
	
	
    $('.card img').each(function (){
        $(this).attr('src',cdnImgUrl($(this).attr('orgurl')));
    })
});

// CDN 이미지 URL로 변경
function cdnImgUrl(mediaUrl) {
    var rtnUrl = mediaUrl;
    try { 
        var searchText = 'context='
        var cdnDomain = 'http://image.thehandsome.com/sys_master/';
        rtnUrl = rtnUrl.substr(rtnUrl.indexOf(searchText)+searchText.length, rtnUrl.length);
        rtnUrl = decodeURIComponent(atob(rtnUrl)).split('|');
        if ( rtnUrl.length > 4 ) {
            rtnUrl = rtnUrl[4];
            rtnUrl = cdnDomain + rtnUrl;
        } else {
            rtnUrl = mediaUrl;
        }
    } catch (e) {
        console.log(e);
    }
    return rtnUrl;
}

function fn_tableMerge(id){
	
	var beforName = "";
	var mergeCnt = 1;
	var beforObj;
	
	$("#"+id+" th").each(function(){
		
		if(beforName == ""){
			beforName = $(this).attr("name");
			beforObj = $(this);
		}else if(beforName == $(this).attr("name")){
			mergeCnt = mergeCnt + 1;
			$(this).remove();
			beforObj.attr("rowspan", mergeCnt);
		}else{
			beforName = $(this).attr("name");
			beforObj = $(this);
			mergeCnt = 1;
		}
		
	});
}

</script>

<div class="popwrap w_type_2" id="cardBenefit" style="display:none;">
	<div class="pop_tltwrap2">
		<h3>카드혜택안내</h3>
	</div>
	<div class="pop_cnt">
		<div class="card_benefits scroll-y">
			<div class="box">
					<div class="title clearfix">
						<p class="float_left">무이자 할부 행사</p>
						<!-- 
						<p class="float_left">무이자 할부 행사</p>
						<p class="float_right">행사기간 : 2015.08.01 ~ 2015.12.31</p>
						-->
					</div>
					<table class="cnt_type1" id="noInterestTable">
						<caption>무이자 할부 행사</caption>
						<colgroup>
							<col style="width:155px"/>
							<col />
						</colgroup>
						<tbody>
							<tr>
									<th scope="row" name="신한카드"><span class="card"><img src="" orgurl="/medias/shinhan.jpg?context=bWFzdGVyfHJvb3R8MjY1N3xpbWFnZS9qcGVnfGhkZS9oMmIvODgxNDE4MTUxNTI5NC5qcGd8NTAwMDYxM2ZmZmRlZGFhZDQ0ODNmODJjZTg2OTE3MGI3OWQ2ZmE3YzI0ZjA3MDY3NzIxYWVhNmY3NDQyYWUzMA" alt="신한카드" /></span></th>
									<td><b>신한카드 5만원이상 결제시 2~7개월 무이자 할부</b><br />
대상: 신한카드 전 회원<br />
(신한BC 제외/ 법인,기프트,체크,선불카드 제외)
<br/>
									2022.05.01&nbsp;~&nbsp;2022.05.31</td>
								</tr>
							<tr>
									<th scope="row" name="삼성카드"><span class="card"><img src="" orgurl="/medias/SAMSUNG.jpg?context=bWFzdGVyfHJvb3R8MzIxOXxpbWFnZS9qcGVnfGgzZC9oNGQvODgxNDE4MTYxMzU5OC5qcGd8ZGY1NDJiM2U1YWNmNGE5MTJkOTA0MTAxMDliMDc4ZjRlNTJmZjJlOTkxOTQzZTEwMDcxZWU2NGU2MjJmMWE2Mw" alt="삼성카드" /></span></th>
									<td><b>삼성카드 5만원이상 결제시 2~6개월 무이자 할부</b><br />
대상: 삼성카드 전 회원<br />
(법인,기프트,체크,선불카드 제외)<br/>
									2022.05.01&nbsp;~&nbsp;2022.05.31</td>
								</tr>
							<tr>
									<th scope="row" name="비씨카드"><span class="card"><img src="" orgurl="/medias/BC.jpg?context=bWFzdGVyfHJvb3R8MjQ1OHxpbWFnZS9qcGVnfGhmMi9oMGQvODgxNDE4MTIyMDM4Mi5qcGd8MjZlZGU2ZGQyNDBkYzU5YmY2NWY0MDU3NDc1OTA0YWI5NmM4NDJjMDFiYjBiYjBjY2FhZjhmMzg3ZmE5NGU5Yw" alt="비씨카드" /></span></th>
									<td><b>비씨카드 5만원이상 결제시 2~7개월 무이자 할부</b><br /> 
대상: 비씨카드 전 회원<br />(법인,기프트,체크,선불카드 제외)<br/>
									2022.05.01&nbsp;~&nbsp;2022.05.31</td>
								</tr>
							<tr>
									<th scope="row" name="현대카드"><span class="card"><img src="" orgurl="/medias/HYUNDAI.jpg?context=bWFzdGVyfHJvb3R8MjYxMHxpbWFnZS9qcGVnfGg1ZC9oN2MvODgxNDE4MTcxMTkwMi5qcGd8YmM5ZWY0ZjlhODlkMzdmMjYyNmY4NjQ4OWU5NWVjOWFlMGY4ODIwYzZlNjA0MjBlNDkwNWI0ZDllYThjMWE5Mw" alt="현대카드" /></span></th>
									<td><b>현대카드 5만원이상 결제시 2~7개월 무이자 할부</b><br />
대상: 현대카드 전 회원<br />
(법인,기프트,체크,선불카드 제외)<br/>
									2022.05.01&nbsp;~&nbsp;2022.05.31</td>
								</tr>
							<tr>
									<th scope="row" name="국민카드"><span class="card"><img src="" orgurl="/medias/kucmin.jpg?context=bWFzdGVyfHJvb3R8MzMwM3xpbWFnZS9qcGVnfGgyZS9oMzQvODgxNDE4MTAyMzc3NC5qcGd8MjM1YjEyN2I4OTljMGIxYzY3MjhjNDhkZWMyOTE5ODZjYmRiYWExNDdhOWZmNDQ3ZWNhNGIxZjYwYzk2MDA4Zg" alt="국민카드" /></span></th>
									<td><b>KB국민카드 5만원이상 결제시 2~7개월 무이자 할부</b><br />
대상: KB국민카드 전 회원<br />
(NH농협, 국민BC 제외/ 법인,기프트,체크,선불카드 제외)<br/>
									2022.05.01&nbsp;~&nbsp;2022.05.31</td>
								</tr>
							<tr>
									<th scope="row" name="하나카드"><span class="card"><img src="" orgurl="/medias/hanacard.gif?context=bWFzdGVyfHJvb3R8MTkzNXxpbWFnZS9naWZ8aDYwL2hmYi84ODE0MDU0OTY1Mjc4LmdpZnxhMGM5OWY0MDdhNDhjYzkwOTdiMzhkM2VmMDQ2YTI0NTAyNDBjZTljNTdiYzk4YWRhZmI0NjBhOWRhNzRiMGYw" alt="하나카드" /></span></th>
									<td><b>하나카드 5만원이상 결제시 2~8개월 무이자 할부</b><br />
대상: 하나카드 전 회원 (구 하나SK, 구 외환)<br />
(하나BC카드 포함/법인,기프트,체크,선불카드 제외)<br/>
									2022.05.01&nbsp;~&nbsp;2022.05.31</td>
								</tr>
							<tr>
									<th scope="row" name="NH카드"><span class="card"><img src="" orgurl="/medias/NH.jpg?context=bWFzdGVyfHJvb3R8Mzk3OXxpbWFnZS9qcGVnfGg4ZS9oMzYvODgxNDE4MTkwODUxMC5qcGd8ZWVlNmY1OWM0NDdmMjg2M2Y4NGZkNDZjYThmOTVkMWNmY2QwYWNkOWI1ODc5YTdiMTc5MjY4MThiZTkzYzNmMw" alt="NH카드" /></span></th>
									<td><b>NH농협카드 5만원이상 결제시 2~8개월 무이자 할부</b><br />
대상: NH농협카드 전 회원<br />
(NH농협BC카드 포함/ 법인,기프트,체크,선불카드 제외)
<br/>
									2022.05.01&nbsp;~&nbsp;2022.05.31</td>
								</tr>
							<tr>
									<th scope="row" name="롯데카드"><span class="card"><img src="" orgurl="/medias/LOTTE.jpg?context=bWFzdGVyfHJvb3R8MzI3MXxpbWFnZS9qcGVnfGhiMy9oNDcvODgxNDE4MTgxMDIwNi5qcGd8MDliOThkNzA1ZDc2ZDE4MzZhYmUzYjI2MDMxZDk0NGU3OTVjYzBhYTA1MmMzMjAyZmE0Y2U4OTZlNTU3NDU2Zg" alt="롯데카드" /></span></th>
									<td><b>롯데카드 5만원이상 결제시 2~4개월 무이자 할부</b><br />
대상:롯데카드 전 회원<br />
(법인,기프트,체크,선불카드 제외)<br/>
									2022.05.01&nbsp;~&nbsp;2022.05.31</td>
								</tr>
							</tbody>
					</table>
				</div>
			<div class="box">
					<div class="title clearfix">
						<p class="float_left">부분 무이자 할부 행사</p>
						
					</div>
					<table class="cnt_type1" id="partNoInterestTable">
						<caption>부분 무이자 할부 행사</caption>
						<colgroup>
							<col style="width:155px">
							<col >
						</colgroup>
						<tbody>
							<tr>
									<th scope="row" name="신한카드"><span class="card"><img src="" orgurl="/medias/shinhan.jpg?context=bWFzdGVyfHJvb3R8MjY1N3xpbWFnZS9qcGVnfGhkZS9oMmIvODgxNDE4MTUxNTI5NC5qcGd8NTAwMDYxM2ZmZmRlZGFhZDQ0ODNmODJjZTg2OTE3MGI3OWQ2ZmE3YzI0ZjA3MDY3NzIxYWVhNmY3NDQyYWUzMA" alt="신한카드" /></span></th>
									<td><b>10개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3,4회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)<br/>
									2022.05.01&nbsp;~&nbsp;2022.05.31</td>
								</tr>
							<tr>
									<th scope="row" name="삼성카드"><span class="card"><img src="" orgurl="/medias/SAMSUNG.jpg?context=bWFzdGVyfHJvb3R8MzIxOXxpbWFnZS9qcGVnfGgzZC9oNGQvODgxNDE4MTYxMzU5OC5qcGd8ZGY1NDJiM2U1YWNmNGE5MTJkOTA0MTAxMDliMDc4ZjRlNTJmZjJlOTkxOTQzZTEwMDcxZWU2NGU2MjJmMWE2Mw" alt="삼성카드" /></span></th>
									<td><b>10개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3,4회차 고객 부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)<br/>
									2022.05.01&nbsp;~&nbsp;2022.05.31</td>
								</tr>
							<tr>
									<th scope="row" name="삼성카드"><span class="card"><img src="" orgurl="/medias/SAMSUNG.jpg?context=bWFzdGVyfHJvb3R8MzIxOXxpbWFnZS9qcGVnfGgzZC9oNGQvODgxNDE4MTYxMzU5OC5qcGd8ZGY1NDJiM2U1YWNmNGE5MTJkOTA0MTAxMDliMDc4ZjRlNTJmZjJlOTkxOTQzZTEwMDcxZWU2NGU2MjJmMWE2Mw" alt="삼성카드" /></span></th>
									<td><b>12개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3,4,5회차 고객 부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)
<br/>
									2022.05.01&nbsp;~&nbsp;2022.05.31</td>
								</tr>
							<tr>
									<th scope="row" name="비씨카드"><span class="card"><img src="" orgurl="/medias/BC.jpg?context=bWFzdGVyfHJvb3R8MjQ1OHxpbWFnZS9qcGVnfGhmMi9oMGQvODgxNDE4MTIyMDM4Mi5qcGd8MjZlZGU2ZGQyNDBkYzU5YmY2NWY0MDU3NDc1OTA0YWI5NmM4NDJjMDFiYjBiYjBjY2FhZjhmMzg3ZmE5NGU5Yw" alt="비씨카드" /></span></th>
									<td><b> 우리BC 10개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)
<br/>
									2022.05.01&nbsp;~&nbsp;2022.05.31</td>
								</tr>
							<tr>
									<th scope="row" name="비씨카드"><span class="card"><img src="" orgurl="/medias/BC.jpg?context=bWFzdGVyfHJvb3R8MjQ1OHxpbWFnZS9qcGVnfGhmMi9oMGQvODgxNDE4MTIyMDM4Mi5qcGd8MjZlZGU2ZGQyNDBkYzU5YmY2NWY0MDU3NDc1OTA0YWI5NmM4NDJjMDFiYjBiYjBjY2FhZjhmMzg3ZmE5NGU5Yw" alt="비씨카드" /></span></th>
									<td><b>우리BC 12개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3,4회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)
<br/>
									2022.05.01&nbsp;~&nbsp;2022.05.31</td>
								</tr>
							<tr>
									<th scope="row" name="국민카드"><span class="card"><img src="" orgurl="/medias/kucmin.jpg?context=bWFzdGVyfHJvb3R8MzMwM3xpbWFnZS9qcGVnfGgyZS9oMzQvODgxNDE4MTAyMzc3NC5qcGd8MjM1YjEyN2I4OTljMGIxYzY3MjhjNDhkZWMyOTE5ODZjYmRiYWExNDdhOWZmNDQ3ZWNhNGIxZjYwYzk2MDA4Zg" alt="국민카드" /></span></th>
									<td><b>10개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)<br/>
									2022.05.01&nbsp;~&nbsp;2022.05.31</td>
								</tr>
							<tr>
									<th scope="row" name="국민카드"><span class="card"><img src="" orgurl="/medias/kucmin.jpg?context=bWFzdGVyfHJvb3R8MzMwM3xpbWFnZS9qcGVnfGgyZS9oMzQvODgxNDE4MTAyMzc3NC5qcGd8MjM1YjEyN2I4OTljMGIxYzY3MjhjNDhkZWMyOTE5ODZjYmRiYWExNDdhOWZmNDQ3ZWNhNGIxZjYwYzk2MDA4Zg" alt="국민카드" /></span></th>
									<td><b>12개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3,4회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)<br/>
									2022.05.01&nbsp;~&nbsp;2022.05.31</td>
								</tr>
							<tr>
									<th scope="row" name="하나카드"><span class="card"><img src="" orgurl="/medias/hanacard.gif?context=bWFzdGVyfHJvb3R8MTkzNXxpbWFnZS9naWZ8aDYwL2hmYi84ODE0MDU0OTY1Mjc4LmdpZnxhMGM5OWY0MDdhNDhjYzkwOTdiMzhkM2VmMDQ2YTI0NTAyNDBjZTljNTdiYzk4YWRhZmI0NjBhOWRhNzRiMGYw" alt="하나카드" /></span></th>
									<td><b>10개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)<br/>
									2022.05.01&nbsp;~&nbsp;2022.05.31</td>
								</tr>
							<tr>
									<th scope="row" name="하나카드"><span class="card"><img src="" orgurl="/medias/hanacard.gif?context=bWFzdGVyfHJvb3R8MTkzNXxpbWFnZS9naWZ8aDYwL2hmYi84ODE0MDU0OTY1Mjc4LmdpZnxhMGM5OWY0MDdhNDhjYzkwOTdiMzhkM2VmMDQ2YTI0NTAyNDBjZTljNTdiYzk4YWRhZmI0NjBhOWRhNzRiMGYw" alt="하나카드" /></span></th>
									<td><b>12개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3,4회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)<br/>
									2022.05.01&nbsp;~&nbsp;2022.05.31</td>
								</tr>
							<tr>
									<th scope="row" name="신한카드"><span class="card"><img src="" orgurl="/medias/shinhan.jpg?context=bWFzdGVyfHJvb3R8MjY1N3xpbWFnZS9qcGVnfGhkZS9oMmIvODgxNDE4MTUxNTI5NC5qcGd8NTAwMDYxM2ZmZmRlZGFhZDQ0ODNmODJjZTg2OTE3MGI3OWQ2ZmE3YzI0ZjA3MDY3NzIxYWVhNmY3NDQyYWUzMA" alt="신한카드" /></span></th>
									<td><b>12개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3,4,5회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)<br/>
									2022.05.01&nbsp;~&nbsp;2022.05.31</td>
								</tr>
							</tbody>
					</table>
					<ul class="bul_sty01_li mt10">
						<li>무이자 할부 결제 시 카드사 포인트는 적립되지 않습니다.</li>
						<li>ARS 무이자 할부는 해당 카드사 ARS 번호로 사전 신청을 하신 경우에 한하여<br />무이자 혜택이 적용됩니다.(ARS 부문 무이자 할부 포함)</li>
						<li>상기 부분 무이자 할부는 5만원 이상 결제 시 자동 적용되며, 결제창에는 무이자 표시가   되지 않을  수 있습니다.</li>
						<li>법인 / 체크 / 선불 / 기프트 / 은행 계열 카드는 제외됩니다.</li>
						<li>고객 부담 수수료는 해당 카드사로 문의 바랍니다.</li>
						<li>본 행사는 카드사 사정에 따라 일부 내용이 변경 또는 중단될 수 있습니다.</li>
					</ul>
				</div>
			</div>
	</div>
	<a href="javascript:void(0);" class="btn_close"><img src="http://cdn.thehandsome.com/_ui/desktop/common/images/popup/ico_close.png" alt="닫기" /></a>
</div>
</li>
				
				<li>
					<span class="title">배송비</span>
					<span class="txt">30,000원 이상 무료배송 (실결제 기준)</span>
					   <a href="javascript:fn_popupDelivery();" class="etc_info" onclick="GA_Event('상품_상세','배송안내','클릭');">배송안내</a>
					<div class="popwrap w_type_2" id="popupDelivery" style="display:none;">
	<div class="pop_tltwrap2">
		<h3>배송비안내</h3>
	</div>
	<div class="pop_cnt">
		<table class="cnt_type1">
			<caption>배송비안내</caption>
			<colgroup>
				<col style="width:155px" />
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">배송기간</th>
					<td>평균 입금완료일 기준 2-4일 소요됩니다.<br />(토/일/공휴일 제외)</td>
				</tr>
				<tr>
					<th scope="row">배송비</th>
					<td>
						<ul class="bul_sty01_li">
							<li>30,000원 이상 결제 시 <em class="ft_point01">무료배송</em></li>
							<li>30,000원 미만 결제 시 <em class="ft_point01">2,500원</em></li>
						</ul>
						<p class="bul_sty02">도서산간 지역은 3,000원의 별도 배송비가 부과됩니다.</p>
						<p class="bul_sty02">쿠폰/바우처 할인금액 및 한섬마일리지/H.Point 사용을 제외한 실결제금액 기준입니다.</p>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<a href="javascript:void(0);" class="btn_close"><img src="http://cdn.thehandsome.com/_ui/desktop/common/images/popup/ico_close.png" alt="닫기" /></a>
</div>
</li>
				</ul>
		</div>

		<div class="info_sect" >
			<ul class="color_size_qty">
				<li>
					<span class="title">색상</span>
					<div id="getcolor" class="txt">
					</div>
					<span class="cl_name" id="colorNameContent"></span>
				</li>
				<li>
				    <span class="title">사이즈<!-- 사이즈 --></span>
					<span class="txt">
					<script type="text/javascript">

$(document).ready(function(){
	
	var tab = $('#size_tab ul li');
	var content = $('.size_tab_container > div');
	$('.size_tab_container > div + div').css('display','none');
	tab.on('click', function(e){
		e.preventDefault();
		var tg = $(this);
		var tc = tg.find('> a');
		tab.find('> a').removeClass('active');
		tc.addClass('active');
		i = tg.index();
		content.css('display', 'none');
		content.eq(i).css('display', 'block');
	});
	
});

</script>

<div class="popwrap w_type_2" id="sizeQuickReferenceLayer" style="display:none;">
	<div class="pop_tltwrap2">
		<h3>사이즈조견표</h3>
	</div>
	<div class="pop_cnt">
		<div class="size_chart">
			<div class="tab_a m6" id="size_tab">
				<ul>
					<li><a href="#;" class="active">WOMEN<br />TOP</a></li>
					<li><a href="#;">WOMEN<br />BOTTOMS</a></li>
					<li><a href="#;">WOMEN<br />SHOES</a></li>
					<li><a href="#;">MEN<br />TOP</a></li>
					<li><a href="#;">MEN<br />BOTTOMS</a></li>
					<li><a href="#;">MEN<br />SHOES</a></li>
				</ul>
			</div>
			<div class="size_tab_container">
				<div>
					<table class="cnt_type2">
						<caption>사이즈조견표</caption>
						<colgroup>
							<col />
							<col style="width:16%" />
							<col style="width:16%" />
							<col style="width:16%" />
							<col style="width:16%" />
							<col style="width:16%" />
						</colgroup>
						<thead>
							<tr class="al_middle">
								<th scope="col">BRAND/<br />SIZE</th>
								<th scope="col">XS</th>
								<th scope="col">S</th>
								<th scope="col">M</th>
								<th scope="col">L</th>
								<th scope="col">FREE</th>
							</tr>
						</thead>
						<tbody>
							<tr class="al_middle">
								<th scope="row">TIME</th>
								<td>76</td>
								<td>82</td>
								<td>88</td>
								<td>94</td>
								<td>90</td>
							</tr>
							<tr class="al_middle">
								<th scope="row">MINE</th>
								<td>76</td>
								<td>82</td>
								<td>88</td>
								<td>94</td>
								<td>90</td>
							</tr>
							<tr class="al_middle">
								<th scope="row">SYSTEM</th>
								<td>76</td>
								<td>82</td>
								<td>88</td>
								<td>-</td>
								<td>90</td>
							</tr>
							<tr class="al_middle">
								<th scope="row">SJSJ</th>
								<td>76</td>
								<td>82</td>
								<td>88</td>
								<td>-</td>
								<td>90</td>
							</tr>
							<tr class="al_middle">
								<th scope="row" rowspan="2">KOREA</th>
								<td>85</td>
								<td>90</td>
								<td>95</td>
								<td>100</td>
								<td>-</td>
							</tr>
							<tr class="al_middle">
								<td>44</td>
								<td>55</td>
								<td>66</td>
								<td>77</td>
								<td>-</td>
							</tr>
							<tr class="al_middle">
								<th scope="row">US</th>
								<td>2</td>
								<td>4</td>
								<td>6</td>
								<td>8</td>
								<td>-</td>
							</tr>
							<tr class="al_middle">
								<th scope="row">EUROPE</th>
								<td>34</td>
								<td>36</td>
								<td>38</td>
								<td>40</td>
								<td>-</td>
							</tr>
							<tr class="al_middle">
								<th scope="row">CHINA</th>
								<td>160/<br />80A</td>
								<td>165/<br />84A</td>
								<td>170/<br />88A</td>
								<td>175/<br />92A</td>
								<td>-</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div style="display:none;">
					<table class="cnt_type2">
						<caption>사이즈조견표</caption>
						<colgroup>
							<col />
							<col style="width:19%" />
							<col style="width:19%" />
							<col style="width:19%" />
							<col style="width:19%" />
						</colgroup>
						<thead>
							<tr class="al_middle">
								<th scope="col">BRAND/<br />SIZE</th>
								<th scope="col">XS</th>
								<th scope="col">S</th>
								<th scope="col">M</th>
								<th scope="col">L</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th scope="row">TIME</th>
								<td>61</td>
								<td>64</td>
								<td>67</td>
								<td>70</td>
							</tr>
							<tr>
								<th scope="row">MINE</th>
								<td>61</td>
								<td>64</td>
								<td>67</td>
								<td>70</td>
							</tr>
							<tr>
								<th scope="row">SYSTEM</th>
								<td>61</td>
								<td>64</td>
								<td>67</td>
								<td>-</td>
							</tr>
							<tr>
								<th scope="row">SJSJ</th>
								<td>61</td>
								<td>64</td>
								<td>67</td>
								<td>-</td>
							</tr>
							<tr class="al_middle">
								<th scope="row" rowspan="2">KOREA</th>
								<td>24</td>
								<td>26</td>
								<td>28</td>
								<td>30</td>
							</tr>
							<tr>
								<td>44</td>
								<td>55</td>
								<td>66</td>
								<td>77</td>
							</tr>
							<tr>
								<th scope="row">US</th>
								<td>2</td>
								<td>4</td>
								<td>6</td>
								<td>8</td>
							</tr>
							<tr>
								<th scope="row">EUROPE</th>
								<td>34</td>
								<td>36</td>
								<td>38</td>
								<td>40</td>
							</tr>
							<tr>
								<th scope="row">CHINA</th>
								<td>160/<br />66A</td>
								<td>165/<br />68A</td>
								<td>170/<br />70A</td>
								<td>175/<br />72A</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div style="display:none;">
					<table class="cnt_type2">
						<caption>사이즈조견표</caption>
						<colgroup>
							<col />
							<col style="width:19%" />
							<col style="width:19%" />
							<col style="width:19%" />
							<col style="width:19%" />
						</colgroup>
						<thead>
							<tr class="al_middle">
								<th scope="col">BRAND/<br />SIZE</th>
								<th scope="col">XS</th>
								<th scope="col">S</th>
								<th scope="col">M</th>
								<th scope="col">L</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th scope="row">TIME</th>
								<td>230</td>
								<td>235</td>
								<td>240</td>
								<td>245</td>
							</tr>
							<tr>
								<th scope="row">MINE</th>
								<td>230</td>
								<td>235</td>
								<td>240</td>
								<td>245</td>
							</tr>
							<tr>
								<th scope="row">SYSTEM</th>
								<td>230</td>
								<td>235</td>
								<td>240</td>
								<td>245</td>
							</tr>
							<tr>
								<th scope="row">SJSJ</th>
								<td>230</td>
								<td>235</td>
								<td>240</td>
								<td>245</td>
							</tr>
							<tr>
								<th scope="row">KOREA</th>
								<td>230</td>
								<td>235</td>
								<td>240</td>
								<td>245</td>
							</tr>
							<tr>
								<th scope="row">US</th>
								<td>6</td>
								<td>6.5</td>
								<td>7</td>
								<td>7.5</td>
							</tr>
							<tr>
								<th scope="row">EUROPE</th>
								<td>36</td>
								<td>36.5</td>
								<td>37</td>
								<td>37.5</td>
							</tr>
							<tr>
								<th scope="row">CHINA</th>
								<td>36</td>
								<td>37</td>
								<td>38</td>
								<td>39</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div style="display:none;">
					<table class="cnt_type2">
						<caption>사이즈조견표</caption>
						<colgroup>
							<col />
							<col style="width:16%" />
							<col style="width:16%" />
							<col style="width:16%" />
							<col style="width:16%" />
							<col style="width:16%" />
						</colgroup>
						<thead>
							<tr class="al_middle">
								<th scope="col">BRAND/<br />SIZE</th>
								<th scope="col">S</th>
								<th scope="col">M</th>
								<th scope="col">L</th>
								<th scope="col">XL</th>
								<th scope="col">XXL</th>
							</tr>
						</thead>
						<tbody>
							<tr class="al_middle">
								<th scope="row">TIME<br />HOMME</th>
								<td>90</td>
								<td>95</td>
								<td>100</td>
								<td>105</td>
								<td>110</td>
							</tr>
							<tr class="al_middle">
								<th scope="row">SYSTEM<br />HOMME</th>
								<td>90</td>
								<td>95</td>
								<td>100</td>
								<td>105</td>
								<td>110</td>
							</tr>
							<tr class="al_middle">
                                <th scope="row">CLUB<br />MONACO</th>
                                <td>XS</td>
                                <td>S</td>
                                <td>M</td>
                                <td>L</td>
                                <td>XL</td>
                            </tr>
							<tr class="al_middle">
								<th scope="row">KOREA</th>
								<td>90</td>
								<td>95</td>
								<td>100</td>
								<td>105</td>
								<td>110</td>
							</tr>
							<tr class="al_middle">
								<th scope="row">US</th>
								<td>36</td>
								<td>38</td>
								<td>40</td>
								<td>42</td>
								<td>44</td>
							</tr>
							<tr class="al_middle">
								<th scope="row">EUROPE</th>
								<td>46</td>
								<td>48</td>
								<td>50</td>
								<td>52</td>
								<td>54</td>
							</tr>
							<tr class="al_middle">
								<th scope="row">CHINA</th>
								<td>165/<br />80-90</td>
								<td>170/<br />96-98</td>
								<td>175/<br />108-110</td>
								<td>180/<br />118-122</td>
								<td>185/<br />126-130</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div style="display:none;">
					<table class="cnt_type2">
						<caption>사이즈조견표</caption>
						<colgroup>
							<col />
							<col style="width:9.5%" />
							<col style="width:9.5%" />
							<col style="width:9.5%" />
							<col style="width:9.5%" />
							<col style="width:9.5%" />
							<col style="width:9.5%" />
							<col style="width:9.5%" />
							<col style="width:9.5%" />
							<col style="width:9.5%" />
						</colgroup>
						<thead>
							<tr class="al_middle">
								<th scope="col">BRAND/<br />SIZE</th>
								<th scope="col">S</th>
								<th scope="col" colspan="2">M</th>
								<th scope="col" colspan="2">L</th>
								<th scope="col" colspan="2">XL</th>
								<th scope="col" colspan="2">XXL</th>
							</tr>
						</thead>
						<tbody>
							<tr class="al_middle">
								<th scope="row">TIME<br />HOMME</th>
								<td>74</td>
								<td colspan="2">78</td>
								<td>82</td>
								<td>84</td>
								<td>86</td>
								<td>88</td>
								<td>90</td>
								<td>92</td>
							</tr>
							<tr class="al_middle">
								<th scope="row">SYSTEM<br />HOMME</th>
								<td>74</td>
								<td colspan="2">78</td>
								<td>82</td>
								<td>84</td>
								<td>86</td>
								<td>88</td>
								<td>90</td>
								<td>92</td>
							</tr>
                            <tr class="al_middle">
                                <th scope="row">CLUB<br />MONACO</th>
                                <td>29</td>
                                <td>30</td>
                                <td>31</td>
                                <td>32</td>
                                <td>33</td>
                                <td colspan="2">34</td>
                                <td colspan="2">36</td>
                            </tr>
							<tr class="al_middle">
								<th scope="row">KOREA</th>
								<td>29</td>
								<td colspan="2">30</td>
								<td>32</td>
								<td>33</td>
								<td>34</td>
								<td>35</td>
								<td>35.5</td>
								<td>36</td>
							</tr>
							<tr class="al_middle">
								<th scope="row">US</th>
								<td>44T</td>
								<td colspan="2">46T</td>
								<td colspan="2">48T</td>
								<td colspan="2">50T</td>
								<td colspan="2">52T</td>
							</tr>
							<tr class="al_middle">
								<th scope="row">EUROPE</th>
								<td>44</td>
								<td colspan="2">46</td>
								<td colspan="2">48</td>
								<td colspan="2">50</td>
								<td colspan="2">52</td>
							</tr>
							<tr class="al_middle">
								<th scope="row">CHINA</th>
								<td>44</td>
								<td colspan="2">46</td>
								<td colspan="2">48</td>
								<td colspan="2">50</td>
								<td colspan="2">52</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div style="display:none;">
					<table class="cnt_type2">
						<caption>사이즈조견표</caption>
						<colgroup>
							<col />
							<col style="width:23%" />
							<col style="width:23%" />
							<col style="width:23%" />
						</colgroup>
						<thead>
							<tr class="al_middle">
								<th scope="col">BRAND<br/>SIZE</th>
								<th scope="col">S</th>
								<th scope="col">M</th>
								<th scope="col">L</th>
							</tr>
						</thead>
						<tbody>
							<tr class="al_middle">
								<th scope="row">TIME HOMME</th>
								<td>260</td>
								<td>270</td>
								<td>280</td>
							</tr>
							<tr class="al_middle">
								<th scope="row">SYSTEM HOMME</th>
								<td>260</td>
								<td>270</td>
								<td>280</td>
							</tr>
							<tr class="al_middle">
								<th scope="row">KOREA</th>
								<td>260</td>
								<td>270</td>
								<td>280</td>
							</tr>
							<tr class="al_middle">
								<th scope="row">US</th>
								<td>8</td>
								<td>9</td>
								<td>10</td>
							</tr>
							<tr class="al_middle">
								<th scope="row">EUROPE</th>
								<td>41</td>
								<td>42</td>
								<td>43.5</td>
							</tr>
							<tr class="al_middle">
								<th scope="row">CHINA</th>
								<td>43</td>
								<td>45</td>
								<td>47</td>
							</tr>
						</tbody>
					</table>
				</div>
				</div>
		</div>
	</div>
	<a href="javascript:void(0);" class="btn_close"><img src="http://cdn.thehandsome.com/_ui/desktop/common/images/popup/ico_close.png" alt="닫기" /></a>
</div>
<ul class="size_chip clearfix sizeChipKo1901">
										<li id="${productInfo.pid}_FREE"><a
											href="javascript:void(0)"
											onclick="setSize()">FREE<span
												class="ko_size1901" style="display:none;">&nbsp;(55)</span></a></li>
<!-- 										<li id="IL2C5WSH942W_DN_88"><a -->
<!-- 											href="javascript:fn_detailProductAjax('IL2C5WSH942W_DN_88')" -->
<!-- 											onclick="GA_Event('상품_상세','사이즈','88')">88<span -->
<!-- 												class="ko_size1901">&nbsp;(66)</span></a></li> -->
									</ul>
							</span>
					<!-- 2021.08.10 화장품 상품인 경우 사이즈조견표 영역 미노출 -->
					<a href="javascript:fn_popupSizeQuickReference();" class="etc_info" onclick="GA_Event('상품_상세','사이즈_조건표','클릭')">사이즈 조견표</a>
					<!-- 재입고알림 툴팁 -->
                    <!-- //재입고알림 툴팁 -->
                    </li>
				<li>
					<span class="title">수량</span>
					<span class="txt">
						<span class="qty_sel num">
							<a href="javascript:fn_qtySubtraction();" class="left" >이전 버튼</a>
							<input type="text" id="txtqty" title='수량' value="1" class="mr0" readonly="readonly">
							<a href="javascript:fn_qtyAdd();" class="right" >다음 버튼</a>
							     </span>
					</span>
					
					<input type="hidden" id="erpWorkOrderNumber" />     <input type="hidden" id="reserveSalesStockpile" />  <input type="hidden" id="erpWorkOrderProdCode" />  </li>
			</ul>
		</div>
		<div class="total_price clearfix">
			<div class="title float_left" style="width:auto;">총 합계</div>
			<div class="pirce float_right">
<!-- 				<div class="tlt_ship"> -->
<!-- 				<div class="delch_box" style="display: none;"> -->
<!-- 	       			<span class="arr">위치아이콘</span> -->
<!-- 	                <div> -->
<!-- 	                    <div id="exchangeDiv"></div> -->
<!-- 	                </div> -->
<!-- 	        	</div> -->
<!-- 				</div> -->
			<span id="sumPrice">₩<fmt:formatNumber value="${productInfo.pprice }" type="number" pattern="###,###" /></span>
			</div>
		</div>
		<!-- st_receipt_wrap -->
			<div class="st_receipt_wrap">
					    <div class="store_pickup" style="padding-bottom:0;border-bottom:0">
							<div class="input_wrap">
								
							<input type="checkbox" id="storePickupCheck" name="storePickupCheck" onclick="GA_Event('상품_상세','수령','매장수령');"/><label for="storePickupCheck">매장수령</label>
							</div>
							<img src="http://cdn.thehandsome.com/_ui/desktop/common/images/common/ico_ques2.png" alt="매장수령이란?" class="tlt"/>
							<div class="text">
								<p>매장에서 직접 상품 수령을 원하는 경우 체크하세요.  </p>
			                    <p>&#40;여러 개 상품 주문 시, 수령 매장이 동일한 경우 가능&#41; </p>
		                    </div>
							<!-- delch_box -->
							<div class="delch_box" id="store_delbox">
								<span class="arr">위치아이콘</span>
								<strong>매장 수령 이란? </strong>
								매장 수령을 원하시면 선택하세요.<br />
								여러 개의 상품 주문 시 수령 매장이 동일해야 합니다.
							</div>
							<!-- //delch_box -->
						</div>
						<!-- //delch_box -->
			             <!-- //delch_box -->
		            </div>
	            <!-- //st_receipt_wrap -->
			
			<!-- st_store_wrap -->
			<div class="st_store_wrap1807" id="storePickupChoice" style="display:none;">
				<div class="st_store">
					<dl>
						<dt>선택 매장</dt>
						<dd>
							<p id="storePickupChoiceName"></p>
							<p id="storePickupChoiceAddress"></p>
							<p id="storePickupChoiceTelephone"></p>
						</dd>
						<dt>수령 신청일</dt>
						<dd>
							<p id="storePickupChoiceDate"></p>
						</dd>
					</dl>
					<a href="javascript:fn_popupStorePickUp();" class="btn">매장변경</a>
				</div>
				<ul class="bul_sty01_li">
					<li>매장 수령 시 상품 사이즈 및 컬러 변경은 불가합니다.</li>
					<li>수령 가능 확정 일은 주문 완료 후, 수령 교환권을 SMS로 안내 드립니다.</li>
					<li>수령 확정일로부터 <span style="color:#fe4242;">1일 경과 후 상품을 수령하지 않으시면 자동 취소</span> 됩니다.</li>
				</ul>
			</div>
			<!-- //st_store_wrap -->
		<div class="btnwrap clearfix" style="position:absolute; width:473px;">
			<input type="button" value="" class="btn wishlist1803 float_left ml0  " onclick="addWishListClick();GA_Event('상품_상세','하단 고정 버튼','좋아요');">
		
		    <div class="toast_popup">
                <p style="display: none; top: -4.12381px; opacity: 0.031172;">위시리스트에서 삭제했습니다.</p>
            </div>
            
            <!--190508 추가 -->
            <div class="toast_popup_pre_order1905"><!-- 토스트팝업 190507 -->
                <p>예약 주문이 가능한 옵션(컬러/사이즈)가 있습니다. <br />옵션 선택 후 배송 예정일을 확인해 주세요.</p>
                <span class="arr">위치아이콘</span>
            </div>
            <!--//190508 추가 -->
			<form id="addToCartForm" name="addToCartForm" action="/shoppingbag" method="post"><input type="hidden" maxlength="3" size="1" name="qty" class="qty" />
				<input type="hidden" name="productCodePost" value="IL2C5WSH942W_DN"/>
				<input type="hidden" id="pid" name="pid" value="${productInfo.pid }"/>
				<input type="hidden" id="mid" name="mid" value="${sessionScope.member.mid }"/>
				<input type="hidden" id="psize" name="psize" value="F"/>
				<input type="hidden" id="pamount" name="pamount" value="1"/>
				<input type="button" value='쇼핑백 담기' class="btn cart1803 float_left ml0" id="addToCartButton" onClick="addToCart();"/>
        <div>
          <input type="hidden" name="CSRFToken" value="ec35065f-63f2-4b5d-8f20-aec5bd737cbc" />
        </div>
      </form><input type="button" value="바로주문" class="btn order float_right mr0" id="addToCartBuyNowButton" onClick="GA_Event('상품_상세','하단 고정 버튼','바로주문');addToCart(true);">   
	                </div>
		
		<dl class="toggle_type1" style="margin-top:80px;">
			<!-- 상품상세 정보창 변경 211027 S -->
			<dt><a href="javascript:void(0);" id="NEW_DETAIL_INFO_EVT">상품상세정보</a></dt>
			<dd>
				<div class="product-info-211027">
					<h3>상품 추가 정보</h3>
					<table>
						<caption>상품 추가 정보</caption>
						<colgroup>
							<col style="width:91px">
							<col style="width:125px;">
							<col style="width:127px">
							<col style="width:126px;">
						</colgroup>
						<tbody>
							<tr>
								<th>핏</th>
								<td >슬림핏</td>
								<td class="bold">레귤러핏</td>
								<td >루즈핏</td>
							</tr>
							<tr>
								<th>신축성</th>
								<td >없음</td>
								<td >조금 있음</td>
								<td class="bold">있음</td>
							</tr>
							<tr>
								<th>비침</th>
								<td class="bold">없음</td>
								<td >약간</td>
								<td >있음</td>
							</tr>
							<tr>
								<th>두께</th>
								<td class="bold">얇음</td>
								<td >보통</td>
								<td >두꺼움</td>
							</tr>
							<tr>
								<th>안감</th>
								<td class="bold">없음</td>
								<td >부분 안감</td>
								<td >전체 안감</td>
							</tr>
							</tbody>
					</table>
					<p>상기 정보는 주관적 내용이므로 참고해주세요</p>
				</div>
			</dd>
			<!-- 상품상세 정보창 변경 211027 E -->
			<dt>
				<a href="javascript:void(0);" id="DETAIL_INFO_EVT">
					상품정보제공고시</a>
			</dt>
			<dd style="display:none;">
				<strong>상품품번 :</strong> IL2C5WSH942W<br />
	                    <strong>품목 :</strong> 의류<br />
			                <strong>소재 :</strong> 겉감 면 18%, 나일론 79%, 폴리우레탄 3%, 배색1 견 100%, 배색2 폴리에스터 100%(DN,WT)<br />
						<strong>색상 :</strong> WT(WHITE), DN(DARK NAVY)<br />
						<strong>사이즈 :</strong> 88, 82<br />
						<strong>제조국 :</strong> 한국<br />
						<strong>제조사 :</strong> (주)한섬<br />
						<strong>제조연월 :</strong> 202204<br />
				     <br />
				<strong>품질보증기준</strong><br />
					1. 본 제품은 정부 고시 소비자 분쟁해결 기준에 의거 고객의 정당한 피해를 보상해드립니다. <br> - 원단 불량, 부자재 불량, 봉제 불량, 사이즈 부정확, 부당 표시(미표시 및 부실표시) 및 소재 구성 부적합으로 인한 세탁 사고 : 구입일로부터 1년 이내분은 무상수리, 교환, 구입가 환불함. (단, 봉제 불량은 1년 경과 후에도 무상 수선 가능) <br> - 사이즈가 맞지 않거나 디자인, 색상 불만 제품 : 구입 후 7일 이내로서 제품에 손상이 없는 경우 동일 가격, 동일 제품으로 교환 가능. <br> - 상하의 한 벌(세트/일착)인 경우 한 쪽에만 이상이 있어도 한 벌(세트/일착)로 처리함. 단, 소재 및 디자인이 다른 경우에는 해당 의류만 교환 가능. <br>2. 소비자 부주의에 의한 제품 훼손, 세탁 잘못으로 인한 변형 및 품질 보증기간(1년)이 경과한 제품에 대해서는 보상의 책임을 지지 않으며, 수선 가능시에는 실비로 수선해드립니다. <br>3. 제품에 이상이 있는 경우 바로 본사로 연락주시면 수선/교환/환불이 가능하나, 타업체(일반 수선실 등)에서 수선했을 경우는 불가능합니다.<br/><br/>
					<strong>세탁방법 및 취급 시 주의사항</strong><br />
						본 제품은 반드시 드라이크리닝 하십시오. 세탁 시 이염, 변색, 탈색될 수 있으니 유의하시기 바랍니다. 단추나 악세서리는 세탁 시 손상될 수 있으므로 은박지로 싸거나 분리하여 주십시오. 특성상 마찰에 의해 올 뜯김 등 원단 손상이 발생할 수 있으니 취급 시 주의하시기 바랍니다.<br/><br/>
					<div style="margin-bottom:20px;">
					<p style="float:left;">
					<strong>AS 책임자와 연락처</strong><br />
					㈜한섬/1800-5700</p>
					<!-- 20200218 마크 추가 -->
					<div class="sft_ksdt">
						</div>
					<!-- // 20200218 마크 추가 -->
					</div><br/><br/>
					위 내용은 상품정보제공 고시에 따라 작성되었습니다.</dd>
		<!-- 2021.08.10 화장품 상품인 경우 실측사이즈 영역 미노출 -->
		<dt><a href="javascript:void(0);" id="REAL_SIZE_EVT">실측사이즈</a></dt>
			<dd>
				<div class="ko realsize_img SZ03"></div>
						<p class="tit">셔츠</p>
						<!-- info_tbl -->
						<div class="detail-size-bd"> <!--20200910 --> <!-- 20160627 -->
							<span class="unit">단위(cm)</span>
							<!-- 아우터 사이즈 -->
							<table class="unit-board" border="0">
								
								<!-- 2019.07.24 아이템별 노출항목 판단 -->
								<!-- 2020.08.19 아이템별 노출항목 판단 -->
								<!-- 탑(베스트 제외) 2020.08.19 sizeCode 추가( SZ13 ~ SZ16 ) -->
									<caption>아우터 실측사이즈</caption>
								<colgroup>
									<col style="width:81px;" />
										<col style="width:auto;" />
										<col style="width:auto;" />
										<col style="width:auto;" />
										</colgroup>
								
								<thead>
									<tr>
										<th scope="col">사이즈</th>
										<th scope="col">82</th>
													<th scope="col">88</th>
													</tr>
								</thead>
								<tbody>
									<!-- 2020.08.19 실측사이즈 추가 09~12 -->
									<tr>
											<th scope="row">총길이</th>
													<td>
												65.4</td>
												<td>
												66.68</td>
												</tr>
									<tr>
											<th scope="row">가슴단면</th>	
													<td>
												53.34</td>
												<td>
												56.52</td>
												</tr>
									<tr>
											<th scope="row">어깨너비</th>
													<td>
												56.52</td>
												<td>
												59.69</td>
												</tr>
									</tbody>
							</table>
						</div>
						<!-- //info_tbl -->
	
						<!-- <p class="txt_last">- 모델착용사이즈 : <strong>82</strong></p> -->  <!-- 20160627 -->
					
					<!-- info_tbl -->
				
				<!-- //info_tbl -->
				<!-- numlist -->
				<br/>
	            <!-- //numlist -->
				<font color="red">
				<strong>
						원단, 측정방법에 따라 약간의 오차 가능성이 있습니다.</strong>
				</font>
				
				<div class="timehomme_pants_fit" style="display:none"></div>
			</dd>
		<dt><a href="#" id="DELI_RETURN_EVT">배송 및 교환/반품</a></dt>
		<dd>
		    <p class="tit">배송안내</p> <dl class="info_tbl"> <dt>배송방식 :</dt> <dd>우체국택배, CJ대한통운, 부릉, 굿투럭</dd><!-- 210728 oera 신규 추가  --> <dt>배송지역 :</dt> <dd>전국 (일부 지역 제외)</dd> <dt>배송정보 :</dt> <dd>평균 입금완료일 기준 2-4일 소요됩니다 (토/일/공휴일 제외)</dd> <dt>배송비 :</dt> <dd>실결제금액 기준 30,000원 이상 결제 시 무료배송<br>30,000원 미만 결제 시 2,500원(기본 배송비)<br>* 실결제금액이란, 쿠폰/바우처 할인액 및 <br>&nbsp; 한섬마일리지/H.Point 사용 금액을 제외한 금액입니다. <br> &nbsp;&nbsp;(e-money 사용은 실결제금액에 포함)<br>* 도서산간 지역은 3,000원의 별도 배송비가 부과됩니다.<br>* 일부 도서지역은 도선료가 부가될 수 있습니다. </dd> </dl> <p class="tit mt20">교환 및 반품안내</p> <!-- info_tbl --> <dl class="info_tbl"> <dt>교환/반품 기간 :</dt> <dd>상품 수령 후, 7일 이내</dd> <dt>교환절차 :</dt> <dd style="letter-spacing: -0.2px;"> 사이즈 및 상품불량 교환만 가능(색상교환 불가)하며 교환을 원하실 경우<br> 고객센터로 문의해주시기 바랍니다. (교환 재고가 없을 경우, 환불로 안내예정)<br> - 교환은 배송비 입금 및 상품 입고 확인 이후에 진행됩니다. <br> 화장품은 상품 불량만 교환 가능하며(상품 개봉 후 교환 불가), 고객센터로<br> 문의해주시기 바랍니다. <!-- 210728 oera 신규 추가  --> </dd> <dt>반품절차 :</dt> <dd>[배송완료] 7일 이내에 마이페이지 주문/배송/취소/반품 메뉴에서<br> [반품신청] 버튼을 클릭 시 가능합니다.</dd> <dt>교환/반품 배송비 :</dt> <dd style="letter-spacing: -0.4px;">배송비는 5,000원 이며(반품비는 주문시 배송비 결제 유무에 따라 변동)<br>상품 불량 등의 이유로 교환/반품하실 경우, 배송비는 무료입니다.</dd> <dt>교환/반품 불가사유</dt> <dd>다음의 경우에는 교환/반품이 불가합니다. <ol class="numlist"> <li> <span class="num sum">-</span> <span class="txt">교환/반품 기간(상품 수령 후 7일 이내)을 초과하였을 경우</span> </li> <li> <span class="num sum">-</span> <span class="txt">고객님의 요청에 의해 제품 사양이 변경(이니셜 제품, 사이즈 맞춤 제품 등)된 경우</span></li><li><span class="num sum">-</span><span class="txt">제품을 이미 사용하였거나, 제품 일부를 소비하였을 경우</span> </li> <!-- 210728 oera 신규 추가  --> <li> <span class="num sum">-</span> <span class="txt">화장품 : 상품 개봉 후 교환/반품 불가. 단 상품 불량(내용물 불량) 혹은 피부 트러블로 인한 반품은 가능(용량 1/3 미만 사용 및 의사소견서 1:1문의 첨부 필수)</span></li> <!-- // 210728 oera 신규 추가  --> <li> <span class="num sum">-</span> <span class="txt">식기류 : 제품 수령 후, 비닐포장을 개봉한 경우</span> </li> <li> <span class="num sum">-</span> <span class="txt">고객님의 귀책사유로 인해 회수가 지연될 경우</span> </li> <li> <span class="num sum">-</span> <span class="txt">국내외 환율 변동 등에 의해 가격이 변동되는 제품의 경우</span> </li> <li> <span class="num sum">-</span> <span class="txt">문제소지가 있는 제품을 본사가 아닌, 타 업체(일반 수선실 등)에서 선처리가 된 경우</span> </li> </ol> </dd> <!-- 210728 oera 신규 추가  --> <dt>교환/반품건 배송</dt> <dd>교환/반품 시 배송 받으신 박스로 반송하셔야 합니다. <br>(한섬/오에라/리퀴드퍼퓸바 상품 함께 주문 후 교환/반품 시 각각의 박스에 나눠서 반송해주세요. 한 박스에 함께 동봉하여 반송 시 교환/반품 처리가 불가할 수 있습니다)</dd> <!-- // 210728 oera 신규 추가  --> </dl> <p class="tit mt20">환불안내</p> <p>환불은 반송제품 확인 후 진행됩니다.</p><br />
				</dd>
        
        </dl>
	</div>
	
	<div class="clearfix mt30">
		<div class="btnwrap float_left">
<!-- 			<a href="javascript:fn_popupProductQnA();" class="btn arrow mr0" onclick="GA_Event('상품_상세','Q&A','클릭');">Q&amp;A(<span class="data" id="productQnACnt">0</span>)</a> -->
				<a href="/mypage" class="btn arrow mr0" onclick="GA_Event('상품_상세','Q&A','클릭');" style="cursor:hand;">Q&amp;A</a>
			</div>
		<div class="float_right">
<!-- AddToAny BEGIN -->
<div class="a2a_kit a2a_kit_size_32 a2a_default_style" >
<a href='javascript:fnSharePin("http://www.thehandsome.com/ko/HANDSOME/WOMEN/Top/Shirts/%EC%8B%9C%EC%8A%A4%EB%A3%A8-%ED%8C%A8%EB%84%90-%EC%BA%A1-%EC%8A%AC%EB%A6%AC%EB%B8%8C-%EC%85%94%EC%B8%A0/p/IL2C5WSH942W_DN");' class="pinterest" onclick="GA_Event('상품_상세','공유_SNS','PRINTEREST');"></a>
<input type="hidden" id="url" value="http://www.thehandsome.com/ko/HANDSOME/WOMEN/Top/Shirts/%EC%8B%9C%EC%8A%A4%EB%A3%A8-%ED%8C%A8%EB%84%90-%EC%BA%A1-%EC%8A%AC%EB%A6%AC%EB%B8%8C-%EC%85%94%EC%B8%A0/p/IL2C5WSH942W_DN"/>
</div>
<script type="text/javascript">
var a2a_config = a2a_config || {};
a2a_config.num_services = 10;
var brandName =	"[" + $('#brandName').val() + "]";
var productName = $('.name').contents().first().text();
a2a_config.linkname = brandName + " " + productName;
a2a_config.linkurl = 'http://www.thehandsome.com/ko/HANDSOME/WOMEN/Top/Shirts/%EC%8B%9C%EC%8A%A4%EB%A3%A8-%ED%8C%A8%EB%84%90-%EC%BA%A1-%EC%8A%AC%EB%A6%AC%EB%B8%8C-%EC%85%94%EC%B8%A0/p/IL2C5WSH942W_DN?lang=ko';
a2a_config.track_links = 'googl';
</script>
<script type="text/javascript" src="//static.addtoany.com/menu/page.js"></script>
<!-- AddToAny END -->

			</div>
	</div>

	<input type="hidden" id="viewExhibitionPageCode" value=""/>
	<input type="hidden" id="viewExhibitionPageName" value=""/>

    </div>

<form id="PAY_FORM" method="post" accept-charset="euc-kr">
</form>
</div>
	<div class="product-detail-img">
		</div>
<div class="matches_items" id="productDetailEtc">
                <script type="text/javascript">
//<![CDATA[

$(document).ready(function(){
	var recommendtProductYn = false;
	
	
		$('#recommendItemsListContent').css('display', 'block'); 
		recommendtProductYn = true;
	
		if(recommendtProductYn == false) {
			$('#newItemsListContent').css('display', 'block');
			$(".halatest_pb > a").addClass('on');
		}
		recommendtProductYn = true;
	
	
	if(recommendtProductYn == false) {
		$("#productEctTab .halatest_pb").css('display', 'block'); 
		$("#productEctTab .halatest_pb > a").addClass('on');
	}
});

function onMouseOverRecommend() {
	$(".rmd_pb_popup").css('display', 'block');
}
function onMouseOutRecommend() {
	$(".rmd_pb_popup").css('display', 'none');
}


//]]>
</script>

</div>
        </div>
<style>
#delQnAFile {
    display: inline;
    position: absolute;
    top: 9px;
    right: 115px;
}

#textQnAFile {
    padding: 0 30px 0 6px;
    width: calc(100% - 24px);
    text-overflow: ellipsis;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	$("#inquiryMobileNo2").on("keyup", function() {
		$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
		if ($("#inquiryMobileNo2").val().length > 0) {
			var inputNumberchk = /^[0-9]+$/; // 숫자 체크
			if (!inputNumberchk.test($("#inquiryMobileNo2").val())){
				$(this).val($(this).val().replace(/[^0-9]/gi,""));
				var la = new layerAlert("숫자만 입력 가능합니다.");
				la.confirmAction = function(){
					$("#inquiryMobileNo2").focus();
				};
			}
		}
	});

	$("#inquiryMobileNo3").on("keyup", function() {
		$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
		if ($("#inquiryMobileNo3").val().length > 0) {
			var inputNumberchk = /^[0-9]+$/; // 숫자 체크
			if (!inputNumberchk.test($("#inquiryMobileNo3").val())){
				$(this).val($(this).val().replace(/[^0-9]/gi,""));
				var la = new layerAlert("숫자만 입력 가능합니다.");
				la.confirmAction = function(){
					$("#inquiryMobileNo3").focus();
				};
			}
		}
	});

	$("#inquiryEmailSel").change(function(){
		if ($("#inquiryEmailSel").val().trim() == "") {
			$("#inquiryEmailDomain").val("");
		} else {
			$("#inquiryEmailDomain").val($("#inquiryEmailSel").val());
		}
	});
	
	//파일 삭제
	$(document).on('click','#delQnAFile',function(){
		$("#delAttach").val("Y");
		$('#textQnAFile').val("");
		$('#qnaFile').val('');
	});
});
</script>
<div class="popwrap w_type_4" id="productQnADiv" style="display:none;">

	<div class="pop_tltwrap2 pb0">
		<h3>Q&A</h3>
	</div>
	<div class="pop_cnt evaluation_list">
		<a href="#;" class="btn_evaluation" id="productQnAWrite">상품문의하기</a>					
		<div class="clearfix">
			<table class="pop_tbl_ltype1">
				<caption>Q&A</caption>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">Q&A</th>
						<th scope="col">작성자</th>
						<th scope="col">작성일</th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
		</div>
		<!-- paging -->
		<div class="paging mt30" id="qnAPagingDiv"></div>
		<!-- //paging -->
	</div>
	<a href="javascript:void(0);"class="btn_close"><img src="http://cdn.thehandsome.com/_ui/desktop/common/images/popup/ico_close.png" alt="닫기" /></a>
</div>


<div class="popwrap w_type_3" id="productQnAWriteDiv" style="display:none;">
	<div class="pop_tltwrap2">
		<h3>상품문의하기</h3>
	</div>
	<div class="pop_cnt evaluation_write">
		<form id="productQnAForm" name="productQnAForm" action="/ko/HANDSOME/WOMEN/Top/Shirts/%EC%8B%9C%EC%8A%A4%EB%A3%A8-%ED%8C%A8%EB%84%90-%EC%BA%A1-%EC%8A%AC%EB%A6%AC%EB%B8%8C-%EC%85%94%EC%B8%A0/p/IL2C5WSH942W_DN?categoryCode=we01" method="post" enctype="multipart/form-data"><input type="hidden" id="productCode" name="productCode" />
			<input type="hidden" id="productQnaCode" name="productQnaCode" />
			<input type="hidden" id="delAttach" name="delAttach" value="N" />
			<fieldset>
				<legend>상품문의하기</legend>
				<div class="tblwrap">
					<p class="reqd_txt float_right"><strong class='reqd'>*</strong> 표시는 필수항목입니다.</p>
					<table class="tbl_wtype1">
						<caption>상품문의하기 입력항목</caption>
						<colgroup>
							<col width="140px">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><strong class='reqd'>*</strong><label for='inquiryTitle'>문의제목</label></th>
								<td>
									<input type="text" id="inquiryTitle" name="inquiryTitle" title="input" style="width:100%" />
								</td>
							</tr>
							<tr>
								<th scope="row"><strong class='reqd'>*</strong><label for='inquiryContents'>문의내용</label><span class='com_txt_p'>(300자 이하)</span></th>
								<td>
									<textarea name="inquiryContents" id="inquiryContents" cols="30" rows="5" style="width:98%;height:200px"></textarea>
								</td>
							</tr>
							<tr>
								<th scope="row" class="th_space"><label for="file">파일 첨부하기</label></th>
								<td>
									<!-- File upload -->
									<div class="file_upload">
										<input type="text" id="textQnAFile" class="text" title="파일찾기" readonly="readonly" name="fileText">
										<a href="javascript:void(0);" id="delQnAFile">
											<img src="http://cdn.thehandsome.com/_ui/desktop/common/images/popup/ico_close.png" alt="파일삭제">
										</a>
										<div class="upload_btn">
											<label for="qnaFile"><button type="button" id="uploadFile" class="img_upload" title="파일찾기"><span>파일찾기</span></button></label>
											<input type="file" id="qnaFile" name="uploadFile" class="btn add_s" title="파일찾기" />
										</div>
									</div>
									<!-- //File upload -->
									<p class="txt_guide">10MB 미만의 jpg,gif,png 파일만 첨부하실 수 있습니다.</p>
								</td>
							</tr>
							<tr>
								<th scope="row" class="th_space">
									<label for="inquiryMobileNo2">SMS 알림받기</label>
								</th>
								<td>
									<div style="position:relative;">
										<input type="hidden" id="smsMobileNo" name="smsMobileNo" />
										<select id="inquiryMobileNo1" title="휴대폰 번호 앞자리" style="width:80px; margin-top:0; vertical-align:middle; padding: 3px 8px 3px 8px;">
											<option value="010" selected="selected">010</option>
											<option value="011">011</option>
											<option value="016">016</option>
											<option value="017">017</option>
											<option value="018">018</option>
											<option value="019">019</option>
										</select>
										<div class="form_hyphen">-</div>
										<input type="text" id="inquiryMobileNo2" name="inquiryMobileNo2" title="휴대폰 번호 가운데자리" style="width:80px;" maxlength="4"  />
										<div class="form_hyphen">-</div>
										<input type="text" id="inquiryMobileNo3" name="inquiryMobileNo3" title="휴대폰 번호 뒷자리" style="width:80px;" maxlength="4" />
										<span class="sms_alm_2006_chk" style="display: block; position:absolute; top:3px; right:14px;">
											<input type="hidden" id="smsNoticeYN" name="smsNoticeYN" value="N" />
											<input type="checkbox" id="inquirySmsNoticeYn" name="inquirySmsNoticeYn" style="margin-top:1px;">
											<label for="inquirySmsNoticeYn">SMS 알람고지</label>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="inquiryEmailAddress"><strong class='reqd'>*</strong><label for='inquiryMobileNo2'>이메일 답변받기</label></label>
								</th>
								<td>
									<input type="hidden" id="replyToEmail" name="replyToEmail" />
									<input type="text" id="inquiryEmailAddress" name="inquiryEmailAddress" title="이메일아이디" style="width:120px;" />
									<span class="andmail">@</span>
									<input type="text" id="inquiryEmailDomain" name="inquiryEmailDomain" title="이메일계정 입력란" style="width:120px;" />
									<select id="inquiryEmailSel" title="이메일계정" style="width:140px; padding: 3px 8px 3px 8px;">
										<option value="" selected="selected">직접입력</option>
										<option value="naver.com">naver.com</option>
										<option value="daum.net">daum.net</option>
										<option value="gmail.com">gmail.com</option>
										<option value="yahoo.co.kr">yahoo.co.kr</option>
										<option value="lycos.co.kr">lycos.co.kr</option>
										<option value="nate.com">nate.com</option>
										<option value="empas.com">empas.com</option>
										<option value="hotmail.com">hotmail.com</option>
										<option value="msn.com">msn.com</option>
										<option value="hanmir.com">hanmir.com</option>
										<option value="chol.net">chol.net</option>
										<option value="korea.com">korea.com</option>
										<option value="netsgo.com">netsgo.com</option>
										<option value="dreamwiz.com">dreamwiz.com</option>
										<option value="hanafos.com">hanafos.com</option>
										<option value="freechal.com">freechal.com</option>
										<option value="hitel.net">hitel.net</option>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<p class="guide_txt clearfix" style="border-top:0;">
					<span class="float_left"><strong>상품에 관한 배송, 교환, 취소 등의 자세한 문의사항은 고객센터를 이용해 주시기 바랍니다.</strong></span>
					<span class="float_right">
						<input type="checkbox" name="securitySentenceYn" id="securitySentenceYn" value="Y"/> <label for="securitySentenceYn">비밀글 설정</label>
					</span>
				</p>
				<div class="btnwrap mt40">
					<input type="button" id="qnaCancle" value='취소하기' class="btn wt"/>
					<input type="button" id="qnaWriteSend" value='등록하기' class="btn gray mr0"/>
				</div>
			</fieldset>
		<div>
<input type="hidden" name="CSRFToken" value="ec35065f-63f2-4b5d-8f20-aec5bd737cbc" />
</div></form></div>
	<a href="javascript:void(0);" class="btn_close"><img src="http://cdn.thehandsome.com/_ui/desktop/common/images/popup/ico_close.png" alt="닫기" /></a>
</div>
<!-- layer pop 1 -->
			<div class="popwrap w_type_3" id="storePickupDiv" style="display:none;">
				<!--title-->
				<div class="pop_tltwrap">
					<h3>수령 매장 선택</h3>
				</div>
				<!--//title-->
				<!--contents-->
				<div class="pop_cnt zipcode">
					<!-- search -->
					<div class="search">
						<label for="search">지역명 (도로명)</label>
						<input type="text" id="storePickupSearchWord" name="searchWord" placeholder="매장명 또는 지역 명을 입력 후 검색해 주세요" style="width:260px" />
						<input type="button" value="검색" id="storePickupSearchBtn" class="btn wt_s mr0 min_auto" />
					</div>
					<!-- //search -->
					<!--  del_tab_container -->
					<div class="del_tab_container"> 
						<table class="pop_dtable store">
							<caption>배송지 목록</caption>
							<thead>
								<tr>
									<th scope="col">선택</th>
									<th scope="col">배송지 주소</th>
									<th scope="col">연락처/휴대폰</th>
								</tr>
							</thead>
							<tbody id="popupStorePickupContent">

							</tbody>
						</table>
						<div class="btnwrap">
							<input class="btn wt_s" id="storePickupCloseBtn" value="취소" type="button" />
							<input class="btn gray_s" id="storePickupChoiceBtn" value="확인" type="button" />
						</div>
					</div>
					<!-- //del_tab_container -->
				</div>
				<!--//contents-->
				<a href="#;" class="btn_close" id="storePickupClose"><img src="http://cdn.thehandsome.com/_ui/desktop/common/images/popup/ico_close.png" alt="닫기" /></a>
			</div>
			<!-- layer pop 1 -->
<!-- layer pop 1 -->
<script type="text/javascript">
$(document).ready(function() {
	$("#stockconfirm .btnwrap .btn.wt_s").on("click", function() {
		$("#offlieQtyClose").trigger("click");
	});
	
	$("#stockconfirm .btnwrap .btn.gray_s").on("click", function() {
		$("#offlieQtyClose").trigger("click");
	});
	
	$("#offlieQtyClose").on("click", function() {
		$("#offlineQtyListPop").show();
		$("#offlineQtyInfoPop").hide();
		$(".more_stockbox").hide();
		if($(".w_type_2_1").hasClass('stockList')) {
			$(".w_type_2_1").removeClass("stockList");
		}
		
		$("#soldOutYn").prop("checked", false);
	});
	
	$("#soldOutYn").change(function() {
		getOfflineQty();
		$("#offlineQtyList").scrollTop(0);
	});
});

function hideOfflineQtyInformation() {
	$(".w_type_2_1").addClass("stockList");
	$("#offlineQtyInfoPop").hide();
	$("#offlineQtyListPop").show();
	
	$("#offlineQtyList").scrollTop(0);
}

function getOfflineQty() {
	var pCode, tmpCode = "IL2C5WSH942W_DN";
	var infoTxt;
	
	if(tmpCode.indexOf("_") > -1) {
		pCode = tmpCode.split("_")[0];
	} else {
		pCode = tmpCode;
	}
	
	var colorCd = $(".color_size_qty.czq_pop .color_chip li a.on").attr("data-color-code");
	var colorNm = $(".color_size_qty.czq_pop .color_chip li a.on").attr("data-color-name");
	var sizeCd = $(".color_size_qty.czq_pop .size_chip li a.on").attr("data-size-code");
	var erpSizeCd = $(".color_size_qty.czq_pop .size_chip li a.on").attr("data-erp-size");
	var krSizeCd = $(".color_size_qty.czq_pop .size_chip li a.on").attr("data-kr-size");
	var size = sizeCd;
	var soldOut = $("#soldOutYn").is(":checked") ? "Y" : "N";
	
	if(krSizeCd != null && krSizeCd != "") {
		size += krSizeCd;
	}
	
	infoTxt = "선택하신 옵션(<em>" + colorNm + "/" + size + "</em>)의 오프라인 매장 재고 정보입니다.<span>※ 매장 재고 현황은 대략적이며, 자세한 정보는 매장에 문의해주세요.</span>";
	$(".stock_pop_txt").html(infoTxt);
	
	$.ajax({
		url      : '/ko/p/offlineShopQty',
		type     : 'GET',
		datatype : 'json',
		data     : { "productCode" : pCode, "styleCode" : colorCd, "sizeCode" : erpSizeCd, "soldOut" : soldOut },
		success  : function(data) {
			var list;
			if(data.length > 0) {
				for(var i=0; i < data.length; i++) {
					if(i % 2 == 0) {
						list += "<tr>";
					} else {
						list += "<tr class='colbg'>";
					}
					list += "	<td>";
					list += "		<span>" + data[i].branchName;
					list += "			<em class='redtxt_count'>" + data[i].offlineShopQty + "개</em>";
					list += "		</span>";
					list += "		<p>" + data[i].branchAddress + "</p>";
					list += "	</td>";
					list += "	<td>" + data[i].branchTelephone + "</td>";
					list += "</tr>";
				}
			} else {
				list = "<td colspan='2' style='width:470px !important;height:280px;padding-left:25px;text-align:center;'>선택하신 옵션("+colorNm+"/"+size+")의 매장 재고를 찾을 수 없습니다.</td>";
			}
			$("#offlineQtyList").html(list);
		},
		error    : function(xhr, Status, error) {
			var la = new layerAlert("[Error] " + error);
			return;
		}
	});
	
	$(".more_stockbox").show();
}
<%@ include file="/WEB-INF/views/common/footer.jsp"%>