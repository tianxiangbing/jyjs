<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��̨����</title>
<link rel="stylesheet" href="../css/common.css" type="text/css" />
<script type="text/javascript" src="../js/checkForm.js"></script>
</head>
<!--#include file="../inc/subCode.asp"-->
<!--#include file="../fckeditor/fckeditor.asp" -->
<body>
<div id="container">
<% 
	 ' �������������ID
	Dim ID
	ID = Trim(Request.QueryString("id"))
	checkId(id)
	' �����ݿ���ȡ��ʼֵ
	
	set rs =conn.execute("SELECT * FROM Info WHERE id=" & ID)
	If  rs.Eof Then
		call erro("��Ч��ID�����ҳ���ϵ����ӽ��в�����")
	End If
	
	if request.querystring("action")="add" then' ȡ�ύ����������
		scontent = ""
		For i = 1 To Request.Form("content").Count
			scontent = scontent & Request.Form("content")(i)
		Next
		scontent=getSafeContent(scontent)
		conn.execute("update Info set InfoContent='"&scontent&"' where id="&id)
	    ok "�޸ĳɹ���","infoList.asp"
	end if

 %>

  <table width="100%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
 <form action="../../sxadmin/info/Info.asp?action=add&id=<%=ID%>" method="post" name="form1" onSubmit="return chkInfo();">
	<tr>
      <td colspan="2" class="table_title"><%= rs("infoName") %></td>
    </tr>
    <tr>
      <td width="12%" align="right" class="left_title_2">��Ϣ���ݣ�</td>
      <td width="88%">
      <%
	  Set oFCKeditor = New FCKeditor 
	  oFCKeditor.BasePath = "../FCKeditor/"  '����·�������ⲻҪ�Ķ���
	 ' //���ñ༭����·������վ���Ŀ¼�µ�һ��Ŀ¼ 
	 oFCKeditor.ToolbarSet = "Default"   '�����ļ��ֹ���������Default,base,����   										                                          fckconfig.js�����趨.   
	 oFCKeditor.Width = "100%" '�����趨���,���԰� % ��ֵ��ѡ��.   
	 oFCKeditor.Height = "400" 
	 oFCKeditor.Value = rs("InfoContent") '//����Ǹ��༭����ʼֵ 
	 oFCKeditor.Create "Content" '//�Ժ�༭��������ݶ��������logbodyȡ�ã��������㶨
	 %>
      </td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td class="left_title_2">&nbsp;</td>
      <td><input type="submit" name="btnsubmit" value="�� ��" class="button2"> &nbsp; 
      <input type="reset" name="btnreset" value="�� д" class="button2"></td>
    </tr>  </form>
  </table>
</div>
</body>
</html>
