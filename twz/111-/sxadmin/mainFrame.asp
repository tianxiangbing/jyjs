<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="css/common.css" type="text/css" />
<title>��������</title>
</head>
<body>
<!--#include file="judge.asp"-->
<div id="container">
<% '**************************************************
'��������IsObjInstalled
'��  �ã��������Ƿ��Ѿ���װ
'��  ����strClassString ----�����
'����ֵ��True  ----�Ѿ���װ
'       False ----û�а�װ
'**************************************************
Function IsObjInstalled(strClassString)
	On Error Resume Next
	IsObjInstalled = False
	Err = 0
	Dim xTestObj
	Set xTestObj = Server.CreateObject(strClassString)
	If 0 = Err Then IsObjInstalled = True
	Set xTestObj = Nothing
	Err = 0
End Function %>
  <table width="97%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
    <tr>
      <td colspan="2" align="center" class="table_title">��������Ϣͳ��</td>
    </tr>
    <tr>
      <td width="45%" align="left" >��������<%= Request.ServerVariables("SERVER_NAME") %>(IP:<%=Request.ServerVariables("LOCAL_ADDR")%>) �˿�:
	  <%=Request.ServerVariables("SERVER_PORT")%></td>
      <td width="55%">�ű��������棺
      <% =ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion %></td>
    </tr>
    <tr>
      <td>վ������·����<% =request.ServerVariables("APPL_PHYSICAL_PATH") %></td>
      <td>FSO�ı���д��
          <% if not IsObjInstalled("Scripting.FileSystemObject") then %>
            <font color="#FF0000"><b>��</b></font>
            <% else %>
            <font color="009a00"><b>��</b></font>
            <% end if %>   </td>
    </tr>
    <tr>
      <td>IIS�汾�� <%=Request.ServerVariables("SERVER_SOFTWARE")%></td>
      <td>Jmail���֧�֣�
          <% if not isobjinstalled("JMail.SMTPMail") then %>
            <font color="#FF0000"><b>��</b></font>
            <% else %>
            <font color="009a00"><b>��</b></font>
            <% end if %></td>
    </tr>
    <tr>
      <td>Persits.Jpeg (ASPJpeg)��<% if not IsObjInstalled("Persits.Jpeg") then %>
            <font color="#FF0000"><b>��</b></font>
            <% else %>
            <font color="009a00"><b>��</b></font>
            <% end if %>  </td>
      <td>&nbsp;</td>
    </tr>
	<tr>
      <td class="left_title_2">&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td colspan="2" align="center" class="table_title">���˵��</td>
    </tr>
    <tr>
      <td colspan="2">1.�����ڸ����������Ϊ���ṩ�������Ե���ʾ��������Щ��ʾ�����Է���ؽ�����վ���ݵ���ӡ��������޸ġ�����ɾ���ȵȡ��������ܿ�ͻᷢ�ֹ�����վԭ����˼򵥡�</td>
    </tr>
    <tr>
      <td colspan="2"> 2.�������ߣ�WINDOWS2003 IIS + Microsoft Access 2003 + SQLserver2000</td>
    </tr>
    
    <tr>
      <td colspan="2" class="left_title_2">&nbsp;</td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td class="left_title_2">&nbsp;</td>
      <td><a href="serverInfo.asp">��˲鿴����ϸ�ķ�������Ϣ>>></a></td>
    </tr>
  </table>
</div>
</body>
</html>
