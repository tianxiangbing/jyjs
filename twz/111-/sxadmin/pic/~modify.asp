<!--#include file="../inc/subCode.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��̨����</title>
<link rel="stylesheet" href="../css/common.css" type="text/css" />
<script type="text/javascript" src="../js/checkForm.js"></script>
</head>
<body>
<!--<div id="container">-->
<!--#include file="../fckeditor/fckeditor.asp" -->
<%
 'call PowerDetailInfo(0,3,3,0) '�ж�Ȩ��

 id=request.QueryString("id")
 checkId(id)
 page=request.QueryString("page")

 if request.querystring("action")="edit" then' ȡ�ύ����������
	' ע��ȡ�������ݵķ�������Ϊ�Դ�����Զ�����һ��Ҫʹ��ѭ�����������100K�����ݽ�ȡ�������������������Ϊ102399�ֽڣ�100K���ң�
	Dim  sTitle, sContent, sPicture,class_news,d_autor,isSuggest
	
	title = Request.Form("title")
	Entitle = Request.Form("Entitle")
	newsClass = Request.Form("newsClass")
	power = Request.Form("power")
	newsPic = Request.Form("newsPic")
	isSuggest=request.Form("isSuggest")
	if isSuggest="" then isSuggest=false
	if newsClass="" then newsClass=0

	' ��ʼ��eWebEditor�༭��ȡֵ-----------------
	scontent = ""
	For i = 1 To Request.Form("content").Count
		scontent = scontent & Request.Form("content")(i)
	Next
	scontent=getSafeContent(scontent)
	
	Encontent = ""
	For i = 1 To Request.Form("Encontent").Count
		Enscontent = Encontent & Request.Form("Encontent")(i)
	Next
	Encontent=getSafeContent(Enscontent)
	' ������eWebEditor�༭��ȡֵ-----------------

	' ����Ϊ����ͨ���༭���ϴ��������ļ������Ϣ�������༭���ֶ��ϴ��ĺ��Զ�Զ���ϴ���
	' GetSafeStr����Ϊ����һЩ�����ַ���
	
	' �ϴ��󱣴浽���ط��������ļ���������·�����������"|"�ָ�
	Dim sSaveFileName,sSavePathFileName
	' �ϴ��󱣴浽���ط�������·���ļ����������"|"�ָ�
	SaveFileName = GetSafeStr(Request.Form("d_savefilename"))
	SavePathFileName = GetSafeStr(Request.Form("d_savepathfilename"))
	
	SaveFileName=CheckSaveFileNamePic(SaveFileName,scontent)	'��Ҫ����༭����ɾ��ͼƬ�󣬱���ͼƬ�ֶεĵ�����
	SavePathFileName=CheckSaveFileNamePic(SavePathFileName,scontent)
 
	sql="update [pic] set title='"&title&"',Entitle='"&Entitle&"',ClassId="&newsClass&",content='"&scontent&"','"&Encontent&"',Power="&Power&",isSuggest="&isSuggest&",editTime=now(),newsPic='"&newsPic&"',d_savefilename='"&SaveFileName&"',d_savepathfilename='"&SavePathFileName&"' where id="&id
	conn.execute(sql)
	
	
	ok "�޸ĳɹ���","manage.asp?page="&page&"&newsClass_type="&newsClass&""
end if

set rs=conn.execute("select * from [pic] where id="&id)
if rs.eof then
	erro "��ЧID"
end if

		sPicture = rs("newsPic")
		sSaveFileName = rs("d_savefilename")
		sSavePathFileName = rs("d_savepathfilename")

' �Ѵ�"|"���ַ���תΪ���飬���ڳ�ʼ�������

		Dim aSavePathFileName
		aSavePathFileName = Split(rs("d_savepathfilename"), "|")

	' ������������������ϴ��ļ�Ϊ���ݣ���ʼ�������
	' ����InitSelect����������ֵ����ʼֵ��������������ִ����������startup.asp�ļ��к�����˵������
		Dim sOptionSavePath
		sOptionSavePath = InitSelect("newsPic", aSavePathFileName, aSavePathFileName, sPicture, "", "��")
%>

  <table width="100%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
    <form id="form1" name="form1" method="post" action="modify.asp?action=edit&page=<%= page %>&amp;id=<%= rs(0) %>" onSubmit="return chkNews();">
	<input type="hidden" name="d_savefilename" value="<%= rs("d_savefilename") %>">
    <input type="hidden" name="d_savepathfilename" value="<%= rs("d_savepathfilename") %>" onChange="doChange(this,document.form1.newsPic)">
	<tr>
      <td colspan="2" class="table_title">�޸�ͼƬ</td>
    </tr>
   <!-- <tr>
      <td width="15%" align="right" class="left_title_2">��Ϣ���</td>
      <td width="85%">
	  <select name="newsClass"  style="background-color:#ECF3FF;">
     <%  'showClass 0,0,rs("ClassId"),"picClass"	%>
      </select>	 <span class="red">*</span></td>
    </tr>-->
    <tr>
      <td align="right" class="left_title_2">������Ϣ���⣺</td>
      <td>
        <input name="title" type="text" id="title" size="45" maxlength="100" value="<%= rs("title") %>" /><span class="red">*</span>
      </td>
    </tr>
     <tr>
      <td align="right" class="left_title_2">Ӣ����Ϣ���⣺</td>
      <td>
        <input name="Entitle" type="text" id="Entitle" size="45" maxlength="100" value="<%= rs("Entitle") %>" /><span class="red">*</span>      </td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">�š�����</td>
      <td><input name="power" type="text" id="power" size="6" maxlength="6" value="<%= rs("power") %>" /><span class="red">*(���������У�������Խ���Խ��ǰ��)</span></td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">�ϴ�ͼƬ��</td>
      <td><input name="newsPic" type="text"  id="newsPic" value="<%=rs("newsPic")%>" size="25" readonly="" />
&nbsp;
<iframe src="../inc/sctp.asp?formname=form1&editname=newsPic&amp;uppath=upfile/pic&filelx=<%= EnableUploadPic %>&amp;enFileSize=<%= EnableUploadPicSize %>" width="320" height="35" frameborder="0" scrolling="No" style="vertical-align:middle" id="uploadFrame" ></iframe>
<span id="uploadInfo"></span><% if rs("newsPic")<> "" then %><a href="../../<%=rs("newsPic")%>" target="_blank"><img src="../../<%=rs("newsPic")%>" style="max-width:100px;border:1px solid #eee;" height="50" /></a><% end if %><bR /><font color="#FF0000">ͼƬ��ʽ��<%= EnableUploadPic %> * ͼƬ�ߴ��С��300*180</font></td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">��Ϣ���ݣ�</td>
      <td>
       <%
	  Set oFCKeditor = New FCKeditor 
	  oFCKeditor.BasePath = "../FCKeditor/"  '����·�������ⲻҪ�Ķ���
	 ' //���ñ༭����·������վ���Ŀ¼�µ�һ��Ŀ¼ 
	 oFCKeditor.ToolbarSet = "Default"   '�����ļ��ֹ���������Default,base,����   										                                          fckconfig.js�����趨.   
	 oFCKeditor.Width = "100%" '�����趨���,���԰� % ��ֵ��ѡ��.   
	 oFCKeditor.Height = "400" 
	 oFCKeditor.Value = rs("content") '//����Ǹ��༭����ʼֵ 
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
	  '���ñ༭����·������վ���Ŀ¼�µ�һ��Ŀ¼ 
	 oFCKeditor.ToolbarSet = "Default"   '�����ļ��ֹ���������Default,base,����   										                                          fckconfig.js�����趨.   
	 oFCKeditor.Width = "100%"    '�����趨���,���԰� % ��ֵ��ѡ��.   
	 oFCKeditor.Height = "400" 
	 oFCKeditor.Value = rs("Encontent") '//����Ǹ��༭����ʼֵ 
	 oFCKeditor.Create "Encontent"  '//�Ժ�༭��������ݶ��������logbodyȡ�ã��������㶨
	 %>      </td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td class="left_title_2">&nbsp;</td>
      <td><input type="submit" name="btnsubmit" value="�� ��" class="button2"> &nbsp; 
      <input type="reset" name="btnreset" value="�� д" class="button2"></td>
    </tr>  </form>
  </table>
<!--</div>-->
</body>
</html>
