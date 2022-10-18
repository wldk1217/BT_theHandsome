(function($){
/*
$(document).ready(function(){
	$(window).scroll(function(){
		if ($(this).scrollTop() >= 1)
		{
			$('.header').addClass('header_scroll');
            $('#bodyWrap').css('margin-top','120px');
		} else {
			$('.header').removeClass('header_scroll');
            $('#bodyWrap').css('margin-top','0px');
		}
	});

});
*/

$(document).ready(function() {
	//view_loading_bar();

	$('#view_smenu').mouseenter(
		function(){
			$('#women_sub').stop(false, true).slideDown('fast');
			$('#women img').attr('src', '../images/header_sub2.jpg');
		}
	);
	$('#view_smenu').mouseleave(
		function(){
			$('#women_sub').stop(false, true).slideUp('fast');
			$('#women img').attr('src', '../images/header_sub1.jpg');
		}
	);

	$('.viewTopArea').click(function(){
		$('html, body').stop().animate({scrollTop:0}, 500);
		return false;
	});

});

// function view_loading_bar(){
// 	var doc_height = $(document).height();
// 	$(".loading_div").height(doc_height);

// 	$("#laodbar").animate({width:300},500,function(){
// 			$(".laodbarBox").css("display","block");
// 			$("#loading_div").fadeOut("slow",function(){
// 					//callback
// 			});
// 	});	//end
// }

/* 리스트 */
$(document).ready(function(){
	//리스트 4개일때
	var list_item4 = $('.list_item4 > ul > li').length;
	$('.list_item4 > ul > li').each(function(list_item4){
		if((list_item4%4) == 0){
			$('.list_item4 > ul > li:nth-child('+(list_item4+4)+')').addClass('mr0');
		}
	});

	//리스트 3개일때 
	var list_item3 = $('.list_item3 > ul > li').length;
	$('.list_item3 > ul > li').each(function(list_item3){
		if((list_item3%3) == 0){
			$('.list_item3 > ul > li:nth-child('+(list_item3+3)+')').addClass('mr0');
		}
	});

	//리스트 4개일때(예외 - 카테고리 리스트)
	var cate_item4 = $('.cate_item4 > ul > li').length;
	$('.cate_item4 > ul > li').each(function(cate_item4){
		if((cate_item4%4) == 0){
			$('.cate_item4 > ul > li:nth-child('+(cate_item4+4)+')').addClass('mr1m');
		}
	});
});


/* zipcode list even color */
$(function(){
	$(".zipcode .result_box .list li:nth-child(even)").css("background","#f8f8f8");
	$(".delivery_comt li:nth-child(even)").css("background","#f8f8f8");
});


/* top btn */
$(document).ready(function(){
	view_topBtn();
	function view_topBtn(){
		$(window).scroll(function(){
			if ($(window).scrollTop() > 0)
			{
				$('#topBtn').fadeIn('fast');
			} else {
				$('#topBtn').fadeOut('fast');
			}
		});
	}

	$('.viewTopArea').click(function(){
		$('html, body').stop().animate({scrollTop:0}, 500);
		return false;
	});
});


/* GNB */
//brand GNB & 수입 brand GNB 카테고리 메뉴 위치 지정
$(document).ready(function(){
	var $br_margin_left = ($("h1").width() + $(".brd_m").width() + $(".cate_m > li:first-child").width() + 20);
	var $br_margin_right = (1205 - ($("h1").width() + $(".gnb_nav").width() + 50));
	$(".gnb_nav > ul.cate_m.cate_m_br li div ul").each(function( index ){
		$(this).css('margin-left', $br_margin_left);
	});
	$(".gnb_nav > ul.cate_m.cate_m_br li+li+li+li+li div ul").each(function( index ){
		$(this).css('margin-right', $br_margin_right).css('margin-left', 0).css('float', 'right');
	});
});

//Gnb Menu
$(document).ready(function(){
    //1803 최상단 브랜드 메뉴 +버튼
    var brTopMenu = $('.brand_menu1803 > ul').width();
    $('.brand_menu1803 .plus_brand').css({left:brTopMenu, display:'block'});
    var brTopMenu2 = $('.brand_menu1903 > ul').width();
    $('.brand_menu1903 .plus_brand').css({left:brTopMenu2, display:'block'});
    var $cate_m = $(".gnb_nav > ul.cate_m > li");	
	$cate_m.find('.sub_menu').children('ul').addClass('sm_dep1');
	$cate_m.find('.sub_menu').children('ul').children('li').children('ul').addClass('sm_dep2');
	$cate_m.find('.sub_menu').children('ul').children('li').children('ul').children('li').children('ul').addClass('sm_dep3');

	$(".gnb_nav > ul.cate_m > li").each(function( index ){
		var $sub_back = $(this).children(".sub_back");
		var $sub_menu = $sub_back.children(".sub_menu");
		var $sm_dep1 = $sub_menu.children(".sm_dep1");
		var $sm_dep2 = $sm_dep1.children().children(".sm_dep2");
		var $sm_dep3 = $sm_dep2.children().children(".sm_dep3");
    	var $sm_height = $sub_menu.outerHeight();

		$(this).on( "mouseenter", function(e){// 공통 처리
	    	$(this).children("a").addClass("on");
			$sub_back.stop().css({height:$sm_height - 1});
			$sub_back.css('border-bottom','1px solid #e5e5e5');
			$sub_menu.stop().fadeIn('easeInQuart');

			//=================================================================
			//GNB 위치 조정
			//=================================================================
			//메인
			if ( $(this).parent().attr("id") == 'cate_m_main' ){
				//subMenu 넓이
				var liWidthSum = 0;
				$(this).children('div').children('div').children('ul').children('li').each(function(index2){
					if(index2 > 0) {
						liWidthSum = liWidthSum + ($(this).width()+parseInt($(this).css("margin-right"), 10));	
					}
				});
				
				var leftSpace = $("h1").width();
				
				if(liWidthSum > 693 && liWidthSum < 901) {
                    leftSpace = leftSpace - (liWidthSum - 693);
                }else if(liWidthSum > 900 && liWidthSum < 1205) {
                    leftSpace = 0;
                    $(this).children('div').children('div').children('ul').css('float','right');
                }else if(liWidthSum > 1204){
                    leftSpace = leftSpace - (liWidthSum - 693);
                    $(this).children('div').children('div').children('ul').css('float','right');
                }

				if($(this).children('a').hasClass('magazine')) {
                    $cate_m.find('.sub_menu').children('ul').css('margin-left', leftSpace+25);
                } else if($(this).children('a').hasClass('magazine1803')){
                    $cate_m.find('.sub_menu').children('ul').css('margin-left', leftSpace+380);
                } else if($(this).children('a').hasClass('gnb_brand')){
                    var brul = $cate_m.find('.sub_menu').children('ul').width();
                    var braply = $('.br_button_wrap').width();
                    $cate_m.find('.sub_menu').children('ul').css({'margin-left':leftSpace-95, 'margin-bottom':'25px'});
                    $cate_m.find('.gnbbr_txt').each(function(){
                        var brTxt = $(this).width();
                        $(this).css({'margin-left':(leftSpace-95) + ((brul-60-brTxt) / 2)});
                    });
                    $cate_m.find('.br_button_wrap').css({'margin-left':(leftSpace-95) + ((brul-60-braply) / 2)});
                }else {
                    $cate_m.find('.sub_menu').children('ul').css('margin-left', leftSpace-95);
                }
				
			//브랜드
			} else if ($(this).parent().attr("id") == 'cate_m_brand') {
                
				var leftSpace = $("h1").width() + 20 + $(".brd_m").width();
				var liWidthSum = 0;
				$(this).find('.sub_menu').children('ul').children('li').each(function(index3){
				    liWidthSum = liWidthSum + ($(this).width()+ 60);
				});
				if(liWidthSum > 700){
				    $(this).find('.sub_menu').children('ul').css('margin-left', 0).css('margin-right', 0).css('float', 'right');
				}else{
                    $(this).find('.sub_menu').children('ul').css('margin-left', leftSpace).css('margin-right', 0).css('float', 'left');
                }

				$cate_m.find('.sub_menu').children('ul').children('li:last-child').css('margin-right', 0);
			//아울렛
			} else if ($(this).parent().attr("id") == 'cate_m_outlet') {
                if( !$(this).hasClass('import_m') ) {
                    if($(this).hasClass('outlet_brand1803')){//아울렛gnb개편 1804
                        var leftSpace = $("h1").width() + 14;
                        $cate_m.find('.sub_menu').children('ul').css('margin-left', leftSpace).css('margin-right', 0);
                        $cate_m.find('.sub_menu').children('ul').children('li:last-child').css('margin-right', 0);
                    }else{
                        var leftSpace = $("h1").width() + 14 + $(".brd_m").width();
                        $cate_m.find('.sub_menu').children('ul').css('margin-left', leftSpace).css('margin-right', 0);
                        $cate_m.find('.sub_menu').children('ul').children('li:last-child').css('margin-right', 0);
                    }
                } else{
                    $cate_m.find('.sub_menu').children('ul').css('margin-left', 0);
                    $cate_m.find('.sub_menu').children('ul').children('li:last-child').css('margin-right', 70);
                }
            }
			//=================================================================
			
	    	if( $(this).hasClass('import_m') ){// 해외브랜드			
				var $sm_dep1_m =  $(this).find (".sm_dep1 > li");
				var $sm_dep2_m =  $(this).find (".sm_dep1 > li > .sm_dep2");
				var $sm_height2 = $sm_dep1_m.outerHeight() + $sm_dep2_m.outerHeight();

				$sm_dep1_m.each(function(index){
					$(this).on("mouseenter",function(){
						$(this).children("a").addClass("on");
						$(this).children(".sm_dep2").stop().fadeIn('easeInQuart');
						$(this).parents(".sub_back").stop().css({height:$sm_height2});
					});
					$(this).on("mouseleave",function(){
						$(this).children("a").removeClass("on");
						$(this).children(".sm_dep2").css('display','none');
						$(this).siblings().children(".sm_dep2").css('display','none');
						$(this).parents(".sub_back").stop().css({height:$sm_dep1_m.outerHeight()});		
					});
				});
	    	};
		});
		$(this).on( "mouseleave", function(e){// 공통 처리
			$(this).children("a").removeClass("on");
			$sub_back.stop().css({height:0});
			$sub_back.css('border-bottom','0');
			$sub_menu.css('display','none');
		});

	});


	//Top Menu
	$(".header_dropmemu").mouseover(function(){
		$(this).children(".btn").addClass("on");
		$(this).children("span").siblings("a").addClass("on");
		$(this).children("div").stop().slideDown('fast');
    });
	$(".header_dropmemu").mouseleave(function(){
		$(this).children(".btn").removeClass("on");
		$(this).children("div").stop().slideUp('fast');
    });
	$(".header_dropmemu > .list").mouseover(function(){
		$(this).siblings("span").children("a").addClass("on");
    });
	$(".header_dropmemu > .list").mouseleave(function(){
		$(this).siblings("span").children("a").removeClass("on");
    });

});

/* Tab*/
$(document).ready(function(){
    $(".tab_a li a, .tab_d li a").click(function(){
		$(this).addClass("active");
		$(this).parent("li").siblings("li").children("a").removeClass("active");
    });

	$(".tab_b li a, .tab_c li a").click(function(){
		$(this).addClass("on");
		$(this).parent("li").siblings("li").children("a").removeClass("on");
    });
	//Search Tab
	$(".tab a").click(function(){
		$(this).addClass("on");
		$(this).siblings().removeClass("on");
		$(this).next("div").addClass("on");
    });
	$(".result_list > div > .close").click(function(){
		$(this).parent("div").css("display","none");
    });
	$(".result_list .btn_allclose").click(function(){
		$(this).parents(".gnb_sh_result").css("display","none");
    });
	$(".gnb_sh_box > a").click(function(){
		$(this).parents().siblings(".gnb_sh_result").css("display","block");
    });
	//Search Top10
	$(".ranklist").mouseover(function(){
		$(this).addClass("on");
		$(this).children("div").stop().slideDown('fast');
    });
	$(".ranklist").mouseleave(function(){
		$(this).removeClass("on");
		$(this).children("div").stop().slideUp('fast');
    });

});


/* Option view*/
$(document).ready(function(){
	$(document).on("click", '.btn_option, .add_bag', function(){
		$(this).parents("tr").next("tr").find(".basket_info").stop().slideDown('fast');
		$(this).parents("tr").next("tr").next('tr').find(".store_info1807").stop().slideUp('fast');
    });
    
    $(document).on("click", '.basket_info .btn_close', function(){
		$(this).parents('.basket_info').stop().slideUp('fast');
    });
    
	// Set 상품 옵션 토글
	$("#set_bag1").click(function(){
		$('#set_option1').stop().slideDown('fast');
    });
	 $("#set_option1 #btn_close").click(function(){
		$('#set_option1').stop().slideUp('fast');
    });

	//쇼핑백 - 수령매장 변경 view
	$(document).on("click", '.btn_store_option1807', function(){
		$(this).parents("tr").next("tr").next('tr').find(".store_info1807").stop().slideDown('fast');
		$(this).parents("tr").next("tr").find(".basket_info").stop().slideUp('fast');
	});
	
	$(document).on("click", ".store_info1807 .btn_close", function(){
	 $(this).parents('.store_info1807').stop().slideUp('fast');
	});
});

/* Color chip */
$(document).ready(function(){
    $(".cl_select a, .sz_select a").click(function(){
        $(this).addClass("on");
        $(this).siblings("a").removeClass("on");
    });

    $(document).on("click",'.color_chip li a, .size_chip li a',function(){
    $(this).addClass("on");
    $(this).parent("li").siblings("li").children("a").removeClass("on");
        });
    $(document).on("mouseover",".tlt_ship", function(){
        $(".delch_wrap .delch_box").css("display","block");
    });
    $(document).on("mouseout",".tlt_ship", function(){
        $(".delch_wrap .delch_box").css("display","none");
    });
    
    //상품상세 배송 옵션 선택 툴팁 박스 수정 - start    
    $(document).on("mouseover",".st_receipt_wrap div .tlt", function(){
        $(this).parent('div').find('.delch_box').css("display","block");
    });
    $(document).on("mouseout",".st_receipt_wrap div .tlt", function(){
        $(this).parent('div').find('.delch_box').css("display","none");
    });
    //상품상세 배송 옵션 선택 툴팁 박스 수정 - end
});

/* Order - 배송지 목록 Tab */
$(document).ready(function(){
	var tab = $('#del_tab ul li');
	var content = $('.del_tab_container > div');
	$('.del_tab_container > div + div').css('display','none');
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

/* Order - 카드행사 혜택 Tab */
$(document).ready(function(){
	var tab = $('#ce_tab ul li');
	var content = $('.ce_tab_container > div');
	$('.ce_tab_container > div + div').css('display','none');
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

/* Mypage & Order & 약관 전체선택 전체해제 */
$(document).ready(function(){
    $("[name=allcheck]").click(function(){
        var isChecked = $(this).is(":checked");
        $("[name=checkpd]:enabled").prop("checked", isChecked);
    });
});

$(document).ready(function(){
    $("[name=allcheck]").click(function(){
        var isChecked = $(this).is(":checked");
        $("[name=checkag]:enabled").prop("checked", isChecked);
    });
});

/* category list - size over */
$(document).ready(function(){
	var $item_boxs = $(".items_list .item_box .item_info1");
	$(".items_list .item_info1 .item_size").hide();
	$item_boxs.on( 'mouseenter', function(){
		active( this );
	});
	$item_boxs.on( 'mouseleave', function(){
		deactive( this );
	});
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
});

/* main product list */
$(document).ready(function(){
	var $item_boxs = $(".product_list .items_list li");
	$item_boxs.on( 'mouseenter', function(){
		active( this );
	});
	$item_boxs.on( 'mouseleave', function(){
		deactive( this );
	});
	function active( item ){
		var $item_box = $( item );
		$item_box.find('.respon_image.on').stop().fadeIn('fast');
	}
	function deactive( item ){
		var $item_box = $( item );
		$item_box.find('.respon_image.on').stop().fadeOut('fast');
	}
});

/* item main - item_box over */
$(document).ready(function(){
	var $item_mboxs = $(".item_main .item_box");
	$(".item_main .item_box .item_info2").hide();
	$item_mboxs.on( 'mouseenter', function(){
		active2( this );
	});
	$item_mboxs.on( 'mouseleave', function(){
		deactive2( this );
	});
	function active2( item ){
		var $item_mbox = $( item );
		$item_mbox.find('.item_info2').stop().slideDown('easeInQuart');
		//$item_mbox.find('.item_img .on').stop().fadeIn('fast');
	}
	function deactive2( item ){
		var $item_mbox = $( item );
		$item_mbox.find('.item_info2').stop().slideUp('fast');
		//$item_mbox.find('.item_img .on').stop().fadeOut('fast');
	}
	
})

/* Toggle : footer > 투자정보 > 기업지배구조, 재무정보 */
$( document).ready(function() {
    var toggleWrap = $('.toggle_type2');
    toggleWrap.children('dt:first').addClass('on');
    toggleWrap.children('dd:first').css('display','block');
    
	toggleWrap.children('dt').click(function() {
		$(this).addClass('on');
		$(this).siblings('dt').removeClass('on');

		var checkElement = $(this).next();
		if((checkElement.is('dd')) && (checkElement.is(':visible'))) {
			$(this).removeClass('on');
	 		checkElement.slideUp('fast');
		}
		if((checkElement.is('dd')) && (!checkElement.is(':visible'))) {
			toggleWrap.children('dd:visible').slideUp('fast');
			toggleWrap.children('dd:visible').prev('dt').removeClass('on');			
			checkElement.slideDown('fast');
		}
		if($(this).next('dd').length == 0) {
			return true;
		} else {
			return false; 
		}      
	});
});

 //item submain
$(function(){
	$('.item_main > ul > li').css('visibility','hidden');
    $(window).load(function(){
	    $('.item_main > ul > li').each(function(i){
	        $(this).delay(i*(100)).css({visibility:'visible',opacity:'0'}).animate({opacity:'1'},'easeInQuart');
	    });
    });
});


//toggle list - notice, faq
$(document).ready(function(){
	var $tr_odd = $(".toggle_list tbody tr:nth-child(odd)")
	var $tr_even = $(".toggle_list tbody tr:nth-child(even)")

	$tr_odd.addClass("odd");
	$tr_even.addClass("answer").hide();

	$(".odd a").each(function(index){
		$(this).click(function(e){
			$(this).parent().parent().next(".answer").slideToggle();
			$(this).parent().parent().siblings().next(".answer").hide();
		})
	})
	
}) 

//footer - language, family slideToggle
$(document).ready(function() {
	$('.related_site > dl').click(function(e){
		$(this).find('dd').slideToggle('fast'),
		$(this).find('dt > a').toggleClass('on'),
		e.stopPropagation();
	});

	$("body").click(function(){
		$('.related_site > dl dd').slideUp('fast');
		$('.related_site > dl dt a').removeClass('on');
	});

	$('.related_site > dl.global').click(function(e){
		$('.related_site > dl.family dd').slideUp('fast');
		$('.related_site > dl.family dt a').removeClass('on');
	});
	$('.related_site > dl.family').click(function(e){
		$('.related_site > dl.global dd').slideUp('fast');
		$('.related_site > dl.global dt a').removeClass('on');
	});
});

// mypage - 배송지 수정 / order - 배송&결제정보 입력
$(document).ready(function() {
	/* 211109 공동현관 출입방법 S */
	$('.input_sumtxt_box:not(.input_sumtxt_box2)').click(function(e){
		$('.delivery_comt:not(.delivery_comt2)').toggle();
		$('.delivery_comt2').hide();
		e.stopPropagation();
	});
	
	$('.input_sumtxt_box2').click(function(e){
		$('.delivery_comt2').toggle(),
		e.stopPropagation();
	});
	/* 211109 공동현관 출입방법 E */
	$("body").click(function(){
		$('.delivery_comt').hide();
	}),
	$(".input_sumtxt_box input").keydown(function(){
		$('.delivery_comt').hide();
	}),
	$(".delivery_comt li a").click(function(){
	    if ($(this).hasClass("direct")) {
	        $(this).parents(".input_sumtxt_box").find('input').val("").focus();
	    } else {
	    	/* 211028 공동현관 출입방법 S */
			if ($(this).data('readonly') === 'readonly') {
				// 읽기만 가능
				$(this).parents(".input_sumtxt_box").find('input').val($(this).attr("deliveryRequestMessage"));
				$(this).parents(".input_sumtxt_box").find('input').prop('readonly', true);
				$('.enter-door211026').show();
			} else if ($(this).data('readonly') === 'write') {
				// 쓰기도 가능
				$(this).parents(".input_sumtxt_box").find('input').val("").focus();
				$(this).parents(".input_sumtxt_box").find('input').attr('placeholder', $(this).attr("deliveryRequestMessage"));
				$(this).parents(".input_sumtxt_box").find('input').prop('readonly', false);
				$('.enter-door211026').hide();
				
				// 211029 공동현관 출입방법 S
			} else if ($(this).data('inputDisplay') === 'none') {
				// 공동현관 출입방법 -> 자유출입
				if($(this).data('recentryMessage')){
					$(this).parents(".input_sumtxt_box").find('input').val($(this).data('default'));
					$('#frontDoorMessage').val($(this).data('recentryMessage'));
				}else{
					$(this).parents(".input_sumtxt_box").find('input').val($(this).text());
					$('#frontDoorMessage').val('');
				}
				$('.enter_front').hide();
			} else if ($(this).data('inputDisplay') === 'block') {
				// 공동현관 출입방법 -> 출입번호, 기타
				if($(this).data('recentryMessage')){
					$(this).parents(".input_sumtxt_box").find('input').val($(this).data('default'));
					$('#frontDoorMessage').val($(this).data('recentryMessage'));
				}else{
					$(this).parents(".input_sumtxt_box").find('input').val($(this).text());
					$('#frontDoorMessage').val('');
				}
				if($(this).data('default') === '기타'){
					$('#frontDoorMessage').attr('placeholder','15자 이내로 입력하세요');
				}else{
					$('#frontDoorMessage').attr('placeholder','예) #12341234# (최대 15자)');
				}
				$('.enter_front').show();
			// 211029 공동현관 출입방법 E
				
			} else {
				// 공동현관 출입방법 제외한 나머지 셀렉트 박스
				$(this).parents(".input_sumtxt_box").find('input').val($(this).text());
			}
			/* 211028 공동현관 출입방법 E */
	    };
	});
});


// 아이템 리스트 - sorting
$(document).ready(function(){
	$(".filterWrap .list").hide()
	$(".filterWrap > ul > li > a").click(function(){
	    var $this = $(this),
	        $list = $this.next(".list");
	    
	    // 화면이 출력되는 경우 처리
	    if ( $list.is(':visible') === false ) {
	        $list.find('li').unbind('click.select').one('click.select', function () {
	            var $currentList = $(this).parents('ul div.list');
	            $currentList.slideUp('fast');
	            // 기존에 있던 이벤트를 삭제한다.
	            $currentList.find('li').unbind('click.select');
	        })
	    }
	    
	    $list.slideToggle('fast');
	    
	    $this.parent().siblings().children(".list").slideUp('fast');
	})
})

//close
$(document).ready(function(){
	$(".shpro_wrap a").click(function(){
		$(this).parent("span").css("display","none");
	})
})

//인스타 이미지 hover
$(document).ready(function(){
    instaImage();
    $(window).resize(function() {		
        instaImage();
    });        
});
//주문서 배송지 주소 툴팁 클릭 이벤트 191022
//마우스 오버로 변경 191024
$(document).ready(function(){
	$(document).on("mouseover",".tooltip191022 .ico_question", function(){
		$(this).parent('.tooltip191022').find('.delch_box190816').css("display","block");
	});
	$(document).on("mouseout",".tooltip191022 .ico_question", function(){
		$(this).parent('.tooltip191022').find('.delch_box190816').css("display","none");
	});
});
function instaImage(){
    var instaHeight = $(".insta_list li").width();
    $(".insta_list li").height(instaHeight);
    $(".insta_list li img").width(instaHeight);

    $(".insta_list li a > div").hide();
    $(".insta_list li").hover(function(){
        $(this).find("div").stop().fadeIn("easeOutQuart");
        $(this).find("img").addClass('active');
    },function(){
        $(this).find("div").stop().fadeOut("300");
        $(this).find("img").removeClass('active');
    });
};
})(jQuery);