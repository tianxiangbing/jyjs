<%
uppath=request.QueryString("uppath")
filelx=request.QueryString("filelx")
enFileSize=request.QueryString("enFileSize")
EditName=request.QueryString("EditName")
formName=request.QueryString("formName")
%>
<html>
<head>
<title>�ļ��ϴ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
td{font-size:12px}
.tx1{height:20px;width:30px;font-size:12px;border:1px solid;border-color:#ccc;color: #0000FF}
-->
</style>
<script language="javascript">
<!--
function chkUpload()
{
	if(form1.file1.value=="")
	{
		alert("����ѡ���ļ���");
		form1.file1.focus();
		return false;
	}
		
	var sAllowExt = "<%= filelx %>";
	if (!IsExt(document.form1.file1.value,sAllowExt))
	{
		alert("��ʾ��\n\n��ѡ��һ����Ч���ļ���\n֧�ֵĸ�ʽ�У�"+sAllowExt+"����");
		form1.file1.focus();
		return false;
	}
	
	innerStr="<img src='../images/uploading.gif' width='110'><font color='blue'>�ϴ��С������Ժ�.</font>";
	//innerStr=innerStr+"<a href='#' onClick=document.getElementById('uploadFrame').src='sctp.asp'>ȡ��</a>"
	parent.document.getElementById("uploadInfo").innerHTML=innerStr;
	parent.document.getElementById("uploadFrame").width=0;
	parent.document.getElementById("uploadFrame").height=0;
	return true;
	
}
function IsExt(url, opt)
{
		var sTemp;
		var b=false;
		var s=opt.toUpperCase().split("|");
		for (var i=0;i<s.length ;i++ )
		{
			sTemp=url.substr(url.length-s[i].length-1);
			sTemp=sTemp.toUpperCase();
			s[i]="."+s[i];
			if (s[i]==sTemp)
			{
				b=true;
				break;
			}
		}
		return b;
}
-->
</script>
</head>

<body bgcolor="#FFFFFF" style="margin:0px;">
  <table width="300" height="30" border="0" cellspacing="1" cellpadding="0" align="center">
  <form name="form1" method="post" action="sc.asp" enctype="multipart/form-data" onSubmit="return chkUpload();" >

        <input type="hidden" name="filepath" value="<%=uppath%>">
        <input type="hidden" name="filelx" value="<%=filelx%>">
		<input type="hidden" name="enFileSize" value="<%=enFileSize%>">
        <input type="hidden" name="EditName" value="<%=EditName%>">
        <input type="hidden" name="FormName" value="<%=formName%>">
        
    <tr align="center" valign="middle" bgcolor="#FFFFFF"> 
      <td align="center"  height="20" width="252"><input type="file" name="file1" style="width:250" class="tx1" ></td>
      <td align="center"  width="60"><input type="submit" name="Submit" value="�� ��"></td>
    </tr>
	</form>
  </table>

</body>
</html>
