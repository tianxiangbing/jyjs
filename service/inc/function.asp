<%

'on error resume next


' ********************************************
' ����Ϊ���ú���
' ********************************************

  sub erro(str)  '��ʾ��Ϣ
      response.Write "<script type='text/javascript'>alert ('"&str&"');"
	  response.Write "javascript:history.go(-1)</script>"
	  response.End()
  end sub
  
  sub ok(str,url)
      response.Write "<script type='text/javascript'>alert ('"&str&"');"
	  response.Write "window.document.location.href='"&url&"';"
	  response.Write "</script>"
  end sub
  
  sub okJump(str,url)
  	 response.Write "<script type='text/javascript'>alert ('"&str&"');"
	 response.Write "window.document.location.href='"&url&"';"
	 response.Write "</script>"
	 response.End()
  end sub
  
  sub msgTest(str)
  	 response.Write "<script type='text/javascript'>alert ('"&str&"');"
	 response.Write "</script>"
  end sub
  
 
  ' ============================================
	' * �Դ����IDУ��
  ' ============================================
  sub CheckID(id)
    'id=request.querystring("id")
	if id="" or IsNumeric(id)=false then 
		erro "��ЧID��������!"
	end if
  end sub
  
  ' ============================================
' �õ���ȫ�ַ���,�ڲ�ѯ�л��б�Ҫǿ���滻�ı���ʹ��
' str Ҫ�滻���ַ���
' ============================================
Function GetSafeStr(str)
	GetSafeStr = Replace(Replace(Replace(Trim(str), "'", ""), Chr(34), ""), ";", "")
	'GetSafeStr = Replace(Replace(Replace(Replace(Replace(str,"'","��"),"""","��"),"&",""),"<","&lt;"),">","&gt;")
End Function


function getSafeContent(fString)
	'fString = replace(fString, ">", "&gt;")
	'fString = replace(fString, "<", "&lt;")
	fString = replace(fString, "'", "&#39;")
	getSafeContent=	fString
end function

'**************************************************
'��������IsValidStr
'��  �ã�����ַ��Ƿ�����Ч��Χ��
'��  ����str ----Ҫ�����ַ�
'����ֵ��True  ----�ַ��Ϸ�
'        False ----�ַ����Ϸ�
'**************************************************
Function IsValidStr(ByVal str)
    Dim i, c
    For i = 1 To Len(str)
        c = LCase(Mid(str, i, 1))
        If InStr("abcdefghijklmnopqrstuvwxyz1234567890", c) <= 0 Then
            IsValidStr = False
            Exit Function
        End If
    Next
    If IsNumeric(Left(str, 1)) Then
        IsValidStr = False
    Else
        IsValidStr = True
    End If
End Function


' ============================================
' * �ж������Ƿ������ⲿ
' * @return ���ز���ֵ
' ============================================
Function IsSelfPost()
    Dim HTTP_REFERER,SERVER_NAME
    HTTP_REFERER = Cstr(Request.ServerVariables("HTTP_REFERER"))
    SERVER_NAME = Cstr(Request.ServerVariables("SERVER_NAME"))
    IsSelfPost = False 
    If Mid(HTTP_REFERER,8,len(SERVER_NAME)) = SERVER_NAME Then IsSelfPost = True 
End Function
'����Ϊʾ��Ӧ��
'If IsSelfPost Then
	'statement 
'end if
  
' ============================================
' ��ȡ�ַ�����
' ============================================
 function cutstr(str,lenstr)
	if len(str)>lenstr then
		cutstr=left(str,lenstr)&"��"
	else
		cutstr=str
	end if
 end function
	
 function cutStr2(str,lenght)  '��ȡ�ַ�
 	Dim str2,newstr
	str2 = str
	Set Reg = New RegExp
    Reg.Ignorecase = True
    Reg.Global = True
    Dim Matches,Match
    Reg.Pattern = "<(.+?)>(.+?)</.+?>"
    Set Matches = Reg.Execute(str2)

	For Each Match In Matches
		if len(Match.SubMatches(1))>lenght then
			newstr=left(Match.SubMatches(1),lenght)&"..."
		else
			newstr= Match.SubMatches(1)
		end if
		newstr = "<"&Match.SubMatches(0)&">" & newstr & "<span>"
		'newstr=newstr 
		'response.Write("[["&newstr&"]]")
		'response.End()
    Next
	if newstr = "" then 
		if len(str)>lenght then
			newstr=left(str,lenght)&"..."
		else
			newstr= str
		end if
	End if
	cutStr2 = newstr
 end function 	
	
	function cutStr3(str,length)	' ��ȡ�ַ�����,����һ���������ַ���Ӣ����һ���ַ�
		dim strLen,y
		str=trim(str)
		str=replace(replace(replace(replace(replace(replace(str,"&nbsp;",""),CHR(9),""),CHR(13), ""), CHR(10) & CHR(10),""),"<BR>", "")," ","")
		strLen = len(str)
		y = 0
		if strLen >= length then
			for i = 1 to strLen
				if asc(mid(str,i,1)) < 0 or asc(mid(str,i,1)) >255 then '����Ǻ���
					y = y + 2
				else
					y = y + 1
				end if
			
				if y >= length then 
					str = left(str,i)&"��" '�ַ����޳�
					exit for
				end if
			next
		end if
		cutStr3 = str
	End Function 


'**************************************************
'��������IsObjInstalled
'��  �ã��������Ƿ��Ѿ���װ
'��  ����strClassString ----�����
'����ֵ��True  ----�Ѿ���װ
'       False ----û�а�װ
'**************************************************
Function IsObjInstalled(strClassString)
	On Error Resume Next
	IsObjInstalled = False
	Err = 0
	Dim xTestObj
	Set xTestObj = Server.CreateObject(strClassString)
	If 0 = Err Then IsObjInstalled = True
	Set xTestObj = Nothing
	Err = 0
End Function 

' ɾ��ָ�����ļ�
Sub DoDelFile(sPathFile)
	'response.Write Server.MapPath(sPathFile)
	Dim oFSO
	Set oFSO = Server.CreateObject("Scripting.FileSystemObject")
	if oFSO.FileExists(Server.MapPath(sPathFile)) then
		oFSO.DeleteFile(Server.MapPath(sPathFile))
	end if
	Set oFSO = Nothing
End Sub	

' ============================================
    ' * jMail��������ʼ�
' ============================================ 
	'call setMail(username,subjects,email,content)
	
	sub setMail(sendName,subjects,receiveMail,mailContent)
		if IsObjInstalled("Jmail.Message")=false then
			response.Write("��������֧��Jmail�ؼ�������ϵ��������Ӧ�̡�")
			exit sub
		end if	
		
		Set Jmail= Server.CreateObject ("Jmail.Message")
		Jmail.Silent = true '�������Ϊtrue,JMail�����׳��������
		Jmail.Charset = "gb2312"
		JMail.ContentType = "text/html"  'ȱʡ��"text/plain"���������HTML��ʽ�����ʼ�, ��Ϊ"text/html"���ɡ�
		Jmail.From = "search456@163.com"	'"����������"
		Jmail.FromName =sendName '"����������"
		Jmail.ReplyTo ="search456@163.com" '"�ظ�����"
		Jmail.Subject = subjects
		Jmail.AddRecipient receiveMail '"�ռ�������"
		Jmail.Body = mailContent
		Jmail.MailServerUserName = "search456"'"������SMTP�ʺ�"
		Jmail.MailServerPassWord = "123456789"'"������SMTP����"
		JMail.Priority=3 '�ʼ��ȼ�����Χ��1-5֮�� 1 �����ȼ�.2 Ҳ�Ǹ����ȼ� 3 ��ͨ���ȼ� 4 �����ȼ�5 ��͵����ȼ�
		Jmail.Send("smtp.163.com")
		Jmail.Close
		Set Jmail = nothing
	end sub
	
	'�Զ���Ӵ�����Ϣ�����ݿ�,���ҷ��͵�����.
	'call AutoErrInfo()
	sub AutoErrInfo()
		if err.number<>0 then
			set errRs=conn.execute("select * from errLog where fullPath='"&GetFullUrl&"' ")
			if errRs.eof then
				sql="insert into errLog(ip,http_referer,fullPath,errNumber,errDescription,errSource,err) values('"&GetIP&"','"&request.ServerVariables("HTTP_REFERER")&"','"&GetFullUrl&"','"&err.number&"','"&err.description&"','"&err.source&"','"&err&"')"
				conn.execute(sql)
				content="<div><ul><li>IP:"&GetIP&"</li><li>http_referer:"&request.ServerVariables("HTTP_REFERER")&"</li><li>URL:"&GetFullUrl&"</li><li>err.number:"&err.number&"</li><li>err.description:"&err.description&"</li><li>err.source:"&err.source&"</li><li>err:"&err&"</li><li>ʱ��:"&now()&"</li></ul></div>"
				call setMail(request.ServerVariables("HTTP_HOST"),"��վ������Ϣ","search789@163.com",content)
			end if	
		end if
	end sub	  

' ============================================
    ' * �������ַ���
    ' * @params ������ ���λ��
    ' * @return �ַ���
' ============================================
    Public Function RandStr(intNum)
        Dim strChar,strCode,i,j,k
        strChar = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        j = Len(strChar)
        Randomize
        For i = 1 To intNum				'Int((upperbound - lowerbound + 1) * Rnd + lowerbound) '����ĳ����Χ�ڵ��������,
		  k = Int(j * Rnd ) + 1 		'upperbound ���������Χ�����ޣ��� lowerbound �����������Χ�����ޡ�  
          strCode = strCode & Mid(strChar,k,1)  'kΪ1��36
        Next
        RandStr = strCode
    End Function
	
	'����ļ�������ʽ"14λʱ��+5λ�����"
	function randName()
		randomize
		ranNum=int(90000*rnd)+10000
		randName=year(now)&AddZero(month(now))&AddZero(day(now))&AddZero(hour(now))&AddZero(minute(now))&AddZero(second(now))&ranNum
	end function
	
	' ============================================
    ' * ����λ��,��0����
    ' * @params ������ַ�
    ' * @return �ַ���
' ============================================  
    Public Function AddZero(ByVal strVal)
        Dim strZero,strlen
		strZero=""
		maxLen=2
		if strVal&"a"="a" then exit Function
		For i = Len(strVal) To maxLen - 1
        	strZero = strZero & "0"
        Next
		AddZero = strZero & strVal
    End Function
	

' ============================================
    ' * �Բ���JS�ַ�ת��
' ============================================
    Public Function JSEncode(ByVal strHTML)
        If Not IIsEmpty(strHTML) Then
            strHTML = Replace(strHTML, "\", "\\")
            strHTML = Replace(strHTML, Chr(34), "\""")
            strHTML = Replace(strHTML, Chr(39), "\'")
            strHTML = Replace(strHTML, Chr(10), "\n")
            strHTML = Replace(strHTML, Chr(13), "\r")
            JSEncode = strHTML
        Else
            JSEncode = Empty
        End If
    End Function

' ============================================
    ' * ��ԭ��ת���JS�ַ�
' ============================================
    Public Function JSDecode(ByVal strHTML)
        If Not IIsEmpty(strHTML) Then
            strHTML = Replace(strHTML, "\\","\")
            strHTML = Replace(strHTML, "\""",Chr(34))
            strHTML = Replace(strHTML, "\'",Chr(39))
            strHTML = Replace(strHTML, "\n",Chr(10))
            strHTML = Replace(strHTML, "\r",Chr(13))
            JSDecode = strHTML
        Else
            SDecode = Empty
        End If
    End Function


  
'����������server.HTMLEncode����server.HTMLEncode���ļ�ǿ�����ƺ�����
'��ָ�����ַ�������HTML���룬�Ӷ�ʹ���ַ������������ʽ��ʾ����.
'ԭ�����Է�ֹ���ֽű���insert������'������
function HTMLEncode(fString)
	if not isnull(fString) then
		'fString=trim(fString)
		fString=server.HTMLEncode(fString)
		fString = replace(fString, ">", "&gt;")
		fString = replace(fString, "<", "&lt;")
		fString = Replace(fString, CHR(32), "&nbsp;")
		fString = Replace(fString, CHR(9), "&nbsp;")	'Chr(9)�ڼ��±��а�һ��Tab����Ч��
		fString = Replace(fString, CHR(34), "&quot;")	'˫����
		fString = Replace(fString, CHR(39), "&#39;")	'������
		fString = Replace(fString, CHR(13), "") 	'  Chr(10) �Ǹ����з�  chr(13) ��һ���س�
		fString = Replace(fString, CHR(10) & CHR(10), "</P><P>")
		fString = Replace(fString, CHR(10), "<BR>")		
		HTMLEncode = fString
	end if
end function

'���ַ����룬��ȥ���ַ���
function HTMLDecode(fString)
	if not isnull(fString) then
		fString = replace(fString, "&gt;",">")
		fString = replace(fString, "&lt;","<")
		fString = Replace(fString, "&nbsp;",CHR(32))
		'fString = Replace(fString, "&nbsp;",CHR(9))	'Chr(9)�ڼ��±��а�һ��Tab����Ч��
		fString = Replace(fString, "&quot;",CHR(34))	'˫����
		fString = Replace(fString, "&#39;",CHR(39))	'������
		'fString = Replace(fString, CHR(13), "") 	'  Chr(10) �Ǹ����з�  chr(13) ��һ���س�
		fString = Replace(fString, "</P><P>",CHR(10) & CHR(10))
		fString = Replace(fString, "<BR>",CHR(10))
		
		HTMLDecode = fString
	end if
end function

 Function nohtml(str)  'ȥ��HTML
	dim re 
	Set re=new RegExp 
	re.IgnoreCase =true 
	re.Global=True 
	str = replace(str,"<br>","{br}")
	re.Pattern="(\<.[^\<]*\>)" 
	str=re.replace(str," ") 
	re.Pattern="(\<\/[^\<]*\>)" 
	str=re.replace(str," ") 
	str = replace(str,"{br}","<br>")
	nohtml=str 
	set re=nothing 
end function 

''''''''''�滻ģ��START''''''''''''
Function ReplaceText(fString,patrn,replStr)
	Set regEx = New RegExp   	' ����������ʽ��
		regEx.Pattern = patrn   ' ����ģʽ��
		regEx.IgnoreCase = True ' �����Ƿ����ִ�Сд��
		regEx.Global = True     ' ����ȫ�ֿ����ԡ� 
		ReplaceText = regEx.Replace(""&fString&"",""&replStr&"") ' ���滻��
	Set regEx=nothing
End Function
''''''''''�滻ģ��END''''''''''''

Function RegExpTest(patrn, strng)
	Set regEx = New RegExp   		' ����������ʽ��
		regEx.Pattern = patrn   	' ����ģʽ��
		regEx.IgnoreCase = True 	' �����Ƿ����ִ�Сд��
		regEx.Global = True     	' ����ȫ�ֿ����ԡ� 
		RegExpTest = regEx.Test(strng) ' ִ��������
	Set regEx=nothing
End Function


' ===============================================
' ��ʼ��������
'	s_FieldName	: ���ص���������	
'	a_Name		: ��ֵ������
'	a_Value		: ��ֵֵ����
'	v_InitValue	: ��ʼֵ
'	s_Sql		: �����ݿ���ȡֵʱ,select name,value from table
'	s_AllName	: ��ֵ������,��:"ȫ��","����","Ĭ��"
' ===============================================
Function InitSelect(s_FieldName, a_Name, a_Value, v_InitValue, s_Sql, s_AllName)
	Dim i
	InitSelect = "<select name='" & s_FieldName & "' size=1>"
	If s_AllName <> "" Then
		InitSelect = InitSelect & "<option value=''>" & s_AllName & "</option>"
	End If
	If s_Sql <> "" Then
		oRs.Open s_Sql, oConn, 0, 1
		Do While Not oRs.Eof
			InitSelect = InitSelect & "<option value=""" & inHTML(oRs(1)) & """"
			If oRs(1) = v_InitValue Then
				InitSelect = InitSelect & " selected"
			End If
			InitSelect = InitSelect & ">" & outHTML(oRs(0)) & "</option>"
			oRs.MoveNext
		Loop
		oRs.Close
	Else
		For i = 0 To UBound(a_Name)
			InitSelect = InitSelect & "<option value=""" & inHTML(a_Value(i)) & """"
			If a_Value(i) = v_InitValue Then
				InitSelect = InitSelect & " selected"
			End If
			InitSelect = InitSelect & ">" & outHTML(a_Name(i)) & "</option>"
		Next
	End If
	InitSelect = InitSelect & "</select>"
End Function

Function inHTML(str)	'�˶κ��¶Σ��������溯��
	Dim sTemp
	sTemp = str
	inHTML = ""
	If IsNull(sTemp) = True Then
		Exit Function
	End If
	sTemp = Replace(sTemp, "&", "&amp;")
	sTemp = Replace(sTemp, "<", "&lt;")
	sTemp = Replace(sTemp, ">", "&gt;")
	sTemp = Replace(sTemp, Chr(34), "&quot;")
	inHTML = sTemp
End Function
' ============================================
' ���ַ�������HTML����,�滻server.htmlencode
' ȥ��Html��ʽ��������ʾ���
' ============================================
Function outHTML(str)
	Dim sTemp
	sTemp = str
	outHTML = ""
	If IsNull(sTemp) = True Then
		Exit Function
	End If
	sTemp = Replace(sTemp, "&", "&amp;")
	sTemp = Replace(sTemp, "<", "&lt;")
	sTemp = Replace(sTemp, ">", "&gt;")
	sTemp = Replace(sTemp, Chr(34), "&quot;")
	sTemp = Replace(sTemp, Chr(10), "<br>")
	outHTML = sTemp
End Function

function CheckSaveFileNamePic(objSavePic,objContent)	'��Ҫ����༭����ɾ��ͼƬ�󣬱���ͼƬ�ֶεĵ�����
	if(objSavePic="" or objSavePic=null) then exit function
	tFileName=""
	arrFile = Split(objSavePic,"|")
	for i=0 to ubound(arrFile)
	  if Instr(objContent,arrFile(i))>0 then tFileName = tFileName & "|" & arrFile(i)
    next
	if left(tFileName,1) = "|" then tFileName = right(tFileName,(len(tFileName)-1))
	if instr(tFileName,"||")>0 then tFileName = trim(replace(tFileName,"||","|"))
	CheckSaveFileNamePic=tFileName
end function

' ============================================
	'*��ʾ��֤��
' ============================================
Function getcode() 
	Dim test
	'On Error Resume Next
	Set test=Server.CreateObject("Adodb.Stream")
	Set test=Nothing
	If Err Then
		Dim zNum
		Randomize timer
		zNum = cint(8999*Rnd+1000)
		Session("GetCode") = zNum
		getcode= Session("GetCode")		
	Else
		getcode= "<img src=""ValidationCode/getcode.asp"">"		
	End If
End Function

' ============================================
' * �õ���ǰ����URL
' ============================================
Function GetFullUrl()
   dim httpHost,scriptName,queryStr
   httpHost=request.ServerVariables("HTTP_HOST")
   scriptName=Request.ServerVariables("SCRIPT_NAME")
   queryStr=request.ServerVariables("QUERY_STRING")
  	if queryStr<>"" then
		queryStr="?"&queryStr
	end if
  	GetFullUrl=lcase("http://"&httpHost&scriptName&queryStr)
End Function

' ============================================
' * �õ���ǰҳ�ļ���
' ============================================
function getFileName()
	scriptName=Request.ServerVariables("SCRIPT_NAME")
	getFileName=lcase(right(scriptName,len(scriptName)-InstrRev(scriptName,"/")))
end function



'''''''''''''''''''''''''''''''''''''''''''

' ============================================
' * �õ� IP ��ַ
' ============================================
Function GetIP()
 if(Request.ServerVariables("REMOTE_ADDR") = "") Then
  GetIP = Request.ServerVariables("HTTP_X_FORWARDED_FOR") '����IP��ַ
 else
  GetIP = Request.ServerVariables("REMOTE_ADDR")
 end if
End Function


'**************************************************
'��������ipsource
'��  �ã���ʾ�û���Դ
'��  ����sip
'**************************************************
Function ipsource(sip)
	dim iprs,ipsql,ipconn,ipconnstr
	if isnumeric(left(sip,2)) then
		if sip="127.0.0.1" then sip="192.168.0.1"
		str1=left(sip,instr(sip,".")-1)
		sip=mid(sip,instr(sip,".")+1)
		str2=left(sip,instr(sip,".")-1)
		sip=mid(sip,instr(sip,".")+1)
		str3=left(sip,instr(sip,".")-1)
		str4=mid(sip,instr(sip,".")+1)
		if isNumeric(str1)=0 or isNumeric(str2)=0 or isNumeric(str3)=0 or isNumeric(str4)=0 then
	
		else
			num=cint(str1)*256*256*256+cint(str2)*256*256+cint(str3)*256+cint(str4)-1

			ipsql="select Top 1 country,city from address where ip1 <="&num&" and ip2 >="&num&""
			set iprs=ipConn.execute(ipsql)
			if iprs.eof and iprs.bof then 
				country="����"
				city=""
			else
				country=iprs("country")
				city=iprs("city")
			end if
			
			iprs.close
			set iprs=nothing
			ipconn.close
			set ipconn=nothing
		end if
			ipsource=country&city
	else
		ipsource="δ֪"
	end if
end function

'����ˮӡ

Function JpegPersits(FileName)
	WatermarkType=0  'ˮӡ��ʽ,0Ϊˮӡ����,1ΪˮӡͼƬ
	widthposition="left" 'ˮӡλ��,left,center,right
	'HeightPosition="left" '��ֱλ��,top,center,bottom

	if WatermarkType=0 then
		Set Jpeg = Server.CreateObject("Persits.Jpeg") ' ��������
		'response.Write server.MapPath("../"&FileName)
		Jpeg.Open Server.MapPath("../"&FileName)  ' ͼƬ����λ��
		Jpeg.Canvas.Font.Color =&HCCCCCC	'��ɫ
		Jpeg.Canvas.Font.Family = "����" 		'����
		Jpeg.Canvas.Font.size =25		'��С
		Jpeg.Canvas.Font.Bold = false	'�Ƿ�Ӵ�
		'Jpeg.Canvas.Font.ShadowXoffset = 10		'ˮӡ������Ӱ����ƫ�Ƶ�����ֵ�����븺ֵ������ƫ��
		'Jpeg.Canvas.Font.ShadowYoffset = 10		'ˮӡ������Ӱ����ƫ�Ƶ�����ֵ�����븺ֵ������ƫ��
		Title = "water"  'ˮӡ����
		TitleWidth = Jpeg.Canvas.GetTextExtent(Title)
		'if Jpeg.Width<TitleWidth then exit function	'ͼƬ��ˮӡ����С���򲻼�ˮӡ
		select case widthposition
		case "left"
			PositionWidth=10
		case "center"
			PositionWidth=(Jpeg.Width - TitleWidth) / 2
		case "right"
			PositionWidth= Jpeg.Width - TitleWidth - 10
		end select
		Jpeg.Canvas.Print PositionWidth, 10, Title
		 
		Jpeg.Save  Server.mappath("../"&FileName)  ' �����ļ�
		Set Jpeg = Nothing
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	elseif WatermarkType=1 then
		Set Jpeg2 = Server.CreateObject("Persits.Jpeg")
		Jpeg2.Open Server.MapPath("upfile/water.jpg")  'ˮӡͼƬλ��
		Jpeg2Width=Jpeg2.OriginalWidth
		Jpeg2Height=Jpeg2.OriginalHeight
		if Jpeg.Width<Jpeg2Width or Jpeg.Height<Jpeg2Height*2 then exit function	'ͼƬ��ˮӡͼƬС���򲻼�ˮӡ
		select case widthposition
		case "left"
			PositionWidth=10
		case "center"
			PositionWidth=(Jpeg.Width - Jpeg2Width) / 2
		case "right"
			PositionWidth= Jpeg.Width - Jpeg2Width - 10
		end select
		select case HeightPosition
		case "top"
			PositionHeight=10
		case "center"
			PositionHeight=(Jpeg.Height - Jpeg2Height) / 2
		case "bottom"
			PositionHeight= Jpeg.Height - Jpeg2Height - 10
		end select
		Jpeg.Canvas.DrawImage PositionWidth, PositionHeight, Jpeg2, 1, &HFFFFFF	'͸����, ͸����ɫ
	end if
End Function



'**************************************************
'��������WriteErrMsg
'��  �ã���ʾ������ʾ��Ϣ
'��  ������
'**************************************************
sub WriteErrMsg(errMsgs)
	dim strErr
	strErr=strErr & "<html><head><title>������ʾҳ��</title><meta http-equiv='Content-Type' content='text/html; charset=gb2312'>" & vbcrlf
	strErr=strErr & "</head><body><br><br>" & vbcrlf
	strErr=strErr & "<table cellpadding=5 cellspacing=0 border=0 width=400 class='border' align=center>" & vbcrlf
	strErr=strErr & "  <tr><td  align='center'><strong>������Ϣ</strong></td></tr>" & vbcrlf
	strErr=strErr & "  <tr><td height='100' valign='top'><b>��������Ŀ���ԭ��</b>" & errMsgs &"</td></tr>" & vbcrlf
	strErr=strErr & "  <tr><td  align='center'><input type=button onclick='history.go(-1)' value=' ���� '>&nbsp;&nbsp;<input type=button onclick='window.close();' value=' �ر� '></td></tr>" & vbcrlf
	strErr=strErr & "</table>" & vbcrlf
	strErr=strErr & "</body></html>" & vbcrlf
	response.write strErr
end sub



'**************************************************
	'��������CheckSize
	'��ת����ʾ�Ĵ�С
	'��  ����ByteSize
'**************************************************
Function CheckSize(ByteSize)  
	if ByteSize>=1073741824 then
		ByteSize=formatnumber(ByteSize/1073741824,2)&" GB"
	elseif ByteSize>=1048576 then
		ByteSize=formatnumber(ByteSize/1048576,2)&" MB"
	elseif ByteSize>=1024 then
		ByteSize=formatnumber(ByteSize/1024,2)&" KB"
	else
		ByteSize=ByteSize&" Byte"
	end if
	CheckSize=ByteSize
End Function


Private Function CheckPath(ByVal sPath)
 If Right(sPath,1)<>"\" Then
 	sPath = sPath & "\"
 End If
 CheckPath = sPath
End Function



 %>