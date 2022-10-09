var _domainPath = "";
var _host = "";

//SSO 함수 호출 전 초기화 처리
function gfnSsoInit() { 
    
    var getRequestURL = location.href ;
    _host = location.host;  
    _domainPath = getRequestURL.substring(0, getRequestURL.indexOf(_host))+_host ;  
}

//토큰 발급 요청 : mcustNo(통합고객번호), ssoAuthCd(권한코드)
function gfnReqSSoToknIssuAjax(mcustNo, ssoAuthCd, ssoUrl, callback)
{   
    gfnSsoInit();
    $.support.cors = true;
    var httpUrl = ssoUrl + "/co/setSsoToknIssuJSONP.hd"; 
    
    $.ajax({
            url: httpUrl, 
            type: "GET",
            data: {"mcustNo":mcustNo, "ssoAuthCd":ssoAuthCd , "domainPath":_domainPath, "dmnAdr":_host, "callback":callback.name},
            dataType: "jsonp",
            contenType: "application/json",
            jsonp: callback.name,
            xhrFields: {
                withCredentials : true
            }, 
            success : function (data) {
                if(callback && typeof callback == "function"){
                    callback(data);
                }
            },
            error : function (data) {
            }
      });
}

//SSO 요청후 sso 인증 성공시 고객번호 리턴
function gfnSsoReqAjax(httpUrl, callback)
{
    gfnSsoInit();
    $.support.cors = true;
    var ssoUrl = ""+httpUrl;
    
    //console.log("_domainPath:"+_domainPath);
    //console.log("_host:"+_host);
    
    $.ajax({
        url: ssoUrl, 
        type: "GET",
        contenType: "application/json",
        data: {"domainPath":_domainPath, "dmnAdr":_host, "callback":callback.name},
        dataType : "jsonp",
        jsonp: callback.name,
        xhrFields: {
            withCredentials : true
        }, 
        success : function (data) {
            if(callback && typeof callback == "function"){
                callback(data);
            }
            
        },
        error : function (data) {
        }
    });
}

//SSO 만료처리
function gfnSsoDscdToknReqAjax(httpUrl, callback)
{
    gfnSsoInit();
    $.support.cors = true;
    var ssoUrl = ""+httpUrl;
    
    var dmnAdr = _host;
    dmnAdr = dmnAdr.replace("8001", "8002"); 
    var domainPath = "https://"+ dmnAdr

     $.ajax({
        url: ssoUrl, 
        type: "GET",
        contenType: "application/json",
        data: {"domainPath": domainPath, "dmnAdr":dmnAdr, "callback":callback.name},
        dataType: "jsonp",
        jsonp: callback.name,
        xhrFields: {
            withCredentials : true
        }, 
        success : function (data) {
            if(typeof callback == "function"){
                callback(data);
            }
        },
        error : function (data) {
        }
    });
}