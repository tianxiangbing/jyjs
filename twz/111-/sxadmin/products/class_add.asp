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
<div id="container">
<%  
	Const ClassTableName="proClass"
	
	id=request.querystring("id")
	if id="" then id=0
	checkId(id)
	
	if request.QueryString("action")="add" then	'�������
		classNames=request.form("className")
		EnclassName=request.form("EnclassName")
		power=htmlencode(request.form("power"))
		proPic = request.Form("proPic")
		conn.execute("insert into "&ClassTableName&"(ClassName,EnclassName,ClassPId,power,proPic) values('"&ClassNames&"','"&EnclassName&"',"&id&","&power&",'"&proPic&"')")
		ok "��ӳɹ�!","class_manage.asp"
	end if
	
	%>
  <table width="99%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
    <form id="form1" name="form1" method="post" action="../../sxadmin/products/class_add.asp?action=add&id=<%= id %>" onsubmit="return chkAddClass()">
	<tr>
      <td colspan="2" align="center" class="table_title">������</td>
    </tr>
    <tr>
      <td width="18%" align="right" class="left_title_2">�������ƣ�</td>
      <td width="82%">
<% 	  if id=0 then
	  	response.write("�����")
	  else
	  	response.write(conn.execute("select ClassName from "&ClassTableName&" where ClassId="&id)(0))
	  end if %>
	  </td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">�������ƣ�</td>
      <td><input name="className" type="text" id="className"  /></td>
    </tr>
	<tr>
      <td align="right" class="left_title_2">Ӣ�����ƣ�</td>
      <td><input name="EnclassName" type="text" id="EnclassName" size="40"  /></td>
    </tr>
     <tr> 
      <td height="30" align="right" class="left_title_2">���ͼƬ</td>
    <td valign="bottom" bgcolor="#FFFFFF"><input name="proPic" type="text"  id="proPic" value="" size="25" readonly="">
    &nbsp;<iframe src="../inc/sctp.asp?formname=form1&editname=proPic&uppath=upfile/products&filelx=<%= EnableUploadPic %>&enFileSize=<%= EnableUploadPicSize %>" width="320" height="35" frameborder="0" scrolling="no" style="vertical-align:middle" id="uploadFrame" ></iframe><span id="uploadInfo"></span>&nbsp;<BR /><font color="#FF0000">ͼƬ��ʽ��<%= EnableUploadPic %> * ͼƬ��С��241*194</font>(������Ŀ���ͼƬ��һ����Ŀ����)</td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">�š�����</td>
      <td><input name="power" type="text" id="power" size="8" maxlength="8" value="0" /> <span class="red">*��Ϊ����(Ĭ��ֵΪ0�����������У�������Խ��Խ��ǰ��)</span></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="submit" name="Submit" value="�ύ" />	<input type="button" name="Submit" value="����" onclick="location.href='class_manage.asp'" /></td>
    </tr> </form>     
  </table>

</div>
</body>
</html>
