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
	dim sql,rs,page,totalPageCount,i
	
  if request.Form("selectId")<>"" then
  	 dim selectid
     selectid=request.Form("selectid")
	 sql = "delete * from log where id in ("&selectId&")"
	 conn.execute sql
	 'response.Redirect "adminLog.asp"
  end if	 
 %>

<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="1" class="table_style" >
  <tr>
    <td height="25" colspan="3" align="center" class="table_title">��̨��־����</td> 
  </tr>
  <tr>
    <td width="9%" height="25" align="center"  class="left_title_2">ID</td>
    <td width="86%" align="center"  class="left_title_2">����</td>
    <td align="center">&nbsp;</td>
  </tr>
  <form action="?" name="myform" method="post" onSubmit="return del('selectId');">
<%
   sql = "select * from log order by id desc"
   call pageRs(rs,sql,15,page,totalPageCount)
   if not rs.eof then
	 for i = 1 to rs.pagesize
	   if rs.eof then exit for
	 
%>  

  
  <tr>  
  <td height="25" align="center"><%= rs(0) %></td>
    <td height="25">
<% if rs("errorPwd")<>"" then %>
    &nbsp;<font color="#0000FF">�Ƿ���¼--></font>
	�û�����<font color="#FF0000"><% =rs("username") %></font>&nbsp;&nbsp;
	���룺<font color="#FF0000"><% =rs("errorPwd") %></font>&nbsp;&nbsp;	
	��¼IP��<font color="#FF0000"><% =rs("userIp") %></font>&nbsp;&nbsp;
	��¼���ڣ�<font color="#FF0000"><% =rs("LoginDate") %></font>&nbsp;&nbsp;
	����ϵͳ��<font color="#FF0000"><% =rs("os") %></font>
<% else %>
   	&nbsp;�û�����<% =rs("username") %>&nbsp;&nbsp;
	��¼IP��<% =rs("userIp") %>&nbsp;&nbsp;
	��¼���ڣ�<% =rs("LoginDate") %>&nbsp;&nbsp;
	����ϵͳ��<% =rs("os") %>
<% end if %>	</td>
	
	<td width="5%" align="center"><input type="checkbox" name="selectId" value="<% =rs("id") %>"></td>
  </tr>
<%
  rs.movenext
  next
  else
   response.Write "<tr><td colspan='3' align='center'>���޼�¼!</td></tr>"
 end if

%>  
  <tr bgcolor="#ffffff">
    <td colspan="3" height="25" align="right">ȫѡ&nbsp;
	<input type="checkbox" name="checkAll" onClick="selectAll(this.form);" >&nbsp;
    <input type="submit" name="submit2" value="ɾ ��" class="button2">&nbsp;</td>
  </tr>
</form>    
</table>
<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30" align="center"><% if i>0 then showPage "?" %>
</td>
  </tr>
</table>

</div>
</body>
</html>
