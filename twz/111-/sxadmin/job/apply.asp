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
	 sql = "delete * from apply where id in ("&selectId&")"
	 conn.execute sql
	 'response.Redirect "adminLog.asp"
  end if
  
 
 %>

<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="1" class="table_style" >
  <tr>
    <td height="25" colspan="7" align="center" class="table_title">����ӦƸ�б�</td> 
  </tr><form action="../../sxadmin/job/apply.asp?" name="myform" method="post" onSubmit="return del('selectId');">
<%
  set rs = server.CreateObject("adodb.recordset")
  sql = "select * from apply order by id desc"
  rs.open sql,conn,1,1
  if not rs.eof then
    
    dim page 
	page=request("page")  
	if page="" or page<=0   then
		page=1
  	end if 
	           
	rs.pageSize=15
	totalPageCount=cint(rs.pagecount)
	rs.absolutepage=page
	for i = 1 to rs.pagesize
	   if rs.eof then exit for
	 
%>  

  <tr>  
    <td width="20%" height="12" align="center">ӦƸְλ</td>
	<td width="17%" align="center">ӦƸ��</td>
	<td width="20%" align="center">E-mail</td>
	<td width="13%" align="center">�绰</td>
	<td width="14%" align="center">����ʱ��</td>
	<td width="9%" align="center">��ϸ</td>
	<td width="7%" align="center">ѡ��</td>
  </tr>
  <tr align="center">
    <td height="12"><%= rs("jobid")%></td>
    <td height="12"><%= rs("username")%></td>
    <td height="12"><%= rs("email")%></td>
    <td height="12"><%=rs("tel")%></td>
    <td height="12"><%= rs("addtime")%></td>
    <td height="12" style="CURSOR: hand" onClick="show(<%= "a"&i %>);">��ʾ</td>
    <td width="7%"><input type="checkbox" name="selectId" value="<% =rs("id") %>" /></td>
  </tr>
  <tr id="<%= "a"&i %>" style="display:none">
	  <td colspan="7">
	      <table width="98%" border="0" align="center" cellpadding="2" cellspacing="1" class="table_style">
            <tr>
              <td width="150" height="20" >ѧ����<%=rs("education")%></td>
              <td >�ʱࣺ<%=rs("postcode")%></td>
            </tr>
            <tr>
              <td height="20">���䣺<%=rs("Age")%></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td height="25" colspan="2">���᣺<%=rs("Origin")%></td>
            </tr>
            <tr>
              <td height="25" colspan="2">��ַ��<%=rs("address")%></td>
            </tr>
            <tr>
              <td height="25" colspan="2">��ע��<%=rs("content")%></td>
            </tr>
          </table>	  </td>
    </tr>
<%
  rs.movenext
  next
  else
   response.Write "������Ϣ!"
 end if
 
%>  
  <tr bgcolor="#ffffff">
    <td colspan="7" height="25" align="right">ȫѡ&nbsp;
	<input type="checkbox" name="checkAll" onClick="selectAll(this.form);" >&nbsp;
    <input type="submit" name="submit2" value="ɾ ��" class="button2">&nbsp;</td>
  </tr>
</form>    
</table>
<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30" align="center"><% showPage "?" %>
</td>
  </tr>
</table>

</div>
</body>
</html>
