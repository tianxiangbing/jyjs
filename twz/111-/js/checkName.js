// JavaScript Document


function checkName(username)
{
	if(username.length<2)
	{      
    	document.getElementById("showArea").innerHTML ="<span class=red>�û�����������2���ַ�</span>";
    	return false;
    }	
	if(!/^([\u4e00-\u9fa5]|[A-Za-z0-9_])*$/.test(username))
	{
		document.getElementById("showArea").innerHTML ="<span class=red>�û���ӦΪ��ĸ�����֡����Ļ��»���</span>";							 
	    return false; 
	}

	loadXMLDoc("../checkreguser.asp?username="+username);

}

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

function state_Change()
{
	if (xmlhttp.readyState==4)
	{// 4 = "loaded"
	//alert(xmlhttp.status);
	  if (xmlhttp.status==200)
		{// 200 = OK
		// ...our code here...
			result = xmlhttp.responseText; 
			//alert(result);
			if(parseInt(result)==0)
			{
			   //  document.getElementById("showArea").style.display='';
			   
				document.getElementById("showArea").innerHTML ="<span style='color:green'>��ϲ,���û�������ע��!</span>";
				//document.getElementById("chk").value="0";
			}
			else if(parseInt(result)>0)
			{
			   //  document.getElementById("showArea").style.display='';
				document.getElementById("showArea").innerHTML ="<span style='color:red'>�ź�,���û����ѱ�ע��,�����һ��!</span>";
				//document.getElementById("chk").value="1";
			 }
		}
		else
	   {	
		 document.getElementById("showArea").innerHTML = "<img src='images/loading.gif' border='0'>���ڼ����û����Ƿ���á���";   
	   }
	}
	else
	{
		 //alert("Problem retrieving XML data");
		 document.getElementById("showArea").innerHTML = "<img src='images/loading.gif' border='0'>���ڼ����û����Ƿ���á���";   
	}	
}
