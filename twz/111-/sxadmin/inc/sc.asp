<!--#include file="config.asp"-->
<!--#include file="../judge2.asp"-->
<!--#include file="sc.inc"-->
<!--#include file="function.asp"-->
<!--#include file="common.asp"-->
<style>
td{font-size:9pt;line-height:120%;color:#353535} 
body{font-size:9pt;line-height:120%} 

a:link          { color: #000000; text-decoration: none }
a:visited       { color: #000000; text-decoration: none }
a:active        { color: #000000; text-decoration: none }
a:hover         { color: #336699; text-decoration: none; position: relative; right: 0px; top: 1px }
</style>
<%
response.Write("<script type='text/javascript'>parent.document.getElementById(""uploadInfo"").innerHTML='';</script>")
response.Write("<script type='text/javascript'>parent.document.getElementById(""uploadFrame"").width=350;</script>")
response.Write("<script type='text/javascript'>parent.document.getElementById(""uploadFrame"").height=35;</script>")

if not IsSelfPost then
 	erro "��ͨ����վ�ύ����!"
end if

'on error resume next
server.ScriptTimeout=300 '��λ�� ��5���� 
dim upload,file,formName,formPath

set upload=new upload_file '�����ϴ�����

if err then
	'err.clear
	'ErrInfo Err.Description
	'ErrInfo "�ļ�̫��,�������ϴ�"
end if

'���ձ�ֵ
filepath=trim(upload.form("filepath"))''�õ��ϴ�Ŀ¼
filelx=trim(upload.form("filelx"))'�õ�������ļ�����
enfileSize=cLng(trim(upload.form("enfileSize")))'�õ�������ļ���С
parentFormName=upload.form("FormName")
EditName=upload.form("EditName")

if filepath="" then 
 ErrInfo "���������ϴ�Ŀ¼!"
end if
if right(filepath,1)<>"/" then filepath=filepath&"/"  ''��Ŀ¼���(/)

for each formName in upload.objFile ''�г������ϴ��˵��ļ�
	set file=upload.file(formName)  ''����һ���ļ�����
	fileExt=lcase(file.FileExt)	'�õ��ļ�����չ��.
 
	if file.FileSize<0 then         ''��� FileSize > 0 ˵�����ļ�����
		ErrInfo "����ѡ����Ҫ�ϴ����ļ���"
	end if	

	if instr(lcase(filelx),lcase(fileExt))=0 then 	
		ErrInfo "ֻ���ϴ�"&filelx&"��ʽ���ļ���"
	end if
	
	if file.filesize>enfileSize then
			ErrInfo "���ֻ���ϴ� "&CheckSize(enfileSize)&" ���ļ���"
	end if
	
	filenamepre=randName	'randName����
	
	file.SaveAs Server.mappath("../../"&filepath&filenamepre&"."&fileExt)   ''�����ļ�
	
	if(fileext="jpg" or fileext="gif") then
		call smallpic(filepath&filenamepre&"."&fileExt)'����ͼ
		'call JpegPersits(FileName)  'ˮӡ
  	end if 

	response.write "<script>parent."&parentFormName&"."&EditName&".value='"&filepath&filenamepre&"."&fileExt&"'</script>"  '�����ϴ�·��
 	if filelx="doc" then 
      response.write "<script>parent."&parentFormName&".sizes.value='"&file.FileSize&"'</script>"
	end if


	response.Write("�ϴ��ɹ���<a href='#' onclick=history.go(-1) >��Ҫ�����ϴ���</a>")
	
	set file=nothing
next
  
set upload=nothing


	
sub ErrInfo(Msg)
 set upload=nothing
 response.write "<span style=""font-family: ����; font-size: 9pt;color:red;"">"&Msg&"��[ <a href='javascript:history.back()'>�����ϴ�</a> ]</span>"
 response.end
end sub

sub smallpic(FileName)  '��������ͼ
	Set Jpeg = Server.CreateObject("Persits.Jpeg")
	Path = Server.MapPath("../../"&FileName)
	Jpeg.Open Path
	
	w=Jpeg.Width   '��ȡԭͼ���
	h=Jpeg.Height 
	
	sw=200	'����ת��ֵ
	sh=200 	
		
	'�߻��ȿ��ʱ����ͼƬ������ ���СΪ88*73 �ȿ���w,h���ܵĹ�ϵ,�ٿ���w��h�Ĺ�ϵ(����w=h)
	if(w>sw or h>sh) then  
		if w>h then
		   h=(sw*h)/w
		   w=sw
		elseif w<h then
		   w=(sh*w)/h
		   h=sh
		else  'w=hʱ ����ת��ֵС��Ϊ��ֵ
		   if sw>sh then
			 w=(sh*w)/h
			 h=sh
		   elseif sw<sh then
		     w=sh
			 h=(sw*h)/w
		   else
		   	 w=sw 'todo
			 h=sh
		   end if	 
		end if
	else
		 'ͼƬ�ȿ�С�����ʱ,��ͼƬ�ڿ���,������
	end if

	'response.Write w
	'response.Write h
	
	Jpeg.Width=w    'ͼƬ������ֵ
	Jpeg.Height=h
	
	
	'Jpeg.Width = 60
	'Jpeg.Height = 50	'Jpeg.Width,Jpeg.Height����׼ȷ����ֵ������Jpeg.Width=120
	'Jpeg.Width = Jpeg.OriginalWidth / 2 
	'Jpeg.Height = Jpeg.OriginalHeight / 2 
	'��������ͼ��С�������趨Ϊ50%����
	Jpeg.Save Server.MapPath("../../"&filepath&"small_"&filenamepre&"."&fileExt)
	
	Set Jpeg = Nothing
End sub	
	

%>
