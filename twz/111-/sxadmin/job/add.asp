<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��̨����</title>
<link rel="stylesheet" href="../css/common.css" type="text/css" />
<script type="text/javascript" src="../js/checkForm.js"></script>
<script type="text/javascript">
function doChange(objText, objDrop){
		if (!objDrop) return;
		var str = objText.value;
		var arr = str.split("|");
		var nIndex = objDrop.selectedIndex;
		objDrop.length=1;
		for (var i=0; i<arr.length; i++){
			objDrop.options[objDrop.length] = new Option(arr[i], arr[i]);
		}
		objDrop.selectedIndex = nIndex;
	}

function change(val)
{
		switch(val)
		{
			case "0":
				document.getElementById("Cn_title").style.display = "table-row";
				document.getElementById("Cn_content").style.display = "table-row";	
				document.getElementById("En_title").style.display = "none";
				document.getElementById("En_content").style.display = "none";	
				break;
			case "1":
				document.getElementById("Cn_title").style.display = "none";
				document.getElementById("Cn_content").style.display = "none";	
				document.getElementById("En_title").style.display = "table-row";
				document.getElementById("En_content").style.display = "table-row";	
				break;
			case "2":
				document.getElementById("Cn_title").style.display = "table-row";
				document.getElementById("Cn_content").style.display = "table-row";	
				document.getElementById("En_title").style.display = "table-row";
				document.getElementById("En_content").style.display = "table-row";	
				break;
		
		}
	
	}
</script>
</head>
<!--#include file="../inc/subCode.asp"-->
<body onLoad="change('0')">
<!--<div id="container">
--><% 
   if request.querystring("action")="add" then' ȡ�ύ����������
   Dim jobName,jobNum,major,education,treatment,content,power,EndTime,EnjobName,Encontent,languages
	jobName = htmlEncode(trim(Request.Form("jobName")))
	EnjobName = htmlEncode(trim(Request.Form("EnjobName")))
	jobNum = htmlEncode(trim(Request.Form("jobNum")))
	major =  htmlEncode(trim(Request.Form("major")))
	education =  htmlEncode(trim(Request.Form("education")))
	treatment = htmlEncode(trim(Request.Form("treatment")))
	content = htmlEncode(trim(Request.Form("content")))
	Encontent = htmlEncode(trim(Request.Form("Encontent")))
	power = htmlEncode(trim(Request.Form("power"))) 
	languages = htmlEncode(trim(Request.Form("languages"))) 
	EndTime = htmlEncode(trim(Request.Form("EndTime")))
	if jobNum="" then jobNum=1 end if
	if power="" then power=0 end if 
	
	sql="insert into job(jobName,EnjobName,jobNum,major,education,treatment,content,Encontent,power,EndTime,languages) values('"&jobName&"','"&EnjobName&"',"&jobNum&",'"&major&"','"&education&"','"&treatment&"','"&content&"','"&Encontent&"',"&power&",'"&EndTime&"','"&languages&"')"
	conn.execute(sql)
	
	ok "��ӳɹ���","add.asp"
end if

 %>

  <table width="100%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
    <form id="form1" name="form1" method="post" action="../../sxadmin/job/add.asp?action=add" onSubmit="return chkAddJob();">
	<tr>
      <td colspan="2" class="table_title">������Ƹ��Ϣ</td>
    </tr>
    <tr> 
      <td height="30" align="right" bgcolor="#FFFFFF"><span class="left_title_2">����ѡ��</span>��</td>
      <td bgcolor="#FFFFFF">
	  <select name="languages" id="languages" onChange="change(this.value)">
        <option value="0" selected>����</option>
        <option value="1">Ӣ��</option>
		 <option value="2">��Ӣ��</option>
      </select>
      </td>
</tr>
    <tr id="Cn_title">
      <td align="right" class="left_title_2">������Ƹ��λ��</td>
      <td>
        <input name="jobName" type="text" id="jobName" size="30" maxlength="50" />
        <span class="red">*</span>
      </td>
    </tr>
     <tr id="En_title" >
      <td align="right" class="left_title_2">Ӣ����Ƹ��λ��</td>
      <td>
        <input name="EnjobName" type="text" id="EnjobName" size="30" maxlength="50" />
        <span class="red">*</span>
      </td>
    </tr>
	<tr>
      <td align="right" class="left_title_2">��Ƹ������</td>
      <td>
      <input name="jobNum" type="text" id="jobNum" size="5" maxlength="10" />
      <span class="red">* </span> ��Ϊ����</td>
    </tr>
	<tr>
      <td align="right" class="left_title_2">��ֹʱ�䣺</td>
      <td>
      <input name="endTime" type="text" id="endTime" size="15" maxlength="20" value="<%= date()+30 %>" />
      <span class="red">*</span> Ĭ��һ����</td>
    </tr>
	<tr>
      <td align="right" class="left_title_2">רҵҪ��</td>
      <td>
      <input name="major" type="text" id="major" size="30" maxlength="50" /></td>
    </tr>
	<tr>
      <td align="right" class="left_title_2">ѧ��Ҫ��</td>
      <td>
      <input name="education" type="text" id="education" size="20" maxlength="50" /></td>
    </tr>
	
	<tr>
      <td align="right" class="left_title_2">н�ʴ�����</td>
      <td>
      <input name="treatment" type="text" id="treatment" size="20" maxlength="50" /></td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">�š�����</td>
      <td><input name="power" type="text" id="power" value="0" size="6" maxlength="6" /><span class="red">*</span></td>
    </tr>
    <tr id="Cn_content">
      <td align="right" class="left_title_2">���ĸ�λ������</td>
      <td><textarea name="content" cols="50" rows="5" id="content" ></textarea><span class="red">*</span></td>
    </tr>
      <tr id="En_content">
      <td align="right" class="left_title_2">Ӣ�ĸ�λ������</td>
      <td><textarea name="Encontent" cols="50" rows="5" id="Encontent" ></textarea><span class="red">*</span></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td class="left_title_2">&nbsp;</td>
      <td><input type="submit" name="btnsubmit" value="�� ��" class="button2"> &nbsp; 
      <input type="reset" name="btnreset" value="�� д" class="button2"></td>
    </tr>  </form>
  </table>
<!--</div>-->
</body>
</html>
