// JavaScript Document
function addfavorite()
{
	if (document.all)
	{ 
	window.external.addFavorite(window.location.href,"QQ��վ��������Ⱥ��������");
	}
	else if (window.sidebar)
	{ window.sidebar.addPanel('QQ��վ��������Ⱥ��������',window.location, ""); }
} 
function copy(){
	var stringAnything="QQ����Ⱥ5678537��70210212��ӭ���ļ��룬Ⱥ�ٷ���վ:http://www.lovewebgames.com/demo."+ document.title+":"+window.location;
	copyToClipboard(stringAnything);
	}
function copyToClipboard(txt) {    
 if(window.clipboardData) {    
		 window.clipboardData.clearData();    
		 window.clipboardData.setData("Text", txt);    
 } else if(navigator.userAgent.indexOf("Opera") != -1) {    
	  window.location = txt;    
 } else if (window.netscape) {    
	  try {    
		   netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");    
	  } catch (e) {    
		   alert("��������ܾ���\n�����������ַ������'about:config'���س�\nȻ��'signed.applets.codebase_principal_support'����Ϊ'true'");    
	  }    
	  var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);    
	  if (!clip)    
		   return;    
	  var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);    
	  if (!trans)    
		   return;    
	  trans.addDataFlavor('text/unicode');    
	  var str = new Object();    
	  var len = new Object();    
	  var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);    
	  var copytext = txt;    
	  str.data = copytext;    
	  trans.setTransferData("text/unicode",str,copytext.length*2);    
	  var clipid = Components.interfaces.nsIClipboard;    
	  if (!clip)    
		   return false;    
	  clip.setData(trans,null,clipid.kGlobalClipboard);      
 }    
	  alert("�ѳɹ����Ƶ����а壬������ճ�����������ѣ�")  
}  