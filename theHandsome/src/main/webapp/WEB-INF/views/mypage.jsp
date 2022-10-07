<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ include file="includes/header.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 <!-- 
 /* 
 * 작성자 : 고정민, 문혁
 * 
 * 마이페이지 화면
 */
  -->
<script>
    var obj, arr;
    $(document).ready(function () {
    	var page = ${(param.pageNum == "" || param.pageNum == null)?1:param.pageNum};
    	var startNum = page-(page-1)%10;
    	var total = "${qnaCount}";
    	console.log(total);
    	var lastNum = Math.ceil(total/10); 
    	/* console.log(startNum); */
        if ("${sessionScope.member.mid }" == "") location.href = "/member/login";
        else
            $.ajax({ // 해당 사용자가 작성한 QNA 리스트 불러오는 ajax 호출
                url: "/mypage/QNAList?mid=" + "${sessionScope.member.mid}"+"&pageNum="+page +"&amount=10", //Controller에서 인식할 주소
                type: "get", //GET 방식으로 전달
                async: false,
                dataType: "json",
                contentType: "application/json",
                success: function (data) {
                    if (data.length < 1) { // 게시물 없을 경우
                        var listTag = "";
                        listTag += "<tr>";
                        listTag += "<td colspan='4' class='no_data'>";
                        listTag += "등록된 게시글이 없습니다.";
                        listTag += "</td>";
                        listTag += "</tr>";
                        document.getElementById("listBody").innerHTML = listTag;
                    } else { // 게시물 있는 경우
                        arr = new Array(data.length);
                        obj = data;
                        var listTag = "";
                        for (var i = 0; i < data.length; i++) {
                            var date = data[i].qdate.substr(0, 10);
                            arr[i] = false;
                            listTag += '<tr class="al_middle" cdlist="[]" pk="8919204155322" onClick="showContent(' + i + ')" >';
                            listTag += "<td class='frt'>" + date + "</td><td>기타</td><td class='al_left'><a href='javascript:void(0);'>" + data[i].qtitle + "</a></td><td>[답변대기]</td></tr>";
                            listTag += '<tr id="qna' + i + '"></tr>';
                        }
                        document.getElementById("listBody").innerHTML = listTag;
                    }
                    var phtml = "";
					var prevPage = Math.floor(${param.pageNum})-1;
					phtml += '<a class="prev2" href="?pageNum=1&amount=10">처음 페이지로 이동</a><a href="?pageNum='+prevPage+'&amount=10" class="prev">이전 페이지로 이동</a><span class="num">';
                    for(var i = 0; i<10; i++){
                    	if ((startNum+i) <= lastNum){
                    		var pageNum = startNum+i;
//                     		phtml += '<li class = "page-number ${(param.pageIndex==(startNum+i))?'active':''}">';
							if (pageNum == page){
	                    		phtml += '<a href="?pageNum='+pageNum+'&amount=10" class="pageBtn on">'+pageNum+'</a>';
							} else{
	                    		phtml += '<a href="?pageNum='+pageNum+'&amount=10" class="pageBtn">'+pageNum+'</a>';
							}
                    		console.log(startNum  + " : " + i);
                    	}
                    }
                    var nextPage = Math.ceil(${param.pageNum})+1;
                    phtml += '</span><a href="?pageNum='+nextPage+'&amount=10" class="next">다음 페이지로 이동</a><a href="?pageNum='+lastNum+'&amount=10" class="next2">마지막 페이지로 이동</a></div>';	
                   	document.getElementById("paging").innerHTML = phtml;
                },
                error: function () {
                    alert("에러입니다");
                },
            });
    });
	// 리스트에서 제목 클릭 시 내용이 펼쳐지도록
    function showContent(i) {
        var listTag = "";
        if (arr[i] == false) {
        	var qcontent = obj[i].qcontent;
        	if(obj[i].qcontent == null) qcontent = "";
        	console.log(qcontent);
            listTag += '<tr><td class="qna_wrap" colspan="4"><div class="qna_box ch"><p></p><div class="qt"><span class="ico">quest</span>';
            if(obj[i].qnaimg == null) {
                listTag += '<div class="txt"><p style="font-weight: 900; font-size:15px; word-wrap:break-word; margin-top:7px">' + obj[i].qtitle + '</p><br><br><br>';
                listTag += '<p style="word-wrap:break-word">' + qcontent + '</p><br><br>';
            }
            else {
                listTag += '<div class="txt"><p style="font-weight: 900; font-size:15px; word-wrap:break-word; margin-top:7px">' + obj[i].qtitle + '</p><br><br><br>';
                listTag += '<p style="word-wrap:break-word">' + qcontent + '</p><br><br><img id="imgsrc2" src="/mypage/display?fileName='+obj[i].qnaimg+'" alt="thumimg" style="width:300px" class="tlt"/><br><br>';
            }
            listTag +=
                '<p class="date" style="color:#999;">등록일 : ' +
                obj[i].qdate +
                '</p><a onclick="deleteContent(' +
                obj[i].qid +
                ')" style="float:right" class="btn add_ss mr0">삭제</a><a href="/mypage/modifyQNA?qid=' +
                obj[i].qid +
                '" style="float:right" class="btn add_ss mr0">수정</a></div></div><div class="an"><span class="ico">answer</span>';
            listTag += '<div class="txt"><p style="word-wrap: break-word">안녕하세요, 고객님. 더한섬닷컴 여경민 파트너입니다.</p><p class="date">답변일 : </p></div></div></div></td></tr>';
            arr[i] = true;
        } else {
            listTag = "";
            arr[i] = false;
        }
        document.getElementById("qna" + i).innerHTML = listTag;
    }
	
	// 게시물 삭제하는 ajax 호출
    function deleteContent(qid) {
        var url = "/mypage/deleteQNA?qid=" + qid;
        if (confirm("해당 게시물을 삭제하시겠습니까?") == true) {
            $.ajax({
                url: url,
                method: "post",
                success: function (data) {
                    alert("완료되었습니다.");
                    location.href='/mypage';
                },
                error : function( request, status, error ){
                    console.log( "code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
                }
            });
        }
    }
</script>
<div id="bodyWrap">
    <h3 class="cnts_title">
        <span id="menuTitle">마이페이지</span>
    </h3>
    <div class="" style="position: relative; width: 834px; height: 0; display: block; left: 50%; margin-left: -338px;">
        <div class="delch_box tooltip1907" id="store_delbox" style="display: none;">
            <span class="arr">위치아이콘</span> 작성 가능한 상품평 확인하시고,<br />
            상품평 작성해서 추가 마일리지 적립하세요.
        </div>
    </div>
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
            <div class="profile_info1 clearfix review_betterment1905">
                <div class="name">
                    <span class="ico_grade">${sessionScope.member.mname }<span style="margin-left: 10px;">님</span></span> <span class="grade_txt" id="grade_txt"></span>
                </div>
                <div class="pointbox_cover">
                    <div class="point_wrap">
                        <div class="point" style="border-left: 0; padding-left: 0;">
                            <p class="title">한섬마일리지</p>
                            <a class="count" href="/ko/mypage/mypoint" onclick="GA_Event('마이페이지','회원정보','한섬마일리지');">0&nbsp;<span>M</span></a>
                        </div>
                        <div class="point">
                            <p class="title">H.POINT</p>
                            <a class="count" href="https://www.h-point.co.kr/cu/myh/myPnt.shd" target="_blank" onclick="GA_Event('마이페이지','회원정보','H.POINT');">${sessionScope.member.mpoint }<span>P</span></a>
                        </div>
                        <div class="point">
                            <p class="title">GIFT CARD</p>
                            <a class="count" href="/ko/mypage/mygiftcard" onclick="GA_Event('마이페이지','회원정보','GIFT CARD');">0&nbsp;<span>원</span></a>
                        </div>
                        <div class="point">
                            <p class="title">e-money</p>
                            <a class="count" href="/ko/mypage/myEGiftCard" onclick="GA_Event('마이페이지','회원정보','E-MONEY');">0&nbsp;<span>원</span></a>
                        </div>
                        <div class="point">
                            <p class="title">COUPON</p>
                            <a class="count" href="/ko/mypage/voucher" onclick="GA_Event('마이페이지','회원정보','COUPON');">5&nbsp;<span>장</span></a>
                        </div>
                        <div class="point review">
                            <p class="title">상품평</p>
                            <img src="/resources/_ui/desktop/common/images/common/ico_ques2.png" alt="상품평이란?" class="tlt" />
                            <a href="/mypage/myreview" class="count" onclick="GA_Event('마이페이지','회원정보','상품평');">0&nbsp;<span>개</span></a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 회원정보 -->
            <div class="title_wrap mt50">
                <h4 class="float_left">나의 1:1 문의&nbsp;</h4>
                <p class="txt_line">고객님의 문의를 등록하시면 빠른 시일 내 답변 드리겠습니다.</p>
                <%-- <img id="imgsrc2" src="${imgsrc }" alt="thumimg" class="tlt"/> --%>
                <div class="btn_wrap">
                    <a href="/mypage/QNA" class="btn add_ss mr0">문의하기</a>
                </div>
            </div>
            <!-- Table -->
            <div class="tblwrap">
                <table class="tbl_ltype">
                    <caption>
                        >나의 1:1 문의 목록
                    </caption>
                    <colgroup>
                        <col style="width: 100px;" />
                        <col style="width: 140px;" />
                        <col />
                        <col style="width: 100px;" />
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col">등록일</th>
                            <th scope="col">상담유형</th>
                            <th scope="col">내용</th>
                            <th scope="col">처리상태</th>
                        </tr>
                    </thead>
                    <tbody id="listBody"></tbody>
                </table>
            </div>
            <!-- //Table -->
            <!--paging-->
            <div class="paging mt30" id = "paging"></div>
            <!--//paging-->
            <!-- 최근주문 -->
            <div class="title_wrap">
                <h4 class="float_left">
                    최근주문&nbsp;
                    <!-- 최근주문 -->
                </h4>
                <p class="txt_line">
                    최근 1개월 내 주문하신 내역입니다.
                    <!-- 최근 1개월 내 주문하신 내역 입니다. -->
                </p>
                <div class="btn_wrap">
                    <a href="/ko/mypage/order/myorders" class="btn add_ss" onclick="GA_Event('마이페이지','최근주문','전체보기');">전체보기<!-- 전체보기 --></a>
                </div>
            </div>
            <!-- table -->
            <div class="tblwrap lncl1812">
                <!-- 클래스추가 181204 -->
                <table class="tbl_ltype review_betterment1905">
                    <caption>
                        상품평 리스트
                    </caption>
                    <colgroup class="interval1812">
                        <!-- 수정 181204 -->
                        <col style="width: 120px;" />
                        <col />
                        <col style="width: 42px;" />
                        <col style="width: 107px;" />
                        <col style="width: 108px;" />
                        <col style="width: 96px;" />
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col">주문번호<!-- 주문번호 --></th>
                            <th scope="col">상품정보<!-- 상품정보 --></th>
                            <th scope="col" style="padding: 15px 0;">수량<!-- 수량 --></th>
                            <!-- 스타일추가 181204 -->
                            <th scope="col">판매가<!-- 판매가 --></th>
                            <th scope="col">주문상태<!-- 주문상태 --></th>
                            <th scope="col">구분<!-- 구분 --></th>
                        </tr>
                    </thead>
                    <tbody id="listBody">
                        <tr>
                            <td colspan="6" class="no_data">최근 한 달간 주문내역이 없습니다.<!-- 최근 한 달간 주문내역이 없습니다. --></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <!-- table -->
            <!-- 위시리스트 -->
            <div class="title_wrap line mt50">
                <h4>
                    위시리스트
                    <!-- 위시리스트 -->
                </h4>
                <div class="btn_wrap">
                    <a href="/ko/mypage/myWish" class="btn add_ss" onclick="GA_Event('마이페이지','위시리스트','전체보기');">전체보기<!-- 전체보기 --></a>
                </div>
            </div>
            <ul class="wish_wrap">
                <li class="no_data">위시리스트에 저장된 상품이 없습니다.<!-- 위시리스트에 저장된 상품이 없습니다. --></li>
            </ul>
        </div>
        <!-- //cnts -->
    </div>
</div>

<%@ include file="includes/footer.jsp"%>