(function () {
    var matched, browser;
 
    // Use of jQuery.browser is frowned upon.
    // More details: http://api.jquery.com/jQuery.browser
    // jQuery.uaMatch maintained for back-compat
    jQuery.uaMatch = function (ua) {
        ua = ua.toLowerCase();
 
        var match = /(chrome)[ \/]([\w.]+)/.exec(ua) ||
            /(webkit)[ \/]([\w.]+)/.exec(ua) ||
            /(opera)(?:.*version|)[ \/]([\w.]+)/.exec(ua) ||
            /(msie) ([\w.]+)/.exec(ua) ||
            ua.indexOf("compatible") < 0 && /(mozilla)(?:.*? rv:([\w.]+)|)/.exec(ua) ||
            [];
 
        return {
            browser: match[1] || "",
            version: match[2] || "0"
        };
    };
 
    matched = jQuery.uaMatch(navigator.userAgent);
    browser = {};
 
    if (matched.browser) {
        browser[matched.browser] = true;
        browser.version = matched.version;
    }
 
    // Chrome is Webkit, but Webkit is also Safari.
    if (browser.chrome) {
        browser.webkit = true;
    } else if (browser.webkit) {
        browser.safari = true;
    }
 
    jQuery.browser = browser;
})();


var CommonController = function(){
    
    this.name = "CommonController";
    this.doWork = function(){
        this.setData();
        this.doFunction();
    };
};


var roadSearchProcessCheck = true;

/** 

page 셋팅하는 스크립트

[totalItemCount : 데이타 총 개수. 필수값]
[pagingArea : 페이징 내용이 삽입될 부분. jquery selector 형태. 필수값]
[curPageNum : 현재 페이지 번호. default = 1. 필수값 아님]
[pagingSize : 페이징 처리될 데이타 개수. default = 10, 필수값 아님]
[pageDisplaySize : 화면에 나타날 페이지 개수. default = 10, 필수값 아님]

========================[example code]===========================

var doSomething = new PageNavigationController(".paging", null, 5);
doSomething.setPage(493, 3);

=================================================================

실제로 데이타 처리와 연동되는 부분은 구현해서 사용? 해야하려나?.....
오버라이드 해서 사용해야하나...?


*/
var PageNavigationController = function(pagingArea, pagingSize, pageDisplaySize  ){
    var t = this; //this의 별칭. each문 등의 this를 사용하지 못하는 공간에서 사용한다.

    this.name = "PageNavigationController";

    var PARAMS = {};
    
    PARAMS.pagingArea = $(pagingArea);
    PARAMS.pagingSize = pagingSize!=null?pagingSize:10;
    PARAMS.pageDisplaySize = pageDisplaySize!=null?pageDisplaySize:10;

    this.setPage = function(totalItemCount, curPageNum){
        this.setData(totalItemCount, curPageNum);
        this.doFunction();
    };


    this.setData = function(totalItemCount, curPageNum){
        PARAMS.totalItemCount = totalItemCount;
        this.setCurPageNum(curPageNum);
    };

    this.setCurPageNum = function(pageNum){
        PARAMS.curPageNum = pageNum!=null?pageNum:1;
        
        PARAMS.endPageNum = Math.ceil(PARAMS.totalItemCount/PARAMS.pagingSize);
        if(PARAMS.curPageNum > PARAMS.endPageNum || PARAMS.curPageNum < 1) PARAMS.curPageNum = 1;       
        var tempNum = Math.floor((PARAMS.curPageNum-1)/PARAMS.pageDisplaySize);
        PARAMS.startPageNum = tempNum*PARAMS.pageDisplaySize+1;

    };

    this.doFunction = function(){

        if(PARAMS.totalItemCount>0){
            this.setHtml();
            this.setAction();
        }else{
            PARAMS.pagingArea.html('');
        }

    };


    this.setHtml = function(){
        var pagingHtml = '';
        
        var firstPageBtn = '<a  class="prev2" href="javascript:void(0);">처음 페이지로 이동</a>';
        var prevPageBtn = '<a href="javascript:void(0);" class="prev">이전 페이지로 이동</a>';

        
        var pageBtn = '<span class="num">';
        for(var i = 0; i<PARAMS.pageDisplaySize; i++){
            var pageNum = i+PARAMS.startPageNum;
            var activeClass = '';
            if(pageNum == PARAMS.curPageNum) activeClass = ' on ';

            pageBtn +='<a href="javascript:void(0);" class="pageBtn '+activeClass+' " pageNum="'+pageNum+'" >'+pageNum+'</a>';

            if(pageNum>=PARAMS.endPageNum) break;
        }

        pageBtn += '</span>';

        var nextPageBtn = '<a href="javascript:void(0);" class="next" >다음 페이지로 이동</a>';
        var endPageBtn = '<a href="javascript:void(0);" class="next2" >마지막 페이지로 이동</a>';

        pagingHtml = firstPageBtn + prevPageBtn + pageBtn + nextPageBtn + endPageBtn;
        
        PARAMS.pagingArea.html(pagingHtml);
    };
    

    this.setAction = function(){
        var thisArea = PARAMS.pagingArea;

        thisArea.find(".prev2").click(function(){
            t.goPage(1);
            if($("#listBody").length > 0){
                $(document).scrollTop(0);
            }
        });

        thisArea.find(".prev").click(function(){
            var pageNum = parseInt($(this).siblings(".num").find('.on').attr("pageNum"))-1;
            if(pageNum<1) pageNum = 1;
            t.goPage(pageNum);
            if($("#listBody").length > 0){
                $(document).scrollTop(0);
            }
        });

        thisArea.find(".pageBtn").click(function(){
            t.goPage($(this).attr("pageNum"));
            if($("#listBody").length > 0){
                $(document).scrollTop(0);
            }
        });

        thisArea.find(".next").click(function(){
            var pageNum = parseInt($(this).siblings(".num").find('.on').attr("pageNum"))+1;
            if(pageNum>PARAMS.endPageNum) pageNum = PARAMS.endPageNum;
            t.goPage(pageNum);
            if($("#listBody").length > 0){
                $(document).scrollTop(0);
            }
        });

        thisArea.find(".next2").click(function(){
            t.goPage(PARAMS.endPageNum);
            if($("#listBody").length > 0){
                $(document).scrollTop(0);
            }
        });
        
    };

    this.goPage = function(targetPageNum){

        PARAMS.pagingArea.html('');
        this.setCurPageNum(targetPageNum);
        this.doFunction();
        this.dynamicAction(targetPageNum);

    };

    this.dynamicAction = function(targetPageNum){
    

    }

};

//PageNavigationController.prototype = new CommonController();


/**
 * 
 * 게시판 형태 리스트 뿌리는 함수
 * 
 * GET 형태, Responsebody SearchPageData로 리턴하는 컨트롤러 필요,
 * JSP 페이지에 action url이 들어간 form 태그 필요
 * script로 리스트 구성하는 함수를 오버라이드 해서 사용
 * 
 * 
 * ========================[example code]===========================
 *
 * [controller sample]
 *
 *
 *@RequestMapping(value = "/myorderlist", method = RequestMethod.GET)
    @ResponseBody
    public SearchPageData<OrderData> getMyOrderList(@RequestParam(value = "pageNum", defaultValue = "1") final int pageNum,
            @RequestParam(value = "pageSize", defaultValue = "10") final int pageSize,
            @RequestParam(value = "show", defaultValue = "Page") final ShowMode showMode,
            @RequestParam(value = "sort", required = false) final String sortCode, final HttpServletRequest request, final HttpServletResponse response)
    {
        
        HashMap whereValue = new HashMap();
        
        final PageableData pageableData = createPageableData(pageNum - 1, pageSize, sortCode, showMode);
        
        SearchPageData<OrderData> datas = myOrdersFacade.getMyOrders(pageableData, whereValue);
        
        return datas;
    }
 *
 *
 *
 *
 *
 * [html sample]
 *
 *<form id="orderSearchForm" action="<c:url value="/mypage/order/myorderlist" />" >
 *
 *</form>
 *
 *
 *
 *
 *
 *
 *
 * [script sample]
 *
 *  var orderList = new BoardListController('orderSearchForm', '#listBody', '.paging', 8, 'searchBtn');
 *                                          폼아이디, 리스트공간 셀렉터, 페이징공간 셀렉터, 페이지당 리스트개수, 검색버튼 아이디
 *
    orderList.setRowHtml = function(results){
        var rows = "";
        $.each(results, function(){
            
            var listTag = '<tr>';
            listTag +=  '<td>'+this.code+'</td>';
            listTag +=  '<td>'+this.currency+'</td>';
            listTag +=  '<td>'+this.pk+'</td>';
            listTag +=  '<td>'+this.calculated+'</td>';
            listTag +=  '<td></td>';
            listTag +=  '<td></td>';
            listTag +=  '</tr>';
            
            rows +=listTag;
        });
        
        return rows;
        
    };
    orderList.doWork();
 *  
 *  =================================================================
 * 
 * 
 */
var BoardListController = function(formId, listArea, pageArea, pageSize, searchBtnId){
    var t = this; //this의 별칭. each문 등의 this를 사용하지 못하는 공간에서 사용한다.

    this.PARAMS = {};

    var paging = null;

    this.name = "BoardListController";

    t.PARAMS.formId = formId;
    
    
    t.PARAMS.pageSize = pageSize!=null?pageSize:10;
    
    t.PARAMS.paging = new PageNavigationController(pageArea, pageSize);
    t.PARAMS.pageNum = 1;
    
    t.PARAMS.defaultListHtml = $(listArea).html();
    
    if(searchBtnId!=null){
        $('#'+searchBtnId).click(function(){
            t.searchAction();
        });
    }
    
    this.setData = function(){

        t.PARAMS.jsonObjectData = null;
        t.PARAMS.resourceObjectData = null;
        this.getJsonData();

    };

    this.getJsonData = function(){
        
        var paramDatas = $("form#"+formId ).serialize();
        if(paramDatas!="") paramDatas +="&";
        paramDatas +="pageNum="+t.PARAMS.pageNum+"&pageSize="+t.PARAMS.pageSize;
        
        
        $.ajax({
            type: "get",
            url :  $("form#"+formId ).attr("action"),
            data : paramDatas,          
            dataType : "json",
            cache: false,
            error : function( request, status, error ){
                //alert(error);
                t.PARAMS.jsonObjectData = 0;
            }, 
            success : function( result ){
                t.PARAMS.jsonObjectData = result;
                
                t.makeResource();
            }
        });
    
    };

    this.makeResource = function(){
        //특별한 데이터 가공이 필요한 경우 오버라이드해서 사용
        t.PARAMS.resourceObjectData = t.PARAMS.jsonObjectData;
    };


    this.doFunction = function(){
        
        var j = 0;
        var chkTimer = setInterval(chkData, 100); // 1000 = 1초입니다.
        function chkData()
        {
            
            if(t.PARAMS.jsonObjectData ==null){
                if(j==500) clearInterval(chkTimer);
                j++;
                return false;
            }else if(t.PARAMS.jsonObjectData!=0){
                
                clearInterval(chkTimer);
                
                t.setListHtml();
                
                if(t.PARAMS.jsonObjectData.pagination!=null){
                    
                    t.PARAMS.paging.setPage(t.PARAMS.jsonObjectData.pagination.totalNumberOfResults, t.PARAMS.pageNum);
                    t.PARAMS.paging.goPage = function(targetPageNum){
                        $( 'body' ).scrollTop(0);
                        t.PARAMS.pageNum = targetPageNum;
                        t.doWork();
                    };
                }
                
            }
            
            clearInterval(chkTimer);
            
        }

    };

    this.setListHtml = function(){
        
        var sumListTag = null;
        if(t.PARAMS.jsonObjectData.results!=null){
            sumListTag = this.setRowHtml(t.PARAMS.jsonObjectData.results);
        }else{
            sumListTag = this.setRowHtml(t.PARAMS.jsonObjectData);
        }

        if(sumListTag!="") $(listArea).html(sumListTag);
        else $(listArea).html(t.PARAMS.defaultListHtml);
        
        this.afterSetAction();
    };

    
    
    /************오버라이드!!***********/
    this.setRowHtml = function(results){
    //이 함수는 각자 리스트에 맞게 반드시 오버라이드 하세요.
        
        var rows = "";
        
        $.each(results, function(){
            
            var listTag = '<tr>';
            listTag +=  '<td>'+this.code+'</td>';
            listTag +=  '<td>'+this.currency+'</td>';
            listTag +=  '<td>'+this.pk+'</td>';
            listTag +=  '<td>'+this.calculated+'</td>';
            listTag +=  '<td></td>';
            listTag +=  '<td></td>';
            listTag +=  '</tr>';
            
            rows +=listTag;
        });
        
        return rows;
        
    };
    
    this.searchAction = function(){
        
        t.PARAMS.pageNum = 1;
        t.doWork();
        
    }
    
    this.afterSetAction = function(){
        //혹시 리스트 셋팅 후에 처리해야하는 로직이 있을경우 이 함수 오버라이드해서 사용
    }



};

BoardListController.prototype = new CommonController();




String.prototype.trim = function() {
    return this.replace(/^\s\s*/,"").replace(/\s\s*$/,"");
}



var BoardDetailController = function(){

};

BoardDetailController.prototype = new CommonController();









var LayerPopupController = function(layerId){

    /*
    params

    layerID
    x좌표, y좌표????????? 클릭 기준점???? (default  :  center)
    입력 내용 유지여부 true, false

    딱히 셋팅하는 부분 없이.

    openLayerPopup

    
    */


    var PARAMS = {};
    PARAMS.layerId = layerId;
    PARAMS.layer = $("#"+PARAMS.layerId);


    this.openNewLayer = function(){

        var layerTag = '<div class="layerArea">';
        layerTag +='<div class="layerBg"></div> ';
        layerTag +='</div>';

        var thisLayer = $(layerTag).appendTo($('body')).append(PARAMS.layer.clone().show());

        $('.layerBg, .btn_close').click(function(){
            thisLayer.remove();
        });
    };

    
    this.openNewLayerCenter = function(){

//      var lp=($(window).width()-PARAMS.layer.width())/2;
        var tp=($(window).height()-PARAMS.layer.height())/2+$(window).scrollTop();
        
//      if(lp<0) lp=0;
        if(tp<0) tp=0;
        
//      PARAMS.layer.css("left",lp).css("top", tp).css("position", "absolute").css("z-index", 101);
        PARAMS.layer.css("top", tp).css("position", "absolute").css("z-index", 101);
        
        var layerTag = '<div class="layerArea">';
        layerTag +='<div class="layerBg"></div> ';
        layerTag +='</div>';

        var thisLayer = $(layerTag).appendTo($('body')).append(PARAMS.layer.show());

        thisLayer.find('.btn_close, .okBtn').click(function(){
            thisLayer.remove();
        });
    };
    
};



/**
 * 
센터에 레이어 팝업 뜨는 함수
display:none 처리되어있는 팝업 DIV 영역을 CLONE으로 복사해서 사용한다.
따라서 닫을때 remove 하고 다시 띄울 때 새로운 창을 띄우므로
닫기전 데이타를 가지고 있지 않는 장점이 있지만
동일한 레이어가 한테이지에 두개가 생기기때문에  요소 접근에 신경을 써야한다.

========================[example code]=======================
    layerPopup('레이어영역ID');
=============================================================
*
*/
var layerPopup = function(layerId){

    var PARAMS = {};
    PARAMS.layerId = layerId;
    PARAMS.layer = $("#"+PARAMS.layerId);


    this.openNewLayer = function(){

//      var lp=($(window).width()-PARAMS.layer.width())/2;
        //var tp=($(window).height()-PARAMS.layer.height())/2+$(window).scrollTop();
        var tp=getMarginTop(PARAMS.layer.height());
//      if(lp<0) lp=0;
        if(tp<0) tp=0;
        
//      PARAMS.layer.css("left",lp).css("top", tp).css("position", "absolute").css("z-index", 101);
        PARAMS.layer.css("top", tp).css("position", "absolute").css("z-index", 101);
        
        var layerTag = '<div class="layerArea">';
        layerTag +='<div class="layerBg"></div> ';
        layerTag +='</div>';

        var thisLayer = $(layerTag).appendTo($('body')).append(PARAMS.layer.clone().show());
        //$('body').css("cssText", " overflow:hidden !important");
        var existedStyle = $('body').attr('style') || '';
        if (existedStyle) {
            existedStyle += ';';
        }
        $('body').attr('style', existedStyle + 'overflow:hidden !important');
        
        
        thisLayer.find('.layerBg, .btn_close, .okBtn').click(function(){
            //$('body').css('overflow', '');
            $('body').attr('style', existedStyle);
            thisLayer.remove();
            return false;
        });
        
        return thisLayer;
    };
    
    return this.openNewLayer();
};








/*
layer popup 형식의 alert 창

========================[example code]===========================
    layerAlert('메세지를 입력하세요');
    
    var lc = new layerAlert('입력하신 정보가 변경완료 되었습니다.');
    lc.confirmAction = function(){
        //alert화면 실행후 후속 처리 부분 추가
        location.href="<c:url value="/mypage/order/myorders"/>";
    };
    
※ 2017.05.22, HSLee, "fixedYn" Argument 추가.
=============================================================
*/
var layerAlert = function(msg, refresh, fixedYn){
    var t = this;

    this.confirmAction = function(){
        
    };
    
    var addClsNm = (fixedYn) ? 'pstn_fixed' : ''; 
    
    var alertTag = '<div class="layerArea" style="z-index:1110;display:none" id="layerDiv">';
    alertTag +='<div class="layerBg"></div> ';
    alertTag +='<div class="popwrap w_type_1 '+addClsNm+'" style="z-index:150;"> ';
    alertTag +='<div class="pop_cnt">';
    alertTag +='<h3 class="pop_tlt copy">'+msg+'</h3>';
    alertTag +='<div class="btnwrap">';
    alertTag +='<input type="button" class="btn gray_s mr0" value="'+$('#deliveryOkMsg').val()+'">';
    alertTag +='</div>';
    alertTag +='</div>';
    alertTag +='<a href="javascript:void(0);" class="btn_close"><img src="/_ui/desktop/common/images/popup/ico_close.png" alt="닫기"></a>';
    alertTag +='</div>';
    alertTag +='</div>';

        var scrollTopCurrent = $(window).scrollTop();
        var $alertLayer = $(alertTag).appendTo($("body"));
        $alertLayer.find('.popwrap').css('marginTop', getMarginTop2(250,scrollTopCurrent));
        $("#layerDiv").show();
    //$('body').css("cssText", " overflow:hidden !important");
    var existedStyle = $('body').attr('style') || '';
    if (existedStyle) {
        existedStyle += ';';
    }
    $('body').attr('style', existedStyle + 'overflow:hidden !important');
    
    if(addClsNm.length<1){
        $alertLayer.find('.popwrap').css('marginTop', getMarginTop($alertLayer.find('.popwrap').outerHeight()));
    }
    
    $alertLayer.find('.layerBg, .btn_close, .btn.gray_s').click(function(){
        //$('body').css('overflow', '');
        $('body').attr('style', existedStyle);
        $alertLayer.remove();
        if(refresh==true) location.reload();
        t.confirmAction();
    });
};

/*
layer popup 형식의 alert 창

========================[example code]===========================
    layerAlert('메세지를 입력하세요');

    var lc = new layerAlert('입력하신 정보가 변경완료 되었습니다.');
    lc.confirmAction = function(){
        //alert화면 실행후 후속 처리 부분 추가
        location.href="<c:url value="/mypage/order/myorders"/>";
    };

※ 2020.01.20 nih - x 버튼 클릭시 confirmAction 실행하지 않고 alert 창만 닫는 layeralert
※ 2021.03.30 seonghun.kim - isFreeGift : 사은품 반품 신청시 메시지 클래스 변경
=============================================================
*/
var closeNotConfirmLayerAlert = function(msg, refresh, fixedYn, isFreeGift){
    var t = this;

    this.confirmAction = function(){

    };

    var addClsNm = (fixedYn) ? 'pstn_fixed' : '';

    var alertTag = '<div class="layerArea" style="z-index:1110;display:none" id="layerDiv">';
    alertTag +='<div class="layerBg"></div> ';
    alertTag +='<div class="popwrap w_type_1 '+addClsNm+'" style="z-index:150;"> ';
    alertTag +='<div class="pop_cnt">';
    
    if (isFreeGift) {
        alertTag +='<div class="pop_tlt copy">'+msg+'</div>';
    } else {
        alertTag +='<h3 class="pop_tlt copy">'+msg+'</h3>';        
    }
    
    alertTag +='<div class="btnwrap">';
    alertTag +='<input type="button" class="btn gray_s mr0" value="'+$('#deliveryOkMsg').val()+'">';
    alertTag +='</div>';
    alertTag +='</div>';
    alertTag +='<a href="javascript:void(0);" class="btn_close"><img src="/_ui/desktop/common/images/popup/ico_close.png" alt="닫기"></a>';
    alertTag +='</div>';
    alertTag +='</div>';

    var scrollTopCurrent = $(window).scrollTop();
    var $alertLayer = $(alertTag).appendTo($("body"));
    $alertLayer.find('.popwrap').css('marginTop', getMarginTop2(250,scrollTopCurrent));
    $("#layerDiv").show();
    var existedStyle = $('body').attr('style') || '';
    if (existedStyle) {
        existedStyle += ';';
    }
    $('body').attr('style', existedStyle + 'overflow:hidden !important');

    if(addClsNm.length<1){
        $alertLayer.find('.popwrap').css('marginTop', getMarginTop($alertLayer.find('.popwrap').outerHeight()));
    }

    $alertLayer.find('.btn.gray_s').click(function(){
        $('body').attr('style', existedStyle);
        $alertLayer.remove();
        if(refresh==true) location.reload();
        t.confirmAction();
    });

    $alertLayer.find('.layerBg, .btn_close').click(function(){
        $('body').attr('style', existedStyle);
        $alertLayer.remove();
        if(refresh==true) location.reload();
    });
};

var customLayerAlert = function(msg, refresh, fixedYn){
    var t = this;

    this.confirmAction = function(){
        
    };
    
    var addClsNm = (fixedYn) ? 'pstn_fixed' : ''; 
    
    var alertTag = '<div class="layerArea" style="z-index:1110">';
    alertTag +='<div class="layerBg"></div> ';
    alertTag +='<div class="popwrap w_type_1 '+addClsNm+'" style="z-index:150;"> ';
    alertTag +='<div class="pop_cnt">';
    alertTag +='<h3 class="pop_tlt copy" style="font-family:\'Malgun Gothic\',sans-serif;">'+msg+'</h3>';
    alertTag +='<div class="btnwrap">';
    alertTag +='<input type="button" class="btn gray_s mr0" value="'+$('#deliveryOkMsg').val()+'">';
    alertTag +='</div>';
    alertTag +='</div>';
    alertTag +='<a href="javascript:void(0);" class="btn_close"><img src="/_ui/desktop/common/images/popup/ico_close.png" alt="닫기"></a>';
    alertTag +='</div>';
    alertTag +='</div>';

    var scrollTopCurrent = $(window).scrollTop();
    var $alertLayer = $(alertTag).appendTo($("html"));
    $alertLayer.find('.popwrap').css('marginTop', getMarginTop2(250,scrollTopCurrent));
    
    var existedStyle = $('body').attr('style') || '';
    if (existedStyle) {
        existedStyle += ';';
    }
    
    if(addClsNm.length<1){
        $alertLayer.find('.popwrap').css('marginTop', getMarginTop($alertLayer.find('.popwrap').outerHeight()));
    }
    
    $alertLayer.find('.layerBg, .btn_close, .btn.gray_s').click(function(){
        $('body').attr('style', existedStyle);
        $alertLayer.remove();
        if(refresh==true) location.reload();
        t.confirmAction();
    });
};

var layerStorePickupInfo = function(msg, refresh, fixedYn){
    var t = this;

    this.confirmAction = function(){
        
    };
    
    var addClsNm = (fixedYn) ? 'pstn_fixed' : ''; 
    
    var alertTag = "";
    alertTag += '<div class="layerArea" style="z-index:1110">';
    alertTag +='    <div class="layerBg"></div> ';
    alertTag +='    <div class="popwrap w_type_1 '+addClsNm+'" style="z-index:150;"> ';
    alertTag +=         msg;
    alertTag +='        <a href="javascript:void(0);" class="btn_close"><img src="/_ui/desktop/common/images/popup/ico_close.png" alt="닫기"></a>';
    alertTag +='    </div>';
    alertTag +='</div>';

    var $alertLayer = $(alertTag).appendTo($("body"));
    
    //$('body').css("cssText", " overflow:hidden !important");
    var existedStyle = $('body').attr('style') || '';
    if (existedStyle) {
        existedStyle += ';';
    }
    $('body').attr('style', existedStyle + 'overflow:hidden !important');
    
    if(addClsNm.length<1){
        $alertLayer.find('.popwrap').css('marginTop', getMarginTop($alertLayer.find('.popwrap').outerHeight()));
    }
    
    $alertLayer.find('.layerBg, .btn_close, .btn.gray_s').click(function(){
        //$('body').css('overflow', '');
        $('body').attr('style', existedStyle);
        $alertLayer.remove();
        if(refresh==true) location.reload();
        t.confirmAction();
    });
};

/*
layer popup 형식의 confirm 창



========================[example code]===========================

    var lc = new layerConfirm('메세지를 입력하세요', '확인버튼', '취소버튼');
    lc.confirmAction = function(){
        console.log('재정의한 함수입니다.');
    };

=============================================================

*/
var layerConfirm = function(msg, confirmMsg, cancleMsg){

    
    var t = this;

    this.confirmAction = function(){
        
    };
    this.cancelAction = function(){
    	
    };
    
    var cnMsg = cancleMsg==null?$('#deliveryCancelMsg').val():cancleMsg;
    var cfMsg = confirmMsg==null?$('#deliveryOkMsg').val():confirmMsg;

    var alertTag = '<div class="layerArea" style="z-index:1110">';
    alertTag +='<div class="layerBg"></div> ';
    alertTag +='<div class="popwrap w_type_1" style="z-index:150"> ';
    alertTag +='<div class="pop_cnt">';
    alertTag +='<h3 class="pop_tlt copy">'+msg+'</h3>';
    alertTag +='<div class="btnwrap">';
    alertTag +='<input type="button" id="clsBtn" class="btn wt_s mr5" value="'+cnMsg+'">';
    alertTag +='<input type="button" id="cfBtn" class="btn gray_s mr0" value="'+cfMsg+'">';
    alertTag +='</div>';
    alertTag +='</div>';
    alertTag +='<a href="javascript:void(0);" class="btn_close"><img src="/_ui/desktop/common/images/popup/ico_close.png" alt="닫기" /></a>';
    alertTag +='</div>';
    alertTag +='</div>';
    

    var $alertLayer = $(alertTag).appendTo($("body"));
    
    //$('body').css("cssText", " overflow:hidden !important");
    var existedStyle = $('body').attr('style') || '';
    if (existedStyle) {
        existedStyle += ';';
    }
    $('body').attr('style', existedStyle + 'overflow:hidden !important');
    
    $alertLayer.find('.popwrap').css('marginTop', getMarginTop($alertLayer.find('.popwrap').outerHeight()));

    
    $alertLayer.find('.layerBg, .btn_close, #clsBtn').click(function(){
        //$('body').css('overflow', '');
        $('body').attr('style', existedStyle);
        $alertLayer.remove();
        t.cancelAction();
    });

    $alertLayer.find('#cfBtn').click(function(){
        $('body').css('overflow', '');
        $alertLayer.remove();
        t.confirmAction();
    });

};

var customLayerConfirm = function(msg, confirmMsg, cancleMsg){
    var t = this;
    this.confirmAction = function(){
        
    };
    var cnMsg = cancleMsg==null?$('#deliveryCancelMsg').val():cancleMsg;
    var cfMsg = confirmMsg==null?$('#deliveryOkMsg').val():confirmMsg;

    var alertTag = '<div class="layerArea" style="z-index:1110">';
    alertTag +='<div class="layerBg"></div> ';
    alertTag +='<div class="popwrap w_type_1" style="z-index:150; width:343px;"> ';
    alertTag +='<div class="pop_cnt">';
    alertTag +='<h3 class="pop_tlt copy" style="font-family:\'Malgun Gothic\',sans-serif;">'+msg+'</h3>';
    alertTag +='<div class="btnwrap">';
    alertTag +='<input type="button" id="clsBtn" class="btn wt_s mr5" value="'+cnMsg+'">';
    alertTag +='<input type="button" id="cfBtn" class="btn gray_s mr0" value="'+cfMsg+'">';
    alertTag +='</div>';
    alertTag +='</div>';
    alertTag +='<a href="javascript:void(0);" class="btn_close"><img src="/_ui/desktop/common/images/popup/ico_close.png" alt="닫기" /></a>';
    alertTag +='</div>';
    alertTag +='</div>';
    

    var $alertLayer = $(alertTag).appendTo($("html"));
    
    var existedStyle = $('body').attr('style') || '';
    if (existedStyle) {
        existedStyle += ';';
    }
    
    $alertLayer.find('.popwrap').css('marginTop', getMarginTop($alertLayer.find('.popwrap').outerHeight()));

    
    $alertLayer.find('.layerBg, .btn_close, #clsBtn').click(function(){
        $('body').attr('style', existedStyle);
        $alertLayer.remove();
    });

    $alertLayer.find('#cfBtn').click(function(){
        $('body').css('overflow', '');
        $alertLayer.remove();
        t.confirmAction();
    });

};


/* 
 * var lc = new layerConfirm2('메세지를 입력하세요', '취소버튼', '확인버튼');
 */
var layerConfirm2 = function(msg, confirmMsg, cancleMsg){

    
    var t = this;

    this.confirmAction = function(){
        
    };
    var cnMsg = cancleMsg==null?$('#deliveryCancelMsg').val():cancleMsg;
    var cfMsg = confirmMsg==null?$('#deliveryOkMsg').val():confirmMsg;

    var alertTag = '<div class="layerArea" style="z-index:1110">';
    alertTag +='<div class="layerBg"></div> ';
    alertTag +='<div class="popwrap w_type_1" style="z-index:150"> ';
    alertTag +='<div class="pop_cnt">';
    alertTag +='<h3 class="pop_tlt copy">'+msg+'</h3>';
    alertTag +='<div class="btnwrap">';
    alertTag +='<input type="button" id="cfBtn" class="btn gray_s mr0" value="'+cfMsg+'">';
    alertTag +='<input type="button" id="clsBtn" class="btn wt_s mr5" value="'+cnMsg+'">';
    alertTag +='</div>';
    alertTag +='</div>';
    alertTag +='<a href="javascript:void(0);" class="btn_close"><img src="/_ui/desktop/common/images/popup/ico_close.png" alt="닫기" /></a>';
    alertTag +='</div>';
    alertTag +='</div>';
    

    var $alertLayer = $(alertTag).appendTo($("body"));
    
    //$('body').css("cssText", " overflow:hidden !important");
    var existedStyle = $('body').attr('style') || '';
    if (existedStyle) {
        existedStyle += ';';
    }
    $('body').attr('style', existedStyle + 'overflow:hidden !important');
    
    $alertLayer.find('.popwrap').css('marginTop', getMarginTop($alertLayer.find('.popwrap').outerHeight()));

    
    $alertLayer.find('.layerBg, .btn_close, #clsBtn').click(function(){
        //$('body').css('overflow', '');
        $('body').attr('style', existedStyle);
        $alertLayer.remove();
    });

    $alertLayer.find('#cfBtn').click(function(){
        $('body').css('overflow', '');
        $alertLayer.remove();
        t.confirmAction();
    });

};










/*

입력값 널체크 및 숫자 체크

[formId : 체크할 폼의 아이디 , 필수값 아님. 값이 없는 경우 body태그를 기준으로 검사]

checkIdList를 배열형태로 셋팅해주면 해당 노드를 찾아서 검사.
아이디 뒤에 :num 이 붙은 경우에는 숫자인지 검사.

검사에 걸린 노드는 title 속성을 이용하여 에러메세지를 띄우기 때문에 검사 대상 태그에는 title 속정을 정의해주어야 함.

ex )     <input type="text" name="" id="id1" value="" title = "아이디" />

========================[example code]===========================

    var vc = new ValidationCheck();
    vc.checkIdList = ['id1:num','id2','id3', 'id4', 'id5'];
    console.log(vc.isValid());

=============================================================

*/

var ValidationCheck = function(formId){
    var t = this;

    this.checkIdList = null;

    var $form = $('#'+formId);
    if($form.length==0) $form = $('body');
    
    this.msgFn = function(msg){
        layerAlert(msg);
    }
    
    this.isValid = function(){

        var passed = true;
        var checkmsg = $('#validationCheckMsg').val();
        var checkmsg1 = $('#validationCheckMsg1').val();
        var checkmsg2 = $('#validationCheckMsg5').val();
        var checkmsg3 = $('#validationCheckMsg6').val();
        

        $.each(this.checkIdList , function(){

            var thisId = this.split(':')[0];
            var thisType = this.split(':')[1];
            var $this = $form.find('#'+thisId);
            
            
            //파라미터로 지정한 필수 데이타 항목 자체가 페이지에 있는지 검사하는 부분
            if($this.length===0){
                t.msgFn(checkmsg1);
            }
            

            if($this.val().length===0){
                if(thisId == "uidDuplChk")
                {
                    t.msgFn(checkmsg2);
                }
                else if(thisId == "emailDuplChk")
                {
                    t.msgFn(checkmsg3);
                }
                else 
                {
                    t.msgFn(checkmsg1);
                }
                passed = false;
                return false;
            }

            if($this.attr('type')=='radio'){

                var nm = $this.attr('name');
                if($form.find('[name='+nm+']:checked').size()===0){
                    passed = false;
                }

            }else if($this.attr('type')=='checkbox'){

                if($this.is(":checked")==false){
                    passed = false;
                }

            }else{

                if($this.val().length===0) {
                    passed = false;
                }else{
                    if(thisType=='num'){
                        if(!$.isNumeric($this.val()))   passed = false;
                    }
                }
            }

            if(passed==false){
                t.msgFn(checkmsg+'<br />'+'( '+$this.attr('title')+' )');
                
                return false;
            }
        });


        return passed;  
    };


};




/*
 * 
 * Id/Password Data Validation Check Function
 * 
 * 
 * ========================[example code]===========================

    inputDataValidationCheck('id');
    inputDataValidationCheck('password');

    =============================================================
 * 
 */

var inputDataValidationCheck = function(fid){
    var t = this;
    
    
    this.msgFn = function(msg){
        $('#'+fid).blur();
        layerAlert(msg)
    };
    this.notLockFn = function(){
        //default do nothing. but you can do something!
    };
    
    //$('#'+fid).keypress(inputDataCheck($('#'+fid).val()));
    $('#'+fid).keyup(function(event){
        //var passed = true;
        var SamePass_0 = 0; // 동일문자 카운트
        var SamePass_1 = 0; // 연속성(+) 카운드
        var SamePass_2 = 0; // 연속성(-) 카운드
        
        var checkmsg2 = $('#validationCheckMsg2').val();
        var checkmsg3 = $('#validationCheckMsg3').val();
        
        var inputdata = $('#'+fid).val();

        for (var i = 0; i < inputdata.length; i++) {     // 4자리
            var chr_pass_0 = inputdata.charCodeAt(i - 2);//3);
            var chr_pass_1 = inputdata.charCodeAt(i - 1);//2);
            var chr_pass_2 = inputdata.charCodeAt(i);// - 1);

            if (i > 1) {
                // 동일문자 카운트
                if ((chr_pass_0 == chr_pass_1) && (chr_pass_1 == chr_pass_2)) {
                    SamePass_0++;
                } else {
                    SamePass_0 = 0;
                }

                // 연속성(+) 카운드
                if (chr_pass_0 - chr_pass_1 == 1 && chr_pass_1 - chr_pass_2 == 1) {
                    SamePass_1++;
                } else {
                    SamePass_1 = 0;
                }

                // 연속성(-) 카운드
                if (chr_pass_0 - chr_pass_1 == -1 && chr_pass_1 - chr_pass_2 == -1) {
                    SamePass_2++;
                } else {
                    SamePass_2 = 0;
                }
            }

            if (SamePass_0 > 0) {
                t.msgFn(checkmsg2);
                //$('#'+fid).text("");
                $('#'+fid).val("");
                return false;
                
            }else {
                t.notLockFn();
            }

            if (SamePass_1 > 0 || SamePass_2 > 0) {
                t.msgFn(checkmsg3);
                //$('#'+fid).text("");
                $('#'+fid).val("");
                return false;
            }else {
                t.notLockFn();
            }
            /*if (!passed) {
                break;
            }*/
        }
        /*if (pw_passed) {
            pw_msg = "<span class='color:blue;'>* 사용할 수 있는 비밀번호입니다.</span>";
            $("#pw_cert_view").html(pw_msg);
        }*/
        
    })
}


/*
 * 
 * <Caps Lock> Check Function
 * 
 * 
 * ========================[example code]===========================
 * 
 * capsLockCheck('id');
 * 
 * =============================================================
 * 
 */
var capsLockCheck = function(fid){
    var t = this;
    
    this.msgFn = function(msg){
        $('#'+fid).blur();
        layerAlert(msg)
    };
    this.notLockFn = function(){
        //default do nothing. but you can do something!
    };
    
    $('#'+fid).keypress(function(event){
        var checkmsg4 = $('#validationCheckMsg4').val();
        if(capsLock(event)) {
            //if($('.layerArea').size() < 1) t.msgFn(checkmsg4);
            //return false;
        }else{
            t.notLockFn();
        }
    });
}


var capsLock = function(e){
     var keyCode = 0;
      var shiftKey=false;
      keyCode=e.which;
      shiftKey=e.shiftKey;
      //alert(shiftKey + "=======" + keyCode + "===============" + ((keyCode >= 65 && keyCode <= 90)&& !shiftKey)||((keyCode >= 97 && keyCode <= 122)&& shiftKey));
      if (((keyCode >= 65 && keyCode <= 90)&& !shiftKey)||((keyCode >= 97 && keyCode <= 122)&& shiftKey))
      {
          return true;
      }else{
          return false;
      }
}



/*
 * 
 * 쿠키 가져오기 (리턴값)
 * 
 * 
 * 
 */
var getCookie = function ( cookieName )
{
     var search = cookieName + "=";
     var cookie = document.cookie;

     // 현재 쿠키가 존재할 경우
     if( cookie.length > 0 )
     {
      // 해당 쿠키명이 존재하는지 검색한 후 존재하면 위치를 리턴.
      startIndex = cookie.indexOf( cookieName );

      // 만약 존재한다면
      if( startIndex != -1 )
      {
       // 값을 얻어내기 위해 시작 인덱스 조절
       startIndex += cookieName.length;

       // 값을 얻어내기 위해 종료 인덱스 추출
       endIndex = cookie.indexOf( ";", startIndex );

       // 만약 종료 인덱스를 못찾게 되면 쿠키 전체길이로 설정
       if( endIndex == -1) endIndex = cookie.length;

       // 쿠키값을 추출하여 리턴
       return unescape( cookie.substring( startIndex + 1, endIndex ) );
      }
      else
      {
       // 쿠키 내에 해당 쿠키가 존재하지 않을 경우
       return false;
      }
     }
     else
     {
      // 쿠키 자체가 없을 경우
      return false;
     }
}



/*
 * 쿠키 가져오고 삭제하기
 * 
 * */
var getCookieAndDelete = function ( cookieName )
{
     var search = cookieName + "=";
     var cookie = document.cookie;

     if( cookie.length > 0 )
     {
      startIndex = cookie.indexOf( cookieName );

      if( startIndex != -1 )
      {
       startIndex += cookieName.length;

       endIndex = cookie.indexOf( ";", startIndex );

       if( endIndex == -1) endIndex = cookie.length;

       
       var cookieValue = unescape( cookie.substring( startIndex + 1, endIndex ) ); 
       setCookie(cookieName, '');      
       var expireDate = new Date();
       expireDate.setDate( expireDate.getDate() - 1 );
       document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString() + "; path=/";
       
       return cookieValue;
      }
     }
}



var getMarginTop = function(layerHeight){
    
    var winHeight = window.innerHeight || $(window).innerHeight();// $(window).height();
    var marginTop = (winHeight-layerHeight)/2;
    return marginTop+$(window).scrollTop();
}
var getMarginTop2 = function(layerHeight,scrollTopCurrent){
    var stc = '';
    if(typeof scrollTopCurrent === 'undefiend'){
        stc = $(window).scrollTop();
    } else {
        stc = scrollTopCurrent;
    }
    var winHeight = $(window).height();
    var pTop = (winHeight-layerHeight)/2;
    
    $(window).scrollTop(stc);
    
    return pTop+stc;
}
var getMarginTop3 = function(obj){
    var lp=($(window).width()-obj.outerWidth())/2;
    var tp=($(window).height()-obj.outerHeight())/2+$(window).scrollTop();
    var marginTop4  = obj.outerHeight()/2;
    if(lp < 0) lp=0;
    if(tp < 0){
        tp=0;
        obj.css("top", tp).css({"position":"absolute",'margin-top':0});
    }else if(tp >= 0){
        obj.css("top", '50%').css({"position":"fixed",'margin-top':-marginTop4});
    }
    obj.find('.list_search1906').scrollTop(0);

}





/**
 * 
 * 우편번호 찾기 레이어팝업 기능
 *
 * *********************************[example Code]*************************************
 * 
 *  searchAddrLayer('address1', 'address2', 'zipCode');
 *              주소1필드아이디, 주소2필드아이디, 우편번호필드아이디           
 * 
 * *************************************************************************************
 * 
 * */

var searchAddrLayer = function(addr1, addr2, zipcode){
    
    var t = this;
    
    var addressLayerTag = '<div class="popwrap w_type_3"  style="z-index:150">                                                                             ' ;
        addressLayerTag += '    <!--title-->                                                                                          ' ;
        addressLayerTag += '    <div class="pop_tltwrap">                                                                             ' ;
        addressLayerTag += '        <h3>우편번호 조회</h3>                                                                            ' ;
        addressLayerTag += '    </div>                                                                                                ' ;
        addressLayerTag += '    <!--//title-->                                                                                        ' ;
        addressLayerTag += '    <!--contents-->                                                                                       ' ;
        addressLayerTag += '    <div class="pop_cnt zipcode">                                                                         ' ;
        addressLayerTag += '        <form id="addrSearchForm">                                                                          ';
        addressLayerTag += '            <div class="search lotBox" >                                                                      ';
        addressLayerTag += '                <label for="lotSearch">지역명 (동/읍/면/리)</label>                                              ';
        addressLayerTag += '                <input type="text" name="dong" id="lotSearch" placeholder="예) 역삼동, 내수읍, 초정리" style="width:260px" title="지역명">  ';
        addressLayerTag += '                <input type="button" value="검색" class="btn wt_s mr0 min_auto" id="lotSearchBtn">             ';
        addressLayerTag += '            </div>                                                                                            ';
        addressLayerTag += '            <div class="search street_adr roadBox">                                                            ';
        addressLayerTag += '                <div>                                                                                          ';
        addressLayerTag += '                    <label for="city">시/도</label>                                                           ';
        addressLayerTag += '                    <select id="city" name="city" title="시/도" >                                              ';
        addressLayerTag += '                        <option value="">선택</option> ';
        addressLayerTag += '                        <option value="강원도">강원도</option> ';
        addressLayerTag += '                        <option value="경기도">경기도</option> ';
        addressLayerTag += '                        <option value="경상남도">경상남도</option> ';
        addressLayerTag += '                        <option value="경상북도">경상북도</option> ';
        addressLayerTag += '                        <option value="광주광역시">광주광역시</option> ';
        addressLayerTag += '                        <option value="대구광역시">대구광역시</option> ';
        addressLayerTag += '                        <option value="대전광역시">대전광역시</option> ';
        addressLayerTag += '                        <option value="부산광역시">부산광역시</option> ';
        addressLayerTag += '                        <option value="서울특별시">서울특별시</option> ';
        addressLayerTag += '                        <option value="세종특별자치시">세종특별자치시</option> ';
        addressLayerTag += '                        <option value="울산광역시">울산광역시</option> ';
        addressLayerTag += '                        <option value="인천광역시">인천광역시</option> ';
        addressLayerTag += '                        <option value="전라남도">전라남도</option> ';
        addressLayerTag += '                        <option value="전라북도">전라북도</option> ';
        addressLayerTag += '                        <option value="제주특별자치도">제주특별자치도</option> ';
        addressLayerTag += '                        <option value="충청남도">충청남도</option> ';
        addressLayerTag += '                        <option value="충청북도">충청북도</option> ';
        addressLayerTag += '                    </select>                                                                                  ';
        addressLayerTag += '                    <label for="sigungu">시/군/구</label>                                                        ';
        addressLayerTag += '                    <select id="sigungu" name="sigungu" title="시/군/구" >                                     ';
        addressLayerTag += '                        <option value="">선택</option>                                                         ';
        addressLayerTag += '                    </select>                                                                                  ';
        addressLayerTag += '                </div>                                                                                         ';
        addressLayerTag += '                <div>                                                                                          ';
        addressLayerTag += '                    <label for="roadName">도로명 주소</label>                                                    ';
        addressLayerTag += '                    <input type="text" name="roadName" id="roadName" placeholder="예) 충정로, 신대방 13길" title="도로명 주소">   ';
        addressLayerTag += '                    <input type="button" value="검색" class="btn wt_s mr0 min_auto" id="roadSearchBtn">                           ';
        addressLayerTag += '                </div>                                                                                         ';
        addressLayerTag += '            </div>                                                                                             ';
        addressLayerTag += '        </form>                                                                                             ';
        addressLayerTag += '                                                                                                           ';
        addressLayerTag += '        <div class="tab_a m2">                                                                            ' ;
        addressLayerTag += '            <ul>                                                                                          ' ;
        addressLayerTag += '                <li><a href="javascript:void(0)" id="lotBox" >지번주소로 찾기</a></li>                      ';
        addressLayerTag += '                <li><a href="javascript:void(0)" id="roadBox" >도로명주소로 찾기</a></li>                   ';
        addressLayerTag += '            </ul>                                                                                         ' ;
        addressLayerTag += '        </div>                                                                                            ' ;
        addressLayerTag += '        <!-- 검색전 문구, 검색결과가 없을때 -->                                                           ' ;
        addressLayerTag += '        <p class="result_box no_data_txt" id="noDataBox">                                                 ' ;
        addressLayerTag += '            주소를 검색해주세요                                                                           ' ;
        addressLayerTag += '        </p>                                                                                              ' ;
        addressLayerTag += '        <!-- //검색전 문구, 검색결과가 없을때 -->                                                         ' ;
        addressLayerTag += '        <div class="result_box" id="dataBox">                                                     ' ;
        addressLayerTag += '            <div class="clearfix">                                                                        ' ;
        addressLayerTag += '                <p class="float_left">주소를 클릭 하시면 자동으로 주소가 선택 됩니다.</p>                 ' ;
        addressLayerTag += '                <p class="float_right" id="resultTotalNumber">검색 : 157건</p>                            ' ;
        addressLayerTag += '            </div>                                                                                        ' ;
        addressLayerTag += '            <div class="list">                                                                            ' ;
        addressLayerTag += '                <ul id="addrResultList">                                                                                      ' ;
        addressLayerTag += '                    <li>                                                                                  ' ;
        addressLayerTag += '                        <a href="#" class="clearfix">                                                     ' ;
        addressLayerTag += '                            <span class="float_left">서울 동작구 신대방1동</span>                         ' ;
        addressLayerTag += '                            <span class="float_right">12045</span>                                        ' ;
        addressLayerTag += '                        </a>                                                                              ' ;
        addressLayerTag += '                    </li>                                                                                 ' ;
        addressLayerTag += '                </ul>                                                                                     ' ;
        addressLayerTag += '            </div>                                                                                        ' ;
        addressLayerTag += '            <div class="detail_address">                                                                  ' ;
        addressLayerTag += '                <p>상세주소 입력</p>                                                                      ' ;
        addressLayerTag += '                <input type="text" id="areaAddr" value="" style="width:100%" title="주소" readOnly />            ' ;
        addressLayerTag += '                <input type="text" id="detailAddr" value="" style="width:100%" title="상세주소" />                           ' ;
        addressLayerTag += '                <input type="hidden" id="zc" value="" style="width:100%" title="주소" />                           ' ;
        addressLayerTag += '            </div>                                                                                        ' ;
        addressLayerTag += '            <div class="btnwrap">                                                                         ' ;
        addressLayerTag += '                <input type="button" class="btn gray_s mr0" value="확인" id="applyBtn">                    ' ;
        addressLayerTag += '            </div>                                                                                        ' ;
        addressLayerTag += '        </div>                                                                                            ' ;
        addressLayerTag += '                                                                                                          ' ;
        addressLayerTag += '    </div>                                                                                                ' ;
        addressLayerTag += '    <!--//contents-->                                                                                     ' ;
        addressLayerTag += '    <a href="javascript:void(0);" class="btn_close"><img src="/_ui/desktop/common/images/popup/ico_close.png" alt="닫기"></a>';
        addressLayerTag += '</div>';
        
    var $thisLayer = null;
        
    this.openNewLayer = function(){

        var layerTag = '<div class="layerArea">';
        layerTag +='<div class="layerBg"></div> ';
        layerTag +='</div>';

        $thisLayer = $(layerTag).appendTo($('body')).append(addressLayerTag);
        
        $thisLayer.find('.popwrap').css('marginTop', getMarginTop(699));

        //$('body').css("cssText", " overflow:hidden !important");
        var existedStyle = $('body').attr('style') || '';
        if (existedStyle) {
            existedStyle += ';';
        }
        $('body').attr('style', existedStyle + 'overflow:hidden !important');
        
        $thisLayer.find('.layerBg, .btn_close').click(function(){
            //$('body').css('overflow', '');
            $('body').attr('style', existedStyle);
            $thisLayer.remove();
        });
        
        
        $thisLayer.find('#lotBox, #roadBox').click(function(){
            
            var tid = $(this).attr('id');
            
            $thisLayer.find('.search').hide();
            $thisLayer.find('.'+tid).show();
            
            $('#dataBox').hide();
            $('#noDataBox').show();
            
            
            $thisLayer.find('#lotBox, #roadBox').removeClass('active');
            $(this).addClass('active');
            
        })
        
        $thisLayer.find('#lotBox').click();
        
        
        $thisLayer.find("#lotSearchBtn").click(function(){
            var vc = new ValidationCheck();
            vc.checkIdList = ['lotSearch'];
            if(vc.isValid()){
                getLotDatas();
            }
        });
        
        $("#lotSearch").keypress(function( event ) {
            if ( event.which == 13 ) {
                event.preventDefault();
                $thisLayer.find("#lotSearchBtn").click();
                $(this).blur();
            }
        });
        
        $thisLayer.find("#roadSearchBtn").click(function(){
            var vc = new ValidationCheck();
            vc.checkIdList = ['city', 'sigungu', 'roadName'];
            if(vc.isValid()){
                getRoadDatas();
            }
        });
        
        $("#roadName").keypress(function( event ) {
            if ( event.which == 13 ) {
                event.preventDefault();
                $thisLayer.find("#roadSearchBtn").click();
                $(this).blur();
            }
        });
        
        
        $thisLayer.find("#city").change(function(){
            
            $.ajax({
                type:"GET",
                url:"/common/getsigungu?city="+encodeURIComponent($thisLayer.find("#city").val()),
                cache: false,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success:function(response){

                    $thisLayer.find("#sigungu").html('<option value="">선택</option>');
                    
                    $.each(response, function(){
                        
                        $thisLayer.find("#sigungu").append('<option value="'+this+'">'+this+'</option>');
                        
                    });
                    
                },
                error:function(e){
                    alert(e);
                }
            });
        });
        
        
        
        $thisLayer.find("#applyBtn").click(function(){
            
            var vc = new ValidationCheck();
            vc.checkIdList = ['areaAddr', 'detailAddr', 'zc'];
            if(vc.isValid()){
                $('#'+addr1).val($thisLayer.find('#areaAddr').val());
                $('#'+addr2).val($thisLayer.find('#detailAddr').val());
                $('#'+zipcode).val($thisLayer.find('#zc').val());
                
                $('#'+addr1).change();
                $('#'+addr2).change();
                $('#'+zipcode).change();
                
                $('body').css('overflow', '');
                $thisLayer.remove();
            }
            
        });
        
    };
    
    
    var getLotDatas = function(){
        if(roadSearchProcessCheck){
            roadSearchProcessCheck = false;
            $.ajax({
                type:"GET",
                url:"/common/getlotaddrlist",
                data:$("#addrSearchForm").serialize(),
                async : false,
                success:function(response){
                    
                    $thisLayer.find('#resultTotalNumber').text('검색 : '+response.length+'건');
                    
                    var listTags = "";
                        
                    $.each(response, function(){
                        
                        var row = this.city + ' ' + this.siGunGu + ' ' + this.eupMyunDong;
                        
                        if(this.mountainYN=='1') row +=' 산';
                        
                        row += ' ' + this.startMainLotNumber;
                        var ssln =  '';
                        if(this.startSubLotNumber!='0'){ ssln = '-' + this.startSubLotNumber;}
                        row += ssln;
                        var eln = '';
                        if(this.endMainLotNumber!=null){
                            eln += ' ~ '+this.endMainLotNumber;
                            if(this.endSubLotNumber!='0'){
                                eln +='-'+this.endSubLotNumber;
                            }
                        }
                        
                        row +=eln;
                        
                        row = '<li class="addrListSelect"><a href="javascript:void(0);" class="clearfix"><span class="float_left">'+row+'</span><span class="float_right">'+this.zoneNumber+'</span></a></li>';
                        
                        listTags += row;
                    });
                        
                    
                    setListTag(listTags);
    
                    $('.zipcode .result_box .list li:nth-child(even)').css('background','#f8f8f8');
                    $('.delivery_comt li:nth-child(even)').css('background','#f8f8f8');
                    
                },
                error:function(e){
                    alert(e);
                }
            });
            
            setTimeout(function() {
                roadSearchProcessCheck = true;                
            }, 1000);
        }
    };
    
    var getRoadDatas = function(){
        if(roadSearchProcessCheck){
            roadSearchProcessCheck = false;
            $.ajax({
                type:"GET",
                url:"/common/getroadaddrlist",
                data:$("#addrSearchForm").serialize(),
                cache: false,
                async : false,
                success:function(response){
                    $thisLayer.find('#resultTotalNumber').text('검색 : '+response.length+'건');
                    var listTags = "";
                    
                        
                    $.each(response, function(){
                        
                        var row = this.city + ' ' + this.siGunGu;
                        
                        if(this.eupMyun!=null) row += ' ' + this.eupMyun;
                        
                        if(this.undergroundyn == '1') row += ' 지하';
                        
                        row += ' ' + this.roadName;
                        
                        row += ' ' + this.startBuildingOriginNo;
                        
                        if(this.startBuildingViceNo != '0') row+='-'+this.startBuildingViceNo;
                        
                        if(this.endBuildingOriginNo != null){
                            row += ' ~ '+this.endBuildingOriginNo
                            
                            if(this.endBuildingViceNo != '0') row +='-'+this.endBuildingViceNo;
                        }
                        
                        if(this.scopeKind=='1') row +='(홀수)';
                        else if(this.scopeKind=='2') row +='(짝수)';
                        
                        row = '<li class="addrListSelect"><a href="javascript:void(0);" class="clearfix"><span class="float_left">'+row+'</span><span class="float_right">'+this.zoneNumber+'</span></a></li>';
                        
                        listTags += row;
                        
                    });
                    
                    setListTag(listTags);
                    
    
                    $('.zipcode .result_box .list li:nth-child(even)').css('background','#f8f8f8');
                    $('.delivery_comt li:nth-child(even)').css('background','#f8f8f8');
                    
                },
                error:function(e){
                    alert(e);
                }
            });
            
            setTimeout(function() {
                roadSearchProcessCheck = true;                
            }, 1000);
        }
    };
    
    var setListTag = function(listTags){
        
        $thisLayer.find('#addrResultList').html('');
        $thisLayer.find('#addrResultList').append(listTags);
        
        $thisLayer.find('#noDataBox').hide();
        $thisLayer.find('#dataBox').show();
        
        $thisLayer.find('#areaAddr').val('');
        $thisLayer.find('#detailAddr').val('');
        
        $thisLayer.find('.addrListSelect').click(function(){
            
            $thisLayer.find('#areaAddr').val($(this).find('span.float_left').text());
            $thisLayer.find('#zc').val($(this).find('span.float_right').text());
            
        });
    };
    
    
    this.openNewLayer();
    
};



/**
 * 
 * 우편번호 찾기 레이어팝업 기능 NEW!!!!!
 *
 * *********************************[example Code]*************************************
 * 
 *  searchAddressLayer('address1', 'address2', 'zipCode');
 *              주소1필드아이디, 주소2필드아이디, 우편번호필드아이디           
 * 
 * *************************************************************************************
 * 
 * */

var searchAddressLayer = function(addr1, addr2, zipcode){
    
    var t = this;
    var confmKey  = $("#apiConfmKey").val();
    var addressLayerTag = '<div class="popwrap w_type_3 zipcodepop1904">                                       ' ;
        addressLayerTag += '    <div class="pop_tltwrap mb20">                                                                        ' ;
        addressLayerTag += '        <h3>우편번호 찾기</h3>                                                                            ' ;
        addressLayerTag += '    </div>                                                                                                ' ;
        addressLayerTag += '    <div class="pop_cnt zipcode">                                                                         ' ;
        addressLayerTag += '        <div class="search">                                                                  ' ;
        addressLayerTag += '            <form id="addrSearchForm">                                                                          ';
        addressLayerTag += '                <input type="text" name="roadName" id="roadName" placeholder="도로명 / 동명을 입력하세요." >                           ' ;
        addressLayerTag += '                <input type="hidden" name="pageNum" value="1">        ' ;
        addressLayerTag += '                <input type="hidden" name="pageSize" value="30">        ' ;
        addressLayerTag += '                <input type="hidden" name="show" value="">        ' ;
        addressLayerTag += '                <input type="hidden" name="sort" value="">        ' ;
        addressLayerTag += '                <input type="hidden" name="resultType" value="xml">        ' ;
        addressLayerTag += '                <input type="hidden" name="confmKey" value="'+confmKey+'">        ' ;
        addressLayerTag += '                <input type="button" value="검색" class="btn gray_s mr0 min_auto" id="searchBtn">        ' ;
        addressLayerTag += '            </form>                                                                                             ';
        addressLayerTag += '        </div>                                                                                            ';
        
        addressLayerTag += '                                                                                                           ';
        addressLayerTag += '        <!-- 검색전 문구, 검색결과가 없을때 -->                                                           ' ;
        addressLayerTag += '        <p class="schrl_total" id="noDataBox">검색 : 0건</p>                                                 ' ;
        addressLayerTag += '        <p class="result_box no_data_txt" id="noDataBoxText">검색된 주소가 없습니다.</p>                                              ' ;
        addressLayerTag += '        <!-- //검색전 문구, 검색결과가 없을때 -->                                                         ' ;
        addressLayerTag += '                                                                                                           ';
        
        addressLayerTag += '        <div class="result_box search1906" id="dataBox" style="display:none;">                                                     ' ;
        addressLayerTag += '            <div class="clearfix">                                                                        ' ;
        addressLayerTag += '                <p class="float_left">주소를 클릭 하시면 자동으로 주소가 선택 됩니다.</p>                 ' ;
        addressLayerTag += '                <p class="float_right" id="resultTotalNumber">검색 : 1664건</p>                            ' ;
        addressLayerTag += '            </div>                                                                                        ' ;
        addressLayerTag += '            <div class="list_search1906">                                                                            ' ;
        addressLayerTag += '                <ul id="addrResultList">                                                                                      ' ;
        addressLayerTag += '                    <li>                                                                                  ' ;
        addressLayerTag += '                        <a href="#;" class="clearfix">                                                     ' ;
        addressLayerTag += '                            <div class="zpcl_adrs_wrap">                         ' ;
        addressLayerTag += '                                <div class="zpcl_adrs_name">                         ' ;
        addressLayerTag += '                                    <div class="zpcl_tit">도로명</div>                         ' ;
        addressLayerTag += '                                    <div class="zpcl_con">경기도 광주시 삼지곡길22번길 6-7 삼성로얄맨션 (삼동, 삼성로얄맨션) (삼동, 삼성로얄맨션) (삼동, 삼성로얄맨션) (삼동, 삼성로얄맨션) (삼동, 삼성로얄맨션)</div>                         ' ;
        addressLayerTag += '                                </div>                         ' ;
        addressLayerTag += '                                <div class="zpcl_adrs_num">                         ' ;
        addressLayerTag += '                                    <div class="zpcl_tit">지번</div>                         ' ;
        addressLayerTag += '                                    <div class="zpcl_con">경기도 광주시 삼동 214 삼성로얄맨션</div>                         ' ;
        addressLayerTag += '                                </div>                         ' ;
        addressLayerTag += '                            </div>                         ' ;
        addressLayerTag += '                            <span class="zpcl_code">12045</span>                         ' ;
        addressLayerTag += '                        </a>                                                                              ' ;
        addressLayerTag += '                    </li>                                                                                 ' ;
        addressLayerTag += '                </ul>                                                                                     ' ;
        addressLayerTag += '            </div>                                                                                        ' ;
        
        addressLayerTag += '            <!-- paging -->                                                                                        ' ;
        addressLayerTag += '            <div class="paging mt30" id="zipcodePagingDiv"></div>                                                                            ' ;
        addressLayerTag += '            <!-- //paging -->                                                                                      ' ;
        
        addressLayerTag += '            <div class="detail_address">                                                                  ' ;
        addressLayerTag += '                <p>상세주소 입력</p>                                                                      ' ;
        addressLayerTag += '                <input type="text" id="areaAddr" title="주소" value="서울시 동작구 신대방1동 500-597" readOnly />            ' ;
        addressLayerTag += '                <input type="text" id="detailAddr" title="상세주소" value="나머지 주소를 입력해 주세요." />                           ' ;
        addressLayerTag += '                <input type="hidden" id="zc" value="" title="주소" />                           ' ;
        addressLayerTag += '            </div>                                                                                        ' ;
        addressLayerTag += '            <div class="btnwrap">                                                                         ' ;
        addressLayerTag += '                <input type="button" class="btn gray_s mr0" value="확인" id="applyBtn">                    ' ;
        addressLayerTag += '            </div>                                                                                        ' ;
        addressLayerTag += '        </div>                                                                                            ' ;
        addressLayerTag += '    </div>                                                                                                ' ;
        addressLayerTag += '    <a href="#;" class="btn_close"><img src="/_ui/desktop/common/images/popup/ico_close.png" alt="닫기"></a>';
        addressLayerTag += '</div>';
        
    var $thisLayer = null;
        
    this.openNewLayer = function(){

        var layerTag = '<div class="layerArea">';
        layerTag +='<div class="layerBg"></div> ';
        layerTag +='</div>';
        
        var scrollTopCurrent = $(window).scrollTop();
        $thisLayer = $(layerTag).appendTo($('body')).append(addressLayerTag);
        //$thisLayer.find('.popwrap').css('marginTop', getMarginTop2(830,scrollTopCurrent));
        getMarginTop3($thisLayer.find('.zipcodepop1904'));


        //$('body').css("cssText", " overflow:hidden !important");
        var existedStyle = $('body').attr('style') || '';
        if (existedStyle) {
            existedStyle += ';';
        }
        $('body').attr('style', '');
        
        $thisLayer.find('.layerBg, .btn_close').click(function(){
            //$('body').css('overflow', '');
            $('body').attr('style', existedStyle);
            $thisLayer.remove();
        });
        
        //TODO 디자인확정후 초기화면 처리 show()할지말지
        $('#dataBox').hide();
        $('#noDataBox').hide();
        $('#noDataBoxText').hide();
        
        
        $thisLayer.find("#searchBtn").click(function(){
            event.preventDefault();
            $thisLayer.find('#detailAddr').attr('placeholder', '');
            $("#addrSearchForm [name='pageNum']").val("1");
            // 도로명주소 안내시스템 switch
            if(confmKey != ""){ // 인증키존재할 시 API 호출
                getSearchDatasApi();
            }else{
                getSearchDatas();
            }
        });
        
        $("#roadName").keypress(function( event ) {
            if ( event.which == 13 ) {
                event.preventDefault();
                $thisLayer.find("#searchBtn").click();
                $(this).blur();
            }
        });
        
        $thisLayer.find("#applyBtn").click(function(){
            //퀵배송 호출할 경우에 대한 정리
            //마이페이지에서 호출할 경우, 결제페이지에서 호출할 경우, 주문/배송/반품/취소 페이지
            //마이페지이
            var checkQuick = false;
            $(".addrModBtn").each(function(idx){
                if($(this).attr("code") == $("#addrModPop_clone #code").val()){
                    if($(this).parents("tr").find(".quick_deliv").length > 0){
                        checkQuick = true;
                    }
                }
            });
            //결제페이지
            if($("#quickTime").length > 0){
                checkQuick = true;
            }
            
            
            if($("#athome_svc").length > 0 && zipcode == "postalcode"){
                var checkCode = $thisLayer.find('#zc').val().substring(0,3);

                //20.02.11 - 강동구 추가
                //18.03.26 - 영등포구, 동작구 추가 
                //17.12 - 용산/마포구 추가
                if("060,061,062,063,065,066,067,068,055,056,057,058,039,040,041,042,043,044,069,070,072,073,074,052,053,054".indexOf(checkCode) > -1){
                    if($(".athome_adr").length > 0){
                        //TODO 앳홈 주소지 변경시 split 기준 변경 해야 함
                        var tempAddr = $thisLayer.find('#areaAddr').val().split(" ");
                        if( $thisLayer.find('#areaAddr').val().length > 0 ){
                            $(".athome_adr").html(tempAddr[0]+" "+tempAddr[1]+" "+tempAddr[2]);
                        }
                    }
                    
                    var vc = new ValidationCheck();
                    vc.checkIdList = ['areaAddr', 'detailAddr', 'zc'];
                    if(vc.isValid()){
                        $('#'+addr1).val($thisLayer.find('#areaAddr').val());
                        $('#'+addr2).val($thisLayer.find('#detailAddr').val());
                        $('#'+zipcode).val($thisLayer.find('#zc').val());
                        
                        $('#'+addr1).change();
                        $('#'+addr2).change();
                        $('#'+zipcode).change();
                        
                        $('body').css('overflow', '');
                        $thisLayer.remove();
                    }
                }else{
                    layerHtml = '앳홈 서비스 불가능 지역 입니다.<br />(강남구/강동구/동작구/마포구<br />/서초구/영등포구/용산구에 한정)';//17.12 - 용산/마포구 추가
                    layerAlert(layerHtml);                  
                    
                }
            }else if(($("#quick_svc").length > 0 && zipcode == "quickPostalcode") || checkQuick){
                var checkCode = $thisLayer.find('#zc').val().substring(0,2);

                //서울지역 우편번호 앞자리 2자리
                if("01,02,03,04,05,06,07,08,09".indexOf(checkCode) > -1){
                    var tempAddr = $thisLayer.find('#areaAddr').val().split(" ");
                    if( $thisLayer.find('#areaAddr').val().length > 0 ){
                        $(".quick_adr").html(tempAddr[0]+" "+tempAddr[1]+" "+tempAddr[2]);
                    }
                    
                    var vc = new ValidationCheck();
                    vc.checkIdList = ['areaAddr', 'detailAddr', 'zc'];
                    if(vc.isValid()){
                        $('#'+addr1).val($thisLayer.find('#areaAddr').val());
                        $('#'+addr2).val($thisLayer.find('#detailAddr').val());
                        $('#'+zipcode).val($thisLayer.find('#zc').val());
                        
                        $('#'+addr1).change();
                        $('#'+addr2).change();
                        $('#'+zipcode).change();
                        
                        $('body').css('overflow', '');
                        $thisLayer.remove();
                    }
                }else{
                    layerHtml = '퀵배송 서비스 불가능  지역입니다.</br>배송지 변경 후 이용해 주세요.<br/>(서울 전 지역 가능, 향후 서비스 확대 예정입니다.)';
                    layerAlert(layerHtml);                  
                    
                }
            }else{
                var vc = new ValidationCheck();
                vc.checkIdList = ['areaAddr', 'detailAddr', 'zc'];
                if(vc.isValid()){
                    $('#'+addr1).val($thisLayer.find('#areaAddr').val());
                    $('#'+addr2).val($thisLayer.find('#detailAddr').val());
                    $('#'+zipcode).val($thisLayer.find('#zc').val());
                    
                    $('#'+addr1).change();
                    $('#'+addr2).change();
                    $('#'+zipcode).change();
                    
                    $('body').css('overflow', '');
                    $thisLayer.remove();
                }
            }
            <!-- 주문서 페이지 배송지 표시란에 기본배송지 표시 제거 20191022 남일희 -->
            $("#basis_bk_flag").removeClass("basis_bk_flag");
        });
        
    };
    
    var getSearchDatas = function(){
        if($("#roadName").val().length < 2){
            return;
        }
        
        if(roadSearchProcessCheck){
            roadSearchProcessCheck = false;
            $.ajax({
                type:"GET",
                url:"/common/searchzipcode",
                data:$("#addrSearchForm").serialize(),
                async : false,
                success:function(data){
                    var response = data.results;
                    var pagination = data.pagination;
                    $thisLayer.find('#resultTotalNumber').text('검색 : '+pagination.totalNumberOfResults+'건');
                    var listTags = "";
                    
                        
                    $.each(response, function(){
                        var row = '<li class="addrListSelect">'
                                 +'    <a href="#;" class="clearfix">'
                                 +'        <div class="zpcl_adrs_wrap">'
                                 +'            <div class="zpcl_adrs_name">'
                                 +'                <div class="zpcl_tit">도로명</div>'
                                 +'                <div class="zpcl_con addrIn">'+this.addrDisp+'</div>'
                                 +'            </div>'
                                 +'            <div class="zpcl_adrs_num">'
                                 +'                <div class="zpcl_tit">지번</div>'
                                 +'                <div class="zpcl_con">'+this.addrDispLot+'</div>'
                                 +'            </div>'
                                 +'        </div>'
                                 +'        <span class="zpcl_code">'+this.zipCd+'</span>'
                                 +'    </a>'
                                 +'</li>';
                        
                        listTags += row;
                        
                    });
                    $("#zipcode .list ul ").html(listTags);
                    
                    if(response == null || response.length < 1){
                        setListTag2(listTags);
                    }else{
                        var reviewpaging = new PageNavigationController("#zipcodePagingDiv", 30, 10);
                        reviewpaging.setPage(pagination.totalNumberOfResults, pagination.currentPage+1);
                        reviewpaging.dynamicAction = function(targetPageNum){
                            goZipcodePage(targetPageNum);
                        };
                        setListTag(listTags);
                    }
                    
                },
                error:function(e){
                    alert(e);
                }
            });
            
            setTimeout(function() {
                roadSearchProcessCheck = true;                
            }, 1000);
        }
    };
    
    var getSearchDatasApi = function(){
        if($("#roadName").val().length < 2){
            return;
        }
        
        if (!checkSearchedWord($("#roadName").val())) {
            return ;
        }
        
        if(roadSearchProcessCheck){
            roadSearchProcessCheck = false;
            var keyword = $("#addrSearchForm [name='roadName']").val();
            var currentPage = $("#addrSearchForm [name='pageNum']").val();
            var countPerPage = $("#addrSearchForm [name='pageSize']").val();
            var resultType = $("#addrSearchForm [name='resultType']").val();
            var confmKey = $("#addrSearchForm [name='confmKey']").val();
            var url = "https://www.juso.go.kr/addrlink/addrLinkApi.do?currentPage=" + currentPage + "&countPerPage="
            + countPerPage + "&keyword=" + encodeURI(keyword) + "&confmKey=" + confmKey + "&resultType="
            + resultType;
            $.ajax({
                type:"GET",
                url:url,
                //data:$("#addrSearchForm").serialize(),
                dataType:"xml",
                async : false,
                success:function(xmlStr){           // xmlStr : 주소 검색 결과 XML 데이터
                    /*if(navigator.appName.indexOf("Microsoft") > -1){        // IE 환경에서 JSONP의 returnXml 결과 데이터 처리
                        var xmlData= newActiveXObject("Microsoft.XMLDOM");
                        xmlData.loadXML(xmlStr.returnXml);
                    }else{                                                   // IE 이외 환경에서 처리
                        var xmlData= xmlStr.returnXml;
                    }*/
                    var xmlData= $(xmlStr).find("results");
                    //$(".zipcode_search_result_list").html("");                                  // 결과 출력 영역 초기화
                    var errCode= $(xmlData).find("errorCode").text();
                    var errDesc= $(xmlData).find("errorMessage").text();
                    if(errCode != "0"){ 
                        alert(errDesc);
                    }else{
                        if(xmlStr!= null){
                            makeList(xmlData);                              // 결과 XML 데이터 파싱 및 출력
                        }
                    }
                    /*var response = data.results;
                    var pagination = data.pagination;
                    
                    $thisLayer.find('#resultTotalNumber').text('검색 : '+pagination.totalNumberOfResults+'건');
                    var listTags = "";
                    
                        
                    $.each(response, function(){
                        //alert(this.addrDisp);
                        var row = '<li class="addrListSelect">'
                                 +'<a href="javascript:void(0);" class="clearfix">'
                                 +'<span class="float_left addrIn">도로명 : '+this.addrDisp+'</span>'
                                 +'<span class="float_right">'+this.zipCd+'</span><br/>'
                                 +'<span class="float_left">지번 : '+this.addrDispLot+'</span>'
                                 +'</a>'
                                 +'</li>';
                        
                        listTags += row;
                        
                    });
                    
                    $("#zipcode .list ul ").html(listTags);*/
                    
                },
                error:function(e){
                    alert(e.statusText);// NetworkError:IE 인증서 허용X 일 경우
                }
            });
            
            setTimeout(function() {
                roadSearchProcessCheck = true;                
            }, 1000);
        }
    };
    
    var setListTag = function(listTags){
        $thisLayer.find('#addrResultList').html('');
        $thisLayer.find('#addrResultList').append(listTags);
        
        $thisLayer.find('#noDataBox').hide();
        $thisLayer.find('#noDataBoxText').hide();
        $thisLayer.find('#dataBox').show();
        
        $thisLayer.find('#areaAddr').val('');
        $thisLayer.find('#detailAddr').val('');
        
        $thisLayer.find('.addrListSelect').click(function(){
            
            $thisLayer.find('#areaAddr').val($(this).find('div.addrIn').text());
            $thisLayer.find('#detailAddr').attr('placeholder', '나머지 주소를 입력해 주세요.');
            $thisLayer.find('#zc').val($(this).find('span.zpcl_code').text());
            
        });
        
        getMarginTop3($thisLayer.find('.zipcodepop1904'));
    };
    
    var setListTag2 = function(listTags){
        $thisLayer.find('#dataBox').hide();
        $thisLayer.find('#noDataBox').show();
        $thisLayer.find('#noDataBoxText').show();
        $thisLayer.find('#noDataBoxText').html('검색된 주소가 없습니다.');
        getMarginTop3($thisLayer.find('.zipcodepop1904'));
    }
    
    
    var goZipcodePage = function(targetPageNum) {
        $("#addrSearchForm [name='pageNum']").val(targetPageNum);
        $thisLayer.find('#detailAddr').attr('placeholder', '');
        // 도로명주소 안내시스템 switch
        if(confmKey != ""){ // 인증키존재할 시 API 호출
            getSearchDatasApi();
        }else{
            getSearchDatas();
        }
    }
    
    var makeList = function(xmlStr){
        //var pagination = data.pagination;
        $thisLayer.find('#resultTotalNumber').text('검색 : '+$(xmlStr).find("totalCount").text()+'건');
        var htmlStr = "";
        // jquery를 이용한 XML 결과 데이터 파싱
        $(xmlStr).find("juso").each(function(){
            htmlStr += '<li class="addrListSelect">';
            htmlStr += '    <a href="#;" class="clearfix">';
            htmlStr += '        <div class="zpcl_adrs_wrap">';
            htmlStr += '            <div class="zpcl_adrs_name">';
            htmlStr += '                <div class="zpcl_tit">도로명</div>';
            htmlStr += '                <div class="zpcl_con addrIn">'+$(this).find('roadAddr').text() +'</div>';
            htmlStr += '            </div>';
            htmlStr += '            <div class="zpcl_adrs_num">';
            htmlStr += '                <div class="zpcl_tit">지번</div>';
            htmlStr += '                <div class="zpcl_con">'+$(this).find('jibunAddr').text() +'</div>';
            htmlStr += '            </div>';
            htmlStr += '        </div>';
            htmlStr += '        <span class="zpcl_code">'+$(this).find('zipNo').text()+'</span>';
            htmlStr += '    </a>';
            htmlStr += '</li>';
            
        });
        // 결과 HTML을 FORM의 결과 출력 DIV에 삽입
        $("#zipcode .list ul ").html(htmlStr);
        
        if($(xmlStr).find("juso") == null || $(xmlStr).find("juso").length < 1){
            setListTag2(htmlStr);
        }else{
            var reviewpaging = new PageNavigationController("#zipcodePagingDiv", 30, 10);
            reviewpaging.setPage($(xmlStr).find("totalCount").text(), $(xmlStr).find("currentPage").text());
            
            reviewpaging.dynamicAction = function(targetPageNum){
                goZipcodePage(targetPageNum);
            };
            setListTag(htmlStr);
        }
        getMarginTop3($thisLayer.find('.zipcodepop1904'));
        
    }
    
    /*
            모의 해킹 테스트 시 검색API를 호출하시면 IP가 차단 될 수 있습니다. 
            주소검색API를 제외하시고 테스트 하시기 바랍니다.
    */
    /*
            도로명주소 API 호출시 검색어에 특수문자 또는 OR, INSERT, UNION 등 SQL예약어가 포함될 경우
            보안장비가 SQL INJECTION공격으로 간주하여 해당 IP를 차단시킬 수 있습니다.
            사용자분들은 API호출시 검색어 필터링를 적용하여 주시기 바랍니다.
    */
    var checkSearchedWord = function(obj){ //특수문자, 특정문자열(sql예약어의 앞뒤공백포함) 제거
        if(obj.length >0){
            //특수문자 제거
            var expText = /[%=><]/ ;
            if(expText.test(obj) == true){
                alert("특수문자를 입력 할 수 없습니다.") ;
                obj = obj.split(expText).join(""); 
                return false;
            }
            
            //특정문자열(sql예약어의 앞뒤공백포함) 제거
            var sqlArray = new Array(
                //sql 예약어
                "OR", "SELECT", "INSERT", "DELETE", "UPDATE", "CREATE", "DROP", "EXEC",
                         "UNION",  "FETCH", "DECLARE", "TRUNCATE" 
            );
            
            var regex;
            for(var i=0; i<sqlArray.length; i++){
                regex = new RegExp( sqlArray[i] ,"gi") ;
                
                if (regex.test(obj) ) {
                    alert("\"" + sqlArray[i]+"\"와(과) 같은 특정문자로 검색할 수 없습니다.");
                    obj =obj.replace(regex, "");
                    return false;
                }
            }
        }
        return true ;
    }
    
    this.openNewLayer();
    
};

///끝 

//레이어 포커스 변경 공통
$(document).on("DOMNodeInserted","body",function(e){
    $(".layerArea").each(function(){
        if($(this).attr("tabindex") != "-1"){
            if($(this).css("display") != "none"){
                if($(this).find("> div:last").attr("tabindex") != "-1"){
                    //예외처리
                    if($("#popwrap2").css("display") == "block" && $("#popwrap2 #pw").length > 0){
                        return false;
                    }else{
                        $(this).find("> div:last").attr("tabindex", -1).focus();
                    }
                }
            }
        }
    });
});


/**
 * 
 * 사용법
 *
 * var today = new Date().format("yyyy-MM-dd");
 * 
 * 
 * */
Date.prototype.format = function(f) {

    if (!this.valueOf()) return " ";

    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];

    var d = this;

    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {

        switch ($1) {

            case "yyyy": return d.getFullYear();

            case "yy": return (d.getFullYear() % 1000).zf(2);

            case "MM": return (d.getMonth() + 1).zf(2);

            case "dd": return d.getDate().zf(2);

            case "E": return weekName[d.getDay()];

            case "HH": return d.getHours().zf(2);

            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);

            case "mm": return d.getMinutes().zf(2);

            case "ss": return d.getSeconds().zf(2);

            case "a/p": return d.getHours() < 12 ? "오전" : "오후";

            default: return $1;
        }
    });
};

String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};





/**
 * email domain selectbox controller script
 * 이메일 도메인 셀렉트박스 컨트롤러 스크립트
 * 
 * *********************************[example Code]*************************************
 * 
 *  emailTypeDomainSelectController("#uidDomain","#uidDomainSel");
 *                                  [도메인셀렉터],[셀렉트박스셀렉터]
 * 
 * *************************************************************************************
 * 
 * 
 */
var emailTypeDomainSelectController = function(dmbox, selbox){
    
    $(selbox).change(function(){
        $(dmbox).val($(this).val());
        if($(this).val()==""){
            $(dmbox).show();
        }else{
            $(dmbox).hide();
        }
    }); 
};



var isNum = function(keyNum){
    if(keyNum && (keyNum  > 47 && keyNum  < 58 || keyNum  > 95 && keyNum  < 106 || keyNum == 8 || keyNum == 9 || keyNum == 37 || keyNum == 39 || keyNum == 46)){
        return true;
    }else{
        return false;
    }
};

/**
 * 콤마를 찍는다.
 */
var addComma = function(price){
    
    price = price + '';
    var num = price.split('.');
    
    if(num[0]==0) return price;
    
    var num1 = num[0];
    var reg = /(^[+-]?\d+)(\d{3})/;
    var num1 = (num1 + '');
 
    while (reg.test(num1)) num1 = num1.replace(reg, '$1' + ',' + '$2');
    if(num.length > 1){
        return num1+"."+num[1];
    }
    return num1;
};

function gf_nvl(s1,s2) {
	if(s1 == null || s1 == "undefined") {
		return s2;
	} else {
		return s1;
	}
}

function gf_isNil(s) {
	if(s == null || s == "undefined") {
		return true;
	} else {
		return false;
	}
}
//소수점 처리
function getDecimalToString(val, intIdx, decIdx, option) {
    var stringVal = String(val);
    var stringValSplit = stringVal.split('.');
    var intNumSpaceList = .0.toFixed(intIdx).split('.');
    var intNumSpace = gf_nvl(intNumSpaceList[1], "0");
    
    //소수계산
    if(!gf_isNil(stringValSplit[1]) && !gf_isNil(decIdx) && decIdx > 1){
        var decimalString = stringValSplit[1].substr(0,decIdx-1)+'.'+stringValSplit[1].substr(decIdx-1,stringValSplit[1].length);
        var calcResult = _optionCalc(decimalString, option);
        var intNum = stringValSplit[0];

        if(String(Math.floor(Number(decimalString))).length < String(calcResult).length){
            calcResult = calcResult.substr(1);
            intNum = String(Number(intNum)+1);
        }
        return _setAddZeroString(intNum, intNumSpace)+"."+calcResult;
    //정수처리
    } else {
    	var calcValue = _optionCalc(stringVal, option);
    	return _setAddZeroString(calcValue, intNumSpace);
    }

    //ceil:올림, floor: 내림, Default : 반올림
    function _optionCalc(_value, _calcOption){
    	var intValue = Number(_value);
    	switch(_calcOption) {
    		case "ceil" : return String(Math.ceil(intValue));
    		break;
    		case "floor" : return String(Math.floor(intValue));
    		break;
    		default : return String(Math.round(intValue));
    	}
	}

	//0추가(정수부분)
	function _setAddZeroString(_value, _spaceValue){
    	//정수부분 String
    	//if(_spaceValue.length > _value.length){
        //	_spaceValue = _spaceValue.substring(_value.length);
        //	return _spaceValue + _value;
    	//} else {
        	return _value;
    	//}
	}
}




/**
 * 
 * input박스 입력시 글자 수 체크하는 함수
 * 
 * 
 */

var chkInputCount = function($input, $count, maxlength){
    
    var update = function() {
        var before = $count.text() * 1;
        var now = $input.val().length;
        // 사용자가 입력한 값이 제한 값을 초과하는지를 검사한다.
        if (now > maxlength) {
            var str = $input.val();
            $input.val(str.substr(0, maxlength));
            now = maxlength;
        }
        // 필요한 경우 DOM을 수정한다.
        if (before != now) {
            $count.text(now);
        }
    };
    // input, keyup, paste 이벤트와 update 함수를 바인드한다
    $input.bind('input keyup paste', function() {
        setTimeout(update, 0)
    });
    update();

};








$(document).ready(function(){
    
    /**
     * 어떤 인풋박스든 태그 안에 numberOnly="true" 라는 속성을 추가하면 자동으로 숫자만 입력되도록 구현
     * 
     */
    $("[numberOnly=true]").keypress(function(event){
        if(!isNum(event.which) && (event.which!=0) || (event.which==37)) return false;
    }).keydown(function(event){
        if(!isNum(event.which)) return false;
    });
    
    
    
    if(getCookieAndDelete("PW_ALARM")=="1"){
        var lc = new layerConfirm('비밀번호를 변경한지 3개월이 지났습니다. 지금 비밀번호를 변경하시겠습니까? ', '비밀번호 변경하러가기', '닫기');
        lc.confirmAction = function(){
            //비밀번호 변경 알림 방어코딩
            setCookie("PW_ALARM","1",-1);
            //비밀번호 변경 페이지로 이동
            //location.href="";
            location.href="/handsome/member/pwChange";
        };
    };
    
    //현대닷컴에서 유입이 될경우 레이어 팝업
    var cName = 'thehyundai' + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cName);
    var cValue = '';
    if(start != -1){
        start += cName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cValue = cookieData.substring(start, end);
    }
    
    if(cValue == "true"){
        var layerName = 'thehyundaiLayer' + '=';
        var layerCookieData = document.cookie;
        var layerStart = layerCookieData.indexOf(layerName);
        var layerValue = '';
        
        if(layerStart != -1){
            layerStart += layerName.length;
            var layerEnd = cookieData.indexOf(';', layerStart);
            if(layerEnd == -1)layerEnd = layerCookieData.length;
            layerValue = layerCookieData.substring(layerStart, layerEnd);
        }
        
        if(layerValue != "true"){
            var layerHtml = '';
            layerHtml += '      <h3 class="pop_tlt">본 서비스는 더한섬닷컴의<br />책임하에 운영되고 있습니다.</h3>';
            layerHtml += '      <p class="pop_txt">더한섬닷컴을 이용하시려면<br />더한섬닷컴의 <strong class="ft_point01">회원가입</strong> 및 <strong class="ft_point01">로그인</strong>이 필요합니다.<br/>신규 가입 시, <strong class="ft_point01">5% 할인쿠폰</strong>을 증정합니다.</p>';

            var la = new layerAlert(layerHtml);
            
            //공통사용으로 인한 중복된 타이틀 제거
            $(".pop_cnt h3:eq(0)").hide();
            
            //첫번째 유입일 경우만 화면에 노출
            var d = new Date();
            d.setTime(d.getTime() + (24*60*60*1000));
            document.cookie = 'thehyundaiLayer=true; expires=' + d.toUTCString();
        }else{
            $(".pop_cnt h3:eq(0)").show();
        }
    }else{
        //$(".pop_cnt h3:eq(0)").show();
    }
    
    //hmall에서 유입이 될경우 레이어 팝업
    var hcName = 'hyundaihmall' + '=';
    var hcookieData = document.cookie;
    var hstart = cookieData.indexOf(hcName);
    var hcValue = '';
    if(hstart != -1){
        hstart += hcName.length;
        var hend = hcookieData.indexOf(';', hstart);
        if(hend == -1)hend = hcookieData.length;
        hcValue = hcookieData.substring(hstart, hend);
    }
    
    if(hcValue == "true"){
        var hlayerName = 'hyundaihmallLayer' + '=';
        var hlayerCookieData = document.cookie;
        var hlayerStart = hlayerCookieData.indexOf(hlayerName);
        var hlayerValue = '';
        
        if(hlayerStart != -1){
            hlayerStart += hlayerName.length;
            var hlayerEnd = hcookieData.indexOf(';', hlayerStart);
            if(hlayerEnd == -1)hlayerEnd = hlayerCookieData.length;
            hlayerValue = hlayerCookieData.substring(hlayerStart, hlayerEnd);
        }
        
        if(hlayerValue != "true"){
            var hlayerHtml = '';
            hlayerHtml += '     <h3 class="pop_tlt">본 서비스는 더한섬닷컴의<br />책임하에 운영되고 있습니다.</h3>';
            hlayerHtml += '     <p class="pop_txt">더한섬닷컴을 이용하시려면<br />더한섬닷컴의 <strong class="ft_point01">회원가입</strong> 및 <strong class="ft_point01">로그인</strong>이 필요합니다.<br/>신규 가입 시, <strong class="ft_point01">5% 할인쿠폰</strong>을 증정합니다.</p>';

            var hla = new layerAlert(hlayerHtml);
            
            //공통사용으로 인한 중복된 타이틀 제거
            $(".pop_cnt h3:eq(0)").hide();
            
            //첫번째 유입일 경우만 화면에 노출
            var d = new Date();
            d.setTime(d.getTime() + (24*60*60*1000));
            document.cookie = 'hyundaihmallLayer=true; expires=' + d.toUTCString();
        }else{
            $(".pop_cnt h3:eq(0)").show();
        }
    }else{
        //$(".pop_cnt h3:eq(0)").show();
    }
});

/**
 * ex) wordLengthReplace('가나다라마', 3, '*')
 * return 가나다*
 */
var wordLengthReplace = function(word, lenth, reqlace){
    
    if(word == null || word == ''){
        return word;
    }
    if(word.length > parseInt(lenth)){
        return word.substring(0, parseInt(lenth)) +'' + reqlace;
    }
    return word;
};


/**
 * passwordControll
 * 패스워드관련 동작들 (compare:비교, save:저장)
 * 
 * *********************************[example Code]*************************************
 * 
 *  var pwc = new passwordControll("compare", inputPw, prk);
 *                              division : "compare"(입력PW와 저장되어있는PW 비교), "save" (바뀐 패스워드를 저장)
 *      pwc.trueAction = function()
 *      {   
 *          //동작 성공시 실행할 로직들 추가
 *          alert("패스워드가 확인되었습니다.  또는    패스워드를 저장하였습니다.");
 *      };
 *      pwc.falseAction = function()
 *      {   
 *          //동작 실패시 실행할 로직들 추가
 *          alert("패스워드를 확인하여 주십시오.  또는  패스워드 저장에 실패하였습니다.");
 *      };
 *  
 * 
 * *************************************************************************************
 * 
 * 
 */
var passwordControll = function(division, inputPW, prk){
    
    var t = this;

    this.trueAction = function(){
    };
    
    this.falseAction = function(){
    };
    
    var target_url  = document.location.href;
    var actionUrl = "";
    if(target_url.indexOf("ko/") > -1){
        actionUrl = "/ko/common/passwordControll";
    }else if(target_url.indexOf("en/") > -1){
        actionUrl = "/en/common/passwordControll";
    }else if(target_url.indexOf("zh/") > -1){
        actionUrl = "/zh/common/passwordControll";
    }else{
        actionUrl = "/common/passwordControll";
    }
    
    $.ajax({
        type:"GET",
        url: actionUrl,
        datatype:"json",
        data:{"division":division, "inputPW":inputPW, "prk":prk},
        success:function(response){
            if(response==true){
                t.trueAction();
            }else{
                t.falseAction();
            }
        },
        error:function(e){
            alert(e);
        }
    });
    
};


/**
 * passwordEncoding
 * 패스워드 암호화 (Hybris체계 암호화)
 * 
 * *********************************[example Code]*************************************
 * 
 *  encodePW = passwordEncoding(inputPW, userID);
 *  암호화된PW               암호화할PW, 유저ID           
 * 
 * *************************************************************************************
 * 
 * 
 */
var passwordEncoding = function(inputPW, userID){
    $.ajax({
        type:"GET",
        url:"/common/passwordEncoding",
        datatype:"json",
        data:{"inputPW":inputPW, "userID":userID},
        success:function(response){
            return response;
        },
        error:function(e){
            alert(e);
        }
    });
    
};


/************************Footer News Start*********************/
function getNewsList(moveUrl){

    to_date = new Date();
    $.ajax({
        type: "get",
        url :  moveUrl+"/newslist?now=" + to_date.getTime(),
        dataType : "json",
        error : function( request, status, error ){     
//          t.PARAMS.jsonObjectData = 0;
            console.log(error);
        }, 
        success : function(data){
            var newsContent = "";
            var viewCnt = 0;
            $.each(data.results, function(){
                if(viewCnt < 4){
                    var listTag = "<li>";
                    listTag += '<a href="' + moveUrl + '/newsDetail' + this.templateType + '?newsCode=' + this.newsCode + '&typeCode=WEB" onclick="GA_Common(\'news\',$(this))">' + this.newsTitle + '</a>';
                    listTag += "</li>";
                    
                    newsContent += listTag;
                    viewCnt++;
                }
            });
            
            $('#newsWrap .list_new').html(newsContent);
            fn_article('newsWrap','controls', data.results.length);
        }
    });
}

function fn_article(containerID, buttonID, count){
    var $element = $('#'+containerID).find('.list_new');
    var $prev = $('.'+buttonID).find('#newsPrev');
    var $next = $('.'+buttonID).find('#newsNext');
    var speed = 3000;
    var timer = null;

    var move = $element.children().outerHeight();
    var first = false;
    var lastChild;
    
    lastChild = $element.children().eq(-1).clone(true);
    lastChild.prependTo($element);
    $element.children().eq(-1).remove();
    
    if(count==1){
        $element.css('top','0px');
    }else{
        $element.css('top','-'+move+'px');
        timer = setInterval(moveNextSlide, speed);
    }


    $element.find('>li').bind({
        'mouseenter': function(){
            clearInterval(timer);
        },
        'mouseleave': function(){
            if(count!=1){
                timer = setInterval(moveNextSlide, speed);
            }
        }
    });

    $prev.bind({
        'click': function(){
            if(count!=1){
                movePrevSlide();
                return false;
            }
        },
        'mouseenter': function(){
            clearInterval(timer);
        },
        'mouseleave': function(){
            if(count!=1){
                timer = setInterval(moveNextSlide, speed);
            }
        }
    });

    $next.bind({
        'click': function(){
            if(count!=1){
                moveNextSlide();
                return false;
            }
        },
        'mouseenter': function(){
            clearInterval(timer);
        },
        'mouseleave': function(){
            if(count!=1){
                timer = setInterval(moveNextSlide, speed);
            }
        }
    });

    function movePrevSlide(){
        $element.each(function(idx){
            if(!first){
                $element.eq(idx).animate({'top': '0px'},'normal',function(){
                    lastChild = $(this).children().eq(-1).clone(true);
                    lastChild.prependTo($element.eq(idx));
                    $(this).children().eq(-1).remove();
                    $(this).css('top','-'+move+'px');
                });
                first = true;
                return false;
            }

            $element.eq(idx).animate({'top': '0px'},'normal',function(){
                lastChild = $(this).children().filter(':last-child').clone(true);
                lastChild.prependTo($element.eq(idx));
                $(this).children().filter(':last-child').remove();
                $(this).css('top','-'+move+'px');
            });
        });
    }

    function moveNextSlide(){
        $element.each(function(idx){
            var firstChild = $element.children().filter(':first-child').clone(true);
            firstChild.appendTo($element.eq(idx));
            $element.children().filter(':first-child').remove();
            $element.css('top','0px');

            $element.eq(idx).animate({'top':'-'+move+'px'},'normal');
        });
    }
}
/**********************Footer News End****************************/


/************************Footer Notice Start*********************/
function getFooterNotices(moveUrl){
    to_date = new Date();
    $.ajax({
        type: "get",
        url :  moveUrl+"/getFooterNotices?now=" + to_date.getTime(),
        dataType : "json",
        error : function( request, status, error ){     
            console.log(error);
        }, 
        success : function(data){
            var noticeContent = "";
            //var viewCnt = 0;
            $.each(data, function(){
                //if(viewCnt < 4){
                    var listTag = "<li>";
                    listTag += '<a href="' + moveUrl + '/notice?noticeCode=' + this.pk + '">' + this.subject + '</a>';
                    listTag += "</li>";
                    
                    noticeContent += listTag;
                    //viewCnt++;
                //}
            });
            
            $('#noticeWrap .list_new').html(noticeContent);
            fn_article('noticeWrap','controls', data.length);
        }
    });
}
/**********************Footer Notice End****************************/

/**
 * 2017-03-08, 이현승, 전화번호 문자포함여부 검증.
 * 검증성공: SUCCESS
 * 검증실패: 해당태그ID
 */
function phoneNumbericCheck(){
    var result = "SUCCESS";
    var inputNumberchk = /^[0-9]+$/;
    
    $("input:text[numberonly]").each(function(index){
        if(this.value.length > 0 && result == "SUCCESS") {
            var numVal  = this.value;
            var flag    = true;
            
            for(i=0; i<numVal.length; i++){
                var str = numVal.substr(i,1);
                if (!inputNumberchk.test(str)){
                    flag = false;
                    break;
                }
            }
            if(!flag){
                result = this.id;
            }
        }
    });
    return result;
}
    
function rakutenCall(){
    (function (url) {
        /*Tracking Bootstrap Set Up DataLayer objects/properties here*/
        if(!window.DataLayer){
            window.DataLayer = {};
        }
        if(!DataLayer.events){
            DataLayer.events = {};
        }
        DataLayer.events.SiteSection = "1";
                    
        var loc, ct = document.createElement("script"); 
        ct.type = "text/javascript"; 
        ct.async = true;
        ct.src = url;
        loc = document.getElementsByTagName('script')[0];
        loc.parentNode.insertBefore(ct, loc);
    }(document.location.protocol + "//intljs.rmtag.com/113658.ct.js"));
}


// 팝업 해상도별 센터에 띄우기
function centerPopup(url, name, width, height) {
 
    var sw  = screen.availWidth ;
    var sh  = screen.availHeight ;

    px=(sw - width)/2 ;
    py=(sh - height)/2 ;

    var set  = 'top=' + py + ',left=' + px ;
    set += ',width=' + width + ',height=' + height + ',toolbar=0,resizable=1,status=0,scrollbars=0' ;

    window.open (url , name , set) ;
}

//한글바이트계산(utf-8 한글 3byte식 계산)
function getByteLength(s,b,i,c){
    for (b = i = 0; c = s.charCodeAt(i++); b += c >> 11 ? 3 : c >> 7 ? 2 : 1);
    return b;
}

/*
 * str : 문자
 * byteLength : 자를 문자 수
 * sizePerLetter : 한글일 경우 byte수
 */
function subStringBytes(str, byteLength, sizePerLetter) {
        
    var limit = byteLength;
    var strLength = 0;
    var strTitle = "";
    var strPiece = "";
             
    for (i = 0; i < str.length; i++){
        var code = str.charCodeAt(i);
        var ch = str.substr(i,1).toUpperCase();
        //체크 하는 문자를 저장
        strPiece = str.substr(i,1)
         
        code = parseInt(code);
         
        if ((ch < "0" || ch > "9") && (ch < "A" || ch > "Z") && ((code > 255) || (code < 0))){
            strLength = strLength + sizePerLetter; //UTF-8 3byte 로 계산
        }else{
            strLength = strLength + 1;
        }
         
        if(strLength>limit){ //제한 길이 확인
            break;
        }else{
            strTitle = strTitle+strPiece; //제한길이 보다 작으면 자른 문자를 붙여준다.
        }
         
    }
     
    return strTitle;
}
function convertNumberToMonth(number) {//숫자를 영문 달로 변환
    var months = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ];
    var number = Number(number)-1;
    var enMonth = months[number];
    return enMonth;
}

/*
 * 이름 마스킹 처리
 */
function maskingName(str){
    var returnValue = "";
    str = $.trim(str);
    if(str.length > 1){
        returnValue = str.substring(0,1);
        returnValue += "*";
        if(str.length > 2){
            returnValue += str.substring(2);
        }
        return returnValue;
    }else{
        return str;
    }
}


/*
 * 아이디 마스킹 처리
 */
function maskingId(str){
    var maskingStr = "";
    if(str.length > 1){
        maskingStr = str.substring(0,3);
        
        var len = str.length - 3;
        if(len > 0){
            for(var i=0; i<len; i++){
                maskingStr += "*";    
            }
        }
    }
    return maskingStr;
}

/*
 * 주소 마스킹 처리
 */
function maskingAddress(str,isAll){
    var maskingStr = "";
    
    if(str.length > 0){
        //주소 전체 길이만큼 마스킹 처리
        if(isAll){
            for(var i=0; i<str.length; i++){
                maskingStr += "*";
            }
        }else{
            var splitStr = str.split(" ");
            if(splitStr.length > 3){
                maskingStr = splitStr[0]+" "+splitStr[1]+" "+splitStr[2];                                 
                
                for(var i=3; i<splitStr.length; i++){
                    var temp = "";
                    try{
                        for(var k=0; k<splitStr[i].length; k++){
                            temp += "*";
                        }
                        
                        maskingStr += (" "+temp);
                    }catch(e){
                        //
                    }
                }    
            }else{
                maskingStr = str;
            }
            
        }
    }
    return maskingStr;
}

/*
 * 문자 마스킹 처리
 */
function maskingStr(str) {
    var maskingStr = "";
    
    for(var i=0; i<str.length; i++){
        maskingStr += "*";
    }
     
    return maskingStr;
}

function noLink() {}
