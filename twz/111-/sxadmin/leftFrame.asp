<!--#include file="inc/config.asp"-->
<!--#include file="judge.asp"-->
<!--#include file="inc/DB.asp"-->
<!--#include file="conn.asp"-->
<!--#include file="leftMenu.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/common.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="css/common.css" type="text/css" />
<title>��ർ����</title>
</head>
<style type="text/css">
<!--
body{
	overflow-x:hidden;  /* ����ˮƽ������*/
}
-->
</style>
<script  type="text/javascript">

function getObject(objectId) 
{ 
	if(document.getElementById && document.getElementById(objectId)) 
	{ 
		return document.getElementById(objectId) 
	} 
	else if(document.all && document.all(objectId)) 
	{ 
		return document.all(objectId) 
	} 
	else if(document.layers && document.layers[objectId]) 
	{ 
		return document.layers[objectId] 
	} 
	else 
	{ 
		return false 
	} 
} 

function outlook() 
{ 
	this.titlelist = new Array(); 
	this.itemlist = new Array(); 
	this.addtitle = addtitle; 
	this.additem = additem; 
	
	this.getdefaultnav = getdefaultnav;
	
} 

function theitem(intitle, insort, inkey, inisdefault) 
{ 
	this.sortname = insort; 
	this.key = inkey; 
	this.title = intitle; 
	this.isdefault = inisdefault 
} 

function addtitle(intitle, sortname, inisdefault) 
{ 
	outlookbar.itemlist[outlookbar.titlelist.length] = new Array(); 
	outlookbar.titlelist[outlookbar.titlelist.length] = new theitem(intitle, sortname, 0, inisdefault); 
	return(outlookbar.titlelist.length - 1) 
} 

function additem(intitle, parentid, inkey) 
{ 
	if(parentid >= 0 && parentid <= outlookbar.titlelist.length) 
	{ 
		insort = "item_" + parentid; 
		outlookbar.itemlist[parentid][outlookbar.itemlist[parentid].length] = new theitem(intitle, insort, inkey, 0); 
		return(outlookbar.itemlist[parentid].length - 1) 
	} 
	else additem = - 1 
} 
function getdefaultnav(sortname) 
{ 
	var output = ""; 
	for(i = 0; i < outlookbar.titlelist.length; i ++ ) 
	{ 
		if(outlookbar.titlelist[i].isdefault == 1 && outlookbar.titlelist[i].sortname == sortname) 
		{ 
			output += "<div class=list_tilte id=sub_sort_" + i +  " onclick=\"hideorshow('sub_detail_"+i+"')\"";
			output += " >";
			output += "<span>" + outlookbar.titlelist[i].title + "</span>"; 
			output += "</div>"; 
			output += "<div class=list_detail id=sub_detail_" + i + "><ul>"; 
			for(j = 0; j < outlookbar.itemlist[i].length; j ++ ) 
			{ 
				
				output += "<li id=" + outlookbar.itemlist[i][j].sortname + j + "";
				output += " onclick=\"changeframe('"+outlookbar.itemlist[i][j].title+"', '"+outlookbar.titlelist[i].title+"', '"+outlookbar.itemlist[i][j].key+"')\"><a  href=#  onclick='return false' >" + outlookbar.itemlist[i][j].title + "</a></li>" 
				//output += "<a  href=#  onclick='return false' >" + outlookbar.itemlist[i][j].title + "</a></li>" 
			} 
			output += "</ul></div>" 
		} 
	} 
	getObject('right_main_nav').innerHTML = output 
} 


function changeframe(item, sortname, src) 
{ 
	if(item != "" && sortname != "") 
	{ 
		window.top.frames['navFrame'].getObject('show_text').innerHTML = sortname + "  <img src=images/slide.gif broder=0 />  " + item 
	} 
	if(src != "") 
	{ 
		window.top.frames['mainFrame'].location = src 
	} 
} 



function hideorshow(divid) 
{ 
	subsortid = "sub_sort_" + divid.substring(11); 
	if(getObject(divid).style.display == "none") 
	{ 
		getObject(divid).style.display = "block"; 
		getObject(subsortid).className = "list_tilte" 
		
	} 
	else 
	{ 
		getObject(divid).style.display = "none"; 
		getObject(subsortid).className = "list_tilte_onclick" ;
	} 
} 
	



// �����������ļ�
var outlookbar=new outlook();
var t;

t=outlookbar.addtitle('��ȫ����','��ȫ����',1)
outlookbar.additem('����Ա�˻�',t,'security/manager.asp')
outlookbar.additem('��ӽ�ɫ',t,'power/add.asp')
outlookbar.additem('�����ɫ',t,'power/manage.asp')
outlookbar.additem('��־����',t,'security/adminLog.asp')


</script>
<!--<script type="text/javascript" src="js/nav.js"></script>-->

<body >
<% 
dim tUserRs
set tUserRs=conn.execute("select * from psadmin where username='"&session("admin")&"'") %>
<div id="left_content">
   <div id="user_info">��ӭ����<font color="red"><%= session("admin") %></font><br />[<%= conn.execute("select username from power where id="&tUserRs("power"))(0)  %>��<a href="logout.asp" target="_top">�˳�</a>]</div>
	<div id="main_nav">
 	 <div id="right_main_nav">
		 
		 <% 
  dim power,i,showMainMenu,arrPower,j,k,arrSmallPower,arrLeftMenu,showSubMenu		 
  power=conn.execute("select power from power where id="&tUserRs("power"))(0)  'Ȩ��ֵ
		 
  for i=0 to ubound(leftMenu,1)	'��ȡ�˵������������˵�ֵ�����˵���ֵ��Ȩ�ޱ���ʱ������ʾ��������ʾ��
	if isempty(leftMenu(i,0)) then exit for
	
	showMainMenu=false   '�Ƿ���ʾ�������˵�
	arrPower=split(power,",")
	'msgTest ubound(arrPower)
	for k=0 to ubound(arrPower)
		arrSmallPower=split(arrPower(k),"_")
		if cint(arrSmallPower(0))=i then	'�ж��Ƿ����Ȩ�ޱ��
			showMainMenu=true
			exit for
		end if
	next
	'msgTest showMainMenu
	if showMainMenu=true then
	%>
		<!--�����˵�-->
		<div  id=sub_sort_<%= i %> onclick="hideorshow('sub_detail_<%= i %>')"
			<% if i>3 then
				 response.write " class=list_tilte_onclick" 
			 else
				 response.write " class=list_tilte" 
			 end if
			 %>
			  >  
			<span style="font-weight:blod;"><%= leftMenu(i,0) %></span>
		</div>
	    <%
		end if
		%>
		
	 <!--�����˵���-->
	<div class=list_detail id=sub_detail_<%= i %>
	      <% if i>3 then
		    	response.write " style='display:none;'" 
			 end if
			%> >
	  <ul> 
<%
	for j=1 to  ubound(leftMenu,2)	'��ȡ�Ӳ˵�������ֵ�����Ӳ˵���ֵ��Ȩ�ޱ���ʱ������ʾ��������ʾ��
		if isempty(leftMenu(i,j)) then exit for
		arrLeftMenu=split(leftMenu(i,j),",")
		
		showSubMenu=false   '�Ƿ���ʾ�������˵�
		arrPower=split(power,",")
		
		'msgTest ubound(arrPower)
		for k=0 to ubound(arrPower)
			arrSmallPower=split(arrPower(k),"_")
			if(Cint(arrSmallPower(0))=i and Cint(arrSmallPower(1))=j) then	'�ж��Ƿ����Ȩ�ޱ��
				showSubMenu=true
				exit for
			end if
		next
		'if showSubMenu=true then
				%>
		<li id="" ><a href="<%= arrLeftMenu(1) %>" target="mainFrame" onclick="changeframe('<%= arrLeftMenu(0) %>','<%= leftMenu(i,0) %>')" ><%= arrLeftMenu(0) %></a></li>
			<% 
		'end if
	next 
	%>
	  </ul>
	</div>
<% next %>
		 
		 </div><!--width:173-->
	 </div>
</div>
</body>
</html>
