<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!--#include file="judge.asp"-->
<%
' *************************************************

'  ����ASP̽�� V1.93 20060602
'  �����غ� http://www.ajiang.net

' *************************************************

' ��ʹ�������������ֱ�ӽ����н����ʾ�ڿͻ���
Response.Buffer = true

' ��ҳ������ʱ����ֹ���浼�²���ʧ�ܡ�
Response.Expires = -1

' ������������б�
Dim OtT(3,15,1)
' ����������
dim okCPUS, okCPU, okOS
' ����������
dim isobj,VerObj,TestObj


%>

<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<TITLE>��������Ϣ</TITLE>
<style>
<!--
h1 {font-size:14px;color:#3F8805;font-family:Arial;margin:15px 0px 5px 0px}
h2 {font-size:12px;color:#000000;margin:15px 0px 8px 0px}
h3 {font-size:12px;color:#3F8805;font-family:Arial;margin:7px 0px 3px 12px;font-weight: normal;}
BODY,TD{FONT-FAMILY: ����;FONT-SIZE: 12px;word-break:break-all}
tr{BACKGROUND-COLOR: #EEFEE0}
A{COLOR: #3F8805;TEXT-DECORATION: none}
A:hover{COLOR: #000000;TEXT-DECORATION: underline}
A.a1{COLOR: #000000;TEXT-DECORATION: none}
A.a1:hover{COLOR: #3F8805;TEXT-DECORATION: underline}
table{BORDER: #3F8805 1px solid;background-color:#3F8805;margin-left:12px}
p{margin:5px 12px;color:#000000}
.input{BORDER: #111111 1px solid;FONT-SIZE: 9pt;BACKGROUND-color: #F8FFF0}
.backs{BACKGROUND-COLOR: #3F8805;COLOR: #ffffff;text-align:center}
.backq{BACKGROUND-COLOR: #EEFEE0}
.backc{BACKGROUND-COLOR: #3F8805;BORDER: medium none;COLOR: #ffffff;HEIGHT: 18px;font-size: 9pt}
.fonts{	COLOR: #3F8805}
-->
</STYLE>
</HEAD>
<body>





<%


' *******************************************************************************
' ����[ A ] �Ƿ�֧��ASP
' *******************************************************************************

%>
<h2>�Ƿ�֧��ASP</h2>
  <table border=0 width=500 cellspacing=1 cellpadding=3>
    <tr><td>
    ���������������ʾ���Ŀռ䲻֧��ASP��
    <br>1�����ʱ��ļ�ʱ��ʾ���ء�
    <br>2�����ʱ��ļ�ʱ�������ơ�&lt;&#x25;&#x40;&#x20;&#x4C;&#x61;&#x6E;&#x67;&#x75;&#x61;&#x67;&#x65;&#x3D;&#x22;&#x56;&#x42;&#x53;&#x63;&#x72;&#x69;&#x70;&#x74;&#x22;&#x20;&#x25;&gt;�������֡�
    </td></tr>
  </table>
<%







' *******************************************************************************
' ����[ B ] �������ſ�
' *******************************************************************************

%>
  <h2>�������ſ�</h2>
	<table border=0 width=500 cellspacing=1 cellpadding=3>
	  <tr>
		<td width="110">��������ַ</td><td width="390">���� <%=Request.ServerVariables("SERVER_NAME")%>(IP:<%=Request.ServerVariables("LOCAL_ADDR")%>) �˿�:<%=Request.ServerVariables("SERVER_PORT")%></td>
	  </tr>
	  <%
	  tnow = now():oknow = cstr(tnow)
	  if oknow <> year(tnow) & "-" & month(tnow) & "-" & day(tnow) & " " & hour(tnow) & ":" & right(FormatNumber(minute(tnow)/100,2),2) & ":" & right(FormatNumber(second(tnow)/100,2),2) then oknow = oknow & " (���ڸ�ʽ���淶)"
	  %>
	  <tr>
		<td>������ʱ��</td><td><%=oknow%></td>
	  </tr>
	  <tr>
		<td>IIS�汾</td><td><%=Request.ServerVariables("SERVER_SOFTWARE")%></td>
	  </tr>
	  <tr>
		<td>�ű���ʱʱ��</td><td><%=Server.ScriptTimeout%> ��</td>
	  </tr>
	  <tr>
		<td>���ļ�·��</td><td><%=Request.ServerVariables("PATH_TRANSLATED")%></td>
	  </tr>
	  <tr>
		<td>�������ű�����</td><td><%=ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion %> , <%="JScript/" & getjver()%></td>
	  </tr>
	  <%getsysinfo()  '��÷���������%>
	  <tr>
		<td>����������ϵͳ</td><td><%=okOS%></td>
	  </tr>
	  <tr>
		<td>ȫ�ֺͻỰ����</td><td>Application ���� <%=Application.Contents.count%> ��<%if Application.Contents.count>0 then Response.Write "[<a href=""?T=C"">�б�</a>]"%>, 
		Session ���� <%=Session.Contents.count%> ��  <%if Session.Contents.count>0 then Response.Write "[<a href=""?T=D"">�б�</a>]"%></td>
	  </tr>
	  <tr>
		<td>ServerVariables</td><td><%=Request.ServerVariables.Count%> ��  <%if Request.ServerVariables.Count>0 then Response.Write "[<a href=""?T=E"">Request.ServerVariables �б�</a>]"%></td>
	  </tr>
	  <tr>
		<td>������CPUͨ����</td><td><%=okCPUS%> ��</td>
	  </tr>
	  <%
	  call ObjTest("WScript.Shell")
	  if isobj then
	    set WSshell=server.CreateObject("WScript.Shell")
	  %>
	  <tr>
		<td>������CPU����</td><td><%=okCPU%></td>
	  </tr>
	  <tr>
		<td>ȫ������������</td><td><%=WSshell.Environment.count%> ��  <%if WSshell.Environment.count>0 then Response.Write "[<a href=""?T=F"">WSshell.Environment �б�</a>]"%></td>
	  </tr>
	  <%
	  end if
	  %>
	</table>
<%


%>
<SCRIPT language="JScript" runat="server">
function getJVer(){
  //��ȡJScript �汾
  return ScriptEngineMajorVersion() +"."+ScriptEngineMinorVersion()+"."+ ScriptEngineBuildVersion();
}
</SCRIPT>
<%

' ��ȡ���������ò���
sub getsysinfo()
  on error resume next
  Set WshShell = server.CreateObject("WScript.Shell")
  Set WshSysEnv = WshShell.Environment("SYSTEM")
  okOS = cstr(WshSysEnv("OS"))
  okCPUS = cstr(WshSysEnv("NUMBER_OF_PROCESSORS"))
  okCPU = cstr(WshSysEnv("PROCESSOR_IDENTIFIER"))
  if isempty(okCPUS) then
    okCPUS = Request.ServerVariables("NUMBER_OF_PROCESSORS")
  end if
  if okCPUS & "" = "" then
    okCPUS = "(δ֪)"
  end if
  if okOS & "" = "" then
    okOS = "(δ֪)"
  end if
end sub






' *******************************************************************************
' ����[ C ] Application �����б�
' *******************************************************************************

%>
<h2>Application �����б�</h2>
<table border=0 width=500 cellspacing=1 cellpadding=3>
  <tr class="backs"><td width="110">�� �� �� ��</td><td width="390">ֵ</td></tr>
  <%for each apps in Application.Contents%>
  <tr><td width="110"><%=apps%></td><td width="390"><%
  if isobject(Application.Contents(apps)) then
    Response.Write "[����]"
  elseif isarray(Application.Contents(apps)) then
    Response.Write "[����]"
  else
    Response.Write cHtml(Application.Contents(apps))
  end if
  %></td></tr><%next%>
</table>
<%







' *******************************************************************************
' ����[ D ] Session �����б�
' *******************************************************************************

%>
<h2>Session �����б�</h2>
<table border=0 width=500 cellspacing=1 cellpadding=3>
  <tr class="backs"><td width="110">�� �� �� ��</td><td width="390">ֵ</td></tr>
  <%for each sens in Session.Contents%>
  <tr><td width="110"><%=sens%></td><td width="390"><%
  if isobject(Session.Contents(sens)) then
    Response.Write "[����]"
  elseif isarray(Session.Contents(sens)) then
    Response.Write "[����]"
  else
    Response.Write cHtml(Session.Contents(sens))
  end if
  %></td></tr><%next%>
</table>
<%




' *******************************************************************************
' ����[ G ] ������
' *******************************************************************************

  on error resume next
  OtT(0,0,0) = "MSWC.AdRotator"
  OtT(0,1,0) = "MSWC.BrowserType"
  OtT(0,2,0) = "MSWC.NextLink"
  OtT(0,3,0) = "MSWC.Tools"
  OtT(0,4,0) = "MSWC.Status"
  OtT(0,5,0) = "MSWC.Counters"
  OtT(0,6,0) = "IISSample.ContentRotator"
  OtT(0,7,0) = "IISSample.PageCounter"
  OtT(0,8,0) = "MSWC.PermissionChecker"
  OtT(0,9,0) = "Microsoft.XMLHTTP"
	OtT(0,9,1) = "(Http ���, ���ڲɼ�ϵͳ���õ�)"
  OtT(0,10,0) = "WScript.Shell"
	OtT(0,10,1) = "(Shell ���, �����漰��ȫ����)"
  OtT(0,11,0) = "Scripting.FileSystemObject"
	OtT(0,11,1) = "(FSO �ļ�ϵͳ�����ı��ļ���д)"
  OtT(0,12,0) = "Adodb.Connection"
	OtT(0,12,1) = "(ADO ���ݶ���)"
  OtT(0,13,0) = "Adodb.Stream"
	OtT(0,13,1) = "(ADO ����������, ����������������ϴ�������)"
	
  OtT(1,0,0) = "SoftArtisans.FileUp"
	OtT(1,0,1) = "(SA-FileUp �ļ��ϴ�)"
  OtT(1,1,0) = "SoftArtisans.FileManager"
	OtT(1,1,1) = "(SoftArtisans �ļ�����)"
  OtT(1,2,0) = "Ironsoft.UpLoad"
	OtT(1,2,1) = "(�������, �ϴ����)"
  OtT(1,3,0) = "LyfUpload.UploadFile"
	OtT(1,3,1) = "(���Ʒ���ļ��ϴ����)"
  OtT(1,4,0) = "Persits.Upload.1"
	OtT(1,4,1) = "(ASPUpload �ļ��ϴ�)"
  OtT(1,5,0) = "w3.upload"
	OtT(1,5,1) = "(Dimac �ļ��ϴ�)"

  OtT(2,0,0) = "JMail.SmtpMail"
	OtT(2,0,1) = "(Dimac JMail �ʼ��շ�) <a href='http://www.ajiang.net/products/aspcheck/coms.asp'>�����ֲ�����</a>"
  OtT(2,1,0) = "CDONTS.NewMail"
	OtT(2,1,1) = "(CDONTS)"
  OtT(2,2,0) = "CDO.Message"
	OtT(2,2,1) = "(CDOSYS)"
  OtT(2,3,0) = "Persits.MailSender"
	OtT(2,3,1) = "(ASPemail ����)"
  OtT(2,4,0) = "SMTPsvg.Mailer"
	OtT(2,4,1) = "(ASPmail ����)"
  OtT(2,5,0) = "DkQmail.Qmail"
	OtT(2,5,1) = "(dkQmail ����)"
  OtT(2,6,0) = "SmtpMail.SmtpMail.1"
	OtT(2,6,1) = "(SmtpMail ����)"
	
  OtT(3,0,0) = "SoftArtisans.ImageGen"
	OtT(3,0,1) = "(SA ��ͼ���д���)"
  OtT(3,1,0) = "W3Image.Image"
	OtT(3,1,1) = "(Dimac ��ͼ���д���)"
  OtT(3,2,0) = "Persits.Jpeg"
	OtT(3,2,1) = "(ASPJpeg)"
  OtT(3,3,0) = "XY.Graphics"
	OtT(3,3,1) = "(�������, ͼ��/ͼ����)"
  OtT(3,4,0) = "Ironsoft.DrawPic"
	OtT(3,4,1) = "(�������, ͼ��/ͼ�δ���)"
  OtT(3,5,0) = "Ironsoft.FlashCapture"
	OtT(3,5,1) = "(�������, �๦�� FLASH ��ͼ)"
  OtT(3,6,0) = "dyy.zipsvr"
	OtT(3,6,1) = "(�������, �����ļ�ѹ����ѹ���)"
  OtT(3,7,0) = "hin2.com_iis"
	OtT(3,7,1) = "(�������, ����IIS�������)"
  OtT(3,8,0) = "Socket.TCP"
	OtT(3,8,1) = "(Dimac ��˾�� Socket ���)"
	
%>


<h3>�� ����ϵͳ�Դ������</h3>
<table border=0 width=500 cellspacing=1 cellpadding=3>
  <tr class="backs"><td width="380">������Ƽ����</td><td width="120">֧��/�汾</td></tr>
  <%
  k=0
  for i=0 to 13
    call ObjTest(OtT(k,i,0))
  %>
  <tr><td width="380"><%=OtT(k,i,0) & " <font color='#888888'>" & OtT(k,i,1) & "</font>"%></td><td width="120" title="<%=VerObj%>"><%=cIsReady(isobj) & " " & left(VerObj,10)%></td></tr>
  <%next%>
</table>

<h3>�� �����ļ��ϴ��͹������</h3>
<table border=0 width=500 cellspacing=1 cellpadding=3>
  <tr class="backs"><td width="380">������Ƽ����</td><td width="120">֧��/�汾</td></tr>
  <%
  k=1
  for i=0 to 5
    call ObjTest(OtT(k,i,0))
  %>
  <tr><td width="380"><%=OtT(k,i,0) & " <font color='#888888'>" & OtT(k,i,1) & "</font>"%></td><td width="120" title="<%=VerObj%>"><%=cIsReady(isobj) & " " & left(VerObj,10)%></td></tr>
  <%next%>
</table>

<h3>�� �����ʼ��������</h3>
<table border=0 width=500 cellspacing=1 cellpadding=3>
  <tr class="backs"><td width="380">������Ƽ����</td><td width="120">֧��/�汾</td></tr>
  <%
  k=2
  for i=0 to 6
    call ObjTest(OtT(k,i,0))
  %>
  <tr><td width="380"><%=OtT(k,i,0) & " <font color='#888888'>" & OtT(k,i,1) & "</font>"%></td><td width="120" title="<%=VerObj%>"><%=cIsReady(isobj) & " " & left(VerObj,10)%></td></tr>
  <%next%>
</table>

<h3>�� �����������</h3>
<table border=0 width=500 cellspacing=1 cellpadding=3>
  <tr class="backs"><td width="380">������Ƽ����</td><td width="120">֧��/�汾</td></tr>
  <%
  k=3
  for i=0 to 8
    call ObjTest(OtT(k,i,0))
  %>
  <tr><td width="380"><%=OtT(k,i,0) & " <font color='#888888'>" & OtT(k,i,1) & "</font>"%></td><td width="120" title="<%=VerObj%>"><%=cIsReady(isobj) & " " & left(VerObj,10)%></td></tr>
  <%next%>
</table>

<p>
<%
	







' *******************************************************************************
' ����[ H ] ������Ϣ
' *******************************************************************************

  on error resume next

  ObjTest("Scripting.FileSystemObject")
  if isobj then
	set fsoobj=server.CreateObject("Scripting.FileSystemObject")

%>

<h2>���̺��ļ���</h2>

<h3>�� ������������Ϣ</h3>

<table border=0 width=500 cellspacing=1 cellpadding=3>
  <tr align=center class="backs">
	<td width="100">�̷��ʹ�������</td>
	<td width="50">����</td>
	<td width="110">���</td>
	<td width="80">�ļ�ϵͳ</td>
	<td width="80">���ÿռ�</td>
	<td width="80">�ܿռ�</td>
  </tr>
<%

	' ���Դ�����Ϣ���뷨���ԡ�COCOON ASP ̽�롱
	
	set drvObj=fsoobj.Drives
	for each d in drvObj
%>
  <tr align="center" class="backq">
	<td align="right"><%=cdrivetype(d.DriveType) & " " & d.DriveLetter%>:</td>
<%
	if d.DriveLetter = "A" then	'Ϊ��ֹӰ������������������
		Response.Write "<td></td><td></td><td></td><td></td><td></td>"
	else
%>
	<td><%=cIsReady(d.isReady)%></td>
	<td><%=d.VolumeName%></td>
	<td><%=d.FileSystem%></td>
	<td align="right"><%=cSize(d.FreeSpace)%></td>
	<td align="right"><%=cSize(d.TotalSize)%></td>
<%
	end if
%>
  </tr>
<%
	next
%>
</td></tr>
</table>
<p>��<font color=red><b>��</b></font>����ʾ����û�о������ߵ�ǰIISվ��û�жԸô��̵Ĳ���Ȩ�ޡ�

<h3>�� ��ǰ�ļ�����Ϣ</h3>
<%

Response.Flush


	dPath = server.MapPath("./")
	set dDir = fsoObj.GetFolder(dPath)
	set dDrive = fsoObj.GetDrive(dDir.Drive)
%>
<p>�ļ���: <%=dPath%></p>
<table border=0 width=500 cellspacing=1 cellpadding=3>
  <tr height="18" align="center" class="backs">
	<td width="75">���ÿռ�</td>
	<td width="75">���ÿռ�</td>
	<td width="75">�ļ�����</td>
	<td width="75">�ļ���</td>
	<td width="200">����ʱ��</td>
  </tr>
  <tr height="18" align="center" class="backq">
	<td><%=cSize(dDir.Size)%></td>
	<td><%=cSize(dDrive.AvailableSpace)%></td>
	<td><%=dDir.SubFolders.Count%></td>
	<td><%=dDir.Files.Count%></td>
	<td><%=dDir.DateCreated%></td>
  </tr>
</td></tr>
</table>

<%
Response.Flush

end if






' *******************************************************************************
' ����[ J ] �ű������ٶ�
' *******************************************************************************

%>
<h2>ASP�ű����ͺ������ٶȲ���</h2><p>
<%
Response.Flush

	'��л����ͬѧ¼ http://www.5719.net �Ƽ�ʹ��timer����
	'��Ϊֻ����50��μ��㣬����ȥ�����Ƿ����ѡ���ֱ�Ӽ��
	
	Response.Write "����������ԣ����ڽ���50��μӷ�����..."
	dim t1,t2,lsabc,thetime,thetime2
	t1=timer
	for i=1 to 500000
		lsabc= 1 + 1
	next
	t2=timer
	thetime=cstr(int(( (t2-t1)*10000 )+0.5)/10)
	Response.Write "...����ɣ�<font color=red>" & thetime & "����</font>��<br>"


	Response.Write "����������ԣ����ڽ���20��ο�������..."
	t1=timer
	for i=1 to 200000
		lsabc= 2^0.5
	next
	t2=timer
	thetime2=cstr(int(( (t2-t1)*10000 )+0.5)/10)
	Response.Write "...����ɣ�<font color=red>" & thetime2 & "����</font>��<br>"
%></p>
<table border=0 width=500 cellspacing=1 cellpadding=3>
  <tr align=center class="backs">
	<td width=350>�����յķ����������ʱ��(����)</td>
    <td width=75>��������</td><td width=75>��������</td>
  </tr>
  <tr>
	<td><a class="a1" target="_blank" href="http://www.100u.com?come=aspcheck&keyword=��������"
	>���ſƼ� 100u ����, <font color=#888888>2003-11-1</font></a></td><td>&nbsp;181��233</td><td>&nbsp;156��218</td>
  </tr>
  <tr>
	<td><a class="a1" target="_blank" href="http://www.west263.net/index.asp?ads=ajiang"
	>�������� west263 ����, <font color=#888888>2003-11-1</font></a></td><td>&nbsp;171��233</td><td>&nbsp;156��171</td>
  </tr>
  <tr>
	<td><a class="a1" target="_blank" href="http://www.163n.com "
	>������� 163n ����,  <font color=#888888>2006-1-4</font></a></td><td>&nbsp;156��171</td><td>&nbsp;140��156</td>
  </tr>
  <tr>
	<td><a class="a1" target="_blank" href="http://www.9s5.com/"
	>������www.9s5.comȫ����(ASP+PHP+JSP)����,<font color=#888888>2003-11-1</font></a></td><td>&nbsp;171��187</td><td>&nbsp;156��171</td>
  </tr>
  <tr>
	<td><a class="a1" target="_blank" href="http://www.dnsmy.com/"
	>��Ѷ���� Dnsmy ����, <font color=#888888>2003-11-1</font></a></td><td>&nbsp;155��180</td><td>&nbsp;122��172</td>
  </tr>
  <tr>
	<td><a class="a1" target="_blank" href="http://www.senye.com"
	>ʤ���� senye.com ����, <font color=#888888>2004-3-28</font></a></td><td>&nbsp;156��171</td><td>&nbsp;140��156</td>
  </tr>
  <tr>
	<td><font color=red>��̨������: <%=Request.ServerVariables("SERVER_NAME")%></font>&nbsp;</td><td>&nbsp;<font color=red><%=thetime%></font></td><td>&nbsp;<font color=red><%=thetime2%></font></td>
  </tr>
</table>

<%


' *******************************************************************************
' ���������������ӳ���
' *******************************************************************************





' ת���ִ�ΪHTML����
function cHtml(iText)
  cHtml = iText
  cHtml = server.HTMLEncode(cHtml)
  cHtml = replace(cHtml,chr(10),"<br>")
end function

' ת����������Ϊ����
function cdrivetype(tnum)
  Select Case tnum
    Case 0: cdrivetype = "δ֪"
    Case 1: cdrivetype = "���ƶ�����"
    Case 2: cdrivetype = "����Ӳ��"
    Case 3: cdrivetype = "�������"
    Case 4: cdrivetype = "CD-ROM"
    Case 5: cdrivetype = "RAM ����"
  End Select
end function

' ���Ƿ����ת��Ϊ�Ժźʹ��
function cIsReady(trd)
  Select Case trd
    case true: cIsReady="<font class=fonts><b>��</b></font>"
    case false: cIsReady="<font color='red'><b>��</b></font>"
  End Select
end function

' ת���ֽ���Ϊ��д��ʽ
function cSize(tSize)
  if tSize>=1073741824 then
    cSize=int((tSize/1073741824)*1000)/1000 & " GB"
  elseif tSize>=1048576 then
    cSize=int((tSize/1048576)*1000)/1000 & " MB"
  elseif tSize>=1024 then
    cSize=int((tSize/1024)*1000)/1000 & " KB"
  else
    cSize=tSize & "B"
  end if
end function

'�������Ƿ�֧�ּ�����汾���ӳ���
sub ObjTest(strObj)
  on error resume next
  IsObj=false
  VerObj=""
  set TestObj=server.CreateObject (strObj)
  If -2147221005 <> Err then		'��л����iAmFisher�ı�����
    IsObj = True
    VerObj = TestObj.version
    if VerObj="" or isnull(VerObj) then VerObj=TestObj.about
  end if
  set TestObj=nothing
End sub

%>

<br>
<span style=" text-align:center;"><a href="mainFrame.asp">�����ع�����ҳ��</a></span>
<br>
 
</body>
</html>