<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��̨����</title>
<link rel="stylesheet" href="../css/common.css" type="text/css" />
<!--#include file="../inc/subCode.asp"-->
<!--#include file="../fckeditor/fckeditor.asp" -->
<script type="text/javascript" src="../js/checkForm.js"></script>
<script type="text/javascript" >
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
<%
 'call PowerDetailInfo(0,3,3,0) '�ж�Ȩ��

 id=request.QueryString("id")
 checkId(id)
 page=request.QueryString("page")

 if request.querystring("action")="edit" then   'ȡ�ύ����������
 
'ע��ȡ�������ݵķ�������Ϊ�Դ�����Զ�����һ��Ҫʹ��ѭ�����������100K�����ݽ�ȡ�������������������Ϊ102399�ֽڣ�100K���ң�
	Dim  sTitle, Entitle, sContent, sPicture,class_news,d_autor,isSuggest
	
	title = Request.Form("title")
	Entitle = Request.Form("Entitle")
	newsClass = Request.Form("newsClass")
	power = Request.Form("power")
	newsPic = Request.Form("newsPic")
	languages = "2"
	isSuggest=request.Form("isSuggest")
	if isSuggest="" then isSuggest=false end if 
	if newsClass="" then newsClass=0  end if
	
	' =============��ʼ��eWebEditor�༭��ȡֵ===============
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
'	response.Write(scontent)
'	response.Write("<br/>")
'	response.Write(Encontent)
'	response.End()
	' =============������eWebEditor�༭��ȡֵ==========
	

	' ����Ϊ����ͨ���༭���ϴ��������ļ������Ϣ�������༭���ֶ��ϴ��ĺ��Զ�Զ���ϴ���
	' GetSafeStr����Ϊ����һЩ�����ַ���
	
	' �ϴ��󱣴浽���ط��������ļ���������·�����������"|"�ָ�
	Dim sSaveFileName,sSavePathFileName
	' �ϴ��󱣴浽���ط�������·���ļ����������"|"�ָ�
	SaveFileName = GetSafeStr(Request.Form("d_savefilename"))
	SavePathFileName = GetSafeStr(Request.Form("d_savepathfilename"))
	
	SaveFileName=CheckSaveFileNamePic(SaveFileName,scontent)	'��Ҫ����༭����ɾ��ͼƬ�󣬱���ͼƬ�ֶεĵ�����
	SavePathFileName=CheckSaveFileNamePic(SavePathFileName,scontent)
	
	
	
	' �ϴ��󱣴浽���ط��������ļ���������·�����������"|"�ָ�
	'Dim sSaveFileName
	' �ϴ��󱣴浽���ط�������·���ļ����������"|"�ָ�
	'Dim sSavePathFileName
	SaveFileName = GetSafeStr(Request.Form("d_savefilename"))
	SavePathFileName = GetSafeStr(Request.Form("d_savepathfilename"))
  if SavePathFileName<>"" then
    if Instr(SavePathFileName,"|")>0 then
    aSavePathFileName = Split(SavePathFileName,"|")
	  for i=0 to ubound(aSavePathFileName)
	     if Instr(scontent,aSavePathFileName(i))=0 then
		 aSavePathFileName(i) = ""
		 end if
      next
	  for i=0 to ubound(aSavePathFileName)
		 sSavePathFileName = sSavePathFileName&"|"&aSavePathFileName(i)
      next
	if instr(sSavePathFileName,"||")>0 then sSavePathFileName = trim(replace(sSavePathFileName,"||","|"))
	if left(sSavePathFileName,1) = "|" then sSavePathFileName = right(sSavePathFileName,(len(sSavePathFileName)-1))
	 ' response.write sSavePathFileName
	 ' response.end
    else
    sSavePathFileName = SavePathFileName
	end if
  else
  sSavePathFileName=""
  end if

  if SaveFileName<>"" then
    if Instr(SaveFileName,"|")>0 then
   
    aSaveFileName = Split(SaveFileName,"|")
	  for i=0 to ubound(aSaveFileName)
	     if Instr(scontent,aSaveFileName(i))=0 then
		 aSaveFileName(i) = ""
		 end if
      next
	  for i=0 to ubound(aSaveFileName)
		 sSaveFileName = sSaveFileName&"|"&aSaveFileName(i)
      next
	if instr(sSaveFileName,"||")>0 then sSaveFileName = trim(replace(sSaveFileName,"||","|"))
	if left(sSaveFileName,1) = "|" then sSaveFileName = right(sSaveFileName,(len(sSaveFileName)-1))
	 ' response.write sSaveFileName
	 ' response.end
    else
    sSaveFileName = SaveFileName
	end if
  else
  sSaveFileName=""
  end if
  
    on error resume next
	sql="update news set title='"&title&"',Entitle='"&Entitle&"',ClassId="&newsClass&",content='"&scontent&"',Encontent='"&Encontent&"',Power="&Power&",isSuggest="&isSuggest&",editTime=now(),newsPic='"&newsPic&"',d_savefilename='"&SaveFileName&"',d_savepathfilename='"&SavePathFileName&"',languages='"&languages&"' where id="&id
	'response.write sql
'	response.end
	conn.execute(sql)
	
	ok "�޸ĳɹ���","manage.asp?page="&page
end if

'�����ǰ��ֵ
sql="select * from news where id="&id
'response.Write(sql)
'response.End()
set rs=conn.execute(sql)
if rs.eof then
	erro "��ЧID"
end if
	sPicture = rs("newsPic")
	sSaveFileName = rs("d_savefilename")
	sSavePathFileName = rs("d_savepathfilename")
	intLan = rs("Languages")
' �Ѵ�"|"���ַ���תΪ���飬���ڳ�ʼ�������
		'Dim aSavePathFileName
'		aSavePathFileName = Split(rs("d_savepathfilename"), "|")
	
	' ������������������ϴ��ļ�Ϊ���ݣ���ʼ�������
	' ����InitSelect����������ֵ����ʼֵ��������������ִ����������startup.asp�ļ��к�����˵������
		'Dim sOptionSavePath
'		sOptionSavePath = InitSelect("newsPic", aSavePathFileName, aSavePathFileName, sPicture, "", "��")

%>
<body>
<!--<div id="container">-->
<table width="100%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
    <form id="form1" name="form1" method="post" action="../../sxadmin/news/modify.asp?action=edit&page=<%= page %>&id=<%= rs(0) %>" onSubmit="return chkNews();">
	<input type="hidden" name="d_savefilename" value="<%= rs("d_savefilename") %>">
    <input type="hidden" name="d_savepathfilename" value="<%= rs("d_savepathfilename") %>" onChange="doChange(this,document.form1.newsPic)">
	<tr>
      <td colspan="2" class="table_title">�޸�����</td>
    </tr>
    <tr>
      <td width="15%" align="right" class="left_title_2">�������</td>
      <td width="85%">
	  <select name="newsClass"  style="background-color:#ECF3FF;">
     <%  showClass 0,0,rs("ClassId"),"newsClass"	%>
      </select>	 <span class="red">*</span></td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">�������ű��⣺</td>
      <td>
        <input name="title" type="text" id="title" size="45" maxlength="100" value="<%= rs("title") %>" /><span class="red">*</span>      </td>
    </tr>
     <tr>
      <td align="right" class="left_title_2">Ӣ�����ű��⣺</td>
      <td>
        <input name="Entitle" type="text" id="Entitle" size="45" maxlength="100" value="<%= rs("Entitle") %>" /><span class="red">*</span>      </td>
    </tr>
    
    
    <tr>
      <td align="right" class="left_title_2">�š�����</td>
      <td><input name="power" type="text" id="power" size="6" maxlength="6" value="<%= rs("power") %>" /><span class="red">*(���������У�������Խ��Խ��ǰ��)</span></td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">ͼƬ�ϴ���</td>
      <td><input name="newsPic" type="text"  id="newsPic" value="<%=rs("newsPic")%>" size="25" readonly="" />
&nbsp;
<iframe src="../inc/sctp.asp?formname=form1&amp;editname=newsPic&amp;uppath=upfile/news&amp;filelx=<%= EnableUploadPic %>&amp;enFileSize=<%= EnableUploadPicSize %>" width="320" height="35" frameborder="0" scrolling="No" style="vertical-align:middle" id="uploadFrame" ></iframe>
<span id="uploadInfo"></span>&nbsp;<font color="#FF0000">ͼƬ��ʽ��<%= EnableUploadPic %> *</font></td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">�����������ݣ�</td>
      <td>
	  <%
	 'Dim oFCKeditor
		Set oFCKeditor = New FCKeditor
		oFCKeditor.BasePath = "../FCKeditor/" '���ñ༭����·������վ���Ŀ¼�µ�һ��Ŀ¼
		oFCKeditor.ToolbarSet = "Default"
		oFCKeditor.Width = "100%"
		oFCKeditor.Height = "400"
		
		oFCKeditor.Value = rs("content") '����Ǹ��༭����ʼֵ
		oFCKeditor.Create "content" '�Ժ�༭��������ݶ��������logbodyȡ�ã��������㶨	
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
    
   <!-- <tr>
      <td align="right" class="left_title_2">�Ƿ��Ƽ���</td>
      <td>
      <input name="isSuggest" type="checkbox" id="isSuggest" value="true" <%' if rs("isSuggest")=true then response.Write("checked='checked'") %> >
      <font color="#FF0000">��ѡ������Ϊ�Ƽ�</font>      </td>
    </tr>-->
    
    <tr bgcolor="#FFFFFF">
      <td class="left_title_2">&nbsp;</td>
      <td>
      <input type="submit" name="btnsubmit" value="�� ��" class="button2"> &nbsp; 
      <input type="reset" name="btnreset" value="�� д" class="button2">      </td>
    </tr> 
    </form>
  </table>
<!--</div>-->
</body>
</html>
