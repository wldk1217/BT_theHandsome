<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
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
						<form id="loginForm" name="loginForm" method="POST" action="login">
							<input type="hidden" name="inputId" id="inputId" value="" />
							<fieldset>
								<legend>로그인 입력항목</legend>
								<div class="login_section">

									<p class="login_err_txt" id="hpErrMsg"
										style="margin-left: 0px;"></p>
									<div>
										<div>
											<input style="width: 400px; margin-top: 30px;" type="text"
												id="userid" name="userid"
												placeholder="아이디 / 이메일을 입력하세요." title="아이디" value="" />
										</div>
										<div>
											<input style="width: 400px; margin-top: 10px;" type="password"
												id="passwd" name="passwd" placeholder="비밀번호를 입력하세요."
												title="비밀번호" />
										</div>
										<div>
											<!-- <a onclick="/member/login" class="btn add_ss join" 
												style="margin-top: 10px; width:380px;">로그인</a> -->
												
											<button type="submit" >로그인</button>
										</div>
									</div>

									<div class="id_save">
										<input type="checkbox" id="id_save" name="id_save" value="Y">
										<label for="id_save">아이디 저장</label>
									</div>
								</div>
							</fieldset>

						</form>
					</div>
					<div class="section_bottom">
						<p>
							<span class="bul_sty01" style="margin-bottom:30px;">H.Point 통합회원 아이디 / 비밀번호를 잊으셨나요?</span> <a
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
					<a href="https://www.h-point.co.kr/cu/join/start.nhd" id="hpoinJoinBtn"
						class="btn add_ss join" style="margin-bottom: 40px; width: 366px;">통합회원 가입</a>
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
						<a  href="/member/join" class="btn add_ss join"
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

<%@ include file="/WEB-INF/views/common/footer.jsp"%>