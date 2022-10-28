<!-- 
/*****************************************************
 * @function : login.jsp
 * @author : 구영모, 심지연 공동작업
 * 1차 작업: 심지연 login.jsp 최초 생성
 * 2차 작업: 구영모 시큐리티 적용
 * @Date : 2022.10.18
 *****************************************************/
 -->
 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="shortcut icon"
	href="http://cdn.thehandsome.com/_ui/desktop/common/images/common/thehandsome_ic_16x16.ico" />
<link rel="stylesheet" type="text/css"
	href="../../../resources/css/font_80.css" media="all" />

<link rel="stylesheet" type="text/css"
	href="../../../resources/css/common.css" media="all" />
<link rel="stylesheet" type="text/css"
	href="../../../resources/css/layout.css" media="all" />
<link rel="stylesheet" type="text/css"
	href="../../../resources/css/popup.css" media="all" />
<link rel="stylesheet" type="text/css"
	href="../../../resources/css/jquery-ui.min.css" media="all" />

<link rel="stylesheet" type="text/css"
	href="../../../resources/css/brand.css" media="all" />
<link rel="stylesheet" type="text/css"
	href="../../../resources/css/swiper.css" media="all" />
<link rel="stylesheet" type="text/css"
	href="../../../resources/css/main_201903.css" media="all" />
<link rel="stylesheet" type="text/css"
	href="../../../resources/css/footer.css" media="all" />
<style type="text/css" media="print">
@IMPORT url("../../../resources/blueprint/print.css");
</style>
<script type="text/javascript"
	src="../../../resources/js/jquery-1.11.2.min.js"></script>
<script type="text/javascript"
	src="../../../resources/js/jquery.vticker.js"></script>

<input type="hidden" name="loginLayer" id="loginLayer" value="E" />
<div id="bodyWrap" class="login">
	<h3 class="cnts_title">
		<span>로그인</span>
	</h3>
	<div class="sub_container">
		<div id="handsomeCust" class="login_wrap box_type_1 renewal1904">
			<div class="border_box1">
				<div class="inner_box">
					<div class="title_wrap">
						<h4>회원</h4>
					</div>
					<div id="hpIPLogin">
						<!-- 폼 끝 -->
						<form id="login_form" method="post">
							<input type="hidden" name="inputId" id="inputId" value="">
							 <!-- 구영모: 시큐리티 적용 -->
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							<fieldset>
								<legend>로그인 입력항목</legend>
								<div class="login_section">
									<p class="login_err_txt" id="hpErrMsg"
										style="margin-left: 0px; margin-bottom: 35px;"></p>
									<div>
										<div> 
											<input class="id_input" name="username" type="text"
												id="j_username" placeholder="아이디 입력하세요." title="아이디"
												value="" style="width: 410px; height: 35px; ">
										</div>
										<div>
											<input class="pw_iput" name="password" type="password"
												id="j_password" placeholder="비밀번호를 입력하세요." title="비밀번호"
												style="width: 410px; height: 35px; margin-top: 5px;">
										</div>
									</div>

									<div class="login_button_wrap" style="width: 410px; height: 35px; padding-top: 25px;">
										<input type="button" class="login_button btn add_ss join " value="로그인" style="width: 410px; height: 35px; ">
									</div>
								</div>
							</fieldset>
				
						</form>
					</div>
					<div class="section_bottom">
						<p>
							<span class="bul_sty01" style="margin-bottom: 30px;">H.Point
								통합회원 아이디 / 비밀번호를 잊으셨나요?</span> <a
								href="https://www.h-point.co.kr/cu/config/findCustId.nhd?prtnrId=D080&chnnlId=1705"
								target="_blank" class="btn add_ss">통합회원 아이디 찾기</a> <a
								href="https://www.h-point.co.kr/cu/config/findCustPwd.nhd"
								target="_blank" class="btn add_ss">통합회원 비밀번호 찾기</a>
						</p>
						<p class="mb0">
							<span class="bul_sty01">한섬 회원 아이디 / 비밀번호를 잊으셨나요?</span> <a
								href="/ko/member/findIdPwPage" class="btn add_ss">한섬 회원 아이디
								/ 비밀번호 찾기</a>
						</p>
					</div>
				</div>
			</div>
			<div class="border_box2">
				<!-- 추가 190417 -->
				<div class="inner_box step2">
					<div class="title_wrap">
						<h4 class="tlt_typ1">H.Point 통합회원 가입</h4>
						<p class="txt">현대백화점 그룹의 모든 서비스를 모두 이용할 수 있는 ID를 만듭니다.</p>
						<p class="join_txt2 mt10">
							한섬 온라인/오프라인 매장에서 모두 사용하실 수 있으며, 구매 시 <br />한섬마일리지가 적립됩니다.<br />한섬
							온라인 멤버십 ‘THE 클럽’의 혜택을 받으실 수 있습니다
						</p>
					</div>
					<a href="https://www.h-point.co.kr/cu/join/start.nhd"
						id="hpoinJoinBtn" class="btn add_ss join"
						style="margin-bottom: 40px; width: 366px;">통합회원 가입</a>
					<div class="title_wrap">
						<h4 class="tlt_typ1">더한섬닷컴 간편회원 가입</h4>
						<p class="txt" style="line-height: 1.5;">
							본인인증 절차 없이, 더한섬닷컴에서 제공하는 서비스만 제한적으로<br />이용할 수 있는 ID를 만듭니다.
						</p>
						<p class="join_txt2 mt10">
							더한섬닷컴에서 사용 가능하며, 오프라인 매장에서는 사용할 수 없습니다.<br /> <span>한섬마일리지와
								현대백화점그룹 H.Point 혜택, 한섬의 온라인 멤버십 서비스<br />‘THE 클럽’의 혜택은 제공되지
								않습니다.
							</span>
						</p>
					</div>
					<div class="title_wrap hide" id="eg_block">
						<a href="/member/join" class="btn add_ss join"
							style="width: 366px">간편회원 가입</a>
						<p class="join_txt2 mt20">
							<span>※ 간편회원은 e-Gift Card 구매 및 등록이 불가능합니다.<br>통합회원 가입
								후 이용해 주세요.
							</span>
						</p>
					</div>
				</div>
			</div>
		</div>
		<!--//login wrap-->
	</div>
	<!--//sub_container-->

</div>
<script>
	/* 로그인 버튼 클릭 메서드 */
	$(".login_button").click(function() {
		/* 로그인 메서드 서버 요청 */
		$("#login_form").attr("action", "/member/login");
		$("#login_form").submit();
	});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>