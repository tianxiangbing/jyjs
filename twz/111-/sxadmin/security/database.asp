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
<BR>
  <table width="850"  border="0" align="center" cellpadding="0" cellspacing="1" class="table_style" >
   <tr>
		<td height="25" align="center" colspan="2" class="table_title">�� �� �� �� ��</td>
	</tr>
	<tr class="a4">
		<td width="75" height="30">&nbsp;<span style="color:#CC6600;">��������</span></td>
    <td height="30">&nbsp;<a href="?action=backup" class="left_title_2">�������ݿ�</a> | <a href="?action=restore" class="left_title_2">�ָ����ݿ�</a> |  <a href="?action=spaceSize" class="left_title_2">ϵͳ�ռ�ռ�����</a>
	  </td>
	</tr>
  </table>
<BR>

<%
if not IsObjInstalled("Scripting.FileSystemObject") then
	Response.Write "<b><font color='red'>��ķ�������֧�� FSO(Scripting.FileSystemObject)! ����ʹ�ñ�����</font></b>"
    response.end()
else
	dim fso
	set fso = server.createObject("Scripting.FileSystemObject")	
end if

dim dbPath2	'���ݿ�·��
const db="../../db/ch#$%shixiang.asa"
dbPath2=Server.MapPath(db)
dim dbBackupPath '���ݿⱸ��·��
dbBackupPath=server.MapPath("../../db/dbBackup")

select case trim(request.QueryString("action"))
	case "backup"
		call showBackup()
	case  "restore"
		call showRestore()
	case  "compact"	
		call ShowCompact()
	case  "spaceSize"
		call SpaceSize()
	case else
		call SpaceSize()
end select


'--------�������ݿ�--------
sub showBackup()
	dim backupName
	backupName=request.form("backupName")
	backupName=replace(replace(backupName,"/",""),"\","")
	if backupName<>"" then
		fso.copyfile dbPath2,dbBackupPath &"/"& backupName & ".asa",true	'�ļ�����ʱ���ǡ�
		if err then
     		err.clear
			erro "�Ƿ����֣�����������"
		end if
		erro "���ݳɹ���"
	End if

%>
<table width="850"  border="0" align="center" cellpadding="0" cellspacing="1" class="table_style" >
<form name="form1" method="post" action="?action=backup" onsubmit="return chkBackData()">
 
  <tr>
    <td align="center" height="25" ><font color="#CC0000"><b>�� �� �� �� ��</b></font></td>
  </tr>
  <tr>
	<td align="center" height="25" >
       <span class="left_title_2">�������ƣ�</span>
       <input  type="text" name="backupName" id="backupName" value="<%= "ch#$%shixiang"&date() %>" size=30 />
       ��д���ݿ����ƣ���׺������д���ļ�����ʱ���Զ����ǡ�</td>
  </tr>
   <tr class="a4">
     <td height="40" align="center"><input name="submit" type=submit value=" &nbsp;��ʼ����&nbsp; "  style="cursor: hand;background-color: #cccccc;"></td>
   </tr>
</form>
</table>
<%
end sub


'--------�ָ����ݿ�--------
sub showRestore()

	dim fileName,operate
	fileName=request.querystring("fileName")
	operate=request.querystring("operate")
	select case operate
		case "compact"	'ѹ�����ݿ�
			call CompactData(fileName)
		case "restore"
		  if fso.fileExists(dbBackupPath &"/"&fileName) then
		  	fso.copyFile dbBackupPath &"/"&fileName,dbPath2,true
		  	ok "�ָ��ɹ���","?action=restore"
		  else
			erro "�˱����ļ�ʧЧ���Ҳ���ָ���ı����ļ���"		
		  end if	
		case "del"
		  if fso.fileExists(dbBackupPath &"/"&fileName) then	fso.deleteFile dbBackupPath &"/"&fileName
		case else
			'erro "��������"
	end select
%>
<table width="850"  border="0" align="center" cellpadding="0" cellspacing="1" class="table_style" >
<form method="post" action="?action=restore">
  <tr>
	<td colspan="7" align="center" height="25"><FONT COLOR="#CC0000"><b>�� �� �� �� ��</b></FONT></td>
  </tr>
  <tr>
    
    <td width="292" align="center" >���ݿ���</td>
    <td width="199" align="center" >ռ�ô�С</td>
    <td width="199" align="center" >��������</td>
    <td width="199" align="center" >���ݿ�����ѹ��</td>
    <td width="199" height="25" align="center" >�ָ����ݿ�</td>
    <td width="122" height="25" align="center" >����</td>
  </tr>
  <% 	
  dim fles
  for each fles in fso.GetFolder(dbBackupPath).files %>
  <tr>
    <td align="center" ><%= fles.name %></td>
    <td align="center" ><%= CheckSize(fles.size) %></td>
    <td align="center" ><%= fles.DateLastModified  %></td>
    <td align="center" ><a href="?action=restore&operate=compact&fileName=<%= server.urlencode(fles.name) %>"  onclick="return confirm('ѹ�����ݿ���һ���ķ��գ������ȱ��ݣ��Ƿ�ѹ����')">ѹ��</a></td>
    <td align="center" height="25" ><a href="?action=restore&operate=restore&fileName=<%= server.urlencode(fles.name) %>"  onclick="return confirm('�ָ��󽫸����������ݿ�!ȷ���ô����ݿ�ָ���')">�ָ�</a></td>
    <td align="center" height="25" ><a href="?action=restore&operate=del&fileName=<%= server.urlencode(fles.name) %>" onclick="return confirm('ȷ��ɾ����ɾ���󽫲��ɻָ���')">ɾ��</a></td>
  </tr>
	<% next %>
	<tr align="center"> 
		<td colspan="7" align="left" valign="middle" style="line-height: 150%"><br>
		  <font color="#FF6600"><b>ע1��</b></font>������ݿⲻ�Ǻ��Ӵ󣬽��鲻��ѹ�������ⷢ��������� <br>
		<font color="#FF6600"><b>ע2��</b></font>��ѡ����ȷ�����ݿ���лָ��������ɴ˴��������ݶ�ʧ��</td>
	</tr>
</form>
</table>
<%
end sub



'--------ͳ�ռ�ռ�����--------
sub SpaceSize()
	
%>
<table cellpadding="2" cellspacing="1" border="0" width="850" align="center" class="a2">
  <tr>
	<td colspan="2" align="center" height="25" class="a1"><FONT COLOR="#CC0000"><b>ϵ ͳ �� �� ռ �� �� ��</b></FONT></td>
	</tr>
  <tr class="a4"> 
    <td width="100%" height="150" valign="middle">
	<blockquote><br>
      ϵͳ����ռ�ÿռ䣺&nbsp;<img src="../images/bar.gif" width=<%=drawBar(showFileSize(db))%> height=10>&nbsp; <%= checkSize(showFileSize(db))%>
      <br>
      <br>
      ��������ռ�ÿռ䣺&nbsp;<img src="../images/bar.gif" width=<%= drawBar(showFolderSize("../../db/DbBackup")) %> height=10>&nbsp; <%= checkSize(showFolderSize("../../db/DbBackup"))%>
      <br>
      <br>
      ϵͳͼƬ���ļ�ռ�ÿռ䣺&nbsp;<img src="../images/bar.gif" width=<%= drawBar(showFolderSize("../../upfile")) %> height=10>&nbsp;<%= checkSize(showFolderSize("../../upfile"))%>
      <br>
      <br>
      ��վռ�ÿռ��ܼƣ�&nbsp;<img src="../images/bar.gif" width=400 height=10>&nbsp;<%= checkSize(showFolderSize("/")) %>
	</blockquote> 	
    </td>
  </tr>
</table>
<%
end sub


'--------ѹ�����ݿ�--------
sub CompactData(fileName) 
	Dim Engine 
	response.write dbBackupPath&"/"&fileName
	If fso.FileExists(dbBackupPath&"/"&fileName) Then
		Set Engine = CreateObject("JRO.JetEngine")
		Engine.CompactDatabase "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & dbBackupPath&"/"&fileName," Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & dbBackupPath & "/" & "temp.mdb"
		fso.CopyFile dbBackupPath & "/" & "temp.mdb",dbPath2
		fso.DeleteFile(dbBackupPath & "/" & "temp.mdb")
		Set Engine = nothing
		ok "���ݿ�ѹ���ɹ�!","?action=restore"
	Else
		erro "���ݿ�û���ҵ�!"
	End If
end sub

function showFileSize(objFile)	'��ʾ�ļ���С
	dim fil
	set fil=fso.getFile(server.MapPath(objFile))
	showFileSize=fil.size
end function

function showFolderSize(objFolder)	'��ʾ�ļ��д�С
	dim flder
	set flder=fso.getFolder(server.MapPath(objFolder))
	showFolderSize=flder.size
end function

 	

Function drawBar(sSize)
	dim totalsize,barsize
	totalsize=showFolderSize("/")
	barsize=cint((sSize/totalsize)*400)
	drawBar=barsize
End Function 	


%>
<BR>

</div>
</body>
</html>