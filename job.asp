<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/main.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta name="keywords" content="���ݸ��˽�վ������|Ӧ���˹�����|��վ|��ѽ�վ|������ҳ|�������|��ѿռ�|��ҵ��վ|�Ż���վ|Դ������|HTML|ASP����|.net|ASP|ͼƬ|����|�����|�㽭��վ|���ݽ�վ����|Ӧ�����ں���|Ӧ���˹�����|���˲���" />
<meta name="description" content="����˽�����罨վ��������ר��Ϊ���ˡ���С����ҵ���ṩ��վ�����ƽ̨������ȫ�棬�۸��Żݣ������ܵ�����������ֵ�÷��ĵ�ѡ�񡣱��˵Ĳ�һ���ǾͲ����ӵ������������Ŷӣ����Ը���������ķ�������ʵĲ�Ʒ������:yoooyeeey@163.com" />
<!-- InstanceBeginEditable name="doctitle" -->
<title>���ݾ�ͷ������  |������վ����|������վ����</title>
<!-- InstanceEndEditable -->

<link href="theam/gray/tb.css" rel="stylesheet" type="text/css" title="gray"/>
<link href="theam/blue/tb.css" rel="stylesheet" type="text/css" disabled="disabled" title="blue"/>

<script language="javascript" type="text/javascript" src="script/index.js">

</script>
<!-- InstanceBeginEditable name="head" --><!-- InstanceEndEditable -->
</head>

<body >
<div class="divcss">
<!--#include file="Top.htm"-->
</div>
<!--#include file="menu.htm"-->
<div class="divcss">
  <table width="100%">
  <tr><td width="200px" height="100%" valign="top">
<!--#include file="left.asp"--></td>
  <td valign="top"  class="sx"><div id="editContent"><!-- InstanceBeginEditable name="EditContent" -->
  �������ݾ���Դ��51job.com<br/>
<!--#include file="inc/conn.asp"-->
<%
sql="select distinct ��˾����, * from job order by ��� desc "
set rs=server.CreateObject("ADODB.recordset")
rs.open sql,conn,1,1
while not rs.eof
response.Write(rs("��˾����")&"-----"&rs("ְλ����")&"------"&rs("��������")&"<br/>")
%>
<%
response.Write("��ϵ��:"&rs("��ϵ��")&"�绰:"&rs("�绰")&"�ƶ��绰:"&rs("�ƶ��绰")&"��������:"&rs("��������")&"��˾��վ:"&rs("��˾��վ")&"����:"&rs("����")&"<hr/>")
rs.movenext
wend

rs.close:set rs=nothing
%>
  <script type="text/javascript"><!--
google_ad_client = "pub-5582667370460391";
/* 234x60, ������ 08-7-29 */
google_ad_slot = "0734503347";
google_ad_width = 234;
google_ad_height = 60;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
<script type="text/javascript"><!--
google_ad_client = "pub-5582667370460391";
/* 120x90, ������ 08-8-6 */
google_ad_slot = "6133072211";
google_ad_width = 120;
google_ad_height = 90;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
  
  <!-- InstanceEndEditable --></div></td>
</tr></table>
</div>

<!--#include file="bottom.htm"-->
</body>
<!-- InstanceEnd --></html>
