<!--#include file="../inc/subCode.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��̨����</title>
<script type="text/javascript" src="../js/checkForm.js"></script>
<link rel="stylesheet" href="../css/common.css" type="text/css" />
</head>
<body>
<div id="container">
  <table width="99%" border="0" align="center"  cellpadding="3" cellspacing="1">
  <form action="../../sxadmin/power/manage.asp?" method="post" name="searchForm">   <!--�������ֿ�ʼ-->
    <tr>
      <td><strong>������</strong> 
        <input type="text" name="keywords">&nbsp;&nbsp;
<input type="submit" name="ss" value="�� ��"></td>
    </tr>
	</form> 
  </table>
</p>
	<% 
	 if request.Form("selectId")<>"" then
		 selectid=request.Form("selectid")
		 sql = "delete * from power where id in ("&selectId&")"
		 conn.execute sql
		 'response.Redirect "adminLog.asp"
  	 end if	
	 
  	
	 %>
  <table width="99%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
    <tr>
      <td colspan="5" class="table_title">��ɫ�б�</td>
    </tr>
	<form action="../../sxadmin/power/manage.asp?page=<%=page%>" method="post" name="myform" onSubmit="return del('selectId');">	
    <tr>
      <td width="12%" align="center" class="left_title_2">���</td>
      <td width="49%" align="center" class="left_title_2">����</td>
      <td width="23%" align="center" class="left_title_2">���ʱ��</td>
      <td width="10%" align="center" class="left_title_2">����</td>
      <td width="6%" align="center" class="left_title_2">ѡ��</td>
    </tr>
	<% 
	keywords=trim(request("keywords"))
	
	sql="select * from power where 1=1 "
	If keywords <> "" Then sql=sql&" and username LIKE '%"&keywords&"%'"
	sql=sql&" order by addtime desc"
	
	
	call pageRs(rs,sql,20,page,totalPageCount)
	if not rs.eof then
		for i=1 to rs.pageSize
		  if rs.eof then exit for 
		   %>
   	 <tr align="center" onMouseOver="this.className ='trOnMouseOver'" onMouseOut="this.className=''">
      <td><%= i %></td>
      <td><%= rs("username") %></td>
      <td><%= rs("addtime")  %></td>
      <td><a href="modify.asp?id=<% =rs(0) %>">�޸�</a></td>
      <td><% if rs("id")<>1 then  %><input type="checkbox" name="selectId" value="<% =rs(0) %>"><% end if %></td>
   	 </tr>
	<% 
		rs.movenext
		next
		 %>
    <tr bgcolor="#FFFFFF">
      <td colspan="5" align="right">&nbsp; <input type="checkbox" name="checkAll" onClick="selectAll(this.form);" >
        &nbsp;ȫѡ&nbsp; 
      <input type="submit" name="submit2" value="ɾ��"  class="button2">
      &nbsp;&nbsp; </td>
    </tr>
	</form>
	<% 
	else
		response.write("��������")
	end if %>
	<tr bgcolor="#FFFFFF">
      <td colspan="5" align="right">ע����������Ա��ɾ�����޸Ĺ��ܣ�</td>
    </tr>
  </table>
  <table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
   <tr>
     <td height="30" align="center"><% if i>0 then showPage "?keywords="&server.urlEncode(keywords)&"&fileClass="&fileClass&"&" %></td>
   </tr>
  </table>
</div>
</body>
</html>
