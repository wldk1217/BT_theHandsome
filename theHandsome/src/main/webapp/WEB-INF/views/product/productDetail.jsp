<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="/WEB-INF/views/common/header.jsp"%>
<!-- 광고 유입 끝 -->
<!-- Loading -->
<div class="loading_bar" id="loadingBarDiv" style="display: none;">
	<img src="/_ui/desktop/common/images/common/loading.gif" alt="loading">
	<span>�로딩중</span>
</div>
<!-- //Loading -->

<div id="bodyWrap" class="item_detail">
	<div id="oneEventLayer"></div>

	<div class="adaptive_wrap">
		<div class="clearfix prd_detail1905" id="clearfix">
			<div class="clearfix image_view3">
				<a href="javascript:imageZoom()" id="btn_zoom" class="btn_zoom"
					onclick="GA_Event('상품_상세','크게보기','클릭')">크게보기</a>
				<!-- 버튼 클릭시 item_visual 에 zoom 클래스 추가 -->
				<!-- 2021.08.18 동영상 재생 수정, 상품 imageDivisionCode에 VOD가 있는 경우 동영상 url 세팅 -->
				<c:forEach items="${colorVOList}" var="colorVO">
					<div class="image_view_${colorVO.ccolorcode}"
						id="image_view_${colorVO.ccolorcode}" style="display: none">
						<div class="item_visual" id="imageDiv" style="margin-top: 20px;">
							<ul>
								<c:if test="${colorVO.cimage1}">
									<li><img src="${colorVO.cimage1}" class="respon_image"
										alt="${colorVO.pid}"
										onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img1.jpg'">
									</li>
								</c:if>
								<c:if test="${colorVO.cimage2}">
									<li><img src="${colorVO.cimage2}" class="respon_image"
										alt="${colorVO.pid}"
										onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img1.jpg'">
									</li>
								</c:if>
								<c:if test="${colorVO.cimage3}">
									<li><img src="${colorVO.cimage3}" class="respon_image"
										alt="${colorVO.pid}"
										onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img1.jpg'">
									</li>
								</c:if>
								<c:if test="${colorVO.cimage4}">
									<li><img src="${colorVO.cimage4}" class="respon_image"
										alt="${colorVO.pid}"
										onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img1.jpg'">
									</li>
								</c:if>
								<c:if test="${colorVO.cimage5}">
									<li><img src="${colorVO.cimage5}" class="respon_image"
										alt="${colorVO.pid}"
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
							<strong class="number-code">상품품번 : ${productVO.pid}<span
								id="pcscode">${curColorCode}</span></strong>
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
						style="position: absolute; width: 473px; /* margin-top: -153.979px; */ margin-bottom: 153.979px;">
						<input type="button" value=""
							class="btn wishlist1803 float_left ml0  "
							onclick="addWishListClick();">

						<div class="toast_popup">
							<p style="display: none; top: -4.12381px; opacity: 0.031172;">위시리스트에서
								삭제했습니다.</p>
						</div>

						<!--190508 추가 -->
						<div class="toast_popup_pre_order1905">
							<!-- 토스트팝업 190507 -->
							<p>
								예약 주문이 가능한 옵션(컬러/사이즈)가 있습니다. <br>옵션 선택 후 배송 예정일을 확인해 주세요.
							</p>
							<span class="arr">위치아이콘</span>
						</div>
						<!--//190508 추가 -->

						<form id="addToCartForm" name="addToCartForm" action="/쇼핑백 등록 url"
							method="post">
							<input type="hidden" name="cart_prev_colorcode"
								id="cart_prev_colorcode" value="${curcolorcode}" /> <input
								type="hidden" name="cart_size" id="cart_size" value="" /> <input
								type="hidden" name="cart_sumprice" id="cart_sumprice" value="" />
							<input type="hidden" name="hsm" id="hsm" value="" /> <input
								type="hidden" name="hspoint" id="hspoint" value="" /> <input
								type="button" value="쇼핑백 담기" class="btn cart1803 float_left ml0"
								id="addToCartButton">
							<!-- onclick="addToCart();GA_Event('상품_상세','하단 고정 버튼','쇼핑백담기');" -->
							<div>
								<input type="hidden" name="CSRFToken"
									value="7399b544-9191-4d49-af3a-9a782a52adc4">
							</div>
						</form>
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
								class="btn order float_right mr0" id="addToCartBuyNowButton">
						</form>
					</div>

					<dl class="toggle_type1" style="margin-top: 80px;">
						<!-- 상품상세 정보창 변경 211027 S -->
						<!-- 상품상세 정보창 변경 211027 E -->
						<dt>
							<a href="javascript:void(0);" id="DETAIL_INFO_EVT"> 상품정보제공고시</a>
						</dt>
						<!-- 상품정보제공고시 -->
						<dd style="display: none;">
							<strong>상품품번 :</strong> ${productVO.pid}<br> <strong>품목
								:</strong> ${productVO.pitem}<br> <strong>소재 :</strong>
							${productVO.pmaterial}<br> <strong>색상 :</strong>
							${productVO.pprice}<br> <strong>사이즈 :</strong>
							${productVO.psize}<br> <strong>제조국 :</strong>
							${productVO.pcountry}<br> <strong>제조사 :</strong>
							${productVO.pmanufacturer}<br> <strong>제조연월 :</strong>
							${productVO.pmadedate}<br> <strong>세탁방법 및 취급 시 주의사항</strong>
							<div class="howToWash renew1907" id="newHowToWash">
								<ul>
									<li><img
										src="http://cdn.thehandsome.com/pc/laundryMark/pc_ko1/003.png"
										onmouseover="this.src='http://cdn.thehandsome.com/pc/laundryMark/pc_ko2/003_.png'"
										onmouseout="this.src='http://cdn.thehandsome.com/pc/laundryMark/pc_ko1/003.png'"
										onerror="javascript:onErrorImg(this);" alt="003"> <span
										class="code_num">003</span></li>
									<li><img
										src="http://cdn.thehandsome.com/pc/laundryMark/pc_ko1/029.png"
										onmouseover="this.src='http://cdn.thehandsome.com/pc/laundryMark/pc_ko2/029_.png'"
										onmouseout="this.src='http://cdn.thehandsome.com/pc/laundryMark/pc_ko1/029.png'"
										onerror="javascript:onErrorImg(this);" alt="029"> <span
										class="code_num">029</span></li>
									<li><img
										src="http://cdn.thehandsome.com/pc/laundryMark/pc_ko1/049.png"
										onmouseover="this.src='http://cdn.thehandsome.com/pc/laundryMark/pc_ko2/049_.png'"
										onmouseout="this.src='http://cdn.thehandsome.com/pc/laundryMark/pc_ko1/049.png'"
										onerror="javascript:onErrorImg(this);" alt="049"> <span
										class="code_num">049</span></li>
									<li><img
										src="http://cdn.thehandsome.com/pc/laundryMark/pc_ko1/005.png"
										onmouseover="this.src='http://cdn.thehandsome.com/pc/laundryMark/pc_ko2/005_.png'"
										onmouseout="this.src='http://cdn.thehandsome.com/pc/laundryMark/pc_ko1/005.png'"
										onerror="javascript:onErrorImg(this);" alt="005"> <span
										class="code_num">005</span></li>
									<li><img
										src="http://cdn.thehandsome.com/pc/laundryMark/pc_ko1/019.png"
										onmouseover="this.src='http://cdn.thehandsome.com/pc/laundryMark/pc_ko2/019_.png'"
										onmouseout="this.src='http://cdn.thehandsome.com/pc/laundryMark/pc_ko1/019.png'"
										onerror="javascript:onErrorImg(this);" alt="019"> <span
										class="code_num">019</span></li>
								</ul>
								본 제품은 반드시 드라이크리닝 하십시오. 세탁 시 이염, 변색, 탈색될 수 있으니 유의하시기 바랍니다. 단추나
								악세서리는 세탁 시 손상될 수 있으므로 은박지로 싸거나 분리하여 주십시오. 특성상 마찰에 의해 올 뜯김 등 원단
								손상이 발생할 수 있으니 취급 시 주의하시기 바랍니다.<br> <br>
							</div>
							<br> <strong>품질보증기준</strong><br> 1. 본 제품은 정부 고시 소비자
							분쟁해결 기준에 의거 고객의 정당한 피해를 보상해드립니다. <br> - 원단 불량, 부자재 불량, 봉제
							불량, 사이즈 부정확, 부당 표시(미표시 및 부실표시) 및 소재 구성 부적합으로 인한 세탁 사고 : 구입일로부터 1년
							이내분은 무상수리, 교환, 구입가 환불함. (단, 봉제 불량은 1년 경과 후에도 무상 수선 가능) <br>
							- 사이즈가 맞지 않거나 디자인, 색상 불만 제품 : 구입 후 7일 이내로서 제품에 손상이 없는 경우 동일 가격,
							동일 제품으로 교환 가능. <br> - 상하의 한 벌(세트/일착)인 경우 한 쪽에만 이상이 있어도 한
							벌(세트/일착)로 처리함. 단, 소재 및 디자인이 다른 경우에는 해당 의류만 교환 가능. <br>2. 소비자
							부주의에 의한 제품 훼손, 세탁 잘못으로 인한 변형 및 품질 보증기간(1년)이 경과한 제품에 대해서는 보상의 책임을
							지지 않으며, 수선 가능시에는 실비로 수선해드립니다. <br>3. 제품에 이상이 있는 경우 바로 본사로
							연락주시면 수선/교환/환불이 가능하나, 타업체(일반 수선실 등)에서 수선했을 경우는 불가능합니다.<br> <br>
							<div style="margin-bottom: 20px;">
								<p style="float: left;">
									<strong>AS 책임자와 연락처</strong><br> ㈜한섬/1800-5700
								</p>
								<!-- 20200218 마크 추가 -->
								<div class="sft_ksdt"></div>
								<!-- // 20200218 마크 추가 -->
							</div>
							<br> <br> 위 내용은 상품정보제공 고시에 따라 작성되었습니다.
						</dd>
						<!-- 2021.08.10 화장품 상품인 경우 실측사이즈 영역 미노출 -->
						<dt>
							<a href="javascript:void(0);" id="REAL_SIZE_EVT">실측사이즈</a>
						</dt>
						<!-- 실측사이즈 -->
						<dd>
							<!-- <dl class="info_tbl">
								
							</dl> -->
							<img src="/resources/image/actualsize/${productVO.pid}.png">
							<!-- <p class="info2">실측 사이즈 (82) 기준</p>
							<br>
							//numlist
							<font color="red"> <strong> 원단, 측정방법에 따라 약간의 오차
									가능성이 있습니다.</strong>
							</font> -->

							<div class="timehomme_pants_fit" style="display: none"></div>
						</dd>
						<dt>
							<a href="#" id="DELI_RETURN_EVT">배송 및 교환/반품</a>
						</dt>
						<!-- 배송 및 교환/반품 -->
						<dd>
							<p class="tit">배송안내</p>
							<dl class="info_tbl">
								<dt>배송방식 :</dt>
								<dd>우체국택배, CJ대한통운, 로젠택배</dd>
								<!-- 210728 oera 신규 추가  -->
								<dt>배송지역 :</dt>
								<dd>전국 (일부 지역 제외)</dd>
								<dt>배송정보 :</dt>
								<dd>평균 입금완료일 기준 2-4일 소요됩니다 (토/일/공휴일 제외)</dd>
								<dt>배송비 :</dt>
								<dd>
									실결제금액 기준 30,000원 이상 결제 시 무료배송<br>30,000원 미만 결제 시 2,500원(기본
									배송비)<br>* 실결제금액이란, 쿠폰/바우처 할인액 및 <br>&nbsp;
									한섬마일리지/H.Point 사용 금액을 제외한 금액입니다. <br> &nbsp;&nbsp;(e-money
									사용은 실결제금액에 포함)<br>* 도서산간 지역은 3,000원의 별도 배송비가 부과됩니다.<br>*
									일부 도서지역은 도선료가 부가될 수 있습니다.
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
									바랍니다. (교환 재고가 없을 경우, 환불로 안내예정)<br> - 교환은 배송비 입금 및 상품 입고 확인
									이후에 진행됩니다. <br> 화장품은 상품 불량만 교환 가능하며(상품 개봉 후 교환 불가), 고객센터로<br>
									문의해주시기 바랍니다.
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
							<br>
						</dd>
						<!--상품평 btn-->
						<div class="popup_customer_review1807" id="customerReview">
							<a href="#;" onclick="GA_Event('상품_상세','정보','상품평');">상품평(<span
								id="customerReviewCnt">0</span>)
								<div class="star_score1807" id="prodTotalStarScoreWrapper"
									style="display: none;">
									<span class="cmt_star"> <!-- 별점에 따라 class명 변경 (star1, star2 ,star3, star4, star5) -->
										<span class="cmt_per" id="prodTotalStarScore">별점</span>
									</span>
								</div>
							</a>
						</div>
						<!--//상품평 btn-->

					</dl>
				</div>

				<div class="clearfix mt30">
					<div class="btnwrap float_left">
						<a href="javascript:fn_popupProductQnA();" class="btn arrow mr0" r>Q&amp;A(<span
							class="data" id="productQnACnt">0</span>)
						</a>
					</div>
					<div class="float_right">
						<!-- AddToAny BEGIN -->
						<div class="a2a_kit a2a_kit_size_32 a2a_default_style"
							data-a2a-url="http://www.thehandsome.com/ko/HANDSOME/MEN/PANTS/%EC%A1%B0%EA%B1%B0-%ED%8A%B8%EB%9E%99/%5BSET%5D-%EC%9A%B8-%EC%A1%B0%EA%B1%B0-%ED%8C%AC%EC%B8%A0/p/TH2CBKPC033M_BK?lang=ko"
							data-a2a-title="[TIME HOMME] 
                            [SET] 울 조거 팬츠"
							style="line-height: 32px;">
							<a class="a2a_button_facebook"
								onclick="GA_Event('상품_상세','공유_SNS','FACEBOOK');" target="_blank"
								href="/#facebook" rel="nofollow noopener"><span
								class="a2a_svg a2a_s__default a2a_s_facebook"
								style="background-color: rgb(24, 119, 242);"><svg
										focusable="false" aria-hidden="true"
										xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32">
										<path fill="#FFF"
											d="M17.78 27.5V17.008h3.522l.527-4.09h-4.05v-2.61c0-1.182.33-1.99 2.023-1.99h2.166V4.66c-.375-.05-1.66-.16-3.155-.16-3.123 0-5.26 1.905-5.26 5.405v3.016h-3.53v4.09h3.53V27.5h4.223z"></path></svg></span><span
								class="a2a_label">Facebook</span></a> <a class="a2a_button_twitter"
								onclick="GA_Event('상품_상세','공유_SNS','TWITTER');" target="_blank"
								href="/#twitter" rel="nofollow noopener"><span
								class="a2a_svg a2a_s__default a2a_s_twitter"
								style="background-color: rgb(29, 155, 240);"><svg
										focusable="false" aria-hidden="true"
										xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32">
										<path fill="#FFF"
											d="M28 8.557a9.913 9.913 0 01-2.828.775 4.93 4.93 0 002.166-2.725 9.738 9.738 0 01-3.13 1.194 4.92 4.92 0 00-3.593-1.55 4.924 4.924 0 00-4.794 6.049c-4.09-.21-7.72-2.17-10.15-5.15a4.942 4.942 0 00-.665 2.477c0 1.71.87 3.214 2.19 4.1a4.968 4.968 0 01-2.23-.616v.06c0 2.39 1.7 4.38 3.952 4.83-.414.115-.85.174-1.297.174-.318 0-.626-.03-.928-.086a4.935 4.935 0 004.6 3.42 9.893 9.893 0 01-6.114 2.107c-.398 0-.79-.023-1.175-.068a13.953 13.953 0 007.55 2.213c9.056 0 14.01-7.507 14.01-14.013 0-.213-.005-.426-.015-.637.96-.695 1.795-1.56 2.455-2.55z"></path></svg></span><span
								class="a2a_label">Twitter</span></a> <a
								href="javascript:fnSharePin(&quot;http://www.thehandsome.com/ko/HANDSOME/MEN/PANTS/%EC%A1%B0%EA%B1%B0-%ED%8A%B8%EB%9E%99/%5BSET%5D-%EC%9A%B8-%EC%A1%B0%EA%B1%B0-%ED%8C%AC%EC%B8%A0/p/TH2CBKPC033M_BK&quot;);"
								class="pinterest"
								onclick="GA_Event('상품_상세','공유_SNS','PRINTEREST');"></a> <input
								type="hidden" id="url"
								value="http://www.thehandsome.com/ko/HANDSOME/MEN/PANTS/%EC%A1%B0%EA%B1%B0-%ED%8A%B8%EB%9E%99/%5BSET%5D-%EC%9A%B8-%EC%A1%B0%EA%B1%B0-%ED%8C%AC%EC%B8%A0/p/TH2CBKPC033M_BK">
							<div style="clear: both;"></div>
						</div>



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

	<!--상품평 리스트 팝업-->
	<div class="popwrap w_type_4" id="customerReviewDiv"
		style="display: none;">
		<!--마일리지 안내영역 1906 -->
		<div class="mileage_info_wrap1906">
			<p class="wrap_heading">상품평 작성 시 추가 마일리지를 드려요!</p>
			<div class="mileage_info_box">
				<div class="review_w">
					<p class="review_w_tit">• 온라인 구매 상품평 작성 시</p>
					<ul>
						<li>
							<div class="ico_mileage1906">정상상품</div>
							<p>
								<strong>정상상품</strong><br>구매금액의 <b>0.5%</b>
							</p>
						</li>
						<li>
							<div class="ico_mileage1906">아울렛상품</div>
							<p>
								<strong>아울렛상품</strong><br>구매금액의 <b>0.1%</b>
							</p>
						</li>
						<li>
							<div class="ico_mileage1906">포토상품평</div>
							<p>
								<strong>포토상품평</strong><br>(상품별 최초)<br> <b>2,000마일리지</b>
							</p>
						</li>
					</ul>
				</div>
				<div class="best_review">
					<p class="review_w_tit">• 온라인/오프라인 구매</p>
					<ul>
						<li>
							<div class="ico_mileage1906">베스트리뷰</div>
							<p>
								<strong>베스트리뷰</strong><br>매월 5명 <b>10만원</b> 바우처
							</p>
						</li>
					</ul>
				</div>
			</div>
			<div class="noti_box" style="display: none;">
				<ul class="bul_sty01_li">
					<li>마일리지는 배송 완료일로부터 30일 이내, 작성한 상품평에 한하여 제공됩니다.</li>
					<li>상품평 작성 시, 제공되는 추가 마일리지는 온라인에서 구입한 상품에 한하여 제공됩니다.</li>
					<li>베스트 리뷰는 온라인/오프라인에서 구매한 상품의 상품평 전체를 대상으로 선정합니다.</li>
					<li>할인, 쿠폰 적용 후 실결제금액이 5,000원 이상인 상품에 한하여 지급됩니다.</li>
					<li>판매가 종료된 상품의 경우, 상품 상세페이지가 소멸되어 상품평 작성 및 마일리지 적립이 불가능합니다.</li>
				</ul>
			</div>
			<div class="btn_noti_box">
				<span>자세히 보기</span>
			</div>
		</div>
		<!--//마일리지 안내영역 1906 -->
		<div class="pop_tltwrap2 pb0 customerreviewdiv1905">

			<h3>
				상품평(<span id="review_cnt" class="review_cnt">0</span>)
			</h3>
			<div class="star_score1807" id="totalStarScoreWrapper">
				<span class="cmt_star"> <!-- 별점에 따라 class명 변경 (star1, star2 ,star3, star4, star5) -->
					<span class="cmt_per" id="totalStarScore">별점</span>
				</span>
			</div>
			<a href="#;" class="btn_evaluation1905" id="customerReviewWrite"
				onclick="GA_Event('상품평','상품평 작성하기','클릭');">상품평 작성하기</a>
		</div>
		<!-- pop_cnt-->
		<div class="pop_cnt evaluation_list1807 options">
			<div class="tab_a m3 mt20">
				<input type="hidden" id="review_tab_active" value="ALL">
				<ul id="review_tab">
					<li id="ALL"><a href="#;" class="active"
						onclick="GA_Event('상품평','탭','전체');">전체 (0)</a></li>
					<li id="PHOTO"><a href="#;" class=""
						onclick="GA_Event('상품평','탭','포토상품평');">포토 상품평 (0)</a></li>
					<li id="TEXT"><a href="#;"
						onclick="GA_Event('상품평','탭','일반상품평');">일반 상품평 (0)</a></li>
				</ul>
			</div>
			<div class="clearfix review_tab1_1807">
				<ul></ul>
			</div>
			<!-- paging -->
			<div class="paging mt30" id="reviewPagingDiv"></div>
			<!-- //paging -->
		</div>
		<!--// pop_cnt-->
		<a href="javascript:void(0);" class="btn_close"><img
			src="http://cdn.thehandsome.com/_ui/desktop/common/images/popup/ico_close.png"
			alt="닫기"></a>
	</div>
	<!--//상품평 리스트 팝업 -->

	<!--상품평 쓰기 팝업 -->
	<div class="popwrap w_type_4" id="customerReviewWriteDiv"
		style="display: none;">
		<div class="pop_tltwrap2 customerreviewwritediv1807">
			<h3 id="review_title">상품평 작성하기</h3>
			<p class="reqd_txt float_right">
				<strong class="reqd">*</strong> 표시는 필수항목입니다.
			</p>
		</div>
		<div class="pop_cnt evaluation_write1905 options1811">
			<form id="reviewForm" name="reviewForm"
				action="/ko/HANDSOME/MEN/PANTS/%EC%A1%B0%EA%B1%B0-%ED%8A%B8%EB%9E%99/%5BSET%5D-%EC%9A%B8-%EC%A1%B0%EA%B1%B0-%ED%8C%AC%EC%B8%A0/p/TH2CBKPC033M_BK"
				method="post" enctype="multipart/form-data">
				<input type="hidden" name="productCode"> <input
					type="hidden" name="productCodeType"> <input type="hidden"
					name="orderNumber" id="orderNumber" value=""> <input
					type="hidden" name="purchaseColor" id="purchaseColor" value="">
				<input type="hidden" name="purchaseColorName" id="purchaseColorName"
					value=""> <input type="hidden" name="purchaseSize"
					id="purchaseSize" value=""> <input type="hidden"
					name="purchaseProdYN" id="purchaseProdYN" value=""> <input
					type="hidden" name="orderWriteChk" id="orderWriteChk" value="">
				<input type="hidden" name="closeWriteChk" id="closeWriteChk"
					value=""> <input type="hidden" name="productId"
					id="productId" value=""> <input type="hidden"
					name="fileDeleteYN" id="fileDeleteYN">

				<!-- 상품평활성화 -->
				<input type="hidden" name="categoryCode" id="categoryCode"
					value="SZ11"> <input type="hidden" name="shoulderWidth"
					id="shoulderWidth" value=""> <input type="hidden"
					name="chestSize" id="chestSize" value=""> <input
					type="hidden" name="waistSize" id="waistSize" value=""> <input
					type="hidden" name="buttSize" id="buttSize" value=""> <input
					type="hidden" name="totalSize" id="totalSize" value=""> <input
					type="hidden" name="photoAccumulationRightYn"
					id="photoAccumulationRightYn" value=""> <input
					type="hidden" name="offlineOrdDt" id="offlineOrdDt" value="">
				<input type="hidden" name="offlineShpCd" id="offlineShpCd" value="">
				<input type="hidden" name="offlineShpNm" id="offlineShpNm" value="">
				<input type="hidden" name="tempProductId" id="tempProductId"
					value=""> <input type="hidden" name="reviewFileCd"
					id="reviewFileCd" value=""> <input type="hidden"
					name="reviewFileCd1" id="reviewFileCd1" value=""> <input
					type="hidden" name="reviewFileCd2" id="reviewFileCd2" value="">
				<input type="hidden" name="reviewFileCd3" id="reviewFileCd3"
					value=""> <input type="hidden" name="reviewFileCd4"
					id="reviewFileCd4" value="">
				<fieldset>
					<legend>상품평쓰기</legend>
					<div class="tblwrap">
						<table class="tbl_wtype1">
							<caption>상품평쓰기 입력항목</caption>
							<colgroup>
								<col style="width: 135px">
								<col>
								<col style="width: 130px">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row" class="th_space">상품명</th>
									<td colspan="3" style="padding: 15px;">
										<div class="item_box" id="reviewProductDiv">
											<div class="pt_list_all">
												<a href="#;"><img
													src="http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img1.jpg"
													id="reviewProducImg" alt="상품 이미지"
													onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img1.jpg'"></a>
												<div class="tlt_wrap review_header_wrapper">
													<!-- <div class="tlt_wrap review_header_wrapper nodata"> -->
													<a href="#;" class="basket_tlt"> <span class="tlt"
														id="reviewProductBrandName"></span> <span class="sb_tlt"
														id="reviewProductProductName"></span> / <span
														id="reviewProducPrice"></span>
													</a>
													<!-- 주문조회에서 넘어올시 이거 보여줌<p class="color_op" id="purchased_color_size" style="display:none;">COLOR : <span id="review_color_name"></span>   <span class="and_line">/</span>  SIZE : <span id="review_size"></span></p> -->
													<div class="select_options_wrap" style="display: none;">
														<ul class="select_options">
															<li class="select_colors">
																<p>
																	<span class="compulsory">*</span> 색상
																	<!-- 색상 -->
																</p>
																<ul class="color_chip clearfix">
																	<input type="hidden" id="colorName" value="BLACK">
																	<li id="TH2CBKPC033M_BK"><input type="hidden"
																		class="colorNameVal" value="BLACK"> <a
																		href="#;" class="beige" data-color="BLACK"
																		style="background: #000000 url('http://newmedia.thehandsome.com/TH/2C/FW/TH2CBKPC033M_BK_C01.jpg/dims/resize/24x24');"
																		onclick="javascript:fn_clickColorCode('TH2CBKPC033M_BK', 'BLACK');"
																		onmouseover="setColorName('BLACK');"
																		onmouseout="setColorName('');"></a></li>
																	<li id="TH2CBKPC033M_TG"><input type="hidden"
																		class="colorNameVal" value="Taupe Grey"> <a
																		class="beige" data-color="Taupe Grey"
																		style="background: #9b9595 url('http://newmedia.thehandsome.com/TH/2C/FW/TH2CBKPC033M_TG_C01.jpg/dims/resize/24x24');"
																		onclick="javascript:fn_clickColorCode('TH2CBKPC033M_TG', 'Taupe Grey');"
																		onmouseover="setColorName('Taupe Grey');"
																		onmouseout="setColorName('');"></a></li>
																	<li><span class="cl_name" id="colorNameContent"></span>
																	</li>
																</ul>
															</li>
															<li class="select_size">
																<p>
																	<span class="compulsory">*</span> 사이즈
																	<!-- 사이즈 -->
																</p>
																<ul class="size_chip clearfix" id="review_size_btn_area">
																	<li id="TH2CBKPC033M_BK_78"><a
																		onclick="javascript:fn_clickSizeCode('TH2CBKPC033M_BK_78');">78</a>
																		<productdetails:popupsizequickreference>
																		</productdetails:popupsizequickreference></li>
																	<li id="TH2CBKPC033M_BK_82"><a
																		onclick="javascript:fn_clickSizeCode('TH2CBKPC033M_BK_82');">82</a>
																	</li>
																	<li id="TH2CBKPC033M_BK_86"><a
																		onclick="javascript:fn_clickSizeCode('TH2CBKPC033M_BK_86');">86</a>
																	</li>
																</ul> <!-- <ul class="size_chip clearfix">
                                                                    <li id="MN1IBKTO483W_MB_90">
                                                                        <a href="javascript:fn_detailProductAjax('MN1IBKTO483W_MB_90')">90</a>
                                                                    </li>
                                                         </ul> -->
															</li>
														</ul>
													</div>

													<!-- <div class="select_checkbox">
                                                        <input type="checkbox" name="" value="" id="storePickTFC">
                                                        <label for="storePickTFC">상품을 매장에서 구매하셨나요?</label>
                                                    </div> -->
												</div>
												<!--20190529_selelct_group -->
												<div class="select_group" id="productOption"
													style="display: none;"></div>
												<!--//20190529_selelct_group -->
												<div class="select_checkbox" style="display: none;">
													<input type="checkbox" id="packopt" name="packopt">
													<label for="purchaseYN"> 매장에서 구매한 상품입니다.</label>
												</div>
											</div>
										</div>
									</td>
								</tr>
								<tr class="tbl_blank1807">
									<td colspan="4">&nbsp;</td>
								</tr>
								<tr class="radio_btn_1905 bk">
									<th scope="row" class="th_space">연 령</th>
									<td colspan="3"><input id="ageG1" type="radio" name="age"
										value="18세 이하"> <label for="ageG1">18세 이하</label> <input
										id="ageG2" type="radio" name="age" value="20대"> <label
										for="ageG2">20대</label> <input id="ageG3" type="radio"
										name="age" value="30대"> <label for="ageG3">30대</label>
										<input id="ageG4" type="radio" name="age" value="40대">
										<label for="ageG4">40대</label> <input id="ageG5" type="radio"
										name="age" value="50대"> <label for="ageG5">50대</label>
										<input id="ageG6" type="radio" name="age" value="60대 이상">
										<label for="ageG6">60대 이상</label></td>
								</tr>
								<tr class="input_txt_1905">
									<th scope="row" class="th_space" id="thHeight"><strong
										class="reqd">*</strong> 키</th>
									<td><input type="text" name="height" id="height"
										style="width: 75%; margin-right: 10px">cm</td>
									<th scope="row" class="th_space" id="thEnjoySize"><strong
										class="reqd">*</strong> 평소 사이즈</th>
									<td><input type="text" name="enjoySize" id="enjoySize"></td>
								</tr>
								<tr class="radio_btn_1905">
									<th scope="row" class="th_space" id="thBodyType"><strong
										class="reqd">*</strong> 체 형</th>
									<td colspan="3"><input id="dark1" type="radio"
										name="bodyType" value="마른 체형"> <label for="dark1">마른
											체형</label> <input id="dark2" type="radio" name="bodyType" value="보통">
										<label for="dark2">보통</label> <input id="dark3" type="radio"
										name="bodyType" value="통통한 체형"> <label for="dark3">통통한
											체형</label></td>
								</tr>
								<tr class="tbl_blank1807">
									<td colspan="4">&nbsp;</td>
								</tr>
								<tr class="write_star_wrap">
									<th colspan="4">
										<div class="write_star_score1807">
											<span class="cmt_star"> <span class="cmt_per star5">별점</span>
											</span>
											<ul class="btn_star_score">
												<li><a href="#;" value="1">1점</a></li>
												<li><a href="#;" value="2">2점</a></li>
												<li><a href="#;" value="3">3점</a></li>
												<li><a href="#;" value="4">4점</a></li>
												<li><a href="#;" value="5">5점</a></li>
												<input type="hidden" id="rating" name="rating" value="5">
											</ul>
											<p>평점을 선택해 주세요.</p>
										</div>
									</th>
								</tr>
								<tr>
									<th scope="row" class="th_space"><strong class="reqd">*</strong>실
										착용 사이즈</th>
									<td colspan="3">
										<!--20190529_상품평활성화-->
										<div class="cont_detail">
											<p class="left_txt">허리둘레 :</p>
											<ul class="rd_box_radio_list">
												<li><input id="realWearSize1_01" type="radio"
													name="realWearSize1" value="1"> <label
													for="realWearSize1_01">타이트함</label></li>
												<li><input id="realWearSize1_02" type="radio"
													name="realWearSize1" value="2"> <label
													for="realWearSize1_02">적당함</label></li>
												<li><input id="realWearSize1_03" type="radio"
													name="realWearSize1" value="3"> <label
													for="realWearSize1_03">여유있음</label></li>
											</ul>
										</div>
										<div class="cont_detail">
											<p class="left_txt">엉덩이둘레 :</p>
											<ul class="rd_box_radio_list">
												<li><input id="realWearSize2_01" type="radio"
													name="realWearSize2" value="1"> <label
													for="realWearSize2_01">타이트함</label></li>
												<li><input id="realWearSize2_02" type="radio"
													name="realWearSize2" value="2"> <label
													for="realWearSize2_02">적당함</label></li>
												<li><input id="realWearSize2_03" type="radio"
													name="realWearSize2" value="3"> <label
													for="realWearSize2_03">여유있음</label></li>
											</ul>
										</div>
										<div class="cont_detail">
											<p class="left_txt">총길이 :</p>
											<ul class="rd_box_radio_list">
												<li><input id="realWearSize3_01" type="radio"
													name="realWearSize3" value="1"> <label
													for="realWearSize3_01">짧은 편</label></li>
												<li><input id="realWearSize3_02" type="radio"
													name="realWearSize3" value="2"> <label
													for="realWearSize3_02">적당함</label></li>
												<li><input id="realWearSize3_03" type="radio"
													name="realWearSize3" value="3"> <label
													for="realWearSize3_03">긴 편</label></li>
											</ul>
										</div> <!--//20190529_상품평활성화-->
									</td>
								</tr>
								<tr>
									<th scope="row" class="th_space"><strong class="reqd">*</strong>실
										제품 색상</th>
									<td colspan="3"><input id="dark" type="radio"
										name="realProductColor" value="1"> <label for="dark">어두워요</label>
										<input id="same" type="radio" name="realProductColor"
										class="ml20" value="2"> <label for="same">화면과
											같아요</label> <input id="light" type="radio" name="realProductColor"
										class="ml20" value="3"> <label for="light">밝아요</label>
									</td>
								</tr>
								<tr>
									<th scope="row"><strong class="reqd"
										style="margin-top: 6px;">*</strong> <label for="lb1"
										style="margin-top: 6px;">상품평<br> <span
											class="subtxt_1905"> (20자 이상<br>&nbsp;200자 이하)
										</span>
									</label></th>
									<td colspan="3"><textarea id="reviewHeadline"
											name="headline" cols="30" rows="5"
											style="width: 98%; height: 78px" maxlength="200"></textarea>
									</td>
								</tr>
								<tr>
									<th scope="row" id="thFile" class="th_space"><label
										for="file">사진등록</label></th>
									<td colspan="3">
										<!-- File upload -->
										<div class="file_upload hs_input_file_wrap2003">
											<div class="upload_wrap2003">
												<input type="text" id="textReviewFile" class="text"
													title="파일 첨부하기" readonly="readonly" name="fileText">
												<div class="upload_btn">
													<input type="file" name="reviewFile" id="reviewFile"
														class="btn add_s" title="파일찾기"> <label
														for="reviewFile"> <!-- 	 <button type="button" id="uploadFile1" class="img_upload" title="파일찾기">  -->
														<span id="uploadFile1" class="img_upload">파일찾기</span> <!--	 </button> -->
													</label>

												</div>
											</div>
											<ul class="file_image_wrap2003">

											</ul>
											<p class="txt_guide">10MB 미만의 jpg,gif,png 파일만 첨부하실 수
												있습니다.</p>
											<!-- //File upload -->
										</div>
									</td>
								</tr>
							</tbody>
						</table>
						<p class="txt_guide">
							<span style="color: #e46764; font-weight: bold;">- 상품평과
								무관한 내용이거나 상품 재판매, 광고, 동일 문자의 반복 및 기타 불법적인 내용은 통보 없이 삭제되며,<br>&nbsp;&nbsp;해당
								글 작성자 ID는 글쓰기 권한이 제한됩니다.
							</span><br>- 반품, 취소 등의 CS관련 글은 고객센터&gt;1:1문의로 이동될 수 있습니다.<br>
							<span>- 더한섬닷컴에서 구매한 상품의 상품평을 배송완료 30일 이내 작성 시, 추가 마일리지를
								지급합니다.</span><br> - 마일리지 지급에 대한 상세 내용은 마이페이지&gt;내 상품평 페이지에서 확인
							부탁드립니다.<br> &nbsp;&nbsp;(마일리지 적립은 오프라인 구매 및 간편회원 제외)
						</p>
					</div>
					<div class="btnwrap mt40">
						<input type="button" id="reviewCancle" value="취소하기" class="btn wt">
						<input type="button" id="reviewWriteSend" value="등록하기"
							class="btn gray mr0">
					</div>

				</fieldset>
				<div>
					<input type="hidden" name="CSRFToken"
						value="7399b544-9191-4d49-af3a-9a782a52adc4">
				</div>
			</form>
		</div>
		<a href="javascript:void(0);" id="reviewCloseBtn"
			style="position: absolute; top: 20px; right: 20px; width: 20px; height: 20px;"><img
			src="http://cdn.thehandsome.com/_ui/desktop/common/images/popup/ico_close.png"
			alt="닫기"></a>
	</div>
	<!--//상품평 쓰기 팝업 -->
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

	<div class="popwrap w_type_4" id="productQnADiv" style="display: none;">

		<div class="pop_tltwrap2 pb0">
			<h3>Q&amp;A</h3>
		</div>
		<div class="pop_cnt evaluation_list">
			<a href="javascript:fn_popupProductQnAWrite();"
				class="btn_evaluation" id="productQnAWrite">상품문의하기</a>
			<div class="clearfix">
				<table class="pop_tbl_ltype1">
					<caption>Q&amp;A</caption>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">Q&amp;A</th>
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
		<a href="javascript:fn_closeProductQnA();" id="qnAcloseBtn"
			class="btn_close"><img
			src="http://cdn.thehandsome.com/_ui/desktop/common/images/popup/ico_close.png"
			alt="닫기"></a>
	</div>


	<div class="popwrap w_type_3" id="productQnAWriteDiv"
		style="display: none;">
		<div class="pop_tltwrap2">
			<h3>상품문의하기</h3>
		</div>
		<div class="pop_cnt evaluation_write">
			<form id="productQnAForm" name="productQnAForm"
				action="/ko/HANDSOME/MEN/PANTS/%EC%A1%B0%EA%B1%B0-%ED%8A%B8%EB%9E%99/%5BSET%5D-%EC%9A%B8-%EC%A1%B0%EA%B1%B0-%ED%8C%AC%EC%B8%A0/p/TH2CBKPC033M_BK"
				method="post" enctype="multipart/form-data">
				<input type="hidden" id="productCode" name="productCode"> <input
					type="hidden" id="productQnaCode" name="productQnaCode"> <input
					type="hidden" id="delAttach" name="delAttach" value="N">
				<fieldset>
					<legend>상품문의하기</legend>
					<div class="tblwrap">
						<p class="reqd_txt float_right">
							<strong class="reqd">*</strong> 표시는 필수항목입니다.
						</p>
						<table class="tbl_wtype1">
							<caption>상품문의하기 입력항목</caption>
							<colgroup>
								<col width="140px">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><strong class="reqd">*</strong><label
										for="inquiryTitle">문의제목</label></th>
									<td><input type="text" id="inquiryTitle"
										name="inquiryTitle" title="input" style="width: 100%">
									</td>
								</tr>
								<tr>
									<th scope="row"><strong class="reqd">*</strong><label
										for="inquiryContents">문의내용</label><span class="com_txt_p">(300자
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
											<input type="text" id="textQnAFile" class="text" title="파일찾기"
												readonly="readonly" name="fileText"> <a
												href="javascript:void(0);" id="delQnAFile"> <img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/popup/ico_close.png"
												alt="파일삭제">
											</a>
											<div class="upload_btn">
												<label for="qnaFile"><button type="button"
														id="uploadFile" class="img_upload" title="파일찾기">
														<span>파일찾기</span>
													</button></label> <input type="file" id="qnaFile" name="uploadFile"
													class="btn add_s" title="파일찾기">
											</div>
										</div> <!-- //File upload -->
										<p class="txt_guide">10MB 미만의 jpg,gif,png 파일만 첨부하실 수 있습니다.</p>
									</td>
								</tr>
								<tr>
									<th scope="row" class="th_space"><label
										for="inquiryMobileNo2">SMS 알림받기</label></th>
									<td>
										<div style="position: relative;">
											<input type="hidden" id="smsMobileNo" name="smsMobileNo">
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
												style="width: 80px;" maxlength="4">
											<div class="form_hyphen">-</div>
											<input type="text" id="inquiryMobileNo3"
												name="inquiryMobileNo3" title="휴대폰 번호 뒷자리"
												style="width: 80px;" maxlength="4"> <span
												class="sms_alm_2006_chk"
												style="display: block; position: absolute; top: 3px; right: 14px;">
												<input type="hidden" id="smsNoticeYN" name="smsNoticeYN"
												value="N"> <input type="checkbox"
												id="inquirySmsNoticeYn" name="inquirySmsNoticeYn"
												style="margin-top: 1px;"> <label
												for="inquirySmsNoticeYn">SMS 알람고지</label>
											</span>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="inquiryEmailAddress"><strong
											class="reqd">*</strong><label for="inquiryMobileNo2">이메일
												답변받기</label></label></th>
									<td><input type="hidden" id="replyToEmail"
										name="replyToEmail"> <input type="text"
										id="inquiryEmailAddress" name="inquiryEmailAddress"
										title="이메일아이디" style="width: 120px;"> <span
										class="andmail">@</span> <input type="text"
										id="inquiryEmailDomain" name="inquiryEmailDomain"
										title="이메일계정 입력란" style="width: 120px;"> <select
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
						<span class="float_left"><strong>상품에 관한 배송, 교환, 취소
								등의 자세한 문의사항은 고객센터를 이용해 주시기 바랍니다.</strong></span> <span class="float_right">
							<input type="checkbox" name="securitySentenceYn"
							id="securitySentenceYn" value="Y"> <label
							for="securitySentenceYn">비밀글 설정</label>
						</span>
					</p>
					<div class="btnwrap mt40">
						<input type="button" id="qnaCancle" value="취소하기" class="btn wt">
						<input type="button" id="qnaWriteSend" value="등록하기"
							class="btn gray mr0">
					</div>
				</fieldset>
				<div>
					<input type="hidden" name="CSRFToken"
						value="7399b544-9191-4d49-af3a-9a782a52adc4">
				</div>
			</form>
		</div>
		<a href="javascript:fn_closeProductQnAWrite();" class="btn_close"><img
			src="http://cdn.thehandsome.com/_ui/desktop/common/images/popup/ico_close.png"
			alt="닫기"></a>
	</div>



	<!-- 211101 체험단 리뷰 추가 S -->
	<!-- 체험단 상품평 리스트-->
	<div class="popwrap w_type_4 pop-tester-review" id="testerReviewDiv"
		style="display: none;">
		<div class="pop_tltwrap2 pb0 customerreviewdiv1905">
			<h3>
				체험단(<span class="review_cnt">15</span>)
			</h3>
			<p>더한섬닷컴 체험단 이벤트에 당첨된 고객님들의 상품 사용 후기입니다.</p>
		</div>
		<!-- pop_cnt-->
		<div class="pop_cnt evaluation_list1807 options">
			<div class="clearfix review_tab1_1807">
				<ul>
					<!-- 1 -->
					<li class="evaluation_view">
						<div class="member_info_bottom">
							<ul>
								<li class="choice">• <span>장*윤</span> / <span>30대</span> /
									<span>민감성</span>
								</li>
							</ul>
						</div> <!--리뷰이미지 영역 (이미지 없으면 영역 삭제)-->
						<div class="review_represent_img1912">
							<img
								src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/01/pc_1.jpg"
								alt="리뷰 이미지">
							<div class="img_count191212">
								<span class="img_count191212_inner">+</span>
							</div>
						</div>
						<div class="review_img_wrap review_img_cont191216"
							id="testerReviewImg_0">
							<ul class="slides reviewImg0">
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/01/pc_1.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/01/pc_2.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/01/pc_3.gif"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/01/pc_4.gif"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/01/pc_5.gif"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/01/pc_6.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/01/pc_7.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
							</ul>
							<div class="controls">
								<span class="prev"></span> <span class="next"></span>
							</div>
							<div class="bx_pager191219">
								<a class="bx-pager-link" data-slide-index="0" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="1" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="2" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="3" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="4" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="5" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="6" href="#;"></a>
							</div>
						</div> <!--//리뷰이미지 영역 -->
						<div class="review_txt_wrap">
							<p class="review_txt">
								열흘 정도 써본 한섬의 럭셔리 뷰티 oera♥ <br> 세안 후 솜으로 닦아내지 않으면 마무리가 되지 않은
								느낌인데, 오에라의 캘리브레이터로 스킨 대신 첫 단계로 써보니 피부가 한결 정리된 기분. 그리고 무엇보다 울긋불긋한
								톤이 균일해졌다! 특히 전용 패드가 너~무 좋아서 감동. <br> 세심하게 만든게 느껴지는 오에라의
								캘리브레이터 꾸준히 쓰면 올 여름 상한 피부가 다시 돌아올 것 같아~
							</p>
						</div>
						<div class="review_more_1807">
							<a href="#;">리뷰 더보기</a>
						</div>
					</li>
					<!-- 2 -->
					<li class="evaluation_view">
						<div class="member_info_bottom">
							<ul>
								<li class="choice">• <span>이*주</span> / <span>30대</span> /
									<span>복합-민감성</span>
								</li>
							</ul>
						</div> <!--리뷰이미지 영역 (이미지 없으면 영역 삭제)-->
						<div class="review_represent_img1912">
							<img
								src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/02/pc_1.jpg"
								alt="리뷰 이미지">
							<div class="img_count191212">
								<span class="img_count191212_inner">+</span>
							</div>
						</div>
						<div class="review_img_wrap review_img_cont191216"
							id="testerReviewImg_1">
							<ul class="slides">
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/02/pc_1.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/02/pc_2.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/02/pc_3.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/02/pc_4.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/02/pc_5.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/02/pc_6.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/02/pc_7.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
							</ul>
							<div class="controls">
								<span class="prev"></span> <span class="next"></span>
							</div>
							<div class="bx_pager191219">
								<a class="bx-pager-link" data-slide-index="0" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="1" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="2" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="3" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="4" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="5" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="6" href="#;"></a>
							</div>
						</div> <!--//리뷰이미지 영역 -->
						<div class="review_txt_wrap">
							<p class="review_txt">
								오에라의 멀티-베네핏 캘리브레이터는 전용 패드 120매와 80ml의 본품이 함께 구성되어 있습니다. <br>
								한 손으로 다 잡히지 않는, 넉넉한 용량입니다. 은빛의 고급스러운 패키지가 눈에 띕니다. <br> 용기는
								펌핑형으로, 무게감이 적당해 사용이 편리했습니다. <br> 제품을 펌핑하여 페이스에 사용하기 전부터 향에서
								깊은 인상을 받을 수 있었습니다. 스킨케어 첫 단계에서 사용하는 제품인 만큼, 휴식과 안정의 느낌을 선사하는
								향이라는 느낌이 듭니다.<br> 멀티-베네핏 캘리브레이터는 묽게 흐르는 제형이지만, 피부에 금방 흡수되며
								촉촉한 느낌입니다. <br> 전용 패드는 한쪽에 엠보가 도드라지며, 다른 한 쪽은 좀더 부드러운
								느낌입니다. 부드러운 패드 반대 쪽 면에 묻혀 사용하니 진정과 수분 공급에 탁월한 효과를 볼 수 있었습니다. <br>
								탄력이 조금 더 신경 쓰이는 날에는 패드에 캘리브레이터를 넉넉히 묻혀 팩처럼 활용하기도 했습니다. 시간이 지나
								패드를 떼어 내면 눈에 띄게 촉촉해지고 쫀쫀해진 피부 때문에 자꾸 손이 가는 제품입니다.<br> 사용하며
								가장 인상적이었던 점은 자극없이 피부에 생기를 불어넣어 준다는 점입니다. 복합성에 민감성 피부인 제가 민감한 부위에
								제품을 덧바르더라도 자극이 전혀 느껴지지 않았습니다. <br> 2주 동안 캘리브레이터를 사용하며 스킨
								토너를 사용할 때보다 수분이 충전되는 느낌을 받았습니다.<br> 캘리브레이터는 기초 첫 단계에서 단독
								사용하더라도, 토너 뿐만 아니라 에센스의 역할까지도 훌륭히 해내는 듯합니다. 역할까지도 훌륭히 해내는 듯합니다.
							</p>
						</div>
						<div class="review_more_1807">
							<a href="#;">리뷰 더보기</a>
						</div>
					</li>
					<!-- 3 -->
					<li class="evaluation_view">
						<div class="member_info_bottom">
							<ul>
								<li class="choice">• <span>최*정</span> / <span>30대</span> /
									<span>민감성</span>
								</li>
							</ul>
						</div> <!--리뷰이미지 영역 (이미지 없으면 영역 삭제)-->
						<div class="review_represent_img1912">
							<img
								src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/03/pc_1.jpg"
								alt="리뷰 이미지">
							<div class="img_count191212">
								<span class="img_count191212_inner">+</span>
							</div>
						</div>
						<div class="review_img_wrap review_img_cont191216"
							id="testerReviewImg_2">
							<ul class="slides">
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/03/pc_1.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/03/pc_2.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/03/pc_3.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/03/pc_4.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/03/pc_5.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/03/pc_6.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
							</ul>
							<div class="controls">
								<span class="prev"></span> <span class="next"></span>
							</div>
							<div class="bx_pager191219">
								<a class="bx-pager-link" data-slide-index="0" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="1" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="2" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="3" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="4" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="5" href="#;"></a>
							</div>
						</div> <!--//리뷰이미지 영역 -->
						<div class="review_txt_wrap">
							<p class="review_txt">
								한섬의 프리미엄 스킨케어 브랜드라 해서 넘나 기대가 되었는데요, 포장 상태도 마음에 들었고 케이스도 고급스러운
								디자인이라, 엄마 선물로도 좋을 것 같아요! <br> 처음에는 큰 박스가 와서 왜 이렇게 큰가 했더니,
								캘리브레이터랑, 캘리브레이터 전용 패드가 같이 들어가 있었어요!<br> 제가 피부가 예민한 편이라, 많은
								성분과 기능을 담은 제품은 사용하기 무서워하는 편인데, 오에라 켈리브레이터는 사용 후에 자극이나 가려움이 느껴지지
								않아서 좋았어요! <br> 왜 패드가 포함되어 있나 했더니, 패드를 활용해서 피부결을 정돈하는 단계가 첫
								단계더라구요! 패드는 촘촘하지 않은 독특한 재질로 되어 있어요! 피부결을 따라 닦아내듯 발라주면 된답니다!<br>
								캘리브레이터 전용 패드를 이용해서 피부결을 닦아낸 후에는, 손바닥에 적당량을 펌핑한 후에 피부에 지그시 누르듯
								흡수시켜주면 된답니다! 용기는 펌핑형으로 되어 있어서 위생적으로 사용하기 좋답니다!ㅎㅎ <br> 제형은
								흐르는 물 같은 제형에, 향은 딱 맡아도 고급스러운 향이 나더라구요. 자연스러운 향이다보니 호불호가 크게 갈리지
								않고 사용할 수 있을 것 같았답니다!<br> 무엇보다 흡수력이 빠르고, 얼굴에 두껍게 발리는 느낌이
								아니여서 산뜻한 느낌이 났어요! <br> 아침저녁으로 사용중인데,촉촉한 느낌이 지속되어서 계속 꾸준히
								사용해볼 생각이랍니다!
							</p>
						</div>
						<div class="review_more_1807">
							<a href="#;">리뷰 더보기</a>
						</div>
					</li>
					<!-- 4 -->
					<li class="evaluation_view">
						<div class="member_info_bottom">
							<ul>
								<li class="choice">• <span>박*영</span> / <span>30대</span> /
									<span>건성</span>
								</li>
							</ul>
						</div> <!--리뷰이미지 영역 (이미지 없으면 영역 삭제)-->
						<div class="review_represent_img1912">
							<img
								src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/04/pc_1.jpg"
								alt="리뷰 이미지">
							<div class="img_count191212">
								<span class="img_count191212_inner">+</span>
							</div>
						</div>
						<div class="review_img_wrap review_img_cont191216"
							id="testerReviewImg_3">
							<ul class="slides">
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/04/pc_1.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/04/pc_2.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/04/pc_3.gif"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/04/pc_4.gif"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/04/pc_5.gif"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/04/pc_6.gif"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
							</ul>
							<div class="controls">
								<span class="prev"></span> <span class="next"></span>
							</div>
							<div class="bx_pager191219">
								<a class="bx-pager-link" data-slide-index="0" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="1" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="2" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="3" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="4" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="5" href="#;"></a>
							</div>
						</div> <!--//리뷰이미지 영역 -->
						<div class="review_txt_wrap">
							<p class="review_txt">
								한 박스에는 "오에라 멀티 베네핏 캘리브레이터"가 있었고, 나머지 한 박스는 전용 패드가 들어있다. <br>
								전용 패드는 일반 화장솜이 아니었다.내 얼굴의 숨은 각질을 한번에 닦아버리겠다는 포부가 그대로 느껴지는 질감!<br>
								어떤 질감인지, 어떤 색인지 전혀 정보가 없는 채 꾹꾹 눌러보니....액체에 가까운 질감이 손등을 타고 흐른다.<br>
								손등에 문질러보니 끈적임이 1도 남아있지 않았다. 바르지 않은 손등과 비교해보면, 광택과 확연히 비교가 된다.<br>
								자연스럽게 손등이 코로 가는데, 향이 인위적인 느낌이 없이 너무 좋았다. <br> 비싸보이는 화장솜에다가
								멀티 베네핏 캘리브레이터를 몇번 펌프해준다. 기존에 쓰던 스킨을 화장솜에 묻혀 일단 피부결을 정돈하고 전용 패드에
								적당양 오에라 멀티 베네핏 캘리브레이터를 뿌려 다시 닦아낸다. <br> 특히, 거칠거칠하던 턱 주변과 볼을
								더 집중적으로 닦아냈다. 일반 화장솜과 다르게 표면이 거칠해서 뭔가 각질이 잘 닦이는 느낌이 들었다. 왜 전용패드를
								함께 패키지로 파는지 알 것 같았다. 전용패드 다쓰면 꼭 다시 사고 싶다.<br> 그 다음날 아침과
								저녁세안 후에도 역시 사용을 해본 결과 볼을 만져보니 확실히 부드러워졌다. 정말 제대로 느껴졌다. 괜히 '피부톤
								개선, 피부결 개선, 피부 탄력' 에 좋다고 한게 아니었다. 계속 부드러운 얼굴을 만져보게 된다 ㅋㅋㅋ<br>
								제품을 받고 사용한지 약 일주일째.. 이 제품을 이렇게 사용해보게 해준 한섬이 너무 고마워졌다. 일단 내 피부가
								요즘 거칠하다.. 팩을 해도 거칠다... 라고 고민하시는 분들은 오에라 멀티 베네핏 캘리브레이터 써보시길
								추천드린다.<br>
							</p>
						</div>
						<div class="review_more_1807">
							<a href="#;">리뷰 더보기</a>
						</div>
					</li>

					<!-- 5 -->
					<li class="evaluation_view">
						<div class="member_info_bottom">
							<ul>
								<li class="choice">• <span>오*선</span> / <span>40대</span> /
									<span>복합성</span>
								</li>
							</ul>
						</div> <!--리뷰이미지 영역 (이미지 없으면 영역 삭제)-->
						<div class="review_represent_img1912">
							<img
								src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/05/pc_1.jpg"
								alt="리뷰 이미지">
							<div class="img_count191212">
								<span class="img_count191212_inner">+</span>
							</div>
						</div>
						<div class="review_img_wrap review_img_cont191216"
							id="testerReviewImg_4">
							<ul class="slides">
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/05/pc_1.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/05/pc_2.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/05/pc_3.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/05/pc_4.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/05/pc_5.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/05/pc_6.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/05/pc_7.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
							</ul>
							<div class="controls">
								<span class="prev"></span> <span class="next"></span>
							</div>
							<div class="bx_pager191219">
								<a class="bx-pager-link" data-slide-index="0" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="1" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="2" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="3" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="4" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="5" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="6" href="#;"></a>
							</div>
						</div> <!--//리뷰이미지 영역 -->
						<div class="review_txt_wrap">
							<p class="review_txt">
								아침마다 세수할때 손끝에 느껴지는 부드러움을 알게해준 오에라! 한섬팬인데 오에라팬이 될거같아요. <br>
								첫째, 피부결이 일주일도 안되어 달라진걸 느꼈어요. <br> 실크처럼 부드럽다라는 말보다 더 좋은 표현을
								못찾겠어요. 아침저녁 사용하는데 손끝이 너무 행복해요<br> 둘째, 피부결이 정리되니 피부톤도 한결 고르게
								되고 밝아지는거 같아요.<br> 셋째, 주름개선은 조금 더 써보고 공유할수 있을거 같아요.<br>
								사용은 펌핑하고 들어있는 패드에 (한쪽은 결이있고, 반대쪽은 매끄러워요~결있는데로 쓱 밀어서 각질까지 케어하고,
								부드러운면으로 쓱 밀어서 피부결 살리고) 뭍혀서 얼굴결 정리하듯 쓱 발라주고, 한번더 펌핑해서 얼굴에 쏘옥~흡수하면
								되는데요, 피부에서 겉돌지 않고 쏘옥~흡수되서 사용도 넘넘 편하답니다.<br> 다른 에센스2배 짐승용량이라
								가치가 있는거 같아요.14일도 안되어 피부결 변화와, 14일이면 느껴지는 피부톤 정리까지!!! 최고예요
							</p>
						</div>
						<div class="review_more_1807">
							<a href="#;">리뷰 더보기</a>
						</div>
					</li>
					<!-- 6 -->
					<li class="evaluation_view">
						<div class="member_info_bottom">
							<ul>
								<li class="choice">• <span>송*희</span> / <span>40대</span> /
									<span>건성</span>
								</li>
							</ul>
						</div> <!--리뷰이미지 영역 (이미지 없으면 영역 삭제)-->
						<div class="review_represent_img1912">
							<img
								src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/06/pc_1.jpg"
								alt="리뷰 이미지">
							<div class="img_count191212">
								<span class="img_count191212_inner">+</span>
							</div>
						</div>
						<div class="review_img_wrap review_img_cont191216"
							id="testerReviewImg_5">
							<ul class="slides">
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/06/pc_1.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/06/pc_2.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
							</ul>
							<div class="controls">
								<span class="prev"></span> <span class="next"></span>
							</div>
							<div class="bx_pager191219">
								<a class="bx-pager-link" data-slide-index="0" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="1" href="#;"></a>
							</div>
						</div> <!--//리뷰이미지 영역 -->
						<div class="review_txt_wrap">
							<p class="review_txt">
								40대 중반에 가을이 되니 부석부석해진 피부가 좀 더 건강해졌으면 좋겠다는 바램이 생기더라구요. <br>
								건강하게 빛나는 피부, 좀 더 어려보이고건강해지고 싶다는 생각으로 피부과, 다양한 화장품, 팩등을 찾고 있던 중 운
								좋게 만난 오에라의 멀티-베네핏 캘리브레이터♡~ <br> 믿고 사용할 만한 스위스의 기술력과 연구과정으로
								탄생했다는 과학기술,크로노 엘릭서를 담은 캘리브레이터가 피부를 케어해주네요. <br> 세안후 앞 뒷면이
								다른 패드 중 더 거친 부분으로 에센스를 3~4방울을 얼굴 전체를 부드럽게 닦아줘요. 그것만으로도 각질이 정리되어
								피부결 톤을 정리가 되더라구요.<br> 한 번 더 수분감으로 채울 부분은 에센스 몇방울을 덜어 손가락으로
								살포시 눌러주면 최상의 컨디션으로 피부가 편안해지는 느낌.럭셔리리추얼스킨케어가 가능한 하이엔드 뷰티~였어요.<br>
								자연분해까지 생각해 환경친밀 비건패드로 수분감이 부족한 부분에 5분간 올려두면 피부의 수분감 충족, 톤과 결,
								매끄러움을 향상시켜 줍니다. <br> 눈가와 이마의 미세한 주름까지 잡아주는 오에라의 멀티-베네핏
								캘리브레이터♡로 더 예뻐지세요~
							</p>
						</div>
						<div class="review_more_1807">
							<a href="#;">리뷰 더보기</a>
						</div>
					</li>
					<!-- 7 -->
					<li class="evaluation_view">
						<div class="member_info_bottom">
							<ul>
								<li class="choice">• <span>한*연</span> / <span>30대</span> /
									<span>민감성</span>
								</li>
							</ul>
						</div> <!--리뷰이미지 영역 (이미지 없으면 영역 삭제)-->
						<div class="review_represent_img1912">
							<img
								src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/07/pc_1.jpg"
								alt="리뷰 이미지">
							<div class="img_count191212">
								<span class="img_count191212_inner">+</span>
							</div>
						</div>
						<div class="review_img_wrap review_img_cont191216"
							id="testerReviewImg_6">
							<ul class="slides">
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/07/pc_1.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/07/pc_2.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/07/pc_3.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/07/pc_4.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/07/pc_5.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
							</ul>
							<div class="controls">
								<span class="prev"></span> <span class="next"></span>
							</div>
							<div class="bx_pager191219">
								<a class="bx-pager-link" data-slide-index="0" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="1" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="2" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="3" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="4" href="#;"></a>
							</div>
						</div> <!--//리뷰이미지 영역 -->
						<div class="review_txt_wrap">
							<p class="review_txt">
								용기 디자인은 깔끔, 영롱한 느낌! 오에라의 분위기를 느낄 수 있어요~<br> 사용 방법은 간단해요 ㅎㅎ
								먼저 전용 패드를 활용하여 피부결을 정돈하고, 두번째는 손으로 흡수시켜 수분 공급을 해주세요! 레이어링 해주는
								느낌으로다가:) <br> 처음 전용패드로 발라주었을 때 느낌은 "오!?!" 👀 촉촉 찹찹 바르면 느낌이
								쫀득쫀득해지는 느낌이더라구요:) <br> 피부톤 개선이나, 피부결, 탄력에 좋다고 하니 꾸준히 사용해 봐야
								겠어요~<br> 촉촉한 손등 보이죠!? 패드도 완전 꿀템이라 슥슥 닦아주고, 흡수시켜주면 최고의
								조합이에요~ <br> 환절기 민감한 피부에 추천해봅니다~
							</p>
						</div>
						<div class="review_more_1807">
							<a href="#;">리뷰 더보기</a>
						</div>
					</li>
					<!-- 8 -->
					<li class="evaluation_view">
						<div class="member_info_bottom">
							<ul>
								<li class="choice">• <span>김*현</span> / <span>40대</span> /
									<span>민감성</span>
								</li>
							</ul>
						</div> <!--리뷰이미지 영역 (이미지 없으면 영역 삭제)-->
						<div class="review_represent_img1912">
							<img
								src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/08/pc_1.jpg"
								alt="리뷰 이미지">
							<div class="img_count191212">
								<span class="img_count191212_inner">+</span>
							</div>
						</div>
						<div class="review_img_wrap review_img_cont191216"
							id="testerReviewImg_7">
							<ul class="slides">
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/08/pc_1.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/08/pc_2.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/08/pc_3.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/08/pc_4.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
							</ul>
							<div class="controls">
								<span class="prev"></span> <span class="next"></span>
							</div>
							<div class="bx_pager191219">
								<a class="bx-pager-link" data-slide-index="0" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="1" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="2" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="3" href="#;"></a>
							</div>
						</div> <!--//리뷰이미지 영역 -->
						<div class="review_txt_wrap">
							<p class="review_txt">
								한섬옷을 좋아하는 편이라, 한섬브랜드에 관심이 많았는데 한섬에서 화장품라인이 나온다는 소식에 넘 기대가 많았다…
								체험단모집에 별기대없이 댓글 응모하였는데~~선정되어 넘 기쁨~~ <br> 기다리던 "오에라" 브랜드명의
								멀티-베네핏 캘리브레이터 에센스 도착!!! <br> 밤에 세안 후 전용 패드로 살짝 닦아내듯 바른 후,
								적당량을 덜어서 누르듯 바름~ <br> 아침에 일어나보니 맑아진 피부톤이 느껴져요~ 역시 명품이 좋군…
								다른 라인도 넘 체험해보고 싶네요… 향도 고급스러운 향수 느낌의 달달함이 가득한 향이에요...^^ <br>
							</p>
						</div>
						<div class="review_more_1807">
							<a href="#;">리뷰 더보기</a>
						</div>
					</li>

					<!-- 9 -->
					<li class="evaluation_view">
						<div class="member_info_bottom">
							<ul>
								<li class="choice">• <span>김*정</span> / <span>40대</span> /
									<span>복합성</span>
								</li>
							</ul>
						</div> <!--리뷰이미지 영역 (이미지 없으면 영역 삭제)-->
						<div class="review_represent_img1912">
							<img
								src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/09/pc_1.jpg"
								alt="리뷰 이미지">
							<div class="img_count191212">
								<span class="img_count191212_inner">+</span>
							</div>
						</div>
						<div class="review_img_wrap review_img_cont191216"
							id="testerReviewImg_8">
							<ul class="slides">
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/09/pc_1.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/09/pc_2.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/09/pc_3.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/09/pc_4.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
							</ul>
							<div class="controls">
								<span class="prev"></span> <span class="next"></span>
							</div>
							<div class="bx_pager191219">
								<a class="bx-pager-link" data-slide-index="0" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="1" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="2" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="3" href="#;"></a>
							</div>
						</div> <!--//리뷰이미지 영역 -->
						<div class="review_txt_wrap">
							<p class="review_txt">
								피부에 밸런스를 잡아줄 완벽한 #에센스 발견 <br> 우선 처음 보자마자 멋있다!!! 감탄😍 그리고
								향수를 쓰는 기분은 보너스~ <br> 1. 피부를 가장 편안한 상태로 만들어주는 오에라만의 처방 솔루션.<br>
								2. 독자적인 크로노 엘릭서™가 "톤","결","촉(탄력)"을 동시에 케어하는 멀티 베네핏 효과 선사.<br>
								3. 전용패드로 피부결 정리 후 손으로 흡수시켜 수분공급하는 2-레이어링 케어.<br> 앞으로 내피부를
								맡겨보기로했다~ #똑똑한에센스 #오에라 #컬러브레이터
							</p>
						</div>
						<div class="review_more_1807">
							<a href="#;">리뷰 더보기</a>
						</div>
					</li>
					<!-- 10 -->
					<li class="evaluation_view">
						<div class="member_info_bottom">
							<ul>
								<li class="choice">• <span>한*연</span> / <span>30대</span> /
									<span>민감성</span>
								</li>
							</ul>
						</div> <!--리뷰이미지 영역 (이미지 없으면 영역 삭제)-->
						<div class="review_represent_img1912">
							<img
								src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/10/pc_1.jpg"
								alt="리뷰 이미지">
							<div class="img_count191212">
								<span class="img_count191212_inner">+</span>
							</div>
						</div>
						<div class="review_img_wrap review_img_cont191216"
							id="testerReviewImg_9">
							<ul class="slides">
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/10/pc_1.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/10/pc_2.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/10/pc_3.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/10/pc_4.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
							</ul>
							<div class="controls">
								<span class="prev"></span> <span class="next"></span>
							</div>
							<div class="bx_pager191219">
								<a class="bx-pager-link" data-slide-index="0" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="1" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="2" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="3" href="#;"></a>
							</div>
						</div> <!--//리뷰이미지 영역 -->
						<div class="review_txt_wrap">
							<p class="review_txt">
								독자성분 '크로노 엘릭서'와 피부 리듬을 잡아주는 '캘리브레이팅 시스템'<br> 피부 톤/결/촉(탄력)을
								함께 챙겨주는 멀티-베네핏 캘리브레이터 <br> 1.써본지 2주 되었는데, 지금 계절이면 뒤집어졌을 피부가
								나름 단단해져 있는 느낌😀<br> 2.친환경 전용 비건패드로 각질을 정돈해주고 손으로 싸악 흡수시켜주니
								촉촉함이 오래가는 느낌.<br> 3.피부가 좋은편은 아닌데, 요새 안색이 좋아졌다는 얘기를 많이 듣는다.<br>
								#캘리브레이터 #더한섬닷컴 #모닝뷰티루틴 #에센스추천
							</p>
						</div>
						<div class="review_more_1807">
							<a href="#;">리뷰 더보기</a>
						</div>
					</li>
					<!-- 11 -->
					<li class="evaluation_view">
						<div class="member_info_bottom">
							<ul>
								<li class="choice">• <span>박*아</span> / <span>40대</span> /
									<span>건성</span>
								</li>
							</ul>
						</div> <!--리뷰이미지 영역 (이미지 없으면 영역 삭제)-->
						<div class="review_represent_img1912">
							<img
								src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/11/pc_1.jpg"
								alt="리뷰 이미지">
							<div class="img_count191212">
								<span class="img_count191212_inner">+</span>
							</div>
						</div>
						<div class="review_img_wrap review_img_cont191216"
							id="testerReviewImg_10">
							<ul class="slides">
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/11/pc_1.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/11/pc_2.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/11/pc_3.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
							</ul>
							<div class="controls">
								<span class="prev"></span> <span class="next"></span>
							</div>
							<div class="bx_pager191219">
								<a class="bx-pager-link" data-slide-index="0" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="1" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="2" href="#;"></a>
							</div>
						</div> <!--//리뷰이미지 영역 -->
						<div class="review_txt_wrap">
							<p class="review_txt">
								캘리브레이터는 투명하고 묽은 제형으로 피부에 닿았을 때 우드향이 은은하게 나는 게 정말 좋았습니다. <br>
								함께 들어있는 패드에 두세번 펌핑하여 볼-이마-코와 턱 순으로 부드럽게 닦아 내듯 발라줍니다. <br>
								패드는 부드러운 면과 거친 면이 양면으로 되어 있어 각질이 신경 쓰일 때는 거친 면으로 바르고, 꼼꼼히 세안을 하여
								피부가 민감한 상태가 되었을 때는 부드러운 면으로 발라 피부에 최소한으로 자극이 되도록 하였습니다. <br>
								한 번 닦아 내듯 바른 패드는 바로 버리지 않고 뒤집어서 두어 번 더 펌핑한 후 가장 신경 쓰이는 이마와 미간 주름
								위에 붙여 놓아 5분 간 팩을 하였습니다. 이마에 패드로 잠시 팩을 하는 동안 손바닥에 다시 캘리브레이터를 적당량
								덜어 눈가와 볼, 팔자주름 등 피부에 대고 지긋이 누르듯 흡수시켜 주었습니다. <br> 성분이 피부 속에
								흡수되어 완전히 자리 잡는 데에 한 1~2분 정도 걸리는 것 같아요. 빠르게 피부에 흡수되어 금방 부드럽고
								촉촉해집니다. 금방 피부에 스며들지만 신기하게도 피부결을 부드럽고 매끄럽게 정돈해주니 정말 신기했습니다. <br>
								캘리브레이터의 효과를 온전히 느끼고 싶어 2주일 째 화장을 하지 않고 맨 얼굴로 출근을 하고 있는데요, <br>
								피부에 보습감을 전달하여 하루 종일 건조하지 않으면서 유수분 조절이 되어 산뜻한 느낌이 들었습니다. 쉽게 예민해졌던
								피부에 자극 없이 스며들어 윤기와 영양분을 공급해주는 듯했습니다. <br> 매일 아침저녁 세안 후
								사용할수록 피부는 투명해졌고 자꾸 거울을 보고 싶어질 정도로 매끈해졌습니다. <br> 이렇게 단기간에
								미백효과가 나타나는 것이 정말 신기했고, 꾸준히 사용하면 분명 효과를 볼 수 있을 것 같아요. <br>
								다양한 피부 상태와 고민에 따라 오에라의 특징적인 솔루션을 담아낸 기능성 제품을 하나씩 단계별로 선택해 자신만의
								리추얼을 완성해가는 즐거움을 느낄 수 있을 듯 합니다.
							</p>
						</div>
						<div class="review_more_1807">
							<a href="#;">리뷰 더보기</a>
						</div>
					</li>
					<!-- 12 -->
					<li class="evaluation_view">
						<div class="member_info_bottom">
							<ul>
								<li class="choice">• <span>최*희</span> / <span>30대</span> /
									<span>건성</span>
								</li>
							</ul>
						</div> <!--리뷰이미지 영역 (이미지 없으면 영역 삭제)-->
						<div class="review_represent_img1912">
							<img
								src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/12/pc_1.jpg"
								alt="리뷰 이미지">
							<div class="img_count191212">
								<span class="img_count191212_inner">+</span>
							</div>
						</div>
						<div class="review_img_wrap review_img_cont191216"
							id="testerReviewImg_11">
							<ul class="slides">
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/12/pc_1.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/12/pc_2.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/12/pc_3.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/12/pc_4.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/12/pc_5.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/12/pc_6.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
							</ul>
							<div class="controls">
								<span class="prev"></span> <span class="next"></span>
							</div>
							<div class="bx_pager191219">
								<a class="bx-pager-link" data-slide-index="0" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="1" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="2" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="3" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="4" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="5" href="#;"></a>
							</div>
						</div> <!--//리뷰이미지 영역 -->
						<div class="review_txt_wrap">
							<p class="review_txt">
								한섬의 럭셔리 뷰티 제품 답게 패키지 역시 고오급지다! 한섬하다! 할만했습니다. <br> 실버톤의 화장품
								용기며, 제품과 함께 동봉되어있는 친환경 전용 패드!! 그냥 말이 필요 없었습니다.<br> 설명서에
								나와있는대로 1차는 세안 후 가볍에 패드에 세럼을 약 2회 펌핑하여 피부결을 따라 닦토 하듯 닦어주었습니다.<br>
								피부에 닿는 순간 냄새 무슨일이죠? 기존 화장품들에서 나는 인위적인 향이 아닌 은은한 향이 특히 마음에 들었구요.<br>
								굴곡진 패드가 화장품을 흡수하는게 아니라, 그대로 머금고 있다가 제피부에 100% 전달해주어 피부 결정리에 너무
								좋은 느낌을 받았습니다. <br> 최근 제가 야근과 마법으로 인해 피부가 푸석해졌었는데요.. 요 제품으로
								아침 저녁 2회씩 사용한 결과 확실히 피부톤이 맑다! 확실히 피부 결 (각질)이 정돈되었다! 하는 느낌을 받을 수
								있었습니다.<br> 제형은 아주 묽은 타입인데요. 끈적임 없이 피부에 부드럽게 스며들더라구요.가격은
								조금(?) 비싸지만.. 이래서!! 좋은걸. 쓰는거지...하는 생각이 절로드는 아이였습니다.<br> 평소에
								화장품에 매우 관심이 많은지라 뷰티 체험단으로 다양한 브랜드도 접해 봤구요. 또 고가 제품, 저렴이 제품 할거 없이
								신상이라고 하면 꼭! 써봐야 직성이 풀리는 1인인데요.<br> 요아이 정말이지 체험단으로 접했지만 정말
								제돈주고 사도 아깝지 않겠다!라는 생각이 절로 들었답니다!
							</p>
						</div>
						<div class="review_more_1807">
							<a href="#;">리뷰 더보기</a>
						</div>
					</li>

					<!-- 13 -->
					<li class="evaluation_view">
						<div class="member_info_bottom">
							<ul>
								<li class="choice">• <span>김*윤</span> / <span>40대</span> /
									<span>건성</span>
								</li>
							</ul>
						</div> <!--리뷰이미지 영역 (이미지 없으면 영역 삭제)-->
						<div class="review_represent_img1912">
							<img
								src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/13/pc_1.jpg"
								alt="리뷰 이미지">
							<div class="img_count191212">
								<span class="img_count191212_inner">+</span>
							</div>
						</div>
						<div class="review_img_wrap review_img_cont191216"
							id="testerReviewImg_12">
							<ul class="slides">
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/13/pc_1.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/13/pc_2.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
							</ul>
							<div class="controls">
								<span class="prev"></span> <span class="next"></span>
							</div>
							<div class="bx_pager191219">
								<a class="bx-pager-link" data-slide-index="0" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="1" href="#;"></a>
							</div>
						</div> <!--//리뷰이미지 영역 -->
						<div class="review_txt_wrap">
							<p class="review_txt">
								처음 받아 봤을때 첫 느낌은 엄청 럭셔리 하네요^^ 향은 좀 호불호가 있을듯 해요~ <br> 부스터 같은
								에센스라서 손등에 발라 보니까 스킨처럼 흐르네요~ <br> 전용 패드로 자극 없이 피부결 정돈해 주어서
								오래 쓰면 부드러운 피부결 만들어 줄듯 해요~ <br> 요즘 같은 환절기에 쓰면 촉촉하고 건조하지 않아서
								좋네요^^ 일주일 써 본 결과 지금까지 만족합니다^^
							</p>
						</div>
						<div class="review_more_1807">
							<a href="#;">리뷰 더보기</a>
						</div>
					</li>
					<!-- 14 -->
					<li class="evaluation_view">
						<div class="member_info_bottom">
							<ul>
								<li class="choice">• <span>권*리</span> / <span>30대</span> /
									<span>건성</span>
								</li>
							</ul>
						</div> <!--리뷰이미지 영역 (이미지 없으면 영역 삭제)-->
						<div class="review_represent_img1912">
							<img
								src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/14/pc_1.jpg"
								alt="리뷰 이미지">
							<div class="img_count191212">
								<span class="img_count191212_inner">+</span>
							</div>
						</div>
						<div class="review_img_wrap review_img_cont191216"
							id="testerReviewImg_13">
							<ul class="slides">
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/14/pc_1.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
							</ul>
							<div class="controls">
								<span class="prev"></span> <span class="next"></span>
							</div>
							<!-- <div class="bx_pager191219">
                                        <a class ="bx-pager-link" data-slide-index="0" href="#;"></a>
                                    </div> -->
						</div> <!--//리뷰이미지 영역 -->
						<div class="review_txt_wrap">
							<p class="review_txt">
								피부 각질 제거 전, 피부 컨디션이 좋지 않은 상태에서 사용했음에도 불구하고, 기타 기초 케어와 피부 화장이 얇게
								잘 되어서 피부 밸런스를 잘 잡아줄 수 있을 거라 생각됩니다! <br> 피부 각질 제거 후, 묵은 각질이
								없는 상태에서는 역시나 기초의 역할을 탄탄히 하는 것 같았어요. <br> 바쁜 생활에서 화장 단계를
								최소화하기 위해 ‘오에라-스킨-선크림-쿠션’으로 사용해 보았습니다. <br> 기초 케어가 부실했음에도
								불구하고 밀림이나 들뜨는 현상 없이 쿠션을 잡아주어서 매우 놀라웠습니다!<br> 제품의 묽기는 일반 스킨과
								같이 흐르는 제형이며, 향은 "은은하다" 정도로 생각됩니다.<br> 전용 패드는 100% 생분해 가능한
								친환경 패드라는 점에 높은 점수를 주고 싶습니다!<br> 제품 용기는 은색의 은은한 용기가 화장대의 어떤
								화장품과 있어도 어울릴 것 같습니다. <br> 마지막으로 캘리브레이터는 기대 이상으로 스킨케어 첫 단계의
								역할을 완벽하게 수행하고 있디고 생각되었습니다.<br> 피부의 톤, 결, 탄력을 이상적인 상태로 가꿔줄 수
								있을 것으로 예상되기 때문에 계속해서 사용할 용의가 있습니다. :)
							</p>
						</div>
						<div class="review_more_1807">
							<a href="#;">리뷰 더보기</a>
						</div>
					</li>
					<!-- 15 -->
					<li class="evaluation_view">
						<div class="member_info_bottom">
							<ul>
								<li class="choice">• <span>이*민</span> / <span>30대</span> /
									<span>민감성</span>
								</li>
							</ul>
						</div> <!--리뷰이미지 영역 (이미지 없으면 영역 삭제)-->
						<div class="review_represent_img1912">
							<img
								src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/15/pc_1.jpg"
								alt="리뷰 이미지">
							<div class="img_count191212">
								<span class="img_count191212_inner">+</span>
							</div>
						</div>
						<div class="review_img_wrap review_img_cont191216"
							id="testerReviewImg_14">
							<ul class="slides">
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/15/pc_1.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
								<li>
									<div class="review_img_cont_inner191216">
										<div class="img_wrap">
											<img
												src="http://cdn.thehandsome.com/_ui/desktop/common/images/beauty/review/15/pc_2.jpg"
												alt="리뷰 이미지">
										</div>
									</div>
								</li>
							</ul>
							<div class="controls">
								<span class="prev"></span> <span class="next"></span>
							</div>
							<div class="bx_pager191219">
								<a class="bx-pager-link" data-slide-index="0" href="#;"></a> <a
									class="bx-pager-link" data-slide-index="1" href="#;"></a>
							</div>
						</div> <!--//리뷰이미지 영역 -->
						<div class="review_txt_wrap">
							<p class="review_txt">
								캘리브레이터가 처음 피부에 닿았을 때 코로 들어오는 향이 자극적이지 않고, 천연 아로마와 유사한 느낌이 들어
								향만으로도 힐링이 되었다. 무엇보다 피부에 즉각적으로 잘 스며들어 산뜻함과 촉촉함이 느껴졌다. <br>
								함께 동봉된 전용 친환경 패드는 한쪽 면은 부드럽고 다른 쪽은 거친 촉감이 다소 느껴져, 과연 부드럽게 닦아질 수
								있을까? 하는 의문이 들었다. <br> 캘리브레이터를 2~3번 펌핑 후 전용 패드의 부드러운 면으로
								피부결을 따라 닦아내 본 결과, 평소 쓰던 패드에 비해 피부에 훨씬 빠르게 흡수되며 수분감이 느껴졌다. 리퀴드
								제형이라 발림성과 흡수성이 뛰어나 에센스만으로 피부 속 영양분이 공급되는 느낌이 들었다. <br> 가을과
								겨울에는 오일과 함께 사용한다면 수분감의 지속과 더불어 피부 밸런스를 보다 더 균형있게 잡아주는 효과를 얻을 수
								있을 것 같다. <br> 체험 후, 피부결이 상당히 좋아진 것을 느낄 수 있었다. <br> 체험
								전에는 메이크업 단계에서 밀리는 경우가 종종 있었는데, 체험 기간 동안에는 메이크업에서 밀림 현상 없이 화장이 잘
								먹혀서 에센스 사용만으로도 이렇게 달라질 수 있음에 다소 놀랐다.
							</p>
						</div>
						<div class="review_more_1807">
							<a href="#;">리뷰 더보기</a>
						</div>
					</li>
				</ul>
			</div>
			<!-- paging -->
			<div class="paging mt30" id="reviewPagingDiv">
				<span class="num"> <a href="javascript:void(0);"
					class="pageBtn on" pagenum="1">1</a> <a href="javascript:void(0);"
					class="pageBtn" pagenum="2">2</a> <a href="javascript:void(0);"
					class="pageBtn" pagenum="3">3</a> <a href="javascript:void(0);"
					class="pageBtn" pagenum="4">4</a>
				</span>
			</div>
			<!-- //paging -->
		</div>
		<!--// pop_cnt-->
		<a href="javascript:void(0);" class="btn_close"><img
			src="/_ui/desktop/common/images/popup/ico_close.png" alt="닫기"></a>
	</div>
	<!-- //상품평 리스트-->
	<!-- // 211101 체험단 리뷰 추가 E -->
</div>
<div id="criteo-tags-div" style="display: none;"></div>

<!-- 장바구니 담겼을때 계속 쇼핑할지 말지  -->
<div class="layerArea" id="productLayer" style="display: none;">
	<div class="layerBg"></div>
	<div class="popwrap w_type_1" id="putCart"
		style="z-index: 150; margin-top: 853px; display: none;" tabindex="-1">
		<div class="pop_cnt">
			<h3 class="pop_tlt copy">
				쇼핑백에 담겼습니다.<br>확인하시겠습니까?
			</h3>
			<div class="btnwrap">
				<input type="button" id="clsBtn" class="btn wt_s mr5"
					value="계속 쇼핑하기"> <input type="button" id="cfBtn"
					class="btn gray_s mr0" value="쇼핑백 바로가기">
			</div>
		</div>
		<a href="javascript:void(0);" class="btn_close"><img
			src="/resources/images/ico_close.png" alt="닫기"></a>
	</div>
	<div class="popwrap w_type_1 " id="Order_confirm"
		style="z-index: 150; margin-top: 753px; display: none;" tabindex="-1">
		<div class="pop_cnt">
			<h3 class="pop_tlt copy">사이즈를 선택해 주세요.</h3>
			<div class="btnwrap">
				<input type="button" class="btn gray_s mr0" onclick="sizeConfirm();"
					value="확인">
			</div>
		</div>
		<a href="javascript:void(0);" class="btn_close"> <img
			src="/resources/images/ico_close.png" alt="닫기"></a>
	</div>
	<!-- 로그인 물어보는 창 -->
	<div id="AskLogin" class="popwrap w_type_1"
		style="z-index: 150; display: none; margin-top: 337.5px" tabindex="-1">
		<div class="pop_cnt">
			<h3 class="pop_tlt copy">로그인 하시겠습니까?</h3>
			<div class="btnwrap">
				<input type="button" id="clsBtn" class="btn wt_s mr5" value="취소" /><input
					type="button" id="cfBtn" class="btn gray_s mr0" value="확인"
					onclick="location.href='/member/loginForm'" />
			</div>
		</div>
		<a href="javascript:void(0);" class="btn_close"><img
			src="/resources/images/ico_close.png" alt="닫기" /></a>
	</div>
	<div id="alreadyInsert" class="popwrap w_type_1"
		style="z-index: 150; margin-top: 1072px" tabindex="-1">
		<div class="pop_cnt">
			<h3 class="pop_tlt copy">
				이미 쇼핑백에 담겨있습니다.<br />
				<p style="color: gray; font-size: 14px; margin-top: 8px">(동일 상품은
					최대 2개까지 구매 가능)</p>
			</h3>
			<div class="btnwrap">
				<input type="button" class="btn gray_s mr0" onclick="sizeConfirm();"
					value="확인" />
			</div>
		</div>
		<a href="javascript:void(0);" class="btn_close"><img
			src="/resources/images/ico_close.png" alt="닫기" /></a>
	</div>
</div>

<form id="productOneCLickDeliveryForm"
	action="/ko/mypage/myDeliveryList">
	<input type="hidden" name="code" id="code" value="">
</form>
<input type="hidden" id="chkToastFirstYn" name="chkToastFirstYn"
	value="N">
<!--beshow conversion starts-->
<!--beshow conversion ends-->
<iframe style="display: none" id="fileFrame" title="fileFrame" scr=""></iframe>

<!-- footerWrap -->
<script>
	//가격에 3자리마다 컴마
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

	//QnA 버튼 클릭시 QnA 리스트 띄워지게 하기
	function fn_popupProductQnA() {
		viewPopup("#productQnADiv");
	}

	//x 버튼을 누르면 QnA 리스트 닫기
	function fn_closeProductQnA() {
		console.log("fn");
		//.btn_close 버튼의 click 동작 이벤트를 강제로 실행시킴
		$(".btn_close").trigger("click");
	}

	//사이즈 확인 모달 창 버튼의 class에 스타일이 적용되있으ㅓㅅ
	/* function fn_Order_confirm() {
		console.log("fn");
		//.btn_close 버튼의 click 동작 이벤트를 강제로 실행시킴
		$(".btn_close").trigger("click");
	} */

	//btn_close라는 클래스 이름을 가진 버튼을 클릭시 닫기 적용
	$(".btn_close").on("click", function() {
		$('#productLayer').hide();
		$(".popwrap").hide();
	});

	//QnA 작성란 띄우기
	function fn_popupProductQnAWrite() {

		//QnA 리스트를 숨긴다.
		$("#productQnADiv").hide();
		//작성란을 띄운다.
		viewPopup("#productQnAWriteDiv");
	}

	//x 버튼을 누르면 QnA 작성창 닫기
	function fn_closeProductQnAWrite() {
		//.btn_close 버튼의 click 동작 이벤트를 강제로 실행시킴
		$(".btn_close").trigger("click");
		//QnA 작성 리스트를 띄운다.
		viewPopup("#productQnADiv");
	}

	//QnA 작성 취소하기
	$("#qnaCancle").on('click', function() {

		//취소를 원하면 QnA 작성란을 숨기고 상품 QnA 리스트를 보여줌
		if (confirm("취소하시겠습니까?")) {
			$("#productQnAWriteDiv").hide();
			viewPopup("#productQnADiv");
		}

	});

	//사이즈 체크 확인 창이 뜨고 확인버튼을 누르면 확인 모달창에 사라짐
	function sizeConfirm() {
		$('#productLayer').hide();
		$("#Order_confirm").hide();
	}

	//QnA 팝업 창의 크기를 조절하고 띄우는 함수(공홈을 참고함)
	function viewPopup(v, n) {

		var obj = $("#" + v.split("#")[1]);
		var lp = ($(window).width() - obj.outerWidth()) / 2;
		var tp = ($(window).height() - obj.outerHeight()) / 2
				+ $(window).scrollTop();
		var scrollTop = $(window).scrollTop();
		if (lp < 0)
			lp = 0;
		if (tp < 0)
			tp = 0;
		$('#productLayer').show();
		if ($(window).height() < obj.outerHeight()) {
			obj.css("top", scrollTop).css("position", "absolute").css(
					"z-index", 101);
		} else {
			obj.css("top", tp).css("position", "absolute").css("z-index", 101);
		}
		obj.show();
		return false;
	}

	//수량버튼 내렸을때! 무조건 1개 이상이여야겠지?
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

	let isWishList = "${isWishList}";
	//좋아요 지우는 ajax처리
	function deleteajaxRequest(params) {
		$.ajax({
			type : "POST",
			url : "/member/deleteWishList",
			data : params,// json 형태의 데이터
			contentType : "application/json; charset=utf-8",
			success : function(data) {
				console.log(data);
				isWishList = data;
				$('.wishlist1803').stop().toggleClass('on');
				$('.toast_popup p').text('위시리스트에서 삭제했습니다.');
				$('.toast_popup').stop().removeClass('on');
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR); //응답 메시지
				console.log(textStatus); //"error"로 고정인듯함
				console.log(errorThrown);
			}
		});
	}

	// 좋아요 눌렀을 때 
	function addWishListClick() {
		// 로그인 안했으면 로그인 했는지 물어보기
<%if ((String) session.getAttribute("member") == null) {
				// 세션에 값이 없으면 로그인 페이지로%>
	$(".layerArea").show();
		$("#AskLogin").show();
<%} else {%>
	if (isWishList != "0") {//이미 등록된 상태 일때
			const deleteList = [];
			let itemMap = new Map();
			itemMap.set('member_mid', "${member}");
			itemMap.set('pid', "${productVO.pid}");
			deleteList.push(Object.fromEntries(itemMap));
			deleteajaxRequest(JSON.stringify(deleteList));
		} else {
			//등록하고싶을때
			let params = {
				member_mid : "${member}",
				pid : "${productVO.pid}"
			}
			$.ajax({
				type : "POST",
				url : "/member/insertWishList",
				data : params, // json 형태의 데이터
				success : function(data) {
					console.log("삽입성공");
					isWishList = "1";
					console.log(isWishList);
					$('.toast_popup p').text('위시리스트에 담았습니다.');
					$('.wishlist1803').stop().toggleClass('on');
				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.log(jqXHR); //응답 메시지
					console.log(textStatus); //"error"로 고정인듯함
					console.log(errorThrown);
				}
			});
		}
<%}%>
	}

	$(document)
			.ready(
					function() {
						//페이지 로드될때 좋아요 누른거면 좋아요 처리를 합시다
						if (isWishList !== "0") {
							$('.wishlist1803').stop().toggleClass('on');
						}
						//쇼핑백에 담을 변수 선언
						let CartorOrder_size = "";
						let CartorOrder_sumprice = "";
						let selectColor = "";
						let selectSize = "";
						//페이지 로드할때 선택된 이미지로 상세보기이미지가 띄워지고 
						let prev_colorcode = "${curColorCode}";
						$(".image_view_" + prev_colorcode).css('display',
								'block');
						// 선택된 컬러버튼 클릭된 상태로 만들기
						$('a[colorcode=${curColorCode}]').addClass('on');
						selectColor = $('a[colorcode=' + prev_colorcode + ']')
								.attr('value');

						//마일리지, 포인트 알맞게 값 넣기
						let hsm = parseInt("${productVO.pprice}") * 5 / 100
						let hspoint = parseInt("${productVO.pprice}") * 0.1 / 100
						$("#hsm").text(priceComma(hsm) + " M (%5)")
						$("#hspoint").text(priceComma(hspoint) + " P (%0.1)")

						//COLOR 버튼 눌리면 왼쪽 이미지들 바뀌고 제품코드고 바뀜
						$(".colorBtn")
								.on(
										"click",
										function(e) {
											$(".image_view_" + prev_colorcode)
													.css('display', 'none');
											$(
													".image_view_"
															+ $(this)
																	.attr(
																			"colorcode"))
													.css('display', 'block');
											prev_colorcode = $(this).attr(
													"colorcode");
											$("#pcscode").text(
													$(this).attr("colorcode"));
											//일단 모든 버튼 on 지우고
											$(".colorBtn").removeClass('on');
											//또한 누르면 그버튼이 계속 눌렸다는걸 표시
											$(this).addClass('on');
											selectColor = $(this).attr("value");
										});

						//사이즈버튼 눌리면 사이즈 공백 제거후 상품코드 변경
						$(".sizeBtn").on(
								"click",
								function(e) {
									const sizeText = $.trim($(this).text());
									selectSize = sizeText;
									$("#pcscode").text(
											prev_colorcode + "_" + sizeText);

									//일단 모든 버튼 on 지우고
									$(".sizeBtn").removeClass('on');
									//또한 누르면 그버튼이 계속 눌렸다는걸 표시
									$(this).addClass('on');
									//쇼핑백에 size에 담음
									CartorOrder_size = sizeText;
								});

						//처음 로드될때 가격에 3자리마다 콤마찍음
						const num = $("#productPrice").val().replace(
								/\B(?=(\d{3})+(?!\d))/g, ',');
						//콤마찍은 숫자를 가격, 총합계 태그에 뿌림
						$("#pricespan").text("₩" + num);
						$("#sumPrice").text("₩" + num);

						/* 						//로그인 확인버튼 누르면 로그인 페이지로
						 $("#cfBtn").on("click", function(){
						 location.href="member/loginForm";
						 }); */
						//상품상세 같은 dt눌렀을때를 공홈꺼 그대로 가져옴
						$('.toggle_type1>dt')
								.click(
										function() {

											$(this).addClass('on');
											$(this).siblings('dt').removeClass(
													'on');

											var beforeHeight = $(
													".toggle_type1").height();
											var afterHeight = 0;
											var scrolltop = $(window)
													.scrollTop();

											var checkElement = $(this).next();

											if ((checkElement.is('dd'))
													&& (checkElement
															.is(':visible'))) {
												$(this).removeClass('on');
												checkElement
														.slideUp(
																'fast',
																function() {
																	afterHeight = $(
																			".toggle_type1")
																			.height();
																	//		 	 					bodyScroll();
																});

											}
											var fitGuide = false;
											if ((checkElement.is('dd'))
													&& (!checkElement
															.is(':visible'))) {
												var v_label = "";
												var v_type = $(this).children()
														.attr("id");
												//21.11.03 상품상세 정보 영역 변경 관련 GA이벤트태깅 추가 및 변경
												if (v_type == "NEW_DETAIL_INFO_EVT") {
													v_label = "상품상세정보";
												} else if (v_type == "DETAIL_INFO_EVT") {
													if ('ko' == 'ko') {
														v_label = "상품정보제공고시";
													} else {
														v_label = "상품상세정보";
													}
												} else if (v_type == "REAL_SIZE_EVT") {
													v_label = "실측사이즈";
												} else if (v_type == "DELI_RETURN_EVT") {
													v_label = "배송 및 반품";
												} else if (v_type == "FIT_GUIDE_EVT") {
													fitGuide = true;
												}

												if (!fitGuide) {
													//GA_Event('상품_상세','정보',v_label);
													console.log("뭐고 이거");
												}

												$('.toggle_type1>dd:visible')
														.slideUp('fast');

												checkElement
														.slideDown(
																'fast',
																function() {
																	afterHeight = $(
																			".toggle_type1")
																			.height();
																	//		 					bodyScroll();
																});
											}

											if (fitGuide) {
												fitGuide_Swiper_Slide(1);
											}

											var bodyScroll = function() {

												$('body,html')
														.animate(
																{
																	scrollTop : parseFloat(scrolltop
																			+ (beforeHeight - afterHeight))
																},
																function() {
																	bodyReSize();
																});
											}

											if ($(this).next('dd').length == 0) {
												return true;
											} else {
												return false;
											}
										});

						//장바구니버튼 눌렀을때
						$("#addToCartButton")
								.on(
										"click",
										function(e) {
											//우선 싸이즈 선택 했는지 물어봐
											if (selectSize === "") {
												$(".layerArea").show();
												$("#Order_confirm").show();
											} else {
												//로그인 안했으면 로그인 했는지 물어보고
<%if ((String) session.getAttribute("member") == null) { //세션에 값이 없으면 로그인 링크를 출력%>
	$(".layerArea").show();
												$("#AskLogin").show();
<%} else {%>
	const params = {
													mid : "${member}",
													pid : "${productVO.pid}",
													psize : selectSize,
													pcolor : selectColor,
													pamount : $("#txtqty")
															.val()
												}
												console.log(params);
												//ajax 호출!
												$
														.ajax({
															type : "POST", // HTTP method type(GET, POST) 형식
															url : "/member/insertShoppingbag", // 컨트롤러에서 대기중인 URL 주소
															data : params, // Json 형식의 데이터
															success : function(
																	data) { // 비동기통신의 성공일경우 success콜백으로 들어옴 'data'는 응답받은 데이터
																// 응답코드 > 0000
																console
																		.log(data);
																const isfail = data
																		.split(':')[0];
																const count = parseInt(data
																		.split(':')[1]);

																//만약 세션의 장바구니 갯수와 반환받은 data와 다르면 성공 ! 같으면 안된거니까 실패 !
																if (isfail === 'success') {
																	$(
																			"#cartCount")
																			.text(
																					count);
																	$(
																			".layerArea")
																			.show();
																	$(
																			"#putCart")
																			.show();
																} else {
																	$(
																			".layerArea")
																			.show();
																	$(
																			"#alreadyInsert")
																			.show();
																}
															},
															error : function(
																	XMLHttpRequest,
																	textStatus,
																	errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옴
																alert("통신 실패.");
															}
														});
<%}%>
	}
										});
						//계속 쇼핑하기 버튼을 눌렀을 경우
						$("#clsBtn").on("click", function() {
							//밖에 있는 layerArea 태그를 숨긴다.
							$(".layerArea").hide();
							//그중 Cart 모달을 나타내는 태그를 숨긴다
							$("#putCart").hide();
						});

						//쇼핑백으로 바로가기를 눌렀을 경우
						$("#cfBtn")
								.on(
										"click",
										function() {
											location.href = "/member/shoppingbag?mid=${member}";
										});

						$("#addToCartBuyNowButton").on(
								"click",
								function() {
									console.log("addToCartBuyNowButton");
									$('#order_colorcode').val(
											$('#pcscode').text());
									if (CartorOrder_size == "") {
										$(".layerArea").show();
										$("#Order_confirm").show();
										return;
									} else {
										$('#order_size').val(CartorOrder_size);
									}

									let cart_Sumprice = $("#productPrice")
											.val()
											* parseInt($("#txtqty").val());
									$('#order_sumprice').val(cart_Sumprice);
									$('#order_hsm').val(hsm);
									$('#order_hspoint').val(hspoint);
									$('#order_count').val($('#txtqty').val());

									$('#addToCartBuynowForm').submit();
								});

					});
</script>
<%@include file="/WEB-INF/views/common/footer.jsp"%>