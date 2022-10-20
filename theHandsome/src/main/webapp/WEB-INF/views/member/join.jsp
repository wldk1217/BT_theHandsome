<!-- 김민선 생성 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>

<form id ="join_form" action="/member/join" method="POST">

<!--  
	<input type="hidden" name="emailDuplChk" id="emailDuplChk" value=""title="이메일 중복" /> 
	<input type="hidden" name="pwTypeChk" id="pwTypeChk" value="" title="비밀번호 형식" />
	<input type="hidden" name="pwConfirmChk" id="pwConfirmChk" value="" title="비밀번호 일치" />
	<input type="hidden" id="uid" name="uid" value="gjm1026@naver.com" /> 
	<input type="hidden" id="emailAddress" name="emailAddress" value="" /> 
	<input type="hidden" id="sBirthday" name="sBirthday" value="" /> 
	<input type="hidden" id="gender" name="gender" value="" /> 
	<input type="hidden" id="collectionAgreementYN" name="collectionAgreementYN" value="" />
-->

	<div id="bodyWrap">
		<!--title-->
		<h3 class="cnts_title">
			<span>회원가입</span>
		</h3>
		<div class="sub_container">
			<div class="join_title">
				<p class="title" style="margin-top: 30px;">고객님의 회원정보를 입력해주세요.</p>
			</div>
			<fieldset>
				<legend>회원정보입력</legend>
				<div class="box_type_1">
					<div class="title_wrap clearfix">
						<h4 class="float_left">회원정보</h4>
						<p class="reqd_txt float_right">
							<strong class="reqd">*</strong> 표시는 필수항목입니다.
						</p>
					</div>
					<div class="tblwrap">
						<table class="tbl_wtype1">
							<caption>회원가입 입력항목</caption>
							<colgroup>
								<col style="width: 160px" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><strong class="reqd">*</strong><label
										for="mid">아이디</label></th>
									<td><input type="text" style="width: 120px" id="id"
										name='mid' /></td>
								</tr>
								<tr>
									<th scope="row"><label for="email">E-mail (정보수신용)</label></th>
									<td><input type="hidden" id="mid" name='memail' ><input
										type="hidden" id='memail' > <input
										type="text" style="width: 120px" title="이메일" id="email">
										<span class="andmail">@</span> <select id="emailDomainSel"
										style="width: 120px" title="이메일">
											<option value="">직접입력</option>
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
									</select> 
									<!-- 
									<input type="text" id="emailDomain" style="width: 120px"
										value="" title="이메일 도메인"> 
										 
										<input type="button"
										class="btn add_s" id="emailDubChkBtn" value="중복확인"
										onclick="checkId()"> <span class="guide_comment"
										id="emailMsg"></span>
										<div class="wtype_comment pt10">
											<p class="login_err_txt" id="id_ok"
												style="margin-left: 0px; color: brown; display: none">사용
												가능한 이메일입니다.</p>
											<p class="login_err_txt" id="id_already"
												style="margin-left: 0px; color: brown; display: none">이미
												사용중인 이메일입니다.</p>
										</div>
										-->
										</td>
								</tr>
								<tr>
									<th scope="row"><strong class="reqd">*</strong><label
										for="pw">비밀번호</label></th>
									<td><input type="password" id="pw" name='mpassword'
										style="width: 150px" title="비밀번호" /> <span
										class="guide_comment lh_30" id="pwMsg"></span> <span
										class="guide_comment lh_30" id="pwcapsLockMsg"></span></td>
								</tr>
								<!-- 
								<tr>
									<th scope="row"><strong class="reqd">*</strong> <label
										for="pw2">비밀번호 확인</label></th>
									<td><input type="password" id="pwc" style="width: 150px"
										title="비밀번호 확인" /> <span class="guide_comment" id="pwcMsg"></span>
										<span class="guide_comment" id="pwcCapsLockMsg"></span></td>
								</tr>
								 -->
								<tr>
									<th scope="row"><strong class="reqd">*</strong><label
										for="name">이름</label></th>
									<td><input type="text" style="width: 120px" id="name"
										name='mname' /></td>
								</tr>
								<tr>
									<th scope="row"><strong class="reqd">*</strong><label
										for="mtel">전화번호</label></th>
									<td><input type="text" style="width: 120px" id="name"
										name='mtel' /></td>
								</tr>
								<tr>
									<th scope="row"><strong class="reqd">*</strong><label
										for="mzipcode">우편번호</label></th>
									<td><input type="text" style="width: 120px" id="mzipcode"
										name='mzipcode' /></td>
								</tr>
								<tr>
									<th scope="row"><strong class="reqd">*</strong><label
										for="maddress1">주소</label></th>
									<td><input type="text" style="width: 120px" id="maddress1"
										name='maddress1' /></td>
								</tr>
								<tr>
									<th scope="row"><strong class="reqd">*</strong><label
										for="maddress2">상세 주소</label></th>
									<td><input type="text" style="width: 120px" id="maddress2"
										name='maddress2' /></td>
								</tr>
							</tbody>
						</table>
					</div>


					<div class="btnwrap">
						<input type="button" value="취소" class="btn wt" id="cancleBtn"
							onClick="location.href='login'" /> 
						<button type ="submit" id="join_button" class="btn gray mr0">회원가입</button>
						
					</div>
				</div>
			</fieldset>
		</div>
		<!--//sub container-->
	</div>
</form>


<!-- footerWrap 
<script>
	$(document).ready(function() {
		//회원가입 버튼(회원가입 기능 작동)
		$("#join_button").click(function() {
			$("#join_form").attr("action", "/member/join");
			$("#join_form").submit();
		});
	});
</script>
-->
<%@ include file="/WEB-INF/views/common/footer.jsp"%>