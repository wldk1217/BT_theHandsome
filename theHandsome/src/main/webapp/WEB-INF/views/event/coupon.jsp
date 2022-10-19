<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<script>
function alert() {
	
	alret('쿠폰이 발급되었습니다.')	
}
</script>
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
					<button
						type ="button"
						style="border: 2px black dot; border-radius: 40%; background-color: ivory; width: 160px; heigth: 200px; font-size: 20px; font-weight: bold;"
						onclick= "location.href = '/controller/event/makecoupon'">
						쿠폰 발급받기</button>
				</div>
			</div>


			<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</html>