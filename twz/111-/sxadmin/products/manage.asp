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
  <form action="../../sxadmin/products/manage.asp?" method="post" name="searchForm">   <!--�������ֿ�ʼ-->
    <tr>
      <td><strong>������</strong> 
        <input type="text" name="keywords">&nbsp;&nbsp;<select name="proClass"  style="background-color:#ECF3FF;"> <option value="">��ѡ�����</option>
    <%  showClass 0,0,0,"proClass"	%>
      </select>
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
		  set dRs=conn.execute("select * from products where id="&Idstr)
		  if not dRs.eof then
		  	
		    Call DoDelFile("../../"&dRs("propic"))
			Call DoDelFile("../../"&dRs("proSmallpic"))
			
			if dRs("d_savepathfilename")<>"" then	
				' �Ѵ�"|"���ַ���תΪ����
				Dim aSavePathFileName
				aSavePathFileName = Split(dRs("d_savepathfilename"), "|")
			
				' ɾ����ص��ļ������ļ�����
				Dim j
				For j = 0 To UBound(aSavePathFileName)
					' ��·���ļ���ɾ���ļ�
					'response.write(Server.MapPath("../../"&aSavePathFileName(j)))
					Call DoDelFile("../../"&aSavePathFileName(j))
				Next
			 end if
			 
			 conn.execute("delete * from products where id="&Idstr)	'ɾ�����ݿ��м�¼
			 
			end if
			closeRs(dRs)
		 end sub
		 
    keywords=trim(request("keywords"))
	proClass=trim(request("proClass"))
	
	sql="select * from products where 1=1 "
	If keywords <> "" Then sql=sql&" and proName LIKE '%"&keywords&"%'"
	If proClass <> "" Then sql=sql&" and classId = "&proClass
	sql=sql&" order by addtime desc"
	
	call pageRs(rs,sql,20,page,totalPageCount)		 

  	
	 %>
  <table width="99%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
    <tr>
      <td colspan="8" class="table_title">��Ʒ�б�</td>
    </tr>
	<form action="../../sxadmin/products/manage.asp?page=<%=page%>" method="post" name="myform" onSubmit="return del('selectId');">	
    <tr>
      <td width="6%" align="center" class="left_title_2">ѡ��</td>
      <td width="9%" align="center" class="left_title_2">Ԥ��</td>
      <td width="37%" align="center" class="left_title_2">����(��Ӣ��)</td>
      <td width="9%" align="center" class="left_title_2">����</td>
      <td width="15%" align="center" class="left_title_2">������</td>
      <td width="5%" align="center" class="left_title_2">����</td>
      <td width="14%" align="center" class="left_title_2">����ʱ��</td>
      <td width="5%" align="center" class="left_title_2">����</td>
    </tr>
	<% 
	
	if not rs.eof then
		for i=1 to rs.pageSize
		  if rs.eof then exit for %>
   	 <tr align="center" onMouseOver="this.className ='trOnMouseOver'" onMouseOut="this.className=''">
      <td><input type="checkbox" name="selectId" value="<% =rs(0) %>"></td>
      <td>
      <a href="../../<%=rs("propic")%>" target="_blank">
      <img src="../../<%=rs("ProSmallPic")%>" width="60" height="50" border="0"/></a></td>
      <td>
	  <% = rs("proName")  %> / <% = rs("EnproName")  %> 
	  <% if rs("isSuggest")=true then response.write "<font color='red'>[��]</font>" end if %>
      <% if rs("IsNew")=true then response.write "<font color='red'>[��]</font>" end if %>
      </td>
       <td><%= GetLanguage(rs("languages")) %></td>
      <td><%= className(rs("ClassId"),"proClass") %></td>
      <td><%= rs("power")  %></td>
      <td><%= FormatDatetime(rs("addtime"),2) %></td>
      <td><a href="modify.asp?page=<%= page %>&id=<%= rs(0) %>">�޸�</a></td>
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
		response.write("<tr bgcolor='#FFFFFF'><td colspan='7' align='center'>��������</td></tr>")
	end if %>
  </table>
  <table width="99%" border="0" align="center"  cellpadding="3" cellspacing="1" >
   <tr>
     <td height="25" align="center"><% if i>0 then showPage "?keywords="&server.urlEncode(keywords)&"&proClass="&proClass&"&" %></td>
   </tr>
  </table>
</div>
</body>
</html>
