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
  if request.Form("selectId")<>"" then  'ɾ������
     selectid=request.Form("selectid")
	 sql = "delete * from message where id in ("&selectId&")"
	 conn.execute sql
	 'response.Redirect "adminLog.asp"
  end if
  
  if request.querystring("action")<>"" then 
  	id=request.QueryString("id")
    select case request.querystring("action") '��˲���
	 	case "check"
			sql = "update [message] set [check]=1 where id = "&id
		case "cancelCheck"
			sql = "update [message] set [check]=0 where id = "&id
		case else
			'response.Redirect "MessageManage.asp"	
	end select
	conn.execute(sql) 
	 
	response.Redirect "manage.asp"	 
  end if 
 %>

<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="1" class="table_style" >
  <tr>
    <td height="25" colspan="9" align="center" class="table_title">�ͻ������б�</td> 
  </tr>
  <tr>  
    <td width="11%" height="12" align="center">������</td>
	<td width="14%" align="center">�绰</td>
	<td width="17%" align="center">E-mail</td>
	<td width="13%" align="center">�ֻ�</td>
	<td width="13%" align="center">����ʱ��</td>
	<td width="6%" align="center">���</td>
	<td width="14%" align="center">����/�޸Ļظ�</td>
	<td width="6%" align="center">��ϸ</td>
	<td width="6%" align="center">ѡ��</td>
  </tr>  
  <form action="../../sxadmin/message/manage.asp?" name="myform" method="post" onSubmit="return del('selectId');">
<%
 
  sql = "select * from message order by id desc"
  call pageRs(rs,sql,20,page,totalPageCount)
 
  if not rs.eof then
	for i = 1 to rs.pagesize
	   if rs.eof then exit for
	 
%>  

  
  <tr align="center">
    <td height="12"><%= rs("username")%></td>
    <td height="12"><%= rs("tel")%></td>
    <td height="12"><%= rs("email")%></td>
    <td height="12"><%= rs("cellphone")%></td>
    <td><%= FormatDatetime(rs("addtime"),2)%></td>
    <td><% 
	 select case rs("check")
	  	case 0
			response.Write("<a href='?id="&rs(0)&"&action=check'><font color='red'>ĩ���</font></a>")
		case 1
			response.Write("<a href='?id="&rs(0)&"&action=cancelCheck'>�����</a>")
		case else
			response.Write("δ֪")
	  end select %></td>
    <td height="12"><a href="backContent.asp?id=<%= rs("id") %>">�ظ�</a>
      <% if rs("backcontent")<>"" then response.write("[�ѻظ�]") %></td>
    <td height="12" style="CURSOR: hand" onClick="show(<%= "a"&i %>);">��ʾ</td>
    <td width="6%"><input type="checkbox" name="selectId" value="<% =rs("id") %>" /></td>
  </tr>
  <tr id="<%= "a"&i %>" style="display:none">
	  <td colspan="9">
	      <table width="98%" border="0" align="center" cellpadding="2" cellspacing="1" class="table_style">
            <tr>
              <td width="479" height="20" bgcolor="#FFFFFF">���棺 <% =rs("Fax")%></td>
              <td width="637"></td>
            </tr>
			<tr>
              <td width="479" height="20" bgcolor="#FFFFFF">��˾���ƣ� <% =rs("company")%></td>
              <td width="637"></td>
            </tr>
            <tr>
              <td height="25" colspan="2" >��ϵ��ַ��<%=rs("address")%></td>
            </tr>
            <tr>
              <td height="25" colspan="2" >�ʱࣺ<%=rs("PostCode")%></td>
            </tr>
            <tr>
              <td height="25" colspan="2">������Ϣ��<%=rs("Content")%></td>
            </tr>
          </table>	  </td>
    </tr>
<%
  rs.movenext
  next
  else
   response.Write "<tr><td colspan='2' align='center'>������Ϣ!</td></tr>"
 end if
 
%>  
  <tr bgcolor="#ffffff">
    <td colspan="9" height="25" align="right">ȫѡ&nbsp;
	<input type="checkbox" name="checkAll" onClick="selectAll(this.form);" >&nbsp;
    <input type="submit" name="submit2" value="ɾ ��" class="button2">&nbsp;</td>
  </tr>
</form>    
</table>
<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="25" align="center"><% showPage "?" %></td>
  </tr>
</table>

</div>
</body>
</html>
