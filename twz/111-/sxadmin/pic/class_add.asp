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
	Const ClassTableName="picClass"
	
	id=request.querystring("id")
	if id="" then  id=0
	checkId(id)
	
	if request.QueryString("action")="add" then	'�������
		'if id="" then id=0
		classNames=htmlencode(request.form("className"))
		power=htmlencode(request.form("power"))
		conn.execute("insert into "&ClassTableName&"(ClassName,ClassPId,power) values('"&ClassNames&"',"&id&","&power&")")
		ok "��ӳɹ�!","class_manage.asp"
	end if
	
	%>
  <table width="99%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
    <form id="form1" name="form1" method="post" action="class_add.asp?action=add&id=<%= id %>" onsubmit="return chkAddClass()">
	<tr>
      <td colspan="2" align="center" class="table_title">������</td>
    </tr>
    <tr>
      <td width="18%" align="right" class="left_title_2">�������ƣ�</td>
      <td width="82%">
     <% 	  
	 if id=0 then
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
      <td align="right" class="left_title_2">�š�����</td>
      <td><input name="power" type="text" id="power" size="8" maxlength="8" value="0" /> ��Ϊ����(Ĭ��ֵΪ0)</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="submit" name="Submit" value="�ύ" /><input type="button" name="Submit" value="����" onclick="location.href='class_manage.asp'" /></td>
    </tr> </form>     
  </table>

</div>
</body>
</html>
