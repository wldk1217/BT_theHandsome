<!-- 김민선 생성 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<head>
<script src="/jquery-3.4.1.min.js"></script>
<body oncontextmenu='return false'>

		

    <form id="customerAddress" name="customerAddress" action="/ko/checkout/ordersheet" method="post"><input type="hidden" name="sel_lastName"
            value="김민선" />
        <input type="hidden" name="sel_postcode"
            value="" />
        <input type="hidden" name="sel_line1"
            value="" />
        <input type="hidden" name="sel_line2"
            value="" />
        <input type="hidden" name="sel_phone"
            value="" />
        <input type="hidden" name="sel_cellphone"
            value="" />
        <input type="hidden" name="sel_email"
            value="" />
        <div>
<input type="hidden" name="CSRFToken" value="9e514b81-fe03-458e-9ec6-2f0271b04fc7" />
</div></form><form id="defaultAddress" name="defaultAddress" action="/ko/checkout/ordersheet" method="post"><input type="hidden" name="sel_addressId"
            value="" />
        <input type="hidden" name="sel_lastName"
            value="" />
        <input type="hidden" name="sel_postcode"
            value="" />
        <input type="hidden" name="sel_line1"
            value="" />
        <input type="hidden" name="sel_line2"
            value="" />
        <input type="hidden" name="sel_phone"
            value="" />
        <input type="hidden" name="sel_cellphone"
            value="" />
        <input type="hidden" name="sel_email"
            value="" />
        <div>
<input type="hidden" name="CSRFToken" value="9e514b81-fe03-458e-9ec6-2f0271b04fc7" />
</div></form><!-- bodyWrap -->
    <div id="bodyWrap">
        <h3 class="cnts_title">
            <span>배송&amp;결제정보 입력</span>
        </h3>
        
<input type="hidden" id="chk_giftAmount" value="" />
        <input type="hidden" id="chk_pointAmount" value="" />
		
        <form id="orderForm" action="/ko/checkout/ordersheet" method="post"><script language="javascript" src="https://stdpay.inicis.com/stdjs/INIStdPay.js" type="text/javascript" charset="UTF-8"></script>	
           	<input type="hidden" id="paytype" name="paytype" value="Inicis" />
            <input type="hidden" id="globalPayment" name="globalPayment" value="" /><input type="hidden" name="ordererName" id="ordererName" value="" />
            <input type="hidden" name="ordererMobilePhone" id="ordererMobilePhone" value="" />
            <input type="hidden" name="ordererEmail" id="ordererEmail" value="" />
            <input type="hidden" name="addressId" id="addressId" value="" />
            <input type="hidden" name="email" id="email" value="" />
            <input type="hidden" id="discInfo_coupon" name="couponCode" value="" />
            <input type="hidden" id="customDutiesPaymentYN" name="customDutiesPaymentYN" value="0" />
            <input type="hidden" id="chinaYN" name="chinaYN" />
            <input type="hidden" id="idCardOrPassport" name="idCardOrPassport" />
            <input type="hidden" id="selectedCompany" name="selectedCompany" value="" />
            <input type="hidden" id="isPermanentCompany" name="isPermanentCompany" value = ""/>
        

            <input type="hidden" name="wpayToken" value="" />   
            <input type="hidden" name="cardQuota" value="" />   
            <input type="hidden" name="cardInterest" value="" />
            <input type="hidden" name="discInfo" value="" />
            
            <!--sub_container-->
            <div class="sub_container">
                <!--orderwrap-->
                <div class="orderwrap del_pay">
                    <!--orderwrap left-->
                    <div class="float_left">
                        <!--table wrap1-->
                        <div id="checkoutCartView" class="tblwrap">
                        	<table class="tbl_ltype ">
                            
                                <caption>
                                    배송&amp;결제정보 입력</caption>
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
                                            <td class="frt">
                                                <!-- pt_list_all -->
                                                <div class="pt_list_all">
                                                <a href="/ko/HANDSOME/WOMEN/DRESS/MINI-DRESS/%5BNANUSHKA%5D-%ED%81%AC%EB%A1%9C%EC%85%B0-%EB%93%9C%EB%A0%88%EC%8A%A4/p/MU2C1WDR207WN6_IV_S"> 
	                                                     <img src="http://newmedia.thehandsome.com/MU/2C/SS/MU2C1WDR207WN6_IV_S01.jpg" alt="" />
	                                                         </a>
                                                     <div class="tlt_wrap">
                                                        <a href="/ko/HANDSOME/WOMEN/DRESS/MINI-DRESS/%5BNANUSHKA%5D-%ED%81%AC%EB%A1%9C%EC%85%B0-%EB%93%9C%EB%A0%88%EC%8A%A4/p/MU2C1WDR207WN6_IV_S" class="basket_tlt"> 
			                                                        <span class="tlt">MUE</span>
			                                                        <span class="sb_tlt">[NANUSHKA] 크로셰 드레스</span>                                                            
																	</a>
			                                                        <p class="color_op">
			                                                                    
			                                                                        color : IVORY<span class="and_line">/</span>
			                                                                    
			                                                                    size : S</p>
			                                                            </div>
                                                    </div> <!-- //pt_list_all -->
                                            </td>
<td>1</td>
                                            <td>
                                                <!-- price_wrap -->
                                                <div class="price_wrap ">
                                                	<span>
		                                                                ₩651,000</span>
		                                                        </div> <!-- //price_wrap -->
                                            </td>
                                        </tr>
                                        </tbody>
                            </table>
<script>var checktHandsomepointUsableAmount = parseInt('0');</script>
</div>
                        <!--//table wrap1-->

                        <!--title_wrap & table wrap3-->
                        <div class="title_wrap clearfix mt40">
                                <h4 class="float_left">
                                    주문자 정보</h4>
                            </div>
                            <div class="tblwrap">
                                <table class="tbl_wtype1">
                                    <caption>
                                        주문자 정보</caption>
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
                                                    <div class="form_hyphen">-</div> <input
                                                    title="휴대폰 번호 가운데자리" class="hp_num2" type="text"
                                                    name="hp0_num2" id="easy_hp1" maxlength="4" numberOnly="true" />
                                                    <div class="form_hyphen">-</div> <input title="휴대폰 번호 뒷자리"
                                                    class="hp_num2" type="text" name="hp0_num3" id="easy_hp2"
                                                    maxlength="4" numberOnly="true" /> <!-- //hp -->
                                                </td>
                                        </tr>
                                        <tr>
                                            <th scope="row" class="th_space">E-mail</th>
                                            <td></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        <!--nonmember-->
                            <!--//nonmember-->

                            <!--//title_wrap & table wrap3-->
                            <!--title_wrap & table wrap4-->
                            <div class="title_wrap clearfix mt40" id="deliveryAddressDisplay">
                                <h4 class="float_left">
배송지 정보</h4>
                                <p class="reqd_txt none">
                                        <strong class="reqd">*</strong>
                                        표시는 필수항목입니다.</p>
                                    <div class="btn_wrap">
	                                        <a href="#;" class="btn wt_ss" onclick="f_customerAddress();">주문고객과 동일</a>
	                                            <a href="#;" class="btn wt_ss"
	                                                onclick="viewPopup('#popwrap');">배송지 선택</a>
	                                        <a href="#;" class="btn wt_ss mr0" onclick="resetAddress();">새로작성하기</a>
	                                    </div>
                                    </div>
                            
                            <div class="tblwrap" id="deliveryInfoTitle">
                                    <table class="tbl_wtype1">
                                        <caption>
                                            배송지 정보</caption>
                                        <colgroup>
                                            <col style="width: 140px" />
                                            <col />
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th scope="row" class="tooltip191022">
                                                    <strong class="reqd">*</strong>
                                                    <label for="adress">배송지 주소</label>
                                                    <span class="ico_question">icon</span>
                                                    <div class="delch_box190816">
                                                        <span class="arr">위치아이콘</span>
                                                        <ul class="bul_sty01_li">
                                                            <li>기본배송지 변경은 <strong>마이페이지> [배송지관리]</strong>에서 가능합니다.</li>
                                                            <li>기본배송지 설정 시 기본배송지가 최우선으로 노출 됩니다.</li>
                                                        </ul>
                                                    </div>
                                                </th>
                                                <td><!-- address --> 
                                                	<input value="" title="우편번호" id="adress" name="postcode" class="post" type="text" readonly />
                                                	<input value="우편번호 조회" id="addrSearchBtn" class="btn add_s" type="button" />
                                                	<br />
                                                    <div id="basis_bk_flag">
													    <input value="" title="주소1" name="line1" id="line1" class="post_wall top" type="text" readonly />
                                                    </div>
													<input value="" title="주소2" name="line2" id="line2" class="post_wall" type="text" maxlength="110" placeholder="나머지 주소를 입력해 주세요." /> <!-- //address -->
												</td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><strong class="reqd">*</strong><label
                                                    for="rcpt_name">수령인</label></th>
                                                <td><input value="" title="수령인" id="rcpt_name"
                                                    name="lastName" maxlength="13" type="text" style="width: 118px;" /></td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><strong class="reqd">*</strong><label
                                                    for="hp">휴대폰 번호</label></th>
                                                <td>
                                                    <!-- hp --> <select id="hp" name="hp_num1"
                                                    title="휴대폰 번호 앞자리" class="hp_num1">
                                                        <option value="010">010</option>
                                                        <option value="011">011</option>
                                                        <option value="016">016</option>
                                                        <option value="017">017</option>
                                                        <option value="018">018</option>
                                                        <option value="019">019</option>
                                                </select>
                                                    <div class="form_hyphen">-</div> <input
                                                    title="휴대폰 번호 가운데자리" name="hp_num2" id="hp_num2"
                                                    class="hp_num2" type="text" maxlength="4" numberOnly="true" />
                                                    <div class="form_hyphen">-</div> <input title="휴대폰 번호 뒷자리"
                                                    name="hp_num3" id="hp_num3" class="hp_num2" type="text"
                                                    maxlength="4" numberOnly="true" /> <!-- //hp -->
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row" class="th_space"><label for="ph">연락처</label></th>
                                                <td>
                                                    <!-- phone --> <select name="ph_num1" id="ph"
                                                    title="연락처 앞자리" class="hp_num1">
                                                        <option value="">선택</option>
                                                        <option value="02">02</option>
                                                        <option value="031">031</option>
                                                        <option value="032">032</option>
                                                        <option value="033">033</option>
                                                        <option value="041">041</option>
                                                        <option value="042">042</option>
                                                        <option value="043">043</option>
                                                        <option value="044">044</option>
                                                        <option value="051">051</option>
                                                        <option value="052">052</option>
                                                        <option value="053">053</option>
                                                        <option value="054">054</option>
                                                        <option value="055">055</option>
                                                        <option value="061">061</option>
                                                        <option value="062">062</option>
                                                        <option value="063">063</option>
                                                        <option value="064">064</option>
                                                </select>
                                                    <div class="form_hyphen">-</div> <input title="연락처 가운데자리"
                                                    name="ph_num2" id="ph_num2" class="hp_num2" type="text" maxlength="4"
                                                    numberOnly="true" />
                                                    <div class="form_hyphen">-</div> <input title="연락처 뒷자리"
                                                    name="ph_num3" id="ph_num3" class="hp_num2" type="text" maxlength="4"
                                                    numberOnly="true" /> <!-- //phone -->
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row" class="th_space"><label for="orderr">배송 메세지</label></th>
                                                <td>
                                                    <div class="input_sumtxt">
                                                        <div class="input_sumtxt_box">
                                                            <!-- input -->
                                                            <input onkeyup="chkword('orderr','orderr_text_length',20);" id="orderr" name="deliveryRequestContents" autocomplete="off" type="text" value="" title="배송 메세지" maxlength="20" />
                                                            <!-- //input -->
                                                            <div class="delivery_comt">
                                                                <ul>
                                                                	<li >
                                                                			<a href="#;" data-readonly="readonly" deliveryRequestMessage="배송 전 연락 바랍니다">
                                                                				배송 전 연락 바랍니다</a>
                                                                		</li>
                                                                	<li >
                                                                			<a href="#;" data-readonly="readonly" deliveryRequestMessage="부재 시 문 앞에 놓아주세요">
                                                                				부재 시 문 앞에 놓아주세요</a>
                                                                		</li>
                                                                	<li >
                                                                			<a href="#;" data-readonly="readonly" deliveryRequestMessage="부재 시 경비실에 맡겨주세요">
                                                                				부재 시 경비실에 맡겨주세요</a>
                                                                		</li>
                                                                	<li >
                                                                			<a href="#;" data-readonly="readonly" deliveryRequestMessage="빠른 배송 부탁드립니다">
                                                                				빠른 배송 부탁드립니다</a>
                                                                		</li>
                                                                	<li >
                                                                			<a href="#;" data-readonly="readonly" deliveryRequestMessage="부재 시 핸드폰으로 연락바랍니다">
                                                                				부재 시 핸드폰으로 연락바랍니다</a>
                                                                		</li>
                                                                	<li >
                                                                			<a href="#;" data-readonly="write" deliveryRequestMessage="직접입력">
                                                                				직접입력</a>
                                                                		</li>
                                                                	</ul>
                                                            </div>
                                                        </div>
                                                        <div>
                                                            <span id="orderr_text_length">0</span> <span>/20자</span>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <!-- 211028 공동현관 출입방법 S -->
											<tr class="enter-door211026">
					
												<th scope="row" class="tooltip191022 th_space tooltip211026-">
													<label for="enter_door" class="">공동현관<br/>출입방법</label><span class="ico_question">icon</span>
													<div class="delch_box190816 ">
														<span class="arr">위치아이콘</span>
														<ul class="bul_sty01_li">
															<li>공동현관 출입번호가 정확하지 않을 경우, 배송 기사의 판단에 따라 1층 공동현관 앞 또는 경비실에 배송될 수 있습니다.</li>
															<li>새벽배송 시 배송 전 연락을 드리지 않습니다.</li>
														</ul>
													</div>
												</th>
												<td>
													<div class="input_sumtxt">
														<div class="input_sumtxt_box input_sumtxt_box2">
															<!-- 211028 공동현관 출입방법 S -->
															<input name="frontDoorSelectMessage" id="enter_door" type="text" autocomplete="off" value="공동현관 출입방법을 선택해주세요" title="공동현관 출입방법" readonly/>
															<!-- 211028 공동현관 출입방법 E -->
															<div class="delivery_comt delivery_comt2">
																<ul>
																	<li>
																		</li>
																	<li><a href="#;" data-default="공동현관 출입번호" data-input-display="block">공동현관 출입번호</a></li>
																	<li><a href="#;" data-default="자유 출입 가능" data-input-display="none">자유 출입 가능</a></li>
																	<li><a href="#;" data-default="기타" data-input-display="block">기타</a></li>
																</ul>
															</div>
														</div>
													</div>
													<div class="input_sumtxt enter_front">
														<input onkeyup="chkword('frontDoorMessage','front_door_text_length',15);" id="frontDoorMessage" name="frontDoorMessage" type="text" placeholder="15자 이내로 입력하세요" title="출입방법 예시" maxlength="15" />
														<div>
															<span id="front_door_text_length">0</span>
															<span>/15자</span>
														</div>
													</div>
												</td>
											</tr>
											<!-- 211028 공동현관 출입방법 E -->  
                                            <tr>
                                                <th scope="row" class="th_space"><label for="mail">수령인 E-mail</label></th>
                                                <td>
                                                    <!-- email --> <input type="text" id="mail" name="mail"
                                                    title="이메일 아이디" class="em_form" /> <span class="andmail">@</span>
                                                    <input type="text" value="" name="emailDely" id="emailDely"
                                                    title="직접입력" class="em_form" /> <select title="이메일 계정"
                                                    id="emailDelySel" class="em_select">
                                                        <option value="">직접입력</option>
                                                        <option value="naver.com">naver.com</option>
                                                        <option value="gmail.com">gmail.com</option>
                                                        <option value="daum.net">daum.net</option>
                                                        <option value="nate.com">nate.com</option>
                                                        <option value="hanmail.net">hanmail.net</option>
                                                        <option value="yahoo.com">yahoo.com</option>
                                                        <option value="dreamwiz.com">dreamwiz.com</option>
                                                </select> <!-- //email -->
                                                </td>
                                            </tr>
                                            </tbody>
                                    </table>
                                    <ul class="bul_sty01_li">
									    <li>선택사항을 미입력하더라도 불이익은 발생하지 않습니다.</li>
									</ul>
                                </div>
                            <!--//title_wrap & table wrap4-->
                             <!--title_wrap & table wrap2-->
                        <div class="title_wrap  mt40">
                                <h4 class="float_left">
                                    쿠폰 및 혜택 적용</h4>
                                <p class="guide_comment">
                                    쿠폰을 적용하셔야 할인 혜택이 가능합니다.</p>
                            </div>
                            
                                <div class="tblwrap">
		                        <table class="tbl_wtype1">
		                            <colgroup>
		                                <col style="width:140px">
		                                <col>
		                            </colgroup>
		                            <tbody>
		                                <tr>
		                                    <th scope="row" class="th_space">쿠폰 및 혜택<br>선택</th>
		                                    <td>
	                                            <div class="vvip_td_wrap" id="select_voucher">
	                                                 <div class="coupon_select_wrap" style="margin-top:15px">
	                                                     <input name="voucherCode" id="voucherCode" value="" title="쿠폰코드 직접입력" placeholder="쿠폰코드 직접입력" type="text" class="input" />
	                                                     <p>또는</p>
	                                                     <select title="쿠폰을 선택해 주세요." id="selectVoucher" style="width: 190px;">
					                                        <option value="">사용 가능한 쿠폰이 없습니다.</option>
					                                        </select>
	                                                    <div class="btnwrap">
					                                        <a href="#;" id="btnRedeemVoucher" class="btn add_s min_auto" onclick="redeemVoucher(this);">
					                                            적용</a>
					                                        <a href="#;" style="display:none" id="btnReleaseVoucher" class="btn dis_s min_auto" onclick="releaseVoucher(this);">
					                                            적용취소</a>
					                                    </div>
	                                                 </div>
	                                                 </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                           </div>
                             <!-- H.Point START ------------------------------------------------>
                             <!-- H.Point END -------------------------------------------->
                            
                        <!--//title_wrap & table wrap2-->
                            <!--title_wrap & table wrap5-->
                            <div class="title_wrap clearfix mt40">
                                <h4 class="float_left">결제 수단 선택</h4>
                            </div>
                            <div class="tblwrap">
                                <table class="tbl_wtype1">
                                    <caption>결제 수단 선택</caption>
                                    <colgroup>
                                        <col style="width: 140px" />
                                        <col />
                                    </colgroup>
                                    <tbody>
<!-- H.Point Start NOT ANY **********************************-->
                                            <!-- H.Point End ********************************************-->
                                           <tr>
                                            <th scope="row" class="th_space">결제수단 선택</th>
                                            <td>
                                                <div class="rd_wrap payment_way1907">
                                                    <ul>
	                                                    <li>
		                                                    <input type="radio" name="mode" id="sel_rd0" checked="checked" value="KO001-3" onclick="showCkout(this);" /> 
		                                                    <label for="sel_rd0" class="mr20 one_click_pay">원클릭결제</label>
		                                                    </li>
	                                                    <li>
	                                                    <input type="radio" name="mode" id="sel_rd1" value="KO001" 
	                                                            
	                                                           onclick="showCkout(this);" />
	                                                    <label for="sel_rd1" class="mr20">신용카드</label>
	                                                    </li>
	                                                    <li>
	                                                    <input type="radio" name="mode" id="sel_rd2" value="KO002" onclick="showCkout(this);" /> 
	                                                    <label for="sel_rd2" class="mr20">실시간 계좌이체</label> 
	                                                    </li>
	                                                   	<!-- #2610 [주문] 가상계좌 결제수단 제외 및 중복 구매 제한 처리 요청 건 (가상계좌 선택 삭제) 51013 -->
	                                                    <span id="paymentSmilePay" >
	                                                        <li>
															<input type="radio" name="mode" id="sel_rd5" value="KO006" onclick="showCkout(this);" /> 
		                                                    <label for="sel_rd5" class="mr20">스마일 페이</label><br/>
		                                                    </li>
	                                                    </span>
	                                                    <span id="paymentRedVoucher" style="display: block;">
		                                                        <li>
																<input type="radio" name="mode" id="sel_rd4" value="KO001-4" onclick="showCkout(this);" /> 
			                                                    <label for="sel_rd4" class="mr20">현대카드 레드 쇼핑바우처</label>
			                                                    </li>
		                                                    </span>
	                                                    <li>
	                                                        <input type="radio" name="mode" id="sel_rd6" value="KO007" onclick="showCkout(this);" />
	                                                        <label for="sel_rd6" class="mr20">토스</label>
	                                                    </li>
	                                                    <li>
	                                                        <input type="radio" name="mode" id="sel_rd7" value="KO008" onclick="showCkout(this);" />
	                                                        <label for="sel_rd7" class="mr20">페이코</label>
	                                                    </li>
                                                    </ul>
                                                </div> <!-- ckout_wrap -->
                                                
                                                <div class="ckout_wrap" id="ckout_wrap0" style="display: none;">
                                                <div class="oclk_card_list_wrap" id="oclk_card_list_wrap">
													    <div class="card_easy_pay_wrap swiper-container swiper_card_easy_pay swiper-container-horizontal" id="card_easy_pay"></div>
													    <a href="#;" class="prev_oclk_slide_btn oclks_btn1905">이전</a>
													    <a href="#;" class="next_oclk_slide_btn oclks_btn1905">다음</a>
													</div>
						                        
						                        </div>
                                                
                                                <div class="ckout_wrap" id="ckout_wrap" style="display: none;">
                                                    <p>※ 한섬마일리지/기프트카드와 가상계좌 함께 사용 시, 입금시점에 한섬마일리지/기프트카드의 결제 잔액이
                                                        있어야 주문이 완료됩니다.</p>
                                                    <p id="virtualText">※ <font color="red">4시간 이내 입금</font> 하셔야 주문이 완료 됩니다.</p>
													<div class="escrow_wrap">
	                                                    <p class="escrowservice">
	                                                        <strong>에스크로 서비스</strong>
	                                                    </p>
	                                                    <input type="radio" name="escrowYn" id="ipt_escrow_01" value="N" checked />
	                                                    <label for="ipt_escrow_01" class="mr20">아니요</label>
	                                                    <input type="radio" name="escrowYn" id="ipt_escrow_02" value="Y"/>
	                                                    <label for="ipt_escrow_02">예</label>
	                                                    <p class="escrowservice_txt">정부방침에 따라 실시간계좌이체 및 무통장입금, 가상계좌로 주문하시는 경우 에스크로 서비스 이용여부를 선택할 수 있습니다.</p>
													</div>
                                                    <a href="#;" onclick="escrowPopup();" class="btn add_s">매매보호서비스 가입사실확인</a>
                                                </div> <!-- //ckout_wrap -->
                                                
												<div class="hyundaiRed ckout_wrap" id="NEWckout_wrap2" style="display: none;">
												    <p>NOTICE</p>
													<ul>
														<li>
															• 현대카드 the Red Edition 2/4/5로 30만원 이상 결제 시, 쇼핑바우처 10만원권 사용 가능합니다.
														</li>
														<li>
															• 현대카드 the Red Edition 3 으로 50만원 이상 결제 시, 쇼핑바우처 15만원권 사용 가능합니다.
														</li>
														<li>
															• 레드카드 쇼핑바우처는 부분 사용 불가하며 카드대금 결제일에 일괄 청구할인 됩니다.
														</li>
														<li>
															• 예약 판매 상품은 레드카드 쇼핑바우처 사용 불가합니다.
														</li>
														<li>
															• 레드카드 쇼핑바우처를 사용한 구매는 부분취소/부분반품 불가 하오니 단품 주문을 권장합니다.
														</li>
														<li>
															• 취소 시 전체취소 후 재결제 필요 하며, 교환/취소 관련 문의는 고객센터 1:1 문의를 이용해 주세요.
														</li>
													</ul>
												</div>
												<div class="hyundaiRed ckout_wrap" id="ckout_wrap2" style="display: none;">
												    <p>NOTICE</p>
													<ul>
														<li>
															• 최종 결제금액 30만원 이상일 시, 현대카드 the Red Edition2로 결제 및<br />
															쇼핑바우처 10만원권 사용 가능합니다.
														</li>
														<li>
															• 레드카드 쇼핑바우처 10만원권은 부분 사용 불가하며 카드 대금 결제일에<br />
															10만원 일괄 <span>청구할인</span> 됩니다.
														</li>
														<li>
															• 예약 판매 상품은 레드카드 쇼핑바우처 사용 불가합니다.
														</li>
														<li>
															• 레드카드 쇼핑바우처를 사용한 구매는 <span>부분취소/부분반품 불가</span>하오니<br />
															단품 주문을 권장합니다.
														</li>
														<li>
															• 취소 시 <span>전체취소 후 재결제 필요</span>하며, 교환/취소 관련 문의는<br />
															고객센터 1:1문의를 이용해 주세요.
														</li>
													</ul>
												</div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!--//title_wrap & table wrap5-->
                            
                            <div class="title_wrap mt40">
								<h4>배송 포장 옵션</h4>
							</div>
							<div class="pack_opt_wrap wd">
								<img src="/_ui/desktop/common/images/shoppingbag.jpg" alt="한섬 쇼핑백">
								<div>
									<input type="checkbox" name="pack_option" id="packopt">
									<label for="pack_option" onclick="$('#packopt').click();" class="check_box">더한섬닷컴 친환경 쇼핑백(무료)</label>
									<p>
                                    · 선물용이나 이동 시 사용할 수 있는, 재활용이 가능한 친환경 쇼핑백을 드립니다.<br>
                                    · 더한섬닷컴 전용 친환경 쇼핑백만 발송되며, 브랜드 쇼핑백은 발송이 어렵습니다.<br>
                                    </p>
								</div>
							</div>
                            <!--card event tab-->
                            <div class="tab_a m3 mt40" id="ce_tab">
                                <ul>
                                    <li><a href="#;">무이자 할부</a></li>
                                    <li><a href="#;"><!-- <strong style="color:#c69c6c">NEW</strong>  -->청구할인</a></li>
                                    <li><a href="#;">즉시할인</a></li>
                                </ul>
                            </div>
                            <!--//card event tab-->
                            <!--card event tab container-->
                            <div class="ce_tab_container mt40">
                                <!--tab contents 1-->
                                <div>
                                    <div class="title_wrap">
                                        <h5>무이자 할부 행사</h5>
                                    </div>
                                    <!--Table wrap-->
                                    <table class="cnt_type1">
                                        <caption>무이자 할부 행사</caption>
                                        <colgroup>
                                            <col style="width: 155px" />
                                            <col style="width: 270px" />
                                            <col />
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                            <th scope="row"><span class="card"><img
                                                                    src="/medias/shinhan.jpg?context=bWFzdGVyfHJvb3R8MjY1N3xpbWFnZS9qcGVnfGhkZS9oMmIvODgxNDE4MTUxNTI5NC5qcGd8NTAwMDYxM2ZmZmRlZGFhZDQ0ODNmODJjZTg2OTE3MGI3OWQ2ZmE3YzI0ZjA3MDY3NzIxYWVhNmY3NDQyYWUzMA"
                                                                    alt="신한카드" /></span></th>
                                                            <td><b>신한카드 5만원이상 결제시 2~6개월 무이자 할부</b><br />
대상: 신한카드 전 회원<br />
(신한BC 제외/ 법인,기프트,체크,선불카드 제외)</td>
                                                            <td>행사기간 : 2022.10.01
                                                                ~ 2022.10.31</td>
                                                        </tr>
                                                    <tr>
                                                            <th scope="row"><span class="card"><img
                                                                    src="/medias/SAMSUNG.jpg?context=bWFzdGVyfHJvb3R8MzIxOXxpbWFnZS9qcGVnfGgzZC9oNGQvODgxNDE4MTYxMzU5OC5qcGd8ZGY1NDJiM2U1YWNmNGE5MTJkOTA0MTAxMDliMDc4ZjRlNTJmZjJlOTkxOTQzZTEwMDcxZWU2NGU2MjJmMWE2Mw"
                                                                    alt="삼성카드" /></span></th>
                                                            <td><b>삼성카드 5만원이상 결제시 2~6개월 무이자 할부</b><br />
대상: 삼성카드 전 회원<br />
(법인,기프트,체크,선불카드 제외)</td>
                                                            <td>행사기간 : 2022.10.01
                                                                ~ 2022.10.31</td>
                                                        </tr>
                                                    <tr>
                                                            <th scope="row"><span class="card"><img
                                                                    src="/medias/BC.jpg?context=bWFzdGVyfHJvb3R8MjQ1OHxpbWFnZS9qcGVnfGhmMi9oMGQvODgxNDE4MTIyMDM4Mi5qcGd8MjZlZGU2ZGQyNDBkYzU5YmY2NWY0MDU3NDc1OTA0YWI5NmM4NDJjMDFiYjBiYjBjY2FhZjhmMzg3ZmE5NGU5Yw"
                                                                    alt="비씨카드" /></span></th>
                                                            <td><b>비씨카드 5만원이상 결제시 2~7개월 무이자 할부</b><br /> 
대상: 비씨카드 전 회원<br />(법인,기프트,체크,선불카드 제외)</td>
                                                            <td>행사기간 : 2022.10.01
                                                                ~ 2022.10.31</td>
                                                        </tr>
                                                    <tr>
                                                            <th scope="row"><span class="card"><img
                                                                    src="/medias/HYUNDAI.jpg?context=bWFzdGVyfHJvb3R8MjYxMHxpbWFnZS9qcGVnfGg1ZC9oN2MvODgxNDE4MTcxMTkwMi5qcGd8YmM5ZWY0ZjlhODlkMzdmMjYyNmY4NjQ4OWU5NWVjOWFlMGY4ODIwYzZlNjA0MjBlNDkwNWI0ZDllYThjMWE5Mw"
                                                                    alt="현대카드" /></span></th>
                                                            <td><b>현대카드 5만원이상 결제시 2~7개월 무이자 할부</b><br />
대상: 현대카드 전 회원<br />
(법인,기프트,체크,선불카드 제외)</td>
                                                            <td>행사기간 : 2022.10.01
                                                                ~ 2022.10.31</td>
                                                        </tr>
                                                    <tr>
                                                            <th scope="row"><span class="card"><img
                                                                    src="/medias/kucmin.jpg?context=bWFzdGVyfHJvb3R8MzMwM3xpbWFnZS9qcGVnfGgyZS9oMzQvODgxNDE4MTAyMzc3NC5qcGd8MjM1YjEyN2I4OTljMGIxYzY3MjhjNDhkZWMyOTE5ODZjYmRiYWExNDdhOWZmNDQ3ZWNhNGIxZjYwYzk2MDA4Zg"
                                                                    alt="국민카드" /></span></th>
                                                            <td><b>KB국민카드 5만원이상 결제시 2~7개월 무이자 할부</b><br />
대상: KB국민카드 전 회원<br />
(NH농협, 국민BC 제외/ 법인,기프트,체크,선불카드 제외)</td>
                                                            <td>행사기간 : 2022.10.01
                                                                ~ 2022.10.31</td>
                                                        </tr>
                                                    <tr>
                                                            <th scope="row"><span class="card"><img
                                                                    src="/medias/hanacard.gif?context=bWFzdGVyfHJvb3R8MTkzNXxpbWFnZS9naWZ8aDYwL2hmYi84ODE0MDU0OTY1Mjc4LmdpZnxhMGM5OWY0MDdhNDhjYzkwOTdiMzhkM2VmMDQ2YTI0NTAyNDBjZTljNTdiYzk4YWRhZmI0NjBhOWRhNzRiMGYw"
                                                                    alt="하나카드" /></span></th>
                                                            <td><b>하나카드 5만원이상 결제시 2~8개월 무이자 할부</b><br />
대상: 하나카드 전 회원 (구 하나SK, 구 외환)<br />
(하나BC카드 포함/법인,기프트,체크,선불카드 제외)</td>
                                                            <td>행사기간 : 2022.10.01
                                                                ~ 2022.10.31</td>
                                                        </tr>
                                                    <tr>
                                                            <th scope="row"><span class="card"><img
                                                                    src="/medias/NH.jpg?context=bWFzdGVyfHJvb3R8Mzk3OXxpbWFnZS9qcGVnfGg4ZS9oMzYvODgxNDE4MTkwODUxMC5qcGd8ZWVlNmY1OWM0NDdmMjg2M2Y4NGZkNDZjYThmOTVkMWNmY2QwYWNkOWI1ODc5YTdiMTc5MjY4MThiZTkzYzNmMw"
                                                                    alt="NH카드" /></span></th>
                                                            <td><b>NH농협카드 5만원이상 결제시 2~8개월 무이자 할부</b><br />
대상: NH농협카드 전 회원<br />
(NH농협BC카드 포함/ 법인,기프트,체크,선불카드 제외)
</td>
                                                            <td>행사기간 : 2022.10.01
                                                                ~ 2022.10.31</td>
                                                        </tr>
                                                    <tr>
                                                            <th scope="row"><span class="card"><img
                                                                    src="/medias/LOTTE.jpg?context=bWFzdGVyfHJvb3R8MzI3MXxpbWFnZS9qcGVnfGhiMy9oNDcvODgxNDE4MTgxMDIwNi5qcGd8MDliOThkNzA1ZDc2ZDE4MzZhYmUzYjI2MDMxZDk0NGU3OTVjYzBhYTA1MmMzMjAyZmE0Y2U4OTZlNTU3NDU2Zg"
                                                                    alt="롯데카드" /></span></th>
                                                            <td><b>롯데카드 5만원이상 결제시 2~4개월 무이자 할부</b><br />
대상:롯데카드 전 회원<br />
(법인,기프트,체크,선불카드 제외)</td>
                                                            <td>행사기간 : 2022.10.01
                                                                ~ 2022.10.31</td>
                                                        </tr>
                                                    </tbody>
                                    </table>
                                    <!--//Table wrap-->
                                    <div class="title_wrap mt40">
                                        <h5>부분 무이자 할부 행사</h5>
                                    </div>
                                    <!--Table wrap-->
                                    <table class="cnt_type1">
                                        <caption>부분 무이자 할부 행사</caption>
                                        <colgroup>
                                            <col style="width: 155px" />
                                            <col style="width: 270px" />
                                            <col />
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                            <th scope="row"><span class="card"><img
                                                                    src="/medias/shinhan.jpg?context=bWFzdGVyfHJvb3R8MjY1N3xpbWFnZS9qcGVnfGhkZS9oMmIvODgxNDE4MTUxNTI5NC5qcGd8NTAwMDYxM2ZmZmRlZGFhZDQ0ODNmODJjZTg2OTE3MGI3OWQ2ZmE3YzI0ZjA3MDY3NzIxYWVhNmY3NDQyYWUzMA"
                                                                    alt="신한카드" /></span></th>
                                                            <td><b>10개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3,4회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)</td>
                                                            <td>행사기간 : 2022.10.01
                                                                ~ 2022.10.31</td>
                                                        </tr>
                                                    <tr>
                                                            <th scope="row"><span class="card"><img
                                                                    src="/medias/SAMSUNG.jpg?context=bWFzdGVyfHJvb3R8MzIxOXxpbWFnZS9qcGVnfGgzZC9oNGQvODgxNDE4MTYxMzU5OC5qcGd8ZGY1NDJiM2U1YWNmNGE5MTJkOTA0MTAxMDliMDc4ZjRlNTJmZjJlOTkxOTQzZTEwMDcxZWU2NGU2MjJmMWE2Mw"
                                                                    alt="삼성카드" /></span></th>
                                                            <td><b>10개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3,4회차 고객 부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)</b></td>
                                                            <td>행사기간 : 2022.10.01
                                                                ~ 2022.10.31</td>
                                                        </tr>
                                                    <tr>
                                                            <th scope="row"><span class="card"><img
                                                                    src="/medias/SAMSUNG.jpg?context=bWFzdGVyfHJvb3R8MzIxOXxpbWFnZS9qcGVnfGgzZC9oNGQvODgxNDE4MTYxMzU5OC5qcGd8ZGY1NDJiM2U1YWNmNGE5MTJkOTA0MTAxMDliMDc4ZjRlNTJmZjJlOTkxOTQzZTEwMDcxZWU2NGU2MjJmMWE2Mw"
                                                                    alt="삼성카드" /></span></th>
                                                            <td><b>12개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3,4,5회차 고객 부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)</b>
</td>
                                                            <td>행사기간 : 2022.10.01
                                                                ~ 2022.10.31</td>
                                                        </tr>
                                                    <tr>
                                                            <th scope="row"><span class="card"><img
                                                                    src="/medias/BC.jpg?context=bWFzdGVyfHJvb3R8MjQ1OHxpbWFnZS9qcGVnfGhmMi9oMGQvODgxNDE4MTIyMDM4Mi5qcGd8MjZlZGU2ZGQyNDBkYzU5YmY2NWY0MDU3NDc1OTA0YWI5NmM4NDJjMDFiYjBiYjBjY2FhZjhmMzg3ZmE5NGU5Yw"
                                                                    alt="비씨카드" /></span></th>
                                                            <td><b> 우리BC 10개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)
</td>
                                                            <td>행사기간 : 2022.10.01
                                                                ~ 2022.10.31</td>
                                                        </tr>
                                                    <tr>
                                                            <th scope="row"><span class="card"><img
                                                                    src="/medias/BC.jpg?context=bWFzdGVyfHJvb3R8MjQ1OHxpbWFnZS9qcGVnfGhmMi9oMGQvODgxNDE4MTIyMDM4Mi5qcGd8MjZlZGU2ZGQyNDBkYzU5YmY2NWY0MDU3NDc1OTA0YWI5NmM4NDJjMDFiYjBiYjBjY2FhZjhmMzg3ZmE5NGU5Yw"
                                                                    alt="비씨카드" /></span></th>
                                                            <td><b>우리BC 12개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3,4회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)
</td>
                                                            <td>행사기간 : 2022.10.01
                                                                ~ 2022.10.31</td>
                                                        </tr>
                                                    <tr>
                                                            <th scope="row"><span class="card"><img
                                                                    src="/medias/kucmin.jpg?context=bWFzdGVyfHJvb3R8MzMwM3xpbWFnZS9qcGVnfGgyZS9oMzQvODgxNDE4MTAyMzc3NC5qcGd8MjM1YjEyN2I4OTljMGIxYzY3MjhjNDhkZWMyOTE5ODZjYmRiYWExNDdhOWZmNDQ3ZWNhNGIxZjYwYzk2MDA4Zg"
                                                                    alt="국민카드" /></span></th>
                                                            <td><b>10개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3,4 회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)</td>
                                                            <td>행사기간 : 2022.10.01
                                                                ~ 2022.10.31</td>
                                                        </tr>
                                                    <tr>
                                                            <th scope="row"><span class="card"><img
                                                                    src="/medias/kucmin.jpg?context=bWFzdGVyfHJvb3R8MzMwM3xpbWFnZS9qcGVnfGgyZS9oMzQvODgxNDE4MTAyMzc3NC5qcGd8MjM1YjEyN2I4OTljMGIxYzY3MjhjNDhkZWMyOTE5ODZjYmRiYWExNDdhOWZmNDQ3ZWNhNGIxZjYwYzk2MDA4Zg"
                                                                    alt="국민카드" /></span></th>
                                                            <td><b>12개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3,4,5 회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)</td>
                                                            <td>행사기간 : 2022.10.01
                                                                ~ 2022.10.31</td>
                                                        </tr>
                                                    <tr>
                                                            <th scope="row"><span class="card"><img
                                                                    src="/medias/hanacard.gif?context=bWFzdGVyfHJvb3R8MTkzNXxpbWFnZS9naWZ8aDYwL2hmYi84ODE0MDU0OTY1Mjc4LmdpZnxhMGM5OWY0MDdhNDhjYzkwOTdiMzhkM2VmMDQ2YTI0NTAyNDBjZTljNTdiYzk4YWRhZmI0NjBhOWRhNzRiMGYw"
                                                                    alt="하나카드" /></span></th>
                                                            <td><b>10개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)</td>
                                                            <td>행사기간 : 2022.10.01
                                                                ~ 2022.10.31</td>
                                                        </tr>
                                                    <tr>
                                                            <th scope="row"><span class="card"><img
                                                                    src="/medias/hanacard.gif?context=bWFzdGVyfHJvb3R8MTkzNXxpbWFnZS9naWZ8aDYwL2hmYi84ODE0MDU0OTY1Mjc4LmdpZnxhMGM5OWY0MDdhNDhjYzkwOTdiMzhkM2VmMDQ2YTI0NTAyNDBjZTljNTdiYzk4YWRhZmI0NjBhOWRhNzRiMGYw"
                                                                    alt="하나카드" /></span></th>
                                                            <td><b>12개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3,4회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)</td>
                                                            <td>행사기간 : 2022.10.01
                                                                ~ 2022.10.31</td>
                                                        </tr>
                                                    <tr>
                                                            <th scope="row"><span class="card"><img
                                                                    src="/medias/shinhan.jpg?context=bWFzdGVyfHJvb3R8MjY1N3xpbWFnZS9qcGVnfGhkZS9oMmIvODgxNDE4MTUxNTI5NC5qcGd8NTAwMDYxM2ZmZmRlZGFhZDQ0ODNmODJjZTg2OTE3MGI3OWQ2ZmE3YzI0ZjA3MDY3NzIxYWVhNmY3NDQyYWUzMA"
                                                                    alt="신한카드" /></span></th>
                                                            <td><b>12개월 부분무이자</b><br />
(5만원이상 결제시/1,2,3,4,5회차 고객부담, 잔여할부 수수료 면제/법인,체크,기프트카드 제외)</td>
                                                            <td>행사기간 : 2022.10.01
                                                                ~ 2022.10.31</td>
                                                        </tr>
                                                    </tbody>
                                    </table>
                                    <!--//Table wrap-->
                                    <ul class="bul_sty01_li mt40">
                                        <li>ARS 무이자 할부는 해당 카드사 ARS 번호로 사전 신청을 하신 경우에 한하여 무이자 혜택이
                                            적용됩니다.<br />(ARS 부문 무이자 할부 포함)
                                        </li>
                                        <li>상기 부분 무이자 할부는 5만원 이상 결제 시 자동 적용되며, 결제창에는 무이자 표시가 되지
                                            않을 수 있습니다.</li>
                                        <li>법인 / 체크 / 선불 / 기프트 / 은행 계열 카드는 제외됩니다.</li>
                                        <li>고객 부담 수수료는 해당 카드사로 문의 바랍니다.</li>
                                        <li>본 행사는 카드사 사정에 따라 일부 내용이 변경 또는 중단될 수 있습니다.</li>
                                    </ul>
                                </div>
                                <!--//tab contents 1-->
                                <!--tab contents 2-->
                                <div>
                                    <div class="title_wrap">
                                        <h5>청구할인 행사</h5>
                                    </div>
                                    <!--Table wrap-->
                                    <table class="cnt_type1">
                                        <caption>청구할인 행사</caption>
                                        <colgroup>
                                            <col style="width: 155px" />
                                            <col style="width: 270px" />
                                            <col />
                                        </colgroup>
                                        <tbody>
                                            </tbody>
                                    </table>
                                    <!--//Table wrap-->
                                    <ul class="bul_sty01_li mt40">
                                        <li>법인/선불/기프트/은행 계열 카드는 제외됩니다.</li>
                                        <!--  <li>상기 청구할인 행사는 5만원 이상 결제 시 자동 적용되며, 결제창에는 표시가 되지 않을 수
                                            있습니다.</li>-->
                                        <li>본 행사는 카드사 사정에 따라 일부 내용이 변경 또는 중단될 수 있습니다.</li>
                                    </ul>
                                </div>
                                <!--//tab contents 2-->
                                <!--tab contents 3-->
                                <div>
                                    <div class="title_wrap">
                                        <h5>즉시할인 행사</h5>
                                    </div>
                                    <!--Table wrap-->
                                    <table class="cnt_type1">
                                        <caption>즉시할인 행사</caption>
                                        <colgroup>
                                            <col style="width: 155px" />
                                            <col style="width: 270px" />
                                            <col />
                                        </colgroup>
                                        <tbody>
                                            </tbody>
                                    </table>
                                    <!--//Table wrap-->
                                    <div id="nowSale1Img"><img src="/_ui/desktop/common/images/paynow.jpg" alt="paynow" width="100%"/></div>
                                    <ul class="bul_sty01_li" style="display:none" id="nowSale1">
                                        <li>선착순 1,000명 대상 행사로, 조기 종료될 수 있습니다.</li>
                                        <li>전액 취소될 경우에 한하여 할인 혜택이 복원됩니다.</li>
                                        <li>PAYNOW로 결제하는 경우 무이자 할부는 PAYNOW 정책에 따라 진행됩니다.</li>
                                        <li>결제문의 : 페이나우 고객센터 (1544-7772)</li>
                                    </ul>
                                    <ul class="bul_sty01_li mt40" id="nowSale2">
                                        <li>법인/체크/선불/기프트/은행 계열 카드는 제외됩니다.</li>
                                        <li>상기 청구할인 행사는 5만원 이상 결제 시 자동 적용되며, 결제창에는 표시가 되지 않을 수 있습니다.</li>
                                        <li>본 행사는 카드사 사정에 따라 일부 내용이 변경 또는 중단될 수 있습니다.</li>
                                    </ul>
                                </div>
                                <!--//tab contents 3-->
                            </div>
                            <!--//card event tab container-->
                        </div>
                    <!--//orderwrap left-->
                    <!--orderwrap right-->
                    <div class="float_right"
                        style="position: absolute; left: 680px;">
                        <!--final payment sum box-->
                        <div class="sum_box">
                            <div>
                                <p class="tlt">
                                    최종 결제 금액</p>
                                <hr />
                                <dl class="clearfix">
                                    <dt>
                                        상품 합계</dt>
                                    <dd id="subTotal">
                                        ₩651,000</dd>
                                    <dt>배송비</dt>
                                        <dd id="deliveryCost">
                                            ₩ 0</dd>
                                    </dl>
                            </div>
                            <div class="total">
                                <dl class="clearfix">
                                    <dt>
                                        합계</dt>
                                    <dd id="totalPrice">
                                        ₩651,000</dd>
                                </dl>
                            </div>
                            <input type="hidden" name="total" id="total" value="651000.0" />
                            <input type="hidden" name="cartDeliveryCost" id="cartDeliveryCost" value="0.0" />
                        </div>
                        <!--//final payment sum box-->
                        <!--point & agreement box-->
                        <div class="p_a_box">
                                <div class="point">
                                    <!-- 간편회원일 때 s --> <!-- 간편회원뿐만 아니라 전환회원일 때 띄움 -->
                                            <p class="tlt">통합회원 전환 시 지급예정 포인트</p>
                                            <p>(상품 수령완료 10일 후 적립, 간편회원은 미적립)</p>
                                            <p class="txt" id="txtAccumulationPoint">한섬마일리지
                                                0 M
                                            </p>
                                            <p class="txt" id="txtAccumulationHPoint">H.Point
                                                0 P
                                            </p>
	                                        <div class="mt20">
	                                            <span><b>통합회원</b>으로 전환하시겠습니까?</span> 
	                                            <a href="https://www.h-point.co.kr/cu/join/start.nhd"
	                                               class="btn add_ss float_right">전환가입
	                                            </a>
	                                        </div>
                                        <!-- 간편회원일 때 e -->
                                        <input type="hidden" name="accumulationPoint"
                                        id="accumulationPoint" value="0" />
                                    <input type="hidden" name="accumulationHPoint"
                                        id="accumulationHPoint" value="0" />    
                                </div>
                                
                                <div class="agree">
                                    <input type="checkbox" id="agree" /><label for="agree"
                                        class="tlt">[필수] 구매자 동의 </label>
                                    <p class="txt">
                                        주문할 상품의 상품명, 가격, 배송정보 등<br /> 
                                        판매조건을 확인하였으며, 구매진행에 동의합니다.<br />
                                        (전자상거래법 제8조 2항)<br /><br />
                                        기존 마이너스 한섬마일리지를 보유하고 있는 고객은 
                                        한섬마일리지가 차감되어 적립되는 것에 동의합니다. 
                                        적립 예정 한섬마일리지가 상이할 수 있습니다.
                                        
                                        <br><br>
                                        * 통합멤버십으로 가입하시면 H.Point 적립 및 사용이 가능합니다.
                                        </p>
                                </div>
                          <!-- 20220905 our legacy 개인정보 제3자 제공 추가. -->
                                </div>
						<!--//point & agreement box-->
                        <span id="doOrderBtn">
							<a href="#;" class="btn gray " onclick="doOrder();">
결제하기</a>
                        </span>
                    </div>
                    <!--//orderwrap right-->
                </div>
                <!--//orderwrap-->
            </div>
            <!--//sub_container-->

        <div>
<input type="hidden" name="CSRFToken" value="9e514b81-fe03-458e-9ec6-2f0271b04fc7" />
</div></form><!--layer pop-->
        <div class="popwrap w_type_3" id="popwrap" style="display: none">
            <!-- Title1 -->
            <div class="pop_tltwrap">
                <h3>
                    배송지관리</h3>
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
                            고객님이 저장하신 배송지 목록입니다.<span class="com_txt_p">(마이페이지에서 등록 및 수정 하실 수 있습니다.)</span>
                        </p>
                        <!-- table -->
                        <div>
                            <table class="pop_dtable my">
                                <caption>
                                    배송지관리</caption>
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
                            <input class="btn wt_s" value="취소" type="button" onclick="$('.btn_close').click();" />
                            <input class="btn gray_s mr0" value="확인" type="button" onclick="javascript:selectAddress();" />
                        </div>
                    </div>
                    <!--// tab 1 -->

                    <!-- tab 2 -->
                    <div>
                        <p class="com_txt mb20 ml10">
                            고객님께서 최근 주문 시 사용하셨던 10개의 배송지 목록 입니다.</p>
                        <!-- table -->
                        <table class="pop_dtable lately">
                            <caption>
                                배송지관리</caption>
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
                            <input class="btn wt_s" value="취소" type="button" onclick="$('.btn_close').click();" />
                            <input class="btn gray_s mr0" value="배송지로 선택" type="button" onclick="javascript:selectDeliveryAddress();" />
                        </div>
                    </div>
                    <!--// tab 2 -->

                </div>
            </div>
            <!-- btn_close -->
            <a href="#;" class="btn_close">
                <img src="/_ui/desktop/common/images/popup/ico_close.png" alt="닫기" />
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
                    고객님의 소중한 한섬마일리지/기프트카드를 보호하기 위하여 비밀번호를 재확인합니다.<br /> 로그인 비밀번호를 입력해 주시기 바랍니다.
                </p>
            </div>
            <!-- //Title1 -->
            <div class="pop_cnt ">
                <div class="tblwrap">
                    <form id="userInfoForm" action="/ko/checkout/ordersheet" method="post"><input id="uid" name="uid" type="hidden" value="kms199606036@naver.com" />
                        <input id="gubun" name="gubun" type="hidden" value="" />
                        <input id="pnt" name="pnt" type="hidden" value="" />
                        <table class="tbl_wtype1">
                            <caption>제목입력</caption>
                            <colgroup>
                                <col style="width: 100px">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row"><label for="pw">비밀번호</label></th>
                                    <td><input id="pw" name="pw" type="password" value="" title="비밀번호 입력" style="width: 150px;" onkeydown="if(event.keyCode==13){this.blur();checkPassword();return false;}" />
                                        <span class="guide_comment" id="pwMsg"></span></td>
                                </tr>
                            </tbody>
                        </table>
                    <div>
<input type="hidden" name="CSRFToken" value="9e514b81-fe03-458e-9ec6-2f0271b04fc7" />
</div></form></div>
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
        <div class="popwrap w_type_10"  id="popwrap3" style="display: none;">
        <!-- Title1 -->
            <div class="pop_tltwrap2">
                    <h3>휴대폰 인증</h3>
            </div>
                <!-- //Title1 -->
                <div class="pop_cnt">
                    <form id="hpointForm" action="/ko/checkout/ordersheet" method="post"><input id="certNo" name="certNo" type="hidden" value="" />
                        <fieldset>
                            <legend>휴대폰인증</legend>
                            <div class="phoneCerti">
                                <p class="txt">
                                    H.Point 10만 포인트 이상 사용 시에는 <br />
                                    고객님의 휴대폰으로 인증이 필요합니다.<br />
                                    SMS 발송 후 3분 이내 인증번호 6자리를 입력해주시기 바랍니다.
                                </p>
                                <div class="btnArea">
                                    <p class="phoneNum"></p>
                                    <input type="button" class="btn add_s" value="인증번호발송" style="padding:6px 13px 10px; margin:0" id="startTimer" onclick="hpointAuthHandphone();"/>
                                </div>
                                <div class="inputArea">
                                    <label for="codeInput">인증번호</label><input type="text" id="codeInput" />
                                    <p class="time">남은시간 <span id="counter">03:00초</span></p>
                                </div>
                            </div>
                            <div class="btnwrap">
                                <input type="button" class="btn wt" value="취소"  onclick="$('.btn_close').click();" id="stopTimer" />
                                <input type="button" class="btn gray" value="확인"  id="stopTimer"  onclick="checkHPassword();"/>
                            </div>
                        </fieldset>
                    <div>
<input type="hidden" name="CSRFToken" value="9e514b81-fe03-458e-9ec6-2f0271b04fc7" />
</div></form></div>
                <!-- btn_close -->
                <a href="#" class="btn_close"><img src="/_ui/desktop/common/images/popup/ico_close.png" alt="닫기"></a>
                <!-- //btn_close -->
        </div>
        <!--//layer pop-->
        <!--layer pop : 관세확인 -->
        <!--//layer pop-->

		
        <div id="payinfo">
			<form id="PAY_FORM" method="post">
			</form>
        </div>
        
        </div>
    <!-- //bodyWrap -->
    <div class="layerArea" id="productLayer" style="display: none;">
        <div class="layerBg"></div>
    </div>
       <!-- 200227 추가 -->
        <div class="popwrap deliy_pop0227" style="display:none;">
        <a href="#;" class="btn_close"><img src="/_ui/desktop/common/images/popup/ico_close.png" alt="닫기"></a>
        <h3>택배사를 선택해주세요</h3>
        <p>
                두 택배사의 배송비와 예상 배송일은 동일합니다.<br />
                평소 선호하시는 택배사를 선택해주세요.
        </p>
        <p class="m_deily_notice" style="margin-top:-16px;margin-bottom:25px;color:#222222;font-style:normal;font-weight:normal; ">
            THE STAR, STAR, MANIA 등급 대상 서비스입니다. (선택 사항)
        </p>
            <!-- deilvy_box -->
            <div class="deilvy_box">
                <!-- deilvy_con -->
                <div class="deilvy_con">
                    <label class="check_style">
                        <input type="radio" name="deilvy_rdo" id="deilvy_rdo01"  />
                        <span><img src="http://cdn.thehandsome.com/_ui/desktop/common/images/txt_deilvery_001_0227.jpg" alt=""></span>
                        <p class="ab-impor">※ 토요일 출고 불가</p>
                    </label>
                </div>
                <!-- // deilvy_con -->
                <!-- deilvy_con -->
                <div class="deilvy_con">
                    <label class="check_style">
                        <input type="radio" name="deilvy_rdo" id="deilvy_rdo02"  />
                        <span><img src="http://cdn.thehandsome.com/_ui/desktop/common/images/txt_deilvery_002_0227.jpg" alt=""></span>
                        <p class="ab-impor">※ 토요일 출고 가능</p>
                    </label>
                </div>
                <!-- // deilvy_con -->
            </div>
            <!-- // deilvy_box -->
            <p class="next_deil">
                <label>
                    <input type="checkbox" name="next_chk" id="next_chk"  />
                    <span>지금 선택한 배송 방법을 다음에도 사용합니다.</span>
                </label>
            </p>
            <a class="confirm_btn" id="confirm_btn_selectComp" href="#a">확인</a>
        </div>
        <!-- // 200227 추가 -->
    <!-- 20220905 팝업 추가 -->
    <div class="layerArea" id="layerPinfoAgree" style="z-index: 10000; position: fixed; display: none;">
		<div class="layerBg"></div>
		<div class="popwrap pop_pinfo_agree">
			<!-- Title1 -->
			<div class="pop_tltwrap2">
				<h1 style="padding-top: 15px;font-size: 19px;font-weight: 700;text-align: center;">개인정보 제3자 제공 동의</h1>
			</div>
			<!-- //Title1 -->
			<div class="pop_cnt ">
				‘아워레가시’ 브랜드 정보 공유 및 마케팅 활용 목적으로 동의하신 고객님에 한하여 최소한의 개인정보가 제 3자에게 제공됩니다. <br>
				고객님께서는 개인정보 제 3자 제공에 대해 ‘동의’ 또는 ‘거부’를 선택할 수 있으며, 선택에 관계없이 제품 구매가 가능합니다.  <br>
				개인정보 제공 관련 구체적인 내용은 아래와 같습니다.
					<ol class="">
						<li><strong>제공받는 자</strong> : 국내 소재 OUR LEGACY의 대리인<br>(한섬과 OUR LEGACY 독점 계약 종료 시 사업을 이어받을 국내 신규 사업자)</li>
						<li><strong>제공 항목</strong> : 성명 및 이메일 주소</li>
						<li><strong>이용 목적</strong> : 마케팅 활용 및 브랜드 정보 공유</li>
						<li><strong>보유 및 이용기간</strong> : 회원탈퇴시 또는 동의 철회시까지</li>
					</ol>
				<div class="btnwrap">
					<input type="button" class="btn gray mr0" value="확인" onclick="$('.btn_close').click();">
				</div>
			</div>
			<!-- btn_close -->
			<a href="#;" class="btn_close">
				<img src="/_ui/desktop/common/images/popup/ico_close.png" alt="닫기">
			</a>
			<!-- //btn_close -->
		</div>
	</div>
    
    
    
    
<!-- footerWrap -->

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
