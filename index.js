$(document).ready(function(){
	$("li").hover(function(){
		$(this).css("background","#a0a0a0");
		$(this).find("img").css("height","220px")
		play(this);
	},function(){
		$(this).css("background","#efefef");
		$(this).find("img").css("height","200px")
		stop(this);
	});
	var v;
	function play(obj){
		v=setTimeout(function (){
			var sWidth,sHeight;
		   sWidth=document.body.offsetWidth;//���������������ҳ����
		   sHeight=screen.height;//��Ļ�߶ȣ���ֱ�ֱ��ʣ�
			 //�����㣨��С�봰����Ч������ͬ�����������Ի���ʱ��������ʾΪ����״͸����ɫ��
		   var bgObj=document.createElement("div");//����һ��div���󣨱����㣩
		   var show=document.createElement("div");
		   show.setAttribute('id','show');
		   show.style.display="none";

		   bgObj.style.display="none";
		   //����div���ԣ����൱��
		   bgObj.setAttribute('id','bgDiv');
		   bgObj.style.position="absolute";
		   bgObj.style.top="0";
		   bgObj.style.background="#777";
		   bgObj.style.filter="progid:DXImageTransform.Microsoft.Alpha(style=3,opacity=25,finishOpacity=75";
		   bgObj.style.opacity="0.6";
		   bgObj.style.left="0";
		   bgObj.style.width=sWidth + "px";
		   bgObj.style.height=sHeight + "px";
		   bgObj.style.zIndex = "10";
		   document.body.appendChild(bgObj);
		   document.body.appendChild(show);//��body����Ӹ�div����
		   $("#show").show(2000);
		   $("#bgDiv").show(2000);
			var url= $(obj).find("a").attr("href");
			var w = document.body.clientWidth||document.body.offsetWidth;	
			$("#show").css("left",w/2-parseInt(512)/2);
			$("#show")[0].innerHTML="<iframe src='"+$(obj).find("a").attr("href")+"' width='800px'height='600px' id='frame'></iframe>";
			document.getElementById("frame").document.body.css="scrollbar-face-color:#e9e9e9; scrollbar-arrow-color:#808080; scrollbar-track-color: #f2f2f2; scrollbar-highlight-color: #e9e9e9; scrollbar-3dlight-color: #ffffff;scrollbar-darkshadow-Color:#d3d3d3; "
			$(document).click(function(){
				$("#show").remove();
				$("#bgDiv").remove();
			})
		},1000)
	}
	function stop(obj){
		clearTimeout(v);
	}
});
