<%
  if session("login") <> true or session("admin") = "" then
     response.Write "<script type='text/javascript'>alert ('��δ��¼��ҳ����¼��ʱ�������µ�½!');"
	 response.Write "window.parent.location.href='index.html';"
	 response.Write "</script>"
	 response.End()
  end if	 
%>