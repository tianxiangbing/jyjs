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
				document.getElementById("Cn_title").style.display = "block";
				document.getElementById("Cn_content").style.display = "block";	
				document.getElementById("En_title").style.display = "none";
				document.getElementById("En_content").style.display = "none";	
				break;
			case "1":
				document.getElementById("Cn_title").style.display = "none";
				document.getElementById("Cn_content").style.display = "none";	
				document.getElementById("En_title").style.display = "block";
				document.getElementById("En_content").style.display = "block";	
				break;
			case "2":
				document.getElementById("Cn_title").style.display = "block";
				document.getElementById("Cn_content").style.display = "block";	
				document.getElementById("En_title").style.display = "block";
				document.getElementById("En_content").style.display = "block";	
				break;
		
		}
	
	}
</script>
</head>
<!--#include file="../inc/subCode.asp"-->
<%
 id=request.QueryString("id")
 checkId(id)
 if request.querystring("action")="edit" then' ȡ�ύ����������
	 Dim jobName,jobNum,major,education,treatment,content,power,EndTime,EnjobName,Encontent,languages
	jobName = htmlEncode(trim(Request.Form("jobName")))
	EnjobName = htmlEncode(trim(Request.Form("EnjobName")))
	jobNum = htmlEncode(trim(Request.Form("jobNum")))
	major =  htmlEncode(trim(Request.Form("major")))
	education =  htmlEncode(trim(Request.Form("education")))
	treatment = htmlEncode(trim(Request.Form("treatment")))
	content = htmlEncode(trim(Request.Form("content")))
	Encontent = htmlEncode(trim(Request.Form("Encontent")))
	languages = htmlEncode(trim(Request.Form("languages")))
	power = htmlEncode(trim(Request.Form("power")))
	EndTime = htmlEncode(trim(Request.Form("EndTime")))
	if jobNum="" then jobNum=1
	if power="" then power=0
	
	sql="update job set jobName='"&jobName&"',EnjobName='"&EnjobName&"',jobNum="&jobNum&",major='"&major&"',education='"&education&"',treatment='"&treatment&"',content='"&content&"',Encontent='"&Encontent&"',power="&power&",EndTime='"&EndTime&"',languages='"&languages&"' where id="&id
	conn.execute(sql)
	
	ok "�޸ĳɹ���","manage.asp"
end if


set rs=conn.execute("select * from job where id="&id)
if rs.eof then
	erro "��ЧID"
end if
intLan=rs("languages")
%>
<body onLoad="change('<%=intLan%>')">
<!--<div id="container">-->


  <table width="100%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
    <form id="form1" name="form1" method="post" action="../../sxadmin/job/modify.asp?action=edit&id=<%= rs(0) %>" onSubmit="return chkAddJob();">
	<tr>
      <td colspan="2" class="table_title">�޸���Ƹ��Ϣ</td>
    </tr>
     <tr> 
      <td height="30" align="right" bgcolor="#FFFFFF">����ѡ��</td>
      <td bgcolor="#FFFFFF">
	   <select name="languages" id="languages" onChange="change(this.value)">
        <option value="0" <% if intLan=0 then response.Write("selected") end if %>>����</option>
        <option value="1" <% if intLan=1 then response.Write("selected") end if %>>Ӣ��</option>
		<option value="2" <% if intLan=2 then response.Write("selected") end if %>>��Ӣ��</option>
      </select>
      </td>
</tr>
    <tr id="Cn_title">
      <td align="right" class="left_title_2"> ������Ƹ��λ��</td>
      <td>
        <input name="jobName" type="text" id="jobName" size="30" maxlength="50" value="<%= rs("jobName") %>" />
        <span class="red">*</span>
      </td>
    </tr>
     <tr id="En_title">
      <td align="right" class="left_title_2">Ӣ����Ƹ��λ��</td>
      <td>
        <input name="EnjobName" type="text" id="EnjobName" size="30" maxlength="50" value="<%= rs("EnjobName") %>" />
        <span class="red">*</span>
      </td>
    </tr>
	<tr>
      <td align="right" class="left_title_2">��Ƹ������</td>
      <td>
      <input name="jobNum" type="text" id="jobNum" size="5" maxlength="10"  value="<%= rs("jobNum") %>" />
      <span class="red">* </span> ��Ϊ����</td>
    </tr>
	<tr>
      <td align="right" class="left_title_2">��ֹʱ�䣺</td>
      <td>
      <input name="endTime" type="text" id="endTime" size="15" maxlength="20"  value="<%= rs("endTime") %>"  />
      <span class="red">*</span> Ĭ��һ����</td>
    </tr>
	<tr>
      <td align="right" class="left_title_2">רҵҪ��</td>
      <td>
      <input name="major" type="text" id="major" size="30" maxlength="50"  value="<%= rs("major") %>"  /></td>
    </tr>
	<tr>
      <td align="right" class="left_title_2">ѧ��Ҫ��</td>
      <td>
      <input name="education" type="text" id="education" size="20" maxlength="50"  value="<%= rs("education") %>"  /></td>
    </tr>
	
	<tr>
      <td align="right" class="left_title_2">н�ʴ�����</td>
      <td>
      <input name="treatment" type="text" id="treatment" size="20" maxlength="50"  value="<%= rs("treatment") %>"  /></td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">�š�����</td>
      <td><input name="power" type="text" id="power" size="6" maxlength="6"  value="<%= rs("power") %>"  /><span class="red">*</span></td>
    </tr>
    
	
    <tr id="Cn_content">
      <td align="right" class="left_title_2">���ĸ�λ������</td>
      <td><textarea name="content" cols="50" rows="5" id="content" ><%= htmlDecode(rs("content")) %></textarea>        <span class="red">*</span></td>
    </tr>
     <tr id="En_content">
      <td align="right" class="left_title_2">Ӣ�ĸ�λ������</td>
      <td><textarea name="Encontent" cols="50" rows="5" id="Encontent" ><%= htmlDecode(rs("content")) %></textarea><span class="red">*</span></td>
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
