<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta name="keywords" content="���ݸ��˽�վ������|Ӧ���˹�����|��վ|��ѽ�վ|������ҳ|�������|��ѿռ�|��ҵ��վ|�Ż���վ|Դ������|HTML|ASP����|.net|ASP|ͼƬ|����|�����|�㽭��վ|���ݽ�վ����|Ӧ�����ں���|Ӧ���˹�����|���˲���" />
<meta name="description" content="����˽�����罨վ��������ר��Ϊ���ˡ���С����ҵ���ṩ��վ�����ƽ̨������ȫ�棬�۸��Żݣ������ܵ�����������ֵ�÷��ĵ�ѡ�񡣱��˵Ĳ�һ���ǾͲ����ӵ������������Ŷӣ����Ը���������ķ�������ʵĲ�Ʒ������:yoooyeeey@163.com" />
<title>��Աע��-Ӧ���˹�����,������ҵ��վ,����������վ,���ݱ�����վ |���ݼ�ְ��վ��|���ݼ�ְ����վ|��ְ��վ-����˵ļ�ְ�������|Ӧ���������</title>
<link href="theam/gray/tb.css" rel="stylesheet" type="text/css" disabled="disabled"  title="gray"/>
<link href="theam/blue/tb.css" rel="stylesheet" type="text/css"title="blue"/>
<script language="javascript" type="text/javascript" src="script/index.js"></script>
<script language="javascript" type="text/javascript" src="script/jquery.js"></script>
<script language="javascript">
var t1=false;
var t2=false;
var t3=false;
var t4=false;
var t5=false;
	
//�ж��û���
function checkuname()
{
    var t=document.getElementById("username");
	var f=/^[a-zA-Z0-9_]{5,16}$/;
	var e=document.getElementById("infoname");
	if(t.value==""||t.value==null)
	{
		e.innerHTML="<font color='blue'> �û�������Ϊ��!</font>";
		t.focus();
		t1=false;
		return false;
	}
	else
	{
	 	if(f.test(t.value))
	   	{
		    var url="checkUserName.asp?rnd="+Math.random(10000);
			$.get(url,{"uname":$("#username").val()},function(xml){
				if(xml==1){
					e.innerHTML="<font color='blue'> ����ʹ��!</font>";
					t1=true; 
					return true;
				}else
				{
					t1=false;
					e.innerHTML="<font color='blue'> �û����Ѿ�����!</font>";
					return false;
				}
			})		
			
			return true;
		}
		else
		{
			 e.innerHTML="<font color='blue'> �û����������5���ַ�С��16���ַ�</font>";
			 t.focus();
			 t1=false;
			 return false;
		}
	}	
}
function checkpwd1()
{
	if(!$("#pwd1").val()||$("#pwd1").val().length<6||$("#pwd1").val().length>16){
		$("#pwd1info").html("<font color='blue'>Ϊ��������Ϣ��ȫ,����д6-16λ���ȵ�����!</font>");
		t2=false;
		return false;
	}else
	{
		$("#pwd1info").html("��");
		t2=true;
		return true;
	}
}
function checkpwd2()
{
	if($("#pwd1").val()!=$("#pwd2").val()){
		$("#pwd2info").html("<font color='blue'>�������벻һ��!</font>");
		t3=false;
		return false;
	}else
	{
		$("#pwd2info").html("��");
		t3=true;
		return true;
	}
}
 function checkEmail()
 {
	var vEmail=/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
	var email=$("#email").val();
	if(!vEmail.test(email))
	{
		$("#sm").css("color","blue");
		document.getElementById("sm").innerHTML="<font color='blue'>�����ʽ����ȷ!</font>";  
		t4=false;      
		return false;
	}else
	{    
		document.getElementById("sm").innerHTML='��';
		t4=true;
		return true;    
	}
 }
function checkQQ(){
	if(!$("#qq").val())
	{
		$("#qqinfo").html("<font color='blue'>����Ϊ��!</font>");
		t5=false;
		return false;
	}else
	{
		t5=true;
		$("#qqinfo").html("��");
		return true;
	}
}
function checkall()
{	alert(checkuname()+"-"+checkpwd1()+"-"+checkpwd2()+"-"+checkEmail()+"-"+checkQQ())
	if(checkuname()&&checkpwd1()&&checkpwd2()&&checkEmail()&&checkQQ()){
		return true;
	}else
	{		
		alert('�뽫������д����!');
		return false;
	}
}
</script>
<style type="text/css">
.tdmoney {
	background-image: url(images/bjb.gif);background-repeat:no-repeat;
	height:100px;
	width:185px;
	padding-top: 30px;
	text-indent: 5px;
}
    </style>
</head>

<body>
<!--#include file="top.htm"-->
<!--#include file="menu.htm"-->
<table width="90%" height="234" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="85"><table width="100%">
      <tr>
        <td width="200px" height="100%" valign="top"><!--#include file="left.asp"--></td>
        <td  class="sx">
		<div id="editContent">
          <div>                <form id="form1" name="form1" method="post" action="execute.asp?action=add" onsubmit="return checkall();" >
			  <table width="100%" height="200" border="0" cellpadding="0" cellspacing="0">

                  <tr>
                    <td height="25" colspan="2">ע��<span class="font6">*</span>Ϊ������</td>
                    <td width="20%" align="right">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="18%" height="24" align="center">
                      ��Ա���ƣ�</td>
                    <td colspan="2"><input name="username" type="text" id="username" onblur="checkuname();"/><span id="infoname">*
                      5-16���ַ�(����Сд��ĸ�����֡��»���)��</span></td>
                  </tr>
                  <tr>
                    <td height="26" align="center">��Ա���룺</td>
                    <td height="25" colspan="2">
                      <input name="pwd1" type="password" id="pwd1" onblur="checkpwd1();"/>
                      <span class="font6" id="pwd1info">*</span>
					  </td>
				  </tr> 
                  <tr>
                    <td height="26" align="center">�ظ����룺</td>
                    <td height="25" colspan="2">
                      <input name="pwd2" type="password" id="pwd2" onblur="checkpwd2();" onchange="checkpwd2();"/>
                      <span class="font6" id="pwd2info">*</span></td>
					</tr> 
                  <tr>
                    <td height="25" align="center">��ʵ������</td>
                    <td colspan="2"><input name="userrel" type="text" id="userrel" /></td>
                  </tr>
                  <tr>
                    <td height="25" align="center">�������䣺</td>
                    <td colspan="2"><input name="email" type="text" id="email" onblur="checkEmail()"/>
                      <span  id="sm">* xxx@xxx.xxx</span></td>
                  </tr>
                  <tr>
                    <td height="25" align="center">QQ/MSN��</td>
                    <td colspan="2">
                      <input name="qq" type="text" id="qq" onblur="checkQQ()"/> <span id="qqinfo">
                        *</span></td>
                  </tr>
                  <tr>
                    <td height="25" align="center">�ƶ��绰��</td>
                    <td colspan="2"><span class="font6" id="email">
                      <input name="mobile" type="text" id="mobile" size="15"/>
                        </span></td>
                  </tr>
                  <tr>
                    <td height="25">&nbsp;</td>
                    <td colspan="2">&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="25">&nbsp;</td>
                    <td colspan="2">
					<input type="submit" name="tijiao" id="tijiao" value="ע��ȷ��" /> 
                    <input type="reset" name="button2" id="button2" value="������д" /></td>
                  </tr>
              </table></form>
		      </div>
        </div></td>
      </tr>
    </table></td>
  </tr>
</table>
<!--#include file="bottom.htm"-->
</body>
</html>
