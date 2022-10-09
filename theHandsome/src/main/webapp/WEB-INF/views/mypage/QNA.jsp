<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
 <!-- 
 /* 
 * 작성자 : 고정민
 * 
 * QNA 작성 페이지 (파일 첨부)
 */
  -->
<style type="text/css">
	#result_card img{
		max-width: 100%;
	    height: auto;
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;	
	}
	#result_card {
		position: relative;
	}
	.imgDeleteBtn{
		float : right;
	    background-color: #ef7d7d;
	    color: wheat;
	    font-weight: 900;
	    width: 30px;
	    height: 30px;
	    border-radius: 50%;
	    line-height: 26px;
	    text-align: center;
	    border: none;
	    display: block;
	    cursor: pointer;	
	}
	
</style>
<script>
$(document).ready(function(){
	// 로그인 안되어 있을 경우 로그인 페이지로 이동
	if("${sessionScope.member.mid }" == "") location.href='/member/login';
	else $('input[name=mid]').attr('value',"${sessionScope.member.mid }");
	
	$("#registerBtn").click(function() {
		// 제목 입력 필수
		if($('input[name=qtitle]').val() == "") {
			alert('제목을 입력해주세요.');
			return false;
		}
		
		$("#manToManInquiryForm").attr("action", "/mypage/QNA");
		$("#manToManInquiryForm").submit();	
	});
	
	// 첨부 파일 등록
	$("input[type='file']").on("change", function(e){
		let formData = new FormData();
		
		let fileInput = $('input[name="uploadFile"]');
		let fileList = fileInput[0].files;
		let fileObj = fileList[0];
		
		if(!fileCheck(fileObj.name, fileObj.size)){
			return false;
		}
		/* console.log($('input[name="uploadFile"]')); */
		$("#textManToManFile").val( $('input[name="uploadFile"]').val());
		/* console.log($("#textManToManFile").val()); */
		formData.append("uploadFile", fileObj);
		
		// 첨부 파일 등록 ajax 호출
		$.ajax({
			url: '/mypage/uploadImg',
	    	processData : false,
	    	contentType : false,
	    	data : formData,
	    	type : 'POST',
	    	dataType : 'json',
	    	success : function(result){
	    		console.log(result);
	    		showUploadImage(result);
	    	},
	    	error : function(result){
	    		alert("이미지 파일이 아닙니다.");
	    	}
		});	
	});
	/* var, method related with attachFile */
	let regex = new RegExp("(.*?)\.(jpg|png)$");
	let maxSize = 1048576; //1MB	
	
	function fileCheck(fileName, fileSize){

		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
			  
		if(!regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		
		return true;	
	}
	function showUploadImage(uploadResultArr){
		if(!uploadResultArr || uploadResultArr.length == 0){return}
		
		let uploadResult = $("#uploadResult");
		
		let obj = uploadResultArr[0];
		console.log(obj);
		
		let str = "";
		
		//let fileCallPath = obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName;
		let fileCallPath = obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName;
		
		// 미리보기
		str += "<div id='result_card'>";
		str += "<img src='/display?fileName=" + fileCallPath +"'>";
		str += "<div class='imgDeleteBtn'>x</div>";
		str += "</div>";		
		
   		uploadResult.append(str);     
	}
});

</script>
<div id="bodyWrap">
	<h3 class="cnts_title">
		<span>1:1 문의 하기</span>
	</h3>
	<div class="sub_container clearfix">
		<!-- lnbWrap -->
		<div class="iframe_lnb">
					<div class="lnb_wrap">
						<h4><a href="/svcenter/submain">고객센터<!-- 고객센터 --></a></h4>
								<div class="lnb">
									<p><a href="/ko/svcenter/notice">공지사항<!-- 공지사항 --></a></p>
									<p><a href="/ko/svcenter/mantomaninquiry" >1:1 문의 등록<!-- 1:1 문의하기 --></a></p>
									<p><a href="/ko/svcenter/faq">FAQ<!-- FAQ; --></a></p>
									<p><a href="/ko/svcenter/mending">수선진행조회<!-- 수선진행조회; --></a></p> 
									<p><a href="/ko/footer/vocProvision">고객의 소리</a></p>
									<!-- <p><a href="#;">APP 다운로드 소개</a></p> -->
									<dl>
										<dt>쇼핑 가이드</dt>
										<dd><a href="/ko/svcenter/memberjoinguide">회원 가입</a></dd>
										<dd><a href="/ko/svcenter/theClubInfo" >온라인 멤버십</a></dd>
										<dd><a href="/ko/svcenter/memberbenefitguide" >한섬 VVIP 혜택</a></dd>
										<dd><a href="/ko/svcenter/pointguide">한섬마일리지 혜택</a></dd>
										<dd><a href="/ko/svcenter/couponguide">쿠폰</a></dd>
										<dd><a href="/ko/svcenter/paymentguide">주문/결제</a></dd>
										<dd><a href="/ko/svcenter/asguide">배송/교환/반품/AS</a></dd>
									</dl>
								</div>
								<!-- ph_guide -->
								<div class="ph_guide">
									<p class="tlt">고객센터 운영 안내</p>
									<p class="phone">1800-5700<span style="color:#c69c6d;" class="txt">(유료)</span></p>
									<p class="txt">평일(월~금)<br/>am 09:00 ~ pm 18:00<span>토/일, 공휴일 휴무</span></p>
									<a href="mailto:shophelp@thehandsome.com" >shophelp<br/>@thehandsome.com</a>
								</div>
								<!-- //ph_guide -->
							</div>
				</div><!-- //lnbWrap -->
		<div class="sub_cnts">
			<div class="title_wrap mt30 clearfix">
				<h4 class="float_left">1:1 문의 등록</h4>
				<p class="reqd_txt"><strong class="reqd">*</strong> 표시는 필수항목입니다.</p>
			</div>
			<!-- <form id="manToManInquiryForm" name="manToManInquiryForm" action="/ko/svcenter/mantomaninquiry?refererUrl=" method="post" enctype="multipart/form-data"><input type="hidden" id="orderPk" name="orderPk" /> -->
			<form id="manToManInquiryForm" name="manToManInquiryForm" method="post" enctype="multipart/form-data"><input type="hidden" id="orderPk" name="orderPk" />
				<input type="hidden" id="pkInquiry" name="pkInquiry" />
				<input type="hidden" id="mobilePhoneNumber" name="mobilePhoneNumber" value="" />
				<input type="hidden" id="emailAddress" name="emailAddress" value="" />
				<fieldset>
					<legend>1:1 문의 입력</legend>
					<div class="tblwrap">
						<table class="tbl_wtype1">
							<caption>1:1 문의 입력</caption>
							<colgroup>
								<col style="width:140px"/>
								<col />
							</colgroup>
							<tbody>
								<tr>
										<th scope="row"><strong class="reqd">*</strong>문의 항목</th>
										<td class="storeQue">
											<p>더한섬닷컴 문의</p>
											<a href="javascript:viewPopup('#storeQue_popwrap');" class="storeQue_btn">오프라인 매장 문의></a>
										</td>
									</tr>
								<tr>
									<th scope="row"><strong class="reqd">*</strong>문의 종류</th>
									<td>
										<select id="largeClassificationCode" name="largeClassificationCode" title="대분류 선택" style="width:160px">
											<option value="">대분류</option>
											<option value="">행사/이벤트</option>
											<option value="">쿠폰/혜택문의</option>
											<option value="">주문/확인취소</option>
											<option value="">웨딩 프로모션</option>
											<option value="">온라인수선</option>
											<option value="">오프라인 문의</option>
											<option value="">오에라 문의</option>
											<option value="">상품문의</option>
											<option value="">배송관련</option>
											<option value="">반품</option>
											<option value="">기프트카드문의</option>
											<option value="">기타</option>
											<option value="">교환</option>
											<option value="">고객정보</option>
											<option value="">결제/환불문의</option>
											<option value="">현대카드 레드바우처 문의</option>
											<option value="">SYSTEM X BTS 문의</option>
										</select>
										</td>
								</tr>
								<tr>
									<th scope="row"><strong class="reqd">*</strong>문의제목</th>
									<td>
										<input type="hidden" id="mid" name="mid">
										<input type="text" id="qtitle" name="qtitle" title="문의제목" class="w_all" />
									</td>
								</tr>
								<tr>
									<th scope="row">
										<strong class="reqd">*</strong>문의 내용<span class="com_txt_p">(2000자 이하)</span>
									</th>
									<td>
										<!-- textarea -->
										<textarea id="qcontent" name="qcontent" title="문의내용" cols="30" rows="10" placeholder=""></textarea>
										<!-- //textarea -->
									</td>
								</tr>
								<!-- popup end -->
								
								<tr>
									<th  scope="row" class="th_space">사진등록</th>
									<td>
										<!-- File upload -->
										<div class="file_upload">
											<input type="text" id="textManToManFile" class="text" title='파일 첨부하기' readonly="readonly" name="fileText" />
											<div class="upload_btn">
												<button type="button" id="uploadFile" class="img_upload" title='파일찾기'><span>파일찾기</span></button>
												<!-- <input type="file" name="file" id="qnaImg" class="btn add_s" title='파일찾기' /> -->
												<input type="file" name="uploadFile" id="qnaImg" class="btn add_s" title='파일찾기' />
											</div>
										</div>
										<p class="txt_guide">10MB 미만의 jpg,gif,png 파일만 첨부하실 수 있습니다.</p>
										<div class="select_img"><img src=""/></div>
										<script>
										// 첨부파일 미리보기
											$("#qnaImg").change(function() {
												if(this.files && this.files[0]) {
													var reader = new FileReader();
													reader.onload = function(data) {
													     $(".select_img img").attr("src", data.target.result).width(500);        
													    }
													    reader.readAsDataURL(this.files[0]);
													   }
													  });
											
													 </script>
										<!-- //File upload -->
									</td>
								</tr>
								<tr>
									<th  scope="row" class="th_space">SMS 알림받기</th>
									<td>
										<!-- hp -->
										<select id="hp1" name="hp1" title="휴대폰 번호 앞자리" class="hp_num1">
											<option value="">선택</option>
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="016">016</option>
											<option value="017">017</option>
											<option value="018">018</option>
											<option value="019">019</option>
										</select>
										<div class="form_hyphen">-</div>
										<input type="text" id="hp2" name="hp2" value="9883" title="휴대폰 번호 가운데자리" class="hp_num2" numberonly="true" maxlength="4" />
										<div class="form_hyphen">-</div>
										<input type="text" id="hp3" name="hp3" value="3753" title="휴대폰 번호 뒷자리" class="hp_num2" numberonly="true" maxlength="4" />
										<!-- //hp -->
										<!-- check -->
										<span class="wtype_comment pt10">
											<input type="checkbox" id="smsAlarmReceiveYN" name="smsAlarmReceiveYN" class="mr5"/><label for="ck1">SMS 알람고지</label>
										</span>
										<!-- //check -->
									</td>
								</tr>
								<tr>
									<th scope="row"><strong class="reqd">*</strong>이메일 답변받기</th>
									<td>
										<!-- email -->
										<input type="text" id="email" name="email" value="gjm1026" title="이메일 아이디" class="em_form"/> 
										<span class="andmail">@</span>
										<input type="text" id="emailDomain" name="emailDomain" value="naver.com" title="이메일 도메인" class="em_form"/>
										<select id="uidDomainSel" name="uidDomainSel" class="em_select">
											<option value="">직접입력</option>
											<option value="naver.com">naver.com</option>
											<option value="daum.net">daum.net</option>
											<option value="yahoo.co.kr">yahoo.co.kr</option>
											<option value="lycos.co.kr">lycos.co.kr</option>
											<option value="nate.com">nate.com</option>
											<option value="empas.com">empas.com</option>
											<option value="hotmail.com">hotmail.com</option>
											<option value="msn.com">msn.com</option>
											<option value="gmail.com">gmail.com</option>
											<option value="hanmir.com">hanmir.com</option>
											<option value="chol.net">chol.net</option>
											<option value="korea.com">korea.com</option>
											<option value="netsgo.com">netsgo.com</option>
											<option value="dreamwiz.com">dreamwiz.com</option>
											<option value="hanafos.com">hanafos.com</option>
											<option value="freechal.com">freechal.com</option>
											<option value="hitel.net">hitel.net</option>
										</select>
										<!-- //email -->
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- btn -->
					<div class="btnwrap">
						<input type="button" id="cancleBtn" value="취소" class="btn wt">
						<input type="button" id="registerBtn" value="등록" class="btn gray mr0">
						</div>
					<!-- //btn -->
				</fieldset>
			<div>
<input type="hidden" name="CSRFToken" value="b44478b9-4671-4b50-a76d-392ac8ea118d" />
</div></form><ul class="bul_sty01_li mt60">
 			<li>문의하신 내용에 대한 답변은 이메일 또는 <a href='/ko/mypage/mymantomaninquiry'><em class="ft_point01">마이페이지 &gt; 1:1 문의내역</em></a>에서 확인하실 수 있습니다. </li>
				<li>SMS 문자와 이메일로 답변 완료 알림을 받아보실 수 있습니다.</li>
			</ul>
			</div>
	</div>
</div>

<%@ include file="../includes/footer.jsp"%>
