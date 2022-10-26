<!-- 김민선 생성 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<head>

<style>
.afterbtn {
	display: none;
}
</style>
</head>
<script src="/jquery-3.4.1.min.js"></script>

<body oncontextmenu='return false'>

<form id="join_form" action="/order/orderlistinsert" method="POST">
	<!-- bodyWrap -->
	<div id="bodyWrap">
		<h3 class="cnts_title">
			<span>배송&amp;결제정보 입력</span>
		</h3>
			<!--sub_container-->
			<div class="sub_container">
				<!--orderwrap-->
				<div class="orderwrap del_pay">
					<!--orderwrap left-->
					<div>
						<!--table wrap1-->
						<div id="checkoutCartView" class="tblwrap">
							<table class="tbl_ltype ">

								<caption>배송&amp;결제정보 입력</caption>
								<colgroup>
									<col />
									<col style="width: 66px" />
									<col style="width: 158px" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">상품정보</th>
										<th scope="col">수량</th>
										<th scope="col">상품 금액</th>
									</tr>
								</thead>
								<tbody>
									<tr class="al_middle">
										<td class="frt" style="height: 200px;">
											<!-- pt_list_all -->
											<div class="pt_list_all"
												style="width: 700px; height: 150px; padding: 0px;">
												<img style="height: 150px; width: 150px;"
													src="${colorVO.cimage2}" alt="" />

												<div class="tlt_wrap" style="font-size: 20px; width: 500px;">
													<a class="basket_tlt"> <span class="tlt"
														style="font-size: 20px; margin-bottom: 60px; padding-left: 200px; height: 50px;">${productVO.bname}</span>
														<span class="sb_tlt"
														style="font-size: 20px; padding-left: 200px; height: 40px; margin-top: 10px;">${productVO.pname}</span>

													</a>
													<p class="color_op"
														style="font-size: 20px; padding-left: 200px; width: 300px;">

														color : ${curColorCode} <span class="and_line"
															style="font-size: 20px;">/</span> size : ${size}
													</p>
												</div>
											</div> <!-- //pt_list_all -->
										</td>
										<td style="font-size: 20px;">${txtqty}</td>
										<td>
											<!-- price_wrap -->
											<div class="price_wrap ">
												<span style="font-size: 20px;"> ₩${productVO.pprice}</span>
											</div> <!-- //price_wrap -->
										</td>
									</tr>
								</tbody>
							</table>
							<script>
								var checktHandsomepointUsableAmount = parseInt('0');
							</script>
						</div>
						<!--//table wrap1-->

						<!--title_wrap & table wrap3-->
						<div class="title_wrap clearfix mt40">
							<h4 class="float_left">주문자 정보</h4>
						</div>
						<div class="tblwrap">
							<table class="tbl_wtype1">
								<caption>주문자 정보</caption>
								<colgroup>
									<col style="width: 140px" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row" class="th_space" >주문자</th>
										<td>${member.mname}</td>
										<input type="hidden" id="mid" name="mid" value="${member.mid}">
									</tr>
									<tr>
										<th scope="row" class="th_space">휴대폰</th>
										<td>${member.mtel}</td>
									</tr>

								</tbody>
							</table>
						</div>


						<div class="title_wrap clearfix mt40" id="deliveryAddressDisplay">
							<h4 class="float_left">배송지 정보</h4>
							<p class="reqd_txt none">
								<strong class="reqd">*</strong> 표시는 필수항목입니다.
							</p>

						</div>

						<div class="tblwrap" id="deliveryInfoTitle">
							<table class="tbl_wtype1">
								<caption>배송지 정보</caption>
								<colgroup>
									<col style="width: 140px" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row" class="tooltip191022"><strong
											class="reqd">*</strong> <label for="adress">배송지 주소</label></th>
										<td>
											<!-- address --> <input value="" title="우편번호" id="adress"
											name= "ozipcode" class="post" type="text" placeholder="우편번호" />
											<br />
											<div id="basis_bk_flag">
												<input value="" title="주소1" name="oaddress1" id="line1"
													class="post_wall top" type="text"
													placeholder="주소를 입력해 주세요." />
											</div> <input value="" title="주소2" name="oaddress2" id="line2"
											class="post_wall" type="text" maxlength="110"
											placeholder="나머지 주소를 입력해 주세요." /> <!-- //address -->
										</td>
									</tr>
									<tr>
										<th scope="row"><strong class="reqd">*</strong><label
											for="rcpt_name">수령인</label></th>
										<td><input value="" title="수령인" id="rcpt_name"
											name="oreceiver" maxlength="13" type="text"
											style="width: 118px;" /></td>
									</tr>
									<tr>
										<th scope="row"><strong class="reqd">*</strong><label
											for="hp">휴대폰 번호</label></th>
										<td>
											<input title="휴대폰 번호 " style="width: 120px"
											id="mtel" name='otel' class="hp_num2" type="text"
											numberOnly="true" />
											
										</td>
									</tr>

								</tbody>
							</table>

						</div>
						<!--//title_wrap & table wrap4-->
						<!--title_wrap & table wrap2-->
						<div class="title_wrap  mt40">
							<h4 class="float_left">쿠폰 및 혜택 적용</h4>
							<p class="guide_comment">쿠폰을 적용하셔야 할인 혜택이 가능합니다.</p>
						</div>

						<div class="tblwrap">
							<table class="tbl_wtype1">
								<colgroup>
									<col style="width: 140px">
									<col>
								</colgroup>
								<tbody>
									<tr>
										<th scope="row" class="th_space">쿠폰 및 혜택<br>선택
										</th>
										<td>
											<div class="vvip_td_wrap" id="select_voucher">
												<div class="coupon_select_wrap" style="margin-top: 15px">

													<select title="쿠폰을 선택해 주세요." id="selectVoucher"
														style="width: 210px;">
														<option value="">사용 가능한 쿠폰이 없습니다.</option>
														<option id="cname" name="cname" value="${couponVO}"><%=session.getAttribute("cc")%></option>
													</select>
													<div class="btnwrap">
														<a href="#;" id="btnRedeemVoucher"
															class="btn add_s min_auto" onclick="redeemVoucher(this);">
															적용</a> <a href="#;" style="display: none"
															id="btnReleaseVoucher" class="btn dis_s min_auto"
															onclick="releaseVoucher(this);"> 적용취소</a>
													</div>
												</div>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>


						<div class="title_wrap clearfix mt40">
							<h4 class="float_left">최종 결제 금액</h4>
						</div>
						<div class="tblwrap">
							<table class="tbl_wtype1" style="margin-bottom: 20px;">
								<caption>최종 결제 금액</caption>
								<colgroup>
									<col style="width: 140px" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row" class="th_space">할인 금액</th>
										<td>
											<span class="beforebtn">₩ 0</span> 
											<input type="hidden" id ="sale" value="<%=session.getAttribute("cupto")%>" />
											<span class="afterbtn">₩</span>
											<div class="afterbtn" id ="sale_price"> </div>
										</td>
									</tr>
									<tr>
										<th scope="row" class="th_space">총 합계</th>
										<td>
											<span class="beforebtn">₩ ${productVO.pprice}</span> 
											<input type="hidden" id ="totalPrice" value="${productVO.pprice}" />
											<span class="afterbtn">₩</span><div class="afterbtn" id ="total_price">  </div>
										</td>
									</tr>

								</tbody>
							</table>

							<input type="hidden" name="total" id="total" value="651000.0" />
							<input type="hidden" name="cartDeliveryCost"
								id="cartDeliveryCost" value="0.0" />
						</div>
						<!--//final payment sum box-->
						<!--point & agreement box-->
						
						<div style="display: flex; justify-content: center;">
							<button  id="doOrderBtn" type="submit" >결제하기</button>
							
						</div>
					</div>
					<!--//orderwrap right-->
				</div>
				<!--//orderwrap-->
			</div>
			<!--//sub_container-->
</form>


<script>
	var price = document.getElementById("totalPrice").value
	var sale = <%=session.getAttribute("cupto")%>;
	var sale_price = (price * sale)/100;
	var total_price = (price * (100 - sale))/100;
	console.log(price);	
	console.log(sale);
	console.log(sale_price);
	console.log(total_price);
	document.getElementById("sale_price").innerHTML=sale_price;
	document.getElementById("total_price").innerHTML=total_price;
	
	
function redeemVoucher(){
	$('.afterbtn ').css("display", 
			"inline");
	$('.beforebtn').css("display", "none");
}
</script>


	<!-- footerWrap -->

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>