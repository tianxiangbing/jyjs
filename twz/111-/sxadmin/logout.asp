<!--#include file="inc/function.asp"-->
<%
	session("login")=""
	session("adminName")=""
	session("lastLogin")=""  '�ϴε�½ʱ��
	session("lastLoginIp")="" '�ϴε�½IP
	'session.Abandon()
	ok "�����˳�ϵͳ,лл�ݹ�!","index.html"
%>