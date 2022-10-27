<!-- 
/*****************************************************
 * @function : coupon.jsp
 * @author : 김민선
 * @Date : 2022.10.20
 *****************************************************/
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<!DOCTYPE html>
<html lang="ko" xmlns:th="http://www.thymeleaf.org">
<head>
	    <meta charset="UTF-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body oncontextmenu='return false'>

	<div id="bodyWrap" class="products">
		<!--title-->
		<h3 class="cnts_title">
			<span> 이벤트 </span>
		</h3>
		<!--//title-->
		<div class="sub_container">
			<div class="mgz_view">

				<div class="evt_cnts">
					<div class="pic">

						<div class="event-pc-handsome-haus-2021-09-15">
							<img style="width: 100%; display: block;"
								src="http://cdn.thehandsome.com/pc/event/detail/image/handsome_202109/event_handsomehausgate_pc_img_01_01.jpg"
								alt="" />
						</div>
					</div>
				</div>

			</div>
			<div style=" padding-top: 30px;  display: flex; justify-content: center;">
				
				<div style= "height: 200px;">
				<form action="/event/makecoupon" method ="POST"  name="coupon_form">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					<input type="hidden" id="mid" name="mid" value="${memid}">
					<button
						type ="submit" 
						style="border: 2px black dot; border-radius: 40%; background-color: ivory; width: 160px; heigth: 200px; font-size: 20px; font-weight: bold;">
						쿠폰 발급받기</button>
				</form>
				</div>
			</div>


			<%@ include file="/WEB-INF/views/common/footer.jsp"%>
			

</html>