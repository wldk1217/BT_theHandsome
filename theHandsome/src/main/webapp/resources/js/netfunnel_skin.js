if(typeof NetFunnel == "object"){

	NetFunnel.SkinUtil.add('handsome_skin',{
		prepareCallback:function(){
			// 필요시 정의
		},
		updateCallback:function(percent,nwait,totwait,timeleft){
			var vTime = document.getElementById("v_NetFunnel_Loading_Popup_TimeLeft");
			vTime.innerHTML= fn_timeChange(timeleft);
			var oCount = document.getElementById("NetFunnel_Loading_Popup_Count");
			var vCount = document.getElementById("v_NetFunnel_Loading_Popup_Count");
			vCount.innerHTML=oCount.innerHTML + '<em>번째</em>';
		},
		htmlStr:'<div id="NetFunnel_Skin_Top" class="pc_gate_pop"> \
					<img class="pc_poptxt01" src="http://cdn.thehandsome.com/_ui/desktop/common/images/pop_gate_tit.png" alt="THEHANDSOME.COM" /> \
					<img class="pc_poptxt02" src="http://cdn.thehandsome.com/_ui/desktop/common/images/pop_gate_txt01.png" alt="서비스 접속대기 중입니다.잠시만 기다려주시면 자동 접속됩니다." /> \
					<img class="pc_poploding" src="http://cdn.thehandsome.com/_ui/desktop/common/images/pc_pop_loading.gif" alt="로딩" /> \
					<ul> \
						<li>	\
							<img src="http://cdn.thehandsome.com/_ui/desktop/common/images/pop_gate_txt02.png" alt="" /> \
							<span id="v_NetFunnel_Loading_Popup_TimeLeft">0</span> \
						</li> \
						<li> \
							<img src="http://cdn.thehandsome.com/_ui/desktop/common/images/pop_gate_txt03.png" alt="" /> \
							<span id="v_NetFunnel_Loading_Popup_Count">0<em>번째</em></span> \
						</li> \
					</ul> \
					<img class="pc_poptxt03" src="http://cdn.thehandsome.com/_ui/desktop/common/images/pop_gate_txt04.png" alt="※ 새로고침 또는 재접속하시면 대기시간이 더 길어집니다" /> \
					<a onClick="javascript:NetFunnel.countdown_stop();"> \
						<img src="http://cdn.thehandsome.com/_ui/desktop/common/images/btn_popgate_next.gif" alt="다음에 접속하기" /> \
					</a> \
					<div id="NetFunnel_Loading_Popup_Count" style="display:none;"></div> \
				</div> '
	},'normal');
	
	NetFunnel.SkinUtil.add('handsome_skin',{
		prepareCallback:function(){
			// 필요시 정의
		},
		updateCallback:function(percent,nwait,totwait,timeleft){
			var vTime = document.getElementById("v_NetFunnel_Loading_Popup_TimeLeft");
			vTime.innerHTML= fn_timeChange(timeleft);
			var oCount = document.getElementById("NetFunnel_Loading_Popup_Count");
			var vCount = document.getElementById("v_NetFunnel_Loading_Popup_Count");
			vCount.innerHTML=oCount.innerHTML + '<em>번째</em>';
		},
		htmlStr:'<div id="NetFunnel_Skin_Top" class="gate_pop"> \
					<p class="poptxt01"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/m_pop_gate_tit.png" alt="THEHANDSOME.COM" /> \
					</p> \
					<p class="poptxt02"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/m_pop_gate_txt01.png" alt="서비스 접속대기 중입니다.잠시만 기다려주시면 자동 접속됩니다." /> \
					</p> \
					<p class="poploding"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/m_pop_loading.gif" alt="로딩" /> \
					</p> \
					<ul> \
						<li> \
							<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/m_pop_gate_txt02.png" alt="" /> \
							<span id="v_NetFunnel_Loading_Popup_TimeLeft">0</span> \
						</li> \
						<li> \
							<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/m_pop_gate_txt03.png" alt="" /> \
							<span id="v_NetFunnel_Loading_Popup_Count">0<em>번째</em></span> \
						</li> \
					</ul> \
					<p class="poptxt03"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/m_pop_gate_txt04.png" alt="※ 새로고침 또는 재접속하시면 대기시간이 더 길어집니다" /> \
					</p> \
					<a onClick="javascript:NetFunnel.countdown_stop();" class="btn_close_btsx"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/m_pop_gate_btntxt.png" alt="다음에 접속하기" /> \
					</a> \
					<div id="NetFunnel_Loading_Popup_Count" style="display:none;"></div> \
				</div> '
	},'mobile');
	
	NetFunnel.SkinUtil.add('handsome_skin_en',{
		prepareCallback:function(){
			// 필요시 정의
		},
		updateCallback:function(percent,nwait,totwait,timeleft){
			var vTime = document.getElementById("v_NetFunnel_Loading_Popup_TimeLeft");
			vTime.innerHTML= fn_timeChange(timeleft);
			var oCount = document.getElementById("NetFunnel_Loading_Popup_Count");
			var vCount = document.getElementById("v_NetFunnel_Loading_Popup_Count");
			vCount.innerHTML=oCount.innerHTML;
		},
		htmlStr:'<div id="NetFunnel_Skin_Top" class="pc_gate_pop"> \
					<img class="pc_poptxt01" src="http://cdn.thehandsome.com/_ui/desktop/common/images/pop_gate_tit.png" alt="THEHANDSOME.COM" /> \
					<img class="pc_poptxt02" src="http://cdn.thehandsome.com/_ui/desktop/common/images/en_pop_gate_txt01.png" alt="Now connecting the site.You will get connected shortly." /> \
					<img class="pc_poploding" src="http://cdn.thehandsome.com/_ui/desktop/common/images/pc_pop_loading.gif" alt="로딩" /> \
					<ul> \
						<li>	\
							<img src="http://cdn.thehandsome.com/_ui/desktop/common/images/en_pop_gate_txt02.png" alt="Estimated wait time" /> \
							<span id="v_NetFunnel_Loading_Popup_TimeLeft">0</span> \
						</li> \
						<li> \
							<img src="http://cdn.thehandsome.com/_ui/desktop/common/images/en_pop_gate_txt03.png" alt="Your number in line" /> \
							<span id="v_NetFunnel_Loading_Popup_Count">0</span> \
						</li> \
					</ul> \
					<img class="pc_poptxt03" src="http://cdn.thehandsome.com/_ui/desktop/common/images/en_pop_gate_txt04.png" alt="※ Refresh or reconnect web page taking too long time to load." /> \
					<a onClick="javascript:NetFunnel.countdown_stop();"> \
						<img src="http://cdn.thehandsome.com/_ui/desktop/common/images/en_btn_popgate_next.png" alt="Try again later" /> \
					</a> \
					<div id="NetFunnel_Loading_Popup_Count" style="display:none;"></div> \
				</div> '
	},'normal');
	
	NetFunnel.SkinUtil.add('handsome_skin_en',{
		prepareCallback:function(){
			// 필요시 정의
		},
		updateCallback:function(percent,nwait,totwait,timeleft){
			var vTime = document.getElementById("v_NetFunnel_Loading_Popup_TimeLeft");
			vTime.innerHTML= fn_timeChange(timeleft);
			var oCount = document.getElementById("NetFunnel_Loading_Popup_Count");
			var vCount = document.getElementById("v_NetFunnel_Loading_Popup_Count");
			vCount.innerHTML=oCount.innerHTML;
		},
		htmlStr:'<div id="NetFunnel_Skin_Top" class="gate_pop"> \
					<p class="en_poptxt01"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/m_pop_gate_tit.png" alt="THEHANDSOME.COM" /> \
					</p> \
					<p class="en_poptxt02"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/en_mpop_gate_txt01.png" alt="Now connecting the site.	You will get connected shortly." /> \
					</p> \
					<p class="poploding"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/m_pop_loading.gif" alt="로딩" /> \
					</p> \
					<ul class="en_bts_list"> \
						<li> \
							<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/en_mpop_gate_txt02.png" alt="Estimated wait time" /> \
							<span id="v_NetFunnel_Loading_Popup_TimeLeft">0</span> \
						</li> \
						<li> \
							<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/en_mpop_gate_txt03.png" alt="Your number in line" /> \
							<span id="v_NetFunnel_Loading_Popup_Count">0</span> \
						</li> \
					</ul> \
					<p class="en_poptxt03"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/en_mpop_gate_txt04.png" alt="※ Refresh or reconnect web page taking too long time to load." /> \
					</p> \
					<a onClick="javascript:NetFunnel.countdown_stop();" class="btn_close_btsx en_btn_bts"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/en_btn_mpopgate_next.png" alt="Try again later" /> \
					</a> \
					<div id="NetFunnel_Loading_Popup_Count" style="display:none;"></div> \
				</div> '
	},'mobile');
	
	NetFunnel.SkinUtil.add('handsome_skin_zh',{
		prepareCallback:function(){
			// 필요시 정의
		},
		updateCallback:function(percent,nwait,totwait,timeleft){
			var vTime = document.getElementById("v_NetFunnel_Loading_Popup_TimeLeft");
			vTime.innerHTML= fn_timeChange(timeleft);
			var oCount = document.getElementById("NetFunnel_Loading_Popup_Count");
			var vCount = document.getElementById("v_NetFunnel_Loading_Popup_Count");
			vCount.innerHTML='<em>第</em>' + oCount.innerHTML + '<em>次</em>';
		},
		htmlStr:'<div id="NetFunnel_Skin_Top" class="pc_gate_pop"> \
					<img class="pc_poptxt01" src="http://cdn.thehandsome.com/_ui/desktop/common/images/pop_gate_tit.png" alt="THEHANDSOME.COM" /> \
					<img class="pc_poptxt02" src="http://cdn.thehandsome.com/_ui/desktop/common/images/cn_pop_gate_txt01.png" alt="正在等待连接到官网。请稍等后自动连接到官网。" /> \
					<img class="pc_poploding" src="http://cdn.thehandsome.com/_ui/desktop/common/images/pc_pop_loading.gif" alt="로딩" /> \
					<ul> \
						<li>	\
							<img src="http://cdn.thehandsome.com/_ui/desktop/common/images/cn_pop_gate_txt02.png" alt="预计等待时间" /> \
							<span id="v_NetFunnel_Loading_Popup_TimeLeft">0</span> \
						</li> \
						<li> \
							<img src="http://cdn.thehandsome.com/_ui/desktop/common/images/cn_pop_gate_txt03.png" alt="" /> \
							<span id="v_NetFunnel_Loading_Popup_Count"><em>第</em>0<em>次</em></span> \
						</li> \
					</ul> \
					<img class="pc_poptxt03" src="http://cdn.thehandsome.com/_ui/desktop/common/images/cn_pop_gate_txt04.png" alt="※ 重新加载或者重新访问时, 等待时间将会变长的。" /> \
					<a onClick="javascript:NetFunnel.countdown_stop();"> \
						<img src="http://cdn.thehandsome.com/_ui/desktop/common/images/cn_btn_popgate_next.png" alt="下次访问" /> \
					</a> \
					<div id="NetFunnel_Loading_Popup_Count" style="display:none;"></div> \
				</div> '
	},'normal');
	
	NetFunnel.SkinUtil.add('handsome_skin_zh',{
		prepareCallback:function(){
			// 필요시 정의
		},
		updateCallback:function(percent,nwait,totwait,timeleft){
			var vTime = document.getElementById("v_NetFunnel_Loading_Popup_TimeLeft");
			vTime.innerHTML= fn_timeChange(timeleft);
			var oCount = document.getElementById("NetFunnel_Loading_Popup_Count");
			var vCount = document.getElementById("v_NetFunnel_Loading_Popup_Count");
			vCount.innerHTML='<em>第</em>' + oCount.innerHTML + '<em>次</em>';
		},
		htmlStr:'<div id="NetFunnel_Skin_Top" class="gate_pop"> \
					<p class="cn_poptxt01"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/m_pop_gate_tit.png" alt="THEHANDSOME.COM" /> \
					</p> \
					<p class="cn_poptxt02"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/cn_mpop_gate_txt01.png" alt="正在等待连接到官网。请稍等后自动连接到官网。" /> \
					</p> \
					<p class="poploding"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/m_pop_loading.gif" alt="로딩" /> \
					</p> \
					<ul class="cn_bts_list"> \
						<li> \
							<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/cn_mpop_gate_txt02.png" alt="预计等待时间" /> \
							<span id="v_NetFunnel_Loading_Popup_TimeLeft">0</span> \
						</li> \
						<li> \
							<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/cn_mpop_gate_txt03.png" alt="等待顺序" /> \
							<span id="v_NetFunnel_Loading_Popup_Count"><em>第</em>0<em>次</em></span> \
						</li> \
					</ul> \
					<p class="cn_poptxt03"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/cn_mpop_gate_txt04.png" alt="※ 重新加载或者重新访问时, 等待时间将会变长的。" /> \
					</p> \
					<a onClick="javascript:NetFunnel.countdown_stop();" class="btn_close_btsx cn_btn_bts"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/cn_btn_mpopgate_next.png" alt="下次访问" /> \
					</a> \
					<div id="NetFunnel_Loading_Popup_Count" style="display:none;"></div> \
				</div> '
	},'mobile');
	
	NetFunnel.SkinUtil.add('handsome_gateway_skin',{
		prepareCallback:function(){
			// 필요시 정의
		},
		updateCallback:function(percent,nwait,totwait,timeleft){
			var vTime = document.getElementById("v_NetFunnel_Loading_Popup_TimeLeft");
			vTime.innerHTML= fn_timeChange(timeleft);
			var oCount = document.getElementById("NetFunnel_Loading_Popup_Count");
			var vCount = document.getElementById("v_NetFunnel_Loading_Popup_Count");
			vCount.innerHTML=oCount.innerHTML + '<em>번째</em>';
		},
		htmlStr:'<div id="NetFunnel_Skin_Top" class="pc_gate_pop"> \
					<img class="pc_poptxt01" src="http://cdn.thehandsome.com/_ui/desktop/common/images/pop_gate_tit.png" alt="THEHANDSOME.COM" /> \
					<img class="pc_poptxt02" src="http://cdn.thehandsome.com/_ui/desktop/common/images/pop_gate_txt01.png" alt="서비스 접속대기 중입니다.잠시만 기다려주시면 자동 접속됩니다." /> \
					<img class="pc_poploding" src="http://cdn.thehandsome.com/_ui/desktop/common/images/pc_pop_loading.gif" alt="로딩" /> \
					<ul> \
						<li>	\
							<img src="http://cdn.thehandsome.com/_ui/desktop/common/images/pop_gate_txt02.png" alt="" /> \
							<span id="v_NetFunnel_Loading_Popup_TimeLeft"></span> \
						</li> \
						<li> \
							<img src="http://cdn.thehandsome.com/_ui/desktop/common/images/pop_gate_txt03.png" alt="" /> \
							<span id="v_NetFunnel_Loading_Popup_Count">0<em>번째</em></span> \
						</li> \
					</ul> \
					<img class="pc_poptxt03" src="http://cdn.thehandsome.com/_ui/desktop/common/images/pop_gate_txt04.png" alt="※ 새로고침 또는 재접속하시면 대기시간이 더 길어집니다" /> \
					<a onClick="javascript:fn_back();"> \
						<img src="http://cdn.thehandsome.com/_ui/desktop/common/images/btn_popgate_next.gif" alt="다음에 접속하기" /> \
					</a> \
					<div id="NetFunnel_Loading_Popup_Count" style="display:none;"></div> \
				</div> '
	},'normal');
	
	NetFunnel.SkinUtil.add('handsome_gateway_skin',{
		prepareCallback:function(){
			// 필요시 정의
		},
		updateCallback:function(percent,nwait,totwait,timeleft){
			var vTime = document.getElementById("v_NetFunnel_Loading_Popup_TimeLeft");
			vTime.innerHTML= fn_timeChange(timeleft);
			var oCount = document.getElementById("NetFunnel_Loading_Popup_Count");
			var vCount = document.getElementById("v_NetFunnel_Loading_Popup_Count");
			vCount.innerHTML=oCount.innerHTML + '<em>번째</em>';
		},
		htmlStr:'<div id="NetFunnel_Skin_Top" class="gate_pop"> \
					<p class="poptxt01"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/m_pop_gate_tit.png" alt="THEHANDSOME.COM" /> \
					</p> \
					<p class="poptxt02"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/m_pop_gate_txt01.png" alt="서비스 접속대기 중입니다.잠시만 기다려주시면 자동 접속됩니다." /> \
					</p> \
					<p class="poploding"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/m_pop_loading.gif" alt="로딩" /> \
					</p> \
					<ul> \
						<li> \
							<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/m_pop_gate_txt02.png" alt="" /> \
							<span id="v_NetFunnel_Loading_Popup_TimeLeft"><em>초</em></span> \
						</li> \
						<li> \
							<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/m_pop_gate_txt03.png" alt="" /> \
							<span id="v_NetFunnel_Loading_Popup_Count"><em>번째</em></span> \
						</li> \
					</ul> \
					<p class="poptxt03"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/m_pop_gate_txt04.png" alt="※ 새로고침 또는 재접속하시면 대기시간이 더 길어집니다" /> \
					</p> \
					<a onClick="javascript:fn_back();" class="btn_close_btsx"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/m_pop_gate_btntxt.png" alt="다음에 접속하기" /> \
					</a> \
					<div id="NetFunnel_Loading_Popup_Count" style="display:none;"></div> \
				</div> '
	},'mobile');
	
	NetFunnel.SkinUtil.add('handsome_gateway_skin_en',{
		prepareCallback:function(){
			// 필요시 정의
		},
		updateCallback:function(percent,nwait,totwait,timeleft){
			var vTime = document.getElementById("v_NetFunnel_Loading_Popup_TimeLeft");
			vTime.innerHTML= fn_timeChange(timeleft);
			var oCount = document.getElementById("NetFunnel_Loading_Popup_Count");
			var vCount = document.getElementById("v_NetFunnel_Loading_Popup_Count");
			vCount.innerHTML=oCount.innerHTML;
		},
		htmlStr:'<div id="NetFunnel_Skin_Top" class="pc_gate_pop"> \
					<img class="pc_poptxt01" src="http://cdn.thehandsome.com/_ui/desktop/common/images/pop_gate_tit.png" alt="THEHANDSOME.COM" /> \
					<img class="pc_poptxt02" src="http://cdn.thehandsome.com/_ui/desktop/common/images/en_pop_gate_txt01.png" alt="Now connecting the site.You will get connected shortly." /> \
					<img class="pc_poploding" src="http://cdn.thehandsome.com/_ui/desktop/common/images/pc_pop_loading.gif" alt="로딩" /> \
					<ul> \
						<li>	\
							<img src="http://cdn.thehandsome.com/_ui/desktop/common/images/en_pop_gate_txt02.png" alt="Estimated wait time" /> \
							<span id="v_NetFunnel_Loading_Popup_TimeLeft">0</span> \
						</li> \
						<li> \
							<img src="http://cdn.thehandsome.com/_ui/desktop/common/images/en_pop_gate_txt03.png" alt="Your number in line" /> \
							<span id="v_NetFunnel_Loading_Popup_Count">0</span> \
						</li> \
					</ul> \
					<img class="pc_poptxt03" src="http://cdn.thehandsome.com/_ui/desktop/common/images/en_pop_gate_txt04.png" alt="※ Refresh or reconnect web page taking too long time to load." /> \
					<a onClick="javascript:fn_back();"> \
						<img src="http://cdn.thehandsome.com/_ui/desktop/common/images/en_btn_popgate_next.png" alt="Try again later" /> \
					</a> \
					<div id="NetFunnel_Loading_Popup_Count" style="display:none;"></div> \
				</div> '
	},'normal');
	
	NetFunnel.SkinUtil.add('handsome_gateway_skin_en',{
		prepareCallback:function(){
			// 필요시 정의
		},
		updateCallback:function(percent,nwait,totwait,timeleft){
			var vTime = document.getElementById("v_NetFunnel_Loading_Popup_TimeLeft");
			vTime.innerHTML= fn_timeChange(timeleft);
			var oCount = document.getElementById("NetFunnel_Loading_Popup_Count");
			var vCount = document.getElementById("v_NetFunnel_Loading_Popup_Count");
			vCount.innerHTML=oCount.innerHTML;
		},
		htmlStr:'<div id="NetFunnel_Skin_Top" class="gate_pop"> \
					<p class="en_poptxt01"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/m_pop_gate_tit.png" alt="THEHANDSOME.COM" /> \
					</p> \
					<p class="en_poptxt02"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/en_mpop_gate_txt01.png" alt="Now connecting the site.	You will get connected shortly." /> \
					</p> \
					<p class="poploding"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/m_pop_loading.gif" alt="로딩" /> \
					</p> \
					<ul class="en_bts_list"> \
						<li> \
							<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/en_mpop_gate_txt02.png" alt="Estimated wait time" /> \
							<span id="v_NetFunnel_Loading_Popup_TimeLeft">0</span> \
						</li> \
						<li> \
							<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/en_mpop_gate_txt03.png" alt="Your number in line" /> \
							<span id="v_NetFunnel_Loading_Popup_Count">0</span> \
						</li> \
					</ul> \
					<p class="en_poptxt03"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/en_mpop_gate_txt04.png" alt="※ Refresh or reconnect web page taking too long time to load." /> \
					</p> \
					<a onClick="javascript:fn_back();" class="btn_close_btsx en_btn_bts"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/en_btn_mpopgate_next.png" alt="Try again later" /> \
					</a> \
					<div id="NetFunnel_Loading_Popup_Count" style="display:none;"></div> \
				</div> '
	},'mobile');
	
	NetFunnel.SkinUtil.add('handsome_gateway_skin_zh',{
		prepareCallback:function(){
			// 필요시 정의
		},
		updateCallback:function(percent,nwait,totwait,timeleft){
			var vTime = document.getElementById("v_NetFunnel_Loading_Popup_TimeLeft");
			vTime.innerHTML= fn_timeChange(timeleft);
			var oCount = document.getElementById("NetFunnel_Loading_Popup_Count");
			var vCount = document.getElementById("v_NetFunnel_Loading_Popup_Count");
			vCount.innerHTML='<em>第</em>' + oCount.innerHTML + '<em>次</em>';
		},
		htmlStr:'<div id="NetFunnel_Skin_Top" class="pc_gate_pop"> \
					<img class="pc_poptxt01" src="http://cdn.thehandsome.com/_ui/desktop/common/images/pop_gate_tit.png" alt="THEHANDSOME.COM" /> \
					<img class="pc_poptxt02" src="http://cdn.thehandsome.com/_ui/desktop/common/images/cn_pop_gate_txt01.png" alt="正在等待连接到官网。请稍等后自动连接到官网。" /> \
					<img class="pc_poploding" src="http://cdn.thehandsome.com/_ui/desktop/common/images/pc_pop_loading.gif" alt="로딩" /> \
					<ul> \
						<li>	\
							<img src="http://cdn.thehandsome.com/_ui/desktop/common/images/cn_pop_gate_txt02.png" alt="预计等待时间" /> \
							<span id="v_NetFunnel_Loading_Popup_TimeLeft">0</span> \
						</li> \
						<li> \
							<img src="http://cdn.thehandsome.com/_ui/desktop/common/images/cn_pop_gate_txt03.png" alt="" /> \
							<span id="v_NetFunnel_Loading_Popup_Count"><em>第</em>0<em>次</em></span> \
						</li> \
					</ul> \
					<img class="pc_poptxt03" src="http://cdn.thehandsome.com/_ui/desktop/common/images/cn_pop_gate_txt04.png" alt="※ 重新加载或者重新访问时, 等待时间将会变长的。" /> \
					<a onClick="javascript:fn_back();"> \
						<img src="http://cdn.thehandsome.com/_ui/desktop/common/images/cn_btn_popgate_next.png" alt="下次访问" /> \
					</a> \
					<div id="NetFunnel_Loading_Popup_Count" style="display:none;"></div> \
				</div> '
	},'normal');
	
	NetFunnel.SkinUtil.add('handsome_gateway_skin_zh',{
		prepareCallback:function(){
			// 필요시 정의
		},
		updateCallback:function(percent,nwait,totwait,timeleft){
			var vTime = document.getElementById("v_NetFunnel_Loading_Popup_TimeLeft");
			vTime.innerHTML= fn_timeChange(timeleft);
			var oCount = document.getElementById("NetFunnel_Loading_Popup_Count");
			var vCount = document.getElementById("v_NetFunnel_Loading_Popup_Count");
			vCount.innerHTML='<em>第</em>' + oCount.innerHTML + '<em>次</em>';
		},
		htmlStr:'<div id="NetFunnel_Skin_Top" class="gate_pop"> \
					<p class="cn_poptxt01"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/m_pop_gate_tit.png" alt="THEHANDSOME.COM" /> \
					</p> \
					<p class="cn_poptxt02"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/cn_mpop_gate_txt01.png" alt="正在等待连接到官网。请稍等后自动连接到官网。" /> \
					</p> \
					<p class="poploding"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/m_pop_loading.gif" alt="로딩" /> \
					</p> \
					<ul class="cn_bts_list"> \
						<li> \
							<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/cn_mpop_gate_txt02.png" alt="预计等待时间" /> \
							<span id="v_NetFunnel_Loading_Popup_TimeLeft">0</span> \
						</li> \
						<li> \
							<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/cn_mpop_gate_txt03.png" alt="等待顺序" /> \
							<span id="v_NetFunnel_Loading_Popup_Count"><em>第</em>0<em>次</em></span> \
						</li> \
					</ul> \
					<p class="cn_poptxt03"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/cn_mpop_gate_txt04.png" alt="※ 重新加载或者重新访问时, 等待时间将会变长的。" /> \
					</p> \
					<a onClick="javascript:fn_back();" class="btn_close_btsx cn_btn_bts"> \
						<img src="http://cdn.thehandsome.com/_ui/handsomemobile/images/common/cn_btn_mpopgate_next.png" alt="下次访问" /> \
					</a> \
					<div id="NetFunnel_Loading_Popup_Count" style="display:none;"></div> \
				</div> '
	},'mobile');

}

function fn_timeChange(seconds) {
	var hour, min, sec;
	hour = parseInt(seconds/3600);
	min = parseInt((seconds%3600)/60);
	sec = seconds%60;
	if (hour.toString().length==1) hour = "0" + hour;
	if (min.toString().length==1) min = "0" + min;
	if (sec.toString().length==1) sec = "0" + sec;
	var rslt = hour + ":" + min + ":" + sec; 
	return rslt;
}

function fn_back() {
	window.history.back();
}