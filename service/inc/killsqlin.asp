<%
'--------���岿��------------------
Dim Fy_Post,Fy_Get,Fy_In,Fy_Inf,Fy_Xh
Fy_In = Fy_In = "'�л���վ;�л���վand�л���վexec�л���վinsert�л���վselect�л���վdelete�л���վupdate�л���վcount�л���վ*�л���վ%�л���վchr�л���վmid�л���վmaster�л���վtruncate�л���վchar�л���վdecl"
'----------------------------------
%>
<%
Fy_Inf = split(Fy_In,"�л���վ")
'--------POST����------------------
If Request.Form<>"" Then
	For Each Fy_Post In Request.Form
		For Fy_Xh=0 To Ubound(Fy_Inf)
			If Instr(LCase(Request.Form(Fy_Post)),Fy_Inf(Fy_Xh))<>0 Then
				'--------д�����ݿ�,ר����һ����¼�Ƿ������ı�------------------------------------
				'set rs=server.createobject("adodb.recordset")
				'sql="insert into SqlIn(Sqlin_IP,SqlIn_Web,SqlIn_FS,SqlIn_cs,SqlIn_nr,sqlin_time) values('"&Request.ServerVariables("REMOTE_ADDR")&"','"&Request.ServerVariables("URL")&"','POST','"&Fy_Post&"','"&replace(Request.Form(Fy_Post),"'","''")&"','"&now&"')"
				'rs.open sql,conn,3,2
				'set rs=nothing
				'---------------------------------------------------------------------------------
				Response.Write "<Script Language=JavaScript>alert('�벻Ҫ�ڲ����а����Ƿ��ַ���-----"&Fy_Inf(Fy_Xh)&"\n\n');"
				'Response.Write "�Ƿ�������ϵͳ�������¼�¼��<br>"
				'Response.Write "�����ɣУ�"&Request.ServerVariables("REMOTE_ADDR")&"<br>"
				'Response.Write "����ʱ�䣺"&Now&"<br>"
				'Response.Write "����ҳ�棺"&Request.ServerVariables("URL")&"<br>"
				'Response.Write "�ύ��ʽ���Уϣӣ�<br>"
				'Response.Write "�ύ������"&Fy_Post&"<br>"
				'Response.Write "�ύ���ݣ�"&Request.Form(Fy_Post)
				response.Write "javascript:history.go(-1)</script>"
				Response.End
			End If
		Next
	Next
End If


'--------GET����-------------------
If Request.QueryString<>"" Then
	For Each Fy_Get In Request.QueryString
		For Fy_Xh=0 To Ubound(Fy_Inf)
			If Instr(LCase(Request.QueryString(Fy_Get)),Fy_Inf(Fy_Xh))<>0 Then
				'--------------------------------------д�����ݿ�-----------------------------------------
				'set rs=server.createobject("adodb.recordset")
				'sql="insert into SqlIn(Sqlin_IP,SqlIn_Web,SqlIn_FS,SqlIn_cs,SqlIn_nr) values('"&Request.ServerVariables("REMOTE_ADDR")&"','"&Request.ServerVariables("URL")&"','POST','"&Fy_Post&"','"&replace(Request.Form(Fy_Post),"'","''")&"','"&now&"')"
				'rs.open sql,conn,3,2
				'rs.close
				'set rs=nothing
				'-----------------------------------------------------------------------------------------
				Response.Write "<Script Language=JavaScript>alert('SQL��ע��ϵͳ��ʾ��\n\n�벻Ҫ�ڲ����а����Ƿ��ַ�����ע�룡\n\n');</Script>"
				Response.Write "�Ƿ�������ϵͳ�������¼�¼��<br>"
				Response.Write "�����ɣУ�"&Request.ServerVariables("REMOTE_ADDR")&"<br>"
				Response.Write "����ʱ�䣺"&Now&"<br>"
				Response.Write "����ҳ�棺"&Request.ServerVariables("URL")&"<br>"
				Response.Write "�ύ��ʽ���ǣţ�<br>"
				Response.Write "�ύ������"&Fy_Get&"<br>"
				Response.Write "�ύ���ݣ�"&Request.QueryString(Fy_Get)
				Response.End
			End If
		Next
	Next
End If
%>