<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="./includes/header.jsp" %>
  <!-- 
  /* 작성자 : 문혁
 * 장바구니 페이지
 */
   -->
<!-- 
추가한 스크립트
 -->
<script type="text/javascript">

function deleteProduct(pid) {
        var url = "/deleteShoppingbag?pid=" + pid;
        if (confirm("해당 상품을 삭제하시겠습니까?") == true) {
            $.ajax({
                url: url,
                method: "post",
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
</script>


    <script type="text/javascript">
//<![CDATA[
var qtyLimitProductYnMap = {};
$(document).ready(function ()
{
	
		qtyLimitProductYnMap['SH2C3TTN642M_IV_95'] = 'true';	
	
		qtyLimitProductYnMap['HS2C3TTO039M73_GY_95'] = 'true';	
	
		qtyLimitProductYnMap['TH2C3TRN650M_BG_95'] = 'true';	
	
		qtyLimitProductYnMap['SH2C5TRN662M_IV_95'] = 'true';	
	
		qtyLimitProductYnMap['SH2C5TRN661M_DG_95'] = 'true';	
	
		qtyLimitProductYnMap['SH2C4TRN641M_DK_95'] = 'true';	
	
		qtyLimitProductYnMap['TH2C3TTN639N_BK_95'] = 'true';	
	
		qtyLimitProductYnMap['TH2C3TRN644N_CR_95'] = 'true';	
	
		qtyLimitProductYnMap['HS2C3TTO043M73_WT_95'] = 'true';	
	
		qtyLimitProductYnMap['SH2C4TRN653M_OW_95'] = 'true';	
	
// 		qtyLimitProductAlert();
	
    
  
		
    //매장수령의 경우
    
    
    //앳홈의 경우
    

    //퀵배송의 경우
    
    
    var emailAddress = "ansgurtk@naver.com";
    emailArr = emailAddress.split("@");
    $("#emailId").val(emailArr[0]);
    $("#emailDomain").val(emailArr[1]);
    
    //GA 이벤트 태깅 
    $(document).on('click','input:checkbox', function(){
        var isChecked = $(this).is(":checked");
        
        if($(this).attr('id') == 'entryCheckAll'){ // 전체선택시
            if (isChecked) {
                GA_Event('쇼핑백','선택','전체선택');
            } else {
                GA_Event('쇼핑백','선택','전체해제');
            }
        } else if ($(this).attr('name') == 'cartlist') { // 개별 선택시
            var label = $(this).parent().next().find('.sb_tlt').text();
            var selYN = "";
            if (isChecked) {
                selYN = "선택";
            } else {
                selYN = "해제";
            }
            GA_Event('쇼핑백','선택',selYN+label);
        }
    });
    
    $(document).on("click", '.left', function(){
    	
    	var soldout = $(this).data("soldout");
    	if(soldout == true) {
    		return false;
    	}
    	
        var qty = $(this).parents('.qty_sel').find('.mr0');
        
        if (qty.val() == 1) {
            return ;
        }
        qty.val(Number(qty.val()) - 1);
    });

    $(document).on("click", '.right', function(){
    	var soldout = $(this).data("soldout");
    	if(soldout == true) {
    		return false;
    	}
    	
        var qty = $(this).parents('.qty_sel').find('.mr0');
        
        //if (qty.val() > 99) {
            //layerAlert("'[브랜드명]상품명'의 \n재고수량은 n개 입니다.\n다시 입력해 주시기 바랍니다.");
            //return ;
        //}
        var productCode = $(this).parents('form').find('input[name="productCode"]').val();
        
        var promotionFlag = promotionProductCartAddCheck(productCode);
        if(promotionFlag){
            layerAlert("동일 옵션(컬러/사이즈)으로 최대 1개 구매 가능합니다.");
        }else{
            qty.val(Number(qty.val()) + 1);
        }
    });
    
    $(document).on("click", '.btn_option', function(){
        //옵션변경 클릭시 모든 하위 레이어 닫기
        $("[class^=store_info]").css("display","none");
        var checkIdx = $(".btn_option").index(this);
        $(".basket_info").each(function(idx){
           if(idx != checkIdx){
               $(this).css("display","none");
           } 
        });
        
        var prodid = $(this).prop('id').split("^");
        var curSize = $('#updateCartForm'+prodid[1]).find('input[name=curSize]').val();
        
        if($(this).parents("tr").next("tr").find(".basket_info").prop('style') == 'display: block;'){
            return;
        }
        
        var reserveSaleyyyy = $(this).parent(".option_wrap").find("#reserveSaleyyyy").val();
        var reserveSalemm = $(this).parent(".option_wrap").find("#reserveSalemm").val();
        var reserveSaledd = $(this).parent(".option_wrap").find("#reserveSaledd").val();
        
        var deliveryPlanDate = "{0}년 {1}월{2}일부터 순차적으로 배송됩니다."+ "(옵션 별로 배송 일자를 확인해 주세요.)";
        deliveryPlanDate = deliveryPlanDate.replace("{0}", reserveSaleyyyy).replace("{1}", reserveSalemm).replace("{2}", reserveSaledd);
        
        $.ajax({
            type: "GET",
            url: "/ko/shoppingbag/options",
            dataType: "json",
            data: {"productCode": prodid[2], "prodid":prodid[1], "curSize":curSize},
            success: function(data){
                $('#pt_list_'+prodid[1]).html(data.options);
                $('#pt_list_'+prodid[1]).find(".sz_select > a").each(function(){
                    if($(this).hasClass("on")){
                        $(this).css("line-height","15px");                        
                    }
                });
                
                var form = $('#updateCartForm' + prodid[1]);
                var productCode = form.find('input[name=productCode]'); 
                form.find('input[name=chgProductCode]').val(productCode.val());
                
                $('#pt_list_'+prodid[1]).find('.reserveDeliveryWrap').html(deliveryPlanDate);
            },
            error: function(xhr,  Status, error) {
                //alert('sendRequest error : ' + xhr.status + " ( " + error + " ) " );
            }
        });
    });

    $(document).on("click", '.btn', function(){
        var prodid = $(this).prop('id').split("_");
        
        if(prodid[0] == 'optCancelLayer'){
            $(this).parents('.basket_info').slideUp('fast');
        }
        
        if(prodid[0] == 'QuantityProduct'){
            var form = $('#updateCartForm' + prodid[1]);
            var productCode = form.find('input[name=productCode]').val(); 
            var initialCartQuantity = form.find('input[name=initialQuantity]').val();
            var newCartQuantity = form.find('input[name=quantity]').val();
            var cartData = form.data("cart");
            
            
			//#2610 [주문] 가상계좌 결제수단 제외 및 중복 구매 제한 처리 요청 건 20220215 hyunbae
            if(qtyLimitProductYnMap[productCode] == 'true' && parseInt(newCartQuantity) > 2){
            	layerAlert('동일 상품(사이즈/컬러)은<br/>최대 2개까지 선택 가능합니다.');
                return;
            }
            
/*             if($(".fourpm").length > 0){
            	form.find('input[name=deliveryKind]').val("4PM");
            }else{
            	form.find('input[name=deliveryKind]').val("");
            } */
            
            //퀵배송 수량 3개 최대 확인
            var checkQuickQty = false;
            $("[class^=shopping_cart_tab]").find("[name=cartDivision]").each(function(){
                if($(this).attr("data-division") == "quick" && $(this).hasClass("active")){
		            if(Number(newCartQuantity) > 3){
		                layerAlert('퀵배송은 3개 상품까지만 주문이 가능합니다.');
		                checkQuickQty = true;    
		                return;
		            }
		            
                }
            });
            
            if(checkQuickQty){
                return false;
            }
            
            if(initialCartQuantity != newCartQuantity)
            {
                AEC_U_V(productCode, newCartQuantity);
                form.submit();
            }
        }
        
        if(prodid[0] == 'RemoveProduct'){
            var form = $('#updateCartForm' + prodid[1]);
            var productCode = form.find('input[name=productCode]').val(); 
            var initialCartQuantity = form.find('input[name=initialQuantity]');
            var cartQuantity = form.find('input[name=quantity]');
            var cartData = form.data("cart");
            
            AEC_F_D(productCode,'o',initialCartQuantity.val());
            
            cartQuantity.val(0);
            initialCartQuantity.val(0);
            setEcommerceData(prodid[1], "Remove From Cart");
            form.submit();
        }
        
        if(prodid[0] == 'UpdateCart'){
            var form = $('#updateCartForm' + prodid[1]);
            var productCode = form.find('input[name=productCode]'); 
            var initialCartQuantity = form.find('input[name=initialQuantity]');
            var cartQuantity = form.find('input[name=quantity]');
            var chgProductCode = form.find('input[name=chgProductCode]').val();
            var storeId = form.find('input[name=storeId]').val();
            var storePickupDate = form.find('input[name=storePickupDate]').val();
            var cartData = form.data("cart");
            
            if($(".fourpm").length > 0){
            	form.find('input[name=deliveryKind]').val("4PM");
            }else{
            	form.find('input[name=deliveryKind]').val("");
            }
            
            if(chgProductCode == ''){
                layerAlert('사이즈를 선택해 주세요.');
                return;
            }
            
            if(chgProductCode != ''){
                productCode.val(chgProductCode);
            }
            
            form.prop('action', '/shoppingbag'); 
            form.submit();
        }
        
        if(prodid[0] == 'deliveryTypeChange'){
    		var checkedVal = "";
    		var storeInfo = "";
     		$("input[type='radio'][name='deliveryType"+prodid[1]+"']:checked").each(function(){
    			if($(this).prop("checked") == true) {
    				checkedVal = $(this).val();
    				storeInfo = $(this).data("storeinfo");
    				return false;
    			}
    		});
        	
     		if(checkedVal == "") {
     			layerAlert("선택되지 않았습니다.");
     			return false;
     		}
     		
     		if(checkedVal == "store") {
	     		//layerAlert('개발중입니다.');
	     		deliveryKindChange(prodid[1], "store", storeInfo);
     		} else {
     			deliveryKindChange(prodid[1], "", "");
     		}
        }
        
    });

    
		$("#ce_tab li:eq(0) a").click();
		

    var widthLi = $(".rmd_pb_list .hidden_wrap").width() / 6;
    $(".productSlide li").css("padding","0").css("width","auto");
    $(".productSlide li img").css("width","96%").css("padding","0 2%");
    $(".hidden_wrap ul li").width(widthLi);
    $(".hidden_wrap ul li").css("margin-right","0px");
    $(".rmd_pb_list ul").css("width","1000%")
    
    $(document).on("click", ".prev" , function(){
        slidPrev();
    });
    $(document).on("click", ".next" ,  function(){
        slidNext();
    });
    
	
	var prevSelectEntry = ",";
    $(document).on("click", '#onlyFourPm', function(){

    	var checked = $(this).prop("checked");
    	var entryPkList = ",";
    	
		$("tr[name='entryProductInfo']").each(function(){
			if(checked == false) {
				$($(this).find("input[type='checkbox']")).each(function(){
					
					// 체크되있던거
					var checkTempPk = "," + $(this).data("pk") + ",";
					if(prevSelectEntry.indexOf(checkTempPk) > -1) {
						$(this).prop("checked", true);
					}
				});
				
				if($(this).find("input[type='checkbox']").prop("checked") == true){
					entryPkList += $(this).data("pk");
					entryPkList += ",";
				}
				
				$(this).show();
			} else {
				$($(this).find("input[type='checkbox']")).each(function(){
					if($(this).prop("checked") == true) {
						prevSelectEntry += $(this).data("pk") + ","; // 체크되있던거
					}
				});
				
				var deliveryKind = $(this).data("deliverykind");
				if(deliveryKind == "FOUR_PM") {
					if($(this).find("input[type='checkbox']").prop("checked") == true){
						entryPkList += $(this).data("pk");
						entryPkList += ",";
					}
				} else {
					$($(this).find("input[type='checkbox']")).each(function(){
						$(this).prop("checked", false);
					});
					
					var outofstock = $(this).data("outofstock");
					if(outofstock == false) {
						$(this).hide();	
					}
				}
			}
		});
		
		if(checked == false) {
			prevSelectEntry = ","; // 초기화
		}
		
		//if(entryPkList != ",") {
			cartListCheckPrice(entryPkList, true);
		//}
    });
	
	
	$(document).on("click", "#entryCheckAll" ,function() {
		var eachName = $(this).val();
		eachName = "input[name="+eachName+"]";
		
		var checkProp = $(this).prop("checked");
		var checkOnlyFourPm = $("#onlyFourPm").prop("checked");
		$(eachName).each(function(){
			
			if(checkOnlyFourPm == true) {
				var deliveryKind = $(this).data("deliverykind");
				if(deliveryKind == "FOUR_PM") {
					if($(this).prop("disabled") == false) {
						$(this).prop("checked", checkProp);
					}
				} else {
					
				}
			} else {
				if($(this).prop("disabled") == false) {
					$(this).prop("checked", checkProp);
				}
			}

		});
		
		cartListCheckPrice(",", false);
	});
	
	$(document).on("click", "input[name='cartlist']" ,function() {
	    var obj = this;
	    var isCartListCheckPrice = true;
		if($("input:checkbox[name='cartlist']:checked").length > 0){
			$("[class^=shopping_cart_tab]").find("[name=cartDivision]").each(function(){
			    if($(this).attr("data-division") == "store"){
			        if($(this).hasClass("active")){
			            //매장수령일 경우 동일한 브랜드 and 매장 만 체크box 처리
	                    var targetIdx = $("input[name='cartlist']").index(obj);
	                    var targetBrand = $("input[name='cartlist']").eq(targetIdx).parent().next().find(".tlt_wrap > a > span:eq(0)").html();
	                    var targetStore = $("input[name='cartlist']").eq(targetIdx).parent().next().find(".storepick_opt_wrap .info").html();
			            $("input:checkbox[name='cartlist']").each(function(idx){
			                if(targetIdx != idx){
			                    var tempBrand = $(this).parent().next().find(".tlt_wrap > a > span:eq(0)").html();
			                    var tempStore = $(this).parent().next().find(".storepick_opt_wrap .info").html();
			                    
			                    if(targetBrand != tempBrand || targetStore != tempStore){
			                        $(this).prop("disabled", true);
			                    }
			                }
			            });		            
			        }
			    }else if($(this).attr("data-division") == "athome"){
			        if($(this).hasClass("active")){
				        if($("input:checkbox[name='cartlist']:checked").length > 3){
				            layerAlert('앳홈은 3개 상품 까지만 주문이 가능합니다.');
				            isCartListCheckPrice = false;
				        }
			        }
			    }
			});
		}else{
		    if($("#ordersheetCartDivision").val() != ""){
		        $("input:checkbox[name='cartlist']").prop("disabled", false);
		    }
		}
		
		if(isCartListCheckPrice){
		    cartListCheckPrice(",", false);
		}else{
		    return false;
		}
	});	
	
    
	$(document).on("click", "a[name='cartDivision']" ,function() {
		var division = $(this).data("division");
		
		$.ajax({
			type: "GET",
			url: "/ko/shoppingbag/shoppingbagCartView",
			dataType: "html",
			async : false,
	        cache : false,			
			data: {"cartDivision" : division},
			success: function(data){
				$("#shoppingbagCartView").html(data);
				
				$("a[name='cartDivision']").each(function(){
					if($(this).data('division') == division){
						$(this).prop("class", "active");
					} else {
						$(this).prop("class", "");
					}
				});
				$("#ordersheetCartDivision").val(division);
				
				var soldoutCheck = $(".soldout").length;
				
				if($(".soldout").length > 0) {
					var soldoutEntryNumber = "";
					
					$(".soldout").each(function(){
						soldoutEntryNumber = $(this).data('entrynumber') + ",";
					}); 
					
					if(soldoutEntryNumber == "") {
						return;
					}
					
					soldoutEntryNumber = "," + soldoutEntryNumber;
					
					$("input:checkbox[name='cartlist']").each(function(){
						var compareEntryNumber = "," + $(this).val() + ",";
						
						if(compareEntryNumber.indexOf(soldoutEntryNumber) > -1){
							$(this).click();
							$(this).prop("disabled", true);
						}
					});
				} else {
					//$("#outOfStockRemoveBtn").hide();
				}
				
				//매장수령일 경우 정책 초기화
				if(division == "store"){
				    storePickupInit();
				}else if(division == "athome"){
				    athomeInit();
				}
				cartInfomationList();
				
				var html = "";
				//앳홈, 퀵배송일 경우 툴팁 변경
				if(division == "athome"){
				    html += "<li>앳홈 서비스 이용 시 배송비 무료 입니다.</li>";
				}else if(division == "quick"){
	                html += "<li>퀵 배송비(5,000원)는 주문상품의 금액과 관계없이 별도 청구되는 배송비입니다.</li>";
	                html += "<li>퀵배송 서비스는 한섬마일리지, H.Point, e-money로 배송비 결제가 불가합니다.</li>";
	                
				}else{
				    html += "<li>쿠폰/바우처 할인금액 및 한섬마일리지/H.Point 사용을 제외한 실 결제금액 기준 3만원 미만 결제 시 2,500원 배송비가 부과 됩니다.(3만원 이상 구매 시 무료배송)</li>";
				    html += "<li>도서산간 지역은 배송비가 추가될 수 있습니다.</li>";
                    html += "<li>한섬마일리지, H.Point, e-money로 배송비 결제가 불가합니다.</li>";
				}
				
				$(".delch_wrap .bul_sty01_li").html(html);
			},
			error: function(xhr,  Status, error) {
				//alert('sendRequest error : ' + xhr.status + " ( " + error + " ) " );
		    }
		});		
	});
	
	
	var cartDivisionActiveYn = false;
	$("a[name='cartDivision']").each(function() {
		if($(this).data('division') == ""){
			$(this).prop("class", "active");
			cartDivisionActiveYn = true;
		} else {
			$(this).prop("class", "");
		}
	});
	
	if(!cartDivisionActiveYn) {
		if($("a[name='cartDivision']").length > 0) {
			$("a[name='cartDivision']").eq(0).prop("class", "active");
		}
	}
	
	if($(".soldout").length > 0) {
		var soldoutEntryNumber = "";
		
		$(".soldout").each(function(){
			soldoutEntryNumber = $(this).data('entrynumber') + ",";
		}); 
		
		if(soldoutEntryNumber == "") {
			return;
		}
		
		soldoutEntryNumber = "," + soldoutEntryNumber;
		
		$("input:checkbox[name='cartlist']").each(function(){
			var compareEntryNumber = "," + $(this).val() + ",";
			
			if(compareEntryNumber.indexOf(soldoutEntryNumber) > -1){
				$(this).click();
				$(this).prop("disabled", true);
			}
		});
	} else {
		//$("#outOfStockRemoveBtn").hide();
	}
	
	//해당 탭의 대상이 없을 경우 숨김 처리
	$(".gd_btn1807 li").each(function(){
		var objN=$(this).find('a').attr('rel');
		var obj=$('.'+objN);
		var chkCnt = 0;
		if(obj.find("tr").length < 1) {
			//$(this).css("backgroundColor","#f5f5f5");	
			$(this).hide();
			chkCnt++;
		}
		
		if(chkCnt == 3){
		    $(".gd_list").hide();
		}
	});
	
	$('.gd_btn1807 li a').on('click',function(){
		var objN=$(this).attr('rel');
		var obj=$('.'+objN);
		
		if(obj.find('tr').length < 1) {
			return;
		}
		
		var lp=($(window).width()-obj.width())/2;
		var tp=($(window).height()-obj.height())/2+$(window).scrollTop();
		if(lp < 0) lp=0;
		if(tp < 0) tp=0;
		$('.layerArea').show();
		obj.css("top", tp).css("position", "absolute").css('left',lp).css("z-index", 101);
		obj.show();
	});
	
	$(".btn_close, .close_btn").on("click", function(){
	    $(".popwrap, .layerArea").hide();
	});
	
	//쇼핑백 이용안내
    cartInfomationList();
	
	
	$(document).on("click", '.gd_btn1807 a:eq(0)', function(){
        $("#ce_tab li:eq(0) a").click();
    });
});
function cartInfomationList(){
    //제거
    $("[id^=infoAdd]").remove();
    //탭별 이용안내 변경
    $("[class^=shopping_cart_tab]").find("[name=cartDivision]").each(function(){
        if($(this).attr("data-division") == "store"){
            if($(this).hasClass("active")){
                $(".shoppingbag_list .bul_sty01_li").prepend('<li id="infoAddS2">수령신청일이 지난 상품은 장바구니에서 자동 삭제됩니다.</li>');
                $(".shoppingbag_list .bul_sty01_li").prepend('<li id="infoAddS1">동일 브랜드, 동일 매장 상품만 함께 주문하실 수 있습니다.</li>');
                $("#infoFourpmDesc").show();
            }
        }else if($(this).attr("data-division") == "athome"){
            if($(this).hasClass("active")){
                $(".shoppingbag_list .bul_sty01_li").prepend('<li id="infoAddA4">앳홈 서비스는 대리 수령이 불가하고 인수증에 자필 서명이 필요합니다.</li>');
                $(".shoppingbag_list .bul_sty01_li").prepend('<li id="infoAddA3">재고 상황에 따라, 서비스 신청 중 "앳홈"이 불가한 상품이 발생할 수 있습니다. 별도의 고지 예정입니다.</li>');
                $(".shoppingbag_list .bul_sty01_li").prepend('<li id="infoAddA2">편하게 집에서 입어 보시고, 원하는 상품만 48시간 내에 결제하시면 됩니다.</li>');
                $(".shoppingbag_list .bul_sty01_li").prepend('<li id="infoAddA1">앳홈은 3개 아이템까지 결제 없이 입어 보실 수 있는 피팅 서비스 입니다.</li>');
                $("#infoFourpmDesc").show();
            }
        }else if($(this).attr("data-division") == "quick"){
            if($(this).hasClass("active")){
                $(".shoppingbag_list .bul_sty01_li").prepend('<li id="infoAddA3">퀵배송 주문 후, 고객 사유로 미수령 시 반품 처리 됩니다.</li>');
                $(".shoppingbag_list .bul_sty01_li").prepend('<li id="infoAddA2">재고 상황에 따라, 서비스 신청 중 "퀵배송"이 불가한 상품이 발생할 수 있습니다. 별도의 고지 예정입니다.</li>');
                $(".shoppingbag_list .bul_sty01_li").prepend('<li id="infoAddA1">퀵배송 상품은 월~금요일, 자정~15시 이전에 서울 전 지역으로 주문하시면 당일 배송 받으실 수 있습니다.</li>');
                $("#infoFourpmDesc").show();
            }
        }else{
            if($(this).hasClass("active")){
                $(".shoppingbag_list .bul_sty01_li").prepend('<li id="infoAddN2">3만원 구매 시 무료 배송됩니다. 3만원 미만 구매 시 배송비 2,500원이 추가되며, 도서산간 지역으로 배송을 원하실 경우<br/>배송비가 추가될 수 있습니다.</li>');
                $(".shoppingbag_list .bul_sty01_li").prepend('<li id="infoAddN1">4PM 상품은 오후 4시 이전에 주문 하셔야 다음날 배송이 가능하며 재고가 소진될 경우 일반택배로 주문하실 수 있습니다.</li>');
            }
        }
    });
}

function storePickupInit(){
    //값을 초기화 해준다.
    $("#cartDataSubtotal").text("₩"+addComma(0));
    $("#cartDataDeliveryCost").text("₩"+addComma(0));
    $("#cartDataTotalPrice").text("₩"+addComma(0));
    
    //매장수령에 있
    var chkBrandCnt = 0;
    var chkStoreCnt = 0;
    var chkBrandList = "";
    var chkStoreList = "";
    $("input:checkbox[name='cartlist']").each(function(){
        //브랜드가 같은지 확인
        if(chkBrandList == ""){
            chkBrandList = $(this).parent().next().find(".tlt_wrap > a > span:eq(0)").html();
        }else{
            if(chkBrandList != $(this).parent().next().find(".tlt_wrap > a > span:eq(0)").html()){
                chkBrandCnt++;
            }
        }
        
        //수령매장이 같은지 확인
        if(chkStoreList == ""){
            chkStoreList = $(this).parent().next().find(".storepick_opt_wrap .info").html();
        }else{
            if(chkStoreList != $(this).parent().next().find(".storepick_opt_wrap .info").html()){
                chkStoreCnt++;
            }
        }
    });
    
    if(chkBrandCnt == 0 && chkStoreCnt == 0){
        $("#entryCheckAll").prop("disabled", false);
    }else{
        $("#entryCheckAll").prop("disabled", true);
    }
}

function athomeInit(){
    //값을 초기화 해준다.
    $("#cartDataSubtotal").text("₩"+addComma(0));
    $("#cartDataDeliveryCost").text("₩"+addComma(0));
    $("#cartDataTotalPrice").text("₩"+addComma(0));
    
    if($("input:checkbox[name='cartlist']").length > 3){
        $("#entryCheckAll").prop("disabled", true);
    }else{
        $("#entryCheckAll").prop("disabled", false);
    }
}

function quickInit(){
    //값을 초기화 해준다.
    $("#cartDataSubtotal").text("₩"+addComma(0));
    $("#cartDataDeliveryCost").text("₩"+addComma(0));
    $("#cartDataTotalPrice").text("₩"+addComma(0));
    
    if($("input:checkbox[name='cartlist']").length > 3){
        $("#entryCheckAll").prop("disabled", true);
    }else{
        $("#entryCheckAll").prop("disabled", false);
    }
}

//var storePickUpList = "";
function storePickUpHtml(entryNumber, data){

	storePickUpList = data;
	var paging = data.pagination;
	 
	var storeInfo = $("#deliveryType_store_"+entryNumber).data("initstoreinfo");
	var storeId = "";
	var storePickupDate = "";
	var selectStorePickupDateDivison = "";
	
	if($.trim(storeInfo) != "") {
		storeInfo = storeInfo.split("/");
		storeId = storeInfo[0];
		storePickupDate = storeInfo[1];
	}
	
	var storePickUpHtml = "";
	if(storePickUpList == null || storePickUpList.length < 1){
		storePickUpHtml += "<tr>";
		storePickUpHtml += 	"<td colspan='4' class='no_data'>";
		storePickUpHtml += 	'입력하신 매장명 혹은 주소로는 선택하신</br>상품을 수령 할 수 있는 매장이 없습니다.';
		storePickUpHtml += 	"</td>";
		storePickUpHtml += "</tr>";
	 } else {
		for(var i=0; i<storePickUpList.length; i++){
			var selectStoreIdProp = "";
			
			if(storeId != "" && storePickUpList[i].branchCode == storeId) {
				selectStoreIdProp = "checked";
				selectStorePickupDateDivison = "#sel_rd"+i;
			}

			storePickUpHtml += "<tr> \n";
			storePickUpHtml += "<td><input name=\"sel_cp\" id=\"sel_rd"+i+"\" type=\"radio\" title=\"배송지 선택\"></td> \n";
			
			storePickUpHtml += "<td> \n";
			storePickUpHtml += " <div> \n";
			storePickUpHtml += "  <span>"+storePickUpList[i].branchName+"</span> \n";
			storePickUpHtml += "   <p>"+storePickUpList[i].branchAddress+"</p> \n";
			storePickUpHtml += " </div> \n";
			storePickUpHtml += "</td> \n";
			storePickUpHtml += "<td>"+storePickUpList[i].branchTelephone+"</td> \n";
			storePickUpHtml += "</tr> \n";
			
			storePickUpHtml += "<tr class=\"receive_date_wrap1807\" style=\"display:none;\"> \n";
			storePickUpHtml += "	<td></td> \n";
			storePickUpHtml += "	<td colspan=\"2\"> \n";
			storePickUpHtml += "		<div class=\"receive_date\"> \n";
			storePickUpHtml += "			<p class=\"receive_date_tlt\">수령 신청일 선택</p> \n";
			
			storePickUpHtml += "			<ul> \n";
 			for(var j=0; j<storePickUpList[i].pickupPossibleDateList.length; j++) {
				var pickupPossibleDate = storePickUpList[i].pickupPossibleDateList[j];
				var pickupPossibleDateConv = pickupPossibleDate.substring(4,6) + "월 " + pickupPossibleDate.substring(6,8) + "일";
				storePickUpHtml += "				<li><a href=\"#;\" name=\"storePickupDate\" data-value="+pickupPossibleDate+" data-storeid="+storePickUpList[i].branchCode+">"+pickupPossibleDateConv+"</a></li> \n";
			}
			storePickUpHtml += "			</ul> \n";
			storePickUpHtml += "		</div> \n";
			storePickUpHtml += "	</td> \n";
			storePickUpHtml += "</tr> \n";			
		}
	}
	 
	$("#popupStorePickupContent").html(storePickUpHtml);
	 
	$("input[type='radio'][name='sel_cp']").off('click').on('click', function(){
		$('.receive_date_wrap1807').stop().hide();
		$(this).parents('tr').next('tr').stop().slideDown('fast');
		
		var dateBtn='.receive_date_wrap1807 .receive_date ul li a';
		$(dateBtn).each(function(){
			$(this).removeClass('on');
		});
	});
	
	var dateBtn='.receive_date_wrap1807 .receive_date ul li a';
	$(dateBtn).off('click').on('click', function(){
		$(dateBtn).removeClass('on');
		$(this).addClass('on');
	});
	
	var tbodyTr = $('#popupStorePickupContent tr');
	var trLength = $('#popupStorePickupContent tr').length;
	for(var i=2; i<trLength; i++){
		tbodyTr.eq(i).css('background','#f8f8f8');
		tbodyTr.eq(i+1).css('background','#f8f8f8');
		i+=3;
	}
	 
	 if(storeId != "") {
		$(selectStorePickupDateDivison).click();
		 
  		$("a[name='storePickupDate'][data-storeid='"+storeId+"']").each(function(){
  			var pickupDate = $(this).data("value");
  			
  			if(storePickupDate != "" && pickupDate == storePickupDate) {
  				$(this).click();
  				return false;
  			}
		});
	 }
}

function deliveryKindChange(entryNumber, type, storeInfo) {
	$.ajax({
		type: "GET",
		url: "/ko/shoppingbag/deliveryKindChange",
		dataType: "json",
		async : false,
        cache : false,			
		data: {"entryNumber" : entryNumber
			,"type" : type
			,"storeInfo" : storeInfo},
		success: function(data){
			if(data == "") {
        		var lc = new layerAlert("변경되었습니다.");
                lc.confirmAction = function(){
                	if(type == "store") {
		   				$("a[name='cartDivision']").each(function() {
		   					if($(this).data('division') == $("#ordersheetCartDivision").val()){
		   						$(this).click();
		   					}
		   				});
                	} else {
	                	location.href = "/ko/shoppingbag";
                	}
            	};
			} else {
				if(data == "timeOver") {
					layerAlert("4PM 가능한 시간이 아닙니다. 일반배송으로 변경해주십시오.");
				} else if(data == "noChange") {
					layerAlert("재고부족 등으로 4PM으로 변경이 불가능합니다. 일반배송으로 변경해주십시오.");
				} else {
	        		var lc = new layerAlert("잘못된 접근입니다.");
	                lc.confirmAction = function(){
	                	window.location.reload();
	            	};
				}
			}
		},
		error: function(xhr,  Status, error) {
			//alert('sendRequest error : ' + xhr.status + " ( " + error + " ) " );
	    }
	});	
}

function cartListCheckPrice(entryPkList, only4pm) {
	if($.trim(entryPkList) == "") {
		entryPkList = ",";
	}
	
	var cartDivision = $("#ordersheetCartDivision").val();
	
	if(only4pm == false) {
		$("input[name='cartlist']").each(function(){
			if($(this).prop("checked") == true) {
				entryPkList += $(this).data("pk");
				entryPkList += ",";
			}
		});
	}
	
	var selectProductCount = entryPkList.split(",").length -2; // ,로 시작해서 , 로 끝나므로 -2
	$("#selectProductCount").text(selectProductCount);
	
	$.ajax({
		type: "GET",
		url: "/ko/shoppingbag/shoppingbagCalculation",
		dataType: "json",
		async : false,
        cache : false,			
		data: {"entryPkList" : entryPkList
				,"cartDivision" : cartDivision},
		success: function(data){
			$("#cartDataSubtotal").text("₩"+addComma(data.subTotal));
			$("#cartDataDeliveryCost").text("₩"+addComma(data.deliveryCost));
			$("#cartDataTotalPrice").text("₩"+addComma(data.totalPrice));

			
			/* if($("#freeGiftPromotion").length > 0) {
				$.ajax({
					type: "GET",
					url: "/ko/shoppingbag/freeGiftPromotionView",
					dataType: "json",
					async : false,
			        cache : false,			
					data: {"entryPkList" : entryPkList
						,"cartDivision" : cartDivision},
					success: function(data){
						$("#freeGiftPromotion").html(data.freeGiftPromotion);
					},
					error: function(xhr,  Status, error) {
						alert('sendRequest error : ' + xhr.status + " ( " + error + " ) " );
				    }
				});
			} */
			
		},
		error: function(xhr,  Status, error) {
			alert('shoppingbagCalculation : ' + xhr.status + " ( " + error + " ) " );
	    }
	});	
}

function outOfStockRemove() {
	if($(".soldout1807").length < 1) {
		layerAlert("품절상품이 없습니다.");
		return false;
	}
	
	var cartDivision = $("#ordersheetCartDivision").val();
	var entryNumber = "";
	$(".soldout1807").each(function(){
		entryNumber += $(this).data("entrynumber") + ",";
	});
	
	if(entryNumber == "") {
		return false;
	}
	
	//entryNumber = entryNumber.substring(0,entryNumber.length-1);
	selectRemove(entryNumber);
}

function selectRemove(entryNumber) {
	var type = "outOfStock";
 	if($.trim(entryNumber) == "") {
 		entryNumber = "";
 		type = "selectRemove";
		$("input:checkbox[name='cartlist']:checked").each(function(){
			entryNumber += $(this).val() + ",";
		});
 	}
 	
	if($.trim(entryNumber) == "") {
		layerAlert("선택된 상품이 없습니다. <br /> 삭제할 상품을 선택해 주세요.");
		return false;
	}
	
	entryNumber = entryNumber.substring(0,entryNumber.length-1);
	var entryArray = entryNumber.split(",");
	
    $.ajax({
        type: "GET",
        url: "/ko/shoppingbag/selectRemove",
        dataType: "json",
        async : false,
        data : {"entryNumber" : entryNumber},
        success: function(data){
			if(data == "") {
        		var lc = "";
        		if(type == "outOfStock") {
        			lc = new layerAlert("품절상품을 삭제하였습니다.");
        		} else {
        			lc = new layerAlert("선택상품을 삭제하였습니다.");
        		}
        		GA_Event('쇼핑백','주문','선택상품삭제');
        		setEcommerceData(entryNumber, "Remove From Cart");
                lc.confirmAction = function(){
                	
	    				$("a[name='cartDivision']").each(function() {
	    					if($(this).data('division') == $("#ordersheetCartDivision").val()){
	    						$(this).click();
	    						$("#cartCount").html(Number($("#cartCount").text()) - entryArray.length);
	    					}
	    				});
                	
            	};
			} else {
        		var lc = "";
        		if(type == "outOfStock") {
					lc = new layerAlert("품절상품 삭제에 실패하였습니다.");
        		} else {
        			lc = new layerAlert("선택상품 삭제에 실패하였습니다.");
        		}
				
                lc.confirmAction = function(){
                	window.location.reload();
            	};
			}
        },
        error: function(xhr,  Status, error) {
            alert('selectRemove error : ' + xhr.status + " ( " + error + " ) " );
        }
    });
}


function slidPrev(){
	if(status == 1 ){
		return;
	}
	status = 1;
	
    var slidUl = $(".hidden_wrap ul");
    
    var liWidth = slidUl.find("li").width()
    var max = (slidUl.find("li").size() - 6) * liWidth;
    var marginLeft = slidUl.css("marginLeft").replace("px", "");
    
    if( marginLeft >= 0 ){
        status = 0;
        return false;
    }
    slidUl.stop().animate({'marginLeft': '+='+liWidth+'px'}, 'normal', function(){status = 0;});
    
    return false;
}


function slidNext(){
	if(status == 1 ){
		return;
	}
	status = 1;
	
    var slidUl = $(".hidden_wrap ul");
    
    var liWidth = slidUl.find("li").width()
    var max = (slidUl.find("li").size() - 6) * liWidth;
    var marginLeft = slidUl.css("marginLeft").replace("px", "");
    
    if( (parseFloat(max) + parseFloat(marginLeft)) <= 0 ){
        status = 0;
        return;
    }
    
    slidUl.stop().animate({'marginLeft': '-='+liWidth+'px'}, 'normal', function(){status = 0;});
    
    return false;
}
 
function checkoutPage() {
    var cartDivision = $("#ordersheetCartDivision").val();
    var resultReturn = true;
    
	$("input[name=checkZeroPrice]").each(function(){
		var price = $(this).val();
		
		if(price <= 0){
			layerAlert("선택 상품은 일시적인 시스템 장애로 구매하실 수 없습니다.<br/>고객센터(1800-5700)로 문의주세요.");
			resultReturn = false;
			return false;
		}
	});
	
	if(resultReturn == false) {
		return false;
	}
	
 	var entryNumber = "";
	$("input:checkbox[name='cartlist']:checked").each(function(){
		entryNumber += $(this).val() + ",";
	});
	
	if(entryNumber == "") {
		layerAlert("주문하실 상품을 선택해주세요.");
		return false;
	}
	
	entryNumber = entryNumber.substring(0,entryNumber.length-1);
	
	//#2610 [주문] 가상계좌 결제수단 제외 및 중복 구매 제한 처리 요청 건 20220215 hyunbae
	var hasQtyLimitProduct = false;
	var entryNumberArray = entryNumber.split(',');
	entryNumberArray.forEach(function(row){
		var productCode = $('#updateCartForm'+row).find('[name=productCode]').val();
		var productQty = $('#updateCartForm'+row).find('[name=initialQuantity]').val();
		if(qtyLimitProductYnMap[productCode] == 'true' && parseInt(productQty) > 2){
			hasQtyLimitProduct = true;
			return;
		}
	})
	
	if(hasQtyLimitProduct){
		layerAlert("동일 상품(사이즈/컬러)은<br/>최대 2개까지 선택 가능합니다.");
		return false;
	}
	
	var form = $('#ordersheetCloneForm');
 	var ordersheetEntryNumber = form.find('input[name=ordersheetEntryNumber]');
	ordersheetEntryNumber.val(entryNumber);
	//checkout1(바로주문) 액션은 주문서페이지에서 일괄적으로 처리
	//setEcommerceData(entryNumber, "Checkout1(바로주문)");
	if(cartDivision == "athome"){
	    GA_Event('쇼핑백','주문','앳홈_신청하기');
	}else{
	    GA_Event('쇼핑백','주문','선택상품_주문하기');
	}
	
	// 넷퍼넬 쇼핑백 -> 바로주문
	if("false" == "true" && "ko" == "ko"){
        NetFunnel_Action({action_id:"buy_now"},function(ev,ret){
        	form.submit();
        });
	}else{
		form.submit();	
	}
	
    
    //location.href="/ko/shoppingbag/checkout";
}


function continueUrl() {
    location.href="/";
}

function setOptions(obj, prodid, productCode, type)
{
    $(obj).parent().find("a").css("line-height","18px");
    $(obj).addClass("on");
    $(obj).siblings("a").removeClass("on");
    $(obj).css("line-height","15px")

    var form = $('#updateCartForm' + prodid);
    var curSize = form.find('input[name=curSize]').val();
    var chgProductCode = form.find('input[name=chgProductCode]');
    var storeId = form.find('input[name=storeId]').val();
    var storePickupDate = form.find('input[name=storePickupDate]').val();
    
    chgProductCode.val(productCode);
    //alert(chgProductCode.val());

    if(type == 'style')
    {
        $.ajax({
            type: "GET",
            url: "/ko/shoppingbag/options",
            dataType: "json",
            async : false,
	        cache : false,
            data: {"productCode":productCode, "prodid":prodid, "curSize":"", "storeId":storeId},
            success: function(data){
                $('#pt_list_'+prodid).html(data.options);
                try{
                    $(obj).parents('.cl_select').find(".cs_sel1807").text(data.options.product.baseOptions[0].selected.code);
                }catch(e){}
                $('#updateCartForm' + prodid).find('input[name=chgProductCode]').val('');
            },
            error: function(xhr,  Status, error) {
                alert('options error : ' + xhr.status + " ( " + error + " ) " );
            }
        });
    } else if(type == 'size'){
        $.ajax({
            type: "GET",
            url: "/ko/shoppingbag/optionsSize",
            dataType: "json",
            data: {"productCode":productCode},
            success: function(data){
                var reserveSaleProducts = data[0];
                if(reserveSaleProducts != undefined && reserveSaleProducts != null){
                    var yyyy=reserveSaleProducts.deliveryPlanYear;
                    var mm=reserveSaleProducts.deliveryPlanMounth;
                    var dd=reserveSaleProducts.deliveryPlanDay;
                    
                    var resultTxt = "";
                    resultTxt += '<div class="reserveDeliveryWrap">';
                    resultTxt += '    '+yyyy+'년 '+mm+'월'+dd+'일부터 순차적으로 배송됩니다.(옵션 별로 배송 일자를 확인해 주세요.)';
                    resultTxt += '</div>';
                    if($(obj).parents("dd").find(".reserveDeliveryWrap").length !== 0) {
                        $(obj).parents("dd").find(".reserveDeliveryWrap").html(resultTxt);
                    } else {
	                    $(obj).parents("dd").find(".sz_select").after(resultTxt);
                    }
                    
                    if(form.find('input[name=productCode]').val() == chgProductCode.val()) {
                        
                        var reserveSaleyyyy = $('#updateCartForm' + prodid).parents("tr").find(".pt_list_wrap").find("#reserveSaleyyyy").val();
                        var reserveSalemm = $('#updateCartForm' + prodid).parents("tr").find(".pt_list_wrap").find("#reserveSalemm").val();
                        var reserveSaledd = $('#updateCartForm' + prodid).parents("tr").find(".pt_list_wrap").find("#reserveSaledd").val();
                        
                        var deliveryPlanDate = "{0}년 {1}월{2}일부터 순차적으로 배송됩니다."+ "(옵션 별로 배송 일자를 확인해 주세요.)";
                        deliveryPlanDate = deliveryPlanDate.replace("{0}", reserveSaleyyyy).replace("{1}", reserveSalemm).replace("{2}", reserveSaledd);
                        
                        $(obj).parents("dd").find(".reserveDeliveryWrap").html(deliveryPlanDate);
                    }
                    
 
                }else{
                    $(obj).parents("dd").find(".reserveDeliveryWrap").html("");
                }
            }
        });
    }
}


function addWishList(obj, productCode)
{
    

    $.ajax({
         url: '/ko/wishlist/add-product-action',
         type: "GET",            
         data: {productCode: productCode},
         success: function(data){
             if(data != null && data != ''){
                 if(data == "erroor1"){
                     var la = new layerAlert('로그인을 해야 합니다.');
                 }else{
                     var la = new layerAlert('해당상품이 위시리스트에 존재 합니다.');
                 }
             }else{
                 var cnt = $("#wishlistCount").text();
                 cnt = cnt == null || cnt == "" ? 1 : parseInt(cnt) + parseInt(1);
                 $("#wishlistCount").text(cnt);
                 layerAlert("위시리스트에 등록되었습니다.");
                 
                 obj.prop("class", "btn gray_ss");
                 var thisIdx = obj.attr("data-value");
                 if(typeof thisIdx != undefined && thisIdx != ""){
                     brazeLogCustomEvent(thisIdx, "CART");
                 }
                 //brazeCustomAttribute
                 brazeCustomAttribute("Wish", productCode);
             }
         },
         error: function(xhr, Status, error) {
             alert('아직 준비중인 기능입니다.');
         }
    });
}


function onMouseOverRecommend() {
    $(".rmd_pb_popup").css('display', 'block');
}
function onMouseOutRecommend() {
    $(".rmd_pb_popup").css('display', 'none');
}


var oneClickProcess = true;
function checkoutOneClick() {
    if(oneClickProcess){
    
        var agent = navigator.userAgent.toLocaleLowerCase();

        if(agent.indexOf("chrome") > -1 && agent.indexOf("/80") > -1 ){
            /*
            var msg = "크롬 브라우저 80 버전 업데이트 이슈에 따라 원클릭결제 서비스 이용이 불가 할 수<br>있습니다.(쿠키 정책 변경)<br><br>" +
                "원활한 원클릭결제를 위해<br>크롬 외 다른 브라우저를 통해 이용해주세요.<br><br>" +
                "빠른 시일 내에 정상화 될 수 있도록<br>노력하겠습니다.";

            new layerAlert(msg);
            return  false;
            */
        }

        oneClickProcess = false;

        $("[class^=shopping_cart_tab]").find("[name=cartDivision]").each(function(){
            if($(this).attr("data-division") != "") {
                if ($(this).hasClass("active")) {
                    var la = new layerAlert('퀵배송/매장수령/앳홈은 배송특화 서비스로</br>원클릭 결제가 불가능합니다.');
                    la.confirmAction = function(){
                        return;
                    };
                    oneClickProcess = true;
                    return;
                }
            }
        });

        var check4pmOver = false;
        vipDeliAvail = true;
        if($("input[name='cartlist']:checked").parent().parent().find(".fourpm").length > 0){
        	vipDeliAvail = false;
        
            $.ajax({
                url: '/ko/shoppingbag/check4pm',
                data: {"deliveryKind":"4pm","buyNowYn":true},
                type: "GET",
                async : false,
                success: function(data){
                    //data가 0 또는 4pm의 경우 담기
                    if(data == "pm_over"){
                        check4pmOver = true;
                        $(".fourpm").remove();
                        $(".cart_top_text").html("");
                        $(".fourpm_pd_ck .input_wrap").html("");
                        // $("#deliveryKind").val("");
                    }
                },
//                 error: function(xhr, Status, error) {
//                     var la = new layerAlert(error);
//                     la.confirmAction = function(){
//                         return;
//                     };
                }
            });
        }

        if(check4pmOver){
            var la = new layerAlert('오후{0}시 이후 주문시 일반배송으로 변경됩니다.');
            la.confirmAction = function(){
                return;
            };
        }

        

        var entryNumber = "";
        var fourPmCount = 0;
        var nomalCount = 0;
        
        $("input:checkbox[name='cartlist']:checked").each(function(){
            if(entryNumber != ""){
                entryNumber += ",";
            }
            entryNumber += $(this).val();
            
            if("FOUR_PM" == $(this).attr("data-deliverykind")){
                fourPmCount++;
            }
            
            if("" == $(this).attr("data-deliverykind")){
                nomalCount++;
            }
        });
        
        if(fourPmCount > 0 && nomalCount > 0) {
            new layerAlert("4PM 주문과 일반배송 주문을 같이 진행 할 수 없습니다.");
            oneClickProcess = true;
            return false;
        }
        
        if(entryNumber == "") {
            new layerAlert("주문하실 상품을 선택해주세요.");
            oneClickProcess = true;
            return false;
        }

        var selectedEntryNumbers = entryNumber.split(",", 50);
        var products ="";
        for(var i=0; i<selectedEntryNumbers.length; i++) {

            var productCode = $("#updateCartForm"+selectedEntryNumbers[i] +" input[name='productCode']").val();
            var productQty = $("#updateCartForm"+selectedEntryNumbers[i] +" input[name='quantity']").val();

            if(productQty < 1){
                new layerAlert('productdetail.basket.errormag.qty');
                oneClickProcess = true;
                return;
            }
            
            
            //#2610 [주문] 가상계좌 결제수단 제외 및 중복 구매 제한 처리 요청 건 20220215 hyunbae
            if(qtyLimitProductYnMap[productCode] == 'true' && parseInt(productQty) > 2 ){
    			layerAlert("동일 상품(사이즈/컬러)은<br/>최대 2개까지 선택 가능합니다.");
                oneClickProcess = true;
    			return;
    		}
            
            

            products += productCode;
            products +=","+ productQty;
            products +="|";
        }
        
        // 넷퍼넬 쇼핑백 -> 원클릭 
        if("false" == "true" &&  "ko" == "ko"){
            NetFunnel_Action({action_id:"buy_now"},function(ev,ret){
            	oneclickLoadingStart(products,vipDeliAvail,entryNumber);
            });
		}else{
			oneclickLoadingStart(products,vipDeliAvail,entryNumber);
		}
    }
}

function oneclickLoadingStart(products,vipDeliAvail,entryNumber)
{
    $("body").append('<div class="layerArea" id="oneclickPopupLayer"><div class="layerBg"></div></div>');
    var loadingHtml = "";
    loadingHtml += '<div class="layerLoading_bar" id="oneclickLoadingDiv" style="width: 100%;height: 100%;top:0;">';
    loadingHtml += '    <div class="ly_oneclick">';
    loadingHtml += '        <img src="http://cdn.thehandsome.com/pc/order/loading_spinner_007s_190827.gif" alt="loading">';
    loadingHtml += '                <p class="ly_ld_main" >최대할인 혜택을 계산 중 입니다</p>';
    loadingHtml += '                <p class="ly_ld_sub">최대할인 혜택을 원클릭결제에 자동 적용하여<br>';
    loadingHtml += '                   편리한 결제가 가능합니다</p>';
    loadingHtml += '    </div>';
    loadingHtml += '</div>';
    $("body").append(loadingHtml);
    $.ajax({
    	url : '/checkout/oneclick?products='+encodeURIComponent(products)+'&vipDeliAvail='+vipDeliAvail ,
    	type : 'GET',
    	success : function(data){
    		$('#oneclickPopupLayer').append(data);
    	},
    	error : function(err){
    		console.log(err.responseText);
    	}
    })

    GA_Event("쇼핑백","주문","1CLICK결제");
    setEcommerceData(entryNumber, "Checkout1(원클릭결제)");
    oneClickProcess = true;
}

function oneClickTargetBlankPopup(wpayData){//원클릭결제 새창 팝업 2001
    WPAY.checkoutAuthSubmit(wpayData);
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
// 		new layerAlert(resultMsg);
		//WPAY.close();
		//window.parent.postMessage({layerClose:'layerClose'},'*');
		break;
	}
}


function callWishListClick(prodNm, ele, prodCd){
    GA_Event('쇼핑백','위시리스트', prodNm);
    addWishList(ele, prodCd);
}

function brazeLogCustomEvent(idx, type){
    var currentActionTime = new Date().format("yyyyMMddHHmmss");
    
    if(type == "CART"){
        
        if("0" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("TH2C3TRN644N_CR_95".indexOf("_") > -1){
                var tmp = "TH2C3TRN644N_CR_95".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "TH2C3TRN644N_CR_95";
            }
            var productCateKoName = setCategoryNameInKO("ME011", "T-SHIRTS");
            appboy.logCustomEvent(
                "wishProduct",
                {
                    "productName" : "[온라인 단독] 세미 오버핏 솔리드 티셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME011"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("1" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("HS2C3TTO039M73_GY_95".indexOf("_") > -1){
                var tmp = "HS2C3TTO039M73_GY_95".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "HS2C3TTO039M73_GY_95";
            }
            var productCateKoName = setCategoryNameInKO("ME011", "T-SHIRTS");
            appboy.logCustomEvent(
                "wishProduct",
                {
                    "productName" : "[TSPTR] 프린팅 티셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME011"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("2" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("HS2C3TTO043M73_WT_95".indexOf("_") > -1){
                var tmp = "HS2C3TTO043M73_WT_95".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "HS2C3TTO043M73_WT_95";
            }
            var productCateKoName = setCategoryNameInKO("ME011", "T-SHIRTS");
            appboy.logCustomEvent(
                "wishProduct",
                {
                    "productName" : "[TSPTR] 프린팅 티셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME011"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("3" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("TH2C3TRN650M_BG_95".indexOf("_") > -1){
                var tmp = "TH2C3TRN650M_BG_95".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "TH2C3TRN650M_BG_95";
            }
            var productCateKoName = setCategoryNameInKO("ME011", "T-SHIRTS");
            appboy.logCustomEvent(
                "wishProduct",
                {
                    "productName" : "리브 라운드넥 티셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME011"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("4" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("TH2C3TTN639N_BK_95".indexOf("_") > -1){
                var tmp = "TH2C3TTN639N_BK_95".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "TH2C3TTN639N_BK_95";
            }
            var productCateKoName = setCategoryNameInKO("ME011", "T-SHIRTS");
            appboy.logCustomEvent(
                "wishProduct",
                {
                    "productName" : "[온라인 단독] 테리 오픈 칼라 티셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME011"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("5" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("SH2C5TRN661M_DG_95".indexOf("_") > -1){
                var tmp = "SH2C5TRN661M_DG_95".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "SH2C5TRN661M_DG_95";
            }
            var productCateKoName = setCategoryNameInKO("ME011", "T-SHIRTS");
            appboy.logCustomEvent(
                "wishProduct",
                {
                    "productName" : "자카드 슬리브 티셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME011"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("6" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("SH2C5TRN662M_IV_95".indexOf("_") > -1){
                var tmp = "SH2C5TRN662M_IV_95".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "SH2C5TRN662M_IV_95";
            }
            var productCateKoName = setCategoryNameInKO("ME011", "T-SHIRTS");
            appboy.logCustomEvent(
                "wishProduct",
                {
                    "productName" : "프린팅 티셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME011"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("7" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("SH2C4TRN641M_DK_95".indexOf("_") > -1){
                var tmp = "SH2C4TRN641M_DK_95".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "SH2C4TRN641M_DK_95";
            }
            var productCateKoName = setCategoryNameInKO("ME011", "T-SHIRTS");
            appboy.logCustomEvent(
                "wishProduct",
                {
                    "productName" : "텍스처 블록 티셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME011"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("8" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("SH2C4TRN653M_OW_95".indexOf("_") > -1){
                var tmp = "SH2C4TRN653M_OW_95".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "SH2C4TRN653M_OW_95";
            }
            var productCateKoName = setCategoryNameInKO("ME011", "T-SHIRTS");
            appboy.logCustomEvent(
                "wishProduct",
                {
                    "productName" : "백 프린팅 라운드넥 티셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME011"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("9" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("SH2C3TTN642M_IV_95".indexOf("_") > -1){
                var tmp = "SH2C3TTN642M_IV_95".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "SH2C3TTN642M_IV_95";
            }
            var productCateKoName = setCategoryNameInKO("ME011", "T-SHIRTS");
            appboy.logCustomEvent(
                "wishProduct",
                {
                    "productName" : "지퍼 슬릿 칼라 티셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME011"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
    }else{ //RECOMMEND
        
        if("0" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("TG2B7HCO002LRA".indexOf("_") > -1){
                var tmp = "TG2B7HCO002LRA".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "TG2B7HCO002LRA";
            }
            var productCateKoName = setCategoryNameInKO("BE031", "Hand·BodyLotion/Cream/Oil");
            appboy.logCustomEvent(
                "LCE_recommendAreaClick",
                {
                    "productName" : "[SALTRAIN] 히노끼 사이프레스 핸드 크림"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "BE031"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("1" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("SH2C4TRN641M".indexOf("_") > -1){
                var tmp = "SH2C4TRN641M".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "SH2C4TRN641M";
            }
            var productCateKoName = setCategoryNameInKO("ME011", "T-SHIRTS");
            appboy.logCustomEvent(
                "LCE_recommendAreaClick",
                {
                    "productName" : "텍스처 블록 티셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME011"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("2" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("SH2C0TRN602MP2".indexOf("_") > -1){
                var tmp = "SH2C0TRN602MP2".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "SH2C0TRN602MP2";
            }
            var productCateKoName = setCategoryNameInKO("ME011", "T-SHIRTS");
            appboy.logCustomEvent(
                "LCE_recommendAreaClick",
                {
                    "productName" : "지퍼 슬릿 티셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME011"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("3" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("SH2C3TRN638M".indexOf("_") > -1){
                var tmp = "SH2C3TRN638M".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "SH2C3TRN638M";
            }
            var productCateKoName = setCategoryNameInKO("ME011", "T-SHIRTS");
            appboy.logCustomEvent(
                "LCE_recommendAreaClick",
                {
                    "productName" : "[PLAYER] 텍스처 블록 티셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME011"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("4" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("SH2C0TRN602MP3".indexOf("_") > -1){
                var tmp = "SH2C0TRN602MP3".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "SH2C0TRN602MP3";
            }
            var productCateKoName = setCategoryNameInKO("ME011", "T-SHIRTS");
            appboy.logCustomEvent(
                "LCE_recommendAreaClick",
                {
                    "productName" : "지퍼 슬릿 티셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME011"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("5" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("SH2C0TRN602MP1".indexOf("_") > -1){
                var tmp = "SH2C0TRN602MP1".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "SH2C0TRN602MP1";
            }
            var productCateKoName = setCategoryNameInKO("ME011", "T-SHIRTS");
            appboy.logCustomEvent(
                "LCE_recommendAreaClick",
                {
                    "productName" : "지퍼 슬릿 티셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME011"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("6" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("SH2C3TRN634M".indexOf("_") > -1){
                var tmp = "SH2C3TRN634M".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "SH2C3TRN634M";
            }
            var productCateKoName = setCategoryNameInKO("ME011", "T-SHIRTS");
            appboy.logCustomEvent(
                "LCE_recommendAreaClick",
                {
                    "productName" : "라운드넥 슬릿 티셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME011"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("7" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("SH2C5TRN661M".indexOf("_") > -1){
                var tmp = "SH2C5TRN661M".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "SH2C5TRN661M";
            }
            var productCateKoName = setCategoryNameInKO("ME011", "T-SHIRTS");
            appboy.logCustomEvent(
                "LCE_recommendAreaClick",
                {
                    "productName" : "자카드 슬리브 티셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME011"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("8" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("SH2C4TRN651M".indexOf("_") > -1){
                var tmp = "SH2C4TRN651M".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "SH2C4TRN651M";
            }
            var productCateKoName = setCategoryNameInKO("ME011", "T-SHIRTS");
            appboy.logCustomEvent(
                "LCE_recommendAreaClick",
                {
                    "productName" : "로고 자수 티셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME011"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("9" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("SH2C3WPCT06M".indexOf("_") > -1){
                var tmp = "SH2C3WPCT06M".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "SH2C3WPCT06M";
            }
            var productCateKoName = setCategoryNameInKO("ME021", "루즈/테이퍼드");
            appboy.logCustomEvent(
                "LCE_recommendAreaClick",
                {
                    "productName" : "[PARIS] 울 블렌드 밴딩 와이드 팬츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME021"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("10" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("SH2C4TRN617M".indexOf("_") > -1){
                var tmp = "SH2C4TRN617M".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "SH2C4TRN617M";
            }
            var productCateKoName = setCategoryNameInKO("ME011", "T-SHIRTS");
            appboy.logCustomEvent(
                "LCE_recommendAreaClick",
                {
                    "productName" : "[TYPE 2] 텍스처 블록 지퍼 포켓 티셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME011"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("11" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("FL2B7HCO037LCB".indexOf("_") > -1){
                var tmp = "FL2B7HCO037LCB".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "FL2B7HCO037LCB";
            }
            var productCateKoName = setCategoryNameInKO("BE041", "Perfume");
            appboy.logCustomEvent(
                "LCE_recommendAreaClick",
                {
                    "productName" : "[100BON] 아로마콜로지 롤 온 향수"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "BE041"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("12" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("SH2C3WPC533M".indexOf("_") > -1){
                var tmp = "SH2C3WPC533M".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "SH2C3WPC533M";
            }
            var productCateKoName = setCategoryNameInKO("ME028", "조거/트랙");
            appboy.logCustomEvent(
                "LCE_recommendAreaClick",
                {
                    "productName" : "투턱 조거 팬츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME028"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("13" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("SH2C1WSH701MM1".indexOf("_") > -1){
                var tmp = "SH2C1WSH701MM1".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "SH2C1WSH701MM1";
            }
            var productCateKoName = setCategoryNameInKO("ME012", "SHIRTS");
            appboy.logCustomEvent(
                "LCE_recommendAreaClick",
                {
                    "productName" : "드로우스트링 지퍼 포켓 셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME012"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("14" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("YS2B1HCO011WDV".indexOf("_") > -1){
                var tmp = "YS2B1HCO011WDV".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "YS2B1HCO011WDV";
            }
            var productCateKoName = setCategoryNameInKO("BE032", "Hand·BodyWash/Scrub");
            appboy.logCustomEvent(
                "LCE_recommendAreaClick",
                {
                    "productName" : "[DAVID'S BRANDING] 핸드 워시 기프트 세트"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "BE032"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("15" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("SH2C3TRN637MM".indexOf("_") > -1){
                var tmp = "SH2C3TRN637MM".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "SH2C3TRN637MM";
            }
            var productCateKoName = setCategoryNameInKO("ME011", "T-SHIRTS");
            appboy.logCustomEvent(
                "LCE_recommendAreaClick",
                {
                    "productName" : "[PLAYER] 엠보 프린팅 티셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME011"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("16" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("SH2C4KCD015M".indexOf("_") > -1){
                var tmp = "SH2C4KCD015M".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "SH2C4KCD015M";
            }
            var productCateKoName = setCategoryNameInKO("ME015", "CARDIGAN/VEST");
            appboy.logCustomEvent(
                "LCE_recommendAreaClick",
                {
                    "productName" : "스트라이프 버튼 가디건"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME015"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("17" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("SH2C3WTO639MM".indexOf("_") > -1){
                var tmp = "SH2C3WTO639MM".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "SH2C3WTO639MM";
            }
            var productCateKoName = setCategoryNameInKO("ME011", "T-SHIRTS");
            appboy.logCustomEvent(
                "LCE_recommendAreaClick",
                {
                    "productName" : "[PLAYER] 백 플랩 티셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME011"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("18" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("SH2C4TTO648M".indexOf("_") > -1){
                var tmp = "SH2C4TTO648M".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "SH2C4TTO648M";
            }
            var productCateKoName = setCategoryNameInKO("ME011", "T-SHIRTS");
            appboy.logCustomEvent(
                "LCE_recommendAreaClick",
                {
                    "productName" : "[TYPE 2] 텍스처 블록 드로우스트링 티셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME011"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("19" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("SH2C4TRN649M".indexOf("_") > -1){
                var tmp = "SH2C4TRN649M".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "SH2C4TRN649M";
            }
            var productCateKoName = setCategoryNameInKO("ME011", "T-SHIRTS");
            appboy.logCustomEvent(
                "LCE_recommendAreaClick",
                {
                    "productName" : "[TYPE 2] 텍스처 블록 드로우스트링 포켓 티셔츠"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "ME011"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
        if("20" == idx){
            //20201222 상품코드 세분화 작업
            var baseCd  = "";
            var styleCd = "";
            var sizeCd  = "";
            if("TG2C1HCO004LRA".indexOf("_") > -1){
                var tmp = "TG2C1HCO004LRA".split("_");
                if(tmp.length == 3){ // size
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                    sizeCd  = tmp[2];
                }else if(tmp.length == 2){ // color
                    baseCd  = tmp[0];
                    styleCd = tmp[1];
                }
            }else{ // base
                baseCd = "TG2C1HCO004LRA";
            }
            var productCateKoName = setCategoryNameInKO("BE035", "Body/Hair Care ETC");
            appboy.logCustomEvent(
                "LCE_recommendAreaClick",
                {
                    "productName" : "[SALTRAIN] 프레그런스 롤온 쿨링 오일"
                   ,"productCode" : baseCd
                   ,"colorCode"   : styleCd
                   ,"sizeCode"    : sizeCd
                   ,"accessDate"  : currentActionTime
                   ,"productCategoryCode" : "BE035"
                   ,"productCategoryName" : productCateKoName
                   ,"viewExhibitionPageCode" : ""
                   ,"viewExhibitionPageName" : ""
                }
            );
        }
        
    }
}

function brazeCustomAttribute(action, prodCd){
    var baseCode = prodCd.indexOf("_") > -1 ? prodCd.split("_")[0] : prodCd;
    
    if(action == "Wish"){
        appboy.getUser().addToCustomAttributeArray(
            "wishAddRemoveAttribute",
            baseCode
        );
    }else{ // Cart (Remove)
        appboy.getUser().removeFromCustomAttributeArray(
            "cartAddRemoveAttribute",
            baseCode
        );
    }
}

function qtyLimitProductAlert(){
	$('[name=entryProductInfo]').each(function (idx,row){
		var productCode = $(row).find('form [name=productCode]').val();
		var quantity = $(row).find('form [name=initialQuantity]').val(); 
		if(qtyLimitProductYnMap[productCode] == 'true' && parseInt(quantity) > 2){
			var brandName = $(row).find('.pt_list_wrap .tlt').text();
			var productName = $(row).find('.pt_list_wrap .sb_tlt').text().trim(); 
			layerAlert('['+brandName+'] ['+productName+']의<br/>구매 가능한 수량은 2개입니다.<br/>수량 변경 후 구매하실 수 있습니다.');
			return false;
		}
	})
}
//]]>
</script>

    <!-- bodyWrap -->
    <div id="bodyWrap">
        <!--title-->
        <h3 class="cnts_title cnts_tlt1807">
            <span>쇼핑백</span>
        </h3>
        <!--//title-->
        
        <!-- 장바구니개편 -->
        <span id="shoppingbagCartView">
        	<script type="text/javascript">

if(typeof kakaoPixel !== 'undefined'){
	var kakaoTrackId = '3482319208237780781'; //개발
	if(location.href.indexOf("www.thehandsome.com") > -1) kakaoTrackId = '7855119525940511046'; //운영
	kakaoPixel(kakaoTrackId).pageView();
	kakaoPixel(kakaoTrackId).viewCart();
}

$(document).ready(function(){
    var athomeAlertYn = "false";
    var todayDate = new Date();
    var startDate1 = new Date('2021/02/23 00:00:00'), endDate1 = new Date('2021/03/12 08:59:59');
    

    // 재입고 알림 신청 취소
    $("#rewareHousingCancel").on('click', function(){
        var lc = new customLayerConfirm("취소하시겠습니까?", "확인", "취소");
        
        lc.confirmAction = function(){
            $(".btn_close").trigger("click");
        };
    });
    
    // 재입고 알림 신청
    $("#rewareHousingApply").on('click', function(){
        var clc = new customLayerConfirm("재입고 알림을 신청하시겠습니까?", "확인", "취소");
        clc.confirmAction = function(){
            reqRewarehousingAlram();
        };
    });
    
    /** 2019.11.07 쇼핑백 최초 진입 시 선택 상품 없도록 수정 - 하단 합계 금액 계산 */
    $("#cartDataSubtotal").text("₩"+0);
	$("#cartDataDeliveryCost").text("₩"+0);
	$("#cartDataTotalPrice").text("₩"+0);
});

//재입고 완료 신청
function reqRewarehousingAlram() {
    
    //로그인체크 
    
    
    //신청
    $.ajax({
        url : '/ko/p/setRewareHousing',
        type : 'GET',
        datatype: 'json',
        data :
        {
            'code' : $('#popupHProduct').val(),
            'emailAddress' : $('#email_address').val() + '@' + $('#email_domain').val(),
            'CSRFToken' : "2e4f730b-79fa-408e-b072-425a73f94a7c"
        },
        success : function(data) 
        {
            if ( data.rsltCd == 'E1') {
                var clc = new customLayerConfirm("장시간 사용하지 않아 로그아웃 되었습니다.", "확인", "취소");
                clc.confirmAction = function() {
                    location.href='/ko/member/login';
                };
            } else {
                var msg = '';
                if ( data.rsltCd == 'S') {
                    msg = "재입고 알림 신청을 완료하였습니다.";
                } else if ( data.rsltCd == 'E2') {
                    msg = "등록된 이메일 정보와 다릅니다.<br />확인 후 다시 시도하여 주세요.";
                } else if ( data.rsltCd == 'E3') {
                    msg = ""+data.userID+"(ID) 로<br/>이미 재입고 알림 신청 이력이 있습니다.<br/>(동일 e-mail)";
                } else if ( data.rsltCd == 'E4') {
                    msg = "이미 신청을 완료하였습니다.";
                }
                var cla = new customLayerAlert(msg);
                cla.confirmAction = function(){
                    hideProductLayer();
                    $(".popwrap").hide();
                };    
            }
        },
        error   : function(xhr, Status, error) {
            var cla = new customLayerAlert("[Error] " + error);
            return;
        }
    });
    
    function hideProductLayer() {
        $("#productLayer .layerBg").removeClass("white");
        $("#productLayer").hide();
    }
    
}

function setEcommerceData(idx, action){

    if(action == "Remove From Cart" || action == "Checkout1(원클릭결제)" || action == "Checkout2(원클릭결제)"){
	    var checkIdx = ",".concat(idx).concat(",");
	    var productData = [];
	    
	    
	    var currentIdx = ",".concat("9").concat(",");
	    
	    if(checkIdx.indexOf(currentIdx) > -1){
	        /* 상품 정상이월세일 */
	        
                    /*  */
                    
	
			if(action == "Remove From Cart"){
	            productData.push({
                    "id": "TH2C3TRN644N_CR_95".indexOf("_") > -1 ? "TH2C3TRN644N_CR_95".split("_")[0] : "TH2C3TRN644N_CR_95", //상품코드
	                "name": "[온라인 단독] 세미 오버핏 솔리드 티셔츠", //상품명
	                "brand": "TIME HOMME", //상품 브랜드
                    "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
	                "dimension19": "정상상품_정상가" //상품 정상이월세일
	            });
	            var thisCd = "TH2C3TRN644N_CR_95";
	            brazeCustomAttribute("Cart", thisCd);
	        }else if(action == "Checkout1(원클릭결제)" || action == "Checkout2(원클릭결제)"){
	            productData.push({
                    "id": "TH2C3TRN644N_CR_95".indexOf("_") > -1 ? "TH2C3TRN644N_CR_95".split("_")[0] : "TH2C3TRN644N_CR_95", //상품코드
					"name": "[온라인 단독] 세미 오버핏 솔리드 티셔츠", //상품명
					"brand": "TIME HOMME", //상품 브랜드
                    "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
					"variant": "IVORY_95", //변형 제품(옵션)
					"quantity": "1", //상품 수량
					"dimension19": "정상상품_정상가" //상품 정상이월세일
				});
	        }
	    }
	    
	    var currentIdx = ",".concat("8").concat(",");
	    
	    if(checkIdx.indexOf(currentIdx) > -1){
	        /* 상품 정상이월세일 */
	        
                    /*  */
                    
	
			if(action == "Remove From Cart"){
	            productData.push({
                    "id": "HS2C3TTO039M73_GY_95".indexOf("_") > -1 ? "HS2C3TTO039M73_GY_95".split("_")[0] : "HS2C3TTO039M73_GY_95", //상품코드
	                "name": "[TSPTR] 프린팅 티셔츠", //상품명
	                "brand": "FOURM MEN'S LOUNGE", //상품 브랜드
                    "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
	                "dimension19": "정상상품_정상가" //상품 정상이월세일
	            });
	            var thisCd = "HS2C3TTO039M73_GY_95";
	            brazeCustomAttribute("Cart", thisCd);
	        }else if(action == "Checkout1(원클릭결제)" || action == "Checkout2(원클릭결제)"){
	            productData.push({
                    "id": "HS2C3TTO039M73_GY_95".indexOf("_") > -1 ? "HS2C3TTO039M73_GY_95".split("_")[0] : "HS2C3TTO039M73_GY_95", //상품코드
					"name": "[TSPTR] 프린팅 티셔츠", //상품명
					"brand": "FOURM MEN'S LOUNGE", //상품 브랜드
                    "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
					"variant": "GREY_95", //변형 제품(옵션)
					"quantity": "2", //상품 수량
					"dimension19": "정상상품_정상가" //상품 정상이월세일
				});
	        }
	    }
	    
	    var currentIdx = ",".concat("7").concat(",");
	    
	    if(checkIdx.indexOf(currentIdx) > -1){
	        /* 상품 정상이월세일 */
	        
                    /*  */
                    
	
			if(action == "Remove From Cart"){
	            productData.push({
                    "id": "HS2C3TTO043M73_WT_95".indexOf("_") > -1 ? "HS2C3TTO043M73_WT_95".split("_")[0] : "HS2C3TTO043M73_WT_95", //상품코드
	                "name": "[TSPTR] 프린팅 티셔츠", //상품명
	                "brand": "FOURM MEN'S LOUNGE", //상품 브랜드
                    "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
	                "dimension19": "정상상품_정상가" //상품 정상이월세일
	            });
	            var thisCd = "HS2C3TTO043M73_WT_95";
	            brazeCustomAttribute("Cart", thisCd);
	        }else if(action == "Checkout1(원클릭결제)" || action == "Checkout2(원클릭결제)"){
	            productData.push({
                    "id": "HS2C3TTO043M73_WT_95".indexOf("_") > -1 ? "HS2C3TTO043M73_WT_95".split("_")[0] : "HS2C3TTO043M73_WT_95", //상품코드
					"name": "[TSPTR] 프린팅 티셔츠", //상품명
					"brand": "FOURM MEN'S LOUNGE", //상품 브랜드
                    "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
					"variant": "WHITE_95", //변형 제품(옵션)
					"quantity": "1", //상품 수량
					"dimension19": "정상상품_정상가" //상품 정상이월세일
				});
	        }
	    }
	    
	    var currentIdx = ",".concat("6").concat(",");
	    
	    if(checkIdx.indexOf(currentIdx) > -1){
	        /* 상품 정상이월세일 */
	        
                    /*  */
                    
	
			if(action == "Remove From Cart"){
	            productData.push({
                    "id": "TH2C3TRN650M_BG_95".indexOf("_") > -1 ? "TH2C3TRN650M_BG_95".split("_")[0] : "TH2C3TRN650M_BG_95", //상품코드
	                "name": "리브 라운드넥 티셔츠", //상품명
	                "brand": "TIME HOMME", //상품 브랜드
                    "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
	                "dimension19": "정상상품_정상가" //상품 정상이월세일
	            });
	            var thisCd = "TH2C3TRN650M_BG_95";
	            brazeCustomAttribute("Cart", thisCd);
	        }else if(action == "Checkout1(원클릭결제)" || action == "Checkout2(원클릭결제)"){
	            productData.push({
                    "id": "TH2C3TRN650M_BG_95".indexOf("_") > -1 ? "TH2C3TRN650M_BG_95".split("_")[0] : "TH2C3TRN650M_BG_95", //상품코드
					"name": "리브 라운드넥 티셔츠", //상품명
					"brand": "TIME HOMME", //상품 브랜드
                    "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
					"variant": "BEIGE_95", //변형 제품(옵션)
					"quantity": "1", //상품 수량
					"dimension19": "정상상품_정상가" //상품 정상이월세일
				});
	        }
	    }
	    
	    var currentIdx = ",".concat("5").concat(",");
	    
	    if(checkIdx.indexOf(currentIdx) > -1){
	        /* 상품 정상이월세일 */
	        
                    /*  */
                    
	
			if(action == "Remove From Cart"){
	            productData.push({
                    "id": "TH2C3TTN639N_BK_95".indexOf("_") > -1 ? "TH2C3TTN639N_BK_95".split("_")[0] : "TH2C3TTN639N_BK_95", //상품코드
	                "name": "[온라인 단독] 테리 오픈 칼라 티셔츠", //상품명
	                "brand": "TIME HOMME", //상품 브랜드
                    "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
	                "dimension19": "정상상품_정상가" //상품 정상이월세일
	            });
	            var thisCd = "TH2C3TTN639N_BK_95";
	            brazeCustomAttribute("Cart", thisCd);
	        }else if(action == "Checkout1(원클릭결제)" || action == "Checkout2(원클릭결제)"){
	            productData.push({
                    "id": "TH2C3TTN639N_BK_95".indexOf("_") > -1 ? "TH2C3TTN639N_BK_95".split("_")[0] : "TH2C3TTN639N_BK_95", //상품코드
					"name": "[온라인 단독] 테리 오픈 칼라 티셔츠", //상품명
					"brand": "TIME HOMME", //상품 브랜드
                    "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
					"variant": "BLACK_95", //변형 제품(옵션)
					"quantity": "2", //상품 수량
					"dimension19": "정상상품_정상가" //상품 정상이월세일
				});
	        }
	    }
	    
	    var currentIdx = ",".concat("4").concat(",");
	    
	    if(checkIdx.indexOf(currentIdx) > -1){
	        /* 상품 정상이월세일 */
	        
                    /*  */
                    
	
			if(action == "Remove From Cart"){
	            productData.push({
                    "id": "SH2C5TRN661M_DG_95".indexOf("_") > -1 ? "SH2C5TRN661M_DG_95".split("_")[0] : "SH2C5TRN661M_DG_95", //상품코드
	                "name": "자카드 슬리브 티셔츠", //상품명
	                "brand": "SYSTEM HOMME", //상품 브랜드
                    "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
	                "dimension19": "정상상품_정상가" //상품 정상이월세일
	            });
	            var thisCd = "SH2C5TRN661M_DG_95";
	            brazeCustomAttribute("Cart", thisCd);
	        }else if(action == "Checkout1(원클릭결제)" || action == "Checkout2(원클릭결제)"){
	            productData.push({
                    "id": "SH2C5TRN661M_DG_95".indexOf("_") > -1 ? "SH2C5TRN661M_DG_95".split("_")[0] : "SH2C5TRN661M_DG_95", //상품코드
					"name": "자카드 슬리브 티셔츠", //상품명
					"brand": "SYSTEM HOMME", //상품 브랜드
                    "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
					"variant": "GREY_95", //변형 제품(옵션)
					"quantity": "1", //상품 수량
					"dimension19": "정상상품_정상가" //상품 정상이월세일
				});
	        }
	    }
	    
	    var currentIdx = ",".concat("3").concat(",");
	    
	    if(checkIdx.indexOf(currentIdx) > -1){
	        /* 상품 정상이월세일 */
	        
                    /*  */
                    
	
			if(action == "Remove From Cart"){
	            productData.push({
                    "id": "SH2C5TRN662M_IV_95".indexOf("_") > -1 ? "SH2C5TRN662M_IV_95".split("_")[0] : "SH2C5TRN662M_IV_95", //상품코드
	                "name": "프린팅 티셔츠", //상품명
	                "brand": "SYSTEM HOMME", //상품 브랜드
                    "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
	                "dimension19": "정상상품_정상가" //상품 정상이월세일
	            });
	            var thisCd = "SH2C5TRN662M_IV_95";
	            brazeCustomAttribute("Cart", thisCd);
	        }else if(action == "Checkout1(원클릭결제)" || action == "Checkout2(원클릭결제)"){
	            productData.push({
                    "id": "SH2C5TRN662M_IV_95".indexOf("_") > -1 ? "SH2C5TRN662M_IV_95".split("_")[0] : "SH2C5TRN662M_IV_95", //상품코드
					"name": "프린팅 티셔츠", //상품명
					"brand": "SYSTEM HOMME", //상품 브랜드
                    "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
					"variant": "IVORY_95", //변형 제품(옵션)
					"quantity": "1", //상품 수량
					"dimension19": "정상상품_정상가" //상품 정상이월세일
				});
	        }
	    }
	    
	    var currentIdx = ",".concat("2").concat(",");
	    
	    if(checkIdx.indexOf(currentIdx) > -1){
	        /* 상품 정상이월세일 */
	        
                    /*  */
                    
	
			if(action == "Remove From Cart"){
	            productData.push({
                    "id": "SH2C4TRN641M_DK_95".indexOf("_") > -1 ? "SH2C4TRN641M_DK_95".split("_")[0] : "SH2C4TRN641M_DK_95", //상품코드
	                "name": "텍스처 블록 티셔츠", //상품명
	                "brand": "SYSTEM HOMME", //상품 브랜드
                    "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
	                "dimension19": "정상상품_정상가" //상품 정상이월세일
	            });
	            var thisCd = "SH2C4TRN641M_DK_95";
	            brazeCustomAttribute("Cart", thisCd);
	        }else if(action == "Checkout1(원클릭결제)" || action == "Checkout2(원클릭결제)"){
	            productData.push({
                    "id": "SH2C4TRN641M_DK_95".indexOf("_") > -1 ? "SH2C4TRN641M_DK_95".split("_")[0] : "SH2C4TRN641M_DK_95", //상품코드
					"name": "텍스처 블록 티셔츠", //상품명
					"brand": "SYSTEM HOMME", //상품 브랜드
                    "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
					"variant": "KHAKI_95", //변형 제품(옵션)
					"quantity": "1", //상품 수량
					"dimension19": "정상상품_정상가" //상품 정상이월세일
				});
	        }
	    }
	    
	    var currentIdx = ",".concat("1").concat(",");
	    
	    if(checkIdx.indexOf(currentIdx) > -1){
	        /* 상품 정상이월세일 */
	        
                    /*  */
                    
	
			if(action == "Remove From Cart"){
	            productData.push({
                    "id": "SH2C4TRN653M_OW_95".indexOf("_") > -1 ? "SH2C4TRN653M_OW_95".split("_")[0] : "SH2C4TRN653M_OW_95", //상품코드
	                "name": "백 프린팅 라운드넥 티셔츠", //상품명
	                "brand": "SYSTEM HOMME", //상품 브랜드
                    "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
	                "dimension19": "정상상품_정상가" //상품 정상이월세일
	            });
	            var thisCd = "SH2C4TRN653M_OW_95";
	            brazeCustomAttribute("Cart", thisCd);
	        }else if(action == "Checkout1(원클릭결제)" || action == "Checkout2(원클릭결제)"){
	            productData.push({
                    "id": "SH2C4TRN653M_OW_95".indexOf("_") > -1 ? "SH2C4TRN653M_OW_95".split("_")[0] : "SH2C4TRN653M_OW_95", //상품코드
					"name": "백 프린팅 라운드넥 티셔츠", //상품명
					"brand": "SYSTEM HOMME", //상품 브랜드
                    "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
					"variant": "WHITE_95", //변형 제품(옵션)
					"quantity": "1", //상품 수량
					"dimension19": "정상상품_정상가" //상품 정상이월세일
				});
	        }
	    }
	    
	    var currentIdx = ",".concat("0").concat(",");
	    
	    if(checkIdx.indexOf(currentIdx) > -1){
	        /* 상품 정상이월세일 */
	        
                    /*  */
                    
	
			if(action == "Remove From Cart"){
	            productData.push({
                    "id": "SH2C3TTN642M_IV_95".indexOf("_") > -1 ? "SH2C3TTN642M_IV_95".split("_")[0] : "SH2C3TTN642M_IV_95", //상품코드
	                "name": "지퍼 슬릿 칼라 티셔츠", //상품명
	                "brand": "SYSTEM HOMME", //상품 브랜드
                    "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
	                "dimension19": "정상상품_정상가" //상품 정상이월세일
	            });
	            var thisCd = "SH2C3TTN642M_IV_95";
	            brazeCustomAttribute("Cart", thisCd);
	        }else if(action == "Checkout1(원클릭결제)" || action == "Checkout2(원클릭결제)"){
	            productData.push({
                    "id": "SH2C3TTN642M_IV_95".indexOf("_") > -1 ? "SH2C3TTN642M_IV_95".split("_")[0] : "SH2C3TTN642M_IV_95", //상품코드
					"name": "지퍼 슬릿 칼라 티셔츠", //상품명
					"brand": "SYSTEM HOMME", //상품 브랜드
                    "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
					"variant": "IVORY_95", //변형 제품(옵션)
					"quantity": "2", //상품 수량
					"dimension19": "정상상품_정상가" //상품 정상이월세일
				});
	        }
	    }
	    
	    
	    if(productData.length > 0){
	        if(action == "Remove From Cart"){
				dataLayer.push({
					'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Remove From Cart','layerLabel' : undefined,
					'ecommerce': {
						'currencyCode': 'KRW', //통화
						'remove': {
							'products': productData
						}
					}
				});
			}else if(action == "Checkout1(원클릭결제)"){
                dataLayer.push({
                    'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Checkout','layerLabel' : '원클릭결제',
                    'ecommerce': {
                        'currencyCode': 'KRW', //통화
                        'checkout': {
                            'actionField': { 'step': 1}, //결제단계
                            'products': productData
                        }
                    }
                });
            }else if(action == "Checkout2(원클릭결제)"){
		        dataLayer.push({
		            'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Checkout','layerLabel' : '원클릭결제',
		            'ecommerce': {
		            'currencyCode': 'KRW', //통화
		            'checkout': {
		                'actionField': { 'step': 2, 'option': '1CLICK 결제' }, //결제단계 및 결제수단
		                'products': productData
		                }
		            }
		        });
		    }
	    }
	}else if(action == "Click ADD"){
        
        if("0" == idx){
            dataLayer.push({
                'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
                'ecommerce': {
                'currencyCode': 'KRW', //통화
                'click': {
                    'actionField': { 'list': '쇼핑백_담은 상품' }, //상품 리스트명
                    'products':
                        [{
                            "id": "TH2C3TRN644N_CR_95".indexOf("_") > -1 ? "TH2C3TRN644N_CR_95".split("_")[0] : "TH2C3TRN644N_CR_95", //상품코드
                            "name": "[온라인 단독] 세미 오버핏 솔리드 티셔츠", //상품명
                            "brand": "TIME HOMME", //상품 브랜드
                            
                            "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
                            
                            "position": 9 //상품 위치
                            
                        }]
                    }
                }
            });
        }
        
        if("1" == idx){
            dataLayer.push({
                'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
                'ecommerce': {
                'currencyCode': 'KRW', //통화
                'click': {
                    'actionField': { 'list': '쇼핑백_담은 상품' }, //상품 리스트명
                    'products':
                        [{
                            "id": "HS2C3TTO039M73_GY_95".indexOf("_") > -1 ? "HS2C3TTO039M73_GY_95".split("_")[0] : "HS2C3TTO039M73_GY_95", //상품코드
                            "name": "[TSPTR] 프린팅 티셔츠", //상품명
                            "brand": "FOURM MEN'S LOUNGE", //상품 브랜드
                            
                            "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
                            
                            "position": 9 //상품 위치
                            
                        }]
                    }
                }
            });
        }
        
        if("2" == idx){
            dataLayer.push({
                'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
                'ecommerce': {
                'currencyCode': 'KRW', //통화
                'click': {
                    'actionField': { 'list': '쇼핑백_담은 상품' }, //상품 리스트명
                    'products':
                        [{
                            "id": "HS2C3TTO043M73_WT_95".indexOf("_") > -1 ? "HS2C3TTO043M73_WT_95".split("_")[0] : "HS2C3TTO043M73_WT_95", //상품코드
                            "name": "[TSPTR] 프린팅 티셔츠", //상품명
                            "brand": "FOURM MEN'S LOUNGE", //상품 브랜드
                            
                            "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
                            
                            "position": 9 //상품 위치
                            
                        }]
                    }
                }
            });
        }
        
        if("3" == idx){
            dataLayer.push({
                'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
                'ecommerce': {
                'currencyCode': 'KRW', //통화
                'click': {
                    'actionField': { 'list': '쇼핑백_담은 상품' }, //상품 리스트명
                    'products':
                        [{
                            "id": "TH2C3TRN650M_BG_95".indexOf("_") > -1 ? "TH2C3TRN650M_BG_95".split("_")[0] : "TH2C3TRN650M_BG_95", //상품코드
                            "name": "리브 라운드넥 티셔츠", //상품명
                            "brand": "TIME HOMME", //상품 브랜드
                            
                            "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
                            
                            "position": 9 //상품 위치
                            
                        }]
                    }
                }
            });
        }
        
        if("4" == idx){
            dataLayer.push({
                'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
                'ecommerce': {
                'currencyCode': 'KRW', //통화
                'click': {
                    'actionField': { 'list': '쇼핑백_담은 상품' }, //상품 리스트명
                    'products':
                        [{
                            "id": "TH2C3TTN639N_BK_95".indexOf("_") > -1 ? "TH2C3TTN639N_BK_95".split("_")[0] : "TH2C3TTN639N_BK_95", //상품코드
                            "name": "[온라인 단독] 테리 오픈 칼라 티셔츠", //상품명
                            "brand": "TIME HOMME", //상품 브랜드
                            
                            "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
                            
                            "position": 9 //상품 위치
                            
                        }]
                    }
                }
            });
        }
        
        if("5" == idx){
            dataLayer.push({
                'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
                'ecommerce': {
                'currencyCode': 'KRW', //통화
                'click': {
                    'actionField': { 'list': '쇼핑백_담은 상품' }, //상품 리스트명
                    'products':
                        [{
                            "id": "SH2C5TRN661M_DG_95".indexOf("_") > -1 ? "SH2C5TRN661M_DG_95".split("_")[0] : "SH2C5TRN661M_DG_95", //상품코드
                            "name": "자카드 슬리브 티셔츠", //상품명
                            "brand": "SYSTEM HOMME", //상품 브랜드
                            
                            "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
                            
                            "position": 9 //상품 위치
                            
                        }]
                    }
                }
            });
        }
        
        if("6" == idx){
            dataLayer.push({
                'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
                'ecommerce': {
                'currencyCode': 'KRW', //통화
                'click': {
                    'actionField': { 'list': '쇼핑백_담은 상품' }, //상품 리스트명
                    'products':
                        [{
                            "id": "SH2C5TRN662M_IV_95".indexOf("_") > -1 ? "SH2C5TRN662M_IV_95".split("_")[0] : "SH2C5TRN662M_IV_95", //상품코드
                            "name": "프린팅 티셔츠", //상품명
                            "brand": "SYSTEM HOMME", //상품 브랜드
                            
                            "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
                            
                            "position": 9 //상품 위치
                            
                        }]
                    }
                }
            });
        }
        
        if("7" == idx){
            dataLayer.push({
                'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
                'ecommerce': {
                'currencyCode': 'KRW', //통화
                'click': {
                    'actionField': { 'list': '쇼핑백_담은 상품' }, //상품 리스트명
                    'products':
                        [{
                            "id": "SH2C4TRN641M_DK_95".indexOf("_") > -1 ? "SH2C4TRN641M_DK_95".split("_")[0] : "SH2C4TRN641M_DK_95", //상품코드
                            "name": "텍스처 블록 티셔츠", //상품명
                            "brand": "SYSTEM HOMME", //상품 브랜드
                            
                            "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
                            
                            "position": 9 //상품 위치
                            
                        }]
                    }
                }
            });
        }
        
        if("8" == idx){
            dataLayer.push({
                'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
                'ecommerce': {
                'currencyCode': 'KRW', //통화
                'click': {
                    'actionField': { 'list': '쇼핑백_담은 상품' }, //상품 리스트명
                    'products':
                        [{
                            "id": "SH2C4TRN653M_OW_95".indexOf("_") > -1 ? "SH2C4TRN653M_OW_95".split("_")[0] : "SH2C4TRN653M_OW_95", //상품코드
                            "name": "백 프린팅 라운드넥 티셔츠", //상품명
                            "brand": "SYSTEM HOMME", //상품 브랜드
                            
                            "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
                            
                            "position": 9 //상품 위치
                            
                        }]
                    }
                }
            });
        }
        
        if("9" == idx){
            dataLayer.push({
                'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
                'ecommerce': {
                'currencyCode': 'KRW', //통화
                'click': {
                    'actionField': { 'list': '쇼핑백_담은 상품' }, //상품 리스트명
                    'products':
                        [{
                            "id": "SH2C3TTN642M_IV_95".indexOf("_") > -1 ? "SH2C3TTN642M_IV_95".split("_")[0] : "SH2C3TTN642M_IV_95", //상품코드
                            "name": "지퍼 슬릿 칼라 티셔츠", //상품명
                            "brand": "SYSTEM HOMME", //상품 브랜드
                            
                            "category":  decodeURIComponent("MEN")+"/"+decodeURIComponent("TOP")+"/"+decodeURIComponent("T-SHIRTS"), //상품 카테고리
                            
                            "position": 9 //상품 위치
                            
                        }]
                    }
                }
            });
        }
        
    }else if(action == "Click RECOMMEND"){
		
		if("0" == idx){
		    dataLayer.push({
		        'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
		        'ecommerce': {
		        'currencyCode': 'KRW', //통화
		        'click': {
		            'actionField': { 'list': '쇼핑백_추천 상품' }, //상품 리스트명
		            'products':
		                [{
		                    "id": "TG2B7HCO002LRA".indexOf("_") > -1 ? "TG2B7HCO002LRA".split("_")[0] : "TG2B7HCO002LRA" , //상품코드
		                    "name": "[SALTRAIN] 히노끼 사이프레스 핸드 크림", //상품명
		                    "brand": "TOM GREYHOUND", //상품 브랜드
		                    "category": "", //상품 카테고리
		                    
                            "position": 10 //상품 위치
                            
		                }]
		            }
		        }
		    });
		    
		    brazeLogCustomEvent(idx, "RECOMMEND");
		}
		
		if("1" == idx){
		    dataLayer.push({
		        'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
		        'ecommerce': {
		        'currencyCode': 'KRW', //통화
		        'click': {
		            'actionField': { 'list': '쇼핑백_추천 상품' }, //상품 리스트명
		            'products':
		                [{
		                    "id": "SH2C4TRN641M".indexOf("_") > -1 ? "SH2C4TRN641M".split("_")[0] : "SH2C4TRN641M" , //상품코드
		                    "name": "텍스처 블록 티셔츠", //상품명
		                    "brand": "SYSTEM HOMME", //상품 브랜드
		                    "category": "", //상품 카테고리
		                    
                            "position": 10 //상품 위치
                            
		                }]
		            }
		        }
		    });
		    
		    brazeLogCustomEvent(idx, "RECOMMEND");
		}
		
		if("2" == idx){
		    dataLayer.push({
		        'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
		        'ecommerce': {
		        'currencyCode': 'KRW', //통화
		        'click': {
		            'actionField': { 'list': '쇼핑백_추천 상품' }, //상품 리스트명
		            'products':
		                [{
		                    "id": "SH2C0TRN602MP2".indexOf("_") > -1 ? "SH2C0TRN602MP2".split("_")[0] : "SH2C0TRN602MP2" , //상품코드
		                    "name": "지퍼 슬릿 티셔츠", //상품명
		                    "brand": "SYSTEM HOMME", //상품 브랜드
		                    "category": "", //상품 카테고리
		                    
                            "position": 10 //상품 위치
                            
		                }]
		            }
		        }
		    });
		    
		    brazeLogCustomEvent(idx, "RECOMMEND");
		}
		
		if("3" == idx){
		    dataLayer.push({
		        'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
		        'ecommerce': {
		        'currencyCode': 'KRW', //통화
		        'click': {
		            'actionField': { 'list': '쇼핑백_추천 상품' }, //상품 리스트명
		            'products':
		                [{
		                    "id": "SH2C3TRN638M".indexOf("_") > -1 ? "SH2C3TRN638M".split("_")[0] : "SH2C3TRN638M" , //상품코드
		                    "name": "[PLAYER] 텍스처 블록 티셔츠", //상품명
		                    "brand": "SYSTEM HOMME", //상품 브랜드
		                    "category": "", //상품 카테고리
		                    
                            "position": 10 //상품 위치
                            
		                }]
		            }
		        }
		    });
		    
		    brazeLogCustomEvent(idx, "RECOMMEND");
		}
		
		if("4" == idx){
		    dataLayer.push({
		        'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
		        'ecommerce': {
		        'currencyCode': 'KRW', //통화
		        'click': {
		            'actionField': { 'list': '쇼핑백_추천 상품' }, //상품 리스트명
		            'products':
		                [{
		                    "id": "SH2C0TRN602MP3".indexOf("_") > -1 ? "SH2C0TRN602MP3".split("_")[0] : "SH2C0TRN602MP3" , //상품코드
		                    "name": "지퍼 슬릿 티셔츠", //상품명
		                    "brand": "SYSTEM HOMME", //상품 브랜드
		                    "category": "", //상품 카테고리
		                    
                            "position": 10 //상품 위치
                            
		                }]
		            }
		        }
		    });
		    
		    brazeLogCustomEvent(idx, "RECOMMEND");
		}
		
		if("5" == idx){
		    dataLayer.push({
		        'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
		        'ecommerce': {
		        'currencyCode': 'KRW', //통화
		        'click': {
		            'actionField': { 'list': '쇼핑백_추천 상품' }, //상품 리스트명
		            'products':
		                [{
		                    "id": "SH2C0TRN602MP1".indexOf("_") > -1 ? "SH2C0TRN602MP1".split("_")[0] : "SH2C0TRN602MP1" , //상품코드
		                    "name": "지퍼 슬릿 티셔츠", //상품명
		                    "brand": "SYSTEM HOMME", //상품 브랜드
		                    "category": "", //상품 카테고리
		                    
                            "position": 10 //상품 위치
                            
		                }]
		            }
		        }
		    });
		    
		    brazeLogCustomEvent(idx, "RECOMMEND");
		}
		
		if("6" == idx){
		    dataLayer.push({
		        'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
		        'ecommerce': {
		        'currencyCode': 'KRW', //통화
		        'click': {
		            'actionField': { 'list': '쇼핑백_추천 상품' }, //상품 리스트명
		            'products':
		                [{
		                    "id": "SH2C3TRN634M".indexOf("_") > -1 ? "SH2C3TRN634M".split("_")[0] : "SH2C3TRN634M" , //상품코드
		                    "name": "라운드넥 슬릿 티셔츠", //상품명
		                    "brand": "SYSTEM HOMME", //상품 브랜드
		                    "category": "", //상품 카테고리
		                    
                            "position": 10 //상품 위치
                            
		                }]
		            }
		        }
		    });
		    
		    brazeLogCustomEvent(idx, "RECOMMEND");
		}
		
		if("7" == idx){
		    dataLayer.push({
		        'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
		        'ecommerce': {
		        'currencyCode': 'KRW', //통화
		        'click': {
		            'actionField': { 'list': '쇼핑백_추천 상품' }, //상품 리스트명
		            'products':
		                [{
		                    "id": "SH2C5TRN661M".indexOf("_") > -1 ? "SH2C5TRN661M".split("_")[0] : "SH2C5TRN661M" , //상품코드
		                    "name": "자카드 슬리브 티셔츠", //상품명
		                    "brand": "SYSTEM HOMME", //상품 브랜드
		                    "category": "", //상품 카테고리
		                    
                            "position": 10 //상품 위치
                            
		                }]
		            }
		        }
		    });
		    
		    brazeLogCustomEvent(idx, "RECOMMEND");
		}
		
		if("8" == idx){
		    dataLayer.push({
		        'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
		        'ecommerce': {
		        'currencyCode': 'KRW', //통화
		        'click': {
		            'actionField': { 'list': '쇼핑백_추천 상품' }, //상품 리스트명
		            'products':
		                [{
		                    "id": "SH2C4TRN651M".indexOf("_") > -1 ? "SH2C4TRN651M".split("_")[0] : "SH2C4TRN651M" , //상품코드
		                    "name": "로고 자수 티셔츠", //상품명
		                    "brand": "SYSTEM HOMME", //상품 브랜드
		                    "category": "", //상품 카테고리
		                    
                            "position": 10 //상품 위치
                            
		                }]
		            }
		        }
		    });
		    
		    brazeLogCustomEvent(idx, "RECOMMEND");
		}
		
		if("9" == idx){
		    dataLayer.push({
		        'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
		        'ecommerce': {
		        'currencyCode': 'KRW', //통화
		        'click': {
		            'actionField': { 'list': '쇼핑백_추천 상품' }, //상품 리스트명
		            'products':
		                [{
		                    "id": "SH2C3WPCT06M".indexOf("_") > -1 ? "SH2C3WPCT06M".split("_")[0] : "SH2C3WPCT06M" , //상품코드
		                    "name": "[PARIS] 울 블렌드 밴딩 와이드 팬츠", //상품명
		                    "brand": "SYSTEM HOMME", //상품 브랜드
		                    "category": "", //상품 카테고리
		                    
                            "position": 10 //상품 위치
                            
		                }]
		            }
		        }
		    });
		    
		    brazeLogCustomEvent(idx, "RECOMMEND");
		}
		
		if("10" == idx){
		    dataLayer.push({
		        'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
		        'ecommerce': {
		        'currencyCode': 'KRW', //통화
		        'click': {
		            'actionField': { 'list': '쇼핑백_추천 상품' }, //상품 리스트명
		            'products':
		                [{
		                    "id": "SH2C4TRN617M".indexOf("_") > -1 ? "SH2C4TRN617M".split("_")[0] : "SH2C4TRN617M" , //상품코드
		                    "name": "[TYPE 2] 텍스처 블록 지퍼 포켓 티셔츠", //상품명
		                    "brand": "SYSTEM HOMME", //상품 브랜드
		                    "category": "", //상품 카테고리
		                    
                            "position": 10 //상품 위치
                            
		                }]
		            }
		        }
		    });
		    
		    brazeLogCustomEvent(idx, "RECOMMEND");
		}
		
		if("11" == idx){
		    dataLayer.push({
		        'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
		        'ecommerce': {
		        'currencyCode': 'KRW', //통화
		        'click': {
		            'actionField': { 'list': '쇼핑백_추천 상품' }, //상품 리스트명
		            'products':
		                [{
		                    "id": "FL2B7HCO037LCB".indexOf("_") > -1 ? "FL2B7HCO037LCB".split("_")[0] : "FL2B7HCO037LCB" , //상품코드
		                    "name": "[100BON] 아로마콜로지 롤 온 향수", //상품명
		                    "brand": "the CASHMERE", //상품 브랜드
		                    "category": "", //상품 카테고리
		                    
                            "position": 10 //상품 위치
                            
		                }]
		            }
		        }
		    });
		    
		    brazeLogCustomEvent(idx, "RECOMMEND");
		}
		
		if("12" == idx){
		    dataLayer.push({
		        'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
		        'ecommerce': {
		        'currencyCode': 'KRW', //통화
		        'click': {
		            'actionField': { 'list': '쇼핑백_추천 상품' }, //상품 리스트명
		            'products':
		                [{
		                    "id": "SH2C3WPC533M".indexOf("_") > -1 ? "SH2C3WPC533M".split("_")[0] : "SH2C3WPC533M" , //상품코드
		                    "name": "투턱 조거 팬츠", //상품명
		                    "brand": "SYSTEM HOMME", //상품 브랜드
		                    "category": "", //상품 카테고리
		                    
                            "position": 10 //상품 위치
                            
		                }]
		            }
		        }
		    });
		    
		    brazeLogCustomEvent(idx, "RECOMMEND");
		}
		
		if("13" == idx){
		    dataLayer.push({
		        'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
		        'ecommerce': {
		        'currencyCode': 'KRW', //통화
		        'click': {
		            'actionField': { 'list': '쇼핑백_추천 상품' }, //상품 리스트명
		            'products':
		                [{
		                    "id": "SH2C1WSH701MM1".indexOf("_") > -1 ? "SH2C1WSH701MM1".split("_")[0] : "SH2C1WSH701MM1" , //상품코드
		                    "name": "드로우스트링 지퍼 포켓 셔츠", //상품명
		                    "brand": "SYSTEM HOMME", //상품 브랜드
		                    "category": "", //상품 카테고리
		                    
                            "position": 10 //상품 위치
                            
		                }]
		            }
		        }
		    });
		    
		    brazeLogCustomEvent(idx, "RECOMMEND");
		}
		
		if("14" == idx){
		    dataLayer.push({
		        'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
		        'ecommerce': {
		        'currencyCode': 'KRW', //통화
		        'click': {
		            'actionField': { 'list': '쇼핑백_추천 상품' }, //상품 리스트명
		            'products':
		                [{
		                    "id": "YS2B1HCO011WDV".indexOf("_") > -1 ? "YS2B1HCO011WDV".split("_")[0] : "YS2B1HCO011WDV" , //상품코드
		                    "name": "[DAVID'S BRANDING] 핸드 워시 기프트 세트", //상품명
		                    "brand": "FOURM THE STORE", //상품 브랜드
		                    "category": "", //상품 카테고리
		                    
                            "position": 10 //상품 위치
                            
		                }]
		            }
		        }
		    });
		    
		    brazeLogCustomEvent(idx, "RECOMMEND");
		}
		
		if("15" == idx){
		    dataLayer.push({
		        'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
		        'ecommerce': {
		        'currencyCode': 'KRW', //통화
		        'click': {
		            'actionField': { 'list': '쇼핑백_추천 상품' }, //상품 리스트명
		            'products':
		                [{
		                    "id": "SH2C3TRN637MM".indexOf("_") > -1 ? "SH2C3TRN637MM".split("_")[0] : "SH2C3TRN637MM" , //상품코드
		                    "name": "[PLAYER] 엠보 프린팅 티셔츠", //상품명
		                    "brand": "SYSTEM HOMME", //상품 브랜드
		                    "category": "", //상품 카테고리
		                    
                            "position": 10 //상품 위치
                            
		                }]
		            }
		        }
		    });
		    
		    brazeLogCustomEvent(idx, "RECOMMEND");
		}
		
		if("16" == idx){
		    dataLayer.push({
		        'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
		        'ecommerce': {
		        'currencyCode': 'KRW', //통화
		        'click': {
		            'actionField': { 'list': '쇼핑백_추천 상품' }, //상품 리스트명
		            'products':
		                [{
		                    "id": "SH2C4KCD015M".indexOf("_") > -1 ? "SH2C4KCD015M".split("_")[0] : "SH2C4KCD015M" , //상품코드
		                    "name": "스트라이프 버튼 가디건", //상품명
		                    "brand": "SYSTEM HOMME", //상품 브랜드
		                    "category": "", //상품 카테고리
		                    
                            "position": 10 //상품 위치
                            
		                }]
		            }
		        }
		    });
		    
		    brazeLogCustomEvent(idx, "RECOMMEND");
		}
		
		if("17" == idx){
		    dataLayer.push({
		        'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
		        'ecommerce': {
		        'currencyCode': 'KRW', //통화
		        'click': {
		            'actionField': { 'list': '쇼핑백_추천 상품' }, //상품 리스트명
		            'products':
		                [{
		                    "id": "SH2C3WTO639MM".indexOf("_") > -1 ? "SH2C3WTO639MM".split("_")[0] : "SH2C3WTO639MM" , //상품코드
		                    "name": "[PLAYER] 백 플랩 티셔츠", //상품명
		                    "brand": "SYSTEM HOMME", //상품 브랜드
		                    "category": "", //상품 카테고리
		                    
                            "position": 10 //상품 위치
                            
		                }]
		            }
		        }
		    });
		    
		    brazeLogCustomEvent(idx, "RECOMMEND");
		}
		
		if("18" == idx){
		    dataLayer.push({
		        'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
		        'ecommerce': {
		        'currencyCode': 'KRW', //통화
		        'click': {
		            'actionField': { 'list': '쇼핑백_추천 상품' }, //상품 리스트명
		            'products':
		                [{
		                    "id": "SH2C4TTO648M".indexOf("_") > -1 ? "SH2C4TTO648M".split("_")[0] : "SH2C4TTO648M" , //상품코드
		                    "name": "[TYPE 2] 텍스처 블록 드로우스트링 티셔츠", //상품명
		                    "brand": "SYSTEM HOMME", //상품 브랜드
		                    "category": "", //상품 카테고리
		                    
                            "position": 10 //상품 위치
                            
		                }]
		            }
		        }
		    });
		    
		    brazeLogCustomEvent(idx, "RECOMMEND");
		}
		
		if("19" == idx){
		    dataLayer.push({
		        'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
		        'ecommerce': {
		        'currencyCode': 'KRW', //통화
		        'click': {
		            'actionField': { 'list': '쇼핑백_추천 상품' }, //상품 리스트명
		            'products':
		                [{
		                    "id": "SH2C4TRN649M".indexOf("_") > -1 ? "SH2C4TRN649M".split("_")[0] : "SH2C4TRN649M" , //상품코드
		                    "name": "[TYPE 2] 텍스처 블록 드로우스트링 포켓 티셔츠", //상품명
		                    "brand": "SYSTEM HOMME", //상품 브랜드
		                    "category": "", //상품 카테고리
		                    
                            "position": 10 //상품 위치
                            
		                }]
		            }
		        }
		    });
		    
		    brazeLogCustomEvent(idx, "RECOMMEND");
		}
		
		if("20" == idx){
		    dataLayer.push({
		        'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
		        'ecommerce': {
		        'currencyCode': 'KRW', //통화
		        'click': {
		            'actionField': { 'list': '쇼핑백_추천 상품' }, //상품 리스트명
		            'products':
		                [{
		                    "id": "TG2C1HCO004LRA".indexOf("_") > -1 ? "TG2C1HCO004LRA".split("_")[0] : "TG2C1HCO004LRA" , //상품코드
		                    "name": "[SALTRAIN] 프레그런스 롤온 쿨링 오일", //상품명
		                    "brand": "TOM GREYHOUND", //상품 브랜드
		                    "category": "", //상품 카테고리
		                    
                            "position": 10 //상품 위치
                            
		                }]
		            }
		        }
		    });
		    
		    brazeLogCustomEvent(idx, "RECOMMEND");
		}
		
	}
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

function notiAlert(){
	var msg = "원클릭결제  서비스가 원활하지 않습니다. <br><br>모바일앱을 이용하시거나 <br>'일반결제' 또는 '주문서 내 원클릭결제'를<br>이용해주시길 바랍니다.<br><br> 빠른 시일내에 원활한 서비스를 위해<br> 최선을 다하겠습니다.<br> 이용에 불편을 드려 죄송합니다.";
	var cla = new customLayerAlert(msg);
	cla.confirmAction = function(){
	$("#productLayer .layerBg").removeClass("white");
	$("#productLayer").hide();
	$(".popwrap").hide();
                };  
}

</script>
<!--sub_container-->
        <div class="sub_container ">
            <!--order wrap-->
            <div class="shopping_cart_tab1807 tab_a">
                <!-- 장바구니개편 -->
                <ul class="tab3">
                    <li>
                        <a href="#;" name="cartDivision" data-division="" onclick="GA_Event('쇼핑백', '탭', '택배');"><span class="delt_ico"></span>택배 (${total})</a>
                    </li>
                    <li>
                        <a href="#;" name="cartDivision" data-division="store" onclick="GA_Event('쇼핑백', '탭', '매장수령');" ><span class="spt_ico"></span>매장수령 (0)</a>
                    </li>
                    <li>
                        <a href="#;" name="cartDivision" data-division="quick" onclick="GA_Event('쇼핑백', '탭', '퀵배송');" ><span class="quk_ico"></span>퀵배송(0)</a>
                    </li>
                    </ul>
                <!-- //장바구니개편 -->
            </div>
            
            <div class="orderwrap1807">             
                <div class="tbl_info_wrap">
                    <p class="cart_top_text">
                       </p>
                    
                    <div class="fourpm_pd_ck">
                        <div class="input_wrap">
                        </div>
                    </div>
                    </div>
                <!--shoppingback table-->
                <div class="tblwrap">
                    <table class="tbl_ltype">
                        <caption>
                            쇼핑백</caption>
                        <colgroup>
                            <col style="width: 10px;" />
                            <col />
                            <col style="width: 120px" />
                            <col style="width: 105px" />
                            <col style="width: 140px" />
                            <col style="width: 110px" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">
                                	<!-- 2019.11.07 쇼핑백 진입 시 선택 상품 없도록 수정 -->
                                	<input type="checkbox" id="entryCheckAll" value="cartlist">
                                </th>
                                <th scope="col">상품정보</th>
                                <th scope="col">수량</th>
                                <th scope="col">판매가</th>
                                <th scope="col">적립율</th>
                                <th scope="col">선택</th>
                            </tr>
                        </thead>
                        <tbody>
<!--                         여기부터 -->

							<!-- c.mid, pid, psize, pcolor, pamount 
							d.bname, pname, pprice, clarge, cmedium, csmall, t01_imageurl  -->
						<c:forEach var="c" items="${cartList}" varStatus="statusNm">
							<c:set var="d" value="${detailList[statusNm.index]}"></c:set>
                            <tr name="entryProductInfo" data-pk="10687045664812" data-deliverykind="" data-outofstock="false" data-category="ME011"> 
                       <td class="frt">
                       	   <!-- 2019.11.07 쇼핑백 진입 시 선택 상품 없도록 수정 -->
                           <input type="checkbox" name="cartlist" data-pk="10687045664812" data-division="" data-deliverykind="" value="9">
                       </td>
                       <td class="pt_list_wrap">
                           <!-- pt_list_all -->
                           <div class="pt_list_all">
                                <a href="/product/productDetail?pid=${c.pid}" onclick="javascript:setEcommerceData('0', 'Click ADD');GA_Event('쇼핑백','상품','${d.pname}');">
                                <img src="${d.t01_imageurl}" alt="" />
                                </a>
                               <div class="tlt_wrap">
                                   <a href="/product/productDetail?pid=${c.pid}" class="basket_tlt" onclick="javascript:setEcommerceData('0', 'Click ADD');GA_Event('쇼핑백','상품','${d.pname}');"> 
                                       <span class="tlt">${d.bname}</span> 
                                       <span class="sb_tlt">
                                            ${d.pname}</span>
                                   </a>
    
                                   <p class="color_op">
                                       
                                               color : ${c.pcolor}<span class="and_line">/</span>
                                               
                                                       size : ${c.psize}</p>
                            
                            
                                <div class="option_wrap">
                                <a href="#none" class="btn_option" id="optOpenLayer^9^TH2C3TRN644N_CR" onclick="GA_Event('쇼핑백','옵션변경', '${d.pname}')">옵션변경</a>
                                    </div>
                                </div>
                            </div>
                            <!-- //pt_list_all-->
                            </td>
                            <td class="al_middle">
                                <form id="updateCartForm${statusNm.index}" data-cart="{&quot;cartCode&quot; : &quot;371497467&quot;,&quot;productPostPrice&quot;:&quot;155000.0&quot;,&quot;productName&quot;:&quot;[온라인 단독] 세미 오버핏 솔리드 티셔츠&quot;}" action="/ko/shoppingbag/update" method="post">
                                	<input type="hidden" name="entryNumber" value="${statusNm.index}" />
                                    <input type="hidden" name="productCode" value="${c.pid}" />
                                    <input type="hidden" name="initialQuantity" value="${c.pamount}" />
                                    <input type="hidden" name="chgProductCode" value="" />
                                    <input type="hidden" name="curSize" value="${c.psize}" />
                                    <input type="hidden" name="storeId" value="" />
                                    <input type="hidden" name="storePickupDate" value="" />
                                    <input type="hidden" name="deliveryKind" value="" />
                                    <input type="hidden" name="cartDivision" value="" />
                                    <!-- qty_sel -->
                                    <span class="qty_sel num">
                                        <a href="#none" onMouseDown="javascript:AEC_F_D('${c.pid}','o',1);" class="left" onclick="GA_Event('쇼핑백', '수량', '-');">이전 버튼</a> 
                                            <input id="quantity${statusNm.index}" name="quantity" type="text" class="mr0" value="1" size="1" maxlength="3"/><a href="#none" onMouseDown="javascript:AEC_F_D('${c.pid}','i',1);" class="right" onclick="GA_Event('쇼핑백', '수량', '+');">다음 버튼</a>
                                        </span>
                                    <!-- //qty_sel -->
                                    <a href="#none" id="QuantityProduct_${statusNm.index}" class="btn wt_ss qty_w mr0">변경</a>
                                        <div>
<!-- <input type="hidden" name="CSRFToken" value="2e4f730b-79fa-408e-b072-425a73f94a7c" /> -->
</div></form></td>
                            <td class="al_middle">
                                <!-- Price -->
                                <div class="price_wrap">
                                	<span>₩<fmt:formatNumber value="${d.pprice }" type="number" pattern="###,###" /></span> <input type="hidden" name="checkZeroPrice" value="${d.pprice }.0" />
                                </div> <!-- //Price -->
                            </td>
                            <td class="al_middle">
                                    <span class="earn">5% (한섬마일리지)</span>
                                    <br>            
                                    <span class="earn">0.1% (H.Point)</span>            
                                </td>
                            <td class="al_middle">
                                <!-- Button size -->
                                <div class="btn_wrap">
                                    <a href="#none" class="btn gray_ss" onclick="callWishListClick('${d.pname}',$(this),'${c.pid }');" data-value="0">위시리스트</a>
                                        <a href="javascript:deleteProduct('${c.pid}');" id="RemoveProduct_${statusNm.index}" class="btn wt_ss" onclick="GA_Event('쇼핑백','삭제','${d.pname}');">삭제</a>
                                    </div> <!-- //Button size -->
                            </td>
                            </tr>
                            <!-- Info wrap -->
                            <tr>
                                <td colspan="6" class="basket_wrap">
                                    <!-- Info -->
									<!--  옵션변경 버튼 누를 시 나오는 상품 디테일 -->
                                    <div class="basket_info">
                                        <span class="btn_arr">위치아이콘</span>
                                        <div class="info">
                                            <!-- Products -->
                                            <div class="pt_list" id="pt_list_${statusNm.index}">
											<a href="/product/productDetail?pid=${c.pid}">
											<img src="${d.t01_imageurl}" alt="">
												</a>
											<div class="tlt_wrap">
												<a href="/product/productDetail?pid=${c.pid}" class="basket_tlt">
											        <span class="tlt">${d.bname}</span>
											        <span class="sb_tlt">${d.pname}</span>
											    </a>
												<!-- color_size -->
												<dl class="cs_wrap">
													<dt>COLOR</dt>
													<dd>
														<div class="cl_select">
														<c:forEach var ="f" items="${colorMap[statusNm.index]}" varStatus="status">
														<a href="javascript:void(0);" onclick="setOptions(this, '0', '${c.pid}', 'style');" class="beige" style="background:${f.ccolorcode} url('${f.cimage1 }">${c.pcolor}</a>
														</c:forEach>
														
<%-- 																		<a href="javascript:void(0);" onclick="setOptions(this, '0', '${c.pid}', 'style');" class="beige on" style="background:#000000 url('http://newmedia.thehandsome.com/SH/2C/SS/SH2C4TRN654M_BK_C01.jpg/dims/resize/18x18')">BLACK</a> --%>
																		<span class="cs_sel1807">${c.pcolor}</span>
														</div>
													</dd>
													<dt>SIZE</dt>
													<dd style="width: 90%; height: 100%;">
														<div class="sz_select">
														<a href="javascript:void(0);" onclick="setOptions(this, '0', '${c.pid}', 'size');" class="on" style="line-height: 15px;">F</a>
																	</div>
														</dd>
												</dl>
												<!-- //color_size -->
											</div>
											
											</div>
                                            <!-- //Products -->
                                            <!-- btns -->
                                            <div class="btns">
                                                <a href="#none" class="btn wt_ss mr0" id="UpdateCart_${statusNm.index}">변경</a>
                                                <a href="#none" class="btn wt_ss mt10 mr0" id="optCancelLayer_${statusNm.index}">취소</a>
                                                <a href="#none" class="btn_close" id="optCloseLayer_${statusNm.index}">닫기</a>
                                            </div>
                                            <!-- //btns -->
                                        </div>
                                    </div> <!-- //Info -->
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" class="basket_wrap">
                                    </td>
                            </tr>
                            
                            
                            <!-- AceCounter eCommerce (Product_Detail) v7.5 Start -->
                            <!-- Data Allocation (Product_Detail) -->
                            <script language='javascript' type="text/javascript">
                                _A_amt[_ace_countvar]="${d.pprice}"; 
                                _A_nl[_ace_countvar]="${c.pamount}";   
                                _A_pl[_ace_countvar]="${c.pid}";       
                                _A_pn[_ace_countvar]="${d.pname}"; 
                                _A_ct[_ace_countvar]="${d.bname}";  
                                _ace_countvar++;
                            </script>
                            <!-- AceCounter eCommerce (Cart_InOut) v7.5 End -->
                            <!-- //Info wrap -->
<!--                             여기까지 -->
                            </c:forEach>     
                                    </tbody>
                    </table>
                </div>
                <!--// shoppingback table-->
                <!--Total wrap-->
                <div class="total_wrap">
                    <!-- total -->
                    <div class="total_price_wrap">
                        <dl>
                                <dt>
                                    상품 합계</dt>
                                <dd>
                                <!-- 여기 총 금액 변경되는거.. -->
                                    <span id="cartDataSubtotal">₩0</span>
			</dd>
                                <dt class="delch_wrap">
                                    <p class="tlt_ship">배송비</p>
                                    <!--delivery charge layer popup-->
                                    <div class="delch_box" style="display: none;">
                                        <span class="arr">위치아이콘</span>
                                        <ul class="bul_sty01_li">
                                            <li>쿠폰/바우처 할인금액 및 한섬마일리지/H.Point 사용을 제외한 실 결제금액 기준 <strong>3만원 미만 결제 시 2,500원 배송비가 부과</strong> 됩니다.(3만원 이상 구매 시 무료배송)</li>
                                            <li>도서산간 지역은 배송비가 추가 될 수 있습니다.</li>
                                            <li>한섬마일리지, H.Point, e-money로 배송비 결제가 불가합니다.</li>
                                        </ul>
                                    </div>
                                    <!--//delivery charge layer popup-->
                                </dt>
                                <dd>
                                    <span id="cartDataDeliveryCost">₩ 0</span>
				</dd>
                            </dl>
                        <dl class="total ">
                            <dt>
                                합계</dt>
                            <dd>
                                <span id="cartDataTotalPrice">₩2,615,000</span>
			</dd>
                        </dl>
                    </div>
                    <div class="total_count1807">
                        <p>총 <span id="selectProductCount">${total}</span>개 상품</p>
                        </div>
                    <!-- //total -->
                </div>
                <!--//Total wrap-->
                <!--button wrap-->
                <div class="btnwrap order" id="checkout_btn_wrap">
                    <a href="#;" onclick="selectRemove();"><input value="선택상품삭제" class="btn wt"type="button" /></a>
                    <a href="#;" onclick="checkoutPage();">
                        <input value="선택상품 주문하기" class="btn gray mr0" type="button" />
                        </a>
                   
                     </div>
                    </div>
            <!--//order wrap-->
        </div>
        <!--//sub_container-->
</span>
        <!-- // 장바구니개편 -->
        
        
        <!--Guide table-->
        <div class="gd_wrap mt60">
            <dl class="shoppingbag_list">
                <dt>
                    쇼핑백 이용안내</dt>
                <dd class="shoppingbag_list_text">
                    <ul class="bul_sty01_li">
                        <li>쇼핑백에 담긴 상품은 30일 동안 보관됩니다. 30일이 지난 상품 자동 삭제됩니다.<br />더 오래 보관하고 싶은 상품은 위시리스트에 담아주세요.</li>
                        <li>쇼핑백에 최대 50개까지 상품 보관이 가능하며, 실제 구매 시에는 가격이나 혜택이 변동될 수 있습니다.</li>
                        
<li>쇼핑백에 담은 상품이 판매종료가 되었을 경우 자동 삭제 됩니다.</li>
						<li>쿠폰은 배송&결제정보 화면에서 입력 할 수 있습니다.</li>
                        <li>상품별 지급율에 따라 한섬마일리지 및 H.POINT가 적립됩니다. 배송완료 10일 이후 적립되며 실 결제금액기준입니다.</li>
                        	<li>해외 배송을 원할 경우 더한섬닷컴의 영문 혹은 중문 서비스를 이용해 주시기 바랍니다.</li>
                            <li>
                            </li>
                        </ul>
                </dd>
            </dl>
            <dl class="gd_list">
				<dt>카드행사 혜택</dt>
				<dd>
					<ul class="gd_btn1807">
						<li>
							<a href="#;" rel="benefit_wrap1807">
								<p>무이자 할부</p>
								<span>자세히 보기 &gt;</span>
							</a>
						</li>
						<li>
							<a href="#;" rel="benefit2_wrap1807">
								<p>청구할인</p>
								<span>자세히 보기 &gt;</span>
							</a>
						</li>
						<li>
							<a href="#;" rel="benefit3_wrap1807">
								<p>즉시할인</p>
								<span>자세히 보기 &gt;</span>
							</a>
						</li>
					</ul>
				</dd>
      		</dl>
      		</div>
        <!--//Guide table-->
        
        <form id="ordersheetCloneForm" name="orderSheetCloneForm" action="/ko/shoppingbag/checkout" method="get"><input type="hidden" id="ordersheetEntryNumber" name="ordersheetEntryNumber" value="" />
			<input type="hidden" id="ordersheetCartDivision" name="ordersheetCartDivision" value="" />
		<div>
<input type="hidden" name="CSRFToken" value="2e4f730b-79fa-408e-b072-425a73f94a7c" />
</div></form><!-- layer pop 1 -->
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
<div class="benefit_wrap1807 popwrap" style="top: 1806.2px; position: absolute; left: 201px; z-index: 101; display:none;">
	<div class="pop_tltwrap">
		<h3>무이자 할부</h3>
	</div>
	<!--card event tab-->
	<div class="tab_a m2" id="ce_tab">
		<ul>
			<li><a href="#;" class="active">무이자 할부</a></li>
			<li><a href="#;" class="">부분 무이자 할부</a></li>
		</ul>
	</div>
	<!--//card event tab-->
	<!--card event tab container-->
	<div class="ce_tab_container mt40">
		<!--tab contents 1-->
		<div style="display: block;">
			<!--Table wrap-->
			<table class="cnt_type1">
				<caption>무이자 할부 행사</caption>
				<colgroup>
						<col style="width: 155px">
						<col style="width: 370px">
						<col>
				</colgroup>
				<tbody>
<tr>
						<th scope="row"><span class="card"><img src="/medias/shinhan.jpg?context=bWFzdGVyfHJvb3R8MjY1N3xpbWFnZS9qcGVnfGhkZS9oMmIvODgxNDE4MTUxNTI5NC5qcGd8NTAwMDYxM2ZmZmRlZGFhZDQ0ODNmODJjZTg2OTE3MGI3OWQ2ZmE3YzI0ZjA3MDY3NzIxYWVhNmY3NDQyYWUzMA"   alt="신한카드" /></span></th>
						<td><b>신한카드 5만원이상 결제시 2~7개월 무이자 할부</b><br />
대상: 신한카드 전 회원<br />
(신한BC 제외/ 법인,기프트,체크,선불카드 제외)
</td>
						<td>행사기간 : 2022.05.01 ~ 2022.05.31</td>
					</tr>
		<tr>
						<th scope="row"><span class="card"><img src="/medias/SAMSUNG.jpg?context=bWFzdGVyfHJvb3R8MzIxOXxpbWFnZS9qcGVnfGgzZC9oNGQvODgxNDE4MTYxMzU5OC5qcGd8ZGY1NDJiM2U1YWNmNGE5MTJkOTA0MTAxMDliMDc4ZjRlNTJmZjJlOTkxOTQzZTEwMDcxZWU2NGU2MjJmMWE2Mw"   alt="삼성카드" /></span></th>
						<td><b>삼성카드 5만원이상 결제시 2~6개월 무이자 할부</b><br />
대상: 삼성카드 전 회원<br />
(법인,기프트,체크,선불카드 제외)</td>
						<td>행사기간 : 2022.05.01 ~ 2022.05.31</td>
					</tr>
		<tr>
						<th scope="row"><span class="card"><img src="/medias/BC.jpg?context=bWFzdGVyfHJvb3R8MjQ1OHxpbWFnZS9qcGVnfGhmMi9oMGQvODgxNDE4MTIyMDM4Mi5qcGd8MjZlZGU2ZGQyNDBkYzU5YmY2NWY0MDU3NDc1OTA0YWI5NmM4NDJjMDFiYjBiYjBjY2FhZjhmMzg3ZmE5NGU5Yw"   alt="비씨카드" /></span></th>
						<td><b>비씨카드 5만원이상 결제시 2~7개월 무이자 할부</b><br /> 
대상: 비씨카드 전 회원<br />(법인,기프트,체크,선불카드 제외)</td>
						<td>행사기간 : 2022.05.01 ~ 2022.05.31</td>
					</tr>
		<tr>
						<th scope="row"><span class="card"><img src="/medias/HYUNDAI.jpg?context=bWFzdGVyfHJvb3R8MjYxMHxpbWFnZS9qcGVnfGg1ZC9oN2MvODgxNDE4MTcxMTkwMi5qcGd8YmM5ZWY0ZjlhODlkMzdmMjYyNmY4NjQ4OWU5NWVjOWFlMGY4ODIwYzZlNjA0MjBlNDkwNWI0ZDllYThjMWE5Mw"   alt="현대카드" /></span></th>
						<td><b>현대카드 5만원이상 결제시 2~7개월 무이자 할부</b><br />
대상: 현대카드 전 회원<br />
(법인,기프트,체크,선불카드 제외)</td>
						<td>행사기간 : 2022.05.01 ~ 2022.05.31</td>
					</tr>
		<tr>
						<th scope="row"><span class="card"><img src="/medias/kucmin.jpg?context=bWFzdGVyfHJvb3R8MzMwM3xpbWFnZS9qcGVnfGgyZS9oMzQvODgxNDE4MTAyMzc3NC5qcGd8MjM1YjEyN2I4OTljMGIxYzY3MjhjNDhkZWMyOTE5ODZjYmRiYWExNDdhOWZmNDQ3ZWNhNGIxZjYwYzk2MDA4Zg"   alt="국민카드" /></span></th>
						<td><b>KB국민카드 5만원이상 결제시 2~7개월 무이자 할부</b><br />
대상: KB국민카드 전 회원<br />
(NH농협, 국민BC 제외/ 법인,기프트,체크,선불카드 제외)</td>
						<td>행사기간 : 2022.05.01 ~ 2022.05.31</td>
					</tr>
		<tr>
						<th scope="row"><span class="card"><img src="/medias/hanacard.gif?context=bWFzdGVyfHJvb3R8MTkzNXxpbWFnZS9naWZ8aDYwL2hmYi84ODE0MDU0OTY1Mjc4LmdpZnxhMGM5OWY0MDdhNDhjYzkwOTdiMzhkM2VmMDQ2YTI0NTAyNDBjZTljNTdiYzk4YWRhZmI0NjBhOWRhNzRiMGYw"   alt="하나카드" /></span></th>
						<td><b>하나카드 5만원이상 결제시 2~8개월 무이자 할부</b><br />
대상: 하나카드 전 회원 (구 하나SK, 구 외환)<br />
(하나BC카드 포함/법인,기프트,체크,선불카드 제외)</td>
						<td>행사기간 : 2022.05.01 ~ 2022.05.31</td>
					</tr>
		<tr>
						<th scope="row"><span class="card"><img src="/medias/NH.jpg?context=bWFzdGVyfHJvb3R8Mzk3OXxpbWFnZS9qcGVnfGg4ZS9oMzYvODgxNDE4MTkwODUxMC5qcGd8ZWVlNmY1OWM0NDdmMjg2M2Y4NGZkNDZjYThmOTVkMWNmY2QwYWNkOWI1ODc5YTdiMTc5MjY4MThiZTkzYzNmMw"   alt="NH카드" /></span></th>
						<td><b>NH농협카드 5만원이상 결제시 2~8개월 무이자 할부</b><br />
대상: NH농협카드 전 회원<br />
(NH농협BC카드 포함/ 법인,기프트,체크,선불카드 제외)
</td>
						<td>행사기간 : 2022.05.01 ~ 2022.05.31</td>
					</tr>
		<tr>
						<th scope="row"><span class="card"><img src="/medias/LOTTE.jpg?context=bWFzdGVyfHJvb3R8MzI3MXxpbWFnZS9qcGVnfGhiMy9oNDcvODgxNDE4MTgxMDIwNi5qcGd8MDliOThkNzA1ZDc2ZDE4MzZhYmUzYjI2MDMxZDk0NGU3OTVjYzBhYTA1MmMzMjAyZmE0Y2U4OTZlNTU3NDU2Zg"   alt="롯데카드" /></span></th>
						<td><b>롯데카드 5만원이상 결제시 2~4개월 무이자 할부</b><br />
대상:롯데카드 전 회원<br />
(법인,기프트,체크,선불카드 제외)</td>
						<td>행사기간 : 2022.05.01 ~ 2022.05.31</td>
					</tr>
		</tbody>
			</table>
		</div>
		<!--//tab contents 1-->
		<!--tab contents 2-->
		<div style="display: none;">
			<!--Table wrap-->
			<table class="cnt_type1">
				<caption>부분 무이자 할부 행사</caption>
				<colgroup>
					<col style="width: 155px">
					<col style="width: 370px">
					<col>
				</colgroup>
				<tbody>
<tr>
						<th scope="row"><span class="card"><img src="/medias/shinhan.jpg?context=bWFzdGVyfHJvb3R8MjY1N3xpbWFnZS9qcGVnfGhkZS9oMmIvODgxNDE4MTUxNTI5NC5qcGd8NTAwMDYxM2ZmZmRlZGFhZDQ0ODNmODJjZTg2OTE3MGI3OWQ2ZmE3YzI0ZjA3MDY3NzIxYWVhNmY3NDQyYWUzMA" alt="신한카드" /></span></th>
						<td><b>10개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3,4회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)</td>
						<td>행사기간 : 2022.05.01 ~ 2022.05.31</td>
					</tr>
		<tr>
						<th scope="row"><span class="card"><img src="/medias/SAMSUNG.jpg?context=bWFzdGVyfHJvb3R8MzIxOXxpbWFnZS9qcGVnfGgzZC9oNGQvODgxNDE4MTYxMzU5OC5qcGd8ZGY1NDJiM2U1YWNmNGE5MTJkOTA0MTAxMDliMDc4ZjRlNTJmZjJlOTkxOTQzZTEwMDcxZWU2NGU2MjJmMWE2Mw" alt="삼성카드" /></span></th>
						<td><b>10개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3,4회차 고객 부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)</b></td>
						<td>행사기간 : 2022.05.01 ~ 2022.05.31</td>
					</tr>
		<tr>
						<th scope="row"><span class="card"><img src="/medias/SAMSUNG.jpg?context=bWFzdGVyfHJvb3R8MzIxOXxpbWFnZS9qcGVnfGgzZC9oNGQvODgxNDE4MTYxMzU5OC5qcGd8ZGY1NDJiM2U1YWNmNGE5MTJkOTA0MTAxMDliMDc4ZjRlNTJmZjJlOTkxOTQzZTEwMDcxZWU2NGU2MjJmMWE2Mw" alt="삼성카드" /></span></th>
						<td><b>12개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3,4,5회차 고객 부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)</b>
</td>
						<td>행사기간 : 2022.05.01 ~ 2022.05.31</td>
					</tr>
		<tr>
						<th scope="row"><span class="card"><img src="/medias/BC.jpg?context=bWFzdGVyfHJvb3R8MjQ1OHxpbWFnZS9qcGVnfGhmMi9oMGQvODgxNDE4MTIyMDM4Mi5qcGd8MjZlZGU2ZGQyNDBkYzU5YmY2NWY0MDU3NDc1OTA0YWI5NmM4NDJjMDFiYjBiYjBjY2FhZjhmMzg3ZmE5NGU5Yw" alt="비씨카드" /></span></th>
						<td><b> 우리BC 10개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)
</td>
						<td>행사기간 : 2022.05.01 ~ 2022.05.31</td>
					</tr>
		<tr>
						<th scope="row"><span class="card"><img src="/medias/BC.jpg?context=bWFzdGVyfHJvb3R8MjQ1OHxpbWFnZS9qcGVnfGhmMi9oMGQvODgxNDE4MTIyMDM4Mi5qcGd8MjZlZGU2ZGQyNDBkYzU5YmY2NWY0MDU3NDc1OTA0YWI5NmM4NDJjMDFiYjBiYjBjY2FhZjhmMzg3ZmE5NGU5Yw" alt="비씨카드" /></span></th>
						<td><b>우리BC 12개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3,4회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)
</td>
						<td>행사기간 : 2022.05.01 ~ 2022.05.31</td>
					</tr>
		<tr>
						<th scope="row"><span class="card"><img src="/medias/kucmin.jpg?context=bWFzdGVyfHJvb3R8MzMwM3xpbWFnZS9qcGVnfGgyZS9oMzQvODgxNDE4MTAyMzc3NC5qcGd8MjM1YjEyN2I4OTljMGIxYzY3MjhjNDhkZWMyOTE5ODZjYmRiYWExNDdhOWZmNDQ3ZWNhNGIxZjYwYzk2MDA4Zg" alt="국민카드" /></span></th>
						<td><b>10개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)</td>
						<td>행사기간 : 2022.05.01 ~ 2022.05.31</td>
					</tr>
		<tr>
						<th scope="row"><span class="card"><img src="/medias/kucmin.jpg?context=bWFzdGVyfHJvb3R8MzMwM3xpbWFnZS9qcGVnfGgyZS9oMzQvODgxNDE4MTAyMzc3NC5qcGd8MjM1YjEyN2I4OTljMGIxYzY3MjhjNDhkZWMyOTE5ODZjYmRiYWExNDdhOWZmNDQ3ZWNhNGIxZjYwYzk2MDA4Zg" alt="국민카드" /></span></th>
						<td><b>12개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3,4회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)</td>
						<td>행사기간 : 2022.05.01 ~ 2022.05.31</td>
					</tr>
		<tr>
						<th scope="row"><span class="card"><img src="/medias/hanacard.gif?context=bWFzdGVyfHJvb3R8MTkzNXxpbWFnZS9naWZ8aDYwL2hmYi84ODE0MDU0OTY1Mjc4LmdpZnxhMGM5OWY0MDdhNDhjYzkwOTdiMzhkM2VmMDQ2YTI0NTAyNDBjZTljNTdiYzk4YWRhZmI0NjBhOWRhNzRiMGYw" alt="하나카드" /></span></th>
						<td><b>10개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)</td>
						<td>행사기간 : 2022.05.01 ~ 2022.05.31</td>
					</tr>
		<tr>
						<th scope="row"><span class="card"><img src="/medias/hanacard.gif?context=bWFzdGVyfHJvb3R8MTkzNXxpbWFnZS9naWZ8aDYwL2hmYi84ODE0MDU0OTY1Mjc4LmdpZnxhMGM5OWY0MDdhNDhjYzkwOTdiMzhkM2VmMDQ2YTI0NTAyNDBjZTljNTdiYzk4YWRhZmI0NjBhOWRhNzRiMGYw" alt="하나카드" /></span></th>
						<td><b>12개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3,4회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)</td>
						<td>행사기간 : 2022.05.01 ~ 2022.05.31</td>
					</tr>
		<tr>
						<th scope="row"><span class="card"><img src="/medias/shinhan.jpg?context=bWFzdGVyfHJvb3R8MjY1N3xpbWFnZS9qcGVnfGhkZS9oMmIvODgxNDE4MTUxNTI5NC5qcGd8NTAwMDYxM2ZmZmRlZGFhZDQ0ODNmODJjZTg2OTE3MGI3OWQ2ZmE3YzI0ZjA3MDY3NzIxYWVhNmY3NDQyYWUzMA" alt="신한카드" /></span></th>
						<td><b>12개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3,4,5회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)</td>
						<td>행사기간 : 2022.05.01 ~ 2022.05.31</td>
					</tr>
		</tbody>
				</table>
				<!--//Table wrap-->
			</div>
			<!--//tab contents 2-->
			<!--//Table wrap-->
			<ul class="bul_sty01_li mt40">
				<li>ARS 무이자 할부는 해당 카드사 ARS 번호로 사전 신청을 하신 경우에 한하여 무이자 혜택이적용됩니다.<br>(ARS 부문 무이자 할부 포함)</li>
				<li>상기 부분 무이자 할부는 5만원 이상 결제 시 자동 적용되며, 결제창에는 무이자 표시가 되지 않을 수 있습니다.</li>
				<li>법인 / 체크 / 선불 / 기프트 / 은행 계열 카드는 제외됩니다.</li>
				<li>고객 부담 수수료는 해당 카드사로 문의 바랍니다.</li>
				<li>본 행사는 카드사 사정에 따라 일부 내용이 변경 또는 중단될 수 있습니다.</li>
			</ul>			
			<p class="btnwrap">
				<a href="#;" class="btn gray close_btn">확인</a>
			</p>
			<a href="#;" class="btn_close"><img src="/resources/_ui/desktop/common/images/popup/ico_close.png" alt="닫기"></a>
	</div>
	<!--//card event tab container-->
</div>
<div class="benefit2_wrap1807 popwrap" style="top: 2295.2px; position: absolute; left: 201px; z-index: 101; display: none;">
	<div class="pop_tltwrap">
		<h3>청구할인 행사</h3>
	</div>
	<!--Table wrap-->
	<table class="cnt_type1">
		<caption>청구할인 행사</caption>
		<colgroup>
				<col style="width: 155px">
				<col style="width: 370px">
				<col>
		</colgroup>
		<tbody>
</tbody>
	</table>
	<!--//Table wrap-->
	<ul class="bul_sty01_li mt40">
			<li>법인/선불/기프트/은행 계열 카드는 제외됩니다.</li>
			<!-- ><li>상기 청구할인 행사는 5만원 이상 결제 시 자동 적용되며, 결제창에는 표시가 되지 않을 수 있습니다.</li> -->
			<li>본 행사는 카드사 사정에 따라 일부 내용이 변경 또는 중단될 수 있습니다.</li>
	</ul>
	<p class="btnwrap">
		<a href="#;" class="btn gray close_btn">확인</a>
	</p>
	<a href="#;" class="btn_close"><img src="/resources/_ui/desktop/common/images/popup/ico_close.png" alt="닫기"></a>
</div>
<div class="benefit3_wrap1807 popwrap" style="top: 2336.7px; position: absolute; left: 201px; z-index: 101; display: none;">
	<div class="pop_tltwrap">
		<h3>즉시할인 행사</h3>
	</div>
		<!--Table wrap-->
		<table class="cnt_type1">
				<caption>즉시할인 행사</caption>
				<colgroup>
						<col style="width: 155px">
						<col style="width: 370px">
						<col>
				</colgroup>
				<tbody>
</tbody>
		</table>
		<!--//Table wrap-->
		<div id="nowSale1Img" style="display: none;"><img src="/_ui/desktop/common/images/paynow.jpg" alt="paynow" width="100%"></div>
		<ul class="bul_sty01_li" style="display:none" id="nowSale1">
			<li>선착순 1,000명 대상 행사로, 조기 종료될 수 있습니다.</li>
			<li>전액 취소될 경우에 한하여 할인 혜택이 복원됩니다.</li>
			<li>PAYNOW로 결제하는 경우 무이자 할부는 PAYNOW 정책에 따라 진행됩니다.</li>
			<li>결제문의 : 페이나우 고객센터 (1544-7772)</li>
		</ul>
		<ul class="bul_sty01_li mt40" id="nowSale2" style="display:none;">
			<li>법인/체크/선불/기프트/은행 계열 카드는 제외됩니다.</li>
			<li>상기 청구할인 행사는 5만원 이상 결제 시 자동 적용되며, 결제창에는 표시가 되지 않을 수 있습니다.</li>
			<li>본 행사는 카드사 사정에 따라 일부 내용이 변경 또는 중단될 수 있습니다.</li>
		</ul>
		<p class="btnwrap">
			<a href="#;" class="btn gray close_btn">확인</a>
		</p>
		<a href="#;" class="btn_close"><img src="/resources/_ui/desktop/common/images/popup/ico_close.png" alt="닫기"></a>
</div>
<!-- layer pop 1 -->
            <div class="popwrap w_type_2" id="restockReminder" style="width:450px;display:none;">
                <div class="pop_tltwrap mb20">
                    <h3>재입고 알림 신청</h3>
                </div>
                <div class="pop_cnt pop_con_restock1904">
                    <div class="item_box" id="rewareHousingDiv">
                        <input type="hidden" id="popupHProduct" value="" />
                        <div class="pt_list_all">
                            <img src="/_ui/desktop/common/images/popup/cart_set_img1.jpg" id="popupProductImageS01" alt="" />
                            <div class="tlt_wrap">
                                <div class="basket_tlt">
                                    <span class="tlt" id="popupBrandName"></span>
                                    <span class="sb_tlt" id="popupProductName"></span>
                                </div>
                                <p class="color_op" id="popupProductColor"></p>
                                <input type="hidden" id="popupProductSize" />
                                <p class="mt5" id="popupProductPrice"></p>
                            </div>
                        </div>
                    </div>
                    <div class="input_box1904">
                        <p class="txt1904">재입고 알림을 받으실 이메일 정보를 확인해주세요.</p>
                        <form action="#" method="post">
                            <!-- email -->
                            <input type="text" id="email_address" title="이메일 아이디" class="em_form" style="width:198px;" value="ansgurtk" disabled="disabled" />
                            <span class="andmail">@</span>
                            <input type="text" id="email_domain" title="이메일 도메인" class="em_form" style="width:198px;margin-right:0;" value="naver.com" disabled="disabled" />
                        </form>
                        <ul class="bul_sty01_li mt15">
                            <li>재입고 알림 예정이 있는 상품(컬러/사이즈)에 한해서 재입고 알림 신청이 가능합니다. <br/>(제작상황에 따라 변경될 수 있습니다.)</li>
                            <li>신청 후 30일 내에 상품이 재입고 되면 '1회' 알림이 발송됩니다.</li>
                            <li>소량 입고되거나 동시 구매가 이루어질 경우 등 알림 후에도 품절이 발생할 수 있습니다.</li>
                            <li>회원정보에 등록된 이메일 정보로 안내 드리며, 이메일 정보 수정은<br/>마이페이지 > 개인정보변경 페이지에서 가능합니다.</li>
                            <li>알림 신청 시의 상품 옵션 및 가격 등의 상품정보가 재입고 시 변동될 수 있습니다.</li>
                            <li>아울렛으로 판매 전환 되었을 경우, 알림이 발송되지 않습니다.</li>
                        </ul>
                    </div>
                </div>
                <div class="btnwrap">
                    <input type="button" class="btn wt_s" id="rewareHousingCancel" value="취소">
                    <input type="button" class="btn gray_s mr0" id="rewareHousingApply" value="신청">
                </div>
                <!-- btn_close -->
                <a href="#" class="btn_close"><img src="/resources/_ui/desktop/common/images/popup/ico_close.png" alt="닫기"></a>
                <!-- //btn_close -->
            </div>
            <!-- layer pop 1 -->
</div>
	<div class="layerArea" id="productLayer" style="display: none;">
		<div class="layerBg"></div>
	</div>
    <!-- //bodyWrap -->
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

<form id="PAY_FORM" method="post" accept-charset="euc-kr">
</form>