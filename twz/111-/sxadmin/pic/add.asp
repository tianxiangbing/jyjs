<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>后台管理</title>
<link rel="stylesheet" href="../css/common.css" type="text/css" />
<script type="text/javascript" src="../js/checkForm.js"></script>
</head>
<body>
<!--#include file="../inc/subCode.asp"-->
<!--#include file="../fckeditor/fckeditor.asp" -->
<!--<div id="container">-->
<% 
if request.querystring("action")="add" then' 取提交过来的数据
'注意取新闻内容的方法，因为对大表单的自动处理，一定要使用循环，否则大于100K的内容将取不到，单个表单项的限制为102399字节（100K左右）
	Dim  title,newsClass,power,newspic,sContent,isSuggest,i
	title = Request.Form("title")
	Entitle = Request.Form("Entitle")
	newsClass = Request.Form("newsClass")
	power = Request.Form("power")
	newsPic = Request.Form("newsPic")
	isSuggest=request.Form("isSuggest")
	if isSuggest="" then isSuggest=false end if 
	if newsClass="" then newsClass=0 end if 	

	' 开始：eWebEditor编辑区取值-----------------
	scontent = ""
	For i = 1 To Request.Form("content").Count
		scontent = scontent & Request.Form("content")(i)
	Next
	scontent=getSafeContent(scontent)
	
	Encontent = ""
	For i = 1 To Request.Form("Encontent").Count
		Encontent = Encontent & Request.Form("Encontent")(i)
	Next
	' 结束：eWebEditor编辑区取值-----------------

	' 上传后保存到本地服务器的文件名（不带路径），多个以"|"分隔
	Dim d_savefilename
	' 上传后保存到本地服务器的路径文件名，多个以"|"分隔
	Dim d_savepathfilename,SaveFileName,SavePathFileName,sql
	d_savefilename=GetSafeStr(Request.Form("d_savefilename"))
	d_savepathfilename=GetSafeStr(Request.Form("d_savepathfilename"))
	
	SaveFileName=CheckSaveFileNamePic(d_savefilename,scontent)						'主要解决编辑器中删除图片后，保存图片字段的调整。
	SavePathFileName=CheckSaveFileNamePic(d_savepathfilename,scontent)
	
	sql="insert into pic(title,Entitle,ClassId,content,Encontent,Power,isSuggest,newsPic,d_savefilename,d_savepathfilename) values('"&title&"','"&Entitle&"',"&newsClass&",'"&scontent&"','"&Encontent&"',"&Power&","&isSuggest&",'"&newsPic&"','"&SaveFileName&"','"&SavePathFileName&"')"
	conn.execute(sql)
	ok "发布成功！","add.asp"
end if
%>
  <table width="100%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
    <form id="form1" name="form1" method="post" action="add.asp?action=add" onSubmit="return chkNews();">
	<input type="hidden" name="d_savefilename">
    <input type="hidden" name="d_savepathfilename" onChange="doChange(this,document.form1.newsPic)">
	<tr>
      <td colspan="2" class="table_title">发布图片</td>
    </tr>
   <!-- <tr>
      <td width="15%" align="right" class="left_title_2">信息类别：</td>
      <td width="85%">
      <select name="newsClass"  style="background-color:#ECF3FF;">
      <option value="">请选择类别</option>
      <% ' showClass 0,0,0,"picClass" %>
      </select>
      <span class="red">*</span></td>
    </tr>-->
    <tr>
      <td align="right" class="left_title_2">中文信息标题：</td>
      <td>
        <input name="title" type="text" id="title" size="45" maxlength="100" /><span class="red">*</span>
      </td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">英文信息标题：</td>
      <td>
        <input name="Entitle" type="text" id="Entitle" size="45" maxlength="100" /><span class="red">*</span>
      </td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">排　　序：</td>
      <td><input name="power" type="text" id="power" value="0" size="6" maxlength="6" />
        <span class="red">*(按降序排列，即数字越大的越在前面)</span></td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">上传图片：</td>
      <td><input name="newsPic" type="text"  id="newsPic" value="" size="25" readonly="" />
&nbsp;
<iframe src="../inc/sctp.asp?formname=form1&amp;editname=newsPic&amp;uppath=upfile/pic&amp;filelx=<%= EnableUploadPic %>&amp;enFileSize=<%= EnableUploadPicSize %>" width="320" height="35" frameborder="0" scrolling="No" style="vertical-align:middle" id="uploadFrame" ></iframe>
<span id="uploadInfo"></span><br /><font color="#FF0000">图片格式：<%= EnableUploadPic %> * 图片尺寸大小：300*180</font></td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">中文信息内容：</td>
      <td>
      <%
	  Set oFCKeditor = New FCKeditor 
	  oFCKeditor.BasePath = "../FCKeditor/"  '基本路径，见意不要改动。
	 ' //设置编辑器的路径，我站点根目录下的一个目录 
	 oFCKeditor.ToolbarSet = "Default"   '采用哪几种工具条，有Default,base,具体   										                                          fckconfig.js里面设定.   
	 oFCKeditor.Width = "100%" '这里设定宽度,可以按 % 和值来选定.   
	 oFCKeditor.Height = "400" 
	 oFCKeditor.Value = "" '//这个是给编辑器初始值 
	 oFCKeditor.Create "content" '//以后编辑器里的内容都是由这个logbody取得，命名由你定
	 %>
      </td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">英文信息内容：</td>
      <td>
      <%
	  Set oFCKeditor = New FCKeditor 
	  oFCKeditor.BasePath = "../FCKeditor/"  '基本路径，见意不要改动。
	 ' //设置编辑器的路径，我站点根目录下的一个目录 
	 oFCKeditor.ToolbarSet = "Default"   '采用哪几种工具条，有Default,base,具体   										                                          fckconfig.js里面设定.   
	 oFCKeditor.Width = "100%" '这里设定宽度,可以按 % 和值来选定.   
	 oFCKeditor.Height = "400" 
	 oFCKeditor.Value = "" '//这个是给编辑器初始值 
	 oFCKeditor.Create "Encontent" '//以后编辑器里的内容都是由这个logbody取得，命名由你定
	 %>
      </td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td class="left_title_2">&nbsp;</td>
      <td><input type="submit" name="btnsubmit" value="提 交" class="button2"> &nbsp; 
      <input type="reset" name="btnreset" value="重 写" class="button2"></td>
    </tr>  </form>
  </table>
<!--</div>-->
</body>
</html>
