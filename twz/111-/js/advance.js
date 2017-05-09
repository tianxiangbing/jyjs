// JavaScript Document



// 1. initialize XMLDOM

// eg .A
//xmlDoc=loadXMLDoc("/example/xdom/books.xml");
function loadXMLDoc(dname) 
{
	var xmlDoc;
	// code for IE
	if (window.ActiveXObject)
	  {
	  xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
	  }
	// code for Mozilla, Firefox, Opera, etc.
	else if (document.implementation && document.implementation.createDocument)
	  {
	  xmlDoc=document.implementation.createDocument("","",null);
	  }
	else
	  {
	  alert('Your browser cannot handle this script');
	  }
	xmlDoc.async=false;
	xmlDoc.load(dname);
	return(xmlDoc);
}

//eg .B
try //Internet Explorer
  {
  xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
  xmlDoc.async="false";
  xmlDoc.loadXML(text);
  }  
catch(e)
  {
  try // Firefox, Mozilla, Opera, etc.
    {
    parser=new DOMParser();
    xmlDoc=parser.parseFromString(text,"text/xml");
    }
  catch(e)
    {
    alert(e.message);
    return;
    }
  }


// 2. initialize xmlhttp

var xmlhttp;
function loadXMLDoc(url)
{
xmlhttp=null;
if (window.XMLHttpRequest)
  {// code for all new browsers
  xmlhttp=new XMLHttpRequest();
  }
else if (window.ActiveXObject)
  {// code for IE5 and IE6
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
if (xmlhttp!=null)
  {
  xmlhttp.onreadystatechange=state_Change;
  xmlhttp.open("GET",url,true);  
  //��ʼ�� HTTP ��������� METHOD,URL �� HTTP ���������ǲ�����������
  //�����������涨�����Ƿ��첽����  True ��ʾ�ű����� send() ����֮�����ִ�У������ȴ����Է���������Ӧ��
  xmlhttp.send(null);//���� HTTP ����ʹ�ô��ݸ� open() �����Ĳ������Լ����ݸ��÷����Ŀ�ѡ�����塣
  
  //xmlhttp.open("post",url,true);   //POST�ύ����
  //xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");//��һ���򿪵�δ���͵��������û����һ�� HTTP ����
  //xmlhttp.send("username="+username);
  }
else
  {
  alert("Your browser does not support XMLHTTP.");
  }
}

function state_Change()
{
if (xmlhttp.readyState==4)
  {// 4 = "loaded"
  if (xmlhttp.status==200)
    {// 200 = OK
    // ...our code here...
	//alert(xmlhttp.responseText);
    }
  else
    {
    alert("Problem retrieving XML data");
    }
  }
}

