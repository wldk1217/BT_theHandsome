<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<c:set var="path" value="${pageContext.request.contextPath}" />
<head>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript">
	// 선택한 상품 컬러에 따라 이미지와 상품번호를 바꿔주는 함수
	function setColor(i) {
		console.log(i);
		console.log(obj[i].ccolorcode);

		let x = document.getElementsByClassName("prodNum")[0];
		x.innerText = obj[i].ccolorcode;

		$("#img2").attr("src", obj[i].cimage2);
		$("#img3").attr("src", obj[i].cimage3);
		$("#img4").attr("src", obj[i].cimage4);
		$("#img5").attr("src", obj[i].cimage5);
		
		$("#ccolorcode").val(obj[i].ccolorcode);
	  	var a = $("#ccolorcode").val();
	    console.log("setColor들어옴: "+a);
	}

	//마우스 올렸을 때 색상이름 보여주는 함수(완성)
	function setColorName(color) {
		$("#colorNameContent").text(color);
	}
	
	// 숫자 format
	Number.prototype.format = function(){
		if(this==0) return 0;

	     var reg = /(^[+-]?\d+)(\d{3})/;
	     var n = (this + '');
	     
	     while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
	     
	     return n;
	};
	// 제품 사이즈 선택
	function change_size(size){
		console.log("사이즈 선택: "+size);
		$("#psize").val(size);
	}
	
	// 제품 수량 변경
	function change_qty(button){
		console.log("버튼클릭");
		 var min_qty = 1;
		 var this_qty = $("#txtqty").val()*1;
		 var this_price = $("#price").val()*1;
		 var max_qty = 5;
		 if(button=='left'){
			 console.log("왼쪽");
			 this_qty -= 1;
			 if(this_qty < min_qty){
				 this_qty = 1;
			 }
			 console.log(this_qty);
		 }
		 else if(button=='right'){
			 console.log("오른쪽");
			 this_qty += 1;
			 if(this_qty > max_qty){
				 alert("재고가 부족합니다.");
				 return;
			 }
			 console.log(this_qty);
		 }
		 var show_total_amount = this_price * this_qty;
		 $("#txtqty").val(this_qty);
		 
		 $("#sumPrice").html('₩ '+show_total_amount.format());
		 
		 $("#pamount").val(this_qty);
	}
	
	// 장바구니에 추가하는 함수
	   function addToCart(buyNow)
	   {
		   var qty = $("#txtqty").val();
		   
		   var size = $("#psize").val();

	       //사이즈 선택 안했을 시 경고창
 	       if(size == ""){
	        /* var la = new layerAlert('사이즈를 선택해 주세요.'); */
	        alert('사이즈를 선택해 주세요.');
	         return;
	       } 
	       /* // 로그인이 안되어있을 경우 로그인페이지로 이동
	       if("${sessionScope.member.mid}" == ""){
	          location.href="/member/login";
	          return;
	       } */
	       if(true){
	           addToCartProcess = false;
	           var pid = $('form[name=addToCartForm] input[name=pid]').val();
	           var psize = $('form[name=addToCartForm] input[name=psize]').val();
	           var pamount = $('form[name=addToCartForm] input[name=pamount]').val();
	           var pcolor = $("#ccolorcode").val();
	           /* if(pcolor == null) {
	              var split_arr = pid.split('_');
	              pcolor = split_arr[1];
	           } */

	           console.log("여기함수: "+pid);
	           console.log("여기함수: "+psize);
	           console.log("여기함수: "+pamount);
	           console.log("여기함수: "+pcolor);
	           
	           /* console.log(pid, psize, pcolor, pamount); */
	           // 장바구니 등록하는 ajax 호출
	           $.ajax({
	               url: "/cart/add",
	               method: "post",
	               data : {
	                  mid : "${member.mid}",
	                  pid : pid,
	                  psize : psize,
	                  pcolor : pcolor,
	                  pamount : pamount
	               },
	               success: function (data) {
	            	   console.log("${member.mname}");
	                   alert("완료되었습니다.");
	                   location.href='/cart/cartList';
	               },
	               error : function( request, status, error ){
	                   console.log( "code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
	               }
	           });
	        
	           
	           
	       }
	   }
	
	//위시리스트 클릭했을 때 작동하는 함수
	   function addWishListClick()
	   {   
	       if(!$('.wishlist1803').hasClass('on')){
	           brazeLogCustomEvent("Wish", "");
	           brazeCustomAttribute("Wish", "add");
	       }else{
	           brazeCustomAttribute("Wish", "remove");
	       }
	       
	       addWishList();
	       
	   }
	
	   function addToWish()
	   {
		   
	   }
	
	$('document').ready(
					function() {
						// 상품 컬러 리스트 가져오는 ajax 호출
						$.ajax({
									url : "/product/productColor?pid="
											+ "${product.pid}",
									type : "GET",
									dataType : "json",
									async : false,
									error : function(request, status, error) {
										console.log("code:" + request.status
												+ "\n" + "message:"
												+ request.responseText + "\n"
												+ "error:" + error);
									},
									success : function(result) {
										var html = "";
										obj = result;
										if (result.length > 0) {
											html += '<ul class="color_chip clearfix">';
											for (var i = 0; i < result.length; i++) {
												console.log(result[i]);
												var img = result[i].ccolorimage;
												console.log(result[i].cimage1);
												/* var split_arr = result[i].cimage1.split('_'); */
												html += '<li id="'+result[i].ccolorcode+'">';
												/* html += '<input type="hidden" id="pcolor" name="pcolor" class="colorNameVal" value="'+split_arr[1]+'"/>'; */
												if (i == 0)
													html += '<a href="#;" onclick="setColor('
															+ i
															+ ')" class="beige on" style="background:'
															+ ' url('
															+ result[i].ccolorimage
															+ ')" onmouseover="setColorName(\''
															+ result[i].ccolorname
															+ '\');" onmouseout="setColorName(\''
															+ "" + '\');">'
												else
													html += '<a href="#;" onclick="setColor('
															+ i
															+ ')" class="beige" style="background:'
															+ ' url('
															+ result[i].ccolorimage
															+ ')" onmouseover="setColorName(\''
															+ result[i].ccolorname
															+ '\');" onmouseout="setColorName(\''
															+ ""
															+ '\');"></a></li>';

												/* $("#pcolor").val(split_arr[1]);
												console.log($("#pcolor").val()); */
											}
											html += '</ul>';
										}
										$("#getcolor").html(html);
									}
								});

					});
	//재고정보 가져오는 ajax호출
	$.ajax({
		url : "/product/productStock?pid=" + "${product.pid}"
				+ "&ccolorcode=" + "${product.ccolorcode}",
		type : "GET",
		dataType : "json",
		async : false,
		error : function(request, status, error) {
			console.log("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		},
		success : function(result) {
			var html = "";
			if (result.length > 0) {
				/* html += '<ul class="size_chip clearfix sizeChipKo1901">'; */
				for (var i = 0; i < result.length; i++) {
					console.log(result[i].ssize);
					html += "<li><a>테스트</a></li>";
				}
				console.log(html);
				$("#ulSize").append(html);
				/* html += '</ul>'; */
			}
			/* $("#ulSize").html(html); */
		}
	});
</script>
</head>
<body>
	<div id="globalMessages"></div>
	<div id="bodyWrap" class="item_detail">
		<div id="oneEventLayer"></div>

		<div class="adaptive_wrap">
			<div class="clearfix prd_detail1905" id="clearfix">
				<div class="clearfix image_view3">
					<a href="javascript:imageZoom()" id="btn_zoom" class="btn_zoom"
						onclick="GA_Event('상품_상세','크게보기','클릭')">크게보기</a>
					<!-- 버튼 클릭시 item_visual 에 zoom 클래스 추가 -->
					<!-- 2021.08.18 동영상 재생 수정, 상품 imageDivisionCode에 VOD가 있는 경우 동영상 url 세팅 -->
					<div class="image_view1" id="image_view1">
						<div class="item_visual" id="imageDiv" style="margin-top: 20px;">
							<ul>
							<li><img src="${ColorVO.cimage2 }" class="respon_image"
									id="img2" alt="${ProductVO.pname }"
									onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img1.jpg'" /></li>
								<li><img src="${ColorVO.cimage3 }" class="respon_image"
									id="img3" alt="${ProductVO.pname }"
									onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img1.jpg'" /></li>
								<li><img src="${ColorVO.cimage4 }" class="respon_image"
									id="img4" alt="${ProductVO.pname }"
									onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img1.jpg'" /></li>
								<li><img src="${ColorVO.cimage5 }" class="respon_image"
									id="img5" alt="${ProductVO.pname }"
									onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img1.jpg'" /></li>
							</ul>
						</div>
					</div>
					<div class="item_visual" id="imageDivW" style="display: none">
						<ul>
							<li><img src="${ColorVO.cimage1 }" class="respon_image"
								alt="${ProductVO.pname }"
								onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img1.jpg'" /></li>
							<li><img src="${ColorVO.cimage1 }" class="respon_image"
								alt="${ProductVO.pname }"
								onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img1.jpg'" /></li>
							<li><img src="${ColorVO.cimage1 }" class="respon_image"
								alt="${ProductVO.pname }"
								onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img1.jpg'" /></li>
						</ul>
					</div>
					<!--동영상 삽입 180710-->
					<!--//동영상 삽입 180710-->
					<!--  2021.08.18 동영상 재생 영역  -->
				</div>
				<!-- 품절상품포함 여부 -->

				<div class="item_detail_info float_right" id="contentDiv"
					style="margin-top: 20px;">
					<div class="info">
						<div class="info_sect">
							<h4 class="item_name">
								<div class="brand-name">
									<a href="/listBrand?bname=${product.bname}">${product.bname}</a>
								</div>
								<span class="name ko_fir_spel"> ${product.pname }<input
									type="hidden" id="brandName" value="LÄTT" /> <input
									type="hidden" id="productName" value="${product.pname }" />
									<input type="hidden" id="productCode"
									value="${product.pid }" />
								</span>
							</h4>

							<div class="flag"></div>

							<p class="price">
								<span>₩<fmt:formatNumber value="${product.pprice}"
										type="number" pattern="###,###" /></span>
										<input type="hidden" id="productPrice" value="${product.pprice}" />
							</p>
							<!-- 상품추가설명 -->
							<p class="selling_point"></p>
							<!-- 20200914이후 추가 상품설명 (신) -->
							<div class="prod-detail-con-box">
								<strong class="number-code">상품품번 &#58; <span
									class="prodNum">${ColorVO.ccolorcode }</span></strong>
								<div class="round-style">
									<p>${product.pdetail }</p>
								</div>
							</div>
							<!-- 20200914 이전 상품설명(구) -->
						</div>
						<div class="info_sect">
							<ul class="point_delivery">
								<%-- <li><span class="title">한섬마일리지</span> <span class="txt"><fmt:formatNumber
											value="${product.pprice * 0.05 }" type="number"
											pattern="###,###" />&nbsp;M&nbsp;(5%)</span></li> --%>
								<li><span class="title">H.Point</span> <span class="txt"><fmt:formatNumber
											value="${product.pprice * 0.001 }" type="number"
											pattern="###,###" />&nbsp;P&nbsp;(0.1%)</span> <a
									href="javascript:fn_cardBenefit();" id="cardbenef"
									class="etc_info" onclick="GA_Event('상품_상세','카드사_혜택안내','클릭');">카드사
										혜택안내</a>

									<div class="popwrap w_type_2" id="cardBenefit"
										style="display: none;">
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
															<col style="width: 155px" />
															<col />
														</colgroup>
														<tbody>
															<tr>
																<th scope="row" name="신한카드"><span class="card"><img
																		src=""
																		orgurl="/medias/shinhan.jpg?context=bWFzdGVyfHJvb3R8MjY1N3xpbWFnZS9qcGVnfGhkZS9oMmIvODgxNDE4MTUxNTI5NC5qcGd8NTAwMDYxM2ZmZmRlZGFhZDQ0ODNmODJjZTg2OTE3MGI3OWQ2ZmE3YzI0ZjA3MDY3NzIxYWVhNmY3NDQyYWUzMA"
																		alt="신한카드" /></span></th>
																<td><b>신한카드 5만원이상 결제시 2~7개월 무이자 할부</b><br /> 대상:
																	신한카드 전 회원<br /> (신한BC 제외/ 법인,기프트,체크,선불카드 제외) <br />
																	2022.05.01&nbsp;~&nbsp;2022.05.31</td>
															</tr>
															<tr>
																<th scope="row" name="삼성카드"><span class="card"><img
																		src=""
																		orgurl="/medias/SAMSUNG.jpg?context=bWFzdGVyfHJvb3R8MzIxOXxpbWFnZS9qcGVnfGgzZC9oNGQvODgxNDE4MTYxMzU5OC5qcGd8ZGY1NDJiM2U1YWNmNGE5MTJkOTA0MTAxMDliMDc4ZjRlNTJmZjJlOTkxOTQzZTEwMDcxZWU2NGU2MjJmMWE2Mw"
																		alt="삼성카드" /></span></th>
																<td><b>삼성카드 5만원이상 결제시 2~6개월 무이자 할부</b><br /> 대상:
																	삼성카드 전 회원<br /> (법인,기프트,체크,선불카드 제외)<br />
																	2022.05.01&nbsp;~&nbsp;2022.05.31</td>
															</tr>
															<tr>
																<th scope="row" name="비씨카드"><span class="card"><img
																		src=""
																		orgurl="/medias/BC.jpg?context=bWFzdGVyfHJvb3R8MjQ1OHxpbWFnZS9qcGVnfGhmMi9oMGQvODgxNDE4MTIyMDM4Mi5qcGd8MjZlZGU2ZGQyNDBkYzU5YmY2NWY0MDU3NDc1OTA0YWI5NmM4NDJjMDFiYjBiYjBjY2FhZjhmMzg3ZmE5NGU5Yw"
																		alt="비씨카드" /></span></th>
																<td><b>비씨카드 5만원이상 결제시 2~7개월 무이자 할부</b><br /> 대상:
																	비씨카드 전 회원<br />(법인,기프트,체크,선불카드 제외)<br />
																	2022.05.01&nbsp;~&nbsp;2022.05.31</td>
															</tr>
															<tr>
																<th scope="row" name="현대카드"><span class="card"><img
																		src=""
																		orgurl="/medias/HYUNDAI.jpg?context=bWFzdGVyfHJvb3R8MjYxMHxpbWFnZS9qcGVnfGg1ZC9oN2MvODgxNDE4MTcxMTkwMi5qcGd8YmM5ZWY0ZjlhODlkMzdmMjYyNmY4NjQ4OWU5NWVjOWFlMGY4ODIwYzZlNjA0MjBlNDkwNWI0ZDllYThjMWE5Mw"
																		alt="현대카드" /></span></th>
																<td><b>현대카드 5만원이상 결제시 2~7개월 무이자 할부</b><br /> 대상:
																	현대카드 전 회원<br /> (법인,기프트,체크,선불카드 제외)<br />
																	2022.05.01&nbsp;~&nbsp;2022.05.31</td>
															</tr>
															<tr>
																<th scope="row" name="국민카드"><span class="card"><img
																		src=""
																		orgurl="/medias/kucmin.jpg?context=bWFzdGVyfHJvb3R8MzMwM3xpbWFnZS9qcGVnfGgyZS9oMzQvODgxNDE4MTAyMzc3NC5qcGd8MjM1YjEyN2I4OTljMGIxYzY3MjhjNDhkZWMyOTE5ODZjYmRiYWExNDdhOWZmNDQ3ZWNhNGIxZjYwYzk2MDA4Zg"
																		alt="국민카드" /></span></th>
																<td><b>KB국민카드 5만원이상 결제시 2~7개월 무이자 할부</b><br /> 대상:
																	KB국민카드 전 회원<br /> (NH농협, 국민BC 제외/ 법인,기프트,체크,선불카드 제외)<br />
																	2022.05.01&nbsp;~&nbsp;2022.05.31</td>
															</tr>
															<tr>
																<th scope="row" name="하나카드"><span class="card"><img
																		src=""
																		orgurl="/medias/hanacard.gif?context=bWFzdGVyfHJvb3R8MTkzNXxpbWFnZS9naWZ8aDYwL2hmYi84ODE0MDU0OTY1Mjc4LmdpZnxhMGM5OWY0MDdhNDhjYzkwOTdiMzhkM2VmMDQ2YTI0NTAyNDBjZTljNTdiYzk4YWRhZmI0NjBhOWRhNzRiMGYw"
																		alt="하나카드" /></span></th>
																<td><b>하나카드 5만원이상 결제시 2~8개월 무이자 할부</b><br /> 대상:
																	하나카드 전 회원 (구 하나SK, 구 외환)<br /> (하나BC카드
																	포함/법인,기프트,체크,선불카드 제외)<br />
																	2022.05.01&nbsp;~&nbsp;2022.05.31</td>
															</tr>
															<tr>
																<th scope="row" name="NH카드"><span class="card"><img
																		src=""
																		orgurl="/medias/NH.jpg?context=bWFzdGVyfHJvb3R8Mzk3OXxpbWFnZS9qcGVnfGg4ZS9oMzYvODgxNDE4MTkwODUxMC5qcGd8ZWVlNmY1OWM0NDdmMjg2M2Y4NGZkNDZjYThmOTVkMWNmY2QwYWNkOWI1ODc5YTdiMTc5MjY4MThiZTkzYzNmMw"
																		alt="NH카드" /></span></th>
																<td><b>NH농협카드 5만원이상 결제시 2~8개월 무이자 할부</b><br /> 대상:
																	NH농협카드 전 회원<br /> (NH농협BC카드 포함/ 법인,기프트,체크,선불카드 제외) <br />
																	2022.05.01&nbsp;~&nbsp;2022.05.31</td>
															</tr>
															<tr>
																<th scope="row" name="롯데카드"><span class="card"><img
																		src=""
																		orgurl="/medias/LOTTE.jpg?context=bWFzdGVyfHJvb3R8MzI3MXxpbWFnZS9qcGVnfGhiMy9oNDcvODgxNDE4MTgxMDIwNi5qcGd8MDliOThkNzA1ZDc2ZDE4MzZhYmUzYjI2MDMxZDk0NGU3OTVjYzBhYTA1MmMzMjAyZmE0Y2U4OTZlNTU3NDU2Zg"
																		alt="롯데카드" /></span></th>
																<td><b>롯데카드 5만원이상 결제시 2~4개월 무이자 할부</b><br />
																	대상:롯데카드 전 회원<br /> (법인,기프트,체크,선불카드 제외)<br />
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
															<col style="width: 155px">
															<col>
														</colgroup>
														<tbody>
															<tr>
																<th scope="row" name="신한카드"><span class="card"><img
																		src=""
																		orgurl="/medias/shinhan.jpg?context=bWFzdGVyfHJvb3R8MjY1N3xpbWFnZS9qcGVnfGhkZS9oMmIvODgxNDE4MTUxNTI5NC5qcGd8NTAwMDYxM2ZmZmRlZGFhZDQ0ODNmODJjZTg2OTE3MGI3OWQ2ZmE3YzI0ZjA3MDY3NzIxYWVhNmY3NDQyYWUzMA"
																		alt="신한카드" /></span></th>
																<td><b>10개월 부분무이자</b><br /> (5만원이상 결제시/1,2,3,4회차
																	고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)<br />
																	2022.05.01&nbsp;~&nbsp;2022.05.31</td>
															</tr>
															<tr>
																<th scope="row" name="삼성카드"><span class="card"><img
																		src=""
																		orgurl="/medias/SAMSUNG.jpg?context=bWFzdGVyfHJvb3R8MzIxOXxpbWFnZS9qcGVnfGgzZC9oNGQvODgxNDE4MTYxMzU5OC5qcGd8ZGY1NDJiM2U1YWNmNGE5MTJkOTA0MTAxMDliMDc4ZjRlNTJmZjJlOTkxOTQzZTEwMDcxZWU2NGU2MjJmMWE2Mw"
																		alt="삼성카드" /></span></th>
																<td><b>10개월 부분무이자</b><br /> (5만원이상 결제시/1,2,3,4회차
																	고객 부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)<br />
																	2022.05.01&nbsp;~&nbsp;2022.05.31</td>
															</tr>
															<tr>
																<th scope="row" name="삼성카드"><span class="card"><img
																		src=""
																		orgurl="/medias/SAMSUNG.jpg?context=bWFzdGVyfHJvb3R8MzIxOXxpbWFnZS9qcGVnfGgzZC9oNGQvODgxNDE4MTYxMzU5OC5qcGd8ZGY1NDJiM2U1YWNmNGE5MTJkOTA0MTAxMDliMDc4ZjRlNTJmZjJlOTkxOTQzZTEwMDcxZWU2NGU2MjJmMWE2Mw"
																		alt="삼성카드" /></span></th>
																<td><b>12개월 부분무이자</b><br /> (5만원이상 결제시/1,2,3,4,5회차
																	고객 부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외) <br />
																	2022.05.01&nbsp;~&nbsp;2022.05.31</td>
															</tr>
															<tr>
																<th scope="row" name="비씨카드"><span class="card"><img
																		src=""
																		orgurl="/medias/BC.jpg?context=bWFzdGVyfHJvb3R8MjQ1OHxpbWFnZS9qcGVnfGhmMi9oMGQvODgxNDE4MTIyMDM4Mi5qcGd8MjZlZGU2ZGQyNDBkYzU5YmY2NWY0MDU3NDc1OTA0YWI5NmM4NDJjMDFiYjBiYjBjY2FhZjhmMzg3ZmE5NGU5Yw"
																		alt="비씨카드" /></span></th>
																<td><b> 우리BC 10개월 부분무이자</b><br /> (5만원이상
																	결제시/1,2,3회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외) <br />
																	2022.05.01&nbsp;~&nbsp;2022.05.31</td>
															</tr>
															<tr>
																<th scope="row" name="비씨카드"><span class="card"><img
																		src=""
																		orgurl="/medias/BC.jpg?context=bWFzdGVyfHJvb3R8MjQ1OHxpbWFnZS9qcGVnfGhmMi9oMGQvODgxNDE4MTIyMDM4Mi5qcGd8MjZlZGU2ZGQyNDBkYzU5YmY2NWY0MDU3NDc1OTA0YWI5NmM4NDJjMDFiYjBiYjBjY2FhZjhmMzg3ZmE5NGU5Yw"
																		alt="비씨카드" /></span></th>
																<td><b>우리BC 12개월 부분무이자</b><br /> (5만원이상
																	결제시/1,2,3,4회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외) <br />
																	2022.05.01&nbsp;~&nbsp;2022.05.31</td>
															</tr>
															<tr>
																<th scope="row" name="국민카드"><span class="card"><img
																		src=""
																		orgurl="/medias/kucmin.jpg?context=bWFzdGVyfHJvb3R8MzMwM3xpbWFnZS9qcGVnfGgyZS9oMzQvODgxNDE4MTAyMzc3NC5qcGd8MjM1YjEyN2I4OTljMGIxYzY3MjhjNDhkZWMyOTE5ODZjYmRiYWExNDdhOWZmNDQ3ZWNhNGIxZjYwYzk2MDA4Zg"
																		alt="국민카드" /></span></th>
																<td><b>10개월 부분무이자</b><br /> (5만원이상 결제시/1,2,3회차
																	고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)<br />
																	2022.05.01&nbsp;~&nbsp;2022.05.31</td>
															</tr>
															<tr>
																<th scope="row" name="국민카드"><span class="card"><img
																		src=""
																		orgurl="/medias/kucmin.jpg?context=bWFzdGVyfHJvb3R8MzMwM3xpbWFnZS9qcGVnfGgyZS9oMzQvODgxNDE4MTAyMzc3NC5qcGd8MjM1YjEyN2I4OTljMGIxYzY3MjhjNDhkZWMyOTE5ODZjYmRiYWExNDdhOWZmNDQ3ZWNhNGIxZjYwYzk2MDA4Zg"
																		alt="국민카드" /></span></th>
																<td><b>12개월 부분무이자</b><br /> (5만원이상 결제시/1,2,3,4회차
																	고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)<br />
																	2022.05.01&nbsp;~&nbsp;2022.05.31</td>
															</tr>
															<tr>
																<th scope="row" name="하나카드"><span class="card"><img
																		src=""
																		orgurl="/medias/hanacard.gif?context=bWFzdGVyfHJvb3R8MTkzNXxpbWFnZS9naWZ8aDYwL2hmYi84ODE0MDU0OTY1Mjc4LmdpZnxhMGM5OWY0MDdhNDhjYzkwOTdiMzhkM2VmMDQ2YTI0NTAyNDBjZTljNTdiYzk4YWRhZmI0NjBhOWRhNzRiMGYw"
																		alt="하나카드" /></span></th>
																<td><b>10개월 부분무이자</b><br /> (5만원이상 결제시/1,2,3회차
																	고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)<br />
																	2022.05.01&nbsp;~&nbsp;2022.05.31</td>
															</tr>
															<tr>
																<th scope="row" name="하나카드"><span class="card"><img
																		src=""
																		orgurl="/medias/hanacard.gif?context=bWFzdGVyfHJvb3R8MTkzNXxpbWFnZS9naWZ8aDYwL2hmYi84ODE0MDU0OTY1Mjc4LmdpZnxhMGM5OWY0MDdhNDhjYzkwOTdiMzhkM2VmMDQ2YTI0NTAyNDBjZTljNTdiYzk4YWRhZmI0NjBhOWRhNzRiMGYw"
																		alt="하나카드" /></span></th>
																<td><b>12개월 부분무이자</b><br /> (5만원이상 결제시/1,2,3,4회차
																	고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)<br />
																	2022.05.01&nbsp;~&nbsp;2022.05.31</td>
															</tr>
															<tr>
																<th scope="row" name="신한카드"><span class="card"><img
																		src=""
																		orgurl="/medias/shinhan.jpg?context=bWFzdGVyfHJvb3R8MjY1N3xpbWFnZS9qcGVnfGhkZS9oMmIvODgxNDE4MTUxNTI5NC5qcGd8NTAwMDYxM2ZmZmRlZGFhZDQ0ODNmODJjZTg2OTE3MGI3OWQ2ZmE3YzI0ZjA3MDY3NzIxYWVhNmY3NDQyYWUzMA"
																		alt="신한카드" /></span></th>
																<td><b>12개월 부분무이자</b><br /> (5만원이상 결제시/1,2,3,4,5회차
																	고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)<br />
																	2022.05.01&nbsp;~&nbsp;2022.05.31</td>
															</tr>
														</tbody>
													</table>
													<ul class="bul_sty01_li mt10">
														<li>무이자 할부 결제 시 카드사 포인트는 적립되지 않습니다.</li>
														<li>ARS 무이자 할부는 해당 카드사 ARS 번호로 사전 신청을 하신 경우에 한하여<br />무이자
															혜택이 적용됩니다.(ARS 부문 무이자 할부 포함)
														</li>
														<li>상기 부분 무이자 할부는 5만원 이상 결제 시 자동 적용되며, 결제창에는 무이자 표시가
															되지 않을 수 있습니다.</li>
														<li>법인 / 체크 / 선불 / 기프트 / 은행 계열 카드는 제외됩니다.</li>
														<li>고객 부담 수수료는 해당 카드사로 문의 바랍니다.</li>
														<li>본 행사는 카드사 사정에 따라 일부 내용이 변경 또는 중단될 수 있습니다.</li>
													</ul>
												</div>
											</div>
										</div>
										<a href="javascript:void(0);" class="btn_close"><img
											src="http://cdn.thehandsome.com/_ui/desktop/common/images/popup/ico_close.png"
											alt="닫기" /></a>
									</div></li>

								<li><span class="title">배송비</span> <span class="txt">30,000원
										이상 무료배송 (실결제 기준)</span> <a href="javascript:fn_popupDelivery();"
									class="etc_info" onclick="GA_Event('상품_상세','배송안내','클릭');">배송안내</a>
									<div class="popwrap w_type_2" id="popupDelivery"
										style="display: none;">
										<div class="pop_tltwrap2">
											<h3>배송비안내</h3>
										</div>
										<div class="pop_cnt">
											<table class="cnt_type1">
												<caption>배송비안내</caption>
												<colgroup>
													<col style="width: 155px" />
													<col />
												</colgroup>
												<tbody>
													<tr>
														<th scope="row">배송기간</th>
														<td>평균 입금완료일 기준 2-4일 소요됩니다.<br />(토/일/공휴일 제외)
														</td>
													</tr>
													<tr>
														<th scope="row">배송비</th>
														<td>
															<ul class="bul_sty01_li">
																<li>30,000원 이상 결제 시 <em class="ft_point01">무료배송</em></li>
																<li>30,000원 미만 결제 시 <em class="ft_point01">2,500원</em></li>
															</ul>
															<p class="bul_sty02">도서산간 지역은 3,000원의 별도 배송비가 부과됩니다.</p>
															<p class="bul_sty02">쿠폰/바우처 할인금액 및 한섬마일리지/H.Point 사용을
																제외한 실결제금액 기준입니다.</p>
														</td>
													</tr>
												</tbody>
											</table>
										</div>
										<a href="javascript:void(0);" class="btn_close"><img
											src="http://cdn.thehandsome.com/_ui/desktop/common/images/popup/ico_close.png"
											alt="닫기" /></a>
									</div></li>
							</ul>
						</div>

						<div class="info_sect">

							<ul class="color_size_qty">
								<li><span class="title">색상</span>
									<div id="getcolor" class="txt">
										<!-- <ul class="color_chip clearfix">
						<input type="hidden" id="colorName" value="IVORY">
											<li id="YN2CAFOT063W_IV">
													<input type="hidden" class="colorNameVal" value="IVORY">
													<a href="#;" class="beige on" style="background:#fbfaea url('http://newmedia.thehandsome.com/YN/2C/FW/YN2CAFOT063W_IV_C01.jpg/dims/resize/24x24')" onmouseover="setColorName('IVORY');" onmouseout="setColorName('');"></a>
												</li>
						</ul> -->
									</div> <span class="cl_name" id="colorNameContent"></span></li>
								<li><span class="title">사이즈</span> <span class="txt">

										<div class="popwrap w_type_2" id="sizeQuickReferenceLayer"
											style="display: none;">


											<div class="pop_tltwrap2">
												<h3>사이즈조견표</h3>
											</div>
											<div class="pop_cnt">
												<div class="size_chart">
													<div class="tab_a m6" id="size_tab">
														<ul>
															<li><a href="#;" class="active">WOMEN<br />TOP
															</a></li>
															<li><a href="#;">WOMEN<br />BOTTOMS
															</a></li>
															<li><a href="#;">WOMEN<br />SHOES
															</a></li>
															<li><a href="#;">MEN<br />TOP
															</a></li>
															<li><a href="#;">MEN<br />BOTTOMS
															</a></li>
															<li><a href="#;">MEN<br />SHOES
															</a></li>
														</ul>
													</div>
													<div class="size_tab_container">
														<div>
															<table class="cnt_type2">
																<caption>사이즈조견표</caption>
																<colgroup>
																	<col />
																	<col style="width: 16%" />
																	<col style="width: 16%" />
																	<col style="width: 16%" />
																	<col style="width: 16%" />
																	<col style="width: 16%" />
																</colgroup>
																<thead>
																	<tr class="al_middle">
																		<th scope="col">BRAND/<br />SIZE
																		</th>
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
																		<td>160/<br />80A
																		</td>
																		<td>165/<br />84A
																		</td>
																		<td>170/<br />88A
																		</td>
																		<td>175/<br />92A
																		</td>
																		<td>-</td>
																	</tr>
																</tbody>
															</table>
														</div>
														<div style="display: none;">
															<table class="cnt_type2">
																<caption>사이즈조견표</caption>
																<colgroup>
																	<col />
																	<col style="width: 19%" />
																	<col style="width: 19%" />
																	<col style="width: 19%" />
																	<col style="width: 19%" />
																</colgroup>
																<thead>
																	<tr class="al_middle">
																		<th scope="col">BRAND/<br />SIZE
																		</th>
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
																		<td>160/<br />66A
																		</td>
																		<td>165/<br />68A
																		</td>
																		<td>170/<br />70A
																		</td>
																		<td>175/<br />72A
																		</td>
																	</tr>
																</tbody>
															</table>
														</div>
														<div style="display: none;">
															<table class="cnt_type2">
																<caption>사이즈조견표</caption>
																<colgroup>
																	<col />
																	<col style="width: 19%" />
																	<col style="width: 19%" />
																	<col style="width: 19%" />
																	<col style="width: 19%" />
																</colgroup>
																<thead>
																	<tr class="al_middle">
																		<th scope="col">BRAND/<br />SIZE
																		</th>
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
														<div style="display: none;">
															<table class="cnt_type2">
																<caption>사이즈조견표</caption>
																<colgroup>
																	<col />
																	<col style="width: 16%" />
																	<col style="width: 16%" />
																	<col style="width: 16%" />
																	<col style="width: 16%" />
																	<col style="width: 16%" />
																</colgroup>
																<thead>
																	<tr class="al_middle">
																		<th scope="col">BRAND/<br />SIZE
																		</th>
																		<th scope="col">S</th>
																		<th scope="col">M</th>
																		<th scope="col">L</th>
																		<th scope="col">XL</th>
																		<th scope="col">XXL</th>
																	</tr>
																</thead>
																<tbody>
																	<tr class="al_middle">
																		<th scope="row">TIME<br />HOMME
																		</th>
																		<td>90</td>
																		<td>95</td>
																		<td>100</td>
																		<td>105</td>
																		<td>110</td>
																	</tr>
																	<tr class="al_middle">
																		<th scope="row">SYSTEM<br />HOMME
																		</th>
																		<td>90</td>
																		<td>95</td>
																		<td>100</td>
																		<td>105</td>
																		<td>110</td>
																	</tr>
																	<tr class="al_middle">
																		<th scope="row">CLUB<br />MONACO
																		</th>
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
																		<td>165/<br />80-90
																		</td>
																		<td>170/<br />96-98
																		</td>
																		<td>175/<br />108-110
																		</td>
																		<td>180/<br />118-122
																		</td>
																		<td>185/<br />126-130
																		</td>
																	</tr>
																</tbody>
															</table>
														</div>
														<div style="display: none;">
															<table class="cnt_type2">
																<caption>사이즈조견표</caption>
																<colgroup>
																	<col />
																	<col style="width: 9.5%" />
																	<col style="width: 9.5%" />
																	<col style="width: 9.5%" />
																	<col style="width: 9.5%" />
																	<col style="width: 9.5%" />
																	<col style="width: 9.5%" />
																	<col style="width: 9.5%" />
																	<col style="width: 9.5%" />
																	<col style="width: 9.5%" />
																</colgroup>
																<thead>
																	<tr class="al_middle">
																		<th scope="col">BRAND/<br />SIZE
																		</th>
																		<th scope="col">S</th>
																		<th scope="col" colspan="2">M</th>
																		<th scope="col" colspan="2">L</th>
																		<th scope="col" colspan="2">XL</th>
																		<th scope="col" colspan="2">XXL</th>
																	</tr>
																</thead>
																<tbody>
																	<tr class="al_middle">
																		<th scope="row">TIME<br />HOMME
																		</th>
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
																		<th scope="row">SYSTEM<br />HOMME
																		</th>
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
																		<th scope="row">CLUB<br />MONACO
																		</th>
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
														<div style="display: none;">
															<table class="cnt_type2">
																<caption>사이즈조견표</caption>
																<colgroup>
																	<col />
																	<col style="width: 23%" />
																	<col style="width: 23%" />
																	<col style="width: 23%" />
																</colgroup>
																<thead>
																	<tr class="al_middle">
																		<th scope="col">BRAND<br />SIZE
																		</th>
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
											<a href="javascript:void(0);" class="btn_close"><img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/popup/ico_close.png"
												alt="닫기" /></a>
										</div>
										<ul class="size_chip clearfix sizeChipKo1901">
											<c:forEach var="stock" items="${stock}">
												<%-- <input type="button" class="btn btn-light btn-sm border"
												onclick="checkStock(this, ${product.pprice})"
												value="${size.sproductsize}" /> --%>
												<li><a href="#;" onclick="change_size('${stock.ssize}');">${stock.ssize}</a></li>
											</c:forEach>
										</ul> <%-- <ul class="size_chip clearfix sizeChipKo1901">
											<li>
												<a href="#;">55</a>
											</li>
											<li id="${product.pid}_FREE">
												<a href="javascript:void(0)" onclick="setSize()">FREE
												<span class="ko_size1901" style="display: none;">&nbsp;(55)</span>
												</a>
											</li>
											<!-- 										<li id="IL2C5WSH942W_DN_88"><a -->
											<!-- 											href="javascript:fn_detailProductAjax('IL2C5WSH942W_DN_88')" -->
											<!-- 											onclick="GA_Event('상품_상세','사이즈','88')">88<span -->
											<!-- 												class="ko_size1901">&nbsp;(66)</span></a></li> -->
										</ul> --%>
								</span> <!-- 2021.08.10 화장품 상품인 경우 사이즈조견표 영역 미노출 -->
								<a href="javascript:fn_popupSizeQuickReference();"
									class="etc_info" onclick="GA_Event('상품_상세','사이즈_조건표','클릭')">사이즈
										조견표</a> <!-- 재입고알림 툴팁 --> <!-- //재입고알림 툴팁 --></li>
								<li>
									<span class="title">수량</span>
									<span class="txt">
										<span class="qty_sel num">
											<a style="cursor:pointer" onclick="change_qty('left');" class="left"></a>
											<input type="text" id="txtqty" title='수량' value="1" class="mr0" readonly="readonly"> 
											<a style="cursor:pointer" onclick="change_qty('right');" class="right">다음 버튼</a>
										</span>
									</span>
									<input type="hidden" id="erpWorkOrderNumber" />
									<input type="hidden" id="reserveSalesStockpile" />
									<input type="hidden" id="erpWorkOrderProdCode" />
								</li>
							</ul>
						</div>
						<div class="total_price clearfix">
							<input  type="hidden" name="price" id="price" value="${product.pprice}" readonly="readonly">
							<div class="title float_left" style="width: auto;">총 합계</div>
							<div class="pirce float_right">
								<!-- 				<div class="tlt_ship"> -->
								<!-- 				<div class="delch_box" style="display: none;"> -->
								<!-- 	       			<span class="arr">위치아이콘</span> -->
								<!-- 	                <div> -->
								<!-- 	                    <div id="exchangeDiv"></div> -->
								<!-- 	                </div> -->
								<!-- 	        	</div> -->
								<!-- 				</div> -->
								<span id="sumPrice">₩
									<fmt:formatNumber value="${product.pprice }" type="number" pattern="###,###" />
								</span>
							</div>
						</div>
						<!-- st_receipt_wrap -->
						<div class="st_receipt_wrap">
							<div class="store_pickup"
								style="padding-bottom: 0; border-bottom: 0">
								<div class="input_wrap">

									<input type="checkbox" id="storePickupCheck"
										name="storePickupCheck"
										onclick="GA_Event('상품_상세','수령','매장수령');" /><label
										for="storePickupCheck">매장수령</label>
								</div>
								<img
									src="http://cdn.thehandsome.com/_ui/desktop/common/images/common/ico_ques2.png"
									alt="매장수령이란?" class="tlt" />
								<div class="text">
									<p>매장에서 직접 상품 수령을 원하는 경우 체크하세요.</p>
									<p>&#40;여러 개 상품 주문 시, 수령 매장이 동일한 경우 가능&#41;</p>
								</div>
								<!-- delch_box -->
								<div class="delch_box" id="store_delbox">
									<span class="arr">위치아이콘</span> <strong>매장 수령 이란? </strong> 매장
									수령을 원하시면 선택하세요.<br /> 여러 개의 상품 주문 시 수령 매장이 동일해야 합니다.
								</div>
								<!-- //delch_box -->
							</div>
							<!-- //delch_box -->
							<!-- //delch_box -->
						</div>
						<!-- //st_receipt_wrap -->

						<!-- st_store_wrap -->
						<div class="st_store_wrap1807" id="storePickupChoice"
							style="display: none;">
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
								<li>수령 확정일로부터 <span style="color: #fe4242;">1일 경과 후
										상품을 수령하지 않으시면 자동 취소</span> 됩니다.
								</li>
							</ul>
						</div>
						<!-- //st_store_wrap -->
						<div class="btnwrap clearfix"
							style="position: absolute; width: 473px;">
							<input type="button" value=""
								class="btn wishlist1803 float_left ml0  "
								onclick="addWishListClick();GA_Event('상품_상세','하단 고정 버튼','좋아요');">

							<div class="toast_popup">
								<p style="display: none; top: -4.12381px; opacity: 0.031172;">위시리스트에서
									삭제했습니다.</p>
							</div>

							<!--190508 추가 -->
							<div class="toast_popup_pre_order1905">
								<!-- 토스트팝업 190507 -->
								<p>
									예약 주문이 가능한 옵션(컬러/사이즈)가 있습니다. <br />옵션 선택 후 배송 예정일을 확인해 주세요.
								</p>
								<span class="arr">위치아이콘</span>
							</div>
							<!--//190508 추가 -->
							<form id="addToCartForm" name="addToCartForm"
								action="/shoppingbag" method="post">
								<!-- <input type="hidden" maxlength="3" size="1" name="qty"class="qty" />  -->
								<input type="hidden" id="pid" name="pid" value="${product.pid }" />
								<input type="hidden" id="ccolorcode" name="ccolorcode" value="${ColorVO.ccolorcode}" /> 
								<input type="hidden" id="mid" name="mid" value="${mid}" /> 
								<input type="hidden" id="psize" name="psize" value="" /> 
								<input type="hidden" id="pamount" name="pamount" value="1" /> 
								<input type="button" value='쇼핑백 담기'
									class="btn cart1803 float_left ml0" id="addToCartButton"
									onClick="addToCart();" />
								<div>
								<!-- <input type="hidden" name="CSRFToken" value="ec35065f-63f2-4b5d-8f20-aec5bd737cbc" /> -->
								</div>
							</form>
							<input type="button" value="바로주문"
								class="btn order float_right mr0" id="addToCartBuyNowButton"
								onClick="getproduct()">
						</div>


						<dl class="toggle_type1" style="margin-top: 80px;">
							<!-- 상품상세 정보창 변경 211027 S -->
							<dt>
								<a href="javascript:void(0);" id="NEW_DETAIL_INFO_EVT">상품상세정보</a>
							</dt>
							<dd>
								<div class="product-info-211027">
									<h3>상품 추가 정보</h3>
									<table>
										<caption>상품 추가 정보</caption>
										<colgroup>
											<col style="width: 91px">
											<col style="width: 125px;">
											<col style="width: 127px">
											<col style="width: 126px;">
										</colgroup>
										<tbody>
											<tr>
												<th>핏</th>
												<td>슬림핏</td>
												<td class="bold">레귤러핏</td>
												<td>루즈핏</td>
											</tr>
											<tr>
												<th>신축성</th>
												<td>없음</td>
												<td>조금 있음</td>
												<td class="bold">있음</td>
											</tr>
											<tr>
												<th>비침</th>
												<td class="bold">없음</td>
												<td>약간</td>
												<td>있음</td>
											</tr>
											<tr>
												<th>두께</th>
												<td class="bold">얇음</td>
												<td>보통</td>
												<td>두꺼움</td>
											</tr>
											<tr>
												<th>안감</th>
												<td class="bold">없음</td>
												<td>부분 안감</td>
												<td>전체 안감</td>
											</tr>
										</tbody>
									</table>
									<p>상기 정보는 주관적 내용이므로 참고해주세요</p>
								</div>
							</dd>
							<!-- 상품상세 정보창 변경 211027 E -->
							<dt>
								<a href="javascript:void(0);" id="DETAIL_INFO_EVT"> 상품정보제공고시</a>
							</dt>
							<dd style="display: none;">
								<strong>상품품번 :</strong> IL2C5WSH942W<br /> <strong>품목
									:</strong> 의류<br /> <strong>소재 :</strong> 겉감 면 18%, 나일론 79%, 폴리우레탄 3%,
								배색1 견 100%, 배색2 폴리에스터 100%(DN,WT)<br /> <strong>색상 :</strong>
								WT(WHITE), DN(DARK NAVY)<br /> <strong>사이즈 :</strong> 88, 82<br />
								<strong>제조국 :</strong> 한국<br /> <strong>제조사 :</strong> (주)한섬<br />
								<strong>제조연월 :</strong> 202204<br /> <br /> <strong>품질보증기준</strong><br />
								1. 본 제품은 정부 고시 소비자 분쟁해결 기준에 의거 고객의 정당한 피해를 보상해드립니다. <br> -
								원단 불량, 부자재 불량, 봉제 불량, 사이즈 부정확, 부당 표시(미표시 및 부실표시) 및 소재 구성 부적합으로
								인한 세탁 사고 : 구입일로부터 1년 이내분은 무상수리, 교환, 구입가 환불함. (단, 봉제 불량은 1년 경과
								후에도 무상 수선 가능) <br> - 사이즈가 맞지 않거나 디자인, 색상 불만 제품 : 구입 후 7일
								이내로서 제품에 손상이 없는 경우 동일 가격, 동일 제품으로 교환 가능. <br> - 상하의 한
								벌(세트/일착)인 경우 한 쪽에만 이상이 있어도 한 벌(세트/일착)로 처리함. 단, 소재 및 디자인이 다른 경우에는
								해당 의류만 교환 가능. <br>2. 소비자 부주의에 의한 제품 훼손, 세탁 잘못으로 인한 변형 및 품질
								보증기간(1년)이 경과한 제품에 대해서는 보상의 책임을 지지 않으며, 수선 가능시에는 실비로 수선해드립니다. <br>3.
								제품에 이상이 있는 경우 바로 본사로 연락주시면 수선/교환/환불이 가능하나, 타업체(일반 수선실 등)에서 수선했을
								경우는 불가능합니다.<br /> <br /> <strong>세탁방법 및 취급 시 주의사항</strong><br />
								본 제품은 반드시 드라이크리닝 하십시오. 세탁 시 이염, 변색, 탈색될 수 있으니 유의하시기 바랍니다. 단추나
								악세서리는 세탁 시 손상될 수 있으므로 은박지로 싸거나 분리하여 주십시오. 특성상 마찰에 의해 올 뜯김 등 원단
								손상이 발생할 수 있으니 취급 시 주의하시기 바랍니다.<br /> <br />
								<div style="margin-bottom: 20px;">
									<p style="float: left;">
										<strong>AS 책임자와 연락처</strong><br /> ㈜한섬/1800-5700
									</p>
									<!-- 20200218 마크 추가 -->
									<div class="sft_ksdt"></div>
									<!-- // 20200218 마크 추가 -->
								</div>
								<br /> <br /> 위 내용은 상품정보제공 고시에 따라 작성되었습니다.
							</dd>
							<!-- 2021.08.10 화장품 상품인 경우 실측사이즈 영역 미노출 -->
							<dt>
								<a href="javascript:void(0);" id="REAL_SIZE_EVT">실측사이즈</a>
							</dt>
							<dd>
								<div class="ko realsize_img SZ03"></div>
								<p class="tit">셔츠</p>
								<!-- info_tbl -->
								<div class="detail-size-bd">
									<!--20200910 -->
									<!-- 20160627 -->
									<span class="unit">단위(cm)</span>
									<!-- 아우터 사이즈 -->
									<table class="unit-board" border="0">

										<!-- 2019.07.24 아이템별 노출항목 판단 -->
										<!-- 2020.08.19 아이템별 노출항목 판단 -->
										<!-- 탑(베스트 제외) 2020.08.19 sizeCode 추가( SZ13 ~ SZ16 ) -->
										<caption>아우터 실측사이즈</caption>
										<colgroup>
											<col style="width: 81px;" />
											<col style="width: auto;" />
											<col style="width: auto;" />
											<col style="width: auto;" />
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
												<td>65.4</td>
												<td>66.68</td>
											</tr>
											<tr>
												<th scope="row">가슴단면</th>
												<td>53.34</td>
												<td>56.52</td>
											</tr>
											<tr>
												<th scope="row">어깨너비</th>
												<td>56.52</td>
												<td>59.69</td>
											</tr>
										</tbody>
									</table>
								</div>
								<!-- //info_tbl -->

								<!-- <p class="txt_last">- 모델착용사이즈 : <strong>82</strong></p> -->
								<!-- 20160627 -->

								<!-- info_tbl -->

								<!-- //info_tbl -->
								<!-- numlist -->
								<br />
								<!-- //numlist -->
								<font color="red"> <strong> 원단, 측정방법에 따라 약간의 오차
										가능성이 있습니다.</strong>
								</font>

								<div class="timehomme_pants_fit" style="display: none"></div>
							</dd>
							<dt>
								<a href="#" id="DELI_RETURN_EVT">배송 및 교환/반품</a>
							</dt>
							<dd>
								<p class="tit">배송안내</p>
								<dl class="info_tbl">
									<dt>배송방식 :</dt>
									<dd>우체국택배, CJ대한통운, 부릉, 굿투럭</dd>
									<!-- 210728 oera 신규 추가  -->
									<dt>배송지역 :</dt>
									<dd>전국 (일부 지역 제외)</dd>
									<dt>배송정보 :</dt>
									<dd>평균 입금완료일 기준 2-4일 소요됩니다 (토/일/공휴일 제외)</dd>
									<dt>배송비 :</dt>
									<dd>
										실결제금액 기준 30,000원 이상 결제 시 무료배송<br>30,000원 미만 결제 시
										2,500원(기본 배송비)<br>* 실결제금액이란, 쿠폰/바우처 할인액 및 <br>&nbsp;
										한섬마일리지/H.Point 사용 금액을 제외한 금액입니다. <br>
										&nbsp;&nbsp;(e-money 사용은 실결제금액에 포함)<br>* 도서산간 지역은 3,000원의
										별도 배송비가 부과됩니다.<br>* 일부 도서지역은 도선료가 부가될 수 있습니다.
									</dd>
								</dl>
								<p class="tit mt20">교환 및 반품안내</p>
								<!-- info_tbl -->
								<dl class="info_tbl">
									<dt>교환/반품 기간 :</dt>
									<dd>상품 수령 후, 7일 이내</dd>
									<dt>교환절차 :</dt>
									<dd style="letter-spacing: -0.2px;">
										사이즈 및 상품불량 교환만 가능(색상교환 불가)하며 교환을 원하실 경우<br> 고객센터로 문의해주시기
										바랍니다. (교환 재고가 없을 경우, 환불로 안내예정)<br> - 교환은 배송비 입금 및 상품 입고
										확인 이후에 진행됩니다. <br> 화장품은 상품 불량만 교환 가능하며(상품 개봉 후 교환 불가),
										고객센터로<br> 문의해주시기 바랍니다.
										<!-- 210728 oera 신규 추가  -->
									</dd>
									<dt>반품절차 :</dt>
									<dd>
										[배송완료] 7일 이내에 마이페이지 주문/배송/취소/반품 메뉴에서<br> [반품신청] 버튼을 클릭 시
										가능합니다.
									</dd>
									<dt>교환/반품 배송비 :</dt>
									<dd style="letter-spacing: -0.4px;">
										배송비는 5,000원 이며(반품비는 주문시 배송비 결제 유무에 따라 변동)<br>상품 불량 등의 이유로
										교환/반품하실 경우, 배송비는 무료입니다.
									</dd>
									<dt>교환/반품 불가사유</dt>
									<dd>
										다음의 경우에는 교환/반품이 불가합니다.
										<ol class="numlist">
											<li><span class="num sum">-</span> <span class="txt">교환/반품
													기간(상품 수령 후 7일 이내)을 초과하였을 경우</span></li>
											<li><span class="num sum">-</span> <span class="txt">고객님의
													요청에 의해 제품 사양이 변경(이니셜 제품, 사이즈 맞춤 제품 등)된 경우</span></li>
											<li><span class="num sum">-</span><span class="txt">제품을
													이미 사용하였거나, 제품 일부를 소비하였을 경우</span></li>
											<!-- 210728 oera 신규 추가  -->
											<li><span class="num sum">-</span> <span class="txt">화장품
													: 상품 개봉 후 교환/반품 불가. 단 상품 불량(내용물 불량) 혹은 피부 트러블로 인한 반품은 가능(용량
													1/3 미만 사용 및 의사소견서 1:1문의 첨부 필수)</span></li>
											<!-- // 210728 oera 신규 추가  -->
											<li><span class="num sum">-</span> <span class="txt">식기류
													: 제품 수령 후, 비닐포장을 개봉한 경우</span></li>
											<li><span class="num sum">-</span> <span class="txt">고객님의
													귀책사유로 인해 회수가 지연될 경우</span></li>
											<li><span class="num sum">-</span> <span class="txt">국내외
													환율 변동 등에 의해 가격이 변동되는 제품의 경우</span></li>
											<li><span class="num sum">-</span> <span class="txt">문제소지가
													있는 제품을 본사가 아닌, 타 업체(일반 수선실 등)에서 선처리가 된 경우</span></li>
										</ol>
									</dd>
									<!-- 210728 oera 신규 추가  -->
									<dt>교환/반품건 배송</dt>
									<dd>
										교환/반품 시 배송 받으신 박스로 반송하셔야 합니다. <br>(한섬/오에라/리퀴드퍼퓸바 상품 함께 주문
										후 교환/반품 시 각각의 박스에 나눠서 반송해주세요. 한 박스에 함께 동봉하여 반송 시 교환/반품 처리가 불가할
										수 있습니다)
									</dd>
									<!-- // 210728 oera 신규 추가  -->
								</dl>
								<p class="tit mt20">환불안내</p>
								<p>환불은 반송제품 확인 후 진행됩니다.</p>
								<br />
							</dd>

						</dl>
					</div>

					<div class="clearfix mt30">
						<div class="btnwrap float_left">
							<!-- 			<a href="javascript:fn_popupProductQnA();" class="btn arrow mr0" onclick="GA_Event('상품_상세','Q&A','클릭');">Q&amp;A(<span class="data" id="productQnACnt">0</span>)</a> -->
							<a href="/mypage" class="btn arrow mr0"
								onclick="GA_Event('상품_상세','Q&A','클릭');" style="cursor: hand;">Q&amp;A</a>
						</div>
						<div class="float_right">
							<!-- AddToAny BEGIN -->
							<div class="a2a_kit a2a_kit_size_32 a2a_default_style">
								<a
									href='javascript:fnSharePin("http://www.thehandsome.com/ko/HANDSOME/WOMEN/Top/Shirts/%EC%8B%9C%EC%8A%A4%EB%A3%A8-%ED%8C%A8%EB%84%90-%EC%BA%A1-%EC%8A%AC%EB%A6%AC%EB%B8%8C-%EC%85%94%EC%B8%A0/p/IL2C5WSH942W_DN");'
									class="pinterest"
									onclick="GA_Event('상품_상세','공유_SNS','PRINTEREST');"></a> <input
									type="hidden" id="url"
									value="http://www.thehandsome.com/ko/HANDSOME/WOMEN/Top/Shirts/%EC%8B%9C%EC%8A%A4%EB%A3%A8-%ED%8C%A8%EB%84%90-%EC%BA%A1-%EC%8A%AC%EB%A6%AC%EB%B8%8C-%EC%85%94%EC%B8%A0/p/IL2C5WSH942W_DN" />
							</div>

						</div>
					</div>

					<input type="hidden" id="viewExhibitionPageCode" value="" /> <input
						type="hidden" id="viewExhibitionPageName" value="" />

				</div>

				<form id="PAY_FORM" method="post" accept-charset="euc-kr"></form>
			</div>
			<div class="product-detail-img"></div>
			<div class="matches_items" id="productDetailEtc"></div>
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
		<div class="popwrap w_type_4" id="productQnADiv"
			style="display: none;">

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
			<a href="javascript:void(0);" class="btn_close"><img
				src="http://cdn.thehandsome.com/_ui/desktop/common/images/popup/ico_close.png"
				alt="닫기" /></a>
		</div>


		<div class="popwrap w_type_3" id="productQnAWriteDiv"
			style="display: none;">
			<div class="pop_tltwrap2">
				<h3>상품문의하기</h3>
			</div>
			<div class="pop_cnt evaluation_write">
				<form id="productQnAForm" name="productQnAForm"
					action="/ko/HANDSOME/WOMEN/Top/Shirts/%EC%8B%9C%EC%8A%A4%EB%A3%A8-%ED%8C%A8%EB%84%90-%EC%BA%A1-%EC%8A%AC%EB%A6%AC%EB%B8%8C-%EC%85%94%EC%B8%A0/p/IL2C5WSH942W_DN?categoryCode=we01"
					method="post" enctype="multipart/form-data">
					<input type="hidden" id="productCode" name="productCode" /> <input
						type="hidden" id="productQnaCode" name="productQnaCode" /> <input
						type="hidden" id="delAttach" name="delAttach" value="N" />
					<fieldset>
						<legend>상품문의하기</legend>
						<div class="tblwrap">
							<p class="reqd_txt float_right">
								<strong class='reqd'>*</strong> 표시는 필수항목입니다.
							</p>
							<table class="tbl_wtype1">
								<caption>상품문의하기 입력항목</caption>
								<colgroup>
									<col width="140px">
									<col width="*">
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><strong class='reqd'>*</strong><label
											for='inquiryTitle'>문의제목</label></th>
										<td><input type="text" id="inquiryTitle"
											name="inquiryTitle" title="input" style="width: 100%" /></td>
									</tr>
									<tr>
										<th scope="row"><strong class='reqd'>*</strong><label
											for='inquiryContents'>문의내용</label><span class='com_txt_p'>(300자
												이하)</span></th>
										<td><textarea name="inquiryContents" id="inquiryContents"
												cols="30" rows="5" style="width: 98%; height: 200px"></textarea>
										</td>
									</tr>
									<tr>
										<th scope="row" class="th_space"><label for="file">파일
												첨부하기</label></th>
										<td>
											<!-- File upload -->
											<div class="file_upload">
												<input type="text" id="textQnAFile" class="text"
													title="파일찾기" readonly="readonly" name="fileText"> <a
													href="javascript:void(0);" id="delQnAFile"> <img
													src="http://cdn.thehandsome.com/_ui/desktop/common/images/popup/ico_close.png"
													alt="파일삭제">
												</a>
												<div class="upload_btn">
													<label for="qnaFile"><button type="button"
															id="uploadFile" class="img_upload" title="파일찾기">
															<span>파일찾기</span>
														</button></label> <input type="file" id="qnaFile" name="uploadFile"
														class="btn add_s" title="파일찾기" />
												</div>
											</div> <!-- //File upload -->
											<p class="txt_guide">10MB 미만의 jpg,gif,png 파일만 첨부하실 수
												있습니다.</p>
										</td>
									</tr>
									<tr>
										<th scope="row" class="th_space"><label
											for="inquiryMobileNo2">SMS 알림받기</label></th>
										<td>
											<div style="position: relative;">
												<input type="hidden" id="smsMobileNo" name="smsMobileNo" />
												<select id="inquiryMobileNo1" title="휴대폰 번호 앞자리"
													style="width: 80px; margin-top: 0; vertical-align: middle; padding: 3px 8px 3px 8px;">
													<option value="010" selected="selected">010</option>
													<option value="011">011</option>
													<option value="016">016</option>
													<option value="017">017</option>
													<option value="018">018</option>
													<option value="019">019</option>
												</select>
												<div class="form_hyphen">-</div>
												<input type="text" id="inquiryMobileNo2"
													name="inquiryMobileNo2" title="휴대폰 번호 가운데자리"
													style="width: 80px;" maxlength="4" />
												<div class="form_hyphen">-</div>
												<input type="text" id="inquiryMobileNo3"
													name="inquiryMobileNo3" title="휴대폰 번호 뒷자리"
													style="width: 80px;" maxlength="4" /> <span
													class="sms_alm_2006_chk"
													style="display: block; position: absolute; top: 3px; right: 14px;">
													<input type="hidden" id="smsNoticeYN" name="smsNoticeYN"
													value="N" /> <input type="checkbox"
													id="inquirySmsNoticeYn" name="inquirySmsNoticeYn"
													style="margin-top: 1px;"> <label
													for="inquirySmsNoticeYn">SMS 알람고지</label>
												</span>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="inquiryEmailAddress"><strong
												class='reqd'>*</strong><label for='inquiryMobileNo2'>이메일
													답변받기</label></label></th>
										<td><input type="hidden" id="replyToEmail"
											name="replyToEmail" /> <input type="text"
											id="inquiryEmailAddress" name="inquiryEmailAddress"
											title="이메일아이디" style="width: 120px;" /> <span
											class="andmail">@</span> <input type="text"
											id="inquiryEmailDomain" name="inquiryEmailDomain"
											title="이메일계정 입력란" style="width: 120px;" /> <select
											id="inquiryEmailSel" title="이메일계정"
											style="width: 140px; padding: 3px 8px 3px 8px;">
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
										</select></td>
									</tr>
								</tbody>
							</table>
						</div>
						<p class="guide_txt clearfix" style="border-top: 0;">
							<span class="float_left"><strong>상품에 관한 배송, 교환,
									취소 등의 자세한 문의사항은 고객센터를 이용해 주시기 바랍니다.</strong></span> <span class="float_right">
								<input type="checkbox" name="securitySentenceYn"
								id="securitySentenceYn" value="Y" /> <label
								for="securitySentenceYn">비밀글 설정</label>
							</span>
						</p>
						<div class="btnwrap mt40">
							<input type="button" id="qnaCancle" value='취소하기' class="btn wt" />
							<input type="button" id="qnaWriteSend" value='등록하기'
								class="btn gray mr0" />
						</div>
					</fieldset>
					<div>
						<input type="hidden" name="CSRFToken"
							value="ec35065f-63f2-4b5d-8f20-aec5bd737cbc" />
					</div>
				</form>
			</div>
			<a href="javascript:void(0);" class="btn_close"><img
				src="http://cdn.thehandsome.com/_ui/desktop/common/images/popup/ico_close.png"
				alt="닫기" /></a>
		</div>
		<!-- layer pop 1 -->
		<div class="popwrap w_type_3" id="storePickupDiv"
			style="display: none;">
			<!--title-->
			<div class="pop_tltwrap">
				<h3>수령 매장 선택</h3>
			</div>
			<!--//title-->
			<!--contents-->
			<div class="pop_cnt zipcode">
				<!-- search -->
				<div class="search">
					<label for="search">지역명 (도로명)</label> <input type="text"
						id="storePickupSearchWord" name="searchWord"
						placeholder="매장명 또는 지역 명을 입력 후 검색해 주세요" style="width: 260px" /> <input
						type="button" value="검색" id="storePickupSearchBtn"
						class="btn wt_s mr0 min_auto" />
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
						<input class="btn wt_s" id="storePickupCloseBtn" value="취소"
							type="button" /> <input class="btn gray_s"
							id="storePickupChoiceBtn" value="확인" type="button" />
					</div>
				</div>
				<!-- //del_tab_container -->
			</div>
			<!--//contents-->
			<a href="#;" class="btn_close" id="storePickupClose"><img
				src="http://cdn.thehandsome.com/_ui/desktop/common/images/popup/ico_close.png"
				alt="닫기" /></a>
		</div>

		<script>
			function addToCart(buyNow)
			{
				var qty = $("#txtqty").val();

				var size = $("#psize").val();

				//사이즈 선택 안했을 시 경고창
				if(size == ""){
					/* var la = new layerAlert('사이즈를 선택해 주세요.'); */
					alert('사이즈를 선택해 주세요.');
					return;
				}
				/* // 로그인이 안되어있을 경우 로그인페이지로 이동
                if("${sessionScope.member.mid}" == ""){
	          location.href="/member/login";
	          return;
	       } */
				if(true){
					addToCartProcess = false;
					var pid = $('form[name=addToCartForm] input[name=pid]').val();
					var psize = $('form[name=addToCartForm] input[name=psize]').val();
					var pamount = $('form[name=addToCartForm] input[name=pamount]').val();
					var pcolor = $("#ccolorcode").val();
					/* if(pcolor == null) {
                       var split_arr = pid.split('_');
                       pcolor = split_arr[1];
                    } */

					console.log("여기함수: "+pid);
					console.log("여기함수: "+psize);
					console.log("여기함수: "+pamount);
					console.log("여기함수: "+pcolor);

					/* console.log(pid, psize, pcolor, pamount); */
					// 장바구니 등록하는 ajax 호출
					$.ajax({
						url: "/cart/add",
						method: "post",
						data : {
							mid : "${member.mid}",
							pid : pid,
							psize : psize,
							pcolor : pcolor,
							pamount : pamount
						},
						success: function (data) {
							console.log("${member.mname}");
							alert("완료되었습니다.");
							location.href='/cart/cartList';
						},
						error : function( request, status, error ){
							console.log( "code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
						}
					});



				}
			}
			function getproduct(){
				var qty = $("#txtqty").val();
				var size = $("#psize").val();
				location.href="/order/orderpage?mid=${member.mid}&pid=${product.pid}&ccolorcode=${ColorVO.ccolorcode}&amount="+ qty +"&ssize=" + size;
			}
		</script>
		<!-- layer pop 1 -->
		<!-- layer pop 1 -->
</body>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>