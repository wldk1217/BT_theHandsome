var tempCnt = 0;
/**
 * @author Eddie
 * @since 2016-06-27 
 * @virsion #1245
 */
var Instagram = (function(window){
    $.ajax({
        type: "get",
        url : $.trim(handsomeContextPath) + "/intro/getInstargramAccessTokens",
        dataType : "json",
        async : false,
        contentType : "application/json",
        error : function( request, status, error ){     
            console.log( "code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
        }, 
        success : function( result ){
            window.instagramAccessTokens = result;
        }
    });
    function _instagram(options) {
        var root = this;
        options = options || {};
        root.accessTokens = options.accessTokens;
        root.cnt = 0;
        root.max = root.accessTokens.length;
        root.data = [];
        root.pagination = new Array(root.max);
        root.render = options.renderingCallBack;
        root.pageSize = options.pageSize;
        root.account = options.account;
        
        root._loadEach = function(token, pagination){
            var url = pagination.next_url || 'https://api.instagram.com/v1/users/self/media/recent/?access_token=' + token + '&count=' + root.pageSize;
            $.ajax({
                type: 'get',
                dataType: 'jsonp',
                url: url
            }).done(function(res){
                if (!pagination.done) {
                    root.data = root.data.concat(res.data);
                    try{
                        pagination.next_url = res.pagination.next_url;
                    //키값 오류시 DB요청 20180327인스타그램
                    }catch(exception){
                        console.log( "code: account error \n" + "message: check your tokenKey \n");
                        if(root.account != ''){
                            $.ajax({
                                type: "get",
                                url : "/intro/getInstargram"+"?type=search&account="+root.account,
                                cache : false,
                                dataType : "json",
                                async : false,
                                contentType : "application/json",
                                error : function( request, status, error ){     
                                    console.log( "code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
                                }, 
                                success : function( result ){
                                    if(result.length > 0){
                                        //정보 보여주기
                                        $.ajax({
                                            type: "get",
                                            url : "/intro/getInstargram",
                                            data : {type:"search",account:root.account,html:""},
                                            dataType : "json",
                                            async : false,
                                            error : function( request, status, error ){     
                                                console.log( "code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
                                            },
                                            success : function(data){
                                                renderInstagram(JSON.parse(data[0].html).data);
                                            }
                                        });
                                    }
                                }
                            });
                        }
                    }
                    if (!pagination.next_url) {
                        pagination.done = true;
                    }
                }
            }).fail(function(){
                pagination.next_url = '';
            }).always(function(){
                root.cnt += 1;
            });
        };

        root.load = function() {
        	if(tempCnt == 0) {
        		tempCnt = 1;
	            $.each(root.accessTokens, function(i, token){
	                if (root.pagination[i] === undefined) {
	                    root.pagination[i] = {'next_url' : ''};
	                }
	                root._loadEach(token, root.pagination[i]);
	            });
	
	            var loadData = setInterval(function(){
	                if (root.cnt >= root.max) {
	                    root.data.sort(function(a, b){
	                        a = a.created_time;
	                        b = b.created_time;
	                        return a < b ? 1 : (a > b ? -1 : 0);
	                    });
	
	                    root.render.call(this, root.data, root.pagination);
	                    clearInterval(loadData);
	                    root.cnt = 0;
	                    root.data = [];
	                    tempCnt = 0;
	                }
	            }, 100);
        	}
        };
    }

    var instance;

    var _static = {
        getInstance: function(options) {
            if (instance === undefined) {
                instance = new _instagram(options);
            }
            return instance;
        }
    };

    return _static;
})(window);
