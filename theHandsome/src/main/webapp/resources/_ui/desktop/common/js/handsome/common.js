(function($){
$(document).ready(function() {
	view_loading_bar();

	// 2017-03-07, 이현승, numberonly속성 input 태그 한글 입력 방지 [START]
	/*$(document).on("keyup","input:text[numberonly]",function(){
		$(this).val($(this).val().replace(/[^0-9]/gi,""));
	});*/	
	$(document).on("focus","input:text[numberonly]",function(){
		$("input:text[numberonly]").each(function(index){
			$(this).val($(this).val().replace(/[^0-9]/gi,""));
		});
	});
	$(document).on("blur","input:text[numberonly]",function(){
		$("input:text[numberonly]").each(function(index){
			$(this).val($(this).val().replace(/[^0-9]/gi,""));
		});
	});
	$(document).on("input","input:text[numberonly]",function(){
		$("input:text[numberonly]").each(function(index){
			$(this).val($(this).val().replace(/[^0-9]/gi,""));
		});
	});
	// 2017-03-07, 이현승, numberonly속성 input 태그 한글 입력 방지 [END]
	
	
	/*카테고리 시작*/
	//var ddddd=0;
	//$('#category').css({height: $(document).height() });
	/*$('#view_category').click(function(){
		$('#category_layer').show();
		$(this).fadeOut('fast', function(){
			$('#category').animate({left:0}, 'fast', function(){
				$('#category a.close').fadeIn('fast');
			});
			$('#contents').animate({marginLeft:227}, 'fast');
			//$('#fixed_cont').animate({marginRight:-867}, 'fast');
		});
		//ddddd = 1;
		return false;
	});
	$('#category a.close').click(function(){
		$('#category_layer').hide();
		$('#category a.close').fadeOut('fast', function(){
			$('#contents').animate({marginLeft:0}, 'fast');
			$('#category').animate({left:-227}, 'fast', function(){
				$('#view_category').fadeIn('fast');
			});
			//$('#fixed_cont').animate({marginRight:-640}, 'fast');
		});
		//ddddd = 0;
		return false;
	});
	$('#category_layer').click(function(){
		$('#category_layer').hide();
		$('#category a.close').fadeOut('fast', function(){
			$('#contents').animate({marginLeft:0}, 'fast');
			$('#category').animate({left:-227}, 'fast', function(){
				$('#view_category').fadeIn('fast');
			});
			//$('#fixed_cont').animate({marginRight:-640}, 'fast');
		});
		//ddddd = 0;
	});*/
	/*카테고리 끝*/

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
	);/*
	$('#header_logo').mouseenter(
		function(){
			$('#women_sub').stop(false, true).slideUp('fast');
			$('#view_smenu').find('img').attr('src', '../images/header_sub1.jpg');
		}
	);
	$('#women_sub').mouseleave(
		function(){
			$(this).stop(false, true).slideUp('fast');
			$('#view_smenu').find('img').attr('src', '../images/header_sub1.jpg');
		}
	);*/
	/*$('#header_menu').click(function(){
		return false;
	});*/

	$('.viewTopArea').click(function(){
		$('html, body').stop().animate({scrollTop:0}, 500);
		return false;
	});

	/*$('#dress_sub1').mouseenter(function(){
		$('#women_sub a.dsub').css({display:'none'});
		$('#women_sub a.dsub1').css({display:'block'});
	});*/
});

function view_loading_bar(){
	//********* loadingbar *********//
	//$("#laodbar").css({width:1});
	//$(".laodbarBox").css("display","none");
	//$("#loading_div").show();

	var doc_height = $(document).height();
	$(".loading_div").height(doc_height);

	$("#laodbar").animate({width:300},500,function(){
			$(".laodbarBox").css("display","block");
			$("#loading_div").fadeOut("slow",function(){
					//callback
			});	
	});	//end
}
})(jQuery);