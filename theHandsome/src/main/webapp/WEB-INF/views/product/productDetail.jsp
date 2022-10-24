<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="/WEB-INF/views/common/header.jsp"%>

<div id="bodyWrap" class="item_detail">
	<div id="oneEventLayer"></div>

	<div class="adaptive_wrap">
		<div class="clearfix prd_detail1905" id="clearfix">
			<div class="clearfix image_view3">
				<a href="javascript:imageZoom()" id="btn_zoom" class="btn_zoom"
					onclick="GA_Event('상품_상세','크게보기','클릭')">크게보기</a>
				<c:forEach items="${colorVOList}" var="colorVO">
					<div class="image_view_${colorVO.ccolorcode}"
						id="image_view_${colorVO.ccolorcode}" style="display: none">
						<div class="item_visual" id="imageDiv" style="margin-top: 20px;">
							<ul>
								<c:if test="${not empty colorVO.cimage2}">
									<li><img src="${colorVO.cimage2}" class="respon_image"
										alt=""
										onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img1.jpg'">
									</li>
								</c:if>
								<c:if test="${not empty colorVO.cimage3}">
									<li><img src="${colorVO.cimage3}" class="respon_image"
										alt=""
										onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img1.jpg'">
									</li>
								</c:if>
								<c:if test="${not empty colorVO.cimage4}">
									<li><img src="${colorVO.cimage4}" class="respon_image"
										alt=""
										onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img1.jpg'">
									</li>
								</c:if>
								<c:if test="${not empty colorVO.cimage5}">
									<li><img src="${colorVO.cimage5}" class="respon_image"
										alt=""
										onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img1.jpg'">
									</li>
								</c:if>
							</ul>
						</div>
					</div>
				</c:forEach>

			</div>
			<script type="text/javascript" src="/_ui/desktop/common/js/wpay.js"></script>
			<!-- 품절상품포함 여부 -->
			<div class="item_detail_info float_right" id="contentDiv"
				style="margin-top: 20px; top: 0px; left: 699px;">
				<div class="info">
					<div class="info_sect">
						<h4 class="item_name">
							<div class="brand-name">
								<a href="javascript:void(0);">${productVO.bname}</a>
							</div>
							<span class="name ko_fir_spel">${productVO.pname}<input
								type="hidden" id="brandName" value="${productVO.bname}">
								<input type="hidden" id="productName" value="${productVO.pname}">
								<input type="hidden" id="productCode" value="${productVO.pid}">
							</span>
						</h4>

						<div class="flag"></div>

						<p class="price">
							<span id="pricespan">₩${productVO.pprice}</span> <input
								type="hidden" id="productPrice" value="${productVO.pprice}">
						</p>
						<!-- 상품추가설명 -->
						<p class="selling_point"></p>
						<!-- 20200914이후 추가 상품설명 (신) -->
						<div class="prod-detail-con-box">
							<strong class="number-code">상품품번 : <span id="pcscode">${curColorCode}</span></strong>
							<div class="round-style">
								<p>${productVO.pdetail}</p>
							</div>
							<div class="fit-info">
								<p class="size-text">${productVO.pinfo}</p>
							</div>
						</div>
						<!-- 20200914 이전 상품설명(구) -->
					</div>

					<!-- //20200904 더보기 -->
					<div class="info_sect">
						<ul class="point_delivery">
							<li><span class="title">배송비</span> <span class="txt">전
									상품 무료배송</span> <a href="javascript:fn_popupDelivery();"
								class="etc_info">배송안내</a> <!-- onclick="GA_Event('상품_상세','배송안내','클릭');" -->
								<div class="popwrap w_type_2" id="popupDelivery"
									style="display: none;">
									<div class="pop_tltwrap2">
										<h3>배송비안내</h3>
									</div>
									<div class="pop_cnt">
										<table class="cnt_type1">
											<caption>배송비안내</caption>
											<colgroup>
												<col style="width: 155px">
												<col>
											</colgroup>
											<tbody>
												<tr>
													<th scope="row">배송기간</th>
													<td>평균 입금완료일 기준 2-4일 소요됩니다.<br>(토/일/공휴일 제외)
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
									<a href="javascript:fn_popdownDelivery();" class="btn_close"><img
										src="http://cdn.thehandsome.com/_ui/desktop/common/images/popup/ico_close.png"
										alt="닫기"></a>
								</div></li>
						</ul>
					</div>

					<div class="info_sect" id="color_size">
						<ul class="color_size_qty">
							<li><span class="title">색상</span>
								<div class="txt">
									<ul class="color_chip clearfix">
										<c:forEach items="${colorVOList}" var="colorVO">
											<input type="hidden" id="colorName" value="${colorVO.cname}">
											<li id="${colorVO.ccolorcode}"><input type="hidden"
												class="colorNameVal"> <a href="javascript:void(0);"
												class="colorBtn" value="${colorVO.cname}"
												colorcode="${colorVO.ccolorcode}"
												style="background: #000000 url('${colorVO.ccolorimage})"
												onmouseover="setColorName('${colorVO.cname}');"
												onmouseout="setColorName('');"> </a> <!-- secColroName이라는 js 함수 만들어줘야할듯 -->
											</li>
										</c:forEach>
									</ul>
								</div> <span class="cl_name" id="colorNameContent"></span></li>
							<li><span class="title">사이즈<!-- 사이즈 --></span> <span
								class="txt">
									<div class="popwrap w_type_2" id="sizeQuickReferenceLayer"
										style="display: none;">
										<div class="pop_tltwrap2">
											<h3>사이즈조견표</h3>
										</div>
										<div class="pop_cnt">
											<div class="size_chart">
												<div class="tab_a m6" id="size_tab">
													<ul>
														<li><a href="#;" class="active">WOMEN<br>TOP
														</a></li>
														<li><a href="#;">WOMEN<br>BOTTOMS
														</a></li>
														<li><a href="#;">WOMEN<br>SHOES
														</a></li>
														<li><a href="#;">MEN<br>TOP
														</a></li>
														<li><a href="#;">MEN<br>BOTTOMS
														</a></li>
														<li><a href="#;">MEN<br>SHOES
														</a></li>
													</ul>
												</div>
												<div class="size_tab_container">
													<div>
														<table class="cnt_type2">
															<caption>사이즈조견표</caption>
															<colgroup>
																<col>
																<col style="width: 16%">
																<col style="width: 16%">
																<col style="width: 16%">
																<col style="width: 16%">
																<col style="width: 16%">
															</colgroup>
															<thead>
																<tr class="al_middle">
																	<th scope="col">BRAND/<br>SIZE
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
																	<td>160/<br>80A
																	</td>
																	<td>165/<br>84A
																	</td>
																	<td>170/<br>88A
																	</td>
																	<td>175/<br>92A
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
																<col>
																<col style="width: 19%">
																<col style="width: 19%">
																<col style="width: 19%">
																<col style="width: 19%">
															</colgroup>
															<thead>
																<tr class="al_middle">
																	<th scope="col">BRAND/<br>SIZE
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
																	<td>160/<br>66A
																	</td>
																	<td>165/<br>68A
																	</td>
																	<td>170/<br>70A
																	</td>
																	<td>175/<br>72A
																	</td>
																</tr>
															</tbody>
														</table>
													</div>
													<div style="display: none;">
														<table class="cnt_type2">
															<caption>사이즈조견표</caption>
															<colgroup>
																<col>
																<col style="width: 19%">
																<col style="width: 19%">
																<col style="width: 19%">
																<col style="width: 19%">
															</colgroup>
															<thead>
																<tr class="al_middle">
																	<th scope="col">BRAND/<br>SIZE
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
																<col>
																<col style="width: 16%">
																<col style="width: 16%">
																<col style="width: 16%">
																<col style="width: 16%">
																<col style="width: 16%">
															</colgroup>
															<thead>
																<tr class="al_middle">
																	<th scope="col">BRAND/<br>SIZE
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
																	<th scope="row">TIME<br>HOMME
																	</th>
																	<td>90</td>
																	<td>95</td>
																	<td>100</td>
																	<td>105</td>
																	<td>110</td>
																</tr>
																<tr class="al_middle">
																	<th scope="row">SYSTEM<br>HOMME
																	</th>
																	<td>90</td>
																	<td>95</td>
																	<td>100</td>
																	<td>105</td>
																	<td>110</td>
																</tr>
																<tr class="al_middle">
																	<th scope="row">CLUB<br>MONACO
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
																	<td>165/<br>80-90
																	</td>
																	<td>170/<br>96-98
																	</td>
																	<td>175/<br>108-110
																	</td>
																	<td>180/<br>118-122
																	</td>
																	<td>185/<br>126-130
																	</td>
																</tr>
															</tbody>
														</table>
													</div>
													<div style="display: none;">
														<table class="cnt_type2">
															<caption>사이즈조견표</caption>
															<colgroup>
																<col>
																<col style="width: 9.5%">
																<col style="width: 9.5%">
																<col style="width: 9.5%">
																<col style="width: 9.5%">
																<col style="width: 9.5%">
																<col style="width: 9.5%">
																<col style="width: 9.5%">
																<col style="width: 9.5%">
																<col style="width: 9.5%">
															</colgroup>
															<thead>
																<tr class="al_middle">
																	<th scope="col">BRAND/<br>SIZE
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
																	<th scope="row">TIME<br>HOMME
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
																	<th scope="row">SYSTEM<br>HOMME
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
																	<th scope="row">CLUB<br>MONACO
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
																<col>
																<col style="width: 23%">
																<col style="width: 23%">
																<col style="width: 23%">
															</colgroup>
															<thead>
																<tr class="al_middle">
																	<th scope="col">BRAND<br>SIZE
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
										<a href="javascript:fn_popdownSizeQuickReference();"
											class="btn_close"><img
											src="http://cdn.thehandsome.com/_ui/desktop/common/images/popup/ico_close.png"
											alt="닫기"></a>
									</div>
									<ul class="size_chip clearfix sizeChipKo1901">
										<c:forEach items="${sizelist}" var="size">
											<li value="${size}"><a href="javascript:void(0);"
												class="sizeBtn">${size}</a></li>
										</c:forEach>
									</ul>
							</span> <!-- 2021.08.10 화장품 상품인 경우 사이즈조견표 영역 미노출 --> <a
								href="javascript:fn_popupSizeQuickReference();" class="etc_info">사이즈
									조견표</a> <!-- 재입고알림 툴팁 --> <!-- //재입고알림 툴팁 -->
								<div id="vs-placeholder-cart">
									<div id="vs-inpage" class="handsome" style="display: none;"></div>
								</div> <!-- 버츄사이즈 --></li>
							<li><span class="title">수량</span> <span class="txt">
									<span class="qty_sel num"> <a
										href="javascript:fn_qtySubtraction();" class="left">이전 버튼</a>
										<input type="text" id="txtqty" title="수량" value="1"
										class="mr0" readonly="readonly" style="text-indent: 0;">
										<a href="javascript:fn_qtyAdd();" class="right">다음 버튼</a>
								</span>
							</span> <span class="txt" id="popularProudct" style="display: none">
									<span class="deliveryPlanDate"> 해당 상품은 전국 매장을 통해 수급하여 배송
										될 예정입니다. <br> 불량 등의 이유로 수급이 어려울 경우, 취소될 수 있습니다. <br>(평일
										기준 5일 이상 소요 예정)
								</span>
							</span> <input type="hidden" id="erpWorkOrderNumber"> <input
								type="hidden" id="reserveSalesStockpile"> <input
								type="hidden" id="erpWorkOrderProdCode"></li>
						</ul>
					</div>
					<div class="total_price clearfix">
						<div class="title float_left" style="width: auto;">총 합계</div>
						<div class="pirce float_right">
							<span id="sumPrice">₩${productVO.pprice}</span>
						</div>
					</div>
					<!-- //st_store_wrap -->
					<div class="btnwrap clearfix"
						style="position: absolute; width: 473px; margin-bottom: 153.979px;">
						<!--//190508 추가 -->
						<form id="addToCartBuynowForm" name="addToCartBuynowForm"
							action="/product/order_page" method="post">
							<input type="hidden" name="order_colorcode" id="order_colorcode"
								value="${curcolorcode}" /> <input type="hidden"
								name="order_size" id="order_size" value="" /> <input
								type="hidden" name="order_sumprice" id="order_sumprice" value="" />
							<input type="hidden" name="order_hsm" id="order_hsm" value="" />
							<input type="hidden" name="order_hspoint" id="order_hspoint"
								value="" /> <input type="hidden" name="order_count"
								id="order_count" value="" /> <input type="button" value="바로주문"
								class="btn order float_right mr0" style="width: 473px;"
								id="addToCartBuyNowButton">
						</form>
					</div>
				</div>

				<input type="hidden" id="viewExhibitionPageCode" value=""> <input
					type="hidden" id="viewExhibitionPageName" value=""> <input
					type="hidden" id="vs-product-id" value="TH2CBKPC033M_BK"> <input
					type="hidden" id="vs-product-version" value="1"> <input
					type="hidden" id="vs-product-image-url"
					value="http://newmedia.thehandsome.com/TH/2C/FW/TH2CBKPC033M_BK_T01.jpg">
			</div>

		</div>
		<div class="product-detail-img"></div>
		<div class="matches_items" id="productDetailEtc"></div>
	</div>
</div>
<!--// pop_cnt-->
<a href="javascript:void(0);" class="btn_close"><img
	src="/_ui/desktop/common/images/popup/ico_close.png" alt="닫기"></a>

<div id="criteo-tags-div" style="display: none;"></div>

<form id="productOneCLickDeliveryForm"
	action="/ko/mypage/myDeliveryList">
	<input type="hidden" name="code" id="code" value="">
</form>
<input type="hidden" id="chkToastFirstYn" name="chkToastFirstYn"
	value="N">
<iframe style="display: none" id="fileFrame" title="fileFrame" scr=""></iframe>

<!-- footerWrap -->
<script>
	//가격에 3자리마다 콤마
	function priceComma(price) {
		return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}

	//배송안내버튼 클릭시 보여지게
	function fn_popupDelivery() {
		//fn_parentLayer();
		$("#popupDelivery").show();
	}
	//배송안내버튼 클릭시 안보여지게
	function fn_popdownDelivery() {
		$("#popupDelivery").hide();
	}
	// 사이즈 조견표클릭시 보여지게
	function fn_popupSizeQuickReference() {
		$("#sizeQuickReferenceLayer").show();
	}
	// 사이즈 조견표클릭시 보여지게
	function fn_popdownSizeQuickReference() {
		$("#sizeQuickReferenceLayer").hide();
	}
	//컬러버튼 이미지 올릴때 오른쪽에 컬러이름 띄워지게하기
	function setColorName(colorName) {
		$("#colorNameContent").text(colorName);
	}

	//btn_close라는 클래스 이름을 가진 버튼을 클릭시 닫기 적용
	$(".btn_close").on("click", function() {
		$('#productLayer').hide();
		$(".popwrap").hide();
	});

	//사이즈 체크 확인 창이 뜨고 확인버튼을 누르면 확인 모달창에 사라짐
	function sizeConfirm() {
		$('#productLayer').hide();
		$("#Order_confirm").hide();
	}

	//수량버튼 내렸을때! 무조건 1개 이상이여야함
	function fn_qtySubtraction() {
		let qty = parseInt($("#txtqty").val());
		if (qty - 1 > 0) {
			qty--;
			$("#txtqty").val(qty + "");
			const sumprice = parseInt($("#productPrice").val()) * qty;
			$("#sumPrice").text("₩" + priceComma(sumprice));

			//마일리지, 포인트 알맞게 값 넣기
			let hsm = parseInt("${productVO.pprice}") * 5 / 100 * qty;
			let hspoint = parseInt("${productVO.pprice}") * 0.1 / 100 * qty;
			$("#hsm").text(priceComma(hsm) + " M (%5)")
			$("#hspoint").text(priceComma(hspoint) + " P (%0.1)")
		}
	}

	function fn_qtyAdd() {
		let qty = parseInt($("#txtqty").val());
		if (qty + 1 > 10) {
			alert("지연: 10개까지만 가능하게 일단 설정! 재고수량에서 빼면서 최대 수량을 주문하고싶어서 수정예정");
		} else {
			qty++;
			$("#txtqty").val(qty + "");
			const sumprice = parseInt($("#productPrice").val()) * qty;
			$("#sumPrice").text("₩" + priceComma(sumprice));

			//마일리지, 포인트 알맞게 값 넣기
			let hsm = parseInt("${productVO.pprice}") * 5 / 100 * qty;
			let hspoint = parseInt("${productVO.pprice}") * 0.1 / 100 * qty;
			$("#hsm").text(priceComma(hsm) + " M (%5)")
			$("#hspoint").text(priceComma(hspoint) + " P (%0.1)")
		}
	}

	$(document).ready(
			function() {
				//페이지 로드할때 선택된 이미지로 상세보기이미지가 띄워지고 
				let prev_colorcode = "${curColorCode}";
				$(".image_view_" + prev_colorcode).css('display', 'block');
				// 선택된 컬러버튼 클릭된 상태로 만들기
				$('a[colorcode=${curColorCode}]').addClass('on');
				selectColor = $('a[colorcode=' + prev_colorcode + ']').attr(
						'value');

				//마일리지, 포인트 알맞게 값 넣기
				let hsm = parseInt("${productVO.pprice}") * 5 / 100
				let hspoint = parseInt("${productVO.pprice}") * 0.1 / 100
				$("#hsm").text(priceComma(hsm) + " M (%5)")
				$("#hspoint").text(priceComma(hspoint) + " P (%0.1)")

				//COLOR 버튼 눌리면 왼쪽 이미지들 바뀌고 제품코드고 바뀜
				$(".colorBtn").on(
						"click",
						function(e) {
							$(".image_view_" + prev_colorcode).css('display',
									'none');
							$(".image_view_" + $(this).attr("colorcode")).css(
									'display', 'block');
							prev_colorcode = $(this).attr("colorcode");
							$("#pcscode").text($(this).attr("colorcode"));
							//일단 모든 버튼 on 지우고
							$(".colorBtn").removeClass('on');
							//또한 누르면 그버튼이 계속 눌렸다는걸 표시
							$(this).addClass('on');
							selectColor = $(this).attr("value");
						});

				//사이즈버튼 눌리면 사이즈 공백 제거후 상품코드 변경
				$(".sizeBtn").on("click", function(e) {
					const sizeText = $.trim($(this).text());
					selectSize = sizeText;
					$("#pcscode").text(prev_colorcode + "_" + sizeText);

					//일단 모든 버튼 on 지우고
					$(".sizeBtn").removeClass('on');
					//또한 누르면 그버튼이 계속 눌렸다는걸 표시
					$(this).addClass('on');
				});

				//처음 로드될때 가격에 3자리마다 콤마찍음
				const num = $("#productPrice").val().replace(
						/\B(?=(\d{3})+(?!\d))/g, ',');
				//콤마찍은 숫자를 가격, 총합계 태그에 뿌림
				$("#pricespan").text("₩" + num);
				$("#sumPrice").text("₩" + num);
			});
</script>
<%@include file="/WEB-INF/views/common/footer.jsp"%>