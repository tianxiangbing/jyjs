<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<%
response.Buffer = true
'on error resume next
db="DB/ch#$%shixiang.asa"
set conn = server.CreateObject("adodb.connection")
connstr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath(db)
conn.open connstr
if err then
 err.clear
 set conn = nothing
 response.Write "���ݿ����ӳ������������ַ���"
 response.End()
end if
sub closeconn()
  set conn = nothing
end sub	


Function my_replace(ContentStr,reg,new_str)

  Dim ClsTempLoseStr,regEx
  ClsTempLoseStr = Cstr(ContentStr)
  Set regEx = New RegExp
  regEx.Pattern = reg
  regEx.IgnoreCase = True '�Ƿ���Դ�Сд
  regEx.Global = True
  ClsTempLoseStr = regEx.Replace(ClsTempLoseStr,new_str)
  my_replace = ClsTempLoseStr
  Set regEx = Nothing
End Function



Function CloseDatabase'�ر������ݿ�
	Conn.close
	Set conn = Nothing
End Function

function setRs(rs,sql,conn,a,b)
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,conn,a,b
end function

function DisRs(rs)
	rs.close
	set rs=nothing
end function
'const RecordsetVal="adodb.recordset"   	 
%>
<%
  sub erro(str)
      response.Write "<script language=javascript>alert ('"&str&"');"
	  response.Write "javascript:history.go(-1)</script>"
	  response.End()
  end sub
  sub ok(str,url)
      response.Write "<script language=javascript>alert ('"&str&"');"
	  response.Write "window.document.location.href='"&url&"';"
	  response.Write "</script>"
  end sub

'��ʾ��Ϣ
sub info(a,rul)
	response.write("<script>alert('"&a&"');location.href='"&rul&"'</script>")
end sub
%>
<% function HTMLEncode(fString)
if not isnull(fString) then
fString = replace(fString, ">", "&gt;")
fString = replace(fString, "<", "&lt;")

fString = Replace(fString, CHR(32), "&nbsp;")
fString = Replace(fString, CHR(9), "&nbsp;")
fString = Replace(fString, CHR(34), "&quot;")
fString = Replace(fString, CHR(39), "&#39;")
fString = Replace(fString, CHR(13), "")
fString = Replace(fString, CHR(10) & CHR(10), "</P><P> ")
fString = Replace(fString, CHR(10), "<BR> ")

HTMLEncode = fString
end if
end function
%>

<%
'ȥ����ǩ
Function RemoveHTML( strText ) 
    nPos1 = InStr(strText, "<") 
    Do While nPos1 > 0 
        nPos2 = InStr(nPos1 + 1, strText, ">") 
        If nPos2 > 0 Then 
            strText = Left(strText, nPos1 - 1) & Mid(strText, nPos2 + 1) 
        Else 
            Exit Do 
        End If 
        nPos1 = InStr(strText, "<") 
    Loop 
    
    RemoveHTML = strText 
End Function 

'��ҳ��ʾ
private sub showPage(CurrentPageName) '��ҳ����ת��ʾ
	'response.write("<br /><div style='font-size:12px;text-align:center;' class='xwlbb'>")
	response.write("��ǰ�� <font color=""#FF0000"">"&curpage&"</font> ҳ/�� <font color=""#FF0000"">"&rs.pagecount&"</font> ҳ&nbsp;&nbsp;")
	if(curpage=1) then 
		response.write("��ҳ ��һҳ&nbsp;&nbsp;")
	else
		response.Write("<a href='"&CurrentPageName&"curpage=1'>��ҳ</a>&nbsp;&nbsp;<a href='"&CurrentPageName&"curpage="&curpage-1&"'>��һҳ</a>&nbsp;&nbsp;")
	end if
 
	if curpage<rs.pagecount then 
		response.Write("<a  href='"&CurrentPageName&"curpage="&curpage+1&"'>��һҳ</a> <a href='"&CurrentPageName&"curpage="&rs.pagecount&"'>βҳ</a>")
	else 
		response.write("��һҳ βҳ")
	end if

	
	response.Write("<form action='"&CurrentPageName&"' name='pageform' method='post' style='margin:0px;padding:0px;display:inline;'>")
	response.Write("&nbsp;&nbsp;ת����<select name='curpage' onChange='javascript:document.pageform.submit();'>")
    for i = 1 to rs.pagecount
		response.Write "<option style='color:#F00;' value="&i
		if i = curpage then response.Write " selected" 
		response.Write(">"& i &"</option>")
	next 
	response.Write(" </select></form>" )
	'response.write("</div>")
end sub


'��ҳ��ʾ
private sub enshowPage(CurrentPageName) '��ҳ����ת��ʾ
	'response.write("<br /><div style='font-size:12px;text-align:center;' class='xwlbb'>")
	response.write("Current <font color=""#FF0000"">"&curpage&"</font> page/Total <font color=""#FF0000"">"&rs.pagecount&"</font> page&nbsp;&nbsp;")
	if(curpage=1) then 
		response.write("Home Previous&nbsp;&nbsp;")
	else
		response.Write("<a href='"&CurrentPageName&"curpage=1'>Home</a>&nbsp;&nbsp;<a href='"&CurrentPageName&"curpage="&curpage-1&"'>Previous</a>&nbsp;&nbsp;")
	end if
 
	if curpage<rs.pagecount then 
		response.Write("<a  href='"&CurrentPageName&"curpage="&curpage+1&"'>Next</a> <a href='"&CurrentPageName&"curpage="&rs.pagecount&"'>Last Page</a>")
	else 
		response.write("Next Last Page")
	end if

	
	response.Write("<form action='"&CurrentPageName&"' name='pageform' method='post' style='margin:0px;padding:0px;display:inline;'>")
	response.Write("&nbsp;&nbsp;Go��<select name='curpage' onChange='javascript:document.pageform.submit();'>")
    for i = 1 to rs.pagecount
		response.Write "<option style='color:#F00;' value="&i
		if i = curpage then response.Write " selected" 
		response.Write(">"& i &"</option>")
	next 
	response.Write(" </select></form>" )
	'response.write("</div>")
end sub

'��html��ǩ���й���
function nohtml(str)
	dim re
	Set re=new RegExp    ' ����������ʽ
	re.IgnoreCase =true  '�����Ƿ������ַ���Сд�� 
	re.Global=True       ' ����ȫ�ֿ�����
	re.Pattern="(\<.[^\<]*\>)"
	str=re.replace(str," ")
	re.Pattern="(\<\/[^\<]*\>)"
	str=re.replace(str," ")
	nohtml=str
	set re=nothing
end function

function getSafeContent2(fString)
	fString = replace(fString, "&gt;", ">")
	fString = replace(fString, "&lt;", "<")
	fString = replace(fString, "'", "&#39;")
	getSafeContent=	fString
end function


' ===================================================
' �õ���ȫ�ַ���,�ڲ�ѯ�л��б�Ҫǿ���滻�ı���ʹ��
' str Ҫ�滻���ַ���
' ===================================================
'Function GetSafeStr(str)
''	GetSafeStr = Replace(Replace(Replace(Trim(str), "'", ""), Chr(34), ""), ";", "")
'	GetSafeStr = Replace(Replace(Replace(Replace(Replace(str,"'","��"),"""","��"),"&",""),"<","&lt;"),">","&gt;")
'End Function

'************************************************** 
'��������GetcutStr 
'�� �ã���ȡָ�������ַ��� 
'�� ����str ----�ִ����� 
'�� ����strlen ----��ȡ���� 
'����ֵ����ȡ�����ַ��� 
'************************************************** 
Function GetcutStr(str, cutlen) 
If str="" or isnull(str) then Exit Function 
Dim strlength, codeid, i 
t = 0 
For i = 1 To len(str) 
	codeid = Abs(Asc(Mid(str, i, 1))) 
	If codeid > 255 Then 
		strlength = strlength + 2 
	Else 
		strlength = strlength + 1 
	End If 
	
	If strlength >= cutlen Then 
		GetcutStr = Left(str, i) & "..." 
		Exit For 
	Else 
		GetcutStr = str 
	End If 
Next 

GetcutStr = Replace(GetcutStr, Chr(10), "") 
End Function


'======================================
'=========��վ���ݹ���=================
'=======����ID�õ���ص���Ϣ===========
'============id->��������id============
Function InFoNum(id)
	Dim rs
	set rs=server.CreateObject("adodb.recordset")
	sql="select * from Info where ID="&id&""
	set rs=conn.execute(sql)
	response.Write rs("InfoContent")
	rs.close
	set rs=nothing
End Function

Function InFoNum2(id)
	Dim rs
	set rs=server.CreateObject("adodb.recordset")
	sql="select * from Info where ID="&id&""
	set rs=conn.execute(sql)
	response.Write RemoveHTML(rs("InfoContent"))
	rs.close
	set rs=nothing
End Function

Function InFoNum3(id)
	Dim rs
	set rs=server.CreateObject("adodb.recordset")
	sql="select * from Info where ID="&id&""
	set rs=conn.execute(sql)
	response.Write nohtml(rs("InfoContent"))
	rs.close
	set rs=nothing
End Function


'======================================
'=========��վ���ݹ���=================
'=======����ID�õ���ص���Ϣ===========
'==========������н�ȡ================
'===id->��������ID,num->��ȡ������=====
Function InFoNumCount(id,num)
	Dim rs
	set rs=server.CreateObject("adodb.recordset")
	sql="select * from Info where ID="&id&""
	set rs=conn.execute(sql)
	response.Write left(RemoveHTML(rs("InfoContent")),num)
	'response.Write(rs("InfoContent"))
	if len(rs("InfoContent"))>num then response.Write "..."
	rs.close:set rs=nothing
End Function

Function closedate(cRs)
	set cRs=close:set cRs=nothing
End Function

Function InFoNumCount2(id,num)
	Dim rs
	set rs=server.CreateObject("adodb.recordset")
	sql="select * from Info where ID="&id&""
	set rs=conn.execute(sql)
	response.Write left(rs("InfoContent"),num)
	'response.Write(rs("InfoContent"))
	if len(rs("InfoContent"))>num then response.Write "..."
	rs.close:set rs=nothing
End Function

Function closedate(cRs)
	set cRs=close:set cRs=nothing
End Function

' ============================================
' �ж��Ƿ������֣�������Ĭ��ֵ�滻
' iCheck Ҫ�滻�ı���,iDefault Ĭ��ֵ
' ============================================
Function GetSafeInt(iCheck,iDefault) 
	If Trim(iCheck)="" Then
		GetSafeInt = iDefault
		Exit Function
	End If

	If IsNumeric(iCheck)=false Then
		GetSafeInt = iDefault
		Exit Function
	End If
	
	GetSafeInt = iCheck
End Function
%>

