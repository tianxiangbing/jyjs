<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>���ݼ�ְ��վ��|���ݼ�ְ����վ|��ְ��վ-����˵ļ�ְ�������</title>
<meta name="keywords" content="���ݸ��˽�վ������|Ӧ���˹�����|��վ|��ѽ�վ|������ҳ|�������|��ѿռ�|��ҵ��վ|�Ż���վ|Դ������|HTML|ASP����|.net|ASP|ͼƬ|����|�����|�㽭��վ|���ݽ�վ����|Ӧ�����ں���|Ӧ���˹�����|���˲���" />
<meta name="description" content="����˽�����罨վ��������ר��Ϊ���ˡ���С����ҵ���ṩ��վ�����ƽ̨������ȫ�棬�۸��Żݣ������ܵ�����������ֵ�÷��ĵ�ѡ�񡣱��˵Ĳ�һ���ǾͲ����ӵ������������Ŷӣ����Ը���������ķ�������ʵĲ�Ʒ������:yoooyeeey@163.com" />
<link href="theam/gray/tb.css" rel="stylesheet" type="text/css" disabled="disabled"  title="gray"/>
<link href="theam/blue/tb.css" rel="stylesheet" type="text/css"title="blue"/>
<script language="javascript" type="text/javascript" src="script/index.js"></script>
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
<%
 server_name=Request.ServerVariables("Server_Name")
 if server_name="hz.yingchengshi.cn" then
 %>
 <div style="width:200px;">
 <marquee height="0"><a href="http://www.yingchengshi.cn" target="_blank">��ְ��վ</a><a href="http://www.yingchengshi.cn" target="_blank">��ְ����վ</a><a href="http://www.yingchengshi.cn" target="_blank">��������վ</a><a href="http://www.yingchengshi.cn" target="_blank">��ְ��վ���</a><a href="http://www.yingchengshi.cn" target="_blank">��վ��ְ</a><a href="http://www.yingchengshi.cn" target="_blank">������վ��ְ</a></marquee>
 </div>
 <%else
 %>
 <div style="width:200px;">
 <marquee height="0"><a href="http://hz.yingchengshi.cn" target="_blank">��ְ��վ</a><a href="http://hz.yingchengshi.cn" target="_blank">��ְ����վ</a><a href="http://hz.yingchengshi.cn" target="_blank">��������վ</a><a href="http://hz.yingchengshi.cn" target="_blank">��ְ��վ���</a><a href="http://hz.yingchengshi.cn" target="_blank">��վ��ְ</a><a href="http://hz.yingchengshi.cn" target="_blank">������վ��ְ</a></marquee>
 </div>
 <%
 	end if
 %>
<!--#include file="menu.htm"-->
<table width="90%" height="234" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="85"><table width="100%">
      <tr>
        <td width="200px" height="100%" valign="top"><!--#include file="left.asp"-->
        </td>
        <td align="center" valign="top"  class="sx"><div id="editContent">
            <div class="tb" ></div>
			<h2>�����ڵ�λ��:<a href="http://hz.yingchengshi.cn" target="_blank">Ӧ���˹�����</a>&gt;�Ż���վ</h2>
			<hr class="solidhr" />
			<table width="98%" height="146" border="0" cellpadding="0" cellspacing="0">
              <tr>
			  <!--ѭ�������е���ҵ��վ-->
			  	  <!--ѭ�������е�չʾ��վ-->
			  <%
			  sql="select ProId,ProName,ProPic,Addtime,Power,ProClass  from Products where ReCycle=false and ProClass in(69,75)"
			  set rs=conn.execute(sql)
			  do while not rs.eof
			  %>
                <td align="left" valign="top">
				<table class="proall" width="183" height="201" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td height="112" align="center" valign="middle"><a href="particular.asp?id=<%=rs("ProId")%>"><img src="<%=rs("ProPic")%>" width="150" alt="<%=trim(rs("ProName"))%>" height="150" border="0"/></a></td>
                  </tr>
                  <tr>
                    <td height="26" align="center" valign="middle"><a href="particular.asp?id=<%=rs("ProId")%>">
					<%=left(trim(rs("ProName")),10)%>
					<%if len(trim(rs("ProName")))>10 then response.write "..."%></a></td>
                  </tr>
                </table>
				</td>
			  <%
			  rs.movenext()
			  loop
			  %>
				<!--����-->
              </tr>
            </table>
			<div class="STYLE4"></div>
          <div></div>
        </div></td>
      </tr>
    </table></td>
  </tr>
</table>
<!--#include file="bottom.htm"-->
</body>
</html>
