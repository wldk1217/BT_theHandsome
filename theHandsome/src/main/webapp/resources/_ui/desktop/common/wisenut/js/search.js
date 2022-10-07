/***************************************************************************
 * Section 1: 전역변수 모음
 ***************************************************************************/
var paramCate = ""; // 전체, 카테고리
var paramBrand = ""; // 브랜드
var paramPrice = ""; // 가격
var paramColor = ""; // 색상
var paramSize = ""; // 사이즈
var paramMixed = ""; // 혼용률
var paramLang = "product_ko"; // 언어선택
var paramSort = ""; // 정렬
var paramReQuery ="" // 재정렬
var paramReSearch ="0" // 재검색 탭 구분자(0: 결과내 재검색, 1: 검색어 제외)
var param1Depth = "";  // 1depth 텍스트
var paramPage = "0";

/***************************************************************************
 * Section 2: Util 함수 모음
 ***************************************************************************/
//String util 함수 추가(김형준)
//속도향상을 위해 자바와 유사한 StringBuilder 객체 추가
var StringBuilder = function(){ 
    this.buffer = new Array();  
} 

// 순서대로 문자열을 추가한다.
StringBuilder.prototype.Append = function( strValue ) { 
    this.buffer[this.buffer.length] = strValue;
} 

// 문자열의 형식을 지정해서 추가한다. 
StringBuilder.prototype.AppendFormat = function() { 
    var count = arguments.length;
    if( count < 2 ) return ""; 
    var strValue = arguments[0];
    for(var i=1; i<count; i++) 
        strValue = strValue.replace("{"+ (i-1) + "}", arguments[i] );
    this.buffer[this.buffer.length] = strValue;
} 

// 해당하는 위치에 문자열을 추가한다. (문자위치가 아님);
StringBuilder.prototype.Insert = function( idx, strValue ) { 
    this.buffer.splice( idx, 0, strValue );
}

// 해당문자열을 새로운 문자열로 바꾼다. 
// (배열방 단위로 바꾸므로 배열방 사이에 낀 문자열은 바꾸지 않음)
StringBuilder.prototype.Replace = function( from, to , one) { 
    for( var i=this.buffer.length-1; i>=0; i--)
        this.buffer[i] = this.buffer[i].replace(new RegExp(from, "g"), to);
}

// 문자열로 반환한다.
StringBuilder.prototype.ToString = function() { 
        return this.buffer.join("");
} 

// 이니시스 결제창과 충돌
//trim 함수
//String.prototype.trim = function () {
//    return this.replace(/(\s*)/g, "");
//};

// 괄호 제거 함수
String.prototype.truncateBracket = function () {
    return this.replace(/(\(*)/g, "").replace(/(\)*)/g , "");
};

//괄호 제거 + ! 제거 함수
String.prototype.truncateBracketAndExcla  = function () {   
    return this.replace(/(\(*)/g, "").replace(/(\)*)/g , "").replace(/(\!*)/g , "");
};

//브랜드 체크박스
var sb_brand = new StringBuilder();
var count_brand = 0;

// 가격 체크박스
var sb_price= new StringBuilder();
var count_price = 0;

// 혼용률 체크박스
var sb_mixed = new StringBuilder();
var count_mixed = 0;

// 천단위 콤마 찍기
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

//기간 설정
function setDate(range) {

    var startDate = "";
    var endDate = "";
    
    var currentDate = new Date();
    var year = currentDate.getFullYear();
    var month = currentDate.getMonth() +1;
    var day = currentDate.getDate();

    if (parseInt(month) < 10) {
        month = "0" + month;
    }

    if (parseInt(day) < 10) {
        day = "0" + day;
    }

    var toDate = year + "." + month + "." + day;

    // 기간 버튼 이미지 초기화
    for (i = 1;i < 5 ;i++) {
        $("#range"+i).attr ("src", "resources/images/btn_term" + i + ".gif");
    }
    
    // 기간 버튼 이미지 선택
    if (range == "D") {
        startDate = getAddDay(currentDate, -0);
        $("#range2").attr ("src", "resources/images/btn_term22.gif");
    } else if (range == "W") {
        startDate = getAddDay(currentDate, -6);
        $("#range3").attr ("src", "resources/images/btn_term32.gif");
    } else if (range == "M") {
        startDate = getAddDay(currentDate, -29);
        $("#range4").attr ("src", "resources/images/btn_term42.gif");
    } else {
        startDate = "1970.01.01";
        endDate = toDate;
        $("#range1").attr ("src", "resources/images/btn_term12.gif");
    }
    
    if (range != "A" && startDate != "") { 
        year = startDate.getFullYear();
        month = startDate.getMonth()+1; 
        day = startDate.getDate();

        if (parseInt(month) < 10) {
            month = "0" + month;
        }

        if (parseInt(day) < 10) {
            day = "0" + day;
        }

        startDate = year + "." + month + "." + day;             
        endDate = toDate;
    }
    
    $("#range").val(range);
    $("#startDate").val(startDate);
    $("#endDate").val(endDate);
}

var currecy = ""; // USD, CNY
var rate = $("#rate").val(); // 환율
var simbol = $("#simbol").val(); // 심볼

function exchangeRatePrice(koPrice){
    var productPrice = koPrice == null || koPrice == 0 ? 0 : koPrice;
    var sumPrice = parseFloat(productPrice);
    var exchangeAmt = sumPrice;
    rate = $("#rate").val();

    var targetUrl = $(".search_box_wrap #search").attr("action");
    if(targetUrl.indexOf("en") > -1 || targetUrl.indexOf("zh") > -1){
        exchangeAmt = Math.round(parseFloat(sumPrice) / parseFloat(rate) * 100) / 100 ;
    }
    return exchangeAmt;
}

// 일주일전 날짜 가져오기
var prevWeek = function getPrevWeek() {
    
    var date = new Date();
    date.setDate(date.getDate()-7);
    
    var year = date.getFullYear();
    var month = (1 + date.getMonth());
    month = month >= 10 ? month : '0' + month;
    var day = date.getDate();
    day = day >= 10 ? day : '0' + day;
    
    var rtnStr = year + '.' + month + '.' + day;
    
    return rtnStr;  
}

// 현재 일자
var realTime = function getRealTime() {
    
    var today = new Date();
    var year = today.getFullYear();
    var month = today.getMonth(); 
    var dt = today.getDate(); 
    var dw = today.getDay(); //요일
    var h = today.getHours();
    var m = today.getMinutes();
    var s = today.getSeconds();

    month = month +1;
    
    
    //요일처리 
    var dayweek = new Array(7);
    var monthArray = new Array(7);
    var targetUrl = $(".search_box_wrap #search").attr("action");
    var returnString = "";

    if(targetUrl.indexOf("en") > -1){ //en
        dayweek[0] = "(SUN)"
        dayweek[1] = "(MON)"
        dayweek[2] = "(TUE)"
        dayweek[3] = "(WED)"
        dayweek[4] = "(THU)"
        dayweek[5] = "(FRI)"
        dayweek[6] = "(SAT)"  
        d = dayweek[dw];
        
        monthArray[1] = "January";
        monthArray[2] = "February";
        monthArray[3] = "March";
        monthArray[4] = "April";
        monthArray[5] = "May";
        monthArray[6] = "June";
        monthArray[7] = "July";
        monthArray[8] = "August";
        monthArray[9] = "September";
        monthArray[10] = "October ";
        monthArray[11] = "November";
        monthArray[12] = "December";
        
        returnString = "As of "+monthArray[month]+" "+ dt + d +", "+ year;
    }else if(targetUrl.indexOf("zh") > -1){ //zh
        dayweek[0] = "(日)"
        dayweek[1] = "(月)"
        dayweek[2] = "(火)"
        dayweek[3] = "(水)"
        dayweek[4] = "(木)"
        dayweek[5] = "(金)"
        dayweek[6] = "(土)"   
        d = dayweek[dw];
        returnString = year + '年 ' + month +'月 ' + dt + '日 '+d +" 为基准";
    }else{ //ko
        dayweek[0] = "(일)"
        dayweek[1] = "(월)"
        dayweek[2] = "(화)"
        dayweek[3] = "(수)"
        dayweek[4] = "(목)"
        dayweek[5] = "(금)"
        dayweek[6] = "(토)"   
        d = dayweek[dw];
        returnString = year + '년 ' + month +'월 ' + dt + '일 '+d +" 기준";
    }
    
    
    // 출력
    return returnString;      
}

// 날짜 계산
function getAddDay ( targetDate, dayPrefix ) {
    
    var newDate = new Date( );
    var processTime = targetDate.getTime ( ) + ( parseInt ( dayPrefix ) * 24 * 60 * 60 * 1000 );
    newDate.setTime ( processTime );
    return newDate;
}

//Replace All
function replaceAll(str, orgStr, repStr) {
    return str.split(orgStr).join(repStr);
}

//문자열 숫자 비교
function compareStringNum(str1, str2, repStr) {
    
    var num1 =  parseInt(replaceAll(str1, repStr, ""));
    var num2 = parseInt(replaceAll(str2, repStr, ""));

    if (num1 > num2) {
        return false;
    } else {
        return true;
    }
}

//쿠키값 추출
function getCookie(c_name) {
    
    var i;
    var x;
    var y;
    
    var cookies = document.cookie.split(";");   
    
    for (i=0;i<cookies.length;i++) {
        x = cookies[i].substr(0,cookies[i].indexOf("="));
        y = cookies[i].substr(cookies[i].indexOf("=")+1);
        x = x.replace(/^\s+|\s+$/g,"");
        if (x==c_name) {
            return unescape(y);
        }
    }
}

// 쿠키 설정
function setCookie(c_name,value,exdays) {

    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var c_value = escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
    document.cookie = c_name + "=" + c_value;
}



/***************************************************************************
 * Section 3: 왼쪽 메뉴 그룹핑 영역 User's Action Handler
 ***************************************************************************/   

var targetLang = "ko";
var priceUnder = "10만원 이하";
var priceBetween1 = "10만원~30만원";
var priceBetween2 = "30만원~50만원";
var priceBetween3 = "50만원~100만원";
var priceOver = "100만원 이상";
$(document).ready(function() {
    
    var targetUrl = $(".search_box_wrap #search").attr("action");
    targetLang = "ko";
    priceUnder = "10만원 이하";
    priceBetween1 = "10만원~30만원";
    priceBetween2 = "30만원~50만원";
    priceBetween3 = "50만원~100만원";
    priceOver = "100만원 이상";

    if(targetUrl.indexOf("en") > -1){
        targetLang = "en";
        priceUnder = "Under $100";
        priceBetween1 = "$100 ~ $300";
        priceBetween2 = "$300 ~ $500";
        priceBetween3 = "$500 ~ $1,000";
        priceOver = "Over $1,000";
    }else if(targetUrl.indexOf("zh") > -1){
        targetLang = "zh";
        priceUnder = "¥ 500以下";
        priceBetween1 = "¥ 500 ~ ¥ 1,500";
        priceBetween2 = "¥ 1,500 ~ ¥ 2,500";
        priceBetween3 = "¥ 2,500 ~ ¥ 5,000";
        priceOver = "¥ 5,000以上";
    }


    // 결과내검색어, 검색어제외 구분
    $('#reSearch > li').find("a").on("click", function() {
        
        var title = String($(this).attr("title"));
        
        if(title == "add"){ 
            paramReSearch = "0";
        } else if(title == "remove"){
            paramReSearch = "1";
        } else {
            
        }
    });

    // 정렬
    $('.sortSearch > li').find("a").on("click", function() {

        // 전체 밑줄 삭제
        $('.sortSearch > li > a').removeClass();
        
        var title = String($(this).attr("title"));
        
        // 선택된 영역 밑줄 긋기
        if(title == "newest"){
            paramSort = "DATE/DESC";
            $(this).addClass("on");
        } else if(title == "lowPrice"){
            paramSort = "SALEPRICE/ASC";
            $(this).addClass("on");
        } else if(title == "highPrice"){
            paramSort = "SALEPRICE/DESC";
            $(this).addClass("on");
        } else if(title == "sell"){
            paramSort = "SELLCNT/DESC";
            $(this).addClass("on");
        } else if(title == "sail"){
            paramSort = "SALERATE/DESC,SALEPRICE/ASC";
            $(this).addClass("on");
        } else if(title == "accuracy"){
            paramSort = "RANK/DESC,SELLCNT/DESC";
            $(this).addClass("on");
        } else {
            paramSort = "DATE/DESC";
            $('.sortSearch > li > a').removeClass();
        }
        
        paramReQuery = "";
        doAsyncSearch();
    });
    
});

//전체
$(document).on("click","#filter_all_search > li > a",function(){  
    var anchorStr = String($(this).text());
    var spanStr = String($(this).children("span").text());
    var paramStr = anchorStr.replace(spanStr, "");
    $(".cate_one").parent().detach();
    
    param1Depth = paramStr;
    paramCate = "";
    
    doAsyncSearch();
    doMenuGroupDraw();
});

//카테고리 2depth
$(document).on("click",".search_depth2 > a",function(){     

    var anchorStr = String($(this).text());
    var spanStr = String($(this).children("span").text());
    var paramStr = anchorStr.replace(spanStr, "");

    $(".cate_one").parent().detach();
    $('#selectedSearchCondition').after("<li class=\"selectedSearch\"><span class=\"cate_one\">"+paramStr+"</span><a href=\"javascript:void(0);\" class=\"btn_close\">해제</a></li>");
    
    $(".filter_words").show();
    
    paramCate = paramStr;
    doAsyncSearch();
    doMenuGroupDrawSub();
});

//카테고리 3depth
$(document).on("click",".autoscroll > .list > li > a",function(){   
    
    var paramStr = String($(this).children("span:eq(0)").text());
    
    $(".cate_one").parent().detach();
    $('#selectedSearchCondition').after("<li class=\"selectedSearch\"><span class=\"cate_one\">"+paramStr+"</span><a href=\"javascript:void(0);\" class=\"btn_close\">해제</a></li>");
    
    $(".filter_words").show();
    
    paramCate = paramStr;
    doAsyncSearch();
    doMenuGroupDrawSub();
});


//브랜드       
$(document).on("change",'input:checkbox[name="brand_ck"]',function(){

    //"TIME,MINE,SYSTEM;"
    if($(this).prop('checked')) {

        // 선택한 조건에 추가
       $('#selectedSearchCondition').after("<li class=\"selectedSearch\"><span class=\"reset01\">"+$(this).val()+"</span><a href=\"javascript:void(0);\" class=\"btn_close\">해제</a></li>");

       $(".filter_words").show();
    
        // 전역변수 파라미터 추가
        if(count_brand == 0){
            
            sb_brand.Append($(this).val());
        } else {
            sb_brand.Append(","+$(this).val());
        }
        count_brand++;
        
        paramBrand = sb_brand.ToString();
        
    } else {
        
        count_brand--;
        
        var str = $(this).val();
        
        // 선택한 조건 삭제
        $('.selectedSearch > span').each(function(i,v){
            if(str == $(this).text()){
                $(this).parent().detach();
            }
        });

        // 전역변수 파라미터 삭제
        if(count_brand == 0){    
            sb_brand = new StringBuilder();
        } else {
        	var tempSbBrand = sb_brand.ToString().split(",");
        	sb_brand = new StringBuilder();
        	for(var i=0;i < tempSbBrand.length;i++){
        		if(tempSbBrand[i] != $(this).val()){
        			if(sb_brand.ToString() == ""){
            			sb_brand.Append(tempSbBrand[i]);
            		} else {
            			sb_brand.Append(","+tempSbBrand[i]);
            		}
        		} 
        	}
        }
        
        // 같은 문자 없는 경우 (같은 문자 모두 제거되는 방지 장치)
        if (sb_brand.ToString().indexOf($(this).val()) == -1) {
            sb_brand.Replace($(this).val(), "");
        }

        paramBrand = sb_brand.ToString();

        if (sb_brand.ToString().indexOf($(this).val()) == -1) {

            if(sb_brand.ToString().substring(0,1) == ","){              
                paramBrand = sb_brand.ToString().substring(1, sb_brand.ToString().length);              
            }
        }           
    }
    
//    document.getElementById('async').scrollIntoView();
    
    doAsyncSearch();
});

//가격
$(document).on("change",'input:checkbox[name="price_ck"]',function(){
    var paramStr = "";
    
    if($(this).val() =="A"){
        paramStr = "10만원 이하";
    } else if($(this).val() =="B"){
        paramStr = "10만원~30만원";
    } else if($(this).val() =="C"){
        paramStr = "30만원~50만원";
    } else if($(this).val() =="D"){
        paramStr = "50만원~100만원";
    } else if($(this).val() =="E"){
        paramStr = "100만원 이상";
    }
    
    if(targetLang == "en") {
    	if($(this).val() =="A"){
            paramStr = "Under $100";
        } else if($(this).val() =="B"){
            paramStr = "$100 ~ $300";
        } else if($(this).val() =="C"){
            paramStr = "$300 ~ $500";
        } else if($(this).val() =="D"){
            paramStr = "$500 ~ $1,000";
        } else if($(this).val() =="E"){
            paramStr = "Over $1,000";
        }
    } else if(targetLang == "zh") {
    	if($(this).val() =="A"){
            paramStr = "¥ 500以下";
        } else if($(this).val() =="B"){
            paramStr = "¥ 500 ~ ¥ 1,500";
        } else if($(this).val() =="C"){
            paramStr = "¥ 1,500 ~ ¥ 2,500";
        } else if($(this).val() =="D"){
            paramStr = "¥ 2,500 ~ ¥ 5,000";
        } else if($(this).val() =="E"){
            paramStr = "¥ 5,000以上";
        }
    }
    
    if($(this).prop('checked')) {
        
        // 선택한 조건에 추가
        $('#selectedSearchCondition').after("<li class=\"selectedSearch\"><span class=\"reset02\">"+paramStr+"</span><a href=\"javascript:void(0);\" class=\"btn_close\">해제</a></li>");

    
        $(".filter_words").show();
        
        // 전역변수 파라미터 추가
        if(count_price == 0){
            sb_price.Append($(this).val());
//            paramPrice += $(this).val();
        } else {
            sb_price.Append(","+$(this).val());
//            paramPrice += ","+ $(this).val();
        }
        count_price++;
        paramPrice = sb_price.ToString();
        
    } else {

        count_price--;
        
        // 선택한 조건 삭제
        $('.selectedSearch > span').each(function(i,v){
            if(paramStr == $(this).text()){
                $(this).parent().detach();
            }
        });
        
        // 전역변수 파라미터 삭제
        sb_price.Replace(","+$(this).val(),"");
        sb_price.Replace($(this).val(), "");
        
        paramPrice = sb_price.ToString();
        
        if(sb_price.ToString().substring(0,1) == ","){              
            paramPrice = sb_price.ToString().substring(1, sb_price.ToString().length);              
        }
    }
    
//    document.getElementById('asyncSearchItem').scrollIntoView();
    
    doAsyncSearch();
});     


// 색상
$(document).on("click","#filter_color_search > li > a",function(){      
    var paramStr = String($(this).text());
    var tempColor = true;
    
    
    // 같은 조건은 한번만 들어가야 한다.
    $('.selectedSearch > span').each(function(i,v){
        if(paramStr == $(v).text()){
            $(v).parent().detach();
            
            tempColor = false;
            return false;
        }

    });
        
    // 선택한 조건에 추가
    $('#selectedSearchCondition').after("<li class=\"selectedSearch\"><span class=\"c_bg\" style=\"background:"+paramStr+";display:block;width:17px;height:17px;border:1px solid #e3e3e3;text-indent:-999em;margin-top:4px\">"+paramStr+"</span><a href=\"javascript:void(0);\" class=\"btn_close\">해제</a></li>");
   
    $(".filter_words").show();
    
    if(paramColor == ""){
        paramColor = paramStr;
    }else if(tempColor){
        paramColor += "," + paramStr;
    }
   
    doAsyncSearch();
});

//사이즈
$(document).on("click","#filter_size_search > li > a",function(){   
    
    var paramStr = String($(this).text());
    var tempSize = true;
    
    // 같은 조건은 한번만 들어가야 한다.
    $('.selectedSearch > span').each(function(i,v){
        if(paramStr == $(v).text()){
            $(v).parent().detach();
            
            tempSize = false;
            return false;
        }

    });
        
    // 선택한 조건에 추가
    $('#selectedSearchCondition').after("<li class=\"selectedSearch\"><span>"+paramStr+"</span><a href=\"javascript:void(0);\" class=\"btn_close\">해제</a></li>");
    
    $(".filter_words").show();
    
    if(paramSize == ""){
        paramSize = paramStr;
    }else if(tempSize){
        paramSize += "," + paramStr;
    }
    doAsyncSearch();
});

//혼용률
$(document).on("change","input:checkbox[name='mixed_ck']",function(){       

    if($(this).prop('checked')) {
        
        // 선택한 조건에 추가
        $('#selectedSearchCondition').after("<li class=\"selectedSearch\"><span class=\"reset05\">"+$(this).val()+"</span><a href=\"javascript:void(0);\" class=\"btn_close\">해제</a></li>");
		
		$(".filter_words").show();
    
        // 전역변수 파라미터 추가
        if(count_mixed == 0){
            sb_mixed.Append($(this).val());
        } else {
            sb_mixed.Append(","+$(this).val());
        }

        count_mixed++;
        
        paramMixed = sb_mixed.ToString();
        
    } else {
        
        count_mixed--;
        
        var str = $(this).val();
        
        // 선택한 조건 삭제
        $('.selectedSearch > span').each(function(i,v){
            if(str == $(this).text()){
                $(this).parent().detach();
            }
        });   
        
        // 전역변수 파라미터 삭제
        sb_mixed.Replace(","+$(this).val(),"");
        sb_mixed.Replace($(this).val(), "");
        
        paramMixed = sb_mixed.ToString();
        
        if(sb_mixed.ToString().substring(0,1) == ","){              
            paramMixed = sb_mixed.ToString().substring(1, sb_mixed.ToString().length);              
        }           
    }
    
//    document.getElementById('asyncSearchItem').scrollIntoView();
    
    doAsyncSearch();
});

// 색깔구분 : 동적으로 태그 추가된 경우 해당 요소를 선택하기 위함
$(document).on("click","#asyncSearchItem .item_box > .color_more_wrap > a, #othersSlider .item_box > .color_more_wrap > a, #search_topSeller .item_box > .color_more_wrap > a",function(){
    $(this).parent().parent().find(".item_info1 > .item_img > .respon_image").siblings().css("display","none");
    $(this).parent().parent().find(".item_info1 > .item_img > .respon_image").filter(":eq("+$(this).index()+")").css("display","block");     
    
    
    var url = $(this).parent().parent().find("> a ").attr("href");
    var urlTemp = url.split('p/');
    var code = "";
    if(urlTemp.length > 1){
    	code = urlTemp[1].split('?')[0].split('\',')[0];
    }
    
    if(code != ""){
        var codeTemp = $(this).parent().parent().find("> a > .item_img > img").filter(":eq("+$(this).index()+")").attr("src").split("/"); 
        var colorCode_temp = codeTemp[codeTemp.length - 1];

        var temp = colorCode_temp.split("_");
        var colorCode = temp[0]+"_"+temp[1];
        
        $(this).parent().parent().find("> a ").attr("href", url.replace(code, colorCode));
        //2019.04.16색상 클릭시 사이즈 표기
        $(this).parent().parent().find(".item_size > div").css("display","none");
        var tempId = $(this).parent().parent().find(".item_size > div").filter(":eq("+$(this).index()+")").attr("id");
        if(tempId == colorCode){
            $("#"+colorCode).css("display","block");
        }
        
        
        var clickThis = $(this);
        var chkAsync = false;
        if(clickThis.parent().parent().parent().parent().attr("id") == "asyncSearchItem") {
            chkAsync = true;
        }
        
        if($("#price_"+colorCode).length == 0){
            $.ajax({
                url: "/"+targetLang+"/c/getProductPrice",
                type: "GET",
                data: {productCode: colorCode},
                success: function(data){
                    var priceHtml = "";
                    simbol = $("#simbol").val();
                    
                    if(data.productPrice == undefined){
                        return;
                    }
                    
                    clickThis.parent().parent().find(".item_info2 .price [id^=price_]").css("display","none");
                    
                    $(".price_"+temp[0]).each(function(){
                        if(targetLang == 'ko'){
                            priceHtml = "";
                            priceHtml += "<span id=\"price_"+colorCode+"\" style=\"display:none;\">";
                            priceHtml += "<span>￦"+ numberWithCommas(data.productPrice)+"</span>";
                            
                            if(data.productNormalityPrice != undefined && data.productNormalityPrice != ""){
                                	var productSalePerCent = getDecimalToString(((data.productNormalityPrice - data.productPrice) / data.productNormalityPrice * 100), 1, 1);
                                	
                                    priceHtml += "<del class=\"del_price_201029\">￦" + numberWithCommas(data.productNormalityPrice)+"</del>";
                                    priceHtml += "<span class=\"discount_rate_201029\">" + productSalePerCent + "%</span>";
                               
                            }else {
                                
                            }
                            
                            priceHtml += "</span>";
                            
                        }else {
                            priceHtml = "";
                            priceHtml += "<span id=\"price_"+colorCode+"\" style=\"display:none;\">";
                            priceHtml += "<span>"+ simbol + numberWithCommas(exchangeRatePrice(data.productPrice))+"</span>";
                            
                            if(data.productNormalityPrice != undefined && data.productNormalityPrice != ""){
                            	var productSalePerCent = getDecimalToString(((data.productNormalityPrice - data.productPrice) / data.productNormalityPrice * 100), 1, 1);
                            	
                                priceHtml += "<del class=\"del_price_201029\">"+ simbol + numberWithCommas(exchangeRatePrice(data.productNormalityPrice))+"</del>";
                                priceHtml += "<span class=\"discount_rate_201029\">" + productSalePerCent + "%</span>";
                            }else {
                            }
                            
                            priceHtml += "</span>";
                        }
                        
                        $(this).find('[id^=price_]').last().after(priceHtml);
                        
                    });
                    
                    clickThis.parent().parent().find(".item_info2 .price #price_"+colorCode).css("display","block");
                    
                },
                error: function(xhr, Status, error) {}
           });
        }else{
             clickThis.parent().parent().find(".item_info2 .price [id^=price_]").css("display","none");
             clickThis.parent().parent().find(".item_info2 .price").find("#price_"+colorCode).css("display", "inline-block");
             
        }
        
        
    }
    
    
});

// 사이즈 정보 활성화
$(document).on("mouseenter",".items_list .item_box .item_info1",function(){
    $(".items_list .item_info1 .item_size").hide();
    $(this).find('.item_size').stop().slideDown('fast');
    $(this).find('.item_img .on').stop().fadeIn('fast');
});

//사이즈 정보 비활성화
$(document).on("mouseleave",".items_list .item_box .item_info1",function(){
    $(".items_list .item_info1 .item_size").hide();
    $(this).find('.item_size').stop().slideUp('fast');
    $(this).find('.item_img .on').stop().fadeOut('fast');
});

// 스타일 서치 파라미터 수집
$(document).on("click",".keyword_link",function(){  
    var paramStr = String($(this).text());
    var trimStr = paramStr.replace(/#/gi,"");
    doDynamicSearch(trimStr);
});

//연관 검색어 밑 스타일 서치 검색 기능
/*$(document).on("click","#search_style_menu > li > a", function() {
    var paramStr = $(this).text();
    doDynamicSearchStyle(paramStr);
});*/

//선택한 조건 : 동적으로 태그 추가된 경우 해당 요소를 선택하기 위함
$(document).on("click",".selectedSearch > a",function(){  
    
    // 1) .selectedSearch에서 선택된 span 요소의 text를 가져옴
    var selectedStr = $(this).siblings().text();

    // [브랜드] 2) brand_ck checkbox의 배열요소 value값 추출
    $('input:checkbox[name="brand_ck"]').each(function(i,v){
        
        // 3) price_ck 요소를 for문 돌려서 selectedStr 값이 같은걸 추출
        if(selectedStr == v.value){         
            if($("input:checkbox[name='brand_ck'][value='"+v.value+"']").is(":checked") == true){
                
                // 4) checkbox를 해제
                $("input:checkbox[name='brand_ck'][value='"+v.value+"']").prop("checked",false);
                
                // 5) 전역변수의 paramPrice의 값도 clear
                count_brand--;
                
                if(count_brand == 0){    
                    sb_brand = new StringBuilder();
                } else {                
                    sb_brand.Replace(","+$(this).val(),"");
                }

                // 같은 문자 없는 경우 (같은 문자 모두 제거되는 방지 장치)
                if (sb_brand.ToString().indexOf($(this).val()) == -1) {
                    sb_brand.Replace($(this).val(), "");
                }

                paramBrand = sb_brand.ToString();

                if (sb_brand.ToString().indexOf($(this).val()) == -1) {

                    if(sb_brand.ToString().substring(0,1) == ","){              
                        paramBrand = sb_brand.ToString().substring(1, sb_brand.ToString().length);              
                    }
                }
            }                   
        }
    });

    // [가격] 2) price_ck checkbox의 배열요소 value값 추출
    $('input:checkbox[name="price_ck"]').each(function(i,v){
        
        // 3) price_ck 요소를 for문 돌려서 selectedStr 값이 같은걸 추출
        var paramStr = "";
        
        if(selectedStr =="10만원 이하"){
            paramStr = "A";         
        } else if(selectedStr =="10만원~30만원"){
            paramStr = "B";         
        } else if(selectedStr =="30만원~50만원"){
            paramStr = "C";         
        } else if(selectedStr =="50만원~100만원"){
            paramStr = "D";         
        } else if(selectedStr =="100만원 이상"){
            paramStr = "E";         
        } 
        
        if(paramStr == v.value){    

            if($("input:checkbox[name='price_ck'][value='"+paramStr+"']").is(":checked") == true){
                
                // 4) checkbox를 해제
                $("input:checkbox[name='price_ck'][value='"+paramStr+"']").prop("checked",false);
                
                // 5) 전역변수의 paramPrice의 값도 clear
                count_price--;
                sb_price.Replace(","+paramStr,"");
                sb_price.Replace(paramStr+",", "");
                sb_price.Replace(paramStr, "");
                paramPrice = sb_price.ToString();
            }                   
        }
        
    });
    
    // [혼용율] 2) mixed_ck checkbox의 배열요소 value값 추출
    $('input:checkbox[name="mixed_ck"]').each(function(i,v){
        // 3) price_ck 요소를 for문 돌려서 selectedStr 값이 같은걸 추출
        if(selectedStr == v.value){         
            if($("input:checkbox[name='mixed_ck'][value='"+v.value+"']").is(":checked") == true){
                
                // 4) checkbox를 해제
                $("input:checkbox[name='mixed_ck'][value='"+v.value+"']").prop("checked",false);
                
                // 5) 전역변수의 paramMixed의 값도 clear
                count_mixed--;
                
                sb_mixed.Replace(","+$(this).val(),"");
                sb_mixed.Replace($(this).val()+",", "");
                sb_mixed.Replace($(this).val(), "");
                paramMixed = sb_mixed.ToString();               
            }                   
        }
    });

    // 전체, 카테고리
    if(selectedStr == paramCate){
        paramCate = "";
    }
    
    // 색상
    var colorlen = paramColor.length;
    if(colorlen > 0) {
        if(paramColor.indexOf(selectedStr) > 0) {
            paramColor = paramColor.replace(","+selectedStr, "");
        }else if(colorlen > 7){
            paramColor = paramColor.replace(selectedStr+",", "");
        }else {
            paramColor = "";
        }
    }
    
    
    // 사이즈
    var sizelen = paramSize.length;
    if(sizelen > 0) {
        if(paramSize.indexOf(selectedStr) > 0) {
            paramSize = paramSize.replace(","+selectedStr, "");
        }else if(sizelen > 2){
            paramSize = paramSize.replace(selectedStr+",", "");
        }else {
            paramSize = "";
        }
    }
    
    
    
    $(this).parent().detach();
    
    doAsyncSearch();

});

//그룹 전체 초기화
function groupAllReset(){

    paramCate = ""; // 카테고리
    paramBrand =""; // 브랜드
    paramPrice = ""; // 가격
    paramColor =""; // 색상
    paramSize =""; // 사이즈
    paramMixed =""; // 혼용률
    paramSort =""; // 정렬
    paramReQuery ="" // 재정렬
//    param1Depth ="" // 1depth

    // [브랜드] brand_ck checkbox 전체 해제
    $('input:checkbox[name="brand_ck"]').prop("checked",false);

    // [사이즈] price_ck checkbox 전체 해제
    $('input:checkbox[name="price_ck"]').prop("checked",false);

    // [혼용율] mixed_ck checkbox 전체 해제
    $('input:checkbox[name="mixed_ck"]').prop("checked",false);
    
    // 선택한 조건 전체 해제
    $('.selectedSearch').detach();
    
    
    count_brand = 0;
    count_price = 0;
    count_mixed = 0;
    sb_brand= new StringBuilder();
    sb_price= new StringBuilder();
    sb_mixed= new StringBuilder();
    
    doAsyncSearch();    
}

// 그룹별 초기화
function groupReset(param){
    
    switch (param) {
        
        // 브랜드 초기화
        case '01' : paramBrand ="";
                    count_brand = 0;
                    sb_brand= new StringBuilder();
                    $('input:checkbox[name="brand_ck"]').prop("checked",false);
                    $('.selectedSearch > span').filter(".reset01").parent().detach();                   
        break;
          
        // 가격 초기화
        case '02' : paramPrice = "";
                    count_price = 0;
                    sb_price= new StringBuilder();
                    $('input:checkbox[name="price_ck"]').prop("checked",false);
                    $('.selectedSearch > span').filter(".reset02").parent().detach();   
        break;
          
        // 색상 초기화
        case '03' : paramColor ="";
                    $('.selectedSearch > span').parent().detach();   
        break;
          
        // 사이즈 초기화
        case '04' : paramSize ="";
                    //$(".sizeSearch > span").removeClass();
                    $('.selectedSearch > span').parent().detach();   
        break;
        
        // 혼용율 초기화 
        case '05' : paramMixed ="";
                    count_mixed = 0;
                    sb_mixed= new StringBuilder();
                    $('input:checkbox[name="mixed_ck"]').prop("checked",false);
                    $('.selectedSearch > span').filter(".reset05").parent().detach();   
        break;
          
    }

    doAsyncSearch();
    
}


/***************************************************************************
 * Section 4: 검색 처리 기능 관련 함수 모음
 ***************************************************************************/

// 통합 검색 기능
function doSearch() {
	
    var searchForm = document.search; 
    var searchwords = searchForm.query.value.replace(/(^\s*)|(\s*$)/g,"");
    
    if (searchwords == "") {
        alert(typingWord);
        searchForm.query.focus();
        return;
    }
//
//    // 로그인 상태 플래그
//    if($("#loginState").val() == "loginOn"){
//        // 내가 찾은 검색어(로그인 상태) : set, get in cookie
//        getLoginMyKeyWord($("#query").val());
//    // 비로그인 상태 플래그
//    } else {
//        // 내가 찾은 검색어(비로그인 상태) set, get in DB
//        getNotLoginMyKeyWord($("#query").val(), 10);            
//    }
//    
    getNotLoginMyKeyWord($("#query").val(), 10);
    
    searchForm.collection.value = searchForm.selectedLang.value;
    searchForm.identity.value = "united";
    searchForm.startDate.value = "";
    searchForm.endDate.value = "";
    searchForm.range.value = "A";
    searchForm.startCount.value = 0;
    searchForm.searchField.value = "ALL";
    searchForm.sort.value = "DATE/DESC";
//    searchForm.action = document.search.action +"?searchwords="+ searchForm.query.value;
    searchForm.submit();
}

// 결과 내 재검색
function doSearchRe() {
    
    var searchForm = document.searchRe; 

    if (searchForm.reQuery.value == "") {
        alert(typingWord);
        searchForm.reQuery.focus();
        return false;
    }
    
    // 구분탭이 '결과내 재검색'인 경우
    if(paramReSearch == "0"){
    	GA_Event('검색','결과내재검색',searchForm.reQuery.value);
        searchForm.query.value = searchForm.prefixQuery.value + " ("+ searchForm.reQuery.value +")";
        
    // 구분탭이 '검색어 제외'인 경우
    } else if(paramReSearch == "1"){
    	GA_Event('검색','검색어제외',searchForm.reQuery.value);
        searchForm.query.value = searchForm.prefixQuery.value +"!"+ searchForm.reQuery.value;
    } else {
        searchForm.query.value = searchForm.prefixQuery.value + " ("+ searchForm.reQuery.value +")";
    }
    
    //searchForm.query.value = searchForm.reQuery.value;
    searchForm.identity.value = "each";
    searchForm.collection.value = searchForm.selectedLang.value;
    searchForm.startDate.value = "";
    searchForm.endDate.value = "";
    searchForm.range.value = "A";
    searchForm.startCount.value = 0;
    searchForm.searchField.value = "ALL"; 
    searchForm.sort.value = "DATE/DESC";
    searchForm.submit();
}

// 동적 검색
function doDynamicSearch(str){   

    var $form = $("<form></form>");
    
    $form.attr("action", "searchCount");
    $form.attr("method", "post");
    $form.appendTo("body");    
    
    var query = $("<input type=\"hidden\" name=\"query\" value=\""+str+"\" />");
    var collection = $("<input type=\"hidden\" name=\"collection\" value=\""+$("#selectedLang").val()+"\" />");
    var lang = $("<input type=\"hidden\" name=\"lang\" value=\""+$("#lang").val()+"\" />");
    var token = $("<input type=\"hidden\" name=\"CSRFToken\" value=\""+$("#CSRFForm [name='CSRFToken']").first().val()+"\" />");
    
    $form.append(query).append(collection).append(lang).append(token);
    $form.submit();
}

// 메뉴 비동기 통신시 새롭게 그리기(1depth 클릭시)
function doMenuGroupDraw(){
    
    /*console.log("==================doMenuGroupDraw================");
    console.log("sort===="+paramSort);
    console.log("collection===="+paramLang);
    console.log("query===="+$("#prefixQuery").val());
    console.log("reQuery===="+paramReQuery);
    console.log("realQuery===="+ $("#realQuery").val());
    console.log("catequery_cate_1st===="+param1Depth);
    console.log("catequery_cate===="+paramCate);
    
    console.log("==================doMenuGroupDraw================");*/
    
    $.ajax({
        type : "get",
        url : "/"+targetLang+"/hssearch/asyncSearch",
        data : {
             sort : paramSort
            ,collection : paramLang
            ,query : $("#prefixQuery").val()
            ,reQuery : paramReQuery
            ,realQuery : $("#realQuery").val()
            ,catequery_cate_1st : param1Depth
            ,catequery_cate : paramCate
            //,catequery_brand : paramBrand
            //,catequery_saleprice_grp :paramPrice
            //,catequery_color : paramColor
            //,catequery_size  : paramSize
            //,catequery_matter : paramMixed
        },
        dataType : "json",
        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
        success : function(data) {  
            
            $("#search_menuGroup").empty();
            
            var sb = new StringBuilder();
            var resizeWidth = parseInt($(window).width());

            if(data.totalCount == 0 || data.totalCount < 1){
                return false;
            }
            
            
            // 2,3depth 카테고리
            sb.Append("<li>");
            if (resizeWidth < 1665){
                sb.Append("<h3 class=\"top_f\">"+category+"</h3>");
            }else{
                sb.Append("<h3 class=\"side_f\">"+category+"</h3>");
            }
            
            // 1) 2depth
            sb.Append("<div id=\"sideCategoryMenu\" class=\"dropdown_menu_wrap dep2\">");
            sb.Append("<ul class=\"sr_category_menu_dep2 dep2_2\">");

            sb.Append("<li><a href=\"javascript:void(0);\">"+total+"<span> ("+data.totalCount+")</span></a></li>");
            
            $.each(data.category2, function(key2, value2){
                sb.Append("<li class=\"search_depth2\">");
                sb.Append("<a href=\"javascript:void(0);\">"+value2.CATEGORY+"<span> ("+value2.CNT+")</span></a>");
                sb.Append("<ul class=\"sr_category_menu_dep3\">");
                sb.Append("</ul>");
                sb.Append("</li>");
            });
            sb.Append("</ul>");
            sb.Append("</div>");

            // 2) 3depth
            sb.Append("<div class=\"cate_select\">");
            sb.Append("<div class=\"cate_depth_3\">");

            $.each(data.category2, function(key3, value3){
                
                var s_menuDepth2 = value3.CATEGORY;
                var s_menuDepth2Length = s_menuDepth2.length;
                var s_menuDepth2Index = s_menuDepth2.indexOf('>');
                
                sb.Append("<div class=\"autoscroll\">");
                sb.Append("<ul class=\"list\">");

                $.each(data.category3, function(key4, value4){
                    
                    var s_menuDepth3 = value4.BRANDNAME;
                    var s_menuDepth3Length = s_menuDepth3.length;

                    if(s_menuDepth3.search(s_menuDepth2) > -1){

                        sb.Append("<li>");
                        sb.Append("<a href=\"javascript:void(0);\">"+s_menuDepth3.substring(s_menuDepth3.substring(0, s_menuDepth3.lastIndexOf(">"))));
                        sb.Append("<span style=\"display:none;\">"+value4.BRANDNAME+"</span>");
                        sb.Append("<span> ("+value4.CNT+")</span>");
                        sb.Append("</a>");
                        sb.Append("</li>");
                    }
                });
                sb.Append("</ul>");
                sb.Append("</div>");
            });

            sb.Append("</div>");
            sb.Append("</div>");
            sb.Append("</li>");

            // 브랜드
            sb.Append("<li class=\"filter\">");
            if (resizeWidth < 1665){
                sb.Append("<h3 class=\"top_f\">"+brand+"<a href=\"javascript:groupReset('01');\" class=\"reset\">"+reset+"</a></h3>");
            }else{
                sb.Append("<h3 class=\"side_f\">"+brand+"<a href=\"javascript:groupReset('01');\" class=\"reset\">"+reset+"</a></h3>");
            }
            sb.Append("<div class=\"dropdown_menu_wrap\">");
            sb.Append("<ul id=\"filter_brand_search\" class=\"sr_category_menu_dep2 dep2_3\">");

            if(data.totalCount > 0){
                $.each(data.cateBrand, function(key5, value5){
                    sb.Append("<li><input type=\"checkbox\" id=\"brand_ck"+(key5+1)+"\" name=\"brand_ck\" value=\""+value5.BRANDNAME+"\">");
                    sb.Append("<label for=\"brand_ck"+(key5+1)+"\">"+value5.BRANDNAME+"<span>&nbsp;("+value5.CNT+")</span></label></li>");
                });
            }
            
            sb.Append("</ul>");
            sb.Append("</div>");
            sb.Append("</li>");
            
            // 가격
            sb.Append("<li class=\"filter\">");
            if (resizeWidth < 1665){
                sb.Append("<h3 class=\"top_f\">"+price+"<a href=\"javascript:groupReset('02');\" class=\"reset\">"+reset+"</a></h3>");
            }else{
                sb.Append("<h3 class=\"side_f\">"+price+"<a href=\"javascript:groupReset('02');\" class=\"reset\">"+reset+"</a></h3>");
            }
            sb.Append("<div class=\"dropdown_menu_wrap\">");
            sb.Append("<ul class=\"sr_category_menu_dep2 price\">");
            sb.Append("<li><input type=\"checkbox\" id=\"price_ck1\" name=\"price_ck\" value=\"A\"><label for=\"price_ck1\">"+priceUnder+"</label></li>");
            sb.Append("<li><input type=\"checkbox\" id=\"price_ck2\" name=\"price_ck\" value=\"B\"><label for=\"price_ck2\">"+priceBetween1+"</label></li>");
            sb.Append("<li><input type=\"checkbox\" id=\"price_ck3\" name=\"price_ck\" value=\"C\"><label for=\"price_ck3\">"+priceBetween2+"</label></li>");
            sb.Append("<li><input type=\"checkbox\" id=\"price_ck4\" name=\"price_ck\" value=\"D\"><label for=\"price_ck4\">"+priceBetween3+"</label></li>");
            sb.Append("<li><input type=\"checkbox\" id=\"price_ck5\" name=\"price_ck\" value=\"E\"><label for=\"price_ck5\">"+priceOver+"</label></li>");
            sb.Append("</ul>");
            sb.Append("<div class=\"filter_apply\">");
            sb.Append("<a href=\"javascript:groupReset('02');\" class=\"reset\">"+reset+"</a>");
            sb.Append("<a href=\"javascript:void(0);\" class=\"close\">"+colse+"</a>");
            sb.Append("</div>");
            sb.Append("</div>");
            sb.Append("</li>");
            
            // 색상
            sb.Append("<li class=\"filter\">");
            if (resizeWidth < 1665){
                sb.Append("<h3 class=\"top_f\">"+color+"<a href=\"javascript:groupReset('03');\" class=\"reset\">"+reset+"</a></h3>");
            }else{
                sb.Append("<h3 class=\"side_f\">"+color+"<a href=\"javascript:groupReset('03');\" class=\"reset\">"+reset+"</a></h3>");
            }
            sb.Append("<div class=\"dropdown_menu_wrap\">");
            sb.Append("<ul id=\"filter_color_search\" class=\"sr_category_menu_dep2 color_chip clearfix\">");

            if(data.totalCount > 0){
                $.each(data.cateColor, function(key6, value6){
                        sb.Append("<li><a href=\"javascript:void(0);\" class=\"c_bg\" style=\"background:"+value6.COLOR+"\">"+value6.COLOR+"</a></li>");
                });
            }

            sb.Append("</ul>");
            sb.Append("<p>"+colorchip+"</p>");
            sb.Append("<div class=\"filter_apply\">");
            sb.Append("<a href=\"javascript:groupReset('03');\" class=\"reset\">"+reset+"</a>");
            sb.Append("<a href=\"javascript:void(0);\" class=\"close\">"+colse+"</a>");
            sb.Append("</div>");
            sb.Append("</div>");
            sb.Append("</li>");
            
            
            // 사이즈
            sb.Append("<li class=\"filter\">");
            if (resizeWidth < 1665){
                sb.Append("<h3 class=\"top_f\">"+size+"<a href=\"javascript:groupReset('04');\" class=\"reset\">"+reset+"</a></h3>");
            }else{
                sb.Append("<h3 class=\"side_f\">"+size+"<a href=\"javascript:groupReset('04');\" class=\"reset\">"+reset+"</a></h3>");
            }
            sb.Append("<div class=\"dropdown_menu_wrap\">");
            sb.Append("<ul id=\"filter_size_search\" class=\"sr_category_menu_dep2 size_chip clearfix\">");

            if(data.totalCount > 0){
                $.each(data.cateSize, function(key7, value7){
                        sb.Append("<li><a href=\"javascript:void(0);\" class\"\">"+value7.SIZE+"</a></li>");
                });
            }

            sb.Append("</ul>");
            sb.Append("<div class=\"filter_apply\">");
            sb.Append("<a href=\"javascript:groupReset('04');\" class=\"reset\">"+reset+"</a>");
            sb.Append("<a href=\"javascript:void(0);\" class=\"close\">"+colse+"</a>");
            sb.Append("</div>");
            sb.Append("</div>");
            sb.Append("</li>");
            
            //혼용율
            sb.Append("<li class=\"filter\">");
            if (resizeWidth < 1665){
                sb.Append("<h3 class=\"top_f\">"+mixingrate+"<a href=\"javascript:groupReset('05');\" class=\"reset\">"+reset+"</a></h3>");
            }else{
                sb.Append("<h3 class=\"side_f\">"+mixingrate+"<a href=\"javascript:groupReset('05');\" class=\"reset\">"+reset+"</a></h3>");
            }
            sb.Append("<div class=\"dropdown_menu_wrap\">");
            sb.Append("<ul class=\"sr_category_menu_dep2 mixed_rate\">");

            if(data.totalCount > 0){
                $.each(data.cateMatter, function(key8, value8){
                    sb.Append("<li><input type=\"checkbox\" id=\"mixed_ck"+(key8+1)+"\" name=\"mixed_ck\" value=\""+value8.MATTER+"\">");
                    sb.Append("<label for=\"mixed_ck"+(key8+1)+"\">"+value8.MATTER+"</label></li>");
                });
            }

            sb.Append("</ul>");
            sb.Append("<div class=\"filter_apply\">");
            sb.Append("<a href=\"javascript:groupReset('05');\" class=\"reset\">"+reset+"</a>");
            sb.Append("<a href=\"javascript:void(0);\" class=\"close\">"+colse+"</a>");
            sb.Append("</div>");
            sb.Append("</div>");
            sb.Append("</li>");
            
            $("#search_menuGroup").html(sb.ToString());
            $("#search_result_keyword_state b").text(data.totalCount);
        },
        complete:function(){
            setTimeout("cateEvent()", 1000);
        },
        error: function(request,status,error){      
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
}



//메뉴 비동기 통신시 새롭게 그리기(2,3depth 클릭시만)
function doMenuGroupDrawSub(){
    
    /*console.log("==================doMenuGroupDraw3Depth================");
    console.log("sort===="+paramSort);
    console.log("collection===="+paramLang);
    console.log("query===="+$("#prefixQuery").val());
    console.log("reQuery===="+paramReQuery);
    console.log("realQuery===="+ $("#realQuery").val());
    console.log("catequery_cate_1st===="+param1Depth);
    console.log("catequery_cate===="+paramCate);
    
    console.log("==================doMenuGroupDraw3Depth================");*/
    
    $.ajax({
        type : "get",
        url : "/"+targetLang+"/hssearch/asyncSearch",
        data : {
             sort : paramSort
            ,collection : paramLang
            ,query : $("#prefixQuery").val()
            ,reQuery : paramReQuery
            ,realQuery : $("#realQuery").val()
            ,catequery_cate_1st : param1Depth
            ,catequery_cate : paramCate
        },
        dataType : "json",
        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
        success : function(data) {  
            
            if(data.totalCount == 0 || data.totalCount < 1){
                return false;
            }
            
            $("#filter_brand_search").empty();
            $("#filter_color_search").empty();
            $("#filter_size_search").empty();
            $("#filter_mixed_search").empty();
            
            var sb_brand = new StringBuilder();
            var sb_color = new StringBuilder();
            var sb_size = new StringBuilder();
            var sb_mixed = new StringBuilder();

            // 브랜드
            if(data.totalCount > 0){
                $.each(data.cateBrand, function(key, value){
                    sb_brand.Append("<li><input type=\"checkbox\" id=\"brand_ck"+(key+1)+"\" name=\"brand_ck\" value=\""+value.BRANDNAME+"\">");
                    sb_brand.Append("<label for=\"brand_ck"+(key+1)+"\">"+value.BRANDNAME+"<span>&nbsp;("+value.CNT+")</span></label></li>");
                });
            }
            
            // 색상
            if(data.totalCount > 0){
                $.each(data.cateColor, function(key2, value2){
                    sb_color.Append("<li><a href=\"javascript:void(0);\" class=\"c_bg\" style=\"background:"+value2.COLOR+"\">"+value2.COLOR+"</a></li>");
                });
            }

            // 사이즈
            if(data.totalCount > 0){
                $.each(data.cateSize, function(key3, value3){
                    sb_size.Append("<li><a href=\"javascript:void(0);\" class\"\">"+value3.SIZE+"</a></li>");
                });
            }
            
            //혼용율
            if(data.totalCount > 0){
                $.each(data.cateMatter, function(key4, value4){
                    sb_mixed.Append("<li><input type=\"checkbox\" id=\"mixed_ck"+(key4+1)+"\" name=\"mixed_ck\" value=\""+value4.MATTER+"\">");
                    sb_mixed.Append("<label for=\"mixed_ck"+(key4+1)+"\">"+value4.MATTER+"</label></li>");
                });
            }
            
            $("#filter_brand_search").html(sb_brand.ToString());
            $("#filter_color_search").html(sb_color.ToString());
            $("#filter_size_search").html(sb_size.ToString());
            $("#filter_mixed_search").html(sb_mixed.ToString());
            //검색결과 건수 업데이트
            $("#search_result_keyword_state b").text(data.totalCount);

        },
        complete:function(){
            setTimeout("cateEvent()", 1000);
        },
        error: function(request,status,error){      
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
}

//비동기 검색어 서치 서비스
function doAsyncSearch(){
    /*console.log("==================doAsyncSearch================");
    console.log("sort===="+paramSort);
    console.log("collection===="+paramLang);
    console.log("query===="+$("#prefixQuery").val());   
    console.log("reQuery===="+paramReQuery);
    console.log("realQuery===="+$("#realQuery").val());
    console.log("catequery_cate_1st===="+param1Depth);
    console.log("catequery_cate===="+paramCate);
    console.log("catequery_brand===="+paramBrand);
    console.log("catequery_saleprice_grp===="+paramPrice);
    console.log("catequery_color===="+paramColor);
    console.log("catequery_size===="+paramSize);
    console.log("catequery_matter===="+paramMixed);
    console.log("==================doAsyncSearch================");*/
    
    $.ajax({
        type : "get",
        url : "/"+targetLang+"/hssearch/asyncSearch",
        data : {
             sort : paramSort       
            ,collection : paramLang
            ,query : $("#prefixQuery").val()
            ,reQuery : paramReQuery
            ,realQuery : $("#realQuery").val()
            ,catequery_cate_1st : param1Depth
            ,catequery_cate : paramCate
            ,catequery_brand : paramBrand
            ,catequery_saleprice_grp :paramPrice
            ,catequery_color : paramColor
            ,catequery_size  : paramSize
            ,catequery_matter : paramMixed
        },
        async : false,
        dataType : "json",
        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
        success : function(data) {  

            if((data.totalCount == 0) || (data.totalCount < 0)){
                $("#no_found").css("display","block");
                $("#asyncSearchItem").empty();
                $("#paging").empty();
                return false;
            }
            
            if(data.totalCount > 0){
                
                $("#no_found").css("display","none");
                
                var sb = new StringBuilder();
    
                $.each(data.product, function(key, value){
                    
                    $("#asyncSearchItem").empty();
                    $("#paging").empty();
                    
                    if (key == 0) {         
                        return true;
                    }   
                    
                    if (key % 4 == 0) {         
                        sb.Append("<li class=\"mr1m\">");
                    } else {
                        sb.Append("<li>");
                    }
                    
                    // 인.허가 여부 데이터
                    var appvObj = value.APPROVAL_STATUS;
                    var appvSp =  appvObj.split(",");                   
                    
                    // 이미지 데이터
                    var imgObj = value.IMG;
                    var imgSp = imgObj.split(",");
                    var cnt = 0;
                    
                    // 사이즈 데이터
                    var sizeObj = value.SIZE_ORG;
                    var sizeSp = sizeObj.split(",");
                    
                    // 컬러칩 데이터
                    var colorObj = value.REP_COLOR;
                    var colorSp = colorObj.split(",");
                    
                    
                    // #1114 - beshow 태깅 추가
                    var beshowImgUrl = "";
                    var cnt2 = 0;
                    $.each(appvSp, function(key2, value2){

                        if(appvSp[key2].indexOf("unapproved") == -1 && appvSp[key2].indexOf("approved") > -1){
                            if(cnt2 == 0){
                                beshowImgUrl = imgSp[key2];
                                cnt2++;
                            }
                        }                        
                    });
                    sb.Append("<div class=\"item_box\">");

                    sb.Append("<a href=\""+value.PRODUCTDETAILURL+"\" class=\"item_info1\"");
                    sb.Append("   onclick=\"beshow_tagging(this);\" link=\""+ value.PRODUCTDETAILURL+"\" price=\""+ numberWithCommas(value.SALEPRICE) +"\" image=\""+ beshowImgUrl +"\" prdname=\""+ replaceAll(replaceAll(value.NAME, '<!HS>',''),'<!HE>','')+ "\" code=\""+ value.DOCID +"\">");
                    // #1114 - beshow 태깅 추가
//                    sb.Append(">");
                    sb.Append("<span class=\"item_img\">");

                    // 이미지 셋팅
                    $.each(appvSp, function(key2, value2){

                        if(appvSp[key2].indexOf("unapproved") == -1 && appvSp[key2].indexOf("approved") > -1){
                            if(cnt == 0){
                                sb.Append("<img src=\""+imgSp[key2]+"\" alt=\""+imgSp[key2]+"\" class=\"respon_image\"/>");
                                //beshowImgUrl +=" , img:"+ imgSp[key2];
                                cnt++;
                            } else {
                                sb.Append("<img src=\""+imgSp[key2]+"\" alt=\""+imgSp[key2]+"\" class=\"respon_image\" style=\"display:none\"/>");
                            }
                        }
                        
                    });
                    //console.log("beshowImg:"+ beshowImgUrl);
                    sb.Append("</span>");
                    
                    // 핏가이드 아이콘 추가 20220215
                    var isKOSite = $(".search_box_wrap #search").attr("action");
                    if(isKOSite.indexOf("ko") > -1){
                        if(value.fitGuideDisplayYn == "true"){
                            sb.Append("<span class='ico_fitguide'>핏가이드</span>");
                        }
                    }
                    
                    // 사이즈 셋팅
                    sb.Append("<span class=\"item_size\" style=\"display:none\" id=\"item_size"+[key]+"\">");
                    sb.Append("<div id=\""+value.PRODUCTCODE.split(',')[0]+"\">");
                    
                    $.each(sizeSp, function(key3, value3){
    
                        sb.Append(" <span>"+value3+"</span>");
                    });
                    sb.Append("</div>");
                    sb.Append("</span>");
                    
                    // 상품 정보 셋팅
                    sb.Append("</a>");
                    sb.Append("<a href=\""+value.PRODUCTDETAILURL+"\" class=\"item_info2\">");
                    sb.Append("<span class=\"brand\">"+value.BRANDNAME+"</span>");
                    sb.Append("<span class=\"title\">"+value.NAME+"</span>");
                    
                    // BENFIT 데이터
                    var benfitObj = value.BENFIT;
                    if(value.BENFIT == undefined){
                    	benfitObj = "";
                    }
                    var benfitSp = benfitObj.split(",");
                    var saleYn = false;
                    
                    if(benfitObj.indexOf("SALE") > -1 && value.ISOUTLET == 'false') {
                        saleYn = true;
                    }
                    
                    var checkNewBrand = true;
                    if(value.DOCID.indexOf('5W') == 0 || value.DOCID.indexOf('MF') == 0 || value.DOCID.indexOf('MM') == 0) {
                        if(value.DOCID.indexOf('0') == 2 || value.DOCID.indexOf('1') == 2 || value.DOCID.indexOf('2') == 2
                        || value.DOCID.indexOf('3') == 2 || value.DOCID.indexOf('4') == 2 || value.DOCID.indexOf('5') == 2
                        || value.DOCID.indexOf('6') == 2 || value.DOCID.indexOf('7') == 2 || value.DOCID.indexOf('8') == 2
                        || value.DOCID.indexOf('9') == 2) {
                            checkNewBrand = true;
                        }else {
                            checkNewBrand = false;
                        }
                    }else {
                        checkNewBrand = true;
                    }
                    
                    var docId = value.DOCID.toLowerCase()+"_";
                    
                    if(checkNewBrand == true && docId.indexOf('a_') == -1 
                    && docId.indexOf('a0_') == -1 
                    && docId.indexOf('a1_') == -1 
                    && docId.indexOf('a2_') == -1 
                    && docId.indexOf('a3_') == -1 
                    && docId.indexOf('a4_') == -1 
                    && docId.indexOf('a5_') == -1 
                    && docId.indexOf('a6_') == -1 
                    && docId.indexOf('a7_') == -1 
                    && docId.indexOf('a8_') == -1 
                    && docId.indexOf('a9_') == -1 
                    && docId.indexOf('b_')  == -1 
                    && docId.indexOf('b0_') == -1 
                    && docId.indexOf('b1_') == -1 
                    && docId.indexOf('b2_') == -1 
                    && docId.indexOf('b3_') == -1 
                    && docId.indexOf('b4_') == -1 
                    && docId.indexOf('b5_') == -1 
                    && docId.indexOf('b6_') == -1 
                    && docId.indexOf('b7_') == -1 
                    && docId.indexOf('b8_') == -1 
                    && docId.indexOf('a9_') == -1 
                    && docId.indexOf('c_')  == -1 
                    && docId.indexOf('c0_') == -1 
                    && docId.indexOf('c1_') == -1 
                    && docId.indexOf('c2_') == -1 
                    && docId.indexOf('c3_') == -1 
                    && docId.indexOf('c4_') == -1 
                    && docId.indexOf('c5_') == -1 
                    && docId.indexOf('c6_') == -1 
                    && docId.indexOf('c7_') == -1 
                    && docId.indexOf('c8_') == -1 
                    && docId.indexOf('c9_') == -1 
                    && docId.indexOf('d_')  == -1 
                    && docId.indexOf('d0_') == -1 
                    && docId.indexOf('d1_') == -1 
                    && docId.indexOf('d2_') == -1 
                    && docId.indexOf('d3_') == -1 
                    && docId.indexOf('d4_') == -1 
                    && docId.indexOf('d5_') == -1 
                    && docId.indexOf('d6_') == -1 
                    && docId.indexOf('d7_') == -1 
                    && docId.indexOf('d8_') == -1 
                    && docId.indexOf('d9_') == -1 && value.ISOUTLET == 'true') {
                        if(value.PRICE != null && parseInt(value.PRICE) >= parseInt(value.SALEPRICE)) {
                            saleYn = true;
                        }
                        
                    }
                    if(checkNewBrand == false &&  value.DOCID.indexOf('5WM') == 0 && value.ISOUTLET == 'true'){
                        if(value.PRICE != null && parseInt(value.PRICE) >= parseInt(value.SALEPRICE)) {
                            saleYn = true;    
                        }
                    }
                    
                    if(docId.indexOf('cm') == 0 && docId.indexOf('c_') > 0 && value.ISOUTLET == 'true'){
                        if(value.PRICE != null && parseInt(value.PRICE) > parseInt(value.SALEPRICE)) {
                            saleYn = true;    
                        }
                    }
                    
                    if(value.BRANDCODE == 'BR15' || value.BRANDCODE == 'BR16' || value.BRANDCODE == 'BR30' 
                    || value.BRANDCODE == 'BR32' || value.BRANDCODE == 'BR35' || value.BRANDCODE == 'BR44' 
                    || value.DOCID.indexOf('FL') == 0){
                        if(value.ISOUTLET == 'true') {
                            saleYn = true;
                        }
                    }
                    
                    simbol = $("#simbol").val();
                    
                    var productCodeTemp = "";
                    var idCnt = 0;
                    $.each(appvSp, function(key6, value6){
                        if(appvSp[key6].indexOf("unapproved") == -1 && appvSp[key6].indexOf("approved") > -1){
                            if(idCnt == 0){
                                productCodeTemp = value.DOCID + "_" + appvSp[key6].split(":")[0];
                                idCnt++;
                            }    
                        }
                    });
                    
                    sb.Append("<span class=\"price price_"+value.DOCID+"\">");
                    sb.Append("<span id=\"price_"+productCodeTemp+"\">");
                    sb.Append("<span>"+simbol +numberWithCommas(exchangeRatePrice(value.SALEPRICE))+"</span>");
                    
                    if(saleYn == true) {
                        if(value.PRICE != null && parseInt(value.PRICE) > parseInt(value.SALEPRICE)){
                        	var productSalePerCent = getDecimalToString(((parseInt(value.PRICE) - parseInt(value.SALEPRICE)) / parseInt(value.PRICE) * 100), 1, 1);
                        	
                            sb.Append("<del class=\"del_price_201029\">"+simbol +numberWithCommas(exchangeRatePrice(value.PRICE))+"</del>");
                            sb.Append("<span class=\"discount_rate_201029\">"+ productSalePerCent +"%</span>");
                        }
                    }
                    
                    sb.Append("</span></span>");
                    
                    sb.Append("<span class=\"flag\">");                         
                    sb.Append("<input type=\"hidden\" id=\"productCd"+[key]+"\" name=\"productCd\" value=\""+value.DOCID+"\"/>");

                    var productflag = "EXCLUSIVE,GIFT,RE_ORDER,NEW,BEST";
                    var tempProductFlag = "";
                    var tempPriceFlag = "";
                    
                    
                    $.each(benfitSp, function(key4, value4){
                        
                        if(benfitSp[key4] == 'SALE') {
                            tempPriceFlag = 'SALE';
                        }
                        
                        if(tempProductFlag == "" && benfitSp[key4] != 'SALE' && benfitSp[key4] != 'COUPON') {
                            tempProductFlag = benfitSp[key4];
                        }
                        
                        if(tempProductFlag != "" && benfitSp[key4] != 'SALE' && productflag.indexOf(benfitSp[key4]) < productflag.indexOf(tempProductFlag)) {
                            tempProductFlag = benfitSp[key4];
                        }
                    });
                    
                    if(tempProductFlag != "") {
                        if ($("#lang").val() == "ko") {
                            if(value.stickerTextUseYn !== "true"){
                                sb.Append("<span class=\"flag_typ1\">");
                                sb.Append(tempProductFlag.replace('RE_ORDER','재입고'));
                                sb.Append("</span>");
                            }
                        } else {
                            sb.Append("<span class=\"flag_typ1\">");
                            sb.Append(tempProductFlag.replace('_','-'));
                            sb.Append("</span>");
                        }
                        
                    }
                    
                    if ($("#lang").val() == "ko" && value.stickerTextUseYn === "true") {
                        sb.Append("<span class=\"point-mark\" style=\"background-color:#"+value.stickerColor+";color: white;\">");
                        sb.Append(value.stickerText);
                        sb.Append("</span>");
                    }
                    if(tempPriceFlag != "") {
                        sb.Append("<span class=\"flag_typ2\">SALE</span>");
                    }
                    
                    /*$.each(benfitSp, function(key4, value4){
                        if(benfitSp[key4] != 'SALE' && benfitSp[key4] != 'COUPON') {
                            sb.Append("<span class=\"flag_typ1\">");
                            sb.Append(benfitSp[key4]);
                            sb.Append("</span>");
                        }
                        
                        if(benfitSp[key4] == 'SALE') {
                            sb.Append("<span class=\"flag_typ2\">");
                            sb.Append("SALE");
                            sb.Append("</span>");
                        }
                        
                    });*/
                    sb.Append("<span class=\"hsDelivery1902 ch1904\" id=\"hsDelivery"+[key]+"\" style=\"display:none;\">한섬딜리버리</span> ");
                    
                    sb.Append("</span>");   
                    sb.Append("</a>");
                    
                    // 컬러 데이터
                    sb.Append("<div class=\"color_more_wrap\">");
                    var colorChipImage = "";
                    $.each(appvSp, function(key5, value5){
                        if(appvSp[key5].indexOf("unapproved") == -1 && appvSp[key5].indexOf("approved") > -1){
                        	var colorChipArr = colorSp[key5].split(";");
                        	if(typeof colorChipArr[1] !== "undefined" && colorChipArr[1] != "ZZZZ" && colorChipArr[1].indexOf('C01') > -1) {
                        		colorChipImage = "background:"+colorChipArr[0]+" url('"+colorChipArr[1]+"/dims/resize/13x14');";
                        	} else {
                        		colorChipImage = "background:"+colorChipArr[0]+";";
                        	}
                            sb.Append("<a href=\"javascript:void(0);\" class=\"cl wt\" style=\""+colorChipImage+"\"></a> \n");
                        }
                    });

                    sb.Append("</div>");
                    sb.Append("</div>");
                    sb.Append("</li>");
                });
                
                $("#asyncSearchItem").html(sb.ToString());
                $("#paging").html(data.pageLink);
                //검색결과 건수 업데이트
                $("#search_result_keyword_state b").text(data.totalCount);
                
                asyncCheckPro4pmInfo(data);
                
                //새로고침 대비 흔적남기기
//                document.location.hash ="#in";
                // 해시태그로 인해 paging이 영향을 받기 때문에 pushstate, replacestate로 url에 파라미터를 붙이고,
                // 페이지 새로 진입 시 해당 파라미터가 있으면 sessionStorage 데이터 가져와 화면 재생성하도록 변경
                history.replaceState({searchCount: '0', keepState: true}, 'start 0', '?startCount=0&keepState=true&query=' + encodeURI($("#realQuery").val()));
               

                //sessionStorage 데이터 저장
                setSessionStorage();
                
                //setSiteSortList();
                
            }   
        },
        
        beforeSend:function(){
            $("#bx_loading").css("display", "block");
            $("#asyncSearchItem").css("display", "none");
        },
        
        complete:function(){
            $("#bx_loading").css("display", "none");
            $("#asyncSearchItem").css("display", "block");
        },

        error: function(request,status,error){      
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
    
    //화면에 목록 보여준 후 보임 처리
    $("#asyncSearchItem").show();
}


function loadStateContent(state) {
    if (Number.isInteger(parseInt(state.searchCount, 10))) {
        getPageData(state.searchCount);
    }
}


//페이징
function doPaging(count){
    var param = '?startCount=' + count
        + '&query=' + encodeURI($("#realQuery").val())
        + '&keepState=true';
    
    history.pushState({searchCount: count, keepState: true}, 'start ' + count, param);
    
    getPageData(count);
    setTimeout(function(){
        $('html, body').scrollTop(0);
    }, 300);
}

function getPageData(count){
    
    /*console.log("sort===="+paramSort);
    console.log("collection===="+paramLang);
    console.log("query===="+$("#prefixQuery").val());   
    console.log("reQuery===="+paramReQuery);
    console.log("realQuery===="+$("#realQuery").val());
    console.log("catequery_cate_1st===="+param1Depth);
    console.log("catequery_cate===="+paramCate);
    console.log("catequery_brand===="+paramBrand);
    console.log("catequery_saleprice_grp===="+paramPrice);
    console.log("catequery_color===="+paramColor);
    console.log("catequery_size===="+paramSize);
    console.log("catequery_matter===="+paramMixed);*/
    paramPage = count;
    
    $.ajax({
        type : "get",
        url : "/"+targetLang+"/hssearch/asyncSearch",
        data : {
             startCount : count
            ,sort : paramSort           
            ,collection : paramLang
            ,query : $("#prefixQuery").val()
            ,reQuery : paramReQuery
            ,realQuery : $("#realQuery").val()
            ,catequery_cate_1st : param1Depth
            ,catequery_cate : paramCate
            ,catequery_brand : paramBrand
            ,catequery_color : paramColor
            ,catequery_size  : paramSize
            ,catequery_matter : paramMixed
            ,catequery_saleprice_grp : paramPrice
        },
        async : false,
        dataType : "json",
        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
        success : function(data) {  

            if((data.totalCount == 0) || (data.totalCount < 0)){
                $("#asyncSearchItem").empty();
                $("#paging").empty();
                return false;
            }
            
            if(data.totalCount > 0){
                
                var sb = new StringBuilder();
                $.each(data.product, function(key, value){
                    
                    $("#asyncSearchItem").empty();
                    $("#paging").empty();
                    
                    if (key == 0) {         
                        return true;
                    }   
                    
                    if (key % 4 == 0) {         
                        sb.Append("<li class=\"mr1m\">");
                    } else {
                        sb.Append("<li>");
                    }
                    
                    
                    // 인.허가 여부 데이터
                    var appvObj = value.APPROVAL_STATUS;
                    var appvSp =  appvObj.split(",");                   
                    
                    // 이미지 데이터
                    var imgObj = value.IMG;
                    var imgSp = imgObj.split(",");
                    var cnt = 0;
                    
                    // 사이즈 데이터
                    var sizeObj = value.SIZE_ORG;
                    var sizeSp = sizeObj.split(",");
                    
                    // 컬러칩 데이터
                    var colorObj = value.REP_COLOR;
                    var colorSp = colorObj.split(",");
                    
                    // #1114 - beshow 태깅 추가
                    var beshowImgUrl = "";
                    var cnt2 = 0;
                    $.each(appvSp, function(key2, value2){

                        if(appvSp[key2].indexOf("unapproved") == -1 && appvSp[key2].indexOf("approved") > -1){
                            if(cnt2 == 0){
                                beshowImgUrl = imgSp[key2];
                                cnt2++;
                            }
                        }                        
                    });
                    sb.Append("<div class=\"item_box\">");
                    sb.Append("<a href=\""+value.PRODUCTDETAILURL+"\" class=\"item_info1\"");
                    sb.Append(" onclick=\"beshow_tagging(this);\" link=\""+ value.PRODUCTDETAILURL+"\" price=\""+ numberWithCommas(value.SALEPRICE) +"\" image=\""+ beshowImgUrl +"\" prdname=\""+ replaceAll(replaceAll(value.NAME, '<!HS>',''),'<!HE>','')+ "\" code=\""+ value.DOCID +"\">");
                    // #1114 - beshow 태깅 추가
                    sb.Append("<span class=\"item_img\">");
                    
                    // 이미지 셋팅
                    $.each(appvSp, function(key2, value2){
                        
                        if(appvSp[key2].indexOf("unapproved") == -1 && appvSp[key2].indexOf("approved") > -1){
                            if(cnt == 0){
                                sb.Append("<img src=\""+imgSp[key2]+"\" alt=\""+imgSp[key2]+"\" class=\"respon_image\"/>");
                                cnt++;
                                //beshowImgUrl += "img:"+ imgSp[key2];
                            } else {
                                sb.Append("<img src=\""+imgSp[key2]+"\" alt=\""+imgSp[key2]+"\" class=\"respon_image\" style=\"display:none\"/>");
                            }
                        }
                    });

                    //console.log(beshowImgUrl);
                    sb.Append("</span>");
                    
                    // 핏가이드 아이콘 추가 20220215
                    var isKOSite = $(".search_box_wrap #search").attr("action");
                    if(isKOSite.indexOf("ko") > -1){
                        if(value.fitGuideDisplayYn == "true"){
                            sb.Append("<span class='ico_fitguide'>핏가이드</span>");
                        }
                    }
                    
                    // 사이즈 셋팅
                    sb.Append("<span class=\"item_size\" style=\"display:none\" id=\"item_size"+[key]+"\">");
                    sb.Append("<div id=\""+value.PRODUCTCODE.split(',')[0]+"\">");
                    
                    $.each(sizeSp, function(key3, value3){
    
                        sb.Append(" <span>"+value3+"</span>");
                    });
                    sb.Append("</div>");
                    sb.Append("</span>");
                    
                    
                    // 상품 정보 셋팅
                    sb.Append("</a>");
                    sb.Append("<a href=\""+value.PRODUCTDETAILURL+"\" class=\"item_info2\">");
                    sb.Append("<span class=\"brand\">"+value.BRANDNAME+"</span>");
                    sb.Append("<span class=\"title\">"+value.NAME+"</span>");
                    
                    // BENFIT 데이터
                    var benfitObj = value.BENFIT;
                    if(value.BENFIT == undefined){
                    	benfitObj = "";
                    }
                    var benfitSp = benfitObj.split(",");
                    var saleYn = false;
               
                    if(benfitObj.indexOf("SALE") > -1 && value.ISOUTLET == 'false') {
                        saleYn = true;
                    }
                    
                    var checkNewBrand = true;
                    if(value.DOCID.indexOf('5W') == 0 || value.DOCID.indexOf('MF') == 0 || value.DOCID.indexOf('MM') == 0) {
                        if(value.DOCID.indexOf('0') == 2 || value.DOCID.indexOf('1') == 2 || value.DOCID.indexOf('2') == 2
                        || value.DOCID.indexOf('3') == 2 || value.DOCID.indexOf('4') == 2 || value.DOCID.indexOf('5') == 2
                        || value.DOCID.indexOf('6') == 2 || value.DOCID.indexOf('7') == 2 || value.DOCID.indexOf('8') == 2
                        || value.DOCID.indexOf('9') == 2) {
                            checkNewBrand = true;
                        }else {
                            checkNewBrand = false;
                        }
                    } 
                                    
                    var docId = value.DOCID.toLowerCase()+"_";
                    
                    if(checkNewBrand == true && docId.indexOf('a_') == -1 
                    && docId.indexOf('a0_') == -1 
                    && docId.indexOf('a1_') == -1 
                    && docId.indexOf('a2_') == -1 
                    && docId.indexOf('a3_') == -1 
                    && docId.indexOf('a4_') == -1 
                    && docId.indexOf('a5_') == -1 
                    && docId.indexOf('a6_') == -1 
                    && docId.indexOf('a7_') == -1 
                    && docId.indexOf('a8_') == -1 
                    && docId.indexOf('a9_') == -1 
                    && docId.indexOf('b_')  == -1 
                    && docId.indexOf('b0_') == -1 
                    && docId.indexOf('b1_') == -1 
                    && docId.indexOf('b2_') == -1 
                    && docId.indexOf('b3_') == -1 
                    && docId.indexOf('b4_') == -1 
                    && docId.indexOf('b5_') == -1 
                    && docId.indexOf('b6_') == -1 
                    && docId.indexOf('b7_') == -1 
                    && docId.indexOf('b8_') == -1 
                    && docId.indexOf('a9_') == -1 
                    && docId.indexOf('c_')  == -1 
                    && docId.indexOf('c0_') == -1 
                    && docId.indexOf('c1_') == -1 
                    && docId.indexOf('c2_') == -1 
                    && docId.indexOf('c3_') == -1 
                    && docId.indexOf('c4_') == -1 
                    && docId.indexOf('c5_') == -1 
                    && docId.indexOf('c6_') == -1 
                    && docId.indexOf('c7_') == -1 
                    && docId.indexOf('c8_') == -1 
                    && docId.indexOf('c9_') == -1 
                    && docId.indexOf('d_')  == -1 
                    && docId.indexOf('d0_') == -1 
                    && docId.indexOf('d1_') == -1 
                    && docId.indexOf('d2_') == -1 
                    && docId.indexOf('d3_') == -1 
                    && docId.indexOf('d4_') == -1 
                    && docId.indexOf('d5_') == -1 
                    && docId.indexOf('d6_') == -1 
                    && docId.indexOf('d7_') == -1 
                    && docId.indexOf('d8_') == -1 
                    && docId.indexOf('d9_') == -1 && value.ISOUTLET == 'true') {
                        if(value.PRICE != null && parseInt(value.PRICE) >= parseInt(value.SALEPRICE)) {
                            saleYn = true;
                        }
                        
                    }
                    if(checkNewBrand == false &&  value.DOCID.indexOf('5WM') == 0 && value.ISOUTLET == 'true'){
                        if(value.PRICE != null && parseInt(value.PRICE) >= parseInt(value.SALEPRICE)) {
                            saleYn = true;    
                        }
                    }
                    
                    if(docId.indexOf('cm') == 0 && docId.indexOf('c_') > 0 && value.ISOUTLET == 'true'){
                        if(value.PRICE != null && parseInt(value.PRICE) > parseInt(value.SALEPRICE)) {
                            saleYn = true;    
                        }
                    }
                    
                    if(value.BRANDCODE == 'BR15' || value.BRANDCODE == 'BR16' || value.BRANDCODE == 'BR30' 
                    || value.BRANDCODE == 'BR32' || value.BRANDCODE == 'BR35' || value.BRANDCODE == 'BR44' 
                    || value.DOCID.indexOf('FL') == 0){
                        if(value.ISOUTLET == 'true') {
                            saleYn = true;

                        }
                    }
                    
                    simbol = $("#simbol").val();
                    
                    var productCodeTemp = "";
                    var idCnt = 0;
                    $.each(appvSp, function(key6, value6){
                        if(appvSp[key6].indexOf("unapproved") == -1 && appvSp[key6].indexOf("approved") > -1){
                            if(idCnt == 0){
                                productCodeTemp = value.DOCID + "_" + appvSp[key6].split(":")[0];
                                idCnt++;
                            }    
                        }
                    });
                    
                    sb.Append("<span class=\"price price_"+value.DOCID+"\">");
                    sb.Append("<span id=\"price_"+productCodeTemp+"\">");
                    sb.Append("<span>"+simbol +numberWithCommas(exchangeRatePrice(value.SALEPRICE))+"</span>");
                    
                    if(saleYn == true) {
                        if(value.PRICE != null && parseInt(value.PRICE) > parseInt(value.SALEPRICE)){
                        	var productSalePerCent = getDecimalToString(((parseInt(value.PRICE) - parseInt(value.SALEPRICE)) / parseInt(value.PRICE) * 100), 1, 1);
                        	
                            sb.Append("<del class=\"del_price_201029\">"+simbol +numberWithCommas(exchangeRatePrice(value.PRICE))+"</del>");
                            sb.Append("<span class=\"discount_rate_201029\">"+ productSalePerCent +"%</span>");
                        }
                    }
                    
                    sb.Append("</span></span>");
                    
                    sb.Append("<span class=\"flag\">");                         
                    sb.Append("<input type=\"hidden\" id=\"productCd"+[key]+"\" name=\"productCd\" value=\""+value.DOCID+"\"/>");
                    
                    var productflag = "EXCLUSIVE,GIFT,RE_ORDER,NEW,BEST";
                    var tempProductFlag = "";
                    var tempPriceFlag = "";
                    
                    
                    $.each(benfitSp, function(key4, value4){
                        
                        if(benfitSp[key4] == 'SALE') {
                            tempPriceFlag = 'SALE';
                        }
                        
                        if(tempProductFlag == "" && benfitSp[key4] != 'SALE' && benfitSp[key4] != 'COUPON') {
                            tempProductFlag = benfitSp[key4];
                        }
                        
                        if(tempProductFlag != "" && benfitSp[key4] != 'SALE' && productflag.indexOf(benfitSp[key4]) < productflag.indexOf(tempProductFlag)) {
                            tempProductFlag = benfitSp[key4];
                        }
                    });
                    
                    if(tempProductFlag != "") {
                        if ($("#lang").val() == "ko") {
                            if(value.stickerTextUseYn !== "true"){
                                sb.Append("<span class=\"flag_typ1\">");
                                sb.Append(tempProductFlag.replace('RE_ORDER','재입고'));
                                sb.Append("</span>");
                            }
                        } else {
                            sb.Append("<span class=\"flag_typ1\">");
                            sb.Append(tempProductFlag.replace('_','-'));
                            sb.Append("</span>");
                        }
                    }
                    
                    if ($("#lang").val() == "ko" && value.stickerTextUseYn === "true") {
                        sb.Append("<span class=\"point-mark\" style=\"background-color:#"+value.stickerColor+";color: white;\">");
                        sb.Append(value.stickerText);
                        sb.Append("</span>");
                    }
                    if(tempPriceFlag != "") {
                        sb.Append("<span class=\"flag_typ2\">SALE</span>");
                    }

                    /*
                    
                    $.each(benfitSp, function(key4, value4){
                        
                        if(benfitSp[key4] != '' && benfitSp[key4] != 'SALE' && benfitSp[key4] != 'COUPON') {
                            sb.Append("<span class=\"flag_typ1\">");
                            sb.Append(benfitSp[key4]);
                            sb.Append("</span>");
                        }
                        
                        if(benfitSp[key4] == 'SALE') {
                            sb.Append("<span class=\"flag_typ2\">");
                            sb.Append("SALE");
                            sb.Append("</span>");
                        }
                        
                    });*/
                    sb.Append("<span class=\"hsDelivery1902 ch1904\" id=\"hsDelivery"+[key]+"\" style=\"display:none;\">한섬딜리버리</span> ");
                    
                    sb.Append("</span>");   
                    sb.Append("</a>");
                    
                    // 컬러 데이터
                    sb.Append("<div class=\"color_more_wrap\">");
                    var colorChipImage = "";
                    $.each(appvSp, function(key5, value5){
                        if(appvSp[key5].indexOf("unapproved") == -1 && appvSp[key5].indexOf("approved") > -1){
                        	var colorChipArr = colorSp[key5].split(";");
                        	if(typeof colorChipArr[1] !== "undefined" && colorChipArr[1] != "ZZZZ" && colorChipArr[1].indexOf('C01') > -1) {
                        		colorChipImage = "background:"+colorChipArr[0]+" url('"+colorChipArr[1]+"/dims/resize/13x14');";
                        	} else {
                        		colorChipImage = "background:"+colorChipArr[0]+";";
                        	}
                            sb.Append("<a href=\"javascript:void(0);\" class=\"cl wt\" style=\""+colorChipImage+"\"></a> \n");
                        }
                    });

                    sb.Append("</div>");
                    sb.Append("</div>");
                    sb.Append("</li>");                 
                });
                
                
                $("#asyncSearchItem").html(sb.ToString());
                $("#paging").html(data.pageLink);
                //검색결과 건수 업데이트
                $("#search_result_keyword_state b").text(data.totalCount);

                asyncCheckPro4pmInfo(data);
                
                //새로고침 대비 흔적남기기
//                document.location.hash ="#in";
                
                //sessionStorage 데이터 저장
                setSessionStorage();     
                
                //setSiteSortList();
            }                   
        },
        
        beforeSend:function(){
            $("#bx_loading").css("display", "block");
            $("#asyncSearchItem").css("display", "none");
        },
        
        complete:function(){
            $("#bx_loading").css("display", "none");
            $("#asyncSearchItem").css("display", "block");
        },
        
        error: function(request,status,error){      
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
}

// 스타일 서치 키워드 가져오기
function getStyleKeyword(){

    var targetUrl = $(".search_box_wrap #search").attr("action");
    var targetLang = "ko";
    
    if(targetUrl.indexOf("en") > -1){
        targetLang = "en";
    }else if(targetUrl.indexOf("zh") > -1){
        targetLang = "zh";
    }

    
    $.ajax({
        type : "get",
        url : "/"+targetLang+"/hssearch/asyncSearch",
        data : {
            collection : "theme"
           ,lang : $("#lang").val()
        },
        dataType : "json",
        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
        success : function(data) {  
            
            if(data.condition.collection == "theme"){   
                
                if((data.totalCount == 0) || (data.totalCount < 0)){
                    $("#search_style_menu_parent").empty();
                    return false;
                }
                
                if(data.theme[0].resultCount > 0){
                    
                    var sb = new StringBuilder();
                    
                    $.each(data.theme, function(key, value){    

                        if (key == 0) {         
                            return true;
                        }
                        
                        if (key == (data.theme.length-1)){
                            sb.Append("<li><a href=\"javascript:doSearchStyle('"+value.TM_KEYWORD+"')\">"+value.TM_NM+"</a></li>");
                        } else {
                            sb.Append("<li><a href=\"javascript:doSearchStyle('"+value.TM_KEYWORD+"')\">"+value.TM_NM+"</a>,</li>");     
                        }
                    });
                    
                    $("#search_style_menu").html(sb.ToString());
                    $("#search_style_menu_parent").show();
                }   
            }
        },

        error: function(request,status,error){      
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
}

//탑셀러 가져오기
function getTopSeller(str){
    
    // 결과 없음 페이지의 탑셀러
    if(str =="01"){
        
        $.ajax({
            type : "get",
            url : "/"+targetLang+"/hssearch/asyncSearch",
            data : {
                 startCount : $("#startCount").val()
                ,collection : paramLang
                ,mode : $("#mode").val()
                ,sort : "SELLCNT/DESC" // 판매량순 오름차순
                ,range : $("#range").val()
                //,startDate :  prevWeek() // 일주일전 날짜
                ,startDate :  "2016.06.01"
                ,endDate : $("#endDate").val()
                ,query : ""
            },
            dataType : "json",
            async : false,
            contentType : "application/x-www-form-urlencoded;charset=UTF-8",
            success : function(data) {  
                

                if((data.totalCount == 0) || (data.totalCount < 0)){
                    $("#search_topSeller").hide();
                    return false;
                }

                if(data.totalCount > 0){
                    
                    var sb = new StringBuilder();   
                    
                    sb.Append("<div class=\"top_seller n_top_seller\">");
                    sb.Append("<p class=\"top_seller_tlt\">");
                    sb.Append("<span>&#34;"+newArrival+"&#34;</span>");
                    sb.Append("</p>");
                    sb.Append("<span class=\"date_sign\">"+realTime()+"</span>");
                    sb.Append("<div class=\"top_seller_slider items_list cate_item6\">");
                    sb.Append("<ul class=\"clearfix slides\">");
                    
                    $.each(data.product, function(key, value){  

                        if (key == 0) {         
                            return true;
                        }
                        
                        sb.Append("<li style=\"width:16%\">");
                        sb.Append("<div class=\"item_box\">");
                        sb.Append("<a href=\""+value.PRODUCTDETAILURL+"\" class=\"item_info1\"> ");
                        
                        // 인.허가 여부 데이터
                        var appvObj = value.APPROVAL_STATUS;
                        var appvSp =  appvObj.split(",");       
                        
                        // 이미지 데이터
                        var imgObj = value.IMG;
                        var imgSp = imgObj.split(",");
                        var cnt = 0;
                        
                        sb.Append("<span class=\"item_img\">");
                        
                        // 이미지 셋팅
                        $.each(appvSp, function(key2, value2){
                            
                            if(appvSp[key2].indexOf("unapproved") == -1 && appvSp[key2].indexOf("approved") > -1){
                                
                                if(cnt == 0){
                                    sb.Append("<img src=\""+imgSp[key2]+"\" alt=\""+imgSp[key2]+"\" class=\"respon_image\"/>");
                                    cnt++;
                                } else {
                                    sb.Append("<img src=\""+imgSp[key2]+"\" alt=\""+imgSp[key2]+"\" class=\"respon_image\" style=\"display:none\"/>");
                                }
                            }
                        });

                        sb.Append("</span>");
                        
                        // 사이즈 데이터
                        var sizeObj = value.SIZE_ORG;
                        var sizeSp = sizeObj.split(",");
                        
                        sb.Append("<span class=\"item_size\" style=\"display:none\">");
                        
                        $.each(sizeSp, function(key3, value3){
        
                            sb.Append(" <span>"+value3+"</span>");
                        });
                        sb.Append("</span>");
                        
                        sb.Append("</a>");
                        sb.Append("<a href=\""+value.PRODUCTDETAILURL+"\" class=\"item_info2\">");
                        sb.Append("<span class=\"brand\">"+value.BRANDNAME+"</span>");
                        sb.Append("<span class=\"title\">"+value.NAME+"</span>");
                        
                        simbol = $("#simbol").val();
                        var productCodeTemp = "";
                        var idCnt = 0;
                        $.each(appvSp, function(key6, value6){
                            if(appvSp[key6].indexOf("unapproved") == -1 && appvSp[key6].indexOf("approved") > -1){
                                if(idCnt == 0){
                                    productCodeTemp = value.DOCID + "_" + appvSp[key6].split(":")[0];
                                    idCnt++;
                                }    
                            }
                        });
                        
                        // BENFIT 데이터
                        var benfitObj = value.BENFIT;
                        if(value.BENFIT == undefined){
                        	benfitObj = "";
                        }
                        var benfitSp = benfitObj.split(",");
                        var saleYn = false;
                        
                        if(benfitObj.indexOf("SALE") > -1 && value.ISOUTLET == 'false') {
                            saleYn = true;
                        }
                        
                        var checkNewBrand = true;
                        if(value.DOCID.indexOf('5W') == 0 || value.DOCID.indexOf('MF') == 0 || value.DOCID.indexOf('MM') == 0) {
                            if(value.DOCID.indexOf('0') == 2 || value.DOCID.indexOf('1') == 2 || value.DOCID.indexOf('2') == 2
                            || value.DOCID.indexOf('3') == 2 || value.DOCID.indexOf('4') == 2 || value.DOCID.indexOf('5') == 2
                            || value.DOCID.indexOf('6') == 2 || value.DOCID.indexOf('7') == 2 || value.DOCID.indexOf('8') == 2
                            || value.DOCID.indexOf('9') == 2) {
                                checkNewBrand = true;
                            }else {
                                checkNewBrand = false;
                            }
                        }else {
                            checkNewBrand = true;
                        }
                        
                        var docId = value.DOCID.toLowerCase()+"_";
                        
                        if(checkNewBrand == true && docId.indexOf('a_') == -1 
                        && docId.indexOf('a0_') == -1 
                        && docId.indexOf('a1_') == -1 
                        && docId.indexOf('a2_') == -1 
                        && docId.indexOf('a3_') == -1 
                        && docId.indexOf('a4_') == -1 
                        && docId.indexOf('a5_') == -1 
                        && docId.indexOf('a6_') == -1 
                        && docId.indexOf('a7_') == -1 
                        && docId.indexOf('a8_') == -1 
                        && docId.indexOf('a9_') == -1 
                        && docId.indexOf('b_')  == -1 
                        && docId.indexOf('b0_') == -1 
                        && docId.indexOf('b1_') == -1 
                        && docId.indexOf('b2_') == -1 
                        && docId.indexOf('b3_') == -1 
                        && docId.indexOf('b4_') == -1 
                        && docId.indexOf('b5_') == -1 
                        && docId.indexOf('b6_') == -1 
                        && docId.indexOf('b7_') == -1 
                        && docId.indexOf('b8_') == -1 
                        && docId.indexOf('a9_') == -1 
                        && docId.indexOf('c_')  == -1 
                        && docId.indexOf('c0_') == -1 
                        && docId.indexOf('c1_') == -1 
                        && docId.indexOf('c2_') == -1 
                        && docId.indexOf('c3_') == -1 
                        && docId.indexOf('c4_') == -1 
                        && docId.indexOf('c5_') == -1 
                        && docId.indexOf('c6_') == -1 
                        && docId.indexOf('c7_') == -1 
                        && docId.indexOf('c8_') == -1 
                        && docId.indexOf('c9_') == -1 
                        && docId.indexOf('d_')  == -1 
                        && docId.indexOf('d0_') == -1 
                        && docId.indexOf('d1_') == -1 
                        && docId.indexOf('d2_') == -1 
                        && docId.indexOf('d3_') == -1 
                        && docId.indexOf('d4_') == -1 
                        && docId.indexOf('d5_') == -1 
                        && docId.indexOf('d6_') == -1 
                        && docId.indexOf('d7_') == -1 
                        && docId.indexOf('d8_') == -1 
                        && docId.indexOf('d9_') == -1 && value.ISOUTLET == 'true') {
                            if(value.PRICE != null && parseInt(value.PRICE) >= parseInt(value.SALEPRICE)) {
                                saleYn = true;
                            }
                            
                        }
                        if(checkNewBrand == false &&  value.DOCID.indexOf('5WM') == 0 && value.ISOUTLET == 'true'){
                            if(value.PRICE != null && parseInt(value.PRICE) >= parseInt(value.SALEPRICE)) {
                                saleYn = true;    
                            }
                        }
                        
                        if(docId.indexOf('cm') == 0 && docId.indexOf('c_') > 0 && value.ISOUTLET == 'true'){
                            if(value.PRICE != null && parseInt(value.PRICE) > parseInt(value.SALEPRICE)) {
                                saleYn = true;    
                            }
                        }
                        
                        if(value.BRANDCODE == 'BR15' || value.BRANDCODE == 'BR16' || value.BRANDCODE == 'BR30' 
                        || value.BRANDCODE == 'BR32' || value.BRANDCODE == 'BR35' || value.BRANDCODE == 'BR44' 
                        || value.DOCID.indexOf('FL') == 0){
                            if(value.ISOUTLET == 'true') {
                                saleYn = true;
                            }
                        }
                        
                        simbol = $("#simbol").val();
                        
                        sb.Append("<span class=\"price price_"+value.DOCID+"\">");
                        sb.Append("<span id=\"price_"+productCodeTemp+"\">");
                        sb.Append("<span>"+simbol +numberWithCommas(exchangeRatePrice(value.SALEPRICE))+"</span>");
                        
                        if(saleYn == true) {
                            if(value.PRICE != null && parseInt(value.PRICE) > parseInt(value.SALEPRICE)){
                            	var productSalePerCent = getDecimalToString(((parseInt(value.PRICE) - parseInt(value.SALEPRICE)) / parseInt(value.PRICE) * 100), 1, 1);
                            	
                                sb.Append("<del class=\"del_price_201029\">"+simbol +numberWithCommas(exchangeRatePrice(value.PRICE))+"</del>");
                                sb.Append("<span class=\"discount_rate_201029\">"+ productSalePerCent +"%</span>");
                            }
                        }
                        
                        sb.Append("</span></span>");                       
                        sb.Append("</a>");
                        
                        var colorObj = value.REP_COLOR;
                        var colorSp = colorObj.split(",");
                        
                        sb.Append("<div class=\"color_more_wrap\">");
                        var colorChipImage = "";
                        // 컬러 데이터                       
                        $.each(appvSp, function(key4, value4){
                            if(appvSp[key4].indexOf("unapproved") == -1 && appvSp[key4].indexOf("approved") > -1){
                            	var colorChipArr = colorSp[key4].split(";");
                            	if(typeof colorChipArr[1] !== "undefined" && colorChipArr[1] != "ZZZZ" && colorChipArr[1].indexOf('C01') > -1) {
                            		colorChipImage = "background:"+colorChipArr[0]+" url('"+colorChipArr[1]+"/dims/resize/13x14');";
                            	} else {
                            		colorChipImage = "background:"+colorChipArr[0]+";";
                            	}
                                sb.Append("<a href=\"javascript:void(0);\" class=\"cl wt\" style=\""+colorChipImage+"\"></a> \n");
                            }
                        });

                        sb.Append("</div>");
                        sb.Append("</div>");
                        sb.Append("</li>");             
                    });
                    
                    sb.Append("</ul>");                     
                    sb.Append("<div id=\"Controls\" class=\"topseller_controls\">");
                    sb.Append("<a href=\"javascript:void(0);\" class=\"prev\"></a>");
                    sb.Append("<a href=\"javascript:void(0);\" class=\"next\"></a>");
                    sb.Append("</div>");                    
                    sb.Append("</div>");
                    sb.Append("</div>");
                    
                    $("#search_topSeller").html(sb.ToString());
                }   
            },
            
            error: function(request,status,error){      
                console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });
        
        realTime();
    
    // 브랜드 바로가기 페이지 탑셀러
    } else if(str == "02"){
        $.ajax({
            type : "get",
            url : "/"+targetLang+"/hssearch/asyncSearch",
            data : {
                 startCount : $("#startCount").val()
                ,collection : paramLang
                ,mode : $("#mode").val()
                ,sort : "SELLCNT/DESC" // 판매량순 오름차순
                ,range : $("#range").val()
                //,startDate :  prevWeek() // 일주일전 날짜
                ,startDate :  "2016.06.01"
                ,endDate : $("#endDate").val()
                ,query : $("#realQuery").val()
            },
            dataType : "json",
            contentType : "application/x-www-form-urlencoded;charset=UTF-8",
            success : function(data) {  
                
                if((data.totalCount == 0) || (data.totalCount < 0)){
                    $("#search_topseller").hide();
                    return false;
                }
                
                if(data.totalCount > 0){
                    
                    $("#search_topseller").empty();
                    
                    var sb = new StringBuilder();
//                    sb.Append("<div class=\"top_seller\">");
                    sb.Append("<p class=\"top_seller_tlt\">");
                    sb.Append("<span>&#34;"+$("#realQuery").val().truncateBracketAndExcla()+"&#34;</span> "+topseller+"");
                    sb.Append("</p>");
                    sb.Append("<span class=\"date_sign\">"+realTime()+"</span>");
                    sb.Append("<div class=\"top_seller_slider\">");
                    sb.Append("<ul class=\"slides\">");
                                
                    $.each(data.product, function(key, value){  

                        if (key == 0) {         
                            return true;
                        }
                        
                        // 인.허가 여부 데이터
                        var appvObj = value.APPROVAL_STATUS;
                        var appvSp =  appvObj.split(",");
                        
                        var imgObj = value.IMG;
                        var imgSp = imgObj.split(",");                      
                        var imgSet = "";
                        
                        var cnt = 0;
                        
                        $.each(appvSp, function(key2, value2){
                            
                            if(appvSp[key2].indexOf("unapproved") == -1 && appvSp[key2].indexOf("approved") > -1){
                                
                                if(cnt == 0){
                                    imgSet = imgSp[key2];
                                    cnt++;
                                }
                            }
                        });

                        sb.Append("<li>");
                        sb.Append("<a href=\""+value.PRODUCTDETAILURL+"\">");
                        sb.Append("<img src=\""+imgSet+"\" alt=\"\">");
                        sb.Append("</li>");             
                    });
                    
                    sb.Append("</ul>");
                    sb.Append("<div id=\"Controls\" class=\"topseller_controls\">");
                    sb.Append("<a href=\"javascript:void(0);\" class=\"prev\"></a>");
                    sb.Append("<a href=\"javascript:void(0);\" class=\"next\"></a>");
                    sb.Append("</div>");
                    sb.Append("</div>");
//                    sb.Append("</div>");
                    
                    $("#search_topseller").html(sb.ToString());
                }   
            },
            
            error: function(request,status,error){      
                console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });
    }   
}

//다른 고객이 가장 많이 보고 있는 검색어
function doManySearchWord(){
    
    $.ajax({
        type : "get",
        url : "/"+targetLang+"/hssearch/searchReco",
//        url : "/"+targetLang+"/hssearch/asyncSearch",
        data : {
             collection : paramLang
            ,query : $("#realQuery").val()
            ,startCount : $("#startCount").val()
            ,mode : $("#mode").val()
            ,sort : "SELLCNT/DESC" //판매량순 오름차순
            ,range : $("#range").val()
            ,startDate : $("#startDate").val()
            ,endDate : $("#endDate").val()          
        },
        dataType : "json",
        async : false,
        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
        success : function(data) {  

            if((data.totalCount == 0) || (data.totalCount < 0)){
                $("#search_manyword").hide();
                return false;
            }
            
            if(data.totalCount > 0){                    
                
                $("#search_manyword").empty();
                
                var sb = new StringBuilder();
                sb.Append("<p class=\"sr_others_tlt\">");
                mostViewItem = mostViewItem.split(")").join("");
                mostViewItem = mostViewItem.split("(").join(",");
                mostViewItem = mostViewItem.replace(",을","(을)");
                sb.Append(""+mostViewItem+"</p>"); 
//                sb.Append("지금 다른 고객이 가장 많이 보고 있는<span>&#34;"+$("#realQuery").val().truncateBracketAndExcla()+"&#34;</span>는?</p>"); 
                sb.Append("<div class=\"items_list cate_item4\" id=\"othersSlider\">"); 
                sb.Append("<ul class=\"clearfix slides\" >");   

                $.each(data.product, function(key, value){  
                    
                    if (key == 0) {         
                        return true;
                    }
                    
                    var areaKind = value.areaKind;
                    
                    sb.Append("<li style=\"width: 23.5%\">");
                    sb.Append("<div class=\"item_box\">");
                    //#1240 검색페이지 상품추천 recopick 추가
                    if(typeof value.clicklog_link !== "undefined"){
                        sb.Append("<a href=\"javascript:goDetailPagebyRecommend('"+ value.PRODUCTDETAILURL +"', '"+ value.clicklog_link +"', '"+areaKind+"')\" class=\"item_info1\"> ");
                    }else{
                        sb.Append("<a href=\""+value.PRODUCTDETAILURL+"?area="+areaKind+"\" class=\"item_info1\"> ");
                    }
                    // 인.허가 여부 데이터
                    var appvObj = value.APPROVAL_STATUS;
                    var appvSp =  appvObj.split(","); 
                    
                    // 이미지 데이터
                    var imgObj = value.IMG;
                    var imgSp = imgObj.split(",");
                    var cnt = 0;
                    
                    // 사이즈 데이터
                    var sizeObj = value.SIZE_ORG;
                    var sizeSp = sizeObj.split(",");
                    
                    // 컬러칩 데이터
                    var colorObj = value.REP_COLOR;
                    var colorSp = colorObj.split(",");
                    
                    sb.Append("<span class=\"item_img\">");

                    // 이미지 셋팅
                    $.each(appvSp, function(key2, value2){
                        
                        if(appvSp[key2].indexOf("unapproved") == -1 && appvSp[key2].indexOf("approved") > -1){
                            
                            if(cnt == 0){
                                sb.Append("<img src=\""+imgSp[key2]+"\" alt=\""+imgSp[key2]+"\" class=\"respon_image\"/>");
                                cnt++;
                            } else {
                                sb.Append("<img src=\""+imgSp[key2]+"\" alt=\""+imgSp[key2]+"\" class=\"respon_image\" style=\"display:none\"/>");
                            }
                        }
                    });
                    
                    sb.Append("</span>");

                    sb.Append("<span class=\"item_size\" style=\"display:none\">");
                    
                    // 사이즈 셋팅
                    $.each(sizeSp, function(key3, value3){
    
                        sb.Append(" <span>"+value3+"</span>");
                    });
                    sb.Append("</span>");
                    
                    sb.Append("</a>");
                    
                    // 상품 정보 셋팅
                    if(typeof value.clicklog_link !== "undefined"){
                        sb.Append("<a href=\"javascript:goDetailPagebyRecommend('"+ value.PRODUCTDETAILURL +"', '"+ value.clicklog_link +"', '"+areaKind+"')\" class=\"item_info2\"> ");    
                    }else{
                        sb.Append("<a href=\""+value.PRODUCTDETAILURL+"?area="+areaKind+"\" class=\"item_info2\">");
                    }
                    simbol = $("#simbol").val();
                    sb.Append("<span class=\"brand\">"+value.BRANDNAME+"</span>");
                    sb.Append("<span class=\"title\">"+value.NAME+"</span>");
                    
                    var productCodeTemp = "";
                    var idCnt = 0;
                    $.each(appvSp, function(key6, value6){
                        if(appvSp[key6].indexOf("unapproved") == -1 && appvSp[key6].indexOf("approved") > -1){
                            if(idCnt == 0){
                                productCodeTemp = value.DOCID + "_" + appvSp[key6].split(":")[0];
                                idCnt++;
                            }    
                        }
                    });


                 // BENFIT 데이터
                    var benfitObj = value.BENFIT;
                    if(value.BENFIT == undefined){
                    	benfitObj = "";
                    }
                    
                    var benfitSp = benfitObj.split(",");
                    var saleYn = false;
                    
                    if(benfitObj.indexOf("SALE") > -1 && value.ISOUTLET == 'false') {
                        saleYn = true;
                    }
                    
                    var checkNewBrand = true;
                    if(value.DOCID.indexOf('5W') == 0 || value.DOCID.indexOf('MF') == 0 || value.DOCID.indexOf('MM') == 0) {
                        if(value.DOCID.indexOf('0') == 2 || value.DOCID.indexOf('1') == 2 || value.DOCID.indexOf('2') == 2
                        || value.DOCID.indexOf('3') == 2 || value.DOCID.indexOf('4') == 2 || value.DOCID.indexOf('5') == 2
                        || value.DOCID.indexOf('6') == 2 || value.DOCID.indexOf('7') == 2 || value.DOCID.indexOf('8') == 2
                        || value.DOCID.indexOf('9') == 2) {
                            checkNewBrand = true;
                        }else {
                            checkNewBrand = false;
                        }
                    }else {
                        checkNewBrand = true;
                    }
                    
                    var docId = value.DOCID.toLowerCase()+"_";
                    
                    if(checkNewBrand == true && docId.indexOf('a_') == -1 
                    && docId.indexOf('a0_') == -1 
                    && docId.indexOf('a1_') == -1 
                    && docId.indexOf('a2_') == -1 
                    && docId.indexOf('a3_') == -1 
                    && docId.indexOf('a4_') == -1 
                    && docId.indexOf('a5_') == -1 
                    && docId.indexOf('a6_') == -1 
                    && docId.indexOf('a7_') == -1 
                    && docId.indexOf('a8_') == -1 
                    && docId.indexOf('a9_') == -1 
                    && docId.indexOf('b_')  == -1 
                    && docId.indexOf('b0_') == -1 
                    && docId.indexOf('b1_') == -1 
                    && docId.indexOf('b2_') == -1 
                    && docId.indexOf('b3_') == -1 
                    && docId.indexOf('b4_') == -1 
                    && docId.indexOf('b5_') == -1 
                    && docId.indexOf('b6_') == -1 
                    && docId.indexOf('b7_') == -1 
                    && docId.indexOf('b8_') == -1 
                    && docId.indexOf('a9_') == -1 
                    && docId.indexOf('c_')  == -1 
                    && docId.indexOf('c0_') == -1 
                    && docId.indexOf('c1_') == -1 
                    && docId.indexOf('c2_') == -1 
                    && docId.indexOf('c3_') == -1 
                    && docId.indexOf('c4_') == -1 
                    && docId.indexOf('c5_') == -1 
                    && docId.indexOf('c6_') == -1 
                    && docId.indexOf('c7_') == -1 
                    && docId.indexOf('c8_') == -1 
                    && docId.indexOf('c9_') == -1 
                    && docId.indexOf('d_')  == -1 
                    && docId.indexOf('d0_') == -1 
                    && docId.indexOf('d1_') == -1 
                    && docId.indexOf('d2_') == -1 
                    && docId.indexOf('d3_') == -1 
                    && docId.indexOf('d4_') == -1 
                    && docId.indexOf('d5_') == -1 
                    && docId.indexOf('d6_') == -1 
                    && docId.indexOf('d7_') == -1 
                    && docId.indexOf('d8_') == -1 
                    && docId.indexOf('d9_') == -1 && value.ISOUTLET == 'true') {
                        if(value.PRICE != null && parseInt(value.PRICE) >= parseInt(value.SALEPRICE)) {
                            saleYn = true;
                        }
                        
                    }
                    if(checkNewBrand == false &&  value.DOCID.indexOf('5WM') == 0 && value.ISOUTLET == 'true'){
                        if(value.PRICE != null && parseInt(value.PRICE) >= parseInt(value.SALEPRICE)) {
                            saleYn = true;    
                        }
                    }
                    
                    if(docId.indexOf('cm') == 0 && docId.indexOf('c_') > 0 && value.ISOUTLET == 'true'){
                        if(value.PRICE != null && parseInt(value.PRICE) > parseInt(value.SALEPRICE)) {
                            saleYn = true;    
                        }
                    }
                    
                    if(value.BRANDCODE == 'BR15' || value.BRANDCODE == 'BR16' || value.BRANDCODE == 'BR30' 
                    || value.BRANDCODE == 'BR32' || value.BRANDCODE == 'BR35' || value.BRANDCODE == 'BR44' 
                    || value.DOCID.indexOf('FL') == 0){
                        if(value.ISOUTLET == 'true') {
                            saleYn = true;
                        }
                    }
                    
                    simbol = $("#simbol").val();
                    
                    sb.Append("<span class=\"price price_"+value.DOCID+"\">");
                    sb.Append("<span id=\"price_"+productCodeTemp+"\">");
                    sb.Append("<span>"+simbol +numberWithCommas(exchangeRatePrice(value.SALEPRICE))+"</span>");
                    
                    if(saleYn == true) {
                        if(value.PRICE != null && parseInt(value.PRICE) > parseInt(value.SALEPRICE)){
                        	var productSalePerCent = getDecimalToString(((parseInt(value.PRICE) - parseInt(value.SALEPRICE)) / parseInt(value.PRICE) * 100), 1, 1);
                        	
                            sb.Append("<del class=\"del_price_201029\">"+simbol +numberWithCommas(exchangeRatePrice(value.PRICE))+"</del>");
                            sb.Append("<span class=\"discount_rate_201029\">"+ productSalePerCent +"%</span>");
                        }
                    }
                    
                    sb.Append("</span></span>");
                    
                    
                    sb.Append("</a>");
                    
                    sb.Append("<div class=\"color_more_wrap\">");
                    var colorChipImage = "";
                    // 컬러칩 셋팅
                    $.each(appvSp, function(key4, value4){
                        if(appvSp[key4].indexOf("unapproved") == -1 && appvSp[key4].indexOf("approved") > -1){
                        	var colorChipArr = colorSp[key4].split(";");
                        	if(typeof colorChipArr[1] !== "undefined" && colorChipArr[1] != "ZZZZ" && colorChipArr[1].indexOf('C01') > -1) {
                        		colorChipImage = "background:"+colorChipArr[0]+" url('"+colorChipArr[1]+"/dims/resize/13x14');";
                        	} else {
                        		colorChipImage = "background:"+colorChipArr[0]+";";
                        	}
                            sb.Append("<a href=\"javascript:void(0);\" class=\"cl wt\" style=\""+colorChipImage+"\"></a> \n");
                        }
                    });

                    sb.Append("</div>");
                    sb.Append("</div>");
                    sb.Append("</li>");
                    
                });
                sb.Append("</ul>"); 
                sb.Append("<div id=\"Controls\" class=\"others_controls\">");   
                sb.Append("<a href=\"javascript:void(0);\" class=\"prev\"></a>");   
                sb.Append("<a href=\"javascript:void(0);\" class=\"next\"></a>");   
                sb.Append("</div>");                        
                sb.Append("</div>");
                
                
                $("#search_manyword").html(sb.ToString());
                
            }
            
        },
        
        error: function(request,status,error){      
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
}

//베스트 기획전 가져오기
function getBestSeller(){

    $.ajax({
        type : "get",
        url : "/"+targetLang+"/hssearch/asyncSearch",
        data : {
             startCount : $("#startCount").val()
            ,collection : paramLang
            ,mode : $("#mode").val()
            ,sort : "DATE/DESC" // 최신상품
            ,range : $("#range").val()
            //,startDate : prevWeek() //일주일전 날짜
            ,startDate :  "2016.06.01"
            ,endDate : $("#endDate").val()
            ,query : ""
        },
        dataType : "json",
        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
        success : function(data) {  
            
            if((data.totalCount == 0) || (data.totalCount < 0)){
                $("#search_bestSeller").hide();
                return false;
            }
            
            if(data.totalCount > 0){
                
                var sb = new StringBuilder();
                
                sb.Append("<div class=\"sr_editorial\" style=\"margin-top:0;\">");
                sb.Append("<p class=\"sr_editorial_tlt\">"+brandEditNoresult+"</p>");
                sb.Append("<div class=\"sr_editorial_list\">");
                sb.Append("<ul class=\"slides\">");

                $.each(data.product, function(key, value){  

                    if (key == 0) {         
                        return true;
                    }
                    sb.Append("<li>");
                    sb.Append("<a href=\"javascript:void(0);\"><img src=\""+value.THUMBNAIL+"\" alt=\"\">");
                    sb.Append("<div>");
                    sb.Append("<span class=\"tlt\">"+value.BRANDNAME+"</span>");
                    sb.Append("<span>"+value.CONTENT+"</span>");
                    
                    sb.Append("</div>");
                    sb.Append("</a>");
                    sb.Append("</li>");
                
                });
                sb.Append("</ul>");
                sb.Append("<div id=\"Controls\" class=\"editorial_controls\">");
                sb.Append("<a href=\"javascript:void(0);\" class=\"prev\"></a>");
                sb.Append("<a href=\"javascript:void(0);\" class=\"next\"></a>");
                sb.Append("</div>");
                sb.Append("</div>");
                sb.Append("</div>");
                
                $("#search_bestSeller").html(sb.ToString());
            }   
        },
        
        error: function(request,status,error){      
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
}

//그래프 자료 가져오기
function getBrandStats() {

    $.ajax({
        type: "get",
        url: "/"+targetLang+"/hssearch/asyncSearch",
        dataType: "json",
        data: { 
             query : $("#realQuery").val()
            ,collection : "brand_pop"
            ,lang : $("#lang").val()
            
        },
        success: function(callback) {

            var data = callback.brand_pop;
            
            if(parseInt(callback.totalCount) > 0){
                var pie_array = [];
                var pie_label = [];
                var pie_color = ["#cccccc", "#fd7964", "#e9a26e", "#8aaea2", "#9f95cf", "#8f9bf4", "#c7dae2", "#9adbc5", "#f0a49a", "#f7c55b",
                                 "#2484c1", "#65a620", "#7b6888", "#a05d56", "#961a1a", "#d8d23a", "#e98125", "#d0743c", "#635222", "#6ada6a",
                                 "#0c6197", "#7d9058", "#207f33", "#44b9b0", "#bca44a", "#e4a14b", "#a3acb2", "#8cc3e9", "#69a6f9", "#5b388f",
                                 "#546e91", "#8bde95", "#d2ab58", "#273c71", "#98bf6e", "#4daa4b", "#98abc5", "#cc1010", "#31383b", "#006391",
                                 "#c2643f", "#b0a474", "#a5a39c", "#a9c2bc", "#22af8c", "#7fcecf", "#987ac6", "#3d3b87", "#b77b1c", "#c9c2b6"];
                
                for(var i = 1; i<parseInt(data[0].resultCount)+1; i++){ 
                    
                     var pie_data = {};
                     
                     if(data[i].WORD){
                         pie_data.label = data[i].WORD;
                         pie_data.value = Number(data[i].CNT);
                         pie_data.color = pie_color[(i-1)]; 
                         pie_array.push(pie_data);
                     }
    
                     if(i > 10){
                         break;
                     }
                }
                
                drawGraph(pie_array); 
            } else {
                $('.result_inner_bottom').hide();
                $('.result_inner_bottom').siblings('.slide_up').hide();
                $('.br_result_search .result_inner_top').css("border-bottom","0px solid");
//                $('.adaptive_wrap').css("min-height", "");
            }
        },
        error: function(request,status,error){
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
}
    
// 그래프 출력
function drawGraph(pie_array){

     var contents_list = eval(JSON.stringify(pie_array));
     
     var pie = new d3pie("pie", {
            
         header: {
             title: {
                 text: "0",
                 fontSize:60,
                 //font:'whitneyMedium'
             },
             location: "pie-center"
         },
         size: {
                 canvasHeight:350,
                 canvasWidth:350,
                 pieInnerRadius: "83%"
         },
         data: {
                 sortOrder: "none",
                 content: contents_list
         },
         effect:{
             load:{
                 effect:"default",
                 speed:500
             }
         },
         labels: {
             outer: {
                 format: "none",
                 hideWhenLessThanPercentage: null,
                 pieDistance: 30
           },
             inner : {
                format: "none",
           }
        },
        callbacks: {
            onload: function(){
         
                $("#p0_title").attr("y", "197.5");
                //pie label
                var obj_color = "";
                var obj_value = "";
                var max = 0;
                
                $("#pie > svg > g:eq(0) g").each(function(i) {
                    var color = $(this).find("path").attr("fill");
                    var total = 0;
                    var value = "";
                    var name = "";
                    for (var k = 0; k < pie_array.length; k++) {
                        total += pie_array[k].value;
                    }
                    for (var k = 0; k < pie_array.length; k++) {
                        
                        var tempValue = pie_array[k].color;

                        if (tempValue.substring(1, 7) == color.substring(1, 7)) {
                            value = Math.round(pie_array[k].value
                                    / total * 100);
                            if (max < value) {
                                max = value;
                            }
                            name = pie_array[k].label;
                        }
                    }
                    
                    $("#pie_label").append("<li><div class='chartlabel' style='background:"+color+";'></div>"+ name + "<span>" + value+ "&#37;</span></li>");
                });
                
                $("#p0_title").text(max);
                
                if($("#pie > svg > g:eq(0) g").length == 1){
                    $(".percentage").css("left","262px");
                }
            }
        }
    // end property:callbacks       
    });
}

//검색결과 메시지 (통합 검색창 요청 메시지)
function unitedSearchResultKeywordState(str, str2){
    if(str2){
        $("#search_result_keyword_state").append("<strong>"+str+"</strong> 검색결과가 없습니다.  ");
    } else {        
        $("#search_result_keyword_state").before("<strong>"+str+"</strong> 검색결과  ");
    }
}

//검색결과 메시지 (결과내 재검색 요청 메시지)
function reSearchResultKeywordState(str, str2){

    var sb1 = new StringBuilder();
    var sb2 = new StringBuilder();

    var sp1 = str.split(" ");
    var sp2 = str.split("!");

    for(var i =0; i<sp1.length; i++){

        if(sp1[i].indexOf("!") > 0){

            sp1[i] = sp1[i].substring(sp1[i],sp1[i].indexOf("!"));
            if(i == 0){
                sb1.Append(sp1[i]);               
            } else {
                sb1.Append(","+sp1[i]);   
            }
                    
        } else {
            if(i == 0){
                sb1.Append(sp1[i]);               
            } else {
                sb1.Append("," +sp1[i]);   
            }
        }
    }

    for(var j =0; j<sp2.length; j++){

        if(sp2[j].indexOf(" ") > 0){

            sp2[j] = sp2[j].substring(sp2[j],sp2[j].indexOf(" "));
            
            if(j == 0){
                continue;       
            } else if(j == 1) {
                sb2.Append(sp2[j]);
            } else {
                sb2.Append(","+ sp2[j]);   
            }
                    
        } else {
            if(j == 0){
                continue;       
            } else if(j == 1) {
                sb2.Append(sp2[j]);
            } else {
                sb2.Append(","+sp2[j]);   
            }
        }
    }
    
    if(sb2.ToString() != ""){
        if(str2){
            $("#search_result_keyword_state").append("<strong>"+sb1.ToString()+"</strong>에서<strong>"+sb2.ToString()+"</strong>를 제외한 검색결과가 없습니다.  ");
        } else{
            $("#search_result_keyword_state").before("<strong>"+sb1.ToString()+"</strong>에서<strong>"+sb2.ToString()+"</strong>를 제외한 검색결과  ");
            
        }
    
    } else {
        if(str2){
            $("#search_result_keyword_state").append("<strong>"+sb1.ToString()+"</strong> 검색결과가 없습니다.  ");
        } else {            
            $("#search_result_keyword_state").before("<strong>"+sb1.ToString()+"</strong> 검색결과  ");
        }
        
    }   
}

// 인기 검색어
function getPopkeyword() {

    var target      = "popword";
    var range       = "W";
    var collection  = "_ALL_";
    var datatype   = "xml";
    
    $.ajax({
      type: "get",
      url: "/"+targetLang+"/hssearch/popword",
      dataType: "xml",
      data: { "target" : target, "range" : range, "collection" : collection , "datatype" : datatype },
      success: function(xml) {
          
        var sb = new StringBuilder();
        
        $(xml).find("Query").each(function(index){

            if(index < 3){
                sb.Append("<li class=\"top\">");
            } else {
                sb.Append("<li class=\"\">");
            }
            
            sb.Append("<a href=\"javascript:doKeyword('" + $(this).text() + "')\" onclick=\"GA_Event('검색','결과내재검색_인기검색어','" + $(this).text() +"');\"  ");
            
            if ($(this).attr("updown") == "U") {        
                sb.Append("class=\"up\">");
            } else if ($(this).attr("updown") == "D") {
                sb.Append("class=\"down\">");
            } else if ($(this).attr("updown") == "N") {
                sb.Append("class=\"new\">");
            } else if ($(this).attr("updown") == "C") {
                sb.Append("class=\"\">");
            }
            
            sb.Append("<span>"+(index+1)+"</span>" + $(this).text() + "</a></li>");
            sb.Append("</li>"); 
        });

        $("#popword").html(sb.ToString());
      }
    });
}

//인기 검색어
function getPopkeywordForSearchArea() {

    var target      = "popword";
    var range       = "W";
    var collection  = "_ALL_";
    var datatype   = "xml";
    
    $.ajax({
      type: "get",
      url: "/"+targetLang+"/hssearch/popword",
      dataType: "xml",
      data: { "target" : target, "range" : range, "collection" : collection , "datatype" : datatype ,CSRFToken: '${CSRFToken}'},
      success: function(xml) {
          
        var sb = new StringBuilder();
        var sb2 = new StringBuilder();
        
        $(xml).find("Query").each(function(index){
            
//            if(index < 5){
                if(index < 3){
                    sb.Append("<li class=\"top\">");
                } else {
                    sb.Append("<li class=\"\">");
                }
                
                sb.Append("<a href=\"javascript:doKeyword('" + $(this).text() + "')\" onclick=\"GA_Event('검색','인기검색어','" +escape($(this).text()) +"')\"");
                
                if ($(this).attr("updown") == "U") {        
                    sb.Append("class=\"up\">");
                } else if ($(this).attr("updown") == "D") {
                    sb.Append("class=\"down\">");
                } else if ($(this).attr("updown") == "N") {
                    sb.Append("class=\"new\">");
                } else if ($(this).attr("updown") == "C") {
                    sb.Append("class=\"\">");
                }
                
                sb.Append("<span>"+(index+1)+"</span>" + $(this).text() + "</a></li>");
                sb.Append("</li>"); 
            /*}else{
                if(index < 3){
                    sb2.Append("<li class=\"top\">");
                } else {
                    sb2.Append("<li class=\"\">");
                }
                
                sb2.Append("<a href=\"javascript:doKeyword('" + $(this).text() + "')\"");
                
                if ($(this).attr("updown") == "U") {        
                    sb2.Append("class=\"up\">");
                } else if ($(this).attr("updown") == "D") {
                    sb2.Append("class=\"down\">");
                } else if ($(this).attr("updown") == "N") {
                    sb2.Append("class=\"new\">");
                } else if ($(this).attr("updown") == "C") {
                    sb2.Append("class=\"\">");
                }
                
                sb2.Append("<span>"+(index+1)+"</span>" + $(this).text() + "</a></li>");
                sb2.Append("</li>"); 
            }*/

            
        });

        $("#topsearchLeft").html(sb.ToString());
//        $("#topsearchRight").html(sb2.ToString());
      }
    });
}


// 스타일 서치 탭의 아이템 리스트
function doStyleItem(){
    var targetUrl = $(".search_box_wrap #search").attr("action");
    var targetLang = "ko";
    
    if(targetUrl.indexOf("en") > -1){
        targetLang = "en";
    }else if(targetUrl.indexOf("zh") > -1){
        targetLang = "zh";
    }
    
    $.ajax({
        type: "get",
        url: "/"+targetLang+"/hssearch/asyncSearch",
        dataType: "json",
        
        data: { 
            collection : "theme"
           ,lang : $("#lang").val()
        },
        async: false,
        success: function(data) {
            
            if(data.condition.collection == "theme"){   
                if((data.totalCount == 0) || (data.totalCount < 0)){
                    $("#btn_style_search").hide();
                    $("#stylesearch_area").hide();
                    getPopkeywordForSearchArea();
                    $("#btn_top_search").show();
//                    $("#topsearch_area").show();
                    return false;
                }
                if($(".style_cnt").length == 0){
	                if(data.theme[0].resultCount > 0){
	                    
	                    var sb = new StringBuilder();
	                    var sb_img = new StringBuilder();
	                    var resultCount = data.theme[0].resultCount;
	                    
	                    $.each(data.theme, function(key, value){    
	                        
	                        if (key == 0) {         
	                            return true;
	                        }
	
	                        sb.Append("<li class=\"style_cnt\">");
	                        
	                        if(key == 1) {
	                            sb.Append("<a class=\"style_cnt_tlt on\" href=\"javascript:doSearchStyle('"+value.TM_KEYWORD+"')\">"+value.TM_NM_HTML+"</a>");
	                        }else {
	                            sb.Append("<a class=\"style_cnt_tlt\"  href=\"javascript:doSearchStyle('"+value.TM_KEYWORD+"')\">"+value.TM_NM_HTML+"</a>");
	                        }
	                        
                            var tmContents = value.TM_CONTENTS;
                            
                            if(resultCount < 3) {
                                if(tmContents.indexOf('<div id="summery" style="display:none">') > -1){
                                    if(tmContents.indexOf("</div>") > -1){
                                        var summery = tmContents.split("</div>")[0].split('<div id="summery" style="display:none">');
                                        var result = summery[1];

                                        if(result != "") {
                                            if(resultCount == 1) {
                                                sb.Append("<div class=\"style_cnt_inner\"><p>"+result+"</p></div>");
                                            }else {
                                                sb.Append("<div class=\"style_cnt_inner\"><p class=\"twl\">"+result+"</p></div>");                                                
                                            }
                                        } 
                                    }
                                }
                            }
	                        
	                        sb.Append("</li>");
	                        
	                        sb_img.Append("<li><a href=\"javascript:doSearchStyle('"+value.TM_KEYWORD+"')\"><img src=\""+value.TM_URL.split(";")[0]+"\" alt=\"img\"></a></li>");
	                        
	                    });
	
	                    $("#style_search_arr").html(sb.ToString());
	                    $("#styleSearchSlider .slides").html(sb_img.ToString());
	                }   
                }
            }
        },
        error: function(request,status,error){
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    }); 
}
// 내가 찾은 검색어(로그인 상태)
function getLoginMyKeyWord(paramQuery) {
    
    var targetUrl = $(".search_box_wrap #search").attr("action");
    var targetLang = "ko";
    
    if(targetUrl.indexOf("en") > -1){
        targetLang = "en";
    }else if(targetUrl.indexOf("zh") > -1){
        targetLang = "zh";
    }
    
    $.ajax({
        type: "GET",
        url: "/"+targetLang+"/hssearch/getLoginMyKeyWord",
        dataType: "json",
        data: { 
            query : paramQuery
           ,user_id : getCookie("UID")
        },
        success: function(callback) {
            if(callback.msg =='success'){
                
                var obj = $.parseJSON(callback.json);   
                
                // 기존 쿠키 정보 추출
                var myKeyword = getCookie("mykeyword");

                if(myKeyword == null) {
                   myKeyword = "";
                }
                
                // 기존 쿠키 split으로 쪼개서 가져오기
                var myKeywords = myKeyword.split("^%");
                
                // 기존 쿠키 전부 삭제
                myKeywords.splice(0, myKeywords.length);
                
                var arr = new Array();
                
                // DB에서 추출한 데이터 배열에 담기
                for (var i in obj) {
                    arr.push(obj[i].SEARCH_TEXT);                   
                }

                // DB에서 추출한 데이터 새롭게 쿠키에 저장(7일저장)
                setCookie("mykeyword", arr.join("^%"), 7);
                
                // 내가 찾은 검색어 화면 출력
                showMyKeyword(arr);

            } else if (callback.msg =='fail') { 
                var query = $("#realQuery").val();              
                getPostLoginMyKeyWord(query,10);    
                //alert("데이터베이스 트랜잭션에 문제가 발생하였습니다.\n관리자에게 문의바랍니다.");
                return false;
            }
        },
        error: function(request,status,error){
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
}

// 내가 찾은 검색어(로그인 이후: 쿠키에서 관리)
function getPostLoginMyKeyWord(keyword, totCount) {
    
    var MYKEYWORD_COUNT = 9; //내가 찾은 검색어 갯수 + 1
    var myKeyword = getCookie("mykeyword");
    if( myKeyword== null) {
        myKeyword = "";
    }

    var myKeywords = myKeyword.split("^%");

    if( totCount > 0 ) {
        var existsKeyword = false;
        for( var i = 0; i < myKeywords.length; i++) {
            if( myKeywords[i] == keyword) {
                existsKeyword = true;
                break;
            }
        }

        if( !existsKeyword ) {
            myKeywords.push(keyword);
            if( myKeywords.length == MYKEYWORD_COUNT) {
                myKeywords = myKeywords.slice(1,MYKEYWORD_COUNT);
            }
        }
        setCookie("mykeyword", myKeywords.join("^%"), 7);
    }

    showMyKeyword(myKeywords.reverse());
}

// 내가 찾은 검색 삭제
function deleteUserMyKeyWord(str, str2){
    
    var targetUrl = $(".search_box_wrap #search").attr("action");
    var targetLang = "ko";
    
    if(targetUrl.indexOf("en") > -1){
        targetLang = "en";
    }else if(targetUrl.indexOf("zh") > -1){
        targetLang = "zh";
    }

    $.ajax({
        type: "POST",
        url: "/"+targetLang+"/hssearch/deleteUserMyKeyWord",
        dataType: "json",
        data: { 
             user_id : getCookie("UID")
            ,search_text : str
            ,search_yn : str2
            ,CSRFToken: '${CSRFToken}'
        },
        success: function(callback) {
            
            if(callback.msg = "fail"){
                //alert("데이터베이스 트랜잭션에 문제가 발생하였습니다.\n관리자에게 문의바랍니다.");
                return false;
            }
            
        },
        error: function(request,status,error){
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
}

// 연관 검색어로 검색엔진 호출
function recommendSearch(str){
    $("#query").val(str);
    doSearch();
}

// 연관 검색어
function getRecommend() {

    $.ajax({
        type: "GET",
        url: "/"+targetLang+"/hssearch/recommend",
        dataType: "json",
        data: { 
            query : $("#realQuery").val()
        },
        success: function(callback) {
            
            var sb = new StringBuilder();
            
            if(typeof(callback.Data) != "undefined" && callback.Data.Return != "0"){
                var data = callback.Data.Word;
                
                $.each(data,function(index ,value){
                    
                    if((data.length-1) == index){
                        sb.Append("<li><a href='javascript:recommendSearch(\""+value+"\")'>"+value+"</a></li>");
                    } else {
                        sb.Append("<li><a href='javascript:recommendSearch(\""+value+"\")'>"+value+"</a>,</li>");
                    }
                });
                
                $("#search_recommend").html(sb.ToString());
                $(".related.keyword").show(); 
            } else {
                $(".related").hide();
            }
            
            
        },
        error: function(request,status,error){
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
}

// 검색어 관련 브랜드 기획전
function doEvent(){
    
    $.ajax({
        type : "get",
        url : "/"+targetLang+"/hssearch/event",
        data : {
             startCount : $("#startCount").val()
            ,mode : $("#mode").val()
            ,sort : $("#sort").val()
            ,range : $("#range").val()
            ,startDate : $("#startDate").val()
            ,endDate : $("#endDate").val()
            ,reQuery : $("#reQuery").val()
            ,realQuery : $("#realQuery").val()
            ,query : $("#realQuery").val()
        },
        dataType : "json",
        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
        success : function(data) {  

            if(data.condition.collection =="ALL" || data.condition.collection == "event"){  
                
                if((data.totalCount == 0) || (data.totalCount < 0)){
                    $("#search_event").hide();
                    return false;
                }
                
                if(data.totalCount > 0){
                    
                    $("search_event").empty();

                    var sb = new StringBuilder();
        
                    sb.Append("<p class=\"sr_editorial_tlt\">");
                    sb.Append("<span>&#34;"+$("#realQuery").val().truncateBracketAndExcla()+"&#34;</span>"+brandEdit+"");
                    sb.Append("</p>");
                    sb.Append("<div class=\"sr_editorial_list\">");
                    sb.Append("<ul class=\"slides\">");
                    
                    $.each(data.event, function(key, value){    
                        
                        if (key == 0) {         
                            return true;
                        }

                        sb.Append("<li>");
                        sb.Append("<a href=\""+value.URL+"\">");
                        sb.Append("<img src=\""+value.THUMBNAIL+"\" alt=\"\">");
                        sb.Append("<div>");
                        sb.Append("<span class=\"tlt\">"+value.NAME+"</span>");
                        sb.Append("<span>"+value.CONTENT+"</span>");
                        sb.Append("</div>");
                        sb.Append("</a>");
                        sb.Append("</li>");
                    });
                    
                    sb.Append("</ul>");
                    sb.Append("<div id=\"Controls\" class=\"editorial_controls\">");
                    sb.Append("<a href=\"javascript:void(0);\" class=\"prev\"></a>");
                    sb.Append("<a href=\"javascript:void(0);\" class=\"next\"></a>");
                    sb.Append("</div>");
                    sb.Append("</div>");

                    $("#search_event").html(sb.ToString());
                }               
            }           
        },

        error: function(request,status,error){      
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
}

//검색어 관련 브랜드 매거진
function doEventMagazine(){
    
    $.ajax({
        type : "get",
        url : "/"+targetLang+"/hssearch/eventMagazine",
        data : {
             startCount : $("#startCount").val()
            ,mode : $("#mode").val()
            ,sort : $("#sort").val()
            ,range : $("#range").val()
            ,startDate : $("#startDate").val()
            ,endDate : $("#endDate").val()
            ,reQuery : $("#reQuery").val()
            ,realQuery : $("#realQuery").val()
            ,query : $("#realQuery").val()
        },
        dataType : "json",
        contentType : "application/x-www-form-urlencoded;charset=UTF-8",
        success : function(data) {  

            if(data.condition.collection =="ALL" || data.condition.collection == "event"){  
                
                if((data.totalCount == 0) || (data.totalCount < 0)){
                    $("#search_magazine").hide();
                    return false;
                }
                
                if(data.totalCount > 0){
                    
                    $("search_magazine").empty();

                    var sb = new StringBuilder();
        
                    sb.Append("<p class=\"sr_editorial_tlt\">");
                    sb.Append("<span>&#34;"+$("#realQuery").val().truncateBracketAndExcla()+"&#34;</span>브랜드 관련 THE 매거진");
                    sb.Append("</p>");
                    sb.Append("<div class=\"search-sd-list-bx\">");
                    sb.Append("   <ul class=\"slides\">");
                    
                    $.each(data.event, function(key, value){    
                        
                        if (key == 0) {         
                            return true;
                        }

                        sb.Append(" <li>");
                        sb.Append("      <a href=\""+value.URL+"\">");
                        
                        var thumnailImg = value.THUMBNAIL; 
                        if(thumnailImg.indexOf('.mp4') > -1){
                            sb.Append("      <video autoplay muted playsinline loop preload=\"auto\" style=\"width:100%; auto;outline:none;\">");
                            sb.Append("         <source src=\""+value.THUMBNAIL+"\" type=\"video/mp4\">");
                            sb.Append("      </video>");
                        }else {
                            sb.Append("      <img src=\""+value.THUMBNAIL+"\" alt=\"\">");
                        }
                        sb.Append("      <div>");
                        
                        var tmpCategory =  value.editorialType != null ? value.editorialType : "";
                        var editorialType = "";
                        if(tmpCategory == "HOW_TO_STYLE") {
                            editorialType = "커버스토리";
                        }else if(tmpCategory == "SPOTLIGHT_ON") {
                            editorialType = "위클리 픽";
                        }else if(tmpCategory == "TREND_TO_KNOW") {
                            editorialType = "셀렉션";
                        }else if(tmpCategory == "EDITORS_PICK") {
                            editorialType = "스타일 가이드";
                        }else if(tmpCategory == "HANDSOME_PEOPLE") {
                            editorialType = "핸썸피플";
                        }else if(tmpCategory == "PLAY_PLAY") {
                            editorialType = "플레이";
                        }else if(tmpCategory == "SHARP_SOME") {
                            editorialType = "#SOME";
                        }
                        sb.Append("          <span class=\"tlt\">"+editorialType+"</span>");
                        sb.Append("         <span>"+value.NAME+"</span>");
                        sb.Append("      </div>");
                        sb.Append("      </a>");
                        sb.Append(" </li>");
                    });
                    
                    sb.Append("   </ul>");
                    
                    sb.Append("   <div id=\"Controls-search\" class=\"editorial_controls\"> ");
                    sb.Append("         <a class=\"prev\"></a>                    ");
                    sb.Append("         <a class=\"next\"></a>                    ");
                    sb.Append("   </div>                                                ");
                    
                    sb.Append("</div>");
                    
                    $("#search_magazine").html(sb.ToString());
                    
                    //슬라이드 적용
                    search_Relevant_Slide();
                }               
            }           
        },

        error: function(request,status,error){      
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
}

//내가 찾은 검색어 조회(비로그인 상태)
function getNotLoginMyKeyWord(keyword, totCount) {

    var MYKEYWORD_COUNT = 9; //내가 찾은 검색어 갯수 + 1
    var myKeyword = getCookie("mykeyword");
    if( myKeyword== null) {
        myKeyword = "";
    }

    var myKeywords = myKeyword.split("^%");

    if( totCount > 0 ) {
        var existsKeyword = false;
        for( var i = 0; i < myKeywords.length; i++) {
            if( myKeywords[i] == keyword) {
                existsKeyword = true;
                break;
            }
        }

        if( !existsKeyword ) {
            myKeywords.push(keyword);
            if( myKeywords.length == MYKEYWORD_COUNT) {
                myKeywords = myKeywords.slice(1,MYKEYWORD_COUNT);
            }
        }
        
        setCookie("mykeyword", myKeywords.join("^%"), 7);
    }

    showMyKeyword(myKeywords.reverse());
}

// 내가 찾은 검색어 삭제
function removeMyKeyword(keyword) {

    var myKeyword = getCookie("mykeyword");
    if( myKeyword == null) {
        myKeyword = "";
    }

    var myKeywords = myKeyword.split("^%");
    
    var i = 0;
    while (i < myKeywords.length) {
        
        if (myKeywords[i] == keyword) {
            myKeywords.splice(i, 1);
        } else { 
            i++; 
        }
    }

    setCookie("mykeyword", myKeywords.join("^%"), 7);
    showMyKeyword(myKeywords);

//    // 로그인 상태인 경우 검색어 DB 삭제
//    if($("#loginState").val() == "loginOn"){
//        deleteUserMyKeyWord(keyword, "1row");
//    }
}

// 내가 찾은 검색어 삭제
function removeAllMyKeyword() {

    var myKeyword = getCookie("mykeyword");
    
    if( myKeyword == null) {
        myKeyword = "";
    }

    var myKeywords = myKeyword.split(",");

    for (var i = 0 ; i < 10; i++) {
        myKeywords.splice(i, 1);
    }

    setCookie("mykeyword", myKeywords.join("^%"), 7);
    showMyKeyword(myKeywords);
//
//    // 로그인 상태인 경우 검색어 DB 삭제
//    if($("#loginState").val() == "loginOn"){
//        deleteUserMyKeyWord(keyword, "all_row");
//    }
}
 
// 내가 찾은 검색어 
function showMyKeyword(myKeywords) {
    
    // 쿠키 10개 넘으면 첫번째 index 삭제
    if(myKeywords.length > 10){
        myKeywords.splice(0, 1);
    }
    
    var str = "";

    for( var i = 0; i < myKeywords.length; i++) {
        if( myKeywords[i] == "") continue;
        myKeywords[i] = myKeywords[i].replace(/&amp;/g,'&');
        myKeywords[i] = myKeywords[i].replace("<",'&lt');
        myKeywords[i] = myKeywords[i].replace(">",'&gt');
        myKeywords[i] = myKeywords[i].replace("'",'&quot;');
        myKeywords[i] = myKeywords[i].replace('"','&#39;');
        str += "<li class=\"searchkey\"><a href=\"javascript:void(0);\" onClick=\"javascript:doKeyword('"+myKeywords[i]+"');GA_Event('검색','최근검색어',\'"+escape(myKeywords[i])+"\' );\">"+myKeywords[i]+"</a> <a href=\"javascript:removeMyKeyword('"+myKeywords[i]+"')\" class=\"btn_close\">삭제</a></li>";
    }
    str +="<div class=\"clear_search_hs\"><a href=\"javascript:removeAllMyKeyword()\">"+historyDelete+"</a></div>";
    $("#mykeyword").html(str);
}

//오타 조회
function getSpell(suggestQuery){

    if(suggestQuery != "") {
        var str = "<div class=\"resultall\" style=\"margin-top:-10px;padding:10px;font-size:14px;\">";
        str += "<span>이것을 찾으셨나요? </span>&nbsp;&nbsp;&nbsp;<a href=\"javascript:void(0);\" style=\"font-weight:bold;color:red;font-size:15px;\" onclick=\"javascript:doKeyword('"+suggestQuery+"');\">" + suggestQuery + "</a>";
        str += "</div>";
        $("#spell").html(str);
    }
    return true;
}

// 정렬
function doSorting(sort) {
    
    var searchForm = document.search;
    searchForm.sort.value = sort;
    searchForm.reQuery.value = "2";
    searchForm.submit();
}

//인기검색어, 내가찾은 검색어
function doKeyword(paramQuery) {
    
    var targetUrl = $(".search_box_wrap #search").attr("action");
    var targetLang = "ko";
    
    if(targetUrl.indexOf("en") > -1){
        targetLang = "en";
    }else if(targetUrl.indexOf("zh") > -1){
        targetLang = "zh";
    }
    
    var brand = "off";
    
    // 브랜드 검색어인지 여부 확인
    $.ajax({
        
        type: "GET",
        
        url: "/"+targetLang+"/hssearch/arkTrans",
        
        dataType: "json",
        
        data: { 
            query : paramQuery
        },
        
        success: function(data) {
            
            var searchForm = document.search;
            searchForm.identity.value = "united";           
            searchForm.startCount.value = "0";
            searchForm.query.value = paramQuery;
            searchForm.collection.value = "ALL";
            searchForm.sort.value = "RANK";
            
            if(data.srch.brand){                    
                searchForm.brandPageGubun.value = "on";
                searchForm.brand_img.value = data.srch.brand[1].IMG;
                searchForm.brand_url.value = data.srch.brand[1].URL;
            }
            
            doSearch();
        },
        error: function(request,status,error){
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    }); 
}

// 상품리스트 정렬
function doSort(str){
    var searchForm = document.search; 
    searchForm.collection.value = "ALL";
    searchForm.startDate.value = "";
    searchForm.endDate.value = "";
    searchForm.range.value = "A";
    searchForm.startCount.value = 0;
    searchForm.searchField.value = "ALL";
    searchForm.sort.value = str;
    searchForm.submit();    
}

// 연관 검색어 밑 스타일서치 검색
function doDynamicSearchStyle(str){ 

    var $form = $("<form></form>");
    
    $form.attr("action", "searchCount");
    $form.attr("method", "post");
    $form.appendTo("body");    
    
    var query = $("<input type=\"hidden\" name=\"query\" value=\""+str+"\" />");
    var collection = $("<input type=\"hidden\" name=\"collection\" value=\""+$("#selectedLang").val()+"\" />");
    var lang = $("<input type=\"hidden\" name=\"lang\" value=\""+$("#lang").val()+"\" />");
    var token = $("<input type=\"hidden\" name=\"CSRFToken\" value=\""+$("#CSRFForm [name='CSRFToken']").first().val()+"\" />");
    var searchStyle = $("<input type=\"hidden\" name=\"searchStyleYn\" value=\"searchStyle\" />");
    
    $form.append(query).append(collection).append(lang).append(token).append(searchStyle);
    
    $form.submit();
}

// 통합검색창에서 스타일서치 검색
function doSearchStyle(str) {   
    var searchForm = document.searchStyle;
    searchForm.collection.value = $("#selectedLang").val();
    searchForm.query.value = str.replace(/([^;]+)/gi,"($1)").replace(/;/gi,"|");
    searchForm.submit();    
}

//영역
function doSearchField(field) {
    
    var searchForm = document.search;
    searchForm.searchField.value = field;
    searchForm.reQuery.value = "2";
    searchForm.submit();
}

//컬렉션별 검색
function doCollection(coll) {
    
    var searchForm = document.search; 
    searchForm.collection.value = coll;
    searchForm.reQuery.value = "2";
    searchForm.submit();
}
    
// 엔터 체크    
function pressCheck() {  

    if (event.keyCode == 13) {
    	GA_search();
        return setTimeout('doSearch()', 500);
    }else{
        return false;
    }
}

//엔터 체크2
function pressCheckRe() {  

    if (event.keyCode == 13) {
        return setTimeout('doSearchRe()', 500);
    }else{
        return false;
    }
}

// 결과내 재검색
function checkReSearch() {
    
    var searchForm = document.search;
    var query = searchForm.query;
    searchForm.reQuery.value = 1;
    query.value = "";   
    query.focus();
}


//기간 적용
function doRange() {
    
    var searchForm = document.search;
    
    if($("#startDate").val() != "" || $("#endDate").val() != "") {
        if($("#startDate").val() == "") {
            alert("시작일을 입력하세요.");
            $("#startDate").focus();
            return;
        }

        if($("#endDate").val() == "") {
            alert("종료일을 입력하세요.");
            $("#endDate").focus();
            return;
        }

        if(!compareStringNum($("#startDate").val(), $("#endDate").val(), ".")) {
            alert("기간이 올바르지 않습니다. 시작일이 종료일보다 작거나 같도록 하세요.");
            $("#startDate").focus();
            return;
        }       
    }

    searchForm.startDate.value = $("#startDate").val();
    searchForm.endDate.value = $("#endDate").val();
    searchForm.range.value = $("#range").val();
    searchForm.reQuery.value = "2";
    searchForm.submit();
}

//sessionStorage에 저장
function setSessionStorage(){
    
    // sessionStorage에 담을 변수 선언
    var orgData = new Array();
    
    orgData[0] = paramPage;                                     // 1. 페이지 시작번호:startCount:count
    orgData[1] = paramSort;                                     // 2. 정렬:sort:paramSort
    orgData[2] = $("#selectedLang").val();                      // 3. 컬렉션ID:collection:$("#selectedLang").val()
    orgData[3] = $("#prefixQuery").val();                       // 4. 검색어:query:$("#prefixQuery").val()
    orgData[4] = paramReQuery;                                  // 5. 재검색어:reQuery:paramReQuery
    
    orgData[5] = $("#realQuery").val();                         // 6. 실검색어:realQuery:$("#realQuery").val()
    orgData[6] = $("#lang").val();                              // 7. 언어:lang:$("#lang").val()
    orgData[7] = param1Depth;                                   // 8. 카테고리1depth:catequery_cate_1st:param1Depth
    orgData[8] = paramCate;                                     // 9. 카테고리2,3depth:catequery_cate:paramCate
    orgData[9] = paramBrand;                                    // 10. 브랜드:catequery_brand:paramBrand
    
    orgData[10] = paramColor;                                   // 11. 가격:catequery_color:paramColor
    orgData[11] = paramSize;                                    // 12. 색상:catequery_size:paramSize
    orgData[12] = paramMixed;                                   // 13. 사이즈:catequery_matter:paramMixed
    orgData[13] = paramPrice;                                   // 14. 혼용율:catequery_saleprice_grp:paramPrice
    orgData[14] = $("#selectedSearchCondition").siblings().parents().html();    // 15. 선택한조건:selected_condition:$("#selectedCondition").html()

    var setData = JSON.stringify(orgData);
    sessionStorage.setItem("setData" , setData);
}

//sessionStorage에 데이터 가져와 화면 재생성
function getSessionStorage(){

    var getData = sessionStorage.getItem("setData");
    var pageIndex = "0";
    
    $(JSON.parse(getData)).each(function(key, value){

        // 1. 페이지 시작번호:startCount
        if(key == 0){
            pageIndex = value;      
        }
        
        // 2. 정렬:sort
        if(key == 1){
            
            paramSort = value;
            
            $(".sortSearch > li > a").removeClass("on");
            
            // 최신 상품순
            if(value =="DATE/DESC"){
                $("a[title='newest']").addClass("on");
            // 정확도순
            } else if(value =="RANK/DESC,SELLCNT/DESC"){
                $("a[title='accuracy']").addClass("on");
            // 낮은 가격순
            } else if(value =="SALEPRICE/ASC"){
                $("a[title='lowPrice']").addClass("on");
            // 높은 가격순
            } else if(value =="SALEPRICE/DESC"){
                $("a[title='highPrice']").addClass("on");
            // 판매량순 
            } else if(value =="SELLCNT/DESC"){
                $("a[title='sell']").addClass("on");
            // 세일상품 우선
            } else if(value =="SALERATE/DESC,SALEPRICE/ASC"){
                $("a[title='sail']").addClass("on");
            }
        }
        
        // 3. 컬렉션ID:collection
        if(key == 2){
            $("#selectedLang").val(value);          
        }
        
        // 4. 검색어:query
        if(key == 3){
            $("#prefixQuery").val(value);           
        }
        
        // 5. 재검색어:reQuery
        if(key == 4){
            paramReQuery = value;           
        }
        
        // 6. 실검색어:realQuery
        if(key == 5){
            $("#realQuery").val(value);         
        }
        
        // 7. 언어:lang
        if(key == 6){
            $("#lang").val(value);          
        }
        
        // 8. 카테고리1depth:catequery_cate_1st
        if(key == 7){
            param1Depth = value;            
        }
        
        // 9. 카테고리2,3depth:catequery_cate
        if(key == 8){
            paramCate = value;          
        }
        
        // 10. 브랜드:catequery_brand
        if(key == 9){
            paramBrand = value;         
            
            var arr = value.split(",");
            
            $(arr).each(function(keySub01, valueSub01){
                $("input:checkbox[name='brand_ck'][value='"+valueSub01+"']").prop("checked",true);
            });
        }

        // 11. 가격:catequery_color
        if(key == 10){
            paramColor = value;     
            
            var arr = value.split(",");
            
            $(arr).each(function(keySub01, valueSub01){
                $("input:checkbox[name='price_ck'][value='"+valueSub01+"']").prop("checked",true);
            });
        }
        
        // 12. 색상:catequery_size
        if(key == 11){
            paramSize = value;          
        }
        
        // 13. 사이즈:catequery_matter
        if(key == 12){
            paramMixed = value;         
        }
        
        // 14. 혼용율:catequery_saleprice_grp
        if(key == 13){
            paramPrice = value;
            
            var arr = value.split(",");
            
            $(arr).each(function(keySub01, valueSub01){
                $("input:checkbox[name='mixed_ck'][value='"+valueSub01+"']").prop("checked",true);
            });
        }
        
        //  15. 선택한조건:selected_condition
        if(key == 14){
            $(".filter_words > ul").html(value);
        }
        
        $(".filter_words").show();

    });

    // 상품리스트 호출
    getPageData(pageIndex);
    
    $('.sr_category_menu, .sr_category_menu_dep, .sr_category_menu_dep1').addClass('chg');
    $('.sr_category_menu_dep h3').html($('.sr_category_menu_dep ul li a').html());
    $('.sr_category_menu_dep h3').css({'border-bottom':'none'});
    $('.sr_category_menu_dep ul').hide();
    $('.sr_category_menu_dep h3+.btn_close').show();
    $(".filter_words").show();
    
    // 2,3depth 표시
    $(".search_depth2 > a").each(function(i,v){
        
        var anchorStr = String($(this).text());
        var spanStr = String($(this).children("span").text());
        var depth2Str = anchorStr.replace(spanStr, "");

        if(paramCate.indexOf(depth2Str) > -1){
            
            $(this).parents().addClass("current");
            
            if(paramCate.match(/>/g).length > 1){

                $(this).after("<span class=\"selec\">"+paramCate+"</span>");
            }
            
        }
        
    });
    //화면에 목록 보여준 후 보임 처리
    $("#asyncSearchItem").show();
}

$(document).ready(function(){
    // 새로고침시 해시값이 있는 경우 sessitionStorage 데이터 가져와 화면 재생성 
//    if(document.location.hash =="#in"){
//        
//        // sessitionStorage 데이터 가져오기
//        getSessionStorage();
//    }else{
    	//화면에 목록 보여준 후 보임 처리
    	$("#asyncSearchItem").show();
//    }
    // 해시태그로 인해 paging이 영향을 받기 때문에 pushstate, replacestate로 url에 파라미터를 붙이고,
    // 페이지 새로 진입 시 해당 파라미터가 있으면 sessionStorage 데이터 가져와 화면 재생성하도록 변경
    if (location.search) {
        var query = location.search.substr(1);
        var result = {};
        query.split("&").forEach(function(part) {
            var item = part.split("=");
            result[item[0]] = decodeURIComponent(item[1]);
        });
        
        if (result.keepState) {
            getSessionStorage();
        }
    }
});

//사이즈 정렬
var orderSizeCodeArr = {};
//대표사이즈 정리 기준표
orderSizeCodeArr["XXXXS"]   = "0000000001";
orderSizeCodeArr["XXXS"]    = "0000000002";
orderSizeCodeArr["XXS"]     = "0000000003";
orderSizeCodeArr["XS"]      = "0000000004";
orderSizeCodeArr["S"]       = "0000000005";
orderSizeCodeArr["M"]       = "0000000006";
orderSizeCodeArr["L"]       = "0000000007";
orderSizeCodeArr["XL"]      = "0000000008";
orderSizeCodeArr["XXL"]     = "0000000009";
orderSizeCodeArr["XXXL"]    = "0000000010";
orderSizeCodeArr["XXXXL"]   = "0000000011";
orderSizeCodeArr["FR"]      = "0000000012";
orderSizeCodeArr["FREE"]    = "0000000013";
orderSizeCodeArr["ETC"]     = "0000000014";
orderSizeCodeArr["00"]      = "0000000015";
orderSizeCodeArr["A0"]      = "0000000016";
orderSizeCodeArr["S/M"]     = "0000000017";
orderSizeCodeArr["M/L"]     = "0000000018";

function asyncCheckPro4pmInfo(data) {
    
    var baseProdCdList = "";
    var resultCount = "";
    
    $.each(data.product, function(key, value){
        if (key == 0) {
            resultCount = value.resultCount;
        }
        
        if (key != 0) {         
            baseProdCdList += value.DOCID;
        }
        if(key != 0 && key != resultCount) {
            baseProdCdList += ",";
        }
        
    });
    
    
    if(baseProdCdList != "" && baseProdCdList != null) {
        $.ajax({
            type : "GET",
            url : "/"+targetLang+"/hssearch/check4pmProdInfo",
            dataType : "json",
            data : {baseProdCd : baseProdCdList},
            async : false,
            error: function(request,status,error){      
                console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            },
            success : function(data) { 

                var listleng = $("input[name=productCd]").length;
                var displayYn = "flase";
                var hsDeliveryYn = false;
                
                for(var i = 0; i < data.length; i++) {
                    for(var j= 1; j < 13; j++)  {
                        var prodCd = $("#productCd"+j).val();
                        
                        var fourpmCategoryYn = true;
                        if(data[i].fourpmCategoryYn == "0"){
                            fourpmCategoryYn = false;
                        }
                        
                        var athomeCategoryYn = true;
                        if(data[i].athomeCategoryYn == "0"){
                            athomeCategoryYn = false;
                        }
                        
                        var quickCategoryYn = true;
                        if(data[i].quickCategoryYn == "0"){
                            quickCategoryYn = false;
                        }
                        
                        if(prodCd == data[i].code) {
//                            console.log(data[i].code + ":" + data[i].available4pm);
                            
                           var siteTemp = "";
                           var styleSizeTemp = data[i].productStyleSizeTemp;
                           var tempSizeCode = styleSizeTemp.split("/");
                           var resultArr = [];
                           for(var k = 0; k < tempSizeCode.length; k++) {
                                var tempTargetCode = tempSizeCode[k];
                                var tempArrTargetSizeCode = tempTargetCode.split(";");
                                if(tempArrTargetSizeCode[0] == $("#item_size"+j).find('div').attr("id")){
                                    siteTemp += '<div id="'+tempArrTargetSizeCode[0]+'" ><span>';
                                }else {
                                    siteTemp += '<div id="'+tempArrTargetSizeCode[0]+'" style="display:none"><span>';
                                }
                                
                                resultArr = orderStyleSize(tempArrTargetSizeCode[1]);
                                siteTemp += resultArr.join('</span><span>')+"</span></div>";
                           }
                            
                           $("#item_size"+j).html(siteTemp);    
                           
//                           if(data[i].reserveYn == "Y") {
//                        	   var targetUrl = $(".search_box_wrap #search").attr("action");
//                        	   var reOrder = "";
//                        	    targetLang = "ko";
//
//                        	    if(targetUrl.indexOf("en") > -1){
//                        	        targetLang = "en";
//                        	    }else if(targetUrl.indexOf("zh") > -1){
//                        	        targetLang = "zh";
//                        	    }
//                        	    
//                        		if(targetLang == "ko") {
//                        			reOrder = "예약판매";
//                        		} else if(targetLang == "en") {
//                        			reOrder = "Advanced order";
//                        		} else if(targetLang == "zh") {
//                        			reOrder = "预购";
//                        		}
//                        		
//                                $("#productCd"+j).parents(".flag").find("span").not(":eq(0)").hide();
//                                $("#productCd"+j).parents(".flag").parents(".item_info2").find("span:eq(1)").prepend("<b>["+reOrder+"] </b> ");
//                                if($("#productCd"+j).parents(".flag").find("span:eq(0)").html().trim() == "SALE") {
//	                                $("#productCd"+j).parents(".flag").find("span:eq(0)").before("<span class='product'>PRE-ORDER</span>");
//                                } else {
//                                	$("#productCd"+j).parents(".flag").find("span:eq(0)").removeClass("hsDelivery1902").addClass("product").html("PRE-ORDER");
//                                }
//                                
//                                $(".ch1904.product").each(function(){
//                                	if($(this).html() == "PRE-ORDER"){
//                                		$(".ch1904.product").show();
//                                	}
//                                });
//                                
//                                continue;
//                            }
                            
                            var chkSoldout = false;
                            if(data[i].available == 0) {
                                $("#productCd"+j).parents(".flag").find("#productCd"+j).after("<span class='flag_typ1' style='color: rgb(255, 0, 0);'>SOLDOUT</span>");
//                                $("#fourpm"+j).css("display", "none");
                                chkSoldout = true;
                            }
                            
                            if(chkSoldout == false) {
                                if(data[i].available4pm == 0) {
//                                    $("#fourpm"+j).css("display", "none");
                                }else if(data[i].available4pm > 0) {
                                    if(data[0].fourPmYn == "true" && fourpmCategoryYn == true){
                                        hsDeliveryYn = true;
//                                        $("#fourpm"+j).html(data[i].timeCheck+'PM');
                                    }else {
//                                        $("#fourpm"+j).css("display", "none");
                                    }
                                }
                                displayYn = "true";
                                
                                if($("#loginState").val() == "loginOn"){
                                    if(athomeCategoryYn == true  && $("#athomeInfo").val() == "ATHOME") { //CATEGORY
                                        if(data[0].athomeYn == "true") {
                                            if(data[i].available4pm > 0) {
                                                try{
                                                    var price = $("#productCd"+j).parents(".item_box").find(".price").html();
                                                    
                                                    var pattern = /[^(0-9)]/gi;   // 숫자이외는 제거
                                                    price = price.replace(pattern,"");
                                                    
                                                    if(Number(price) >= 100000){
                                                        hsDeliveryYn = true;
//                                                        $("#productCd"+j).parents(".item_box").append("<a href=\"javascript:void(0);\" class=\"athome_sticker\" >앳홈</a>");
                                                    }
                                                }catch(e){}
                                            }
                                        }
                                    }
                                    
                                    if(quickCategoryYn == true && data[0].quickTimeCheck == "true") { //quick
                                        if(data[i].available4pm > 0) { //재고
                                            try{
                                                var price = $("#productCd"+j).parents(".item_box").find(".price").html();
                                                
                                                var pattern = /[^(0-9)]/gi;   // 숫자이외는 제거
                                                price = price.replace(pattern,"");
                                                
                                                if(Number(price) >= 100000){
                                                    hsDeliveryYn = true;
                                                }
                                            }catch(e){}
                                        }
                                    }
                                }
                            }
                            
                            if(hsDeliveryYn){
                                //delivery 스티커부착
                                $("#hsDelivery"+j).show();
                                
                            }
                        }
                    }
                }
                
                if(displayYn != "true") {
//                    $(".fourpm").css("display", "none");
                    $(".hsDelivery1902").hide();
                }
            },
            
        });
    }    
}


function setSiteSortList(){
    
    $("#asyncSearchItem .item_size").each(function(){
        var siteTempNewArr = [];
        $(this).find("span").each(function(idx){
            siteTempNewArr[idx] = $(this).html(); 
        });
        
     // 2017-02-23, 이현승, 상품전시리스트 및 상품상세화면에 사이즈표기수정 - 사이즈 정렬 [START] 
        for(var i = 0; i < siteTempNewArr.length; i++) {
            for(var j = i; j < siteTempNewArr.length; j++) {
                var sizeArr = [];
                // 이니시스 결제창과 충돌
                //var aSiteTmpSize = siteTempNewArr[i].trim().toUpperCase();
                //var bSiteTmpSize = siteTempNewArr[j].trim().toUpperCase();
                var aSiteTmpSize = $.trim(siteTempNewArr[i]).toUpperCase();
                var bSiteTmpSize = $.trim(siteTempNewArr[j]).toUpperCase();                
                
                var aSizeSortVal = "";
                var bSizeSortVal = "";
                
                if(orderSizeCodeArr[aSiteTmpSize] == null || orderSizeCodeArr[aSiteTmpSize]==""){
                    var tmpSize = "1";
                    // 이니시스 결제창과 충돌
                    //var sizeStr = siteTempNewArr[i].trim();
                    var sizeStr = $.trim(siteTempNewArr[i]);
                    for(var k=0; k<(9 - sizeStr.length); k++){
                        tmpSize+="0";
                    }
                    aSizeSortVal = tmpSize +  sizeStr;
                } else {
                    aSizeSortVal = orderSizeCodeArr[aSiteTmpSize];
                }
                sizeArr[0] = aSizeSortVal;
                
                if(orderSizeCodeArr[bSiteTmpSize] == null || orderSizeCodeArr[bSiteTmpSize]==""){
                    var tmpSize = "1";
                    // 이니시스 결제창과 충돌
                    //var sizeStr = siteTempNewArr[j].trim();
                    var sizeStr = $.trim(siteTempNewArr[j]);
                    for(var k=0; k<(9 - sizeStr.length); k++){
                        tmpSize+="0";
                    }
                    bSizeSortVal = tmpSize +  sizeStr;
                } else {
                    bSizeSortVal = orderSizeCodeArr[bSiteTmpSize];
                }
                sizeArr[1] = bSizeSortVal;
                
                sizeArr.sort(function(a,b){
                    if(!isNaN(a) && !isNaN(b)){  //숫자 sort
                        return a - b;
                    }
                    
                    //문자 sort
                    var a = a.toString();
                    var b = b.toString();
                    return (a < b) ? -1 : (a == b) ? 0 : 1;
                });
                
                if(aSizeSortVal != sizeArr[0]){
                    var tempSiteTmpSize = aSiteTmpSize;
                    siteTempNewArr[i] = bSiteTmpSize;
                    siteTempNewArr[j] = tempSiteTmpSize;
                }
            }
        }
        
        $(this).find("span").each(function(i){
            $(this).html(siteTempNewArr[i]);
        });
    });
}
//#1240 recopick 추천상품 추가
function goDetailPagebyRecommend(productCode, clickUrl, areakind){
    var locale = document.location.href.split("/")[3];
    var url = "/"+locale+productCode;
    var host = "http://"+ $(location).attr('host') + url +"?type=recommendProd&area="+areakind;
    $.ajax({
        type : "GET",
        url : clickUrl,
        error: function(request,status,error){      
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        },
        success: function(data){      
            console.log(data);
        }
    });
    
    window.location.href= encodeURI(host);
}

function orderStyleSize(tempArrSize){

    var siteTempArr = tempArrSize.split(',');
    var siteTempNewArr = [];
    
    for(var i = 0; i < siteTempArr.length; i++) {
        siteTempNewArr[i] = siteTempArr[i].trim();
    }

    for(var i = 0; i < siteTempNewArr.length; i++) {
        for(var j = i; j < siteTempNewArr.length; j++) {
            var sizeArr = [];
            var aSiteTmpSize = siteTempNewArr[i].trim().toUpperCase();
            var bSiteTmpSize = siteTempNewArr[j].trim().toUpperCase();
            
            var aSizeSortVal = "";
            var bSizeSortVal = "";
            
            if(orderSizeCodeArr[aSiteTmpSize] == null || orderSizeCodeArr[aSiteTmpSize]==""){
                var tmpSize = "1";
                var sizeStr = siteTempNewArr[i].trim();
                for(var k=0; k<(9 - sizeStr.length); k++){
                    tmpSize+="0";
                }
                aSizeSortVal = tmpSize +  sizeStr;
            } else {
                aSizeSortVal = orderSizeCodeArr[aSiteTmpSize];
            }
            sizeArr[0] = aSizeSortVal;
            
            if(orderSizeCodeArr[bSiteTmpSize] == null || orderSizeCodeArr[bSiteTmpSize]==""){
                var tmpSize = "1";
                var sizeStr = siteTempNewArr[j].trim();
                for(var k=0; k<(9 - sizeStr.length); k++){
                    tmpSize+="0";
                }
                bSizeSortVal = tmpSize +  sizeStr;
            } else {
                bSizeSortVal = orderSizeCodeArr[bSiteTmpSize];
            }
            sizeArr[1] = bSizeSortVal;
            
            //문자, 숫자 분리
            sizeArr.sort(function(a,b){
                if(!isNaN(a) && !isNaN(b)){  //숫자 sort
                    return a - b;
                }
                
                //문자 sort
                var a = a.toString();
                var b = b.toString();
                return (a < b) ? -1 : (a == b) ? 0 : 1;
            });
            
            if(aSizeSortVal != sizeArr[0]){
                var tempSiteTmpSize = aSiteTmpSize;
                siteTempNewArr[i] = bSiteTmpSize;
                siteTempNewArr[j] = tempSiteTmpSize;
            }
        }
    }
   return siteTempNewArr;
}