<!-- 김민선 생성 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<head>
<script src="/jquery-3.4.1.min.js"></script>
<body oncontextmenu='return false'>



	<form id="customerAddress" name="customerAddress"
		action="/ko/checkout/ordersheet" method="post">
		<input type="hidden" name="sel_lastName" value="김민선" /> <input
			type="hidden" name="sel_postcode" value="" /> <input type="hidden"
			name="sel_line1" value="" /> <input type="hidden" name="sel_line2"
			value="" /> <input type="hidden" name="sel_phone" value="" /> <input
			type="hidden" name="sel_cellphone" value="" /> <input type="hidden"
			name="sel_email" value="" />
		<div>
			<input type="hidden" name="CSRFToken"
				value="9e514b81-fe03-458e-9ec6-2f0271b04fc7" />
		</div>
	</form>
	<form id="defaultAddress" name="defaultAddress"
		action="/ko/checkout/ordersheet" method="post">
		<input type="hidden" name="sel_addressId" value="" /> <input
			type="hidden" name="sel_lastName" value="" /> <input type="hidden"
			name="sel_postcode" value="" /> <input type="hidden"
			name="sel_line1" value="" /> <input type="hidden" name="sel_line2"
			value="" /> <input type="hidden" name="sel_phone" value="" /> <input
			type="hidden" name="sel_cellphone" value="" /> <input type="hidden"
			name="sel_email" value="" />
		<div>
			<input type="hidden" name="CSRFToken"
				value="9e514b81-fe03-458e-9ec6-2f0271b04fc7" />
		</div>
	</form>
	<!-- bodyWrap -->
	<div id="bodyWrap">
		<h3 class="cnts_title">
			<span>배송&amp;결제정보 입력</span>
		</h3>

		<input type="hidden" id="chk_giftAmount" value="" /> <input
			type="hidden" id="chk_pointAmount" value="" />

		<form id="orderForm" action="/ko/checkout/ordersheet" method="post">
			<script language="javascript"
				src="https://stdpay.inicis.com/stdjs/INIStdPay.js"
				type="text/javascript" charset="UTF-8"></script>
			<input type="hidden" id="paytype" name="paytype" value="Inicis" /> <input
				type="hidden" id="globalPayment" name="globalPayment" value="" /><input
				type="hidden" name="ordererName" id="ordererName" value="" /> <input
				type="hidden" name="ordererMobilePhone" id="ordererMobilePhone"
				value="" /> <input type="hidden" name="ordererEmail"
				id="ordererEmail" value="" /> <input type="hidden" name="addressId"
				id="addressId" value="" /> <input type="hidden" name="email"
				id="email" value="" /> <input type="hidden" id="discInfo_coupon"
				name="couponCode" value="" /> <input type="hidden"
				id="customDutiesPaymentYN" name="customDutiesPaymentYN" value="0" />
			<input type="hidden" id="chinaYN" name="chinaYN" /> <input
				type="hidden" id="idCardOrPassport" name="idCardOrPassport" /> <input
				type="hidden" id="selectedCompany" name="selectedCompany" value="" />
			<input type="hidden" id="isPermanentCompany"
				name="isPermanentCompany" value="" /> <input type="hidden"
				name="wpayToken" value="" /> <input type="hidden" name="cardQuota"
				value="" /> <input type="hidden" name="cardInterest" value="" /> <input
				type="hidden" name="discInfo" value="" />

			<!--sub_container-->
			<div class="sub_container">
				<!--orderwrap-->
				<div class="orderwrap del_pay">
					<!--orderwrap left-->
					<div >
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

										<th scope="col">판매가/쿠폰 적용가</th>
									</tr>
								</thead>
								<tbody>
									<tr class="al_middle">
										<td class="frt" style ="height: 200px; ">
											<!-- pt_list_all -->
											<div class="pt_list_all" style ="width : 700px; height: 150px; padding:0px; ">
												<img style ="height: 150px; width: 150px;"  
													src="${colorVO.cimage2}"
													alt="" />
				
												<div class="tlt_wrap" style ="font-size: 20px; width: 500px;" >
													<a class="basket_tlt"> <span class="tlt" style ="font-size: 20px; margin-bottom:60px; padding-left:200px; height: 50px;" >${productVO.bname}</span> <span
														class="sb_tlt" style ="font-size: 20px; padding-left:200px; height: 40px; margin-top: 10px;" >${productVO.pname}</span>
			
													</a>
													<p class="color_op" style ="font-size: 20px; padding-left:200px; width: 300px;" >

														color : ${curColorCode} <span class="and_line" style ="font-size: 20px;" >/</span> size : ${size}
													</p>
												</div>
											</div> <!-- //pt_list_all -->
										</td>
										<td  style ="font-size: 20px;">${txtqty}</td>
										<td>
											<!-- price_wrap -->
											<div class="price_wrap ">
												<span  style ="font-size: 20px;"> ₩${productVO.pprice} * ${txtqty}</span>
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
										<th scope="row" class="th_space">주문자</th>
										<td>김민선</td>
									</tr>
									<tr>
										<th scope="row" class="th_space"><strong class="reqd">*</strong>휴대폰</th>
										<td>
											<!-- hp --> <select id="easy_hp" name="hp0_num1"
											title="휴대폰 번호 앞자리" class="hp_num1">
												<option value="010">010</option>
												<option value="011">011</option>
												<option value="016">016</option>
												<option value="017">017</option>
												<option value="018">018</option>
												<option value="019">019</option>
										</select>
											<div class="form_hyphen">-</div> <input title="휴대폰 번호 가운데자리"
											class="hp_num2" type="text" name="hp0_num2" id="easy_hp1"
											maxlength="4" numberOnly="true" />
											<div class="form_hyphen">-</div> <input title="휴대폰 번호 뒷자리"
											class="hp_num2" type="text" name="hp0_num3" id="easy_hp2"
											maxlength="4" numberOnly="true" /> <!-- //hp -->
										</td>
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
											class="reqd">*</strong> <label for="adress">배송지 주소</label> 
											</th>
										<td>
											<!-- address --> <input value="" title="우편번호" id="adress"
											name="postcode" class="post" type="text" placeholder="우편번호" />  <br />
											<div id="basis_bk_flag">
												<input value="" title="주소1" name="line1" id="line1"
													class="post_wall top" type="text" placeholder="주소를 입력해 주세요." />
											</div> <input value="" title="주소2" name="line2" id="line2"
											class="post_wall" type="text" maxlength="110"
											placeholder="나머지 주소를 입력해 주세요." /> <!-- //address -->
										</td>
									</tr>
									<tr>
										<th scope="row"><strong class="reqd">*</strong><label
											for="rcpt_name">수령인</label></th>
										<td><input value="" title="수령인" id="rcpt_name"
											name="lastName" maxlength="13" type="text"
											style="width: 118px;" /></td>
									</tr>
									<tr>
										<th scope="row"><strong class="reqd">*</strong><label
											for="hp">휴대폰 번호</label></th>
										<td>
											<!-- hp --> <select id="hp" name="hp_num1" title="휴대폰 번호 앞자리"
											class="hp_num1">
												<option value="010">010</option>
												<option value="011">011</option>
												<option value="016">016</option>
												<option value="017">017</option>
												<option value="018">018</option>
												<option value="019">019</option>
										</select>
											<div class="form_hyphen">-</div> <input title="휴대폰 번호 가운데자리"
											name="hp_num2" id="hp_num2" class="hp_num2" type="text"
											maxlength="4" numberOnly="true" />
											<div class="form_hyphen">-</div> <input title="휴대폰 번호 뒷자리"
											name="hp_num3" id="hp_num3" class="hp_num2" type="text"
											maxlength="4" numberOnly="true" /> <!-- //hp -->
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
							<table class="tbl_wtype1"  style =" margin-bottom : 20px;">
								<caption>최종 결제 금액</caption>
								<colgroup>
									<col style="width: 140px" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row" class="th_space">상품 합계</th>
										<td>상품 합계금액</td>
									</tr>
									<tr>
										<th scope="row" class="th_space">합계</th>
										<td>합계금액</td>
									</tr>

								</tbody>
							</table>
				
							<input type="hidden" name="total" id="total" value="651000.0" />
							<input type="hidden" name="cartDeliveryCost"
								id="cartDeliveryCost" value="0.0" />
						</div>
						<!--//final payment sum box-->
						<!--point & agreement box-->

						<span id="doOrderBtn"> <a href="#;" class="btn gray "
							onclick="doOrder();"> 결제하기</a>
						</span>
					</div>
					<!--//orderwrap right-->
				</div>
				<!--//orderwrap-->
			</div>
			<!--//sub_container-->

			<div>
				<input type="hidden" name="CSRFToken"
					value="9e514b81-fe03-458e-9ec6-2f0271b04fc7" />
			</div>
		</form>
		<!--layer pop-->
		<div class="popwrap w_type_3" id="popwrap" style="display: none">
			<!-- Title1 -->
			<div class="pop_tltwrap">
				<h3>배송지관리</h3>
			</div>
			<!-- //Title1 -->
			<div class="pop_cnt">
				<div class="tab_a m2" id="del_tab">
					<ul>
						<li><a href="#;" class="active">나의 배송지 목록</a></li>
						<li><a href="#;">최근 배송지 목록</a></li>
					</ul>
				</div>
				<div class="del_tab_container">
					<!-- tab 1 -->
					<div>
						<p class="com_txt mb20 ml10">
							고객님이 저장하신 배송지 목록입니다.<span class="com_txt_p">(마이페이지에서 등록 및
								수정 하실 수 있습니다.)</span>
						</p>
						<!-- table -->
						<div>
							<table class="pop_dtable my">
								<caption>배송지관리</caption>
								<thead>
									<tr>
										<th scope="col">선택</th>
										<th scope="col">수령인</th>
										<th scope="col">배송지 주소</th>
										<th scope="col">연락처/휴대폰</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<!-- //table -->
						<div class="btnwrap">
							<input class="btn wt_s" value="취소" type="button"
								onclick="$('.btn_close').click();" /> <input
								class="btn gray_s mr0" value="확인" type="button"
								onclick="javascript:selectAddress();" />
						</div>
					</div>
					<!--// tab 1 -->

					<!-- tab 2 -->
					<div>
						<p class="com_txt mb20 ml10">고객님께서 최근 주문 시 사용하셨던 10개의 배송지 목록
							입니다.</p>
						<!-- table -->
						<table class="pop_dtable lately">
							<caption>배송지관리</caption>
							<thead>
								<tr>
									<th scope="col">선택</th>
									<th scope="col">수령인</th>
									<th scope="col">배송지 주소</th>
									<th scope="col">연락처/휴대폰</th>
									<th scope="col">수정/삭제</th>
								</tr>
							</thead>
							<tbody id="shippingDeliveryAddressList">
							</tbody>
						</table>
						<!-- //table -->
						<div class="btnwrap">
							<input class="btn wt_s" value="취소" type="button"
								onclick="$('.btn_close').click();" /> <input
								class="btn gray_s mr0" value="배송지로 선택" type="button"
								onclick="javascript:selectDeliveryAddress();" />
						</div>
					</div>
					<!--// tab 2 -->

				</div>
			</div>
			<!-- btn_close -->
			<a href="#;" class="btn_close"> <img
				src="/_ui/desktop/common/images/popup/ico_close.png" alt="닫기" />
			</a>
			<!-- //btn_close -->
		</div>
		<!--//layer pop-->

		<!--layer pop : password -->
		<div class="popwrap w_type_4" id="popwrap2" style="display: none;">
			<!-- Title1 -->
			<div class="pop_tltwrap2">
				<h3>비밀번호 재확인</h3>
				<p class="txt">
					고객님의 소중한 한섬마일리지/기프트카드를 보호하기 위하여 비밀번호를 재확인합니다.<br /> 로그인 비밀번호를 입력해
					주시기 바랍니다.
				</p>
			</div>
			<!-- //Title1 -->
			<div class="pop_cnt ">
				<div class="tblwrap">
					<form id="userInfoForm" action="/ko/checkout/ordersheet"
						method="post">
						<input id="uid" name="uid" type="hidden"
							value="kms199606036@naver.com" /> <input id="gubun" name="gubun"
							type="hidden" value="" /> <input id="pnt" name="pnt"
							type="hidden" value="" />
						<table class="tbl_wtype1">
							<caption>제목입력</caption>
							<colgroup>
								<col style="width: 100px">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><label for="pw">비밀번호</label></th>
									<td><input id="pw" name="pw" type="password" value=""
										title="비밀번호 입력" style="width: 150px;"
										onkeydown="if(event.keyCode==13){this.blur();checkPassword();return false;}" />
										<span class="guide_comment" id="pwMsg"></span></td>
								</tr>
							</tbody>
						</table>
						<div>
							<input type="hidden" name="CSRFToken"
								value="9e514b81-fe03-458e-9ec6-2f0271b04fc7" />
						</div>
					</form>
				</div>
				<div class="btnwrap">
					<input type="button" class="btn wt_s" value="취소"
						onclick="$('.btn_close').click();" /> <input type="button"
						class="btn gray_s mr0" value="확인" onclick="checkPassword();" />
				</div>
			</div>
			<!-- btn_close -->
			<a href="#;" class="btn_close"><img
				src="/_ui/desktop/common/images/popup/ico_close.png" alt="닫기" /></a>
			<!-- //btn_close -->
		</div>
		<!--//layer pop-->


		<!--layer pop : h.point -->
		<div class="popwrap w_type_10" id="popwrap3" style="display: none;">
			<!-- Title1 -->
			<div class="pop_tltwrap2">
				<h3>휴대폰 인증</h3>
			</div>
			<!-- //Title1 -->
			<div class="pop_cnt">
				<form id="hpointForm" action="/ko/checkout/ordersheet" method="post">
					<input id="certNo" name="certNo" type="hidden" value="" />
					<fieldset>
						<legend>휴대폰인증</legend>
						<div class="phoneCerti">
							<p class="txt">
								H.Point 10만 포인트 이상 사용 시에는 <br /> 고객님의 휴대폰으로 인증이 필요합니다.<br />
								SMS 발송 후 3분 이내 인증번호 6자리를 입력해주시기 바랍니다.
							</p>
							<div class="btnArea">
								<p class="phoneNum"></p>
								<input type="button" class="btn add_s" value="인증번호발송"
									style="padding: 6px 13px 10px; margin: 0" id="startTimer"
									onclick="hpointAuthHandphone();" />
							</div>
							<div class="inputArea">
								<label for="codeInput">인증번호</label><input type="text"
									id="codeInput" />
								<p class="time">
									남은시간 <span id="counter">03:00초</span>
								</p>
							</div>
						</div>
						<div class="btnwrap">
							<input type="button" class="btn wt" value="취소"
								onclick="$('.btn_close').click();" id="stopTimer" /> <input
								type="button" class="btn gray" value="확인" id="stopTimer"
								onclick="checkHPassword();" />
						</div>
					</fieldset>
					<div>
						<input type="hidden" name="CSRFToken"
							value="9e514b81-fe03-458e-9ec6-2f0271b04fc7" />
					</div>
				</form>
			</div>
			<!-- btn_close -->
			<a href="#" class="btn_close"><img
				src="/_ui/desktop/common/images/popup/ico_close.png" alt="닫기"></a>
			<!-- //btn_close -->
		</div>
		<!--//layer pop-->
		<!--layer pop : 관세확인 -->
		<!--//layer pop-->


		<div id="payinfo">
			<form id="PAY_FORM" method="post"></form>
		</div>

	</div>
	<!-- //bodyWrap -->
	<div class="layerArea" id="productLayer" style="display: none;">
		<div class="layerBg"></div>
	</div>
	<!-- 200227 추가 -->
	<div class="popwrap deliy_pop0227" style="display: none;">
		<a href="#;" class="btn_close"><img
			src="/_ui/desktop/common/images/popup/ico_close.png" alt="닫기"></a>
		<h3>택배사를 선택해주세요</h3>
		<p>
			두 택배사의 배송비와 예상 배송일은 동일합니다.<br /> 평소 선호하시는 택배사를 선택해주세요.
		</p>
		<p class="m_deily_notice"
			style="margin-top: -16px; margin-bottom: 25px; color: #222222; font-style: normal; font-weight: normal;">
			THE STAR, STAR, MANIA 등급 대상 서비스입니다. (선택 사항)</p>
		<!-- deilvy_box -->
		<div class="deilvy_box">
			<!-- deilvy_con -->
			<div class="deilvy_con">
				<label class="check_style"> <input type="radio"
					name="deilvy_rdo" id="deilvy_rdo01" /> <span><img
						src="http://cdn.thehandsome.com/_ui/desktop/common/images/txt_deilvery_001_0227.jpg"
						alt=""></span>
					<p class="ab-impor">※ 토요일 출고 불가</p>
				</label>
			</div>
			<!-- // deilvy_con -->
			<!-- deilvy_con -->
			<div class="deilvy_con">
				<label class="check_style"> <input type="radio"
					name="deilvy_rdo" id="deilvy_rdo02" /> <span><img
						src="http://cdn.thehandsome.com/_ui/desktop/common/images/txt_deilvery_002_0227.jpg"
						alt=""></span>
					<p class="ab-impor">※ 토요일 출고 가능</p>
				</label>
			</div>
			<!-- // deilvy_con -->
		</div>
		<!-- // deilvy_box -->
		<p class="next_deil">
			<label> <input type="checkbox" name="next_chk" id="next_chk" />
				<span>지금 선택한 배송 방법을 다음에도 사용합니다.</span>
			</label>
		</p>
		<a class="confirm_btn" id="confirm_btn_selectComp" href="#a">확인</a>
	</div>
	<!-- // 200227 추가 -->
	<!-- 20220905 팝업 추가 -->
	<div class="layerArea" id="layerPinfoAgree"
		style="z-index: 10000; position: fixed; display: none;">
		<div class="layerBg"></div>
		<div class="popwrap pop_pinfo_agree">
			<!-- Title1 -->
			<div class="pop_tltwrap2">
				<h1
					style="padding-top: 15px; font-size: 19px; font-weight: 700; text-align: center;">개인정보
					제3자 제공 동의</h1>
			</div>
			<!-- //Title1 -->
			<div class="pop_cnt ">
				‘아워레가시’ 브랜드 정보 공유 및 마케팅 활용 목적으로 동의하신 고객님에 한하여 최소한의 개인정보가 제 3자에게
				제공됩니다. <br> 고객님께서는 개인정보 제 3자 제공에 대해 ‘동의’ 또는 ‘거부’를 선택할 수 있으며,
				선택에 관계없이 제품 구매가 가능합니다. <br> 개인정보 제공 관련 구체적인 내용은 아래와 같습니다.
				<ol class="">
					<li><strong>제공받는 자</strong> : 국내 소재 OUR LEGACY의 대리인<br>(한섬과
						OUR LEGACY 독점 계약 종료 시 사업을 이어받을 국내 신규 사업자)</li>
					<li><strong>제공 항목</strong> : 성명 및 이메일 주소</li>
					<li><strong>이용 목적</strong> : 마케팅 활용 및 브랜드 정보 공유</li>
					<li><strong>보유 및 이용기간</strong> : 회원탈퇴시 또는 동의 철회시까지</li>
				</ol>
				<div class="btnwrap">
					<input type="button" class="btn gray mr0" value="확인"
						onclick="$('.btn_close').click();">
				</div>
			</div>
			<!-- btn_close -->
			<a href="#;" class="btn_close"> <img
				src="/_ui/desktop/common/images/popup/ico_close.png" alt="닫기">
			</a>
			<!-- //btn_close -->
		</div>
	</div>




	<!-- footerWrap -->

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>