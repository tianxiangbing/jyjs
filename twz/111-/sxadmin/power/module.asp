<!--#include file="../inc/subCode.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��̨����</title>
<link rel="stylesheet" href="../css/common.css" type="text/css" />
<script type="text/javascript" src="../js/checkForm.js"></script>
<script type="text/javascript">
function selectMenu(obj,tValue)
{
	//alert(obj);
	//alert(tValue);
	//alert(document.all.item("0_1").value);
	if(tValue)
	{	
		document.all(obj).checked="checked";
	}
}

</script>
</head>
<body>
<div id="container">
<% if request.querystring("action")="add" then' ȡ�ύ����������
		
		 username = htmlEncode(trim(Request.Form("username")))
		 power = htmlEncode(replace(Request.Form("power")," ",""))
		 powerDetail = htmlEncode(replace(Request.Form("powerDetail")," ",""))
		 describe = htmlEncode(trim(Request.Form("describe")))
		 
		 if username="" then erro "�������ɫ����"
		 if power="" then erro "����ѡ��һ���鿴Ȩ��!"
		 num=conn.execute("select count(*) from power where username='"&username&"'")(0)
		 if num>0 then
		   erro "�˽�ɫ�����Ѵ��ڣ����������룡"
		 end if 
		 
		' response.write power
'		 response.write powerdetail
'		 response.end
		
		sql="insert into [power]([username],[power],[powerDetail],[describe]) values('"&username&"','"&power&"','"&powerDetail&"','"&describe&"')"
		'response.write sql
		'response.end
		conn.execute(sql)
		
		ok "��ӳɹ���","add.asp"
	end if

 %>

  <table width="100%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
    <form id="form1" name="form1" method="post" action="../../sxadmin/power/module.asp?action=add" onSubmit="return chkAddRole();">
	<tr>
      <td colspan="2" class="table_title">��ӽ�ɫ</td>
    </tr>
    
    <tr>
      <td width="14%" align="right" class="left_title_2">��ɫ���ƣ�</td>
      <td>
        <input name="username" type="text" id="username" size="25" maxlength="40" />
        <span class="red">*</span>      </td>
    </tr>
    <tr>
      <td align="right" class="left_title_2">��ɫȨ�ޣ�</td>
      <td align="left"><table width="100%" border="0" cellpadding="3" cellspacing="1" class="table_style">
        <% for i=0 to ubound(leftMenu,1)
			if isempty(leftMenu(i,0)) then exit for  %>
        <tr>
          <td width="12%" align="center"><%= leftMenu(i,0) %> </td>
          <td>
		   
				 
				  <table width="80%" border="0" cellspacing="0" cellpadding="0">
                     <% 
			    for j=1 to  ubound(leftMenu,2)
				  if isempty(leftMenu(i,j)) then exit for
				  arrLeftMenu=split(leftMenu(i,j),",") %>
				  
                    <tr>
                      <td width="17%" align="left"> <%= arrLeftMenu(0) %> </td>
                      <td width="83%" align="left" valign="middle">
					  <input type="checkbox" name="power" id="<%= i&"_"&j %>"  value="<%= i&"_"&j %>" />
					  ����
					  <% set tRs=conn.execute("select * from powerDetail where MenuPId="&i&" and MenuId="&j&" order by paixu desc ") 
					  	do while not tRs.eof%>
						 <input type="checkbox" name="powerDetail"  value="<%= tRs("id") %>" onClick="selectMenu('<%= i&"_"&j %>',this.checked)" /><%= getPowerName(tRs("PowerName")) %>
						<%tRs.movenext
						loop
						closeRs(tRs)%>					  </td>
                    </tr>
					<% next %>
                  </table>					  </td>
          </tr>
		<% next %>
      </table>        </td>
      </tr>
     <tr>
      <td width="14%" align="right" class="left_title_2">��ɫ������</td>
      <td>
        <textarea name="describe" cols="50" rows="3"></textarea>       </td>
    </tr>
    
    
     <tr bgcolor="#FFFFFF">
       <td class="left_title_2"></td>
       <td height="40" valign="bottom"><span class="red">ע�⣺�޸ģ�ɾ��Ȩ�ޱ����ڡ����ơ���Ȩ���ϲ�����</span></td>
     </tr>
     <tr bgcolor="#FFFFFF">
      <td class="left_title_2"></td>
      <td height="40" valign="bottom"><input type="submit" name="btnsubmit" value="�� ��" class="button2"> &nbsp; 
      <input type="reset" name="btnreset" value="�� д" class="button2"></td>
    </tr>  </form>
  </table>
</div>
</body>
</html>
