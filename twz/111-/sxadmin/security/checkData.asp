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
<table width="97%" border="0" align="center" cellpadding="0" cellspacing="1" class="table_style">
  <tr>
    <td height="30" bgcolor="#FFFFFF"><strong>�������ݴ���</strong></td>
  </tr>
</table>
<p>
<% 
if request.querystring("action")="edit" then
	'���ദ��,���������ļ����Ƿ�������ݿ��У����û�У���ɾ�������ļ�
	
	'�ļ���,���,��ͼ�ֶ�,Сͼ�ֶ�,	
	Redundancy "products","products","propic","proSmallpic" 'products�ļ���
	Redundancy "news","Article","NewsPic","NewsSmallPic" 'News�ļ���
	Redundancy "guangGao","ad","AdPic","AdSmallPic" 'guangGao[���]�ļ���
	Redundancy "download","download","filepath","filepath" '�����ļ���
	Redundancy "friendlink","Friendlink","FriPic","FriSmallPic" '���������ļ���
	
	'dim str	
	'eWebEditorFile "article"
	'eWebEditorFile "products"
	'response.Write str&"s"
	
	response.Write("<script>alert('�����ɹ���');</script>")
end if

sub Redundancy(aFloder,aTable,bPic,sPic) '���ദ��
	dim oFSO,folder,items '��ȡ�ļ����������ļ�,
	Set oFSO = Server.CreateObject("Scripting.FileSystemObject")
	set folder = oFSO.GetFolder(Server.MapPath("../upfile/"&aFloder&""))
	
	for each items in folder.Files
		set rs=server.CreateObject("adodb.RecordSet")
		sql="select * from ["&aTable&"]" '��ȡ���ݿ�������
		rs.Open sql, conn, 1,3
		i=0
		do while not rs.eof
			if "upfile/"&aFloder&"/"&items.name=rs(""&bPic&"") or "upfile/"&aFloder&"/"&items.name=rs(""&sPic&"") then 
				exit do
			end if	
			rs.movenext
			i=i+1
		loop
		'response.write rs.recordCount=i
		if rs.recordCount=i then oFSO.DeleteFile(Server.MapPath("../upfile/"&aFloder&"/"&items.name))
		'if rs.recordCount=i then 	response.write("upfile/"&aFloder&"/"&items.name)
		rs.close
		set rs=nothing
	next
	Set oFSO = Nothing
	Set folder = Nothing
end sub


'if instr(str,"upfile/"&aFloder&"/"&items.name)=0 then  oFSO.DeleteFile(Server.MapPath("../upfile/eWebeditor/"&items.name))

sub eWebEditorFile(aTable)
	dim oFSO,folder,items '��ȡ�ļ����������ļ�,
	Set oFSO = Server.CreateObject("Scripting.FileSystemObject")
	set folder = oFSO.GetFolder(Server.MapPath("../upfile/eWebeditor"))
	
	for each items in folder.Files
		set rs=conn.execute("select d_savepathfilename from ["&aTable&"]") '��ȡ���ݿ�������
		do while not rs.eof
			str=str&"|"&rs("d_savepathfilename")
			rs.movenext
		loop
		
		rs.close
		set rs=nothing
	next
	Set oFSO = Nothing
end sub

%>
<table width="97%" border="0" align="center" cellpadding="0" cellspacing="1" class="tablebg">
  <tr > 
    <td height="20" colspan="2" align="center"><font color="#000">�������ݡ��ļ�����</font></td>
  </tr>
  <tr >
    <td width="26%" height="80" align="right">˵����</td>
    <td width="74%" align="left">1���������ݿ�����ʱ�������,��������Ҳ������,���ô˹��ܴ�����������.<br/>
      <br/>	
    2�����������ļ����Ƿ�������ݿ��У����û�У���ɾ�������ļ���</td>
  </tr>
  <tr >
    <td height="25" colspan="2" align="center"><a href="?action=edit" onclick="return reConfirm()">����</a></td>
  </tr>
</table>
</div>
</body>
</html>