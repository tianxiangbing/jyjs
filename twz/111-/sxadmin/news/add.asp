<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��̨����</title>
<link rel="stylesheet" href="../css/common.css" type="text/css" />
<script type="text/javascript" src="../js/checkForm.js"></script>
<script type="text/javascript">
function doChange(objText, objDrop){
		if (!objDrop) return;
		var str = objText.value;
		var arr = str.split("|");
		var nIndex = objDrop.selectedIndex;
		objDrop.length=1;
		for (var i=0; i<arr.length; i++){
			objDrop.options[objDrop.length] = new Option(arr[i], arr[i]);
		}
		objDrop.selectedIndex = nIndex;
	}
</script>
</head>
<body>
<!--#include file="../inc/subCode.asp"-->
<!--#include file="../fckeditor/fckeditor.asp" -->
<!--<div id="container">-->
<%
 if request.querystring("action")="add" then' ȡ�ύ����������
	' ע��ȡ�������ݵķ�������Ϊ�Դ�����Զ�����һ��Ҫʹ��ѭ�����������100K�����ݽ�ȡ�������������������Ϊ102399�ֽڣ�100K���ң�
	Dim  title,newsClass,power,newspic,sContent,Encontent,isSuggest,i,Entitle
	
	title = Request.Form("title")
	Entitle = Request.Form("Entitle")
	newsClass = Request.Form("newsClass")
	power = Request.Form("power")
	newsPic = Request.Form("newsPic")
	if(len(newsPic))>16 then
		newssmallpic="upfile/news"&"small_"&right(newsPic,(len(newsPic)-16))
		'rs("ProSmallPic")="upfile/products/"&"small_"&right(proPic,(len(proPic)-16))
	end if
	languages = "2"
	isSuggest=request.Form("isSuggest")
	if isSuggest="" then isSuggest=false end if
'	if newsClass="" then newsClass=0  end if
	

	' =======��ʼ��eWebEditor�༭��ȡֵ=====================
	scontent = ""
	For i = 1 To Request.Form("content").Count
		scontent = scontent & Request.Form("content")(i)
	Next
	scontent=getSafeContent(scontent)
	
	Encontent = ""
	For i = 1 To Request.Form("Encontent").Count
		Encontent = Encontent & Request.Form("Encontent")(i)
	Next
	' =========������eWebEditor�༭��ȡֵ===================
	
	' �ϴ��󱣴浽���ط��������ļ���������·�����������"|"�ָ�
	Dim d_savefilename
	' �ϴ��󱣴浽���ط�������·���ļ����������"|"�ָ�
	Dim d_savepathfilename,SaveFileName,SavePathFileName,sql
	d_savefilename=GetSafeStr(Request.Form("d_savefilename"))
	d_savepathfilename=GetSafeStr(Request.Form("d_savepathfilename"))
	
	SaveFileName=CheckSaveFileNamePic(d_savefilename,scontent)	'��Ҫ����༭����ɾ��ͼƬ�󣬱���ͼƬ�ֶεĵ�����
	SavePathFileName=CheckSaveFileNamePic(d_savepathfilename,scontent)
	
	sql="insert into news(title,Entitle,ClassId,content,Encontent,power,isSuggest,newsPic,newssmallpic,d_savefilename,d_savepathfilename,languages) values('"&title&"','"&Entitle&"',"&newsClass&",'"&scontent&"','"&Encontent&"',"&power&","&isSuggest&",'"&newssmallpic&"','"&ssavefilename&"','"&ssavepathfilename&"','"&ssavepathfilename&"','"&languages&"')"
	'response.Write(sql)
	'response.End()
	conn.execute(sql)
	ok "�����ɹ���","add.asp"

'on error resume next
'set rs=server.CreateObject("adodb.recordset")
'sql="select * from news where 1=0"
'rs.open sql,conn,3,2
'rs.addnew
'rs("title") = title
'rs("Entitle") = Entitle
'rs("ClassId") = newsClass
'rs("power") = Cint(power)
'rs("newsPic") = newsPic
'if(len(newsPic))>16 then
'	rs("newssmallpic")="upfile/news"&"small_"&right(newsPic,(len(newsPic)-16))
'	'rs("ProSmallPic")="upfile/products/"&"small_"&right(proPic,(len(proPic)-16))
'end if 
'rs("title") = title   
'rs("languages") = languages
'rs("content") = scontent
'rs("Encontent") = Encontent
'
'rs("d_savefilename") = ssavefilename
'rs("d_savepathfilename") = ssavepathfilename
'
'rs("addtime") = Now()
'
'if rs("isSuggest") = "yes" then 
'	rs("isSuggest") = true
'else
'	rs("isSuggest") = false
'end if 
''rs.update
'if err<>0 then
'	erro("���ʧ�ܣ������ֶ�")
'else
'	ok "�����ɹ�","add.asp"
'end if 
rs.close
set rs = nothing
end if
 %>
<table width="100%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
    <form id="form1" name="form1" method="post" action="../../sxadmin/news/add.asp?action=add" onSubmit="return chkNews();">
	<input type="hidden" name="d_savefilename">
    <input type="hidden" name="d_savepathfilename" onChange="doChange(this,document.form1.newsPic)">
	<tr>
      <td colspan="2" class="table_title">��������</td>
    </tr>
    <tr>
      <td width="15%" align="right" class="left_title_2">�������</td>
      <td width="85%">
      <select name="newsClass"  style="background-color:#ECF3FF;">
      <option value="">��ѡ�����</option>
      <%  showClass 0,0,0,"newsClass" %>
      </select><span class="red">*</span></td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">�������ű��⣺</td>
      <td align="left"  bgcolor="#FFFFFF">
        <input name="title" type="text" id="title" size="45" maxlength="100" />
        <span class="red">*</span></td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">Ӣ�����ű��⣺</td>
      <td align="left">
        <input name="Entitle" type="text" id="Entitle" size="45" maxlength="100" /><span class="red">*</span>
      </td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">�š�����</td>
      <td><input name="power" type="text" id="power" value="0" size="6" maxlength="6" />
      <span class="red">*(���������У�������Խ��Խ��ǰ��)</span></td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">�ϴ�ͼƬ��</td>
      <td><input name="newsPic" type="text"  id="newsPic" value="" size="25" readonly="" />
&nbsp;
<iframe src="../inc/sctp.asp?formname=form1&amp;editname=newsPic&amp;uppath=upfile/news&amp;filelx=<%= EnableUploadPic %>&amp;enFileSize=<%= EnableUploadPicSize %>" width="320" height="35" frameborder="0" scrolling="No" style="vertical-align:middle" id="uploadFrame" ></iframe>
<span id="uploadInfo"></span>&nbsp;<font color="#FF0000">ͼƬ��ʽ��
<%= EnableUploadPic %>
*</font></td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">�����������ݣ�</td>
      <td>
      <%
	  Set oFCKeditor = New FCKeditor 
	  oFCKeditor.BasePath = "../FCKeditor/"  '����·�������ⲻҪ�Ķ���
	 ' //���ñ༭����·������վ���Ŀ¼�µ�һ��Ŀ¼ 
	 oFCKeditor.ToolbarSet = "Default"   '�����ļ��ֹ���������Default,base,����   										                                          fckconfig.js�����趨.   
	 oFCKeditor.Width = "100%" '�����趨���,���԰� % ��ֵ��ѡ��.   
	 oFCKeditor.Height = "400" 
	 oFCKeditor.Value = "" '//����Ǹ��༭����ʼֵ 
	 oFCKeditor.Create "content" '//�Ժ�༭��������ݶ��������logbodyȡ�ã��������㶨
	 %>
      </td>
    </tr>
      <tr>
      <td align="right" class="left_title_2">Ӣ���������ݣ�</td>
     <td>
     <%
	  Set oFCKeditor = New FCKeditor 
	  oFCKeditor.BasePath = "../FCKeditor/"  '����·�������ⲻҪ�Ķ���
	 ' //���ñ༭����·������վ���Ŀ¼�µ�һ��Ŀ¼ 
	 oFCKeditor.ToolbarSet = "Default"   '�����ļ��ֹ���������Default,base,����   										                                          fckconfig.js�����趨.   
	 oFCKeditor.Width = "100%" '�����趨���,���԰� % ��ֵ��ѡ��.   
	 oFCKeditor.Height = "400" 
	 oFCKeditor.Value = "" '//����Ǹ��༭����ʼֵ 
	 oFCKeditor.Create "Encontent" '//�Ժ�༭��������ݶ��������logbodyȡ�ã��������㶨
	 %>
     </td>
    </tr>
    <!--<tr>
      <td align="right" class="left_title_2">�Ƿ��Ƽ���</td>
      <td><input name="isSuggest" type="checkbox" id="isSuggest" value="true" >
      <font color="#FF0000">��ѡ������Ϊ�Ƽ�</font></td>
    </tr>-->
    <tr bgcolor="#FFFFFF">
      <td class="left_title_2">&nbsp;</td>
      <td>
      <input type="submit" name="btnsubmit" value="�� ��" class="button2"> &nbsp; 
      <input type="reset" name="btnreset" value="�� д" class="button2">
      </td>
    </tr>  
    </form>
  </table>
<!--</div>-->
</body>
</html>
