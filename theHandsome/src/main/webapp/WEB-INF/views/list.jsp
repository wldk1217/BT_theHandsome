<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="./includes/header.jsp"%>
  <!-- 
  /* 작성자 : 고정민, 변민혁, 문혁
 * 상품 리스트 페이지. 
 */
   -->
<body oncontextmenu="return false">

	<script type="text/javascript">
//<![CDATA[ 
var categoryListList = "";
var orderSizeCodeArr = {};
var imageUrl = "";
var criteoProductCode1 = "";
var criteoProductCode2 = "";
var criteoProductCode3 = "";
var hashFirstCheck = false;
var checkTime = "";
var checkQuickTime = false;
var hsDeliveryYn = false;

var currecy = ""; // USD, CNY
var rate = ""; // 환율
var simbol = ""; // 심볼
$(document).ready(function(){
	
	console.log("log");
	console.log("${colorMap}");
	
    var reviewYn = "Y";
    
    if(reviewYn == "N"){
        $(".sortby .list ul li:eq(4)").hide();
    }
    
    var chkAthome  = "";

        
        if(chkAthome  == "ATHOME") {
//             $(".athome_filter").show();
            hsDeliveryYn = true;
        }else {
//             $(".athome_filter").hide();
        }
        
        if(hsDeliveryYn == true){
           $(".delivery").show();
        }else {
            $(".delivery").hide();
        }
    
    
    if(!Array.indexOf){ //IE8 이하버전
        Array.prototype.indexOf = function(obj){
            for(var i=0; i<this.length; i++){
                if(this[i]==obj){
                    return i;
                }
            }
            return -1;
        }
    }
       
    $(document).on("click",".prev",function(){
    	GA_Event('카테고리_리스트','페이지','PREV');
    });
    $(document).on("click",".prev2",function(){
    	GA_Event('카테고리_리스트','페이지','PREV2');
    });
    $(document).on("click",".pageBtn",function(){
    	GA_Event('카테고리_리스트','페이지',categoryListList.PARAMS.pageNum);
    });
    $(document).on("click",".next",function(){
    	GA_Event('카테고리_리스트','페이지','NEXT');
    });
    $(document).on("click",".next2",function(){
    	GA_Event('카테고리_리스트','페이지','NEXT2');
    });
    
    $(document).on("click","a",function(){
        if(document.location.hash.length < 10){
            setHashInfo(categoryListList.PARAMS.pageNum);   
        }
    });

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

    
    if("" != "") {
        setProductOrderCode("", '판매순');
    }
    
    categoryListList = new BoardListController('categoryListForm', '#listBody', '.paging', 12); //폼아이디, 리스트공간 셀렉터, 페이징공간 셀렉터, 페이지당 리스트개수
    
    categoryListList.doWork();
    
    categoryListList.setRowHtml = function(results){
        var rows = "";

        if(results.length <= 0 || results==null){
            resultLayout_none();
        }else{
            resultLayout_Exist();
        }

        $.each(results, function(index){
            var temp = "";
            var siteTemp = "";
            var productFlagTemp = "";
            var productBaseCode = this.productBaseCode;
            var productStyleCode = this.productStyleCode;
            if(results.length > 0) {
                window.sessionStorage.setItem('normal_cate_ecommerceDataList', JSON.stringify(results));
            }
            
                if(this.productStyleSizeTemp != undefined) {
                    var styleSizeTemp = this.productStyleSizeTemp;
                    var siteTempStyleNewArr = [];
                    
                    if(!Object.keys) {//IE8 이하
                        var keyLength = [];
                        for(var key in this.productStyleSizeTemp) {
                            keyLength.push(key);
                        }
                        if(keyLength.length > 0) {
                            var keyLength = keyLength.length;
                            $.each(this.productStyleSizeTemp, function(key, value){
                                $.each(this.productStyleSizeTemp, function(key, value){
                                    
                                    if(productStyleCode == key){
                                        siteTemp += '<div id="'+key+'" > <span>';
                                    }else {
                                        siteTemp += '<div id="'+key+'" style="display:none"> <span>';
                                    }

                                    if(value != undefined) {
                                        
                                        var siteTempArr = value[0].split(',');
                                        
                                        var siteTempNewArr = [];

                                        for(var i = siteTempArr.length-1, j = 0; i >= 0; i--, j++) {
                                            siteTempNewArr[j] = siteTempArr[i].trim();
                                        }
                                        
                                        siteTempNewArr = siteTempNewArr.reduce(function(a,b){if(a.indexOf(b)<0)a.push(b);return a;},[]);

                                        // 2017-02-23, 이현승, 상품전시리스트 및 상품상세화면에 사이즈표기수정 - 사이즈 정렬 [START] 
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
                                        // 2017-02-23, 이현승, 상품전시리스트 및 상품상세화면에 사이즈표기수정 - 사이즈 정렬 [END]
                                        
                                       siteTemp += siteTempNewArr.join('</span><span>')+"</span></div>";
                                        
                                    }
                                });                       
                            });
                        }
                    } else { // 그 이외
                        if(Object.keys(this.productStyleSizeTemp).length > 0) {
                            var keyLength = Object.keys(this.productStyleSizeTemp).length;
                            $.each(this.productStyleSizeTemp, function(key, value){
                                
                                if(productStyleCode == key){
                                    siteTemp += '<div id="'+key+'" > <span>';
                                }else {
                                    siteTemp += '<div id="'+key+'" style="display:none"> <span>';
                                }

                                if(value != undefined) {
                                    
                                    var siteTempArr = value[0].split(',');
                                    
                                    var siteTempNewArr = [];

                                    for(var i = siteTempArr.length-1, j = 0; i >= 0; i--, j++) {
                                        siteTempNewArr[j] = siteTempArr[i].trim();
                                    }
                                    
                                    siteTempNewArr = siteTempNewArr.reduce(function(a,b){if(a.indexOf(b)<0)a.push(b);return a;},[]);

                                    // 2017-02-23, 이현승, 상품전시리스트 및 상품상세화면에 사이즈표기수정 - 사이즈 정렬 [START] 
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
                                    // 2017-02-23, 이현승, 상품전시리스트 및 상품상세화면에 사이즈표기수정 - 사이즈 정렬 [END]
                                    
                                   siteTemp += siteTempNewArr.join('</span><span>')+"</span></div>";
                                    
                                }
                            });
                        }                   
                    }
                    
                    
                        
                }    
            

            if(this.productFlag != undefined) {
                var productFlagTemp = this.productFlag.split(',');
            }
            
            if(imageUrl == "" && "http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img3.jpg" != this.productImageUrl1) {
                imageUrl = this.productImageUrl1.substring(0, this.productImageUrl1.lastIndexOf("/"));
                
                if(imageUrl.indexOf("newmedia") > -1){
                    imageUrl = "http://media.thehandsome.com";
                }
            }
            
            if(this.productImageUrl1.indexOf(this.productStyleCode) < 0){
                if(this.productImageUrl1 != null && this.productImageUrl1 != ""){
                    var tempArrCode = this.productImageUrl1.split("/");
                    if(tempArrCode.length > 1){
                        var tempTargetCode = tempArrCode[tempArrCode.length-1];
                        var tempArrTargetCode = tempTargetCode.split("_");
                        this.productStyleCode = tempArrTargetCode[0]+"_"+tempArrTargetCode[1];  
                    }
                }
            }
            
            var gaProductFunction = "";
            
            if("" != "OU") {
                var target_url  = document.location.href;
                if(target_url.indexOf("/c/ou_") == -1){ //아울렛이 아니면
                    if(target_url.indexOf("/c/") > -1){ //정상상품 리스트
	                    // if'/c/카테고리코드' : /가 한개면
	                    if(target_url.substring(target_url.indexOf("/c/")+3).indexOf("/") > -1){
	                        if(target_url.toLowerCase().substring(target_url.indexOf("/c/")+3).indexOf("br") > -1){
	                            gaProductFunction = "onclick=\"setEcommerceData('"+index+"', 'BRAND');\"";
	                        }else{
	                            gaProductFunction = "onclick=\"setEcommerceData('"+index+"', 'CATEGORY');\"";
	                        }
	                    }else{
	                        gaProductFunction = "onclick=\"setEcommerceData('"+index+"', 'CATEGORY');\"";
	                    }
                    }
                }
            }
            
            var listTag = "<li> \n";
            listTag += "    <div class=\"item_box\"> \n";
            listTag += "        <a href=\"/ko/p/"+ this.productStyleCode +"?categoryCode=we011\" class=\"item_info1\" "+gaProductFunction+"> \n";
            //listTag += "     <a href=\"/ko/p/"+ this.productStyleCode +"\" class=\"item_info1\"> \n";
            listTag += "            <span class=\"item_img\"> \n";
            listTag += "                <img src=\"" + this.productImageUrl1 + "\" id=\"T01_IMG_"+index+"\" alt=\"" + this.productName + "\" targetCode=\""+this.productStyleCode+"\" class=\"respon_image\" onerror=\"this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img3.jpg'\"/> \n";
            listTag += "                <img src=\"" + this.productImageUrl2 + "\" id=\"T02_IMG_"+index+"\"alt=\"" + this.productName + "\" targetCode=\""+this.productStyleCode+"\" class=\"respon_image on\" onerror=\"this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img3.jpg'\"/> \n";
            listTag += "                <input type='hidden' id='newImage1_"+index+"' value='"+ this.productImageUrl1 +"'/>";
            listTag += "                <input type='hidden' id='newImage2_"+index+"' value='"+ this.productImageUrl2 +"'/>";
            
            if(this.videoMarkYn == true) {
                listTag += "<img src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/img_video.png' class='img-video'>";
            }
            
            
            listTag += "            </span> \n";
            
            // 핏가이드 아이콘 추가 20220215
            
            if(this.fitGuideDisplayYn == true){
                listTag += "<span class='ico_fitguide'>핏가이드</span>";
            }
            
            
            listTag += "            <span class=\"item_size\" id='itemsize_"+index+"'> \n";
            listTag += "                " + siteTemp + " \n";
//             listTag += "                " + "<span>"+siteTemp + " \n";
            listTag += "            </span> \n";
            listTag += "        </a> \n";
            listTag += "        <a href=\"/ko/p/"+ this.productStyleCode +"?categoryCode=we011\" class=\"item_info2\" "+gaProductFunction+"> \n";
            //listTag += "     <a href=\"/ko/p/"+ this.productStyleCode +"\" class=\"item_info2\"> \n";
            listTag += "            <span class=\"brand\">" + this.productBrandName + "</span> \n";
            
//             if(this.productReserveSaleYn){
//                 listTag += "            <span class=\"title\"><b>[예약판매]</b> "+this.productName+"</span> \n";
//             } else {
                listTag += "            <span class=\"title\">" + this.productName + "</span> \n";
//             }
            
            var productNormalityPrice = "";
            var chkSaleYn = false;
            
            if("" != "OU") {
            	if(productFlagTemp.indexOf("SALE") > -1) {
                    if(Number(this.productNormalityPrice) > Number(this.productPrice)) {
                        chkSaleYn = true;
                        var productSalePerCent = getDecimalToString(((this.productNormalityPrice - this.productPrice) / this.productNormalityPrice * 100), 1, 1);
                    	var productNormalityPriceTag  = "<del class=\"del_price_201029\">￦" + addComma(this.productNormalityPrice) + "</del>";
                    	var productSalePerCentTag = "<span class=\"discount_rate_201029\">" + productSalePerCent + "%</span>";
                    }
                }
            	
            	var productPriceTag = "<span "+(productFlagTemp.indexOf("SALE") > -1 && chkSaleYn ? "class=\"ou_price\"" : "") + ">￦" +  addComma(this.productPrice) + "</span>";
                
                listTag += "            <span class=\"price\"><span id=\"price_"+this.productStyleCode +"\">"+ productPriceTag + (productFlagTemp.indexOf("SALE") > -1 && chkSaleYn ? productNormalityPriceTag +  productSalePerCentTag : "") +"</span></span> \n";
            } else if("" == "OU") {

                //기획상품이 아니면 세일가 적용
                if(this.productSaleDisplayYn == true) {
                    if(Number(this.productNormalityPrice) > Number(this.productPrice)) {
                    	var productSalePerCent = getDecimalToString(((this.productNormalityPrice - this.productPrice) / this.productNormalityPrice * 100), 1, 1);
                        var productOuPriceTag = "<span class=\"ou_price\">￦" +  addComma(this.productPrice) + "</span>";
                    	var productNormalityPriceTag  = "<del class=\"del_price_201029\">￦" + addComma(this.productNormalityPrice) + "</del>";
                    	var productSalePerCentTag = "<span class=\"discount_rate_201029\">" + productSalePerCent + "%</span>";
                        
                        listTag += "            <span class=\"price\"><span id=\"price_"+this.productStyleCode +"\">"+ productOuPriceTag + productNormalityPriceTag +  productSalePerCentTag +"</span></span> \n";
                    } else {
                        listTag += "            <span class=\"price\"> <span id=\"price_"+this.productStyleCode+"\"><span>￦" + addComma(this.productPrice) + "</span></span></span> \n";    
                    }
                } else {
                    listTag += "            <span class=\"price\"> <span id=\"price_"+this.productStyleCode+"\"><span>￦" + addComma(this.productPrice) + "</span></span></span> \n";
                }
            }
            

            listTag += "            <span class=\"flag\"> \n";
            
            if(this.productAvailableYn == 0) {
                listTag += "                <span class=\"soldout\">SOLDOUT</span> \n";
            } else if (this.productAvailableYn == 1) {
                var fourPmYn = "false";
                var quickYn = "false";
                if(this.available4pmSum >= 1) {   //4pm
                    fourPmYn = "true";
                }
                if(this.availableQuick >= 1) {   //퀵배송
                    quickYn = "true";
                }
                

                // 상품스티커문구 있을 경우 productSticker 노출 X (상품스티커문구 존재시 노출 우선) 20200708 추가
                var stickerTextYN = false;
                
                if(this.stickerTextUseYn == true){
                    listTag += "                <span class=\"point-mark\" style=\"background-color:#"+this.stickerTextInfo.stickerColor+";color: white;\">"+this.stickerTextInfo.stickerText+"</span> \n";
                    stickerTextYN = true;
                }
                
                
                for(var i = 0; i < productFlagTemp.length; i++) {
                    var classTemp = "";
                    var wishlistClass = "";
                    var wishlistAdd = "";
                    var skipFlag = false; // stickerTextYN == true 이면서 productSticker 있을 경우 true
                    
                    if (i == 0) {
                        classTemp = "product";
                        
                        // 상품스티커문구 있을 경우 productSticker 존재 여부 체크 20200709추가
                        if(stickerTextYN == true){
                            if(productFlagTemp[0] !== "SALE"){
                                skipFlag = true;
                            }// else skipFlag = false;
                        }
                        
                    } else if (i == 1) {
                        classTemp = "price";
                    }
                    if (productFlagTemp[i] === "SALE") {
                        classTemp += " flag_typ2";
                    }
                    
                    if(productFlagTemp[0] != "" || hsDeliveryYn != "true") {
                        
                        if(!skipFlag){
                            listTag += "                <span class=\""+classTemp+"\">"+productFlagTemp[i].replace("RE_ORDER","재입고")+"</span> \n";
                        }
                        
                    }
                }
                
                if(!this.productReserveSaleYn) {//예약상품이 아닐 경우
                    if((this.available4pmSum >= 1 && checkTime != "") || (quickYn == "true" && checkQuickTime == true) || (chkAthome == "ATHOME" && this.availableAtHome >= 1)) {
                        listTag += " <span class=\"hsDelivery1902 ch1904\">한섬딜리버리</span>\n";
                    }
                    /* if( this.available4pmSum >= 1 && checkTime != "") {   //4pm
                        listTag += "                <span class=\"fourpm\">"+checkTime+"PM</span> \n";
                    } 
                    if(quickYn == "true") {   //퀵배송
                        if($("#checkQuick").parents("li").css("display") != "none"){
                            listTag += "                <span class=\"stk_quick_deliv stk\">퀵배송</span> \n";
                        }
                    }*/
                }
                if(this.productReviewCount != "0" && this.productReviewCount != null) {
                    
                    listTag += " <span class=\"review1902 ch1904\">"+this.productReviewCount+"</span>\n";
                    
                }
            }

            listTag += "            </span> \n";
            listTag += "        </a> \n";
            
            if(!Object.keys) {//IE8 이하
                var keyLength = [];
                for(var key in this.productColorTemp) {
                    keyLength.push(key);
                }
                if(keyLength.length > 0) {
                    var keyLength = keyLength.length;
                    var colorChipImg = "";
                    listTag += "<div class=\"color_more_wrap\"> \n";
                    $.each(this.productColorTemp, function(key, value){
                    	var colorChipArr = value.split(";");
                    	if(colorChipArr[1] != null && colorChipArr[1].indexOf("C01") > -1) {
                    		colorChipImg = "background:"+colorChipArr[0]+" url('"+colorChipArr[1]+"/dims/resize/13x14')";
                    	} else {
                    		colorChipImg = "background:"+colorChipArr[0];
                    	}
                    	
                        if(keyLength > 1) {
                            listTag += "    <a href=\"javascript:chgColorChip("+index+", '"+key+"')\" class=\"cl wt\" style=\""+colorChipImg+";\" onclick=\"GA_Event('카테고리_리스트','컬러칩','"+key.split('_')[1]+"')\" ></a> \n";
                        } else if (keyLength == 1) {
                            listTag += "    <a href=\"javascript:void(0);\" class=\"cl wt\" style=\""+colorChipImg+";\" onclick=\"GA_Event('카테고리_리스트','컬러칩','"+key.split('_')[1]+"')\"></a> \n";
                        }
                        
                    });
                    listTag += "</div> \n";
                }
            } else { // 그 이외
                if(Object.keys(this.productColorTemp).length > 0) {
                    var keyLength = Object.keys(this.productColorTemp).length;
                    var colorChipImg = "";
                    listTag += "<div class=\"color_more_wrap\"> \n";
                    $.each(this.productColorTemp, function(key, value){
                    	var colorChipArr = value[0].split(";");
                    	if(colorChipArr[1] != null && colorChipArr[1].indexOf("C01") > -1) {
                    		colorChipImg = "background:"+colorChipArr[0]+" url('"+colorChipArr[1]+"/dims/resize/13x14')";
                    	} else {
                    		colorChipImg = "background:"+colorChipArr[0];
                    	}
                        if(keyLength > 1) {
                            listTag += "    <a href=\"javascript:chgColorChip("+index+", '"+key+"')\" class=\"cl wt\" style=\""+colorChipImg+";\" onclick=\"GA_Event('카테고리_리스트','컬러칩','"+key.split('_')[1]+"')\" ></a> \n";
                        } else if (keyLength == 1) {
                            listTag += "    <a href=\"javascript:void(0);\" class=\"cl wt\" style=\""+colorChipImg+";\" onclick=\"GA_Event('카테고리_리스트','컬러칩','"+key.split('_')[1]+"')\"></a> \n";
                        }
                        
                    });
                    listTag += "</div> \n";
                }                   
            }
            
            if(this.productWishlist != 0) {
                wishlistClass = "on";
                wishlistAdd = "javascript:addWishListClick('"+ this.productBaseCode +"');";
            } else {
                wishlistClass = "";
                wishlistAdd = "javascript:addWishListClick('"+ this.productBaseCode +"');";
            }
            listTag += "     <a href=\"" + wishlistAdd + "\" class=\"add_wishlist " + wishlistClass + "\" id=\"wish_"+this.productBaseCode+"\" onclick=\"GA_Category('wish', $(this));brazeLogCustomEvent('"+index+"');\" data-value='"+ this.productStyleCode +"'>위시리스트 담기</a> \n";
            
            /* if(chkAthome == "ATHOME" && this.availableAtHome >= 1) {
                listTag += "        <a href=\"javascript:void(0);\" class=\"athome_sticker\" >앳홈</a> \n";
            } */
            listTag += "    </div> \n";
            listTag += "</li> \n";
                
            rows += listTag;
            
            if(index == 0) {
                criteoProductCode1 = this.productBaseCode;
            } else if(index == 1) {
                criteoProductCode2 = this.productBaseCode;
            } else if(index == 2) {
                criteoProductCode3 = this.productBaseCode;
            }
        });
        
         
        var criteoTag = "";
        criteoTag += "<script type=\"text/javascript\">";
        criteoTag += "window.criteo_q = window.criteo_q || [];";
        criteoTag += "window.criteo_q.push(";
        criteoTag += "{ event: \"setAccount\", account: 24596 },";
        
        criteoTag += "{ event: \"setSiteType\", type: \"d\" },";
        //criteoTag += "{ event: \"viewList\", item: [\""+criteoProductCode1+"\",\""+criteoProductCode2+"\",\""+criteoProductCode3+"\"], requiresDOM: \"yes\" }";
        criteoTag += "{ event: \"viewList\", item: [\""+criteoProductCode1+"\",\""+criteoProductCode2+"\",\""+criteoProductCode3+"\"]}";
        criteoTag += ");";
        criteoTag += "<\/script>";
        $("#criteoVariable").html(criteoTag);
        
        return rows;
    };
    
    //타일 이벤트 시작 
    categoryListList.afterSetAction = function(){

        var $item_boxs = $(".items_list .item_box .item_info1");
        $(".items_list .item_info1 .item_size").hide();
        $item_boxs.on( 'mouseenter', function(){
            active( this );
        });
        $item_boxs.on( 'mouseleave', function(){
            deactive( this );
        });

        //리스트 4개일때(예외 - 카테고리 리스트)
        var cate_item4 = $('.cate_item4 > ul > li').length;
        $('.cate_item4 > ul > li').each(function(cate_item4){
            if((cate_item4%4) == 0){
                $('.cate_item4 > ul > li:nth-child('+(cate_item4+4)+')').addClass('mr1m');
            }
        });

        //이미지가 1px이라도 어긋나면 밀리는 현상 방지용
        $(".cate_item4 .mr1m").next("li").css("clear","both");

        //전체 상품수 세팅
        $(".num").html(this.PARAMS.resourceObjectData.pagination.totalNumberOfResults);

        //페이지 세팅 정보 기억 - HASH : page_색상_사이즈_가격_정렬순_상품갯수
        setHashInfo(this.PARAMS.pageNum);
        
        //에러 이미지 재 조정
        var checkImageUrl1 = "";
        var checkImageUrl2 = "";
        $(".item_box img").on("error",function(){
           var image = "http://media.thehandsome.com/"+$(this).attr("targetCode") +"_"+ $(this).attr("id").split("_")[0]+".jpg";
           if(checkImageUrl1 == $(this).attr("targetCode")){
               if(checkImageUrl2 == $(this).attr("targetCode")){
                   $(this).attr("src","http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img3.jpg");
                   checkImageUrl1 = "";
                   checkImageUrl2 = "";
               }else{
                    $(this).attr("src",image);
                    checkImageUrl2 = $(this).attr("targetCode");
               }
            }else{
                $(this).attr("src",image);
                checkImageUrl1 = $(this).attr("targetCode");
            }
        });
    }
    
    function active( item ){
        var $item_box = $( item );
        $item_box.find('.item_size').stop().slideDown('fast');
        $item_box.find('.item_img .on').stop().fadeIn('fast');
    }
    function deactive( item ){
        var $item_box = $( item );
        $item_box.find('.item_size').stop().slideUp('fast');
        $item_box.find('.item_img .on').stop().fadeOut('fast');
    }

    function resultLayout_none(){
        $('#searchResult_None').css("display", "block");
        $('.paging').css("display", "none");
        $('#listContent').css("display", "none");
    }
    function resultLayout_Exist(){
        $('#searchResult_None').css("display", "none");
        $('.paging').css("display", "block");
        $('#listContent').css("display", "block");
    }
    
    
    
});


function setRepProdColorCode( colorCode ){
    $("#repProdColorCode").val(colorCode);
    color = $("#category_color_chip > li > .on").text()
    
    $('#colorCurrent').remove(); 
    $('<span class="current" id="colorCurrent" title="' + color + '">' + color + '</span>').insertBefore('.color > .select > .ico_arr');
}

function setRepSizeEnumCode( sizeCode ){
    $("#repSizeEnumCode").val(sizeCode);
    
    size = $("#category_size_chip > li > .on").text();
    $('#sizeCurrent').remove(); 
    $('<span class="current" id="sizeCurrent" title="' + size + '">' + size + '</span>').insertBefore('.size > .select > .ico_arr');
}

function setPriceOrderCode(o,  priceCode ){
    $('.filterWrap .price input:checkbox').prop('checked',false);
    $('#'+o.id).prop('checked',true);
    $("#priceOrderCode").val(priceCode);
    
    price = $("#lable_ck"+priceCode).text();
    $('#priceCurrent').remove(); 
    $('<span class="current" id="priceCurrent" title="' + price + '">' + price + '</span>').insertBefore('.price > .select > .ico_arr');
}

function setProductOrderCode( productCode, displayName ){
    $("#productOrderCode").val(productCode);
    $(".sortby > .select > .current").html(displayName);
}
function reset() {
    $("#check4pmCode").val("");
    $("#checkAtHomeCode").val("");
    $("#checkSaleCode").val("");
    $("#checkDeliveryCode").val("");
    
    $('input:checkbox').prop('checked',false);
    $("#repProdColorCode").val("");
    
    $("#category_color_chip > li").each(function(index){
        $(this).children("a").removeClass("on");
    });

    $("#category_size_chip > li").each(function(index){
        $(this).children("a").removeClass("on");
    });
    
    $("#repSizeEnumCode").val("");
    $("#priceOrderCode").val("");
    $("#productOrderCode").val("NEW");
    $(".current").html('신상품');
    $("#brandCode").val("");
    
    $('#colorCurrent').remove(); 
    $('#sizeCurrent').remove(); 
    $('#priceCurrent').remove(); 
    $('#brandCurrent').remove(); 
    
    gubunSearch(1);
}
//]]>
</script>
	<!-- bodyWrap -->
	<div id="bodyWrap" class="products">
		<!--title-->
		<!-- #1141 - 카테고리 개편(카테고리/브랜드 Navigation) -->
		<h3 class="cnts_title ou1804">
			<span>
				<!-- 정상 브랜드 카테고리 목록 --> <a href="/list/${clarge}/${cmedium}/${csmall}"
				onclick="GA_Event('카테고리_리스트','카테고리','여성')"> ${(clarge=="MEN")?"남성":"여성"}</a> <img
				src="http://cdn.thehandsome.com/_ui/desktop/common/images/products/ou_location_arr.png"
				alt="location arr"> <a href="/ko/c/WE01/"
				onclick="GA_Event('카테고리_리스트','카테고리','탑')"> 탑</a> <img
				src="http://cdn.thehandsome.com/_ui/desktop/common/images/products/ou_location_arr.png"
				alt="location arr"> <a href="javascript:void(0);"
				onclick="GA_Event('카테고리_리스트','카테고리','티셔츠')"> 티셔츠</a>
			</span>
		</h3>
		<!--  카테고리 개편 아울렛 -->
		<!--//title-->
		<div class="adaptive_wrap">

			<form id="categoryListForm" action="/ko/c/categoryList">
				<input type="hidden" id="brandCode" name="brandCode" value="">
				<input type="hidden" id="brandName" name="brandName" value="">
				<input type="hidden" id="subBrand" name="subBrand" value="">
				<input type="hidden" name="categoryCode" value="we011"> <input
					type="hidden" id="genderCategoryCode" name="genderCategoryCode"
					value=""> <input type="hidden" id="mainCateFlag"
					name="mainCateFlag" value=""> <input type="hidden"
					id="repProdColorCode" name="repProdColorCode" value=""> <input
					type="hidden" id="repSizeEnumCode" name="repSizeEnumCode" value="">
				<input type="hidden" id="priceOrderCode" name="priceOrderCode"
					value=""> <input type="hidden" id="productOrderCode"
					name="productOrderCode" value="NEW"> <input type="hidden"
					id="check4pmCode" name="check4pmCode" value=""> <input
					type="hidden" id="checkAtHomeCode" name="checkAtHomeCode" value="">
				<input type="hidden" id="checkSaleCode" name="checkSaleCode"
					value=""> <input type="hidden" id="checkQuickCode"
					name="checkQuickCode" value=""> <input type="hidden"
					id="checkDeliveryCode" name="checkDeliveryCode" value="">
				<!-- 뒤로가기 버튼 클릭시 페이징 기억용 -->
				<input type="hidden" id="rememberPage" name="rememberPage" value="">
				<input type="hidden" id="FKD-001_015" value="컬러 더보기">
				<!-- 컬러 더보기 -->

				<!-- sort wrap -->
				<div class="filterWrap hsDelivery1902">
					<ul class="clearfix float_left">
						<!-- 정상용 브랜드 검색 -->
						<li class="brand"><a href="javascript:void(0);"
							class="select" onclick="GA_Event('카테고리_리스트','정렬','브랜드');">브랜드<span
								class="ico_arr">arrow</span></a>
							<div class="list" style="display: none;">
								<ul id="category_brand_chip">
									<li><input type="checkbox" id="brand_ck1"
										onclick="GA_Event('카테고리_리스트','정렬','TIME');setOnlineShopBrand(this, 'BR01');"><label
										for="brand_ck1" id="BR01">TIME</label></li>
									<li><input type="checkbox" id="brand_ck2"
										onclick="GA_Event('카테고리_리스트','정렬','MINE');setOnlineShopBrand(this, 'BR02');"><label
										for="brand_ck2" id="BR02">MINE</label></li>
									<li><input type="checkbox" id="brand_ck3"
										onclick="GA_Event('카테고리_리스트','정렬','LANVIN COLLECTION');setOnlineShopBrand(this, 'BR19');"><label
										for="brand_ck3" id="BR19">LANVIN COLLECTION</label></li>
									<li><input type="checkbox" id="brand_ck4"
										onclick="GA_Event('카테고리_리스트','정렬','SYSTEM');setOnlineShopBrand(this, 'BR03');"><label
										for="brand_ck4" id="BR03">SYSTEM</label></li>
									<li><input type="checkbox" id="brand_ck5"
										onclick="GA_Event('카테고리_리스트','정렬','SJSJ');setOnlineShopBrand(this, 'BR04');"><label
										for="brand_ck5" id="BR04">SJSJ</label></li>
									<li><input type="checkbox" id="brand_ck6"
										onclick="GA_Event('카테고리_리스트','정렬','TIME HOMME');setOnlineShopBrand(this, 'BR06');"><label
										for="brand_ck6" id="BR06">TIME HOMME</label></li>
									<li><input type="checkbox" id="brand_ck7"
										onclick="GA_Event('카테고리_리스트','정렬','SYSTEM HOMME');setOnlineShopBrand(this, 'BR07');"><label
										for="brand_ck7" id="BR07">SYSTEM HOMME</label></li>
									<li><input type="checkbox" id="brand_ck8"
										onclick="GA_Event('카테고리_리스트','정렬','the CASHMERE');setOnlineShopBrand(this, 'BR08');"><label
										for="brand_ck8" id="BR08">the CASHMERE</label></li>
									<li><input type="checkbox" id="brand_ck9"
										onclick="GA_Event('카테고리_리스트','정렬','LÄTT');setOnlineShopBrand(this, 'BR31');"><label
										for="brand_ck9" id="BR31">LÄTT</label></li>
									<li><input type="checkbox" id="brand_ck10"
										onclick="GA_Event('카테고리_리스트','정렬','OBZEE');setOnlineShopBrand(this, 'BR43');"><label
										for="brand_ck10" id="BR43">OBZEE</label></li>
									<li><input type="checkbox" id="brand_ck11"
										onclick="GA_Event('카테고리_리스트','정렬','O&amp;#039;2nd');setOnlineShopBrand(this, 'BR45');"><label
										for="brand_ck11" id="BR45">O'2nd</label></li>
									<li><input type="checkbox" id="brand_ck12"
										onclick="GA_Event('카테고리_리스트','정렬','CLUB MONACO');setOnlineShopBrand(this, 'BR44');"><label
										for="brand_ck12" id="BR44">CLUB MONACO</label></li>
									<li><input type="checkbox" id="brand_ck13"
										onclick="GA_Event('카테고리_리스트','정렬','oera');setOnlineShopBrand(this, 'BR61');"><label
										for="brand_ck13" id="BR61">oera</label></li>
									<li><input type="checkbox" id="brand_ck14"
										onclick="GA_Event('카테고리_리스트','정렬','BALLY');setOnlineShopBrand(this, 'BR21');"><label
										for="brand_ck14" id="BR21">BALLY</label></li>
									<li><input type="checkbox" id="brand_ck15"
										onclick="GA_Event('카테고리_리스트','정렬','LANVIN PARIS');setOnlineShopBrand(this, 'BR20');"><label
										for="brand_ck15" id="BR20">LANVIN PARIS</label></li>
									<li><input type="checkbox" id="brand_ck16"
										onclick="GA_Event('카테고리_리스트','정렬','3.1 Phillip Lim');setOnlineShopBrand(this, 'BR41');"><label
										for="brand_ck16" id="BR41">3.1 Phillip Lim</label></li>
									<li><input type="checkbox" id="brand_ck17"
										onclick="GA_Event('카테고리_리스트','정렬','ROCHAS');setOnlineShopBrand(this, 'BR37');"><label
										for="brand_ck17" id="BR37">ROCHAS</label></li>
									<li><input type="checkbox" id="brand_ck18"
										onclick="GA_Event('카테고리_리스트','정렬','TOM GREYHOUND');setOnlineShopBrand(this, 'BR15');"><label
										for="brand_ck18" id="BR15">TOM GREYHOUND</label></li>
									<li><input type="checkbox" id="brand_ck19"
										onclick="GA_Event('카테고리_리스트','정렬','FOURM THE STORE');setOnlineShopBrand(this, 'BR35');"><label
										for="brand_ck19" id="BR35">FOURM THE STORE</label></li>
									<li><input type="checkbox" id="brand_ck20"
										onclick="GA_Event('카테고리_리스트','정렬','FOURM STUDIO');setOnlineShopBrand(this, 'BR30');"><label
										for="brand_ck20" id="BR30">FOURM STUDIO</label></li>
									<li><input type="checkbox" id="brand_ck21"
										onclick="GA_Event('카테고리_리스트','정렬','FOURM MEN&amp;#039;S LOUNGE');setOnlineShopBrand(this, 'BR32');"><label
										for="brand_ck21" id="BR32">FOURM MEN'S LOUNGE</label></li>
									<li><input type="checkbox" id="brand_ck22"
										onclick="GA_Event('카테고리_리스트','정렬','MUE');setOnlineShopBrand(this, 'BR16');"><label
										for="brand_ck22" id="BR16">MUE</label></li>
									<li><input type="checkbox" id="brand_ck23"
										onclick="GA_Event('카테고리_리스트','정렬','H : SCENE');setOnlineShopBrand(this, 'BR47');"><label
										for="brand_ck23" id="BR47">H : SCENE</label></li>
									<li><input type="checkbox" id="brand_ck24"
										onclick="GA_Event('카테고리_리스트','정렬','Liquides Perfume Bar');setOnlineShopBrand(this, 'BR62');"><label
										for="brand_ck24" id="BR62">Liquides Perfume Bar</label></li>
								</ul>
							</div></li>
						<li class="color"><a href="#" class="select"
							onclick="GA_Event('카테고리_리스트','정렬','색상');">색상<span
								class="ico_arr">arrow</span></a>
							<div class="list list_item4" style="display: none;">
								<ul class="color_chip clearfix" id="category_color_chip">
									<li><a href="javascript:setRepProdColorCode('BEIGE')"
										style="background: #fae7c4;"
										onclick="GA_Event('카테고리_리스트','정렬','BEIGE');">BEIGE</a></li>
									<li><a href="javascript:setRepProdColorCode('BLACK')"
										style="background: #000000;"
										onclick="GA_Event('카테고리_리스트','정렬','BLACK');">BLACK</a></li>
									<li><a href="javascript:setRepProdColorCode('BLUE')"
										style="background: #0f45bc;"
										onclick="GA_Event('카테고리_리스트','정렬','BLUE');">BLUE</a></li>
									<li class="mr0"><a
										href="javascript:setRepProdColorCode('BROWN')"
										style="background: #673915;"
										onclick="GA_Event('카테고리_리스트','정렬','BROWN');">BROWN</a></li>
									<li><a href="javascript:setRepProdColorCode('BURGUNDY')"
										style="background: #741313;"
										onclick="GA_Event('카테고리_리스트','정렬','BURGUNDY');">BURGUNDY</a></li>
									<li><a href="javascript:setRepProdColorCode('CAMEL')"
										style="background: #876c41;"
										onclick="GA_Event('카테고리_리스트','정렬','CAMEL');">CAMEL</a></li>
									<li><a href="javascript:setRepProdColorCode('GOLD')"
										style="background: #ffc733;"
										onclick="GA_Event('카테고리_리스트','정렬','GOLD');">GOLD</a></li>
									<li class="mr0"><a
										href="javascript:setRepProdColorCode('GREEN')"
										style="background: #0f6f0e;"
										onclick="GA_Event('카테고리_리스트','정렬','GREEN');">GREEN</a></li>
									<li><a href="javascript:setRepProdColorCode('GREY')"
										style="background: #444445;"
										onclick="GA_Event('카테고리_리스트','정렬','GREY');">GREY</a></li>
									<li><a href="javascript:setRepProdColorCode('IVORY')"
										style="background: #fff8d9;"
										onclick="GA_Event('카테고리_리스트','정렬','IVORY');">IVORY</a></li>
									<li><a href="javascript:setRepProdColorCode('KHAKI')"
										style="background: #465626;"
										onclick="GA_Event('카테고리_리스트','정렬','KHAKI');">KHAKI</a></li>
									<li class="mr0"><a
										href="javascript:setRepProdColorCode('LAVENDER')"
										style="background: #9c81bb;"
										onclick="GA_Event('카테고리_리스트','정렬','LAVENDER');">LAVENDER</a></li>
									<li><a href="javascript:setRepProdColorCode('METAL')"
										style="background: #9d9fa2;"
										onclick="GA_Event('카테고리_리스트','정렬','METAL');">METAL</a></li>
									<li><a href="javascript:setRepProdColorCode('MINT')"
										style="background: #95d0ab;"
										onclick="GA_Event('카테고리_리스트','정렬','MINT');">MINT</a></li>
									<li><a href="javascript:setRepProdColorCode('MULTI')"
										style="background: #534741;"
										onclick="GA_Event('카테고리_리스트','정렬','MULTI');">MULTI</a></li>
									<li class="mr0"><a
										href="javascript:setRepProdColorCode('NAVY')"
										style="background: #061836;"
										onclick="GA_Event('카테고리_리스트','정렬','NAVY');">NAVY</a></li>
									<li><a href="javascript:setRepProdColorCode('OLIVE')"
										style="background: #5d682d;"
										onclick="GA_Event('카테고리_리스트','정렬','OLIVE');">OLIVE</a></li>
									<li><a href="javascript:setRepProdColorCode('ORANGE')"
										style="background: #ee6423;"
										onclick="GA_Event('카테고리_리스트','정렬','ORANGE');">ORANGE</a></li>
									<li><a href="javascript:setRepProdColorCode('PINK')"
										style="background: #ea589b;"
										onclick="GA_Event('카테고리_리스트','정렬','PINK');">PINK</a></li>
									<li class="mr0"><a
										href="javascript:setRepProdColorCode('PURPLE')"
										style="background: #833b95;"
										onclick="GA_Event('카테고리_리스트','정렬','PURPLE');">PURPLE</a></li>
									<li><a href="javascript:setRepProdColorCode('RED')"
										style="background: #ec1e24;"
										onclick="GA_Event('카테고리_리스트','정렬','RED');">RED</a></li>
									<li><a href="javascript:setRepProdColorCode('SILVER')"
										style="background: #c0c0c0;"
										onclick="GA_Event('카테고리_리스트','정렬','SILVER');">SILVER</a></li>
									<li><a href="javascript:setRepProdColorCode('SKY')"
										style="background: #a2d6f3;"
										onclick="GA_Event('카테고리_리스트','정렬','SKY');">SKY</a></li>
									<li class="mr0"><a
										href="javascript:setRepProdColorCode('VIOLET')"
										style="background: #4c2b7b;"
										onclick="GA_Event('카테고리_리스트','정렬','VIOLET');">VIOLET</a></li>
									<li><a href="javascript:setRepProdColorCode('WHITE')"
										class="wt" style="background: #ffffff;"
										onclick="GA_Event('카테고리_리스트','정렬','WHITE');">WHITE</a></li>
									<li><a href="javascript:setRepProdColorCode('YELLOW')"
										style="background: #ffea0a;"
										onclick="GA_Event('카테고리_리스트','정렬','YELLOW');">YELLOW</a></li>
								</ul>
							</div></li>
						<li class="size"><a href="#" class="select"
							onclick="GA_Event('카테고리_리스트','정렬','사이즈')">사이즈<span
								class="ico_arr">arrow</span></a>
							<div class="list list_item3" style="display: none;">
								<ul class="size_chip clearfix" id="category_size_chip">
									<li><a href="javascript:setRepSizeEnumCode('XXXS')"
										onclick="GA_Event('카테고리_리스트','정렬','XXXS');">XXXS</a></li>
									<li><a href="javascript:setRepSizeEnumCode('XXS')"
										onclick="GA_Event('카테고리_리스트','정렬','XXS');">XXS</a></li>
									<li class="mr0"><a
										href="javascript:setRepSizeEnumCode('XS')"
										onclick="GA_Event('카테고리_리스트','정렬','XS');">XS</a></li>
									<li><a href="javascript:setRepSizeEnumCode('S')"
										onclick="GA_Event('카테고리_리스트','정렬','S');">S</a></li>
									<li><a href="javascript:setRepSizeEnumCode('M')"
										onclick="GA_Event('카테고리_리스트','정렬','M');">M</a></li>
									<li class="mr0"><a
										href="javascript:setRepSizeEnumCode('L')"
										onclick="GA_Event('카테고리_리스트','정렬','L');">L</a></li>
									<li><a href="javascript:setRepSizeEnumCode('XL')"
										onclick="GA_Event('카테고리_리스트','정렬','XL');">XL</a></li>
									<li><a href="javascript:setRepSizeEnumCode('XXL')"
										onclick="GA_Event('카테고리_리스트','정렬','XXL');">XXL</a></li>
									<li class="mr0"><a
										href="javascript:setRepSizeEnumCode('XXXL')"
										onclick="GA_Event('카테고리_리스트','정렬','XXXL');">XXXL</a></li>
									<li><a href="javascript:setRepSizeEnumCode('XXXXL')"
										onclick="GA_Event('카테고리_리스트','정렬','XXXXL');">XXXXL</a></li>
									<li><a href="javascript:setRepSizeEnumCode('FREE')"
										onclick="GA_Event('카테고리_리스트','정렬','FREE');">FREE</a></li>
									<li class="mr0"><a
										href="javascript:setRepSizeEnumCode('ETC')"
										onclick="GA_Event('카테고리_리스트','정렬','ETC');">ETC</a></li>
								</ul>
							</div></li>
						<li class="price"><a href="#" class="select"
							onclick="GA_Event('카테고리_리스트','정렬','가격');">가격<span
								class="ico_arr">arrow</span></a>
							<div class="list" style="display: none;">
								<ul>
									<li><input type="checkbox" id="price_ck1"
										onclick="GA_Event('카테고리_리스트','정렬','￦100,000 이하');setPriceOrderCode(this, '1')">
										<label for="price_ck1" id="lable_ck1"> ￦100,000 이하</label></li>
									<li><input type="checkbox" id="price_ck2"
										onclick="GA_Event('카테고리_리스트','정렬','￦100,000 ~ ￦300,000');setPriceOrderCode(this, '2')">
										<label for="price_ck2" id="lable_ck2">￦100,000 ~
											￦300,000</label></li>
									<li><input type="checkbox" id="price_ck3"
										onclick="GA_Event('카테고리_리스트','정렬','￦300,000 ~ ￦500,000');setPriceOrderCode(this, '3')">
										<label for="price_ck3" id="lable_ck3">￦300,000 ~
											￦500,000</label></li>
									<li><input type="checkbox" id="price_ck4"
										onclick="GA_Event('카테고리_리스트','정렬','￦500,000 ~ ￦1,000,000');setPriceOrderCode(this, '4')">
										<label for="price_ck4" id="lable_ck4">￦500,000 ~
											￦1,000,000</label></li>
									<li><input type="checkbox" id="price_ck5"
										onclick="GA_Event('카테고리_리스트','정렬','￦1,000,000 이상');setPriceOrderCode(this, '5')">
										<label for="price_ck5" id="lable_ck5">￦1,000,000 이상</label></li>
								</ul>
							</div></li>

						<li class="sortby"><a href="#" class="select"
							onclick="GA_Event('카테고리_리스트','정렬','정렬순');">정렬순<span
								class="current">신상품</span><span class="ico_arr">arrow</span></a>
							<div class="list" style="display: none;">
								<ul>
									<li><a
										href="javascript:setProductOrderCode('NEW', '신상품');"
										onclick="GA_Event('카테고리_리스트','정렬','신상품');">신상품</a></li>
									<li><a
										href="javascript:setProductOrderCode('SALES', '판매순');"
										onclick="GA_Event('카테고리_리스트','정렬','판매순');">판매순</a></li>
									<li><a
										href="javascript:setProductOrderCode('HIGH', '고가순');"
										onclick="GA_Event('카테고리_리스트','정렬','고가순');">고가순</a></li>
									<li><a
										href="javascript:setProductOrderCode('LOW', '저가순');"
										onclick="GA_Event('카테고리_리스트','정렬','저가순');">저가순</a></li>
									<li><a
										href="javascript:setProductOrderCode('REVIEW', '평점순');"
										onclick="GA_Event('카테고리_리스트','정렬','상품평순');">평점순</a></li>
								</ul>
							</div></li>
						<li class="prd_list_filter1810 sale_filter">
							<div class="input_wrap">
								<input type="checkbox" id="checkSale" name="checkSale"
									onclick="setCheckSaleCode();GA_Event('카테고리_리스트','정렬','SALE');"
									style="margin: 3px 10px 0 0;"><label for="checkSale"
									id="checkSale" style="color: #ff0000;">SALE</label>
							</div>
						</li>
						<li class="prd_list_filter1810 delivery" style="display: none">
							<!-- 딜리버리 190219 -->
							<div class="input_wrap">
								<input type="checkbox" id="checkDelivery" name="checkDelivery"
									onclick="sethsDeliveryCode();GA_Event('카테고리_리스트','정렬','한섬딜리버리');"><label
									for="checkDelivery" id="hsDelivery">한섬딜리버리</label>
							</div> <img
							src="http://cdn.thehandsome.com/_ui/desktop/common/images/common/ico_quest.png"
							alt="한섬딜리버리란?" class="tlt" onmouseover="onMouseOverRecommend();"
							onmouseout="onMouseOutRecommend();">
							<div class="rmd_pb_popup" style="display: none;">
								<p>4PM, 퀵배송이 가능합니다.</p>
								<span class="box_arr"></span>
							</div>
						</li>
						<li class="btn"><a href="javascript:reset();"
							onclick="GA_Event('카테고리_리스트','정렬','초기화');">초기화</a><a
							href="javascript:gubunSearch(1);"
							onclick="GA_Event('카테고리_리스트','정렬','적용');">적용</a></li>
					</ul>
					<div class="items_count float_right">
						<span class="num">1069</span> <span>전체</span>
					</div>
				</div>
			</form>
			<!-- sort wrap -->

			<!-- <div class="row"> -->
			<!--                 <div class="col-lg-12"> -->
			<!--                     <div class="panel panel-default"> -->
			<!--                         <div class="panel-heading"> Board List Page  </div> -->
			<!--                         /.panel-heading -->
			<!--                         <div class="panel-body"> -->
			<!--                             <table width="100%" class="table table-striped table-bordered table-hover"> -->
			<!--                                 <thead> -->
			<!--                                     <tr> -->
			<!--                                         <th>#품번</th> -->
			<!--                                         <th>상품이름</th> -->
			<!--                                         <th>가격</th> -->
			<!--                                     </tr> -->
			<!--                                 </thead> -->
			<%--                                 <c:forEach items="${list}" var="product"> --%>
			<!--                                 <tr> -->
			<%--                                 <td><c:out value="${product.pid}" />  </td> --%>
			<%--                                 <td><c:out value="${product.pname}" />  </td>     --%>
			<%--                                 <td><c:out value="${product.pprice}" />  </td>                                --%>
			<!--                                 </tr> -->
			<%--                                 </c:forEach> --%>
			<!--                             </table> -->
			<!--                         </div> end panel-body -->
			<!--                       </div> -->
			<!--                     </div> -->
			<!--                     /.panel -->
			<!--                 </div> -->
			상품 리스트 및 페이징
			<div class="items_list cate_item4" id="listContent"
				style="display: block;">
				<ul class="clearfix" id="listBody" style="display: block;">
					<c:forEach items="${list}" var="product" varStatus="status">
						<li>
							<div class="item_box">
								<a href="/product/productDetail?pid=${product.pid}"
									class="item_info1"> <span class="item_img"> <img
										src="${product.t01_imageurl}" id="T01_IMG_0"
										alt="${product.pname}" targetcode="${product.pid}"
										class="respon_image"
										onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img3.jpg'">
										<img src="${product.t02_imageurl}" id="T02_IMG_0"
										alt="${product.pname}" targetcode="${product.pname}"
										class="respon_image on"
										onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img3.jpg'"
										style="display: none; opacity: 1;"> <input type="hidden"
										id="newImage1_0"
										value="http://newmedia.thehandsome.com/SY/2C/SS/SY2C4TTO047W_BK_T01.jpg">
										<input type="hidden" id="newImage2_0"
										value="http://newmedia.thehandsome.com/SY/2C/SS/SY2C4TTO047W_BK_T02.jpg">
								</span> <span class="item_size" id="itemsize_0"
									style="display: none; height: 20px; padding-top: 15px; margin-top: 0px; padding-bottom: 15px; margin-bottom: 0px;">
										<div id="SY2C4TTO047W_WG" style="display: none">
											<span>90</span>
										</div>
										<div id="SY2C4TTO047W_BK">
											<span>90</span>
										</div>
								</span>
								</a> <a href="/ko/p/${product.pid}" class="item_info2"> <span
									class="brand">${product.bname}</span> <span class="title">${product.pname}</span>
									<span class="price">₩<fmt:formatNumber value="${product.pprice }" type="number" pattern="###,###" /></span>
									<span class="flag"> <span class="product">NEW</span>
								</span>
								</a>
								<div class="color_more_wrap">
								<c:forEach items="${colorMap[status.index] }" var="colorList" varStatus="status2">
									<a href="javascript:void(0)" class="cl wt" style="background:${colorList.ccolorcode} url('${colorList.cimage1 }');" onclick="GA_Event('카테고리_리스트','컬러칩','BK')"></a>
								</c:forEach>
								</div>
							</div>
						</li>
					</c:forEach>
 				</ul>
			</div>
</body>

<!-- paging -->
<!--           <div class="paging" style="display: block;"> 
           <a class="prev2" href="javascript:void(0);">처음 페이지로 이동</a><a href="javascript:void(0);" class="prev">이전 페이지로 이동</a><span class="num"><a href="javascript:void(0);" class="pageBtn  on  " pagenum="1">1</a><a href="javascript:void(0);" class="pageBtn  " pagenum="2">2</a><a href="javascript:void(0);" class="pageBtn  " pagenum="3">3</a><a href="javascript:void(0);" class="pageBtn  " pagenum="4">4</a><a href="javascript:void(0);" class="pageBtn  " pagenum="5">5</a><a href="javascript:void(0);" class="pageBtn  " pagenum="6">6</a><a href="javascript:void(0);" class="pageBtn  " pagenum="7">7</a><a href="javascript:void(0);" class="pageBtn  " pagenum="8">8</a><a href="javascript:void(0);" class="pageBtn  " pagenum="9">9</a><a href="javascript:void(0);" class="pageBtn  " pagenum="10">10</a></span><a href="javascript:void(0);" class="next">다음 페이지로 이동</a><a href="javascript:void(0);" class="next2">마지막 페이지로 이동</a></div> -->

<!-- //paging -->

<!--페이지 번호 처리  -->
<div class="paging" style="display: block;">
	 
	<c:if test="${pageMaker.prev}">
		<!-- 이전 버튼 -->

		<a href="?pageNum=${pageMaker.startPage - 1}" class="prev">Previous</a>

	</c:if>

	 
	<!-- 1~10 버튼 -->
	<span class="num"> 
	<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
			<c:if test="${(pageMaker.startPage+i) <= pageMaker.endPage}">
			<a href="/list/${clarge}/${cmedium}/${csmall}?pageNum=${num}"
				class="pageBtn">${num}</a>
			</c:if>
		</c:forEach>
	</span>  
	<c:if test="${pageMaker.next}">
		<!-- 다음 버튼 -->
		<a href="?pageNum=${pageMaker.endPage +1}" class="next">Next</a>
	</c:if>

</div>
<!--  end Pagination -->

<form id='actionForm' action="/list" method='get'>
	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
	<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
</form>

<!-- //페이지 번호 처리  -->

<div class="sh_result none" id="searchResult_None"
	style="display: none;">조건에 맞는 상품 정보가 없습니다.</div>
</div>

<div id="criteoVariable">
	<script type="text/javascript">window.criteo_q = window.criteo_q || [];window.criteo_q.push({ event: "setAccount", account: 24596 },{ event: "setSiteType", type: "d" },{ event: "viewList", item: ["SY2C4TTO047W","CM2C4TTO340WP2","MW2C4TTO509W"]});</script>
</div>
</div>
<!-- //bodyWrap -->

<iframe height="0" width="0" title="Criteo DIS iframe"
	style="display: none;"></iframe>
<iframe height="0" width="0" title="Criteo DIS iframe"
	style="display: none;"></iframe>
</body>
<%@ include file="./includes/footer.jsp"%>