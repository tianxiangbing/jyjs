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
<body>
<% 
if request.querystring("action")="add" then   'ȡ�ύ����������
'ע��ȡ��Ʒ���ݵķ�������Ϊ�Դ�����Զ�����һ��Ҫʹ��ѭ�����������100K�����ݽ�ȡ�������������������Ϊ102399�ֽڣ�100K���ң�
	Dim  sTitle, sContent, proPic, proClass, d_autor, isSuggest, EnproName, Encontent
	proClass = Request.Form("proClass")
	proName = Request.Form("proName")
	EnproName = Request.Form("EnproName")
	power = Request.Form("power")
	proPic = Request.Form("proPic")
	languages = "2"
	isSuggest=request.Form("isSuggest")
	IsNew=request.Form("IsNew")
	
	' ��ʼ��eWebEditor�༭��ȡֵ-----------------
	scontent = ""
	For i = 1 To Request.Form("Content").Count
		scontent = scontent & Request.Form("Content")(i)
	Next
	scontent=getSafeContent(scontent)
	
	Encontent = ""
	For i = 1 To Request.Form("Encontent").Count
		Encontent = Encontent & Request.Form("Encontent")(i)
	Next
	Encontent=getSafeContent(Encontent)
	' ������eWebEditor�༭��ȡֵ-----------------


	' �ϴ��󱣴浽���ط��������ļ���������·�����������"|"�ָ�
	Dim d_savefilename
	' �ϴ��󱣴浽���ط�������·���ļ����������"|"�ָ�
	Dim d_savepathfilename
	d_savefilename=GetSafeStr(Request.Form("d_savefilename"))
	d_savepathfilename=GetSafeStr(Request.Form("d_savepathfilename"))
	
	d_savefilename=CheckSaveFileNamePic(d_savefilename,scontent)	'��Ҫ����༭����ɾ��ͼƬ�󣬱���ͼƬ�ֶεĵ�����
	d_savepathfilename=CheckSaveFileNamePic(d_savepathfilename,scontent)
	
	'sql="insert into products(ProName,EnProName,ClassId,content,Encontent,Power,isSuggest,ProPic,ProSmallPic,d_savefilename,d_savepathfilename) values('"&ProName&"','"&EnProName&"',"&proClass&",'"&scontent&"','"&Encontent&"',"&Power&","&isSuggest&",'"&ProPic&"','"&ProSmallPic&"','"&d_savefilename&"','"&d_savepathfilename&"')"
	'conn.execute(sql)
	'ok "�����ɹ���","add.asp"
	
	'on error resume next
	set rs=server.CreateObject("adodb.recordset")
	sql="select * from Products where 1=0"
	rs.open sql,conn,3,2
	rs.addnew
	rs("ProName") = ProName
	rs("EnProName") = EnProName
	rs("ClassId") = Cint(proClass)
	rs("Content") = scontent
	rs("EnContent") = Encontent
	rs("Power") = Cint(Power)
	
	rs("ProPic") = ProPic
	if len(proPic)>16 then
		rs("ProSmallPic")="upfile/products/"&"small_"&right(proPic,(len(proPic)-16))
		'response.Write("</br>")
		'response.Write(ProSmallPic)
		'response.End()
	end if
	
	rs("languages") = languages
	rs("d_savefilename") = d_savefilename
	rs("d_savepathfilename") = d_savepathfilename
	rs("Addtime") = Now()
	
	if IsNew <> "" then 
		rs("IsNew") = true
	else
		rs("IsNew") = false
	end if 
	
	if IsSuggest <> "" then 
		rs("IsSuggest") = true
	else
		rs("IsSuggest") = false
	end if 
	'rs.update
	if err<>0 then
		erro("���ʧ�ܣ������ֶ�")
    else
		ok "�����ɹ�","add.asp"
	end if 
	rs.close
	set rs=nothing
end if
%>

  <table width="100%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
    <form id="form1" name="form1" method="post" action="../../sxadmin/products/add.asp?action=add" onSubmit="return chkAddPro();">
	<input type="hidden" name="d_savefilename">
    <input type="hidden" name="d_savepathfilename" onChange="doChange(this,document.form1.d_picture)">
	<tr>
      <td colspan="2" class="table_title">������Ʒ</td>
    </tr>
    <tr>
      <td width="15%" align="right" class="left_title_2">��Ʒ���</td>
      <td width="85%">
      <select name="proClass"  style="background-color:#ECF3FF;">
      <option value="">��ѡ�����</option>
     <%  showClass 0,0,0,"proClass"	%>
      </select>	 <span class="red">*</span></td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">���Ĳ�Ʒ���⣺</td>
      <td>
        <input name="proName" type="text" id="proName" size="45" maxlength="100" />
        <span class="red">*</span>
      </td>
    </tr>
    
     <tr >
      <td align="right" class="left_title_2">Ӣ�Ĳ�Ʒ���⣺</td>
      <td>
        <input name="EnproName" type="text" id="EnproName" size="45" maxlength="100" />
        <span class="red">*</span>
      </td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">�š�����</td>
      <td><input name="power" type="text" id="power" value="0" size="6" maxlength="6" /><span class="red">*(���������У�������Խ��Խ��ǰ��)</span></td>
    </tr>
    <tr> 
      <td height="30" align="right" class="left_title_2">��ƷͼƬ��</td>
    <td valign="bottom" bgcolor="#FFFFFF"><input name="proPic" type="text"  id="proPic" value="" size="25" readonly="">
    &nbsp;<iframe src="../inc/sctp.asp?formname=form1&editname=proPic&uppath=upfile/products&filelx=<%= EnableUploadPic %>&enFileSize=<%= EnableUploadPicSize %>" width="320" height="35" frameborder="0" scrolling="no" style="vertical-align:middle" id="uploadFrame" ></iframe><span id="uploadInfo"></span>&nbsp;<font color="#FF0000">ͼƬ��ʽ��<%= EnableUploadPic %> * ͼƬ�ߴ��С��500*500</font></td>
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
	 oFCKeditor.Value = "" '//����Ǹ��༭����ʼֵ 
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
	 oFCKeditor.Value = "" '//����Ǹ��༭����ʼֵ 
	 oFCKeditor.Create "EnContent" '//�Ժ�༭��������ݶ��������logbodyȡ�ã��������㶨
	 %>
      </td>
    </tr>
    <!--<tr>
      <td align="right" class="left_title_2">�Ƿ��Ƽ���</td>
      <td><input name="isSuggest" type="checkbox" id="isSuggest" value="true" >
      <font color="#FF0000">��ѡ������Ϊ�Ƽ�
      <input name="IsNew" type="checkbox" id="IsNew" value="true" />
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
