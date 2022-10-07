function Nethru_getCookieVal(offset)
{
	var endstr = document.cookie.indexOf (";", offset);
	if (endstr == -1)
		endstr = document.cookie.length;
	return unescape(document.cookie.substring(offset, endstr));
}

function Nethru_SetCookie(name, value){
   var argv = Nethru_SetCookie.arguments;
   var argc = Nethru_SetCookie.arguments.length;
   var expires = (2 < argc) ? argv[2] : null;
   var path = (3 < argc) ? argv[3] : null;
   var domain = (4 < argc) ? argv[4] : null;
   var secure = (5 < argc) ? argv[5] : false;

   document.cookie = name + "=" + escape (value) +
        ((expires == null) ? "" : ("; expires="+expires.toGMTString())) +
     ((path == null) ? "" : ("; path=" + path)) +
     ((domain == null) ? "" : ("; domain=" + domain)) +
        ((secure == true) ? "; secure" : "");

}

function Nethru_GetCookie(name){
   var arg = name + "=";
   var alen = arg.length;
   var clen = document.cookie.length;
   var i = 0;
   while (i < clen)
      {
      var j = i + alen;
      if (document.cookie.substring(i, j) == arg)
         return Nethru_getCookieVal (j);
      i = document.cookie.indexOf(" ", i) + 1;
      if (i == 0)
         break;
      }
  return null;
}

function Nethru_makePersistentCookie(name,length,path,domain)
{
    var today = new Date();
    var expiredDate = new Date(2100,1,1);
    var cookie;
	var value;

    cookie = Nethru_GetCookie(name);
    if ( cookie ) {
        return 1;
	}

	var values = new Array();
	for ( i=0; i < length ; i++ ) {
		values[i] = "" + Math.random();
	}

	value = today.getTime();
	for ( i=0; i < length ; i++ ) {
		value += values[i].charAt(2);
	}

    Nethru_SetCookie(name,value,expiredDate,path,domain);
}


function Nethru_makePersistentCookie1(name,length,path,domain)
{
	if ( domain == null ) return 1;						
        	var expiredDate = new Date(2100,1,1);

	
        	var vn_screenx = screen.width; 					
                var vn_screeny = screen.height; 					
	var vn_screenc = screen.colorDepth; 					
		
	var resolution_cookiename = name + "_RESOLUTION";			
	var color_cookiename = name + "_COLOR";				
	
	var resolution_value = screen.width + "*" + vn_screeny;
	var color_value = vn_screenc;
	
	var resolution_cookie;
	var color_cookie;

        	resolution_cookie = Nethru_GetCookie(resolution_cookiename);
        	color_cookie = Nethru_GetCookie(color_cookiename)

	
        if ( resolution_cookie ) {						
        		
        	if ( resolution_cookie != resolution_value ) {			
        		Nethru_SetCookie(resolution_cookiename,resolution_value,expiredDate,path,domain);  	
			
		}
	}
	else
	{	
        		Nethru_SetCookie(resolution_cookiename,resolution_value,expiredDate,path,domain);
        		
	}
	
        	if ( color_cookie ) {							
        		if ( color_cookie != color_value ) {			
        		Nethru_SetCookie(color_cookiename,color_value,expiredDate,path,domain);  	
			
			
		}
	}
	else
	{								
        		Nethru_SetCookie(color_cookiename,color_value,expiredDate,path,domain);
        		
	}

}

function Nethru_getDomain() {
	var _host   = document.domain;
	var so      = _host.split('.');
	var dm    = so[so.length-2] + '.' + so[so.length-1];
	return (so[so.length-1].length == 2) ? so[so.length-3] + '.' + dm : dm;
}

var Nethru_domain  = Nethru_getDomain();

Nethru_makePersistentCookie("PCID",10,"/",Nethru_domain);
Nethru_makePersistentCookie1("RC",10,"/",Nethru_domain);