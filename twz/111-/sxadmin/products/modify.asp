<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��̨����</title>
<link rel="stylesheet" href="../css/common.css" type="text/css" />
<!--#include file="../inc/subCode.asp"-->
<!--#include file="../fckeditor/fckeditor.asp" -->
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
<%
 id=request.QueryString("id")
 checkId(id)
 page=request.QueryString("page")
 if request.querystring("action")="edit" then' ȡ�ύ����������
 
'ע��ȡ��Ʒ���ݵķ�������Ϊ�Դ�����Զ�����һ��Ҫʹ��ѭ�����������100K�����ݽ�ȡ�������������������Ϊ102399�ֽڣ�100K���ң�
	Dim  sContent, proPic, proClass, isSuggest, IsNew, EnProName, proName, power
	proClass = Request.Form("proClass")
	proName = Request.Form("proName")
	EnProName = Request.Form("EnProName")
	power = Request.Form("power")
	languages = "2"
	proPic = Request.Form("proPic")
	if len(proPic)>16 then
		ProSmallPic="upfile/products/"&"small_"&right(proPic,(len(proPic)-16))
	end if
	isSuggest=request.Form("isSuggest")
	if isSuggest="" then isSuggest=false end if
	IsNew=request.Form("IsNew")
	if IsNew="" then IsNew=false end if
	if proClass="" then proClass=0 end if

	
	' ��ʼ��eWebEditor�༭��ȡֵ-----------------
	scontent = ""
	For i = 1 To Request.Form("content").Count
		scontent = scontent & Request.Form("content")(i)
	Next
	scontent=getSafeContent(scontent)
	
	EnContent = ""
	For i = 1 To Request.Form("EnContent").Count
		EnContent = EnContent & Request.Form("EnContent")(i)
	Next
	EnContent=getSafeContent(EnContent)
	' ������eWebEditor�༭��ȡֵ-----------------

	' �ϴ��󱣴浽���ط��������ļ���������·�����������"|"�ָ�
	Dim sSaveFileName,sSavePathFileName
	' �ϴ��󱣴浽���ط�������·���ļ����������"|"�ָ�
	SaveFileName = GetSafeStr(Request.Form("d_savefilename"))
	SavePathFileName = GetSafeStr(Request.Form("d_savepathfilename"))
	
	SaveFileName=CheckSaveFileNamePic(SaveFileName,scontent)	'��Ҫ����༭����ɾ��ͼƬ�󣬱���ͼƬ�ֶεĵ�����
	SavePathFileName=CheckSaveFileNamePic(SavePathFileName,scontent)
	
	on error resume next
	sql="update products set ProName='"&ProName&"',ClassId="&proClass&",content='"&scontent&"',Power="&Power&",isSuggest="&isSuggest&",editTime=now(),proPic='"&proPic&"',ProSmallPic='"&ProSmallPic&"',d_savefilename='"&SaveFileName&"',d_savepathfilename='"&SavePathFileName&"',languages='"&languages&"',EnProName='"&EnProName&"',EnContent='"&EnContent&"',IsNew="&IsNew&" where id="&id
	conn.execute(sql)
	ok "�޸ĳɹ���","manage.asp?page="&page
end if 

set rs=conn.execute("select * from products where id="&id)
if rs.eof then
	erro "��ЧID"
end if
%>
<body>
  <table width="100%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
  <form id="form1" name="form1" method="post" action="../../sxadmin/products/modify.asp?action=edit&page=<%= page %>&id=<%= rs(0) %>" onSubmit="return chkAddPro();">
	<input type="hidden" name="d_savefilename" value="<%= rs("d_savefilename") %>">
    <input type="hidden" name="d_savepathfilename" value="<%= rs("d_savepathfilename") %>" onChange="doChange(this,document.form1.newsPic)">
	<tr>
      <td colspan="2" class="table_title">�޸Ĳ�Ʒ</td>
    </tr>
    <tr>
      <td width="15%" align="right" class="left_title_2">��Ʒ���</td>
      <td width="85%"><select name="proClass" id="proClass"  style="background-color:#ECF3FF;">
     <%  showClass 0,0,rs("ClassId"),"proClass"	%>
      </select>	 <span class="red">*(���������У�������Խ��Խ��ǰ��)</span></td>
    </tr>
    <tr>
      <td align="right" class="left_title_2"> ���Ĳ�Ʒ���⣺</td>
      <td>
        <input name="proName" type="text" id="proName" size="45" maxlength="100" value="<%= rs("proName") %>" />
        <span class="red">*</span>      </td>
    </tr>
      <tr>
      <td align="right" class="left_title_2">Ӣ�Ĳ�Ʒ���⣺</td>
      <td>
        <input name="EnProName" type="text" id="EnProName" size="45" maxlength="100" value="<%= rs("EnProName") %>" />
        <span class="red">*</span>      </td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">�š�����</td>
      <td><input name="power" type="text" id="power" size="6" maxlength="6" value="<%= rs("power") %>" /><span class="red">*</span></td>
    </tr>
    <tr> 
      <td height="30" align="right" class="left_title_2">��ƷͼƬ��</td>
    <td valign="bottom" bgcolor="#FFFFFF"><input name="proPic" type="text"  id="proPic" value="<%= rs("proPic") %>" size="25" readonly="">
    &nbsp;<iframe src="../inc/sctp.asp?formname=form1&editname=proPic&uppath=upfile/products&filelx=<%= EnableUploadPic %>&enFileSize=<%= EnableUploadPicSize %>" width="320" height="35" frameborder="0" scrolling="no" style="vertical-align:middle"  id="uploadFrame" ></iframe><span id="uploadInfo"></span>&nbsp;<font color="#FF0000">ͼƬ��ʽ��<%=EnableUploadPic%> *ͼƬ�ߴ��С��500*500</font></td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">���Ĳ�Ʒ���ݣ�</td>
      <td>
      <%
	  Set oFCKeditor = New FCKeditor 
	  oFCKeditor.BasePath = "../FCKeditor/"  '����·�������ⲻҪ�Ķ���
	 ' //���ñ༭����·������վ���Ŀ¼�µ�һ��Ŀ¼ 
	 oFCKeditor.ToolbarSet = "Default"   '�����ļ��ֹ���������Default,base,����   										                                          fckconfig.js�����趨.   
	 oFCKeditor.Width = "100%" '�����趨���,���԰� % ��ֵ��ѡ��.   
	 oFCKeditor.Height = "400" 
	 oFCKeditor.Value = rs("Content") '//����Ǹ��༭����ʼֵ 
	 oFCKeditor.Create "Content" '//�Ժ�༭��������ݶ��������logbodyȡ�ã��������㶨
	 %>
      </td>
    </tr>
     <tr>
      <td align="right" class="left_title_2">Ӣ�Ĳ�Ʒ���ݣ�</td>
      <td>
      <%
	  Set oFCKeditor = New FCKeditor 
	  oFCKeditor.BasePath = "../FCKeditor/"  '����·�������ⲻҪ�Ķ���
	 ' //���ñ༭����·������վ���Ŀ¼�µ�һ��Ŀ¼ 
	 oFCKeditor.ToolbarSet = "Default"   '�����ļ��ֹ���������Default,base,����   										                                          fckconfig.js�����趨.   
	 oFCKeditor.Width = "100%" '�����趨���,���԰� % ��ֵ��ѡ��.   
	 oFCKeditor.Height = "400" 
	 oFCKeditor.Value = rs("EnContent") '//����Ǹ��༭����ʼֵ 
	 oFCKeditor.Create "EnContent" '//�Ժ�༭��������ݶ��������logbodyȡ�ã��������㶨
	 %>
      </td>
    </tr>
   <!-- <tr>
      <td align="right" class="left_title_2">�Ƿ��Ƽ���</td>
      <td><input name="isSuggest" type="checkbox" id="isSuggest" value="true" <% 'if rs("isSuggest")=true then response.Write("checked='checked'") end if  %> >
      <font color="#FF0000">��ѡ������Ϊ��Ʒ�Ƽ�
      <input name="IsNew" type="checkbox" id="IsNew" value="true" <%' if rs("IsNew")=true then response.Write("checked='checked'") end if  %> />
      <font color="#FF0000">��ѡ������Ϊ���²�Ʒ</font></font></td>
    </tr>-->
    
    <tr bgcolor="#FFFFFF">
      <td class="left_title_2">&nbsp;</td>
      <td><input type="submit" name="btnsubmit" value="�� ��" class="button2"> &nbsp; 
      <input type="reset" name="btnreset" value="�� д" class="button2"></td>
    </tr>  </form>
  </table>
<!--</div>-->
</body>
</html>
