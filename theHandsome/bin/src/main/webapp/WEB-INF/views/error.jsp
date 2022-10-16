<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <!-- 
  /* 작성자 : 문혁
 * 에러페이지. 
 * 404, 405, 500 에러 발생시 해당 페이지 출력
 */
   -->
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="Cache-Control" content="No-Cache"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=1, target-densitydpi=medium-dpi" />
<title> 서비스 이용에 불편을 드려서 죄송합니다! | THE HANDSOME.COM </title>
<!-- ie8 미디어쿼리 사용하기위해 스크립트보다 상위에 위치해야 함 -->
<link rel="shortcut icon" href="http://cdn.thehandsome.com/_ui/desktop/common/images/common/thehandsome_ic_16x16.ico" />	        
<link rel="stylesheet" type="text/css" href="/resources/_ui/desktop/common/css/common.css" media="all" />
<link rel="stylesheet" type="text/css" href="/resources/_ui/desktop/common/css/layout.css" media="all" />
<link rel="stylesheet" type="text/css" href="/resources/_ui/desktop/common/css/contents.css" media="all" />
<link rel="stylesheet" type="text/css" href="/resources/_ui/desktop/common/css/popup.css" media="all" />

<script type="text/javascript" src="/resources/_ui/desktop/common/js/jquery-1.11.2.js"></script>
</head>

<!-- This script is for AceCounter START -->
<script language="javascript"  type="text/javascript">
	var _ERR='err';
</script>
<!-- AceCounter END -->

<script type="text/javascript">
//<![CDATA[
$(document).ready(function(){
	if(location.href.indexOf("/ko") > -1){
		$("#ko").show();
		$("#en").hide();
		$("#zh").hide();
	}else if(location.href.indexOf("/en") > -1){
		$("#ko").hide();
		$("#en").show();
		$("#zh").hide();
	}else if(location.href.indexOf("/zh") > -1){
		$("#ko").hide();
		$("#en").hide();
		$("#zh").show();
	}		
});

function language(country) {
	
	var status =  $("#"+country+"").css("display");
	if(status == 'none'){
		$("#ko").hide();
		$("#en").hide();
		$("#zh").hide();
		
		$("#"+country+"").show();
	} 
};
//]]>
</script>
<body>
<!-- bodyWrap -->
<div id="bodyWrap">
	<!-- sub_container -->
	<div class="sub_container error_container">

		<div class="errorwrap" id="ko">
			<div class="top_error">
                <h1 class="logo">
				    <a href="#">thehandsome.com</a>
                </h1>
               
                <a href="javascript:language('zh');">中文</a>
               	<a href="javascript:language('en');">ENGLISH</a>
                <a href="#">한국어</a>
                </div>
            <div class="con_error">
            	<p>아직 준비중인 페이지 입니다.</p>
	            <p>서비스 이용에 불편을 드려서 죄송합니다!</p>
<!-- 	            <span>방문하시려는 페이지의 주소가 잘못 입력되었거나,<br />페이지의 주소가 변경 혹은 삭제되어 요청하신 페이지를 찾을 수 없습니다.<br /><br />입력한 주소가 정확한지 다시 한번 확인해주시길 바랍니다.</span> -->
            </div>
            <div class="btnwrap">
                <a href="/main" class="btn wt_ss">더한섬닷컴 메인으로</a>
            </div>
	                	
        </div>
        
        <div class="errorwrap" id="en" style="display:none;">
        	<div class="top_error">
                <h1 class="logo">
				    <a href="#">thehandsome.com</a>
                </h1>
                
                <a href="javascript:language('zh');">中文</a>
               	<a href="#">ENGLISH</a>
                <a href="javascript:language('ko');">한국어</a>
                <!-- <a href="mailto:globalcs@thehandsome.com">Customer Center</a> -->
            </div>
            <div class="con_error">
	            <p>We are sorry for any inconvenience caused by the recent service.</p>
	            <span>The webpage cannot be found.<br />This error is caused because the website address is typed incorrectly,<br />has been deleted, or changed.<br /><br />Make sure the address is correct and try again.</span>
            </div>
            <div class="btnwrap">
                <a href="/main" class="btn wt_ss">Go to thehandsome.com</a>
            </div>
		</div>            
		
		<div class="errorwrap" id="zh" style="display:none;">               	
			<div class="top_error">
                <h1 class="logo">
				    <a href="#">thehandsome.com</a>
                </h1>
                
				<a href="#">中文</a>
               	<a href="javascript:language('en');">ENGLISH</a>
                <a href="javascript:language('ko');">한국어</a>
               <!--  <a href="mailto:globalcs@thehandsome.com">客服中心</a> -->
            </div>
            <div class="con_error">
	            <p>非常抱！</p>
	            <span>入的址无法。<br />此不存在或址已更。<br /><br />再次地址。</span>
            </div>
            <div class="btnwrap">
                <a href="/main" class="btn wt_ss">返回thehandsome.com首</a>
            </div>
		</div>
		
	</div>
	<!-- //sub_container -->
</div>
<!-- //bodyWrap -->
</body>

<!-- AceCounter Log Gathering Script V.7.5.2013010701 -->
<script language='javascript'>
	var _AceGID=(function(){var Inf=['dgc17.acecounter.com','8080','AP6F40149814536','CW','0','NaPm,Ncisy','ALL','0']; var _CI=(!_AceGID)?[]:_AceGID.val;var _N=0;var _T=new Image(0,0);if(_CI.join('.').indexOf(Inf[3])<0){ _T.src =( location.protocol=="https:"?"https://"+Inf[0]:"http://"+Inf[0]+":"+Inf[1]) +'/?cookie'; _CI.push(Inf);  _N=_CI.length; } return {o: _N,val:_CI}; })();
	var _AceCounter=(function(){var G=_AceGID;if(G.o!=0){var _A=G.val[G.o-1];var _G=( _A[0]).substr(0,_A[0].indexOf('.'));var _C=(_A[7]!='0')?(_A[2]):_A[3];	var _U=( _A[5]).replace(/\,/g,'_');var _S=((['<scr','ipt','type="text/javascr','ipt"></scr','ipt>']).join('')).replace('tt','t src="'+location.protocol+ '//cr.acecounter.com/Web/AceCounter_'+_C+'.js?gc='+_A[2]+'&py='+_A[4]+'&gd='+_G+'&gp='+_A[1]+'&up='+_U+'&rd='+(new Date().getTime())+'" t');document.writeln(_S); return _S;} })();
</script>
<noscript><img src='http://dgc17.acecounter.com:8080/?uid=AP6F40149814536&je=n&' border='0' width='0' height='0' alt=''></noscript>	
<!-- AceCounter Log Gathering Script End --> 

</html>