<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��̨����</title>
<link rel="stylesheet" href="../css/common.css" type="text/css" />
</head>
<!--#include file="../inc/subCode.asp"-->
<body>
<div id="container">
  <table width="99%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
    <tr>
      <td align="left"><a href="class_add.asp"><strong>��Ӹ����</strong></a></td>
    </tr>
  </table>
  <br />
  <table width="99%" border="0" align="center"  cellpadding="0" cellspacing="1" class="table_style">
    <tr>
      <td colspan="3" align="center" class="table_title">������</td>
    </tr>
    <tr class="left_title_2">
      <td align="center">����</td>
      <td align="center">����</td>
      <td align="center">����</td>
    </tr>
	 <%
	Const ClassTableName="downloadClass"
	 
	if request.querystring("action")="del" then
	 	conn.execute("delete from "&ClassTableName&" where ClassId="&request.querystring("id"))
	end if 
	
showClassT 0,0  
sub showClassT(id,nSpace) '�ݹ���ʾ����
	dim rs,delStr
	
	sql="select * from "&ClassTableName&" where ClassPId="&id&" order by power desc"
	set rs=conn.execute(sql)
	
	do while not rs.eof
	ssubstr=""
		for i=1 to nSpace
			ssubstr=ssubstr+"&nbsp;&nbsp;&nbsp;&nbsp;"
		next
		if nSpace<>0 then	ssubstr1="����"
		%>
	<tr    onMouseOut="this.className=''" onMouseOver="this.className ='trOnMouseOver'">
      <td height="20"  align="center"><% =rs("Power") %></td>
      <td>&nbsp;<%= ssubstr&ssubstr1&rs("ClassName") %></td>
      <td ><table width="75%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td width="82"><%if nSpace+1<downloadClassNum then response.write("<a href='class_add.asp?id="&rs(0)&"' >��������</a>")%>&nbsp;</td>
              <td width="51" align="left"><a href="class_modify.asp?id=<%=rs(0)%>">�޸�</a></td>
              <td width="63">
			  <% set cRs=conn.execute("select * from "&ClassTableName&" where ClassPId="&rs(0))'�ж��Ƿ���ʾɾ��,���������ʱ,��ɾ������
			  	if cRs.eof then	response.write "<a href='?action=del&id="&rs(0)&"' onclick=""return confirm('ȷ��ɾ����')"" >ɾ��</a>&nbsp;"
			   %>&nbsp;			  </td>
            </tr>
            </table></td>
    </tr>
	<%	call  showClassT(rs(0),nSpace+1)
		rs.movenext
	loop
end sub

%>
    
  </table>
</div>
</body>
</html>
