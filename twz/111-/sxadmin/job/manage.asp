<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��̨����</title>
<script type="text/javascript" src="../js/checkForm.js"></script>
<link rel="stylesheet" href="../css/common.css" type="text/css" />
</head>
<!--#include file="../inc/subCode.asp"-->
<body>
<div id="container">
  
<% 
	 if request.Form("selectId")<>"" then
		  selectid=request.Form("selectid")
		  sql = "delete * from job where id in ("&selectId&")"
	 	  conn.execute sql
	end if	
	
	sql = "SELECT * FROM job order by addtime desc "
	call pageRs(rs,sql,20,page,totalPageCount)	
		  
	 %>
<table width="99%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
  <tr>
    <td colspan="8" class="table_title">��Ƹ�б�</td>
  </tr>
  <form action="../../sxadmin/job/manage.asp?" method="post" name="myform" onsubmit="return del('selectId');">
    <tr>
      <td width="6%" align="center" class="left_title_2">ѡ��</td>
      <td width="24%" align="center" class="left_title_2">��Ƹ��λ</td>
      <td width="14%" align="center" class="left_title_2">����</td>
      <td width="16%" align="center" class="left_title_2">��Ƹ����</td>
      <td width="12%" align="center" class="left_title_2">��ֹʱ��</td>
      <td width="9%" align="center" class="left_title_2">����</td>
      <td width="10%" align="center" class="left_title_2">����ʱ��</td>
      <td width="9%" align="center" class="left_title_2">����</td>
    </tr>
    <% 

	if not rs.eof then
		for i=1 to rs.pageSize
		  if rs.eof then exit for %>
    <tr align="center">
      <td><input type="checkbox" name="selectId" value="<% =rs(0) %>" /></td>
      <td><%= rs("jobName") %></td>
      <td><%= GetLanguage(rs("languages")) %></td>
      <td><%= rs("jobNum") %></td>
      <td><%= rs("EndTime") %></td>
      <td><%= rs("power")  %></td>
      <td><%= FormatDatetime(rs("addtime"),2)  %></td>
      <td><a href="modify.asp?id=<% =rs(0) %>">�޸�</a></td>
    </tr>
    <% 
		rs.movenext
		next
		 %>
    <tr bgcolor="#FFFFFF">
      <td colspan="8">&nbsp;
        <input type="checkbox" name="checkAll" onclick="selectAll(this.form);" />
        &nbsp;ȫѡ&nbsp;
        <input type="submit" name="submit2" value="ɾ��"  class="button2" />
        &nbsp;&nbsp; </td>
    </tr>
  </form>
  <% 
	else
		response.write("<tr bgcolor='#FFFFFF'><td colspan='7' align='center'>��������</td></tr>")
	end if %>
</table>
<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
     <td height="30" align="center"><% if i>0 then showPage "?" %></td>
   </tr>
  </table>
</div>
</body>
</html>
