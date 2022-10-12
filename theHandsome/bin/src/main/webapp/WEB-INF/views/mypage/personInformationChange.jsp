<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ include file="../includes/header.jsp"%>
 <!-- 
 /* 
 * 작성자 : 고정민
 * 
 * 회원 정보 변경 페이지
 */
  -->
<script>
    $(document).ready(function () {
    	// 회원정보 변경 시 기존 비밀번호 확인 절차
        $("#saveBtn").click(function () {
            if ($("#oldpw").val() == "") {
                alert("기존 비밀번호를 입력해주세요.");
                return;
            }

            if ($("#oldpw").val() != "${sessionScope.member.mpassword}") {
                alert("기존 비밀번호를 확인해주세요.");
                return;
            }
            if ($("#mpassword").val() != $("#pwcheck").val()) {
                alert("비밀번호가 일치하지 않습니다.");
                return;
            }

            if ($("#mpassword").val() == "") {
                $("input[name=mpassword]").attr("value", "${sessionScope.member.mpassword}");
            }
            $("#updateProfileForm").attr("action", "/mypage/personInformationChange");
            $("#updateProfileForm").submit();
        });
		
    	// 회원 탈퇴 ajax 호출
        $("#memberSecessionBtn").click(function () {
            if (confirm("회원 탈퇴를 하시겠습니까?") == true) {
                $.ajax({
                    url: "/mypage/memberWithdrawal",
                    type: "post",
                    data: {
                        mid: "${sessionScope.member.mid}",
                    },
                    async: false,
                    success: function (result) {
                        alert('탈퇴되었습니다.');
                        location.href="/";
                    },
                    error: function () {
                        alert("에러입니다");
                    },
                });
            } else return false;
        });
    });
</script>
<div id="bodyWrap">
    <h3 class="cnts_title">
        <span id="menuTitle"></span>
    </h3>
    <div class="sub_container">
        <!-- lnb -->
        <div class="lnb_wrap">
            <h4>
                <a href="/ko/mypage">마이페이지<!-- 마이페이지 --></a>
            </h4>
            <div class="lnb">
                <dl>
                    <dt>주문조회</dt>
                    <dd>
                        <a href="/ko/mypage/order/myorders" onclick="GA_Event('마이페이지','LNB','주문/배송/반품/취소');">주문/배송/반품/취소</a>
                    </dd>
                </dl>
                <dl>
                    <dt>혜택관리</dt>
                    <dd>
                        <a href="/ko/mypage/myGradeInfo" onclick="GA_Event('마이페이지','LNB','나의 회원 등급');">나의 회원 등급</a>
                    </dd>
                    <dd>
                        <a href="/ko/mypage/voucher" onclick="GA_Event('마이페이지','LNB','나의 쿠폰');">나의 쿠폰<!-- 쿠폰함 --></a>
                    </dd>
                    <dd>
                        <a href="/ko/mypage/mypoint" onclick="GA_Event('마이페이지','LNB','나의 한섬마일리지');">나의 한섬마일리지</a>
                    </dd>
                    <dd>
                        <a href="/ko/mypage/myEGiftCard" onclick="GA_Event('마이페이지','LNB','E-GIFT CARD');">e-Gift Card</a>
                    </dd>
                </dl>
                <dl>
                    <dt>나의 상품관리</dt>
                    <dd>
                        <a href="/ko/mypage/myWish" onclick="GA_Event('마이페이지','LNB','위시리스트');">위시리스트<!-- 위시리스트 --></a>
                    </dd>
                    <dd>
                        <a href="/ko/mypage/rsalarm" onclick="GA_Event('마이페이지','LNB','재입고 알림');">재입고 알림<!-- 재입고알림 --></a>
                    </dd>
                </dl>
                <dl>
                    <dt>나의 정보관리</dt>
                    <dd>
                        <a href="/mypage/personInformationChange" onclick="GA_Event('마이페이지','LNB','개인정보 변경/탈퇴');">개인정보 변경/탈퇴</a>
                    </dd>
                    <dd>
                        <a href="/ko/mypage/shoppingAddressPWCheck" onclick="GA_Event('마이페이지','LNB','배송지 관리');">배송지 관리</a>
                    </dd>
                    <dd>
                        <a href="/ko/mypage/oneClick" onclick="GA_Event('마이페이지','LNB','원클릭 결제 관리');">원클릭 결제 관리</a>
                    </dd>
                    <dd>
                        <a href="/ko/mypage/mergeCustomerInfo" onclick="GA_Event('마이페이지','LNB','한섬 멤버십 통합');">한섬 멤버십 통합</a>
                    </dd>
                </dl>
                <dl>
                    <dt>나의 활동관리</dt>
                    <!-- <dd><a href="#">회원등급</a></dd> -->
                    <dd>
                        <a href="/ko/mypage/myreview" onclick="GA_Event('마이페이지','LNB','내 상품평');">내 상품평</a>
                    </dd>
                    <dd>
                        <a href="/ko/mypage/myqna" onclick="GA_Event('마이페이지','LNB','상품 Q&A');">상품 Q&A</a>
                    </dd>
                    <dd>
                        <a href="/ko/mypage/mymantomaninquiry" onclick="GA_Event('마이페이지','LNB','1:1 문의');">1:1 문의</a>
                    </dd>
                    <!-- <dd><a href="#">이벤트 참여현황</a></dd> -->
                </dl>
            </div>
            <!-- ph_guide -->
            <div class="ph_guide">
                <p class="tlt">고객센터 운영 안내</p>
                <p class="phone">1800-5700<span style="color: #c69c6d;" class="txt">(유료)</span></p>
                <p class="txt">
                    평일(월~금)<br />
                    am 09:00 ~ pm 18:00<span>토/일, 공휴일 휴무</span>
                </p>
                <a href="mailto:shophelp@thehandsome.com">
                    shophelp<br />
                    @thehandsome.com
                </a>
            </div>
            <!-- //ph_guide -->
        </div>
        <!-- //lnb -->
        <!-- cnts -->
        <div class="sub_cnts">
            <form id="updateProfileForm" action="/ko/mypage/personInfomationChange" method="post">
                <input type="hidden" name="prk" id="prk" value="8929526415364" /> <input type="hidden" name="emailDuplChk" id="emailDuplChk" value="Y" title="이메일 중복" />
                <input type="hidden" id="emailAddress" name="emailAddress" value="" /> <input type="hidden" id="mobilePhoneNumber" name="mobilePhoneNumber" value="" />
                <input type="hidden" id="telephoneNumber" name="telephoneNumber" value="" />
                <!-- //lnbWrap -->
                <div>
                    <div class="title_wrap mt30">
                        <h4 class="float_left">개인정보 변경</h4>
                        <p class="txt_line">회원정보를 확인하고, 변경할 수 있습니다.</p>
                        <p class="reqd_txt"><strong class="reqd">*</strong> 표시는 필수항목입니다.</p>
                    </div>

                    <fieldset>
                        <legend>회원정보입력</legend>
                        <div class="tblwrap">
                            <table class="tbl_wtype1">
                                <caption>
                                    회원가입 입력항목
                                </caption>
                                <colgroup>
                                    <col style="width: 140px;" />
                                    <col />
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th scope="row" class="th_space">이름</th>
                                        <td>${sessionScope.member.mname }</td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="th_space">생년월일</th>
                                        <td>${sessionScope.member.mbirth }</td>
                                    </tr>
                                    <!-- <tr>
										<th scope="row" class="th_space">성별</th>
										<td>여자</td>
									</tr> -->
                                    <tr>
                                        <th scope="row" class="th_space">아이디</th>
                                        <td>${sessionScope.member.mid }<input type="hidden" id="mid" name="mid" value="${sessionScope.member.mid }" /></td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="th_space"><label for="pwChangeBtn">비밀번호</label></th>
                                        <td>
                                            <input type="password" placeholder="기존 비밀번호 [필수]" id="oldpw" style="width: 30%; margin: 5px 0;" /> <br />
                                            <input type="password" placeholder="신규 비밀번호" id="mpassword" name="mpassword" style="width: 30%; margin: 5px 0;" /> <br />
                                            <input type="password" placeholder="비밀번호 확인" id="pwcheck" style="width: 30%; margin: 5px 0;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="th_space"><label for="address">주소</label></th>
                                        <td>
                                            <input type="text" id="mzipcode" name="mzipcode" style="width: 75px;" title="우편번호" value="${sessionScope.member.mzipcode }" />
                                            <input type="button" value="우편번호 조회" class="btn add_s" id="addrSearchBtn" /><br />
                                            <input type="text" id="maddress1" name="maddress1" style="width: 100%; margin: 5px 0;" title="주소1" value="${sessionScope.member.maddress1 }" />
                                            <input type="text" id="maddress2" name="maddress2" style="width: 100%;" title="주소2" value="${sessionScope.member.maddress2 }" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><strong class="reqd">*</strong> <label for="hp">휴대폰 번호</label></th>
                                        <td>
                                            <input type="text" id="mtel" name="mtel" class="hp_num1" style="width: 120px;" value="${sessionScope.member.mtel }" maxlength="4" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="th_space">
                                            이메일 / SMS <br />
                                            수신여부
                                        </th>
                                        <td>
                                            <div class="wtype_comment">
                                                더한섬닷컴에서 제공되는 서비스에 대한 수신동의 여부를 확인해주세요. <br />
                                                선택 하시면 더한섬닷컴에서 진행하는 공지 및 이벤트소식을 받아보실 수 있습니다. <br />
                                                <span>(단, 가입 및 주문/결제와 재입고 알림 등에 관련된 이메일과 SMS는 동의와 상관 없이 발송 됩니다.)</span>
                                            </div>
                                            <div class="receive_choice">
                                                <span class="bul_sty01">
                                                    <span>이메일</span> <input type="radio" name="emailReceiveYN" value="true" id="emailReceiveYN" /><label for="email_y">예</label>
                                                    <input type="radio" name="emailReceiveYN" value="false" id="emailReceiveYN" /><label for="email_n">아니오</label>
                                                    <!-- <input type="radio" name="email_rd" id="email_y" /><label for="email_y">예</label>
											<input type="radio" name="email_rd" id="email_n" /><label for="email_n">아니오</label> -->
                                                </span>
                                                <span class="bul_sty01">
                                                    <span>SMS</span> <input type="radio" name="smsReceiveYN" id="smsReceiveYN" value="true" /><label for="sms_y2">예</label>
                                                    <input type="radio" name="smsReceiveYN" id="smsReceiveYN" value="false" /><label for="sms_n2">아니오</label>
                                                    <!-- <input type="radio" name="sms_rd" id="sms_y2" /><label for="sms_y2">예</label>
											<input type="radio" name="sms_rd" id="sms_n2" /><label for="sms_n2">아니오</label> -->
                                                </span>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </fieldset>

                    <!-- btn_btwrap -->
                    <div class="btn_btwrap">
                        <input type="button" class="btn wt_ss" value="회원탈퇴" id="memberSecessionBtn" />
                    </div>
                    <div class="btnwrap mypage2">
                        <input type="button" class="btn wt" value="취소" id="cancleBtn" />
                        <input type="button" class="btn gray" value="변경사항 저장" id="saveBtn" />
                    </div>
                    <!-- //btn_btwrap -->
                </div>
                <div>
                    <input type="hidden" name="CSRFToken" value="63a2658c-eee7-442b-bd0c-5c890250220c" />
                </div>
            </form>
            <!-- 다국어 한국 이외의 언어에서 사용 -->
        </div>
        <!-- //cnts -->
    </div>
</div>
<%@ include file="../includes/footer.jsp"%>
