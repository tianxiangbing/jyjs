<!--#include file="inc/conn.asp"-->
<%
	Response.Charset="gb2312"

	Dim CmdSP
	Dim adoRS
	Dim adCmdSPStoredProc
	Dim adParamReturnValue
	Dim adParaminput
	Dim adParamOutput
	Dim adInteger
	Dim iVal
	Dim oVal
	Dim adoField
	Dim adVarChar
	
	adCmdSPStoredProc = 4
	adParamReturnValue = 4
	adParaminput = 1
	adParamOutput = 2
	adInteger = 3
	adVarChar = 200
	
	iVal = 5
	oVal = 3
'if request.ServerVariables("Request_method") <> "POST" then Response.End
set rs=server.CreateObject("ADODB.recordset")
select case request.querystring("menu")
	case "zzsc"
		'response.write("ok<img/><a href=''>h</a>")
		id =cint(request.QueryString("id"))
		sql="select content from news where id="&id&""	
		'response.Write(sql)
		rs.open sql,conn,1,1
		if not rs.eof then
			if len(rs("content"))>200 then
			 response.write( (left(rs("content"),200)))
			else
			response.Write((rs("content")))
			end if 
		else
		response.Write("������Ϣ!")
		end if
		myClose
	case "showzzsc"
		id =cint(request.QueryString("id"))
		sql="select content from news where id="&id&""	
		'response.Write(sql)
		rs.open sql,conn,1,1
		if not rs.eof then
			response.Write(rs("content"))
		end if
		myClose
	case "login"
		if session("uid")<>""then 
			call Check( Trim(session("uName")) ,session("pwd"))
		else
			if request.QueryString("val")="" or request.QueryString("uid")="" or request.QueryString("val")="pwd" then 
			ShowError("������������")
			else
				if cint(session("tianxiangbing"))<>cint(request.QueryString("val")) then
					ShowError("��֤���������")
					set session("tianxiangbing")=nothing				
					response.End
				else		
					IsUser(Trim(request.querystring("uid")))
					call Check( Trim(request.querystring("uid")) ,request.QueryString("pwd"))
				end if
				myClose
			end if
		end if
	case "reg"
		RegInfo
		myClose
end select
'***************************'
'******�ͷ���Դ*************'
'***************************'
Sub myClose
	conn.Close
	set rs=nothing
	set conn=nothing
End Sub

'*******************************'
'*****��֤�û��Ƿ����**********'
'*******************************'
Sub IsUser(uid)
	sql="select * from user_info where username=@username"
	set Cmd = Server.CreateObject("ADODB.Command")
	Cmd.CommandText=sql
	Cmd.activeConnection=conn
	Cmd.Parameters.Append Cmd.CreateParameter("@username", adVarChar, adParaminput, 50, uid)
	set rs=Cmd.Execute()
	if rs.eof then 
		ShowError("�û������ڣ�")
		response.End		
	end if
	rs.close
End Sub

Sub Check1(uid,pwd)
	sql="select *from user_info where userName='"&uid&"' and pwd='"&pwd&"'"
	rs.open sql,conn,1,1
	if rs.eof then
		ShowError("������������")
		response.End
	else
		'ShowError("�ɹ�!")
		session("uid")=rs("uid")
		session("uName")=rs("userName")
		session("pwd")=rs("pwd")
		LoginSucceed
	End if
	rs.close
End Sub
'*************************************************'
'*****��֤�û���¼********************************'
'*****����uid:�û���******************************'
'*****����pwd:�û�����****************************'
'*************************************************'
Sub Check(uid,pwd)
	sql="select *from user_info where userName=@username and pwd=@pwd"
	set Cmd = Server.CreateObject("ADODB.Command")
	Cmd.CommandText=sql
	Cmd.activeConnection=conn
	Cmd.Parameters.Append Cmd.CreateParameter("@username", adVarChar, adParaminput, 50, uid)
	Cmd.Parameters.Append Cmd.CreateParameter("@pwd", adVarChar, adParaminput, 50, pwd)
	set rs=Cmd.Execute()

	if rs.eof then
		ShowError("������������")
		response.End
	else
		'ShowError("�ɹ�!")
		session("uid")=rs("uid")
		session("uName")=rs("userName")
		session("pwd")=rs("pwd")
		LoginSucceed
	End if
	rs.close
End Sub

Sub MessageBox(Message)
	%>
	<Script language="JavaScript">
	alert('<%=Message%>');
	</script>
	<%
End Sub

'********************************************'
'************��ʾ������Ϣ********************'
'********************************************'
Sub ShowError(Message)
	response.write("<div style='color:blue;'>"&Message&"</div>")
	userLogin
End Sub

Sub userLogin
%>
<table>
<tr><td colspan="2"><img src="images/login.gif" /></Td></tr>
  <tr><td align="right" valign="middle" nowrap="nowrap">��Ա����</td>
<td><input class="input" id="userName" >
</input></td>
</tr>
	<tr>
	  <td align="right" valign="middle">���룺</td>
	  <td><input class="input" id="pwd" type="password" size="32"/></td></tr>
	<tr>
	  <td align="right" valign="middle">��֤��</td>
	  <td><input class="val" id="val" size="4"/><img src="inc/verifycode.asp" onclick="this.src='inc/verifycode.asp'" height="12px"width="40px" /></td></tr>
	<tr><td colspan="2" align="center"><input type="submit" name="submit" value="��¼" onclick="check();"/>
	    <input type="button" name="btnReg" value="ע��"/></td></tr>
		<tR><td colspan="2" align="center"><span class="btn" onclick="">�����������������</span>
		</td></tr>
</table>
<%
End Sub
'********************************'
'***********��¼�ɹ�*************'
'********************************'
Sub LoginSucceed
%>
<table class="login">
<tr><td colspan="2" align="left" valign="top" style="padding:10px 5px 5px 5px;">
<font color="#aa00ff">
<%response.write(session("uName"))%></font> ��ӭ��!
</td>
</tr>
<tr><td align="center" colspan="2"><img height="100px" width="100px" src="<%
if rs("photo")<>"" then
	response.write(rs("photo"))
else
	if rs("sex") then
		response.write("images/man.gif")
	else
		response.write("images/woman.gif")	
	end if
end if
%>"/>
</td>
</tr>
<tr><td align="right">
�ǳ�:  </td>
<td align="left"><%response.write(rs("nickName"))%></td>
</tr>
<tr><td align="right">
����:  </td>
<td align="left"><%response.write(rs("integral"))%></td>
</tr>
<tr>
  <td colspan="2" align="center">
��������|���ﳵ|�˳�   </td>
</tr>
</table>
<%
End Sub
%>
<%
Sub RegInfo
sql="select *from config where configName='ע����Ϣ'"
rs.open sql,conn,1,1
if not rs.eof then 
%>
	<div style="text-align:center;color:blue;font-weight:bold;font-size:14px;"><%=rs("title")%></div>
	<div><%=rs("content")%><div>
	<div></div>
<%
end if
rs.close
End Sub
%>







