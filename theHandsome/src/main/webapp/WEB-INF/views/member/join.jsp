<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>


	<form id="join_form" method="post">
		<input type="hidden" name="emailDuplChk" id="emailDuplChk" value=""
			title="이메일 중복" /> <input type="hidden" name="pwTypeChk"
			id="pwTypeChk" value="" title="비밀번호 형식" /> <input type="hidden"
			name="pwConfirmChk" id="pwConfirmChk" value="" title="비밀번호 일치" /> <input
			type="hidden" id="uid" name="uid" value="gjm1026@naver.com" /> <input
			type="hidden" id="emailAddress" name="emailAddress" value="" /> <input
			type="hidden" id="sBirthday" name="sBirthday" value="" /> <input
			type="hidden" id="gender" name="gender" value="" /> <input
			type="hidden" id="collectionAgreementYN" name="collectionAgreementYN"
			value="" />


		<div id="bodyWrap">
			<!--title-->
			<h3 class="cnts_title">
				<span>회원가입</span>
			</h3>
			<div class="sub_container">
				<div class="join_title">
					<p class="title" style="margin-top:30px;">고객님의 회원정보를 입력해주세요.</p>
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
										<th scope="row"><label for="email">E-mail (정보수신용)</label></th>
										<td><input type="hidden" id="mid" name="mid"><input type="hidden" id="memail" name="memail">
										<input type="text" style="width: 120px" title="이메일"
											id="email"> <span class="andmail">@</span> <select
											id="emailDomainSel" style="width: 120px" title="이메일">
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
										</select> <input type="text" id="emailDomain" style="width: 120px"
											value="" title="이메일 도메인"> <input type="button"
											class="btn add_s" id="emailDubChkBtn" value="중복확인" onclick="checkId()"> <span
											class="guide_comment" id="emailMsg"></span>
											<div class="wtype_comment pt10">
											<p class="login_err_txt" id="id_ok" style="margin-left: 0px; color:brown; display:none">사용 가능한 이메일입니다. </p>
											<p class="login_err_txt" id="id_already" style="margin-left: 0px; color:brown; display:none">이미 사용중인 이메일입니다. </p>
											</div>
											<div class="wtype_comment pt10">
												<input type="checkbox" id="ck1" /><label for="ck1">이메일
													아이디 적용</label>
											</div>
											<div class="wtype_comment pt5">
												<input type="checkbox" id="emailReceiveYn"
													name="emailReceiveYn" value="Y" /><label
													for="emailReceiveYn">이메일을 통한 상품 및 이벤트 정보 수신에 동의합니다.
													(선택)</label> <a href="javascript:void(0);"
													class="email-prev-detail-btn">자세히 보기</a>
											</div></td>
									</tr>
									<tr>
										<th scope="row"><strong class="reqd">*</strong><label
											for="pw">비밀번호</label></th>
										<td><input type="password" id="pw" name="mpassword"
											style="width: 150px" title="비밀번호" /> <span
											class="guide_comment lh_30" id="pwMsg"></span> <span
											class="guide_comment lh_30" id="pwcapsLockMsg"></span></td>
									</tr>
									<tr>
										<th scope="row"><strong class="reqd">*</strong> <label
											for="pw2">비밀번호 확인</label></th>
										<td><input type="password" id="pwc" style="width: 150px"
											title="비밀번호 확인" /> <span class="guide_comment" id="pwcMsg"></span>
											<span class="guide_comment" id="pwcCapsLockMsg"></span></td>
									</tr>
									
									<tr>
										<th scope="row"><strong class="reqd">*</strong><label
											for="name">이름</label></th>
										<td><input type="text" style="width: 120px" id="name"
											name="mname" /></td>
									</tr>
									<tr>
										<th scope="row"><strong class="reqd">*</strong><label
											for="mtel">전화번호</label></th>
										<td><input type="text" style="width: 120px" id="name"
											name="mtel" /></td>
									</tr>
									<tr>
										<th scope="row"><strong class="reqd">*</strong><label
											for="mzipcode">우편번호</label></th>
										<td><input type="text" style="width: 120px" id="mzipcode"
											name="mzipcode" /></td>
									</tr>
									<tr>
										<th scope="row"><strong class="reqd">*</strong><label
											for="maddress1">주소</label></th>
										<td><input type="text" style="width: 120px" id="maddress1"
											name="maddress1" /></td>
									</tr>
									<tr>
										<th scope="row"><strong class="reqd">*</strong><label
											for="maddress2">상세 주소</label></th>
										<td><input type="text" style="width: 120px" id="maddress2"
											name="maddress2" /></td>
									</tr>
								</tbody>
							</table>
						</div>


						<div class="btnwrap">
							<input type="button" value="취소" class="btn wt" id="cancleBtn" onClick="location.href='login'" />
							<input type="button" id="join_button" value="회원가입" class="btn gray mr0" />
						</div>
					</div>
				</fieldset>
			</div>
			<!--//sub container-->
		</div>

		<div class="layerArea email-detail-pop" style="display: none;">
			<div class="layerBg"></div>
			<div class="popwrap w_type_11">
				<div class="terms_box box_type_2">
					■ 개인정보의 수집항목 및 이용<br>
					<br> 더한섬닷컴은 별도의 회원가입 절차 없이 대부분의 컨텐츠에 자유롭게 접근할 수 있습니다. 더한섬닷컴의
					서비스를 이용하시는 경우 다음의 정보를 고객의 동의를 받아 수집할 수 있으며 선택항목을 입력하지 않아도 서비스 이용에
					제한은 없습니다.<br>
					<br> <span
						style="color: #000; display: block; margin-bottom: 12px;">회원가입
						및 주문 등 필요시점에 수집하는 개인정보의 범위</span>
					<table class="tbl_ltype">
						<caption>회원가입 및 주문 등 필요시점에 수집하는 개인정보의 범위</caption>
						<colgroup>
							<col style="width: auto">
							<col style="width: 202px;">
							<col style="width: 103px;">
							<col style="width: 254px;">
							<col style="width: auto;">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">수집 방법</th>
								<th scope="col">이용 목적</th>
								<th scope="col">수집 정보</th>
								<th scope="col">수집 항목</th>
								<th scope="col">보유 기간</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="frt">간편회원가입</td>
								<td><strong>신규서비스/상품안내</strong></td>
								<td>선택</td>
								<td>이메일</td>
								<td>회원 탈퇴 시 또는 동의 철회 시</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div>
		</div>
	</form>
	<!-- footerWrap -->
<script>

$(document).ready(function(){
	//회원가입 버튼(회원가입 기능 작동)
	$("#join_button").click(function(){
		$("#join_form").attr("action", "/member/join");
		$("#join_form").submit();
	});
});

</script>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>