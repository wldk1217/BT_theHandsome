<!-- 
/*****************************************************
 * @function : join.jsp
 * @author : 구영모, 김민선 공동작업
 * 1차 작업: 김민선 join.jsp 최초 생성
 * 2차 작업: 구영모 시큐리티 적용
 * @Date : 2022.10.18
 *****************************************************/
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<!-- author:구영모 checkid의 Ajax안에서 csrf토큰을 사용하기 위한 meta 태그 추가 -->
<meta id="_csrf" name="_csrf" th:content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" th:content="${_csrf.headerName}"/>
 <!-- meta 태그 끝 -->
<head>
<script src="/jquery-3.4.1.min.js"></script>



<style>
.id_ok {
   color: #008000;
   display: none;
}

.id_already {
   color: #6A82FB;
   display: none;
}

.pw_ok {
   color: #008000;
   display: none;
}

.pw_notokay {
   color: #6A82FB;
   display: none;
}
</style>

</head>

<form id="join_form" action="/member/join" method="POST">
   <!-- author:구영모  post값 전송을 위한 csrf token 값 추가 -->
   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
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
                           <th scope="row"><strong class="reqd">*</strong>
                           <label for="mid">아이디</label></th>
                           <td><input type="text" style="width: 120px" id="id"
                              name='mid' oninput="checkId()" required /> <span class="id_ok">사용
                                 가능한 아이디입니다.</span> <span class="id_already">이미 사용중인 아이디입니다.</span></td>


                        </tr>
                        <tr>
                           <th scope="row"><label for="email">E-mail (정보수신용)</label></th>
                           <td><input type="text" style="width: 120px" title="이메일"
                              id="userEmail" /> <span class="andmail" id="middle">@</span>
                              <input type="text" id="email_address"
                              list="user_email_address" style="width: 150px" required> <datalist
                                 id="user_email_address">
                                 <option value="직접입력"></option>
                                 <option value="naver.com"></option>
                                 <option value="daum.net"></option>
                                 <option value="gmail.com"></option>
                                 <option value="hotmail.com"></option>
                                 <option value="msn.com"></option>

                              </datalist> 
                              <input type="hidden" id="totalEmail" name='memail' /></td>
                        </tr>
                        <tr>
                           <th scope="row"><strong class="reqd">*</strong><label
                              for="pw">비밀번호</label></th>
                           <td><input type="password" id="pw" name='mpassword'
                              style="width: 150px" title="비밀번호" required /> <span
                              class="guide_comment lh_30" id="pwMsg"></span> <span
                              class="guide_comment lh_30" id="pwcapsLockMsg"></span></td>
                        </tr>

                        <tr>
                           <th scope="row"><strong class="reqd">*</strong> <label
                              for="pw2">비밀번호 확인</label></th>
                           <td><input type="password" id="pwc" style="width: 150px"
                              title="비밀번호 확인" required /> 
                              <span class="pw_ok">비밀번호가 일치합니다.</span> <span class="pw_notokay">비밀번호가 불일치합니다.</span>
                           </td>
                        </tr>

                        <tr>
                           <th scope="row"><strong class="reqd">*</strong><label
                              for="name">이름</label></th>
                           <td><input type="text" style="width: 120px" id="name"
                              name='mname' required /></td>
                        </tr>
                        <tr>
                           <th scope="row"><strong class="reqd">*</strong><label
                              for="mtel">전화번호</label></th>
                           <td><input type="text" style="width: 120px" id="name"
                              name='mtel' required /></td>
                        </tr>
                        <tr>
                           <th scope="row"><label for="mzipcode">우편번호</label></th>
                           <td><input type="text" style="width: 120px" id="mzipcode"
                              name='mzipcode' /></td>
                        </tr>
                        <tr>
                           <th scope="row"><label for="maddress1">주소</label></th>
                           <td><input type="text" style="width: 120px" id="maddress1"
                              name='maddress1' /></td>
                        </tr>
                        <tr>
                           <th scope="row"><label for="maddress2">상세 주소</label></th>
                           <td><input type="text" style="width: 120px" id="maddress2"
                              name='maddress2' /></td>
                        </tr>
                     </tbody>
                  </table>
               </div>


               <div class="btnwrap">
                  <input type="button" value="취소" class="btn wt" id="cancleBtn"
                     onClick="location.href='login'" />
                  <button type="submit" id="join_button" class="btn gray mr0">회원가입</button>

               </div>
            </div>
         </fieldset>
      </div>
      <!--//sub container-->
   </div>
</form>


<!-- footerWrap -->

<script>
   //구영모 추가 작성
   // 스프링 시큐리티에서 idCheck를 할때 post방식으로 넘겨주어서 생기는 엑세스 거부를 해결하기 위한 코드
   var token = $("meta[name='_csrf']").attr("content");
   var header = $("meta[name='_csrf_header']").attr("content");
   
   //이메일주소 합쳐서 한번에 저장하기
   $("#email_address").blur(function() {
      email();
   });
   $("#userEmail").blur(function() {
      email();
   });

   function email() {

      const email_id = $("#userEmail").val();
      const middle = $("#middle").text();

      const email_domain = $("#email_address").val();

      if (email_id != "" && email_domain != "") {
         $("#totalEmail").val(email_id + middle + email_domain);
      }
   }

   // 아이디 중복체크
   function checkId() {
      var id = $('#id').val(); //id값이 "id"인 입력란의 값을 저장
      console.log(id);
      var token = $("meta[name='_csrf']").attr('content');
      var header = $("meta[name='_csrf_header']").attr('content');
      
      $.ajax({
         url : './idCheck', //Controller에서 요청 받을 주소
         type : 'post', //POST 방식으로 전달
         data : {
            id : $("#id").val()
         },
         dataType : 'text',
         
         /*author:구영모 데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
         beforeSend : function(xhr){
            if(token && header){
                 $(document).ajaxSend(function(event, xhr, options) {
                     xhr.setRequestHeader(header, token);
                 });
            }
         },
         success : function(result) {
            console.log(result);
            //컨트롤러에서 넘어온 cnt값을 받는다 
            if (result == "possible") { //cnt가 1이 아니면(=0일 경우) -> 사용 가능한 아이디 
               $('.id_ok').css("display", "inline-block");
               $('.id_already').css("display", "none");

            } else {
               // cnt가 1일 경우 -> 이미 존재하는 아이디
               $('.id_already').css("display", "inline-block");
               $('.id_ok').css("display", "none");
            }
         },
         error : function(request, status, error) {
            alert("status : " + request.status + ", message : " + request.responseText + ", error : " + error);
         }
      });
   };

   // 비밀번호 확인
   $(function() {
      $('#pwc').blur(function() {
         if ($('#pw').val() != $('#pwc').val()) {
            if ($('#pwc').val() != '') {
               $('.pw_notokay').css("display", "inline-block");
               $('.pw_ok').css("display", "none");
               $('#pwc').val('');
               $('#pwc').focus();
            }
            }else{
               $('.pw_ok').css("display", "inline-block");
               $('.pw_notokay').css("display", "none");
         }
      })
   });
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>