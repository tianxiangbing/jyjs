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
		 If Not selectid="" Then
			arrIdList = Split(selectid,",")
			For i = 0 To UBound(arrIdList)
				iId = Clng(arrIdList(i))
				 Call DelNews(iId)
			Next
		 Else
			 Call erro("������ѡ��һ����Ϣ��¼��")
		 End If
	  end if	
	 
	  sub DelNews(Idstr)
		  set dRs=conn.execute("select * from ad where id="&Idstr)
		  if not dRs.eof then
		  	
		    Call DoDelFile("../../"&dRs("adPic"))
			Call DoDelFile("../../"&dRs("adSmallPic"))
			
			conn.execute("delete * from ad where id="&Idstr)	'ɾ�����ݿ��м�¼
			 
		  end if
		  closeRs(dRs)
		end sub

  	
	 %>
<table width="97%" border="0" align="center" cellpadding="0" cellspacing="1" class="table_style">
  <tr>
    <td height="30" bgcolor="#FFFFFF"><span style="color:#CC6600">���λ�ã�</span>&nbsp;&nbsp;
      
        <%
	  set rs_class=conn.execute("select * from ADClass order by power desc")
	  do while not rs_class.eof
	 	 response.write "<a href='?ClassID="&rs_class(0)&"' >"&rs_class("ClassName")&"</a>&nbsp;&nbsp;&nbsp;&nbsp;"
	  rs_class.movenext
	  loop
	  closeRs(rs_class)
	  
	  %>
      </td>
  </tr>
</table>
<br />
  <table width="99%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
    <tr>
      <td colspan="8" class="table_title">����б�</td>
    </tr>
	<form action="../../sxadmin/advertise/manage.asp?" method="post" name="myform" onSubmit="return del('selectId');">	
    <tr>
      <td width="9%" align="center" class="left_title_2">ѡ��</td>
      <td width="9%" align="center" class="left_title_2">���ͼƬ</td>
      <td width="21%" align="center" class="left_title_2">�������</td>
      <td width="19%" align="center" class="left_title_2">������ӵ�ַ</td>
      <td width="13%" align="center" class="left_title_2">���λ��</td>
      <td width="19%" align="center" class="left_title_2">����ʱ��</td>
      <td width="10%" align="center" class="left_title_2">����</td>
    </tr>
	<% 
	
	ClassId=request.QueryString("ClassId")
    sql = "SELECT * FROM [ad]  "
 
	If ClassId <> "" Then sql=sql&" where adclass ="&Cint(ClassId)
	sql=sql&" ORDER BY addtime desc"
	
	call pageRs(rs,sql,20,page,totalPageCount)
	
	if not rs.eof then
		for i=1 to rs.pageSize
		  if rs.eof then exit for %>
   	 <tr align="center">
      <td><input type="checkbox" name="selectId" value="<% =rs(0) %>"></td>
      <td><a href="../../<%=rs("adPic")%>" target="_blank"><img src="../../<%=rs("adSmallpic")%>" width="60" height="50" border="0"/></a></td>
      <td><%= rs("adName") %></td>
      <td><%= rs("adUrl") %></td>
      <td><%= classname(rs("adClass"),"adClass") %></td>
      <td><%= rs("addtime")  %></td>
      <td><a href="modify.asp?id=<% =rs(0) %>">�޸�</a></td>
    </tr>
	<% 
		rs.movenext
		next
		 %>
		
    <tr bgcolor="#FFFFFF">
      <td colspan="8">&nbsp; <input type="checkbox" name="checkAll" onClick="selectAll(this.form);" >
        &nbsp;ȫѡ&nbsp; 
      <input type="submit" name="submit2" value="ɾ��"  class="button2">
      &nbsp;&nbsp; </td>
    </tr>
	</form>
	<% 
	else
		response.write("<tr bgcolor='#FFFFFF'><td colspan='6' align='center'>��������</td></tr>")
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
