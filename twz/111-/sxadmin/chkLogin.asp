<!--#include file="inc/config.asp"-->
<!--#include file="inc/killsqlin.asp"-->
<!--#include file="inc/DB.asp"-->
<!--#include file="conn.asp" -->
<!--#include file="inc/md5.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/common.asp"-->

<%
     if not IsSelfPost then
	 	erro "��ͨ����վ�ύ����!"
	 end if
	 
	 dim username,userpwd,passcode,thesoft,vOs,mdUserpwd,rs,userIp,errorPwd
	
	 username = LCase(htmlencode(request.form("username")))
	 userpwd = LCase(htmlencode(request.form("userpwd")))
	 passcode=htmlencode(request.form("passcode"))
	' response.Write(username)
'	 response.Write(userpwd)
'	 response.End()
	 
	 if username = "" or userpwd = "" or passcode="" then
		Call erro("��¼ʧ��!����ϸ��д��¼��Ϣ!")
	 end if	

	 
	 if  IsNumeric(passcode)=false then erro "��֤��Ϊ����,����������!"
	 passcode = clng(passcode)
	 if passcode <> Session("GetCode") then
	    Session("GetCode")=""
		call okJump("��֤�����,����������!","index.html")
	 end if
	 
	 
	    thesoft=Request.ServerVariables("HTTP_USER_AGENT")
           if instr(thesoft,"Windows NT 5.0") then
	          vOS="Win2000"
           elseif instr(thesoft,"Windows NT 5.2") then
	          vOs="Win2003"
           elseif instr(thesoft,"Windows NT 5.1") then
	          vOs="WinXP"
           elseif instr(thesoft,"Windows NT") then
	          vOs="WinNT"
           elseif instr(thesoft,"Windows 9") then
	          vOs="Win9x"
           elseif instr(thesoft,"unix") or instr(thesoft,"linux") or instr(thesoft,"SunOS") or instr(thesoft,"BSD") then
	          vOs="��Unix"
           elseif instr(thesoft,"Mac") then
	          vOs="Mac"
           else
	          vOs="Other"
           end if
		   
	    mdUserpwd=md5(userpwd)	'md5����
		
		userIp=GetIP()

		set rs = conn.execute("select * from PsAdmin where username='"&username&"' and userpwd='"&mdUserpwd&"'")
		
		if rs.eof then	'��¼ʧ��ʱ����¼��¼��Ϣ
			conn.execute("insert into log(username,errorPwd,userIp,os) values('"&username&"','"&userpwd&"','"&userIp&"','"&vOs&"')")
		    Call okJump("��¼ʧ��!�����û���������!","index.html") 'ˢ����֤��
		else
		   session("login")=true
		   session("admin")=username
		   
		   session.timeout=60
		   
		   conn.execute("insert into log(username,userIp,os) values('"&username&"','"&userIp&"','"&vOs&"')")	'��½��Ϣ
		   conn.execute("update psadmin set lastLoginDate='"&rs("thisLoginDate")&"',lastLoginIp='"&rs("thisLoginIP")&"' where username='"&username&"'")'�����ϴε�¼ʱ��,�ϴε�¼IP,��¼����
		   conn.execute("update psadmin set thisLoginDate=now(),loginTime=loginTime+1,thisLoginIP='"&userIp&"' where username='"&username&"'")'���±��ε�¼��Ϣ

		   response.Redirect("main.asp")
		end if
		
		closeRs(rs)
 	    		
%>