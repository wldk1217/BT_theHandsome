<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
            	<!-- mid 부분 -->
                <input type="hidden" id="mid" name="mid" value="${memid}">               
                <input type="hidden" id="qid" name="qid" value="${board.qid}">
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
                                <tr>
                                    <th scope="row"><strong class="reqd">*</strong>작성자</th>
                                    <td>
                                        <input type="text" id="mid" name="mid" title="작성자" 
                                        value='<c:out value="${board.mid}"/>' class="w_all" readonly="readonly" style="border:none">
                                    </td>
                                </tr>
                                <!-- 작성자 end -->
                                <!-- 작성 날짜 start -->
                                <tr>
                                    <th scope="row"><strong class="reqd">*</strong>작성 날짜</th>
                                    <td>
                                        <input type="text" id="qdate" name="qdate" title="작성자" 
                                        value='<c:out value="${board.qdate}"/>' class="w_all" readonly="readonly" style="border:none">
                                    </td>
                                </tr>
                                <!-- 작성 날짜 end -->
                                <!-- 문의 제목 start-->
                                <tr>
                                    <th scope="row"><strong class="reqd">*</strong>문의제목</th>
                                    <td>
                                        <input type="text" id="qtitle" name="qtitle" title="문의제목" 
                                        value='<c:out value="${board.qtitle}"/>' class="w_all" readonly="readonly" style="border:none">
                                    </td>
                                </tr>
                                <!-- 문의 제목 -->
                                <tr>
                                    <th scope="row">
                                        <strong class="reqd">*</strong>문의 내용<span class="com_txt_p">(2000자 이하)</span>
                                    </th>
                                    <td>
                                        <!-- textarea -->
                                        <textarea id="qcontent" name="qcontent" title="문의내용" cols="30" rows="10" readonly="readonly" style="border:none">
${board.qcontent}
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
                        <c:if test="${memid eq board.mid}">
                        	<input type="button" id="btn_modify" value="수정" class="btn gray mr0">
                        	<input type="button" id="btn_delete" value="삭제" class="btn wt">
                        </c:if>
                    </div>
                    <!-- //btn -->
                </fieldset>
                <!-- 
                <div>
                    <input type="hidden" name="CSRFToken" value="fdb40c20-f51b-4a6f-9828-0142a1aebb29">
                </div>
                 -->
            </form>
            <!-- 댓글 목록 시작 -->
            <div class="title_wrap mt30 clearfix">
                <h4 class="float_left">댓글</h4>
            </div>
            <div class="tab_a m2" id="faqTabs" style="margin-bottom:0px;">
                <ul>
                    <li><a href="#a" class="active" onclick="testFunc('0')" id="aa">회원</a></li>
                    <li><a href="#b" onclick="testFunc('1')" id="bb">관리자</a></li>
                </ul>
            </div>            
            <div class="tblwrap" style="overflow: hidden;">
            	<textarea class="new_reply" id="new_reply" style="width:79%;" placeholder="댓글 입력"></textarea>          	
            	<button id="btn_reply" class="btn gray mr0" style="float:right; height:52px;">댓글</button>
                <table class="tbl_ltype toggle_list" style="border-top: none;">
                    <caption>회원 댓글 리스트</caption>
                    <colgroup>
                        <col style="width:115px">
                        <col style="width:600px">
                        <col style="width:50px">
                        <col style="width:100px">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col"><small>이름</small></th>
                            <th scope="col"><small>댓글</small></th>
                            <th scope="col"></th>
                            <th scope="col"><small>날짜</small></th>
                        </tr>
                    </thead>
                    <tbody id="listBody" class="reply">
                        <tr class="al_middle">
                            <td class="frt"><small></small></td>
                            <td class="al_left"></td>
                            <td class="al_right"><small></small></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <!-- 댓글 목록 끝 -->
            <ul class="bul_sty01_li mt60">
                <li>문의하신 내용에 대한 답변은 이메일 또는 <a href="/ko/mypage/mymantomaninquiry"><em class="ft_point01">마이페이지 &gt; 1:1
                            문의내역</em></a>에서 확인하실 수 있습니다. </li>
                <li>SMS 문자와 이메일로 답변 완료 알림을 받아보실 수 있습니다.</li>
            </ul>
        </div>
		

        
        <input type="hidden" id="pageNum" value="${cri.pageNum}">        
        <input type="hidden" id="qid" value="${board.qid}">
    </div>
</div>

<!-- 댓글 수정, 삭제 모달창 style 추가 -->
<style>
    #my_modal {
        display: none;
        padding: 20px 60px;
        background-color: #fefefe;
        border: 1px solid #888;
        border-radius: 3px;
    }
</style>
<!-- 댓글 수정, 삭제 모달창 style 추가 부분 끝 -->

<!-- 모달창 부분 -->
<div id="my_modal">
    <div class="sub_container clearfix">
                    <div class="tblwrap">
                        <table class="tbl_wtype1">
                            <caption>댓글 수정 및 삭제</caption>
                            <colgroup>
                                <col style="width:140px">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row"><strong class="reqd">*</strong>
                                    	작성자
                                    </th>
                                    <td class="replyer">                                        
                                    </td>
                                </tr>

                                <tr>
                                    <th scope="row">
                                        <strong class="reqd">*</strong>댓글<span class="com_txt_p">(500자 이하)</span>
                                    </th>
                                    <td>
                                        <!-- textarea -->
                                        <textarea id="reply_contents" name="reply_contents" title="문의내용" cols="20" rows="10"
                                            placeholder="수정할 댓글 입력"></textarea>
                                        <!-- //textarea -->
                                    </td>
                                </tr>                                
                                <!-- popup end -->
                            </tbody>
                        </table>
                    </div>
                    <!-- 댓글 번호를 받아오기 위한 HIDDEN 태그 -->
                    <input type="hidden" value="" name="inputValue"/>
                    <!-- 댓글 번호를 받아오기 위한 HIDDEN 태그  끝-->
                    <!-- 버튼 부분 시작 -->
                    <div class="btnwrap">
                        <input type="button" id="modal_close_btn" value="취소" class="btn wt">
                        <input type="button" id="reply_modifyBtn" value="수정" class="btn gray mr0">
                        <input type="button" id="reply_deleteBtn" value="삭제" class="btn gray mr0">
                    </div>
                    <!-- 버튼 부분 끝 -->
                    
        </div>

    </div>
    <!-- 모달창 부분 끝-->

<script type="text/javascript" src="/resources/js/reply.js"></script>
<script>
$("#customerReviewWriteDiv").hide();
		//ajax를 이용한 게시판 조회 페이지의 댓글 처리
		$(document).ready(function(){	
			var bnoValue ='<c:out value="${board.qid}"/>';
			var pageValue = '<c:out value="${cri.pageNum}"/>';
			var reply = $(".reply");
			showList(1);
			function showList(page){
				mid = document.getElementById("mid").value;
				replyService.getList({bno:bnoValue, page:pageValue}, function(list){
					var str = "";
					//댓글이 없을때 아무것도 띄우지 않고 return
					if(list==null||list.length==0){
						reply.html("");
						return;
					}//end if
					for(var i=0, len=list.length||0; i<len; i++){
						str += "<tr class='al_middle'>";
						str += "<td class='frt'><small>"+list[i].replyer+"</small></td>";
						str += "<td class='al_left'>"+list[i].reply+"</td>";
						if(list[i].replyer==mid){
							str += "<td class='getreply' style='border-left:none;'><small><input type='button' id='click_modify' value='수정' class='btn gray mr0'"; 
							str += "style='min-width: 40px; font-size: 5px; padding: 0px 0px 0px;'";
							str +=  "data-rno="+list[i].rno+" data-replyer="+list[i].replyer+"></small></td>";
						}
						else{
							str += "<td style='border-left:none;'></td>";	
						}
						str += "<td class='al_left'><small>" +replyService.displayTime(list[i].replyDate)+"</small></td>";
						
					}//end for
					reply.html(str);
				});//end getList
			}//end showList		
		});//end func
		//댓글을 클릭하면 모달창을 띄우게 하는 함수
		$(".reply").on("click", "input[id='click_modify']", function(e){
			rno = $(this).data("rno");
			console.log("---------------rno:"+rno);
			replyer = $(this).data("replyer");
			console.log("---------------replyer:"+replyer);
			$('input[name=inputValue]').attr("value", rno);
			$(".replyer").text(replyer);
			modal('my_modal');
		});
		//댓글 수정 및 삭제의 모달창에서 수정 버튼을 누르면 테이블을 업데이트 하는 메소드
		$("#reply_modifyBtn").click(function(){
			rno = $('input[name=inputValue]').val();
			reply = $("#reply_contents").val();
			replyService.update(
					{rno:rno, reply:reply}, function(result){
				alert("댓글 수정 완료");
				showList(1);
			});
			history.go(0);
		});
		$("#reply_deleteBtn").click(function(){
			rno = $('input[name=inputValue]').val();
			console.log(rno);
			replyService.remove(rno, function(result){
				alert("댓글 삭제 완료");
				showList(1);
			});
			history.go(0);
		});
	/* 등록 버튼 클릭시 동작하는 method*/
		$("#btn_modify").click(function() {
			/* insert 요청 */
			qid = document.getElementById("qid").value;
			pageNum = document.getElementById("pageNum").value;
			location.href = "/board/update?qid="+qid
							 +"&pageNum="+pageNum;
						     
		});
	
		$("#btn_cancle").click(function() {
			/* 목록 화면 요청 */
			pageNum = document.getElementById("pageNum").value;
			location.href = "/board/list?pageNum="+pageNum
						     +"&amount=10";
		});
		
		$("#btn_delete").click(function() {
			/* delete 요청 */
			console.log("버튼클릭");
			$("#manToManInquiryForm").attr("action", "/board/delete");
			$("#manToManInquiryForm").submit();
		});
		
		$("#btn_reply").click(function() {
			/* 댓글 insert 요청 */
			mid = document.getElementById("mid").value;
			//로그인을 하였을 때 댓글 삽입 가능
			if(mid){
				replyService.add(
						{reply:document.getElementById("new_reply").value,
						replyer:document.getElementById("mid").value,
						bno:document.getElementById("qid").value}, 
						function(result){
							alert("새로운 댓글이 등록되었습니다.");
							showList(1);						
				});//end add
				history.go(0);
			}			
		});

		
		//모달 창 띄우는 함수
		function modal(id) {
		    var zIndex = 9999;
		    var modal = $('#' + id);

		    // 모달 div 뒤의 레이어 색 조절
		    var bg = $('<div>')
		        .css({
		            position: 'fixed',
		            zIndex: zIndex,
		            left: '0px',
		            top: '0px',
		            width: '100%',
		            height: '100%',
		            overflow: 'auto',
		            // 레이어 색깔 변경
		            backgroundColor: 'rgba(0,0,0,0.4)'
		        })
		        .appendTo('body');

		    modal
		        .css({
		            position: 'fixed',
		            boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

		            // 시꺼먼 레이어 보다 한칸 위에 보이기
		            zIndex: zIndex + 1,

		            // div center 정렬
		            top: '50%',
		            left: '50%',
		            transform: 'translate(-50%, -50%)',
		            msTransform: 'translate(-50%, -50%)',
		            webkitTransform: 'translate(-50%, -50%)'
		        })
		        .show()
		        // 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
		        .find('#modal_close_btn')
		        .on('click', function() {
		            bg.remove();
		            modal.hide();
		        });
		}

		$('#popup_open_btn').on('click', function() {
		    // 모달창 띄우기
		    modal('my_modal');
		});
		
</script>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>