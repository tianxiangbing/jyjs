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
<%

 id=request.QueryString("id")
 checkId(id)

 if request.querystring("action")="edit" then' ȡ�ύ����������
	
	voteTitle = trim(replace(Request.Form("voteTitle"),"'",""))
	voteNum = trim(replace(Request.Form("voteNum"),"'",""))
	power = trim(replace(Request.Form("power"),"'",""))
	

	
	sql="update vote set voteTitle='"&voteTitle&"',voteNum='"&voteNum&"',power='"&power&"' where id="&id
	'response.write sql
	'response.end
	conn.execute(sql)
	
	ok "�޸ĳɹ���","manage.asp"
end if


set rs=conn.execute("select * from vote where id="&id)
if rs.eof then
	erro "��ЧID"
end if



 %>

  <table width="100%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
    <form id="form1" name="form1" method="post" action="../../sxadmin/vote/modify.asp?action=edit&id=<%= id %>" onSubmit="return chkAddTP();">
	<tr>
      <td colspan="2" class="table_title">�޸�ͶƱ</td>
    </tr>
    
    <tr>
      <td align="right" class="left_title_2">ͶƱ���⣺</td>
      <td><%= conn.execute("select ClassName from voteClass")(0) %> </td>
    </tr>
    
    <tr> 
      <td height="30" align="right"  class="left_title_2">ͶƱ���ƣ�</td>
      <td bgcolor="#FFFFFF"><input name="voteTitle" type="text"  id="voteTitle" value="<%= rs("voteTitle") %>" size="40">��
      <font color="#FF0000">*</font></td>
    </tr>
	<tr> 
      <td height="30" align="right"  class="left_title_2">Ʊ��������</td>
      <td><input name="voteNum" type="text"  id="voteNum" value="<%= rs("voteNum") %>" size="5">��
      <font color="#FF0000">*</font></td>
    </tr>
	<tr>
      <td align="right" class="left_title_2">�š�����</td>
      <td><input name="power" type="text" id="power" value="<%= rs("power") %>" size="6" maxlength="6" /> <span class="red">*</span> Ĭ��Ϊ0��ҪΪ����</td>
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
