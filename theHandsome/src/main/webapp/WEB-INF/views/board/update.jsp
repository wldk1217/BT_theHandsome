<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<title>THE HANDSOME.COM</title>
<link rel="shortcut icon" href="http://cdn.thehandsome.com/_ui/desktop/common/images/common/thehandsome_ic_16x16.ico" />
<link rel="stylesheet" type="text/css" href="./font_80.css" media="all" />
<link rel="stylesheet" type="text/css" href="./common.css" media="all" />
<link rel="stylesheet" type="text/css" href="./layout.css" media="all" />
<link rel="stylesheet" type="text/css" href="./jquery-ui.min.css" media="all" />
<link rel="stylesheet" type="text/css" href="./brand.css" media="all" />
<link rel="stylesheet" type="text/css" href="./swiper.css" media="all" />
<link rel="stylesheet" type="text/css" href="./main_201903.css" media="all" />
<link rel="stylesheet" type="text/css" href="./footer.css" media="all" />
<!-- input 박스 클릭시 테두리를 보이지 않게 하기위한 css 추가 -->

<style>
	input:focus {
	    outline: none;
	}
	textarea:focus {
	    outline: none;
	}
</style>

<div id="bodyWrap">
    <div id="subMainPopwrap1"></div>
    <h3 class="cnts_title">
        <span>게시물 조회</span>
    </h3>
    <div class="sub_container clearfix">
        <div class="iframe_lnb">
            <div class="lnb_wrap">
                <h4><a href="/svcenter/submain">고객센터
                        <!-- 고객센터 -->
                    </a></h4>
                <div class="lnb">
                    <p><a href="/ko/svcenter/notice">공지사항
                            <!-- 공지사항 -->
                        </a></p>
                    <p><a href="/ko/svcenter/mantomaninquiry">1:1 문의 등록
                            <!-- 1:1 문의하기 -->
                        </a></p>
                    <p><a href="/ko/svcenter/faq">FAQ
                            <!-- FAQ; -->
                        </a></p>
                    <p><a href="/ko/svcenter/mending">수선진행조회
                            <!-- 수선진행조회; -->
                        </a></p>
                    <p><a href="/ko/footer/vocProvision">고객의 소리</a></p>
                    <!-- <p><a href="#;">APP 다운로드 소개</a></p> -->
                    <dl>
                        <dt>쇼핑 가이드</dt>
                        <dd><a href="/ko/svcenter/memberjoinguide">회원 가입</a></dd>
                        <dd><a href="/ko/svcenter/theClubInfo">온라인 멤버십</a></dd>
                        <dd><a href="/ko/svcenter/memberbenefitguide">한섬 VVIP 혜택</a></dd>
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
                    <p class="txt">평일(월~금)<br>am 09:00 ~ pm 18:00<span>토/일, 공휴일 휴무</span></p>
                    <a href="mailto:shophelp@thehandsome.com">shophelp<br>@thehandsome.com</a>
                </div>
                <!-- //ph_guide -->

            </div>
        </div>
        <div class="sub_cnts">
            <div class="title_wrap mt30 clearfix">
                <h4 class="float_left">문의 조회</h4>
            </div>
            <!-- enctype="multipart/form-data" -->
            <form id="manToManInquiryForm" name="manToManInquiryForm" method="post" >
                <input type="hidden" id="qid" name="qid" value="${board.qid}">
                <input type="hidden" id="pageNum" name="pageNum" value="${cri.pageNum}">
                <fieldset>
                    <legend>1:1 문의 입력</legend>
                    <div class="tblwrap">
                        <table class="tbl_wtype1">
                            <caption>1:1 문의 입력</caption>
                            <colgroup>
                                <col style="width:140px">
                                <col>
                            </colgroup>
                            <!-- 문의 테이블 시작  border:none style로 테두리 없애기-->
                            <tbody>
                            	<!-- 문의 항목 -->
                                <tr>
                                    <th scope="row"><strong class="reqd">*</strong>문의 항목</th>
                                    <td class="storeQue">
                                        <p>더한섬닷컴 문의</p>
                                    </td>
                                </tr>
                                <!-- 작성자 start -->

                                <!-- 작성자 end -->
                                <!-- 작성 날짜 start -->

                                <!-- 작성 날짜 end -->
                                <!-- 문의 제목 start-->
                                <tr>
                                    <th scope="row"><strong class="reqd">*</strong>문의제목</th>
                                    <td>
                                        <input type="text" id="qtitle" name="qtitle" title="문의제목" class="w_all">
                                    </td>
                                </tr>
                                <!-- 문의 제목 -->
                                <tr>
                                    <th scope="row">
                                        <strong class="reqd">*</strong>문의 내용<span class="com_txt_p">(2000자 이하)</span>
                                    </th>
                                    <td>
                                        <!-- textarea -->
                                        <textarea id="qcontent" name="qcontent" title="문의내용" cols="30" rows="10"
	                                     placeholder="문의하실 상품의 상품명/제품코드/사이즈/컬러를 정확히 적어주세요.

주문하신 상품이라면 주문번호와 문의 하실 상품명/제품코드/사이즈/컬러와 함께 궁금하신 사항을 적어 주시면
                                            정확한 답변을 드리는데 도움이 됩니다.

반품접수는 마이페이지 주문내역에서 “반품 신청“ 버튼을 클릭하여 반품을 접수해주셔야 합니다.">
                                        </textarea>
                                        
                                        <!-- //textarea -->
                                    </td>
                                </tr>
                                <!-- popup end -->
								
                                <!-- <tr>
                                    <th scope="row" class="th_space">사진등록</th>
                                    <td>

                                        <div class="file_upload">
                                            <input type="text" id="textManToManFile" class="text" title="파일 첨부하기"
                                                readonly="readonly" name="fileText">
                                            <div class="upload_btn">
                                                <button type="button" id="uploadFile" class="img_upload"
                                                    title="파일찾기"><span>파일찾기</span></button>
                                                <input type="file" name="mantomanFile" id="mantomanFile"
                                                    class="btn add_s" title="파일찾기">
                                            </div>
                                        </div>
                                        <p class="txt_guide">10MB 미만의 jpg,gif,png 파일만 첨부하실 수 있습니다.</p>

                                    </td>
                                </tr>  -->
                            </tbody>
                        </table>
                    </div>
                    <!-- btn -->
                    <div class="btnwrap">
                        <input type="button" id="btn_cancle" value="취소" class="btn wt">
                        <input type="button" id="btn_modify" value="수정" class="btn gray mr0">
                    </div>
                    <!-- //btn -->
                </fieldset>
                <!-- 
                <div>
                    <input type="hidden" name="CSRFToken" value="fdb40c20-f51b-4a6f-9828-0142a1aebb29">
                </div>
                 -->
            </form>
            <ul class="bul_sty01_li mt60">
                <li>문의하신 내용에 대한 답변은 이메일 또는 <a href="/ko/mypage/mymantomaninquiry"><em class="ft_point01">마이페이지 &gt; 1:1
                            문의내역</em></a>에서 확인하실 수 있습니다. </li>
                <li>SMS 문자와 이메일로 답변 완료 알림을 받아보실 수 있습니다.</li>
            </ul>
        </div>
		
    </div>
</div>
<script>

	/* 등록 버튼 클릭시 동작하는 method*/
		$("#btn_modify").click(function(e) {
			/* insert 요청 */
			actionForm = $("#manToManInquiryForm");
			$("#manToManInquiryForm").attr("action", "/board/update");
			$("#manToManInquiryForm").submit();
		});
	
		$("#btn_cancle").click(function(e) {
			/* insert 요청 */
			qid = $('#qid').val();
			pageNum = $('#pageNum').val();
			location.href = "/board/read?qid="+qid
							 +"&pageNum="+pageNum;
			
		});
</script>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
