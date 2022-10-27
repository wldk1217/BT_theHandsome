<!-- 
/*****************************************************
 * @function : productlist.jsp
 * @author : 심지연
 * @Date : 2022.10.19
 *****************************************************/
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<body oncontextmenu="return false">
	<!-- bodyWrap -->
	<div id="bodyWrap" class="products">
		<!--title-->
		<h3 class="cnts_title ou1804">
			<span> <!-- 정상 브랜드 카테고리 목록 --> <a
				href="/list?clarge=${product.clarge}&cmedium=&csmall=">
					${product.clarge}</a> <c:if test="${product.cmedium ne ''}">
					<img
						src="http://cdn.thehandsome.com/_ui/desktop/common/images/products/ou_location_arr.png"
						alt="location arr">
					<a
						href="/list?clarge=${product.clarge}&cmedium=${product.cmedium}&csmall=">${product.cmedium}</a>
					<c:if test="${product.csmall ne ''}">
						<img
							src="http://cdn.thehandsome.com/_ui/desktop/common/images/products/ou_location_arr.png"
							alt="location arr">
						<a
							href="/list?clarge=${product.clarge}&cmedium=${product.cmedium}&csmall=${product.csmall}">${product.csmall}</a>
					</c:if>
				</c:if>

			</span>
		</h3>
		<!--  카테고리 개편 아울렛 -->
		<!--//title-->
		<div class="adaptive_wrap">

			<form id="productListForm" action="/ko/c/productList">
				<input type="hidden" id="brandCode" name="brandCode" value="">
				<input type="hidden" id="brandName" name="brandName" value="">
				<input type="hidden" id="subBrand" name="subBrand" value="">
				<input type="hidden" name="productCode" value="we011"> <input
					type="hidden" id="genderproductCode" name="genderproductCode"
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
								<ul id="product_brand_chip">
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
								<ul class="color_chip clearfix" id="product_color_chip">
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
								<ul class="size_chip clearfix" id="product_size_chip">
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
						<span class="num">${totalProducts}</span> <span>전체</span>
					</div>
				</div>
			</form>
			<!-- sort wrap -->

			<div class="items_list cate_item4" id="listContent"
				style="display: block;">
				<ul class="clearfix" id="listBody" style="display: block;">
					<c:forEach items="${list}" var="product" varStatus="status">
						<li>
							<div class="item_box">
								<a href="#" class="item_info1"> <span class="item_img">
										<input type="hidden" class="idvalue${product.pid}"
										value="${product.pid}"> <img src="" id="T01_IMG_0"
										alt="${product.pname}" targetcode="${product.pid}"
										class="respon_image"
										onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img3.jpg'">
										<img src="" id="T02_IMG_0" alt="${product.pname}"
										targetcode="${product.pname}" class="respon_image on"
										onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img3.jpg'"
										style="opacity: 0;"> <input type="hidden"
										id="newImage1_0"
										value="http://newmedia.thehandsome.com/SY/2C/SS/SY2C4TTO047W_BK_T01.jpg">
										<input type="hidden" id="newImage2_0"
										value="http://newmedia.thehandsome.com/SY/2C/SS/SY2C4TTO047W_BK_T02.jpg">
								</span> <span class="item_size" id="itemsize_0"
									style="display: none; height: 20px; padding-top: 15px; margin-top: 0px; padding-bottom: 15px; margin-bottom: 0px;">
										<div>
											<c:forEach items="${sizeMap[status.index]}" var="size">
												<span>${size}</span>
											</c:forEach>
										</div>
								</span>
								</a> <a href="/ko/p/${product.pid}" class="item_info2"> <span
									class="brand">${product.bname}</span> <span class="title">${product.pname}</span>
									<span class="price">₩<fmt:formatNumber
											value="${product.pprice }" type="number" pattern="###,###" /></span>
									<span class="flag"> <span class="product">NEW</span>
								</span>
								</a>

								<div class="color_more_wrap">
									<c:forEach items="${colorMap[status.index] }" var="colorList"
										varStatus="status2">
										<a href="javascript:void(0)" class="cl wt"
											style="background:<%-- ${colorList.ccolorname} --%> url('${colorList.ccolorimage }');"
											onclick="GA_Event('카테고리_리스트','컬러칩','BK')"
											productid="${product.pid}"
											ccolorcode="${colorList.ccolorcode}"
											cimage2="${colorList.cimage2}" cimage4="${colorList.cimage4}"></a>
										<input type="hidden" class="colorvalue"
											value="${colorList.ccolorcode}">
									</c:forEach>
								</div>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
</body>

<div class="paging" style="display: block;">
	<input type="hidden" class="clarge" value="${product.clarge}">
	<input type="hidden" class="cmedium" value="${product.cmedium}">
	<input type="hidden" class="csmall" value="${product.csmall}">
	<input type="hidden" class="realEnd" value="${pager.realEnd}">
	<a class="prev2" href="#"></a>
	<c:if test="${pager.prev}">
		<!-- 이전 버튼 -->
		<a class="prev"
			href="/list?clarge=${product.clarge}&cmedium=${product.cmedium}&csmall=${product.csmall}&pageNum=${pager.startPage - 1}">Previous</a>
	</c:if>

	<!-- 1~10 버튼 -->
	<span class="num"> <c:forEach var="num"
			begin="${pager.startPage}" end="${pager.endPage}">
			<c:if test="${(pager.startPage+i) <= pager.endPage}">
				<a
					href="/list?clarge=${product.clarge}&cmedium=${product.cmedium}&csmall=${product.csmall}&pageNum=${num}"
					class="pageBtn">${num}</a>
			</c:if>
		</c:forEach>
	</span>  
	<c:if test="${pager.next}">
		<!-- 다음 버튼 -->
		<a
			href="/list?clarge=${product.clarge}&cmedium=${product.cmedium}&csmall=${product.csmall}&pageNum=${pager.endPage +1}"
			class="next">Next</a>
	</c:if>
	<a class="next2" href="#"></a>
</div>
<!--  end Pagination -->

<form id='actionForm' action="/list" method='get'>
	<input type='hidden' name='pageNum' value='${pager.cri.pageNum}'>
	<input type='hidden' name='amount' value='${pager.cri.amount}'>
</form>

<div class="sh_result none" id="searchResult_None"
	style="display: none;">조건에 맞는 상품 정보가 없습니다.</div>

<div id="criteoVariable">
	<script type="text/javascript">
		$(document)
				.ready(
						function() {

							const products = document
									.querySelectorAll(".item_box")
							for (i = 0; i < products.length; i++) {
								const img1 = products[i]
										.getElementsByClassName("cl")[0]
										.getAttribute("cimage2");
								const img2 = products[i]
										.getElementsByClassName("cl")[0]
										.getAttribute("cimage4");
								products[i]
										.getElementsByClassName("respon_image")[0]
										.setAttribute("src", img1);
								products[i]
										.getElementsByClassName("respon_image")[1]
										.setAttribute("src", img2);

								const productid = products[i]
										.getElementsByClassName("cl")[0]
										.getAttribute("productid");
								const ccolorcode = products[i]
										.getElementsByClassName("cl")[0]
										.getAttribute("ccolorcode");
								products[i]
										.getElementsByClassName("item_info1")[0]
										.setAttribute("href",
												"/product/productDetail?pid="
														+ productid
														+ "&ccolorcode="
														+ ccolorcode);
								products[i]
										.getElementsByClassName("item_info2")[0]
										.setAttribute("href",
												"/product/productDetail?pid="
														+ productid
														+ "&ccolorcode="
														+ ccolorcode);
							}

							$(".cl")
									.on(
											"click",
											function(e) {
												e.preventDefault();
												$(this)
														.closest("li")
														.find("img:eq(0)")
														.attr(
																"src",
																$(this)
																		.attr(
																				"cimage2"));
												$(this)
														.closest("li")
														.find("img:eq(1)")
														.attr(
																"src",
																$(this)
																		.attr(
																				"cimage4"));
												$(this)
														.closest("li")
														.find("a:eq(0)")
														.attr(
																"href",
																"/product/productDetail?pid="
																		+ $(
																				this)
																				.attr(
																						"productid"
																								+ "&ccolorcode="
																								+ ccolorcode));
											});

							$(".item_info1").hover(
									function() {
										$(this).find("img:eq(1)").css(
												"visibility", "visible");
										$(this).find("img:eq(1)").css(
												"opacity", 1);
										$(this).find(".item_size").css(
												"display", "block");
									},
									function() {
										$(this).find("img:eq(1)").css(
												"opacity", 0);
										$(this).find("img:eq(1)").css(
												"visibility", "hidden");
										$(this).find(".item_size").css(
												"display", "none");
									});

							$(".item_img").on("click", function(e) {
								console("페이지 이동");
								location.href = $(this).attr("alt");
							});

							$(".prev2").on(
									"click",
									function(e) {
										var clarge = $(".clarge").val();
										var cmedium = $(".cmedium").val();
										var csmall = $(".csmall").val();
										location.href = "/list?clarge="
												+ clarge + "&cmedium="
												+ cmedium + "&csmall=" + csmall
												+ "&pageNum=1";
									});

							$(".next2").on(
									"click",
									function(e) {
										var clarge = $(".clarge").val();
										var cmedium = $(".cmedium").val();
										var csmall = $(".csmall").val();
										var endpage = $(".realEnd").val();
										console.log(endpage);
										location.href = "/list?clarge="
												+ clarge + "&cmedium="
												+ cmedium + "&csmall=" + csmall
												+ "&pageNum=" + endpage;
									});

						});

		window.criteo_q = window.criteo_q || [];
		window.criteo_q.push({
			event : "setAccount",
			account : 24596
		}, {
			event : "setSiteType",
			type : "d"
		}, {
			event : "viewList",
			item : [ "SY2C4TTO047W", "CM2C4TTO340WP2", "MW2C4TTO509W" ]
		});
	</script>
</div>
<!-- //bodyWrap -->

<iframe height="0" width="0" title="Criteo DIS iframe"
	style="display: none;"></iframe>
<iframe height="0" width="0" title="Criteo DIS iframe"
	style="display: none;"></iframe>
</body>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>