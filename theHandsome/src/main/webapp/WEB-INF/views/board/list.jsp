<!-- 
/*****************************************************
 * @function : list.jsp
 * @author : 구영모
 * 설명: 게시판  페이지
 * @Date : 2022.10.22
 *****************************************************/
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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

<div id="bodyWrap">
    <div id="subMainPopwrap1"></div>
    <h3 class="cnts_title">
        <span>고객센터</span>
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
					<!--  -->
                    <p><a href="/board/insert">게시물 등록</a></p>
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
            <!-- 검색창 부분-->
            <form id="faqListForm" action="/ko/svcenter/faqlist">
                <div class="search_sv_wrap">
                    <p>FAQ SEARCH</p>
                    <input type="hidden" id="tabIndex" name="tabIndex" value="">
                    <input type="text" class="input" id="subject" title="FAQ SEARCH" name="subject" value="">
                    <input type="button" class="btn gray_s" id="searchBtn" onclick="testFunc('0')" value="검색">
                </div>
            </form>
        </div>
        <div class="tab_a m6" id="faqTabs">
            <ul>
                <li><a href="#a" class="active" onclick="testFunc('0')" id="aa">전체보기</a></li>
                <li><a href="#b" onclick="testFunc('1')" id="bb">상품문의</a></li>
                <li><a href="#c" onclick="testFunc('2')" id="cc">주문/배송</a></li>
                <li><a href="#e" onclick="testFunc('4')" id="ee">결제/환불</a></li>
                <li><a href="#f" onclick="testFunc('5')" id="ff">쿠폰/혜택</a></li>
                <li><a href="#h" onclick="testFunc('7')" id="hh">기타</a></li>
            </ul>
        </div>
        <div class="title_wrap mt60 clearfix">
            <h4 class="float_left">전체보기</h4>
            <p class="txt_line" id="totRsltCnt">총<strong class="ft_point01">${count}</strong>개 의 검색결과가 있습니다.</p>
        </div>
                <!-- 문의 테이블 부분  --> 
                <div class="tblwrap" style="overflow: hidden;">
                    <table class="tbl_ltype toggle_list">
                        <caption>게시판 리스트</caption>
                        <!-- 테이블 컬럼의 가로길이 컬럼의 개수만큼 추가-->
                        <colgroup>
                            <col style="width:80px">
                            <col style="width:115px">
                            <col style="width:659px">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">번호</th>
                                <th scope="col">작성자</th>
                                <th scope="col">제목</th>
                            </tr>
                        </thead>
                        <tbody id="listBody">
                        	<c:forEach items="${list}" var="board">                       	
	                        	<tr class="al_middle" id="clickme" onclick="read(${board.qid})" style="cursor:pointer ;">
	                                <td class="frt">${board.qid}</td>
	                                <td>${board.mid}</td>
	                                <td class="al_left">${board.qtitle}</td>
	                            </tr>
	                            <input type="hidden" id="${board.qid}" value="${board.qid}"/>
                        	</c:forEach>

                        </tbody>
                    </table>
                </div>
                <div class="paging">
                    <c:if test="${pageMaker.prev}"> <!-- 이전 버튼 -->
		              <span class="paginate_button previous">
		              	<a href="${pageMaker.firstPage}"> << </a>
		              	<a href="${pageMaker.startPage - 1}"> < </a>
		              </span>
          			</c:if>
            				
		            <!-- 페이징 처리 시작부분 -->
		            <!-- 1~10 버튼 -->
		            <!-- jstl을 사용하여 현재 페이지의 번호를 굵게 한다 -->
		             <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
		              <span class="paginate_button">		              
		              	<c:choose>
		              		<c:when test="${pageMaker.cri.pageNum eq num}">
		              			<a style="font-weight:bold; margin:3px;" class="pageBtn" href="${num}">${num}</a>
		              		</c:when>
		              		<c:otherwise>
		              			<a style="margin:3px;" class="pageBtn" href="${num}">${num}</a>
		              		</c:otherwise>
		              	</c:choose>
		              </span>
		            </c:forEach>
                    <c:if test="${pageMaker.next}"> <!-- 이전 버튼 -->
		              <span class="paginate_button next">
		              	<a href="${pageMaker.endPage + 1}">></a>
		              	<a href="${pageMaker.lastPage}"> >> </a>
		              </span>
          			</c:if>
            		<!-- 페이징 처리 끝 -->
				<form id='actionForm' action="/board/list" method='get'>
					<input type='hidden' id='pageNum' name='pageNum' value='${pageMaker.cri.pageNum}'>
					<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>	
			   </form>    
				
        		</div>
        		<input type='hidden' id='pagenum' value='${pageMaker.cri.pageNum}'>
    </div>
     
</div>
<script>
	//조회 페이지 링크 처리
	function read(num){
		qid = document.getElementById(num).value;
		pagenum = document.getElementById("pagenum").value;
		location.href = "/board/read?qid="+qid+"&pageNum="+pagenum;
	}
	
	//페이징 버튼 처리
	var actionForm = $("#actionForm"); //폼등록
	$(".paginate_button a").on("click",function(e) {
		e.preventDefault(); //<a> 작동 중지
		console.log('click');
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit(); //form submit
	});//end click
</script>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
