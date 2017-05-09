<%@ Language="VBScript" CODEPAGE="936"%>
<% Option Explicit %>
<%
Response.Buffer = True
'####################################
'#                                  #
'#      ITlearner ASP̽�� V1.4      #
'#                                  #
'#     http://www.itlearner.com     #
'#                                  #
'#    ת�ر�����ʱ�뱣����Щ��Ϣ    #
'#                                  #
'####################################


	Dim startime,FileName,WebName,WebUrl,SysName,SysNameE,SysVersion
	startime=timer()


'####################################
'#                                  #
'#      ���ຯ���͹���              #
'#                                  #
'####################################

	'�������Ƿ�֧��
	Function IsObjInstalled(strClassString)
		On Error Resume Next
		Dim xTestObj
		Set xTestObj = Server.CreateObject(strClassString)
		If Err Then
			IsObjInstalled = False
		else
			IsObjInstalled = True
		end if
		Set xTestObj = Nothing
	End Function

	'�������汾
	Function getver(Classstr)
		On Error Resume Next
		Dim xTestObj
		Set xTestObj = Server.CreateObject(Classstr)
		If Err Then
			getver=""
		else
		 	getver=xTestObj.version
		end if
		Set xTestObj = Nothing
	End Function

  '�õ������Ϣ�����
	Sub GetObjInfo(startnum,endnum)
  '�������
  Dim theTestObj(25,2)

	theTestObj(0,0) = "MSWC.AdRotator"
	theTestObj(1,0) = "MSWC.BrowserType"
	theTestObj(2,0) = "MSWC.NextLink"
	theTestObj(7,0) = "WScript.Shell"
	theTestObj(8,0) = "Microsoft.XMLHTTP"
	theTestObj(9,0) = "Scripting.FileSystemObject"
	theTestObj(9,1) = "(FSO �ı��ļ���д)"
	theTestObj(10,0) = "ADODB.Connection"
	theTestObj(10,1) = "(ADO ���ݶ���)"

	theTestObj(11,0) = "SoftArtisans.FileUp"
	theTestObj(11,1) = "(SA-FileUp �ļ��ϴ�)"
	theTestObj(12,0) = "Persits.Upload"
	theTestObj(12,1) = "(ASPUpload �ļ��ϴ�)"
	theTestObj(13,0) = "LyfUpload.UploadFile"
	theTestObj(13,1) = "(���Ʒ���ļ��ϴ����)"
	theTestObj(14,0) = "SoftArtisans.ImageGen"
	theTestObj(14,1) = "(SA ��ͼ���д���)"
	theTestObj(15,0) = "Persits.Jpeg"
	theTestObj(15,1) = "(ASPJPEG:ͼ���д���)"

	'�ʼ�����
	theTestObj(16,0) = "JMail.SmtpMail"
	theTestObj(16,1) = "(Dimac JMail �ʼ��շ�)"
	theTestObj(17,0) = "CDONTS.NewMail"
	theTestObj(17,1) = "(���� SMTP ����)"
	theTestObj(18,0) = "Persits.MailSender"
	theTestObj(18,1) = "(ASPemail ����)"

		Dim i,Outstr,theObj
		For i=startnum To endnum
      theObj = theTestObj(i,0)
      If theObj <> "" then
	      	Outstr = Outstr & "<tr class=""hx_tr1""><td>" & theObj
	      	if theTestObj(i,1) <> "" then Outstr = Outstr & "<span class=""font_1"">"&theTestObj(i,1)&"</span>"
	      	Outstr = Outstr & "</td>"
	    	If Not IsObjInstalled(theTestObj(i,0)) Then
	      	Outstr = Outstr & "<td><span class=""font_2""><b>��</b></span></td>"
	    	Else
	      	Outstr = Outstr & "<td><span class=""font_3""><b>��</b></span> " & getver(theTestObj(i,0)) & "</td>"
			End If
	      	Outstr = Outstr & "</tr>" & vbCrLf
	    End If
		next
		Response.Write(Outstr)
	End Sub

  '��ʽ����С
	Function formatdsize(dsize)
	    if dsize>=1073741824 then
			formatdsize=Formatnumber(dsize/1073741824,2) & " GB"
	    elseif dsize>=1048576 then
	    	formatdsize=Formatnumber(dsize/1048576,2) & " MB"
	    elseif dsize>=1024 then
			formatdsize=Formatnumber(dsize/1024,2) & " KB"
		else
			formatdsize=dsize & "B"
		end if
	End Function

  '��ʽ�����
	Function formatvariables(str)
		on error resume next
		str = cstr(server.htmlencode(str))
		formatvariables=replace(str,chr(10),"<br/>")
	End Function

  'ҳβ���
	Sub ShowFooter()
		dim Endtime,Runtime,OutStr
		Endtime=timer()
		OutStr = "<div id=""bottom"">"
		OutStr = OutStr & "<p><a href=""http://www.itlearner.com"" target=""_blank"">ITѧϰ��</a> | <a href=""http://www.9enjoy.com"" target=""_blank"">����Blog</a> | <a href=""http://www.aspcheck.org/"" target=""_blank"">�������°�</a><br/>" & vbcrlf
	 	Runtime=FormatNumber((endtime-startime)*1000,2)
		if Runtime>0 then
			if Runtime>1000 then
				OutStr = OutStr & "ҳ��ִ��ʱ�䣺Լ"& FormatNumber(runtime/1000,2) & "��"
			else
				OutStr = OutStr & "ҳ��ִ��ʱ�䣺Լ"& Runtime & "����"
			end if
		end if
		OutStr = OutStr & "&nbsp;&nbsp;"
		OutStr = OutStr & "<a href=""http://www.asp" & "check.org"" target=""_blank"">ITlearner AspCheck " & SysVersion & "</a>"
		OutStr = OutStr & "</p></div>"
		Response.Write(OutStr)
	End Sub

	Function getEngVerVBS()
		getEngVerVBS = ScriptEngineMajorVersion() & "." & ScriptEngineMinorVersion() & "." & ScriptEngineBuildVersion()
	End Function

	'ϵͳ����
	WebName   ="ITѧϰ��"
	WebUrl    ="http://www.itlearner.com"
	SysName   ="ASP̽��"
	SysNameE  ="AspCheck"
	SysVersion="V1.4"
	FileName  =Request.ServerVariables("SCRIPT_NAME")
	if InStr(FileName,"/") then FileName = right(FileName,len(FileName)-InStrRev(FileName,"/"))

dim action
action=request("action")
select case action
case ""
  Call HeadInfo("")
  Call SystemTest
  Call ObjTest
  Call CalcuateTest
case "Custom_ObjInfo"
  Call HeadInfo("������������")
%><div class="frame_box"><%Call Custom_ObjInfo%></div><%
case "DriveTest"
  Call HeadInfo("������������Ϣ")
  Call DriveTest
case "CalcuateTest"
  Call HeadInfo("��������������")
  Call CalcuateTest
case "SpeedTest"
  Call HeadInfo("�����������ٶ�")
  Call SpeedTest
case "SystemCheck"
  Call HeadInfo("ϵͳ�û�(��)�ͽ��̼��")
	Call SystemCheck
case else
  Call HeadInfo("")
  Call SystemTest
end select

Call ShowFooter

Sub HeadInfo(str)
  dim pagetitle
  pagetitle = "ITѧϰ��ASP̽��(ITlearner AspCheck) " & SysVersion
  if str <> "" then pagetitle = str & "_" & pagetitle
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312" />
<title><%=pagetitle%></title>
<style type="text/css">
<!--
body		{font-size:12px;margin-left:50px;background:#FFF;line-height:1.5;font-family:����,arial;color:#000;}
td,span {font-size:12px;word-wrap:break-word;word-break:break-all;overflow:hidden;line-height:1.2;}
form		{margin:0;}
a       {color:#000;text-decoration:none}
a:hover {color:#F00;text-decoration:underline;}
#top		{width:600px;margin:8px 0;text-align:center;}
#bottom	{border:1px dotted #183789;width:598px;margin-top:10px;text-align:center;padding:5px 0;}
h1			{font-size:30px;margin:0;}
h1 sub	{font-size:14px;font-weight:normal;}
.input  {border:1px solid #0099CF;}
.btn_c  {background:#0099CF;border:1px solid #0099CF;color:#FFF;font-size:12px;}
.PicBar {background:#0099CF;border:1px solid #000;height:12px;vertical-align:middle;float:left;}
.PicTxt {float:left;}
#txt_speed{position:absolute;height:30px;z-index:1000;}
.frame_box{border:0;width:600px;margin-top:5px;clear:both;}
.frame_box h3{background:#0099CF;text-align:center;color:#FFF;padding:3px;font-weight:bold;margin:0;font-size:12px;width:594px;}
.item_content{width:600px;}
.hx_tr1{text-indent:8px;background:#FFF;}
.hx_tr2{background:#FFF;}
.hx_tr3{text-align:center;background:#FFF;height:18px;}
.font_1{color:#888;}
.font_2{color:#080;}
.font_3{color:#F00;}
.table1{background:#0099CF;width:100%;border:0;}
th{background:#9CF;text-indent:6px;font-weight:normal;text-align:left;}
.table2{background:#0099CC;width:600px;}
-->
</style>
</head>
<body>
<a name="top"></a>
<div id="top">
<h1><a href="<%=FileName%>">ASP̽��</a><sub> - <a href="http://www.aspcheck.org" target="_blank"><%=SysVersion%></a>(<a href="http://www.itlearner.com" target="_blank">ITlearner</a>)</sub></h1>
</div>
<div id="menu">ѡ�<a href="<%=FileName%>#SystemTest">�������йز���</a> | <a href="<%=FileName%>#ObjTest">������������</a> | <a href="?action=CalcuateTest">��������������</a> | <a href="?action=DriveTest">������������Ϣ</a> | <a href="?action=SpeedTest">�����������ٶ�</a><br/>
��ȫ��<a href="?action=SystemCheck">ϵͳ�û�(��)�ͽ��̼��</a></div>
<%
End Sub

Sub SystemTest
on error resume next
Dim ServerName,ServerOS,Processors_no
ServerName = Request.ServerVariables("SERVER_NAME")
ServerOS = Request.ServerVariables("OS")
Processors_no = Request.ServerVariables("NUMBER_OF_PROCESSORS")
'win2003�޷���������������Ķ�ȡ��ʽ 080728
if ServerOS = "" or Processors_no = "" then
  Set WshShell = server.CreateObject("WScript.Shell")
  Set WshSysEnv = WshShell.Environment("SYSTEM")
  ServerOS = WshSysEnv("OS")
  Processors_no = WshSysEnv("NUMBER_OF_PROCESSORS")
  Set WshShell = nothing
end if
'������WScript.Shell���ͻ�ȡ���� 080802
if ServerOS = "" then ServerOS = "����"
if Processors_no = "" then
  Processors_no = "����"
else
  Processors_no = Processors_no & "��"
end if
%>
<script language="JavaScript" runat="server">
	function getEngVerJs(){
		try{
			return ScriptEngineMajorVersion() +"."+ScriptEngineMinorVersion()+"."+ ScriptEngineBuildVersion() + " ";
		}catch(e){
			return "��������֧�ִ�����";
		}
	}
</script>
<a name="SystemTest"></a>
<div class="frame_box">
	<h3>�������йز���</h3>
	<div class="item_content" id="submenu0">
		<table border="0" cellspacing="1" cellpadding="3" class="table1">
        <tr class="hx_tr1">
          <td width="100">��������</td>
          <td width="185"><%=ServerName%></td>
          <td width="100">����������ϵͳ</td>
          <td width="184"><%=ServerOS%></td>
        </tr>
        <tr class="hx_tr1">
          <td>������IP</td>
          <td><%=Request.ServerVariables("LOCAL_ADDR")%></td>
          <td>�������˿�</td>
          <td><%=Request.ServerVariables("SERVER_PORT")%></td>
        </tr>
        <tr class="hx_tr1">
          <td>������ʱ��</td>
          <td><%=now%></td>
          <td>������CPUͨ����</td>
          <td><%=Processors_no%></td>
        </tr>
        <tr class="hx_tr1">
          <td>IIS�汾</td>
          <td><%=Request.ServerVariables("SERVER_SOFTWARE")%></td>
          <td>�ű���ʱʱ��</td>
          <td><%=Server.ScriptTimeout%> ��</td>
        </tr>
        <tr class="hx_tr1">
          <td>Application����</td>
          <td><%Response.Write(Application.Contents.Count & "�� ")
		  if Application.Contents.count>0 then Response.Write("[<a href=""?action=showapp"">����Application����</a>]")%>
          </td>
          <td>Session����</td>
          <td><%Response.Write(Session.Contents.Count&"�� ")
		  if Session.Contents.count>0 then Response.Write("[<a href=""?action=showsession"">����Session����</a>]")%>
          </td>
        </tr>
        <tr class="hx_tr1">
          <td><a href="?action=showvariables">���з���������</a></td>
          <td><%Response.Write(Request.ServerVariables.Count&"�� ")
		  if Request.ServerVariables.Count>0 then Response.Write("[<a href=""?action=showvariables"">��������������</a>]")%>
          </td>
          <td>��������������</td>
          <td><%
			dim WshShell,WshSysEnv
			Set WshShell = server.CreateObject("WScript.Shell")
			Set WshSysEnv = WshShell.Environment
			if err then
				Response.Write("��������֧��WScript.Shell���")
				err.clear
			else
				Response.Write(WshSysEnv.count &"�� ")
				if WshSysEnv.count>0 then Response.Write("[<a href=""?action=showwsh"">������������</a>]")
		 	end if
		  %>
          </td>
        </tr>
        <tr class="hx_tr1">
          <td>��������������</td>
          <td colspan="3">JScript: <%= getEngVerJs() %> | VBScript: <%=getEngVerVBS()%></td>
        </tr>
        <tr class="hx_tr1">
          <td>���ļ�ʵ��·��</td>
          <td colspan="3"><%=server.mappath(Request.ServerVariables("SCRIPT_NAME"))%></td>
        </tr>
      </table>
      <%
if action="showapp" or action="showsession" or action="showvariables" or action="showwsh" then
	showvariable(action)
end if
%>
	</div>
</div>
<%
End Sub

Sub showvariable(action)
%>
<table border="0" cellpadding="3" cellspacing="1" class="table2">
  <tr>
    <th colspan="2">
      <%
	'on error resume next
	dim Item,xTestObj,outstr
		Response.Write("�� ")
	if action="showapp" then
		Response.Write("����Application����")
		set xTestObj=Application.Contents
	elseif action="showsession" then
		Response.Write("����Session����")
		set xTestObj=Session.Contents
	elseif action="showvariables" then
		Response.Write("��������������")
		set xTestObj=Request.ServerVariables
	elseif action="showwsh" then
		Response.Write("������������")
		dim WshShell
		Set WshShell = server.CreateObject("WScript.Shell")
		set xTestObj=WshShell.Environment
	end if
		Response.Write "(<a href="""&FileName&""">�ر�</a>)"
	%>
    </th>
  </tr>
  <tr class="hx_tr2">
    <td width="100">������</td>
    <td width="485">ֵ</td>
  </tr>
  <%
	if err then
		outstr = "<tr class=""hx_tr2""><td colspan=""2"">û�з��������ı���</td></tr>"
		err.clear
	else
		dim w
		if action="showwsh" then
			for each Item in xTestObj
				w=split(Item,"=")
				outstr = outstr & "<tr class=""hx_tr2"">"
				outstr = outstr & "<td width=""100"">" & w(0) & "</td>"
				outstr = outstr & "<td width=""485"">" & w(1) & "</td>"
				outstr = outstr & "</tr>"
			next
		else
			dim i
			for each Item in xTestObj
				outstr = outstr & "<tr class=""hx_tr2"">"
				outstr = outstr & "<td width=""100"">" & Item & "</td>"
				outstr = outstr & "<td width=""485"">"
        if IsObject(xTestObj(Item)) then
          outstr = outstr & formatvariables(xTestObj(Item))
          if err then
            outstr = outstr & "[����]"
          end if
        elseif IsArray(xTestObj(Item)) then
          outstr = outstr & "[����]"
        else
          outstr = outstr & formatvariables(xTestObj(Item))
        end if
				outstr = outstr & "</td>"
				outstr = outstr & "</tr>"
			next
		end if
	end if
		Response.Write(outstr)
		set xTestObj=nothing
		%>
</table>
<%End Sub%>
<%Sub ObjTest

%>
<script type="text/javascript">
<!--
function Checksearchbox(form1){
if(form1.classname.value == "")
{
	alert("��������Ҫ�����������");
	form1.classname.focus();
	return false;
}
}
-->
</script>
<a name="ObjTest"></a>
<div class="frame_box">
	<h3>������������</h3>
	<div class="item_content" id="submenu1">
			<table border="0" cellspacing="1" cellpadding="3" class="table1">
        <tr>
          <th colspan="2">�� IIS�Դ���ASP���</th>
        </tr>
        <tr class="hx_tr1">
          <td width="440">�� �� �� ��</td>
          <td width="145">֧�ּ��汾</td>
        </tr>
        <%GetObjInfo 0,10%>
        <tr>
          <th colspan="2">�� ��վ������� </th>
        </tr>
        <tr class="hx_tr1">
          <td>�� �� �� ��</td>
          <td>֧�ּ��汾</td>
        </tr>
        <%GetObjInfo 11,20%>
				<tr class="hx_tr1">
          <td colspan="2"><a href="http://www.9enjoy.com/post/295/" target="_blank">����ASP������غ�ʹ�÷���</a></td>
        </tr>
      </table>
      <%Call Custom_ObjInfo()%>
	</div>
</div>
<%
End Sub
Sub Custom_ObjInfo%>
      <table border="0" cellspacing="1" cellpadding="3" class="table1">
				<tr>
          <th>�� �������֧�������� </th>
        </tr>
        <tr class="hx_tr2">
          <td height="30">
          <form action="?action=Custom_ObjInfo" method="post">
          ������Ҫ���������ProgId��ClassId
              <input class="input" type="text" value="" name="classname" size="40" />
              <input type="submit" value="ȷ��" class="btn_c" name="submit1" onclick="return Checksearchbox(this.form);" />
          </form>
          </td>
				</tr>
<%
		Dim strClass
    strClass = Trim(Request.Form("classname"))
    If strClass <> "" then

    Response.Write "<tr class=""hx_tr2""><td height=""30"">��ָ��������ļ������"
      If Not IsObjInstalled(strClass) then
        Response.Write "<span class=""font_3"">���ź����÷�������֧��" & strclass & "�����</span>"
      Else
        Response.Write "<span class=""font_3"">"
		Response.Write " ��ϲ���÷�����֧��" & strclass & "�����"
		If getver(strclass)<>"" then
		Response.Write " ������汾�ǣ�" & getver(strclass)
		End if
		Response.Write "</span>"
      End If
      Response.Write "</td></tr>"
    end if
%>
      </table>

<%End Sub

Sub CalcuateTest
%><a name="CalcuateTest"></a>
<div class="frame_box">
	<h3>��������������</h3>
	<div class="item_content" id="submenu2">
			<table border="0" cellspacing="1" cellpadding="3" class="table1">
        <tr>
          <th colspan="3">�� �÷�����ִ��50��μӷ�(��������)��20��ο���(��������)����¼����ʹ�õ�ʱ�䡣
          </th>
        </tr>
        <tr class="hx_tr3">
          <td width="400">�� �� �� �� �� �� �� �� �� ��</td>
          <td width="100">��������</td>
          <td width="100">��������</td>
        </tr>
        <tr class="hx_tr1">
          <td><a href="http://www.9enjoy.com/post/277/" target="_blank">ITlearner08������ĵ���</a> (CPU:���2 E4500 2.2G �ڴ�:2G)</td>
          <td>93.75 ����</td>
          <td>109.38 ����</td>
        </tr>
        <tr class="hx_tr1">
          <td><a href="http://www.itlearner.com" target="_blank">ITlearner05����Ϸ�����</a> (CPU:P4 3.0G(1M) �ڴ�:1.5G)</td>
          <td>187.50 ����</td>
          <td>171.88 ����</td>
        </tr>
        <tr class="hx_tr1">
          <td><a href="http://www.aspcheck.org/aspcheck.asp" target="_blank">Godaddy��Windows������(Deluxe Plan)</a> [2008/07/29]</td>
          <td>93.99 ����</td>
          <td>125.00 ����</td>
        </tr>
        <tr class="hx_tr1">
          <td><a href="http://www.iva.cn" target="_blank">���߿Ƽ���������</a>&nbsp; [2008/07/29]</td>
          <td>109.38 ����</td>
          <td>109.86 ����</td>
        </tr>
        <%
	dim i,t1,t2,tempvalue,runtime1,runtime2
	'��ʼ����50��μӷ�����ʱ��
	t1=timer()
	for i=1 to 500000
		tempvalue= 1 + 1
	next
	t2=timer()
	runtime1=formatnumber((t2-t1)*1000,2)

	'��ʼ����20��ο�������ʱ��
	t1=timer()
	for i=1 to 200000
		tempvalue= 2^0.5
	next
	t2=timer()
	runtime2=formatnumber((t2-t1)*1000,2)
%>
        <tr class="hx_tr1">
          <td><span class="font_3">������ʹ�õ���̨������</span>&nbsp; <input name="button" type="button" class="btn_c"  onclick="document.location.href='<%=FileName%>?action=CalcuateTest'" value="���²���" />
          </td>
          <td><span class="font_3"><%=runtime1%> ����</span></td>
          <td><span class="font_3"><%=runtime2%> ����</span></td>
        </tr>
      </table>
	</div>
</div>
<%
End Sub
Sub DriveTest
	On Error Resume Next
	Dim fo,d,xTestObj
	set fo=Server.Createobject("Scripting.FileSystemObject")
	set xTestObj=fo.Drives
%>
<a name="DriveTest"></a>
<div class="frame_box">
	<h3>������������Ϣ</h3>
	<div class="item_content" id="submenu4">
		<%if IsObjInstalled("Scripting.FileSystemObject") then%>
      <table border="0" cellspacing="1" cellpadding="3" class="table1">
        <tr>
          <th colspan="7">�� ������������Ϣ</th>
        </tr>
        <tr class="hx_tr1">
          <td width="90">��������</td>
          <td width="60">�̷�</td>
          <td width="40">����</td>
          <td width="80">���</td>
          <td width="80">�ļ�ϵͳ</td>
          <td width="100">���ÿռ�</td>
		      <td width="100">�ܿռ�</td>
        </tr>
		<%
  Dim dtype
  dtype = Array("δ֪","���ƶ�����","����Ӳ��","�������","CD-ROM","RAM ����")
	for each d in xTestObj
		Response.write "<tr class=""hx_tr1"">"
		Response.write "<td>"&dtype(d.DriveType)&"</td>"
		Response.write "<td>"&d.DriveLetter&"</td>"
		if d.DriveLetter = "A" then
		Response.Write "<td colspan=""5"">Ϊ��ֹӰ������������������</td>"
		else
		Response.write "<td>"
		if d.isready then
			Response.Write "��"
			Response.write "</td>"
			Response.write "<td>"&d.VolumeName&"</td>"
			Response.write "<td>"&d.FileSystem&"</td>"
			Response.write "<td>"&formatdsize(d.FreeSpace)&"</td>"
			Response.write "<td>"&formatdsize(d.TotalSize)&"</td>"
		else
			Response.Write "��"
			Response.Write "<td colspan=4>&nbsp;�����Ǵ��������⣬���߳���û�ж�ȡȨ��</td>"
		end if
		end if
	next%>
      </table>
	  <%
	Dim filePath,fileDir,fileDrive
	filePath = server.MapPath(".")
	set fileDir = fo.GetFolder(filePath)
	set fileDrive = fo.GetDrive(fileDir.Drive)
	  %>
      <table border="0" cellspacing="1" cellpadding="3" class="table1">
        <tr>
          <th colspan="6">�� ��ǰ�ļ�����Ϣ (<%=filePath%>)</th>
        </tr>
        <tr class="hx_tr3">
          <td width="90">���ÿռ�</td>
          <td width="80">���ÿռ�</td>
          <td width="50">�ļ�����</td>
          <td width="50">�ļ���</td>
          <td width="143">����ʱ��</td>
          <td width="144">�޸�ʱ��</td>
        </tr>
        <%
		Response.write "<tr class=""hx_tr3"">"
		Response.write "<td>"&formatdsize(fileDir.Size)&"</td>"
		Response.write "<td>"
		Response.write formatdsize(fileDrive.AvailableSpace)
		if err then Response.write "û��Ȩ�޶�ȡ" : error.clear
		Response.write "</td>"
		Response.write "<td>"&fileDir.SubFolders.Count&"</td>"
		Response.write "<td>"&fileDir.Files.Count&"</td>"
		Response.write "<td>"&fileDir.DateCreated&" </td> "
		Response.write "<td>"&fileDir.DateLastModified&" </td> "
%>
      </tr></table>
<%
	Dim i,t1,t2,runtime,TestFileName
	Dim tempfo
	t1= timer()
	for i=1 to 30
	TestFileName=server.mappath("Hx_Test_"&i&".txt")
	set tempfo=fo.CreateTextFile(TestFileName,true)
		tempfo.WriteLine "Create:It's a hxtest file."
	set tempfo=nothing
	if err then err.clear
	set tempfo=fo.OpenTextFile(TestFileName,8,0)
		tempfo.WriteLine "Appending:It's a hxtest file."
	set tempfo=nothing
	set tempfo=fo.GetFile(TestFileName)
		tempfo.delete True
	set tempfo=nothing
	if err then
	  runtime = "��ǰĿ¼û��Ȩ�޴����ļ����޷�����!"
		error.clear
		Exit For
	end if
	next

	if runtime = "" then
	t2=	timer()
	runtime=formatnumber((t2-t1)*1000,2)
	if runtime = 0 then
		runtime = "��ǰĿ¼û��Ȩ�޴����ļ����޷�����!"
	else
		runtime = runtime & "����"
	end if
  end if
%>
      <a name="filetest"></a>
      <table border="0" cellspacing="1" cellpadding="3" class="table1">
        <tr>
          <th colspan="2">�� �����ļ������ٶȲ��� (�ظ�������д�롢׷�Ӻ�ɾ���ı��ļ�30�Σ���¼����ʹ�õ�ʱ��)</th>
        </tr>
        <tr class="hx_tr3">
          <td width="400">�� �� �� �� �� �� �� �� �� ��</td>
          <td width="200">���ʱ��</td>
        </tr>
        <tr class="hx_tr1">
          <td>ITlearner08������ĵ��� (CPU:���2 E4500 2.2G �ڴ�:2G)</td>
          <td>62.50 ~ 78.13 ����</td>
        </tr>
        <tr class="hx_tr1">
          <td>ITlearner05����Ϸ����� (CPU:P4 3.0G(1M) �ڴ�:1.5G)</td>
          <td>46.88 ~ 62.50 ����</td>
        </tr>
        <tr class="hx_tr1">
          <td>Godaddy��Windows������(Deluxe Plan) [2008/07/29]</td>
          <td>15.63 ~ 16.11����</td>
        </tr>
        <tr class="hx_tr1">
          <td><span class="font_3">������ʹ�õ���̨������</span>&nbsp; <input name="button2" type="button" class="btn_c" onclick="document.location.reload()" value="���²���" />
          </td>
          <td><span class="font_3"><%=runtime%></span></td>
        </tr>
      </table>
      <%
	  	else
		Response.write "&nbsp;���ķ����������õĿռ䲻֧��FSO������޷����д������!"
	end if%>
	</div>
</div>
<%
End Sub
Sub SpeedTest
%>
<a name="SpeedTest"></a>
<div class="frame_box">
	<h3>�����������ٶ�</h3>
<%	if action="SpeedTest" then%>
	<div id="txt_speed">���ٲ����У����Ժ�...</div>
<%	end if%>
	<div class="item_content" id="submenu3">
			<table cellspacing="1" cellpadding="3" class="table1">
        <tr>
          <th colspan="3">�� ��ͻ������100k�ֽڣ���¼����ʱ�䣬����������ٶ�</th>
        </tr>
        <tr class="hx_tr1">
          <td width="65">�����豸</td>
          <td width="400">�����ٶ�(����ֵ����λbps)</td>
          <td width="113">�����ٶ�(����ֵ)</td>
        </tr>
        <tr class="hx_tr1">
          <td>56k Modem</td>
          <td><div class="PicBar" style="width:2px"></div><div class="PicTxt">56K</div></td><td>7.0 k/s</td>
        </tr>
        <tr class="hx_tr1">
          <td>2M ADSL</td>
          <td><div class="PicBar" style="width:80px"></div><div class="PicTxt">2M</div></td><td>250.0 k/s</td>
        </tr>
        <tr class="hx_tr1">
          <td>5M FTTP</td>
          <td><div class="PicBar" style="width:200px"></div><div class="PicTxt">5M</div></td><td>625.0 k/s</td>
        </tr>
        <tr class="hx_tr1">
          <td>��ǰ����</td>
          <td>
          <%
		dim i
		With Response
		.Write("<script language=""JavaScript"" type=""text/javascript"">var tSpeedStart=new Date();</script>")
		.Write("<!--") & chr(13) & chr(10)
		for i=1 to 1000
		.Write("ITlearner-AspCheck-v1.4#############################################################################") & chr(13) & chr(10)
		next
		.Write("-->") & chr(13) & chr(10)
		.Write("<script type=""text/javascript"">var tSpeedEnd=new Date();</script>") & chr(13) & chr(10)
		.Write("<script type=""text/javascript"">")
		.Write("var iSpeedTime=(tSpeedEnd - tSpeedStart) / 1000;")
		.Write("iKbps = (iSpeedTime>0) ? Math.round(Math.round(100 * 8 / iSpeedTime * 10.5) / 10) : 10000 ;")
		.Write("var iSpeed = (iKbps > 1000) ? Math.round(iKbps/100)/10 + 'M' : iKbps + 'K';")
		.Write("var iSpeedwidth=Math.round(iKbps / 100 * 4);")
		.Write("if(iSpeedwidth<1) iSpeedwidth=1;  else if(iSpeedwidth>350) iSpeedwidth=350;")
		.Write("</script>") & chr(13) & chr(10)
		.Write("<script type=""text/javascript"">")
		.Write("document.write('<div class=""PicBar"" style=""width:' + iSpeedwidth + 'px""></div>');")
		.Write("document.write('<div style=""float:left"">'+iSpeed+'</div>');")
		.Write("</script>") & chr(13) & chr(10)
		.Write("</td><td class=""font_3"">")
		.Write("<script type=""text/javascript"">")
		.Write("document.write(Math.round(iKbps/8*10)/10+ ' k/s');")
		.Write("</script>") & chr(13) & chr(10)
		.Write("<script type=""text/javascript"">")
		.Write("document.getElementById(""txt_speed"").style.display=""none"";")
		.Write("</script>") & chr(13) & chr(10)
		End With
%>
          </td>
        </tr>
        <tr class="hx_tr1"><td colspan="3">�����⼸�Σ�ȡƽ��ֵ��������ȽϽӽ���ʵֵ��[<a href="?action=SpeedTest" title="���²��������ٶ�">������²��ԣ�</a>]</td></tr>
      </table>
	</div>
</div>
<%End Sub%>
<%Sub SystemCheck()%>
<div class="frame_box">
	<h3>ϵͳ�û�(��)�ͽ��̼��</h3>
	<div class="item_content">
  <table cellspacing="1" cellpadding="3" class="table1">
    <tr>
			<th colspan="2">�� ��������г���ϵͳ�û�(��)�ͽ��̣���˵��ϵͳ���ܴ��ڰ�ȫ������</th>
    </tr>
    <tr bgcolor="#EFEFEF">
      <td width="80" align="center">�� ��</td><td width="400">���Ƽ�����</td>
    </tr>
<%	dim obj
  	on error resume next
    for each obj in getObject("WinNT://.")
%>
    <tr bgcolor="#FFFFFF">
      <td align="center"><!--<%=obj.path%>-->
<%  if err=438 then Response.Write "ϵͳ�û�(��)" : else Response.Write "ϵͳ����"%>
      </td>
      <td><%Response.Write obj.Name
	  if not error then Response.Write " (" & obj.displayname & ")<br/>" & obj.path%>
      </td>
    </tr>
<%	err.clear
		next
%>
  </table>
  </div>
</div>
<%
End Sub%>
</body>
</html>