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
  <table width="99%" border="0" align="center"  cellpadding="3" cellspacing="1">
    <tr>
      <td><strong><a href="managerOperate.asp">��ӹ���Ա</a></strong></td>
    </tr>
  </table>
</p>
  <table width="99%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
    <tr>
      <td colspan="8" align="center" class="table_title">������˺�</td>
    </tr>
    <tr class="left_title_2">
      <td width="11%" align="center">����Ա����</td>
      <td width="14%" align="center">��ɫ</td>
      <td width="8%" align="center">��½����</td>
      <td width="19%" align="center">�ϴε�½</td>
      <td width="15%" align="center">�ϴε�½IP</td>
      <td width="19%" align="center">���ʱ��</td>
      <td colspan="2" align="center">����</td>
    </tr>
<%
	dim sql,rs,totalPageCount,i
	if request.queryString("action")="del" then
		num=conn.execute("select count(*) from psadmin")(0)
		if num>1 then
			conn.execute("delete from psadmin where id="&request.querystring("id"))
		else
			erro "����Ա����Ҫ��һλ!"
		end if
	end if
	
	
	sql="select * from psadmin order by addtime desc"
	call pageRs(rs,sql,20,page,totalPageCount)
	if not rs.eof then
		for i=1 to rs.pageSize
		  if rs.eof then exit for 
		
	 %>
		<tr>
		  <td align="center" ><%= rs("username") %></td>
		  <td align="center" ><%= conn.execute("select username from power where id="&rs("power"))(0) %></td>
		  <td align="center" ><%= rs("loginTime") %></td>
		  <td align="center" ><%= rs("lastLoginDate") %></td>
		  <td align="center" ><%= rs("lastLoginIp") %></td>
		  <td align="center" ><%= rs("addtime") %></td>
		  <td width="7%" align="center" ><a href="managerOperate.asp?action=edit&id=<%= rs(0) %>"><img src="../images/button_edit.gif" alt="�༭" width="42" height="17" /></a></td>
		  <td width="7%" align="center" ><a href="?action=del&id=<%= rs(0) %>" onclick="return confirm('ȷ��ɾ����');"><img src="../images/button_del.gif" alt="ɾ��" width="42" height="17" border="0" /></a></td>
		</tr>
    <% 
		rs.movenext
		next
	else
		response.Write("����!�޹���Ա,����ϵ��������ӡ�")
	end if %>
  </table>
  
  <table width="99%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30" align="center"><% showPage "?" %></td>
  </tr>
  </table>
</div>
</body>
</html>
