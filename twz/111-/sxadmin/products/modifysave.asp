<!--#include file="../inc/subCode.asp"-->
<%
 if request.querystring("action")="edit" then' ȡ�ύ����������
 id=request.QueryString("id")
 checkId(id)
 page=request.QueryString("page")
 
'ע��ȡ��Ʒ���ݵķ�������Ϊ�Դ�����Զ�����һ��Ҫʹ��ѭ�����������100K�����ݽ�ȡ�������������������Ϊ102399�ֽڣ�100K���ң�
	Dim  sContent, proPic, proClass, isSuggest, IsNew, EnProName, proName, power
	proClass = Request.Form("proClass")
	proName = htmlEncode(Request.Form("proName"))
	EnProName = htmlEncode(Request.Form("EnProName"))
	power = Request.Form("power")
	languages = Request.Form("languages")
	proPic = Request.Form("proPic")
	isSuggest=request.Form("isSuggest")
	IsNew=request.Form("IsNew")
	
	' ��ʼ��eWebEditor�༭��ȡֵ-----------------
	scontent = ""
	For i = 1 To Request.Form("content").Count
		scontent = scontent & Request.Form("content")(i)
	Next
	scontent=getSafeContent(scontent)
	
	EnContent = ""
	For i = 1 To Request.Form("EnContent").Count
		EnContent = EnContent & Request.Form("EnContent")(i)
	Next
	EnContent=getSafeContent(EnContent)
	' ������eWebEditor�༭��ȡֵ-----------------

	' �ϴ��󱣴浽���ط��������ļ���������·�����������"|"�ָ�
	Dim sSaveFileName,sSavePathFileName
	' �ϴ��󱣴浽���ط�������·���ļ����������"|"�ָ�
	SaveFileName = GetSafeStr(Request.Form("d_savefilename"))
	SavePathFileName = GetSafeStr(Request.Form("d_savepathfilename"))
	
	SaveFileName=CheckSaveFileNamePic(SaveFileName,scontent)	'��Ҫ����༭����ɾ��ͼƬ�󣬱���ͼƬ�ֶεĵ�����
	SavePathFileName=CheckSaveFileNamePic(SavePathFileName,scontent)
	'
'	sql="update products set ProName='"&ProName&"',ClassId="&proClass&",content='"&scontent&"',Power="&Power&",isSuggest="&isSuggest&",editTime=now(),proPic='"&proPic&"',ProSmallPic='"&ProSmallPic&"',d_savefilename='"&SaveFileName&"',d_savepathfilename='"&SavePathFileName&"' where id="&id
'	conn.execute(sql)
'	ok "�޸ĳɹ���","manage.asp?page="&page

'��������
'on error resume next
set oRs = server.CreateObject("adodb.recordset")
sql = "select * from products where ProId="&Cint(id)
response.Write(sql)
oRs.open sql,conn,3,2

oRs("proName") = proName
oRs("EnProName") = EnProName
oRs("ClassId") = Cint(proClass)

oRs("proPic") = proPic
if len(proPic)>16 then
	oRs("ProSmallPic")="upfile/product"&"small_"&right(proPic,len(proPic)-16)
end if 

oRs("power") = Cint(power)
oRs("languages") = languages
oRs("sContent") = sContent
oRs("EnContent") = EnContent
oRs("d_savefilename") = d_savefilename
oRs("d_savepathfilename") = d_savepathfilename
oRs("addtime") = Now()

if oRs("isSuggest") = yes then 
	oRs("isSuggest") = true
else
	oRs("isSuggest") = false
end if 

if oRs("IsNew") = yes then
	oRs("IsNew") = true
else
	oRs("IsNew") = false
end if 
oRs.update
if err<>0 then
	erro("�޸�ʧ�ܣ������ֶ�") 
else
	ok "�޸ĳɹ�","manage.asp?page="&page
end if 
oRs.close
set oRs=nothing
end if
%>