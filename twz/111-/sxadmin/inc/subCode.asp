<!--#include file="config.asp"-->
<!--#include file="../judge2.asp"-->
<!--#include file="DB.asp"-->
<!--#include file="function.asp"-->
<!--#include file="common.asp"-->
<!--#include file="../leftMenu.asp"-->
<!--#include file="../power/checkPower.asp"-->

<%
	dim conn,dbPath 
	dbPath="../../DB/ch#$%shixiang.asa"
	call initialize(conn,dbPath)	'��ʼ�����ݿ�����
	
	
	'call needCheck()
' ********************************************
' ����Ϊ��̨ҳ����ʾ����
' ********************************************
 'ȡ����
Function GetLanguage(val)
    Select Case val
    	Case "0"
            GetLanguage = "����"
        Case "1"
            GetLanguage = "Ӣ��"
    	Case "2"
            GetLanguage = "��Ӣ��"
    End Select
End Function




'����˵��
private sub pageRs(objRs,objSql,maxPageSize,intPage,intTotalPageCount)
	set objRs=server.CreateObject("ADODB.RecordSet")
	objRs.open objSql,conn,1,1
	if not objRs.eof then
		intPage=request("page")
		if intPage="" or not isNumeric(intPage)  then intPage=1
		if intPage<=0 then intPage=1
		intPage=cLng(intPage)  '�����ֱȽ�ʱ,Ҫת��,����ʧ��.
		
		objRs.pageSize=maxPageSize
		if intPage>objRs.pagecount then intPage=objRs.pagecount
		
		objRs.absolutepage=intPage
		intTotalPageCount=objRs.pagecount
	else
	end if	

end sub

 	'�����࣬�õ�������,�޸��������ʱ��.
	'����: id,����
private function GetPName(sClassId,classTable)
	if sClassId=0 then
		GetPName="��Ŀ¼"
	else
		GetPName=conn.execute("select ClassName from "&classTable&" where ClassId="&sClassId)(0)
	end if	
end function

'��ʾ�������
'������id,����
private function classname(id,classTable) 
	set rs_class=conn.execute("select ClassName from "&classTable&" where ClassId="&id)
	if rs_class.eof then exit function
	classname=rs_class(0)
	closeRs(rs_class)
end function

'�ݹ���ʾ���,
'��������ID���ո���,ID������
sub showClass(id,nSpace,classId,classTable)
	dim sql,rs_class,i
	sql="select * from "&classTable&" where ClassPId="&id&" order by power desc"
	set rs_class=conn.execute(sql)
	do while not rs_class.eof
		response.write "<option value='"&rs_class(0)&"'"
		if rs_class(0)=Cint(ClassId) then response.write " selected"
		response.write ">"
		for i=1 to nSpace
			response.write "&nbsp;&nbsp;"
		next
		response.write "��"&rs_class("ClassName")&"</option>"
		call  showClass(rs_class(0),nSpace+1,classId,classTable)
		rs_class.movenext
	loop
	closeRs(rs_class)
end sub



'�ݹ�ȡ�ø�Id
'������ID
Function GetRootId(intClassId)
    Dim strSql,objRs
    strSql = "SELECT ArtClassPid FROM [ArtClass] WHERE ArtClassId = " & intClassId
    Set objRs = Conn.Execute(strSql)
    If Not objRs.Eof Then
        If objRs(0) <> 0 Then
            GetRootId = GetRootId(objRs(0))
        Else
            GetRootId = intClassId
        End If
    End If
   closeRs(objRs)
End Function


'��ʾ��棬֧��FLASH��
'������id,����
sub ShowAd(classId,ADwidth,ADheight)
	dim adRs
	set adRs=conn.execute("select * from ad where adClass="&classId)
	
	if right(adRs("adpic"),3)="swf" then
		response.Write("<button onclick=""window.open('"&adRs("url")&"')"" style='border:0px;width:"&ADwidth&"px;height:"&ADheight&"px;background:background-color'>")
		response.Write("<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0' width='"&ADwidth&"' height='"&ADheight&"' >")
 		response.Write(" <param name='movie' value='"&adRs("adpic")&"' />")
  		response.Write("<param name='quality' value='high' />")
		response.Write("<param name='wmode' value='transparent'>")   '����flashΪ͸��
		response.Write(" <embed src='"&adRs("adpic")&"' quality='high' pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash' width='"&ADwidth&"' height='"&ADheight&"'></embed>")
		response.Write("</object>")
		response.Write("</button>")
	else
		response.Write("<a href='"&adRs("url")&"' target='_blank'>")
		response.Write("<img src='"&adRs("adpic")&"' width='"&ADwidth&"' height='"&ADheight&"' border='0'/>")
		response.Write("</a>")
	end if
	 closeRs(adRs)
end sub

  private sub showPage(CurrentPageName) '��ҳ����ת��ʾ
	response.write("<br /><div style='font-size:12px;text-align:center;'>")
	response.write("��<font color=""#FF0000"">"&page&"</font>ҳ/��<font color=""#FF0000"">"&totalPageCount&"</font>ҳ&nbsp;&nbsp;")
	if(page=1) then 
		response.write("��ҳ ��һҳ&nbsp;&nbsp;")
	else
		response.Write("<a href='"&CurrentPageName&"page=1'>��ҳ</a>&nbsp;&nbsp;<a href='"&CurrentPageName&"page="&page-1&"'>��һҳ</a>&nbsp;&nbsp;")
	end if
 
	if page<totalPageCount then 
		response.Write("<a href='"&CurrentPageName&"page="&page+1&"'>��һҳ</a> <a href='"&CurrentPageName&"page="&totalpageCount&"'>βҳ</a>")
	else 
		response.write("��һҳ βҳ")
	end if

	response.Write("<form action='"&CurrentPageName&"' name='pageform' method='post' style='margin:0px;padding:0px;display:inline;'>")
	response.Write("&nbsp;&nbsp;ת����<select name='page' onChange='javascript:document.pageform.submit();'>")
    for i = 1 to totalPageCount
		response.Write "<option value="&i
		if i = page then response.Write " selected" 
		response.Write(">"& i &"</option>")
	next 
	response.Write(" </select></form>" )
	response.write("</div>")
  end sub

  private sub showpage2(sfilename,totalnumber,maxperpage)
	
	dim totalPage, i,strTemp
	
	if totalnumber mod maxperpage=0 then
    	totalPage= totalnumber \ maxperpage
  	else
    	totalPage= totalnumber \ maxperpage+1
  	end if
  	strTemp= "<br /><div style='font-size:12px;text-align:center;'>"
	strTemp=strTemp & "�� <b>" & totalNumber & "</b> ����¼��ռ�� <b>" & CheckSize(TotleSize) & "</b> &nbsp;&nbsp;&nbsp;"
	strTemp=strTemp & "&nbsp;ҳ�Σ�<strong><font color=red>" & page & "/" & totalPage & "</font></strong>ҳ "
    strTemp=strTemp & "&nbsp;<b>" & maxperpage & "</b>" & "���ļ�/ҳ&nbsp;&nbsp;"
	
  	if page<2 then
    	strTemp=strTemp & "��ҳ ��һҳ&nbsp;"
  	else
    	strTemp=strTemp & "<a href='" & sfilename & "page=1'>��ҳ</a>&nbsp;"
    	strTemp=strTemp & "<a href='" & sfilename & "page=" & (page-1) & "'>��һҳ</a>&nbsp;"
  	end if

  	if totalPage-page<1 then
    	strTemp=strTemp & "��һҳ βҳ"
  	else
    	strTemp=strTemp & "<a href='" & sfilename & "page=" & (page+1) & "'>��һҳ</a>&nbsp;"
    	strTemp=strTemp & "<a href='" & sfilename & "page=" & totalPage & "'>βҳ</a>"
  	end if

	strTemp=strTemp & "<form action='"&sfilename&"' name='pageform' method='post' style='margin:0px;padding:0px;display:inline;'>"
	strTemp=strTemp & "&nbsp;&nbsp;ת����<select name='page' onChange='javascript:document.pageform.submit();'>"  
    for i = 1 to totalPage  
   		strTemp=strTemp & "<option value='" & i & "'"
		if cint(page)=cint(i) then strTemp=strTemp & " selected "
		strTemp=strTemp & ">��" & i & "ҳ</option>"   
	next
	strTemp=strTemp & "</select></form>"
	strTemp=strTemp & "</div>"
	response.write strTemp
  end sub
 %>