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
  <table width="99%" border="0" align="center"  cellpadding="3" cellspacing="1">
  <form action="../../sxadmin/download/manage.asp?" method="post" name="searchForm">   <!--�������ֿ�ʼ-->
    <tr>
      <td><strong>������</strong> 
        <input type="text" name="keywords">&nbsp;&nbsp;<!--
        <select name="fileClass"  style="background-color:#ECF3FF;">
          <option value="">��ѡ�����</option>
          <% ' showClass 0,0,0,"downloadClass"	%>
        </select>-->
<input type="submit" name="ss" value="�� ��"></td>
    </tr>
	</form> 
  </table>
</p>
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
		 set dRs=conn.execute("select * from download where id="&Idstr)
		 if not dRs.eof then
		  	
		    Call DoDelFile("../../"&dRs("filepath"))
		 	conn.execute("delete * from download where id="&Idstr)	'ɾ�����ݿ��м�¼
			 
		 end if
		 closeRs(dRs)
	 end sub
	 
	 keywords=trim(request("keywords"))
	 fileClass=trim(request("fileClass"))
	
	 sql="select * from download where 1=1 "
	 If keywords <> "" Then sql=sql&" and filename LIKE '%"&keywords&"%'"
	' If fileClass <> "" Then sql=sql&" and fileClass = "&fileClass
	 sql=sql&" order by addtime desc"
	
	 call pageRs(rs,sql,20,page,totalPageCount)	

  	
	 %>
  <table width="99%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
    <tr>
      <td colspan="8" class="table_title">�ļ��б�</td>
    </tr>
	<form action="../../sxadmin/download/manage.asp?page=<%=page%>" method="post" name="myform" onSubmit="return del('selectId');">	
    <tr>
      <td width="5%" align="center" class="left_title_2">���</td>
      <td width="42%" align="center" class="left_title_2">�ļ�����(��Ӣ��)</td>
      <td width="10%" align="center" valign="middle">����</td>
     <!-- <td width="15%" align="center" class="left_title_2">��С</td>-->
      <td width="13%" align="center" class="left_title_2">������</td>
      <td width="5%" align="center" class="left_title_2">����</td>
      <td width="14%" align="center" class="left_title_2">����ʱ��</td>
      <td width="6%" align="center" class="left_title_2">����</td>
      <td width="5%" align="center" class="left_title_2">ѡ��</td>
    </tr>
	<% 
	if not rs.eof then
		for i=1 to rs.pageSize
		  if rs.eof then exit for %>
   	 <tr align="center" onMouseOver="this.className ='trOnMouseOver'" onMouseOut="this.className=''">
      <td><%= i %></td>
      <td><%= rs("fileName") %> / <%= rs("EnfileName") %></td>
      <td><%= GetLanguage(rs("languages")) %></td>
   <!--    <td><%'= CheckSize(rs("sizes")) %></td>-->
     <td><% = className(rs("fileClass"),"downloadClass") %></td>
      <td><%= rs("power")  %></td>
      <td><%= rs("addtime")  %></td>
      <td><a href="modify.asp?id=<% =rs(0) %>">�޸�</a></td>
      <td><input type="checkbox" name="selectId" value="<% =rs(0) %>"></td>
   	 </tr>
	<% 
		rs.movenext
		next
		 %>
		
    <tr bgcolor="#FFFFFF">
      <td colspan="8" align="right">&nbsp; <input type="checkbox" name="checkAll" onClick="selectAll(this.form);" >
        &nbsp;ȫѡ&nbsp; 
      <input type="submit" name="submit2" value="ɾ��"  class="button2">
      &nbsp;&nbsp; </td>
    </tr>
	</form>
	<% 
	else
		response.write("��������")
	end if %>
  </table>
  <table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
   <tr>
     <td height="30" align="center"><% if i>0 then showPage "?keywords="&server.urlEncode(keywords)&"&fileClass="&fileClass&"&" %></td>
   </tr>
  </table>
</div>
</body>
</html>
