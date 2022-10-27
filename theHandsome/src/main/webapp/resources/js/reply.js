/*****************************************************
 * @function : reply.js
 * @author : 구영모
 * @Date : 2022.10.23
 * 게시판 댓글 처리를 위한 코드 ajax, js, jquery사용
 *****************************************************/

var replyService= (function(){
	//댓글 삽입
  	function add(reply, callback, error) {
	    console.log("add reply...............");
	    $.ajax({
	      type : 'post',
	      url : '/replies/new',
	      data : JSON.stringify(reply),
	      contentType : "application/json; charset=utf-8",
	      success : function(result, status, xhr) {
	        if (callback) {callback(result); }
	      } ,
	      error : function(xhr, status, er) {
	        if (error) {error(er);}//end if
	      }//end error
	    })//end ajax
	 }//end add
	//댓글 리스트 불러오기
	function getList(param, callback, error){
		console.log("reply getlist...........");
		var bno = param.bno;
		var page = param.page;
		$.getJSON("/replies/pages/" + bno + "/" + page + ".json", 
			function(data) {
			if(callback){
				callback(data);
			}//end if			
		}).fail(function(xhr,status,err) {
			if(error){error()}; //end if			
		}); //end getJSON	
	}
	//댓글 삭제
	function remove(rno, callback,error) {
		$.ajax({
			type: "delete",
			url : "/replies/" + rno,
			success: function(deleteResult,status,xhr) {
				if(callback){
					callback(deleteResult);
				}; //end if				
			}//end sucess
		,
		error: function(xhr,status,er) {
			if(error){ error(er)}; //end if			
			}//end error
		})//end ajax				
	}//end remove func
	//댓글 수정
	function update(reply, callback, error) {		
		console.log("RNO: " + reply.rno);		
		$.ajax({
			type: "put",
			url: "/replies/" + reply.rno,
			data: JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success: function(result,status,xhr) {
				if(callback){
					callback(result);
				}//end if				
			}//end success.. 
		    ,
		    error: function(xhr,status,er) {
				if(error){error(er)}; //end if
			}//end err..					
		})//end ajax		
	}//end update
	
	//번호로 표시된 댓글 날짜를 날짜형식으로 표기
	function displayTime(timevalue) {
		var today = new Date();
		var gap = today.getTime() - timevalue;
		var dateObj = new Date(timevalue);
		var str ="";
		if (gap < (1000 * 60 * 60 * 24)) { //댓글이 하루안이면
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi,
					':', (ss > 9 ? '' : '0') + ss ].join('');

		} else { //댓글이 하루 지났으면
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
			var dd = dateObj.getDate();
			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',
					(dd > 9 ? '' : '0') + dd ].join('');
		}//end if		
	}//end displayTime
	
	//함수의 리턴값 이름 설정
	return {
		add:add,
		getList:getList,
		remove:remove,
		update:update,
		displayTime:displayTime
	};
})();