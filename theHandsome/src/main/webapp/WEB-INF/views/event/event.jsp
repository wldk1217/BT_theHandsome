<!-- 
/*****************************************************
 * @function : event.jsp
 * @author : 김민선
 * @Date : 2022.10.20
 *****************************************************/
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
	
<% 
    String ctx = request.getContextPath();    
    pageContext.setAttribute("ctx", ctx);
%>


<!DOCTYPE html>
<html lang="ko">
<header>
	<script>
</script>
</header>

<body>
	<!-- bodyWrap -->
	<div id="bodyWrap" class="products">
		<!--title-->
		<h3 class="cnts_title">
			<span> 이벤트 </span>
		</h3>
		<!--//title-->
		<div class="adaptive_wrap">
			<div class="tab_b event_tab">
				<ul id="tab">
					<li><a style="cursor: pointer"
						onclick="GA_Event('이벤트', '탭', this.text);changeTab(this, false);"
						class="on">진행 중인 이벤트</a></li>
					<li><a style="cursor: pointer"
						onclick="GA_Event('이벤트', '탭', this.text);changeTab(this, true);">지난
							이벤트</a></li>

				</ul>
			</div>

			<div role="wrapper">
				<div class="event_list" id="contentsInProgress">
					<div class="event_box col1" style="" data-last="15">
						<a href="#">
							<div class="pic">
								<img
									src="http://cdn.thehandsome.com/pc/event/list/banner/20220927_50847413914033207_ko.jpg"
									data-full="http://cdn.thehandsome.com/pc/event/list/banner/20220927_50847413914033207_ko.jpg"
									data-half="http://cdn.thehandsome.com/pc/event/list/banner/20220927_50847414081375558_ko.jpg">
							</div>

			                                                                                    			</a>
					</div>
					<div class="event_box col2" style="" data-last="15">
						<a href="#"
							onclick="GA_EventList($(this));goDetail('/ko/magazine/events/8804547221376');">
							<div class="pic">
								<img
									src="http://cdn.thehandsome.com/pc/event/list/banner/20221005_51597963797616851_ko.jpg"
									data-full="http://cdn.thehandsome.com/pc/event/list/banner/20221005_51597963683822415_ko.jpg"
									data-half="http://cdn.thehandsome.com/pc/event/list/banner/20221005_51597963797616851_ko.jpg">
								<img
									style = "padding-left: 10px; "
									src="http://cdn.thehandsome.com/pc/event/list/banner/20220930_51105538839875272_ko.jpg"
									data-full="http://cdn.thehandsome.com/pc/event/list/banner/20220930_51105538694910ㅍ126_ko.jpg"
									data-half="http://cdn.thehandsome.com/pc/event/list/banner/20220930_51105538839875272_ko.jpg">
							</div>

						</a>
					</div>

					<div class="event_box col2" style="" data-last="15">
						<a href="#">
							<div class="pic">
								<img 
									src="${ctx}/resources/images/event/dog.png"
									onclick ="javascript:location.href='/event/coupon'"/>
								<img
									style = "padding-left: 10px; "
									src="http://cdn.thehandsome.com/pc/event/list/banner/20220928_50936344591474494_ko.jpg"
									data-full="http://cdn.thehandsome.com/pc/event/list/banner/20220928_50936344486516402_ko.jpg"
									data-half="http://cdn.thehandsome.com/pc/event/list/banner/20220928_50936344591474494_ko.jpg">
							</div>
							
						</a>
					</div>
				
					<div class="event_box col1" style="" data-last="15">
						<a href="#"
							onclick="GA_EventList($(this));goDetail('/ko/magazine/events/8799861397376');">
							<div class="pic">
								<img
									src="http://cdn.thehandsome.com/pc/event/list/banner/20191001_33122121401805255_ko.jpg"
									data-full="http://cdn.thehandsome.com/pc/event/list/banner/20191001_33122121401805255_ko.jpg"
									data-half="http://cdn.thehandsome.com/pc/event/list/banner/20200206_44169766487982960_ko.jpg">
							</div>
							
						</a>
					</div>
				</div>
				<div class="morewrap" style="display: none;">
					<a style="cursor: pointer" onclick="getEvents(this, false);">더보기</a>
				</div>
			</div>
		</div>
		<!-- //bodyWrap -->
		

		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</html>