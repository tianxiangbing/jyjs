//JS

function chkLogin()    //��½У��
{
	if(form1.username.value=="")
	{
		alert("�������û���!");
		return false;
	}
	else if(form1.userPwd.value=="")
	{
		alert("����������!");
		return false;
	}
	else if(form1.mofei.value=="")
	{
		alert("��������֤��!");
		return false;
	}
	else
	return true;
}


function chkLawyerBack()    //�ظ�У��
{
	if(form1.content.value=="")
	{
		alert("������ظ�����!");
		return false;
	}
	else
	return true;
}

function chkSearch()    //��������У��
{
	if(form3.keywords.value=="")
	{
		alert("��������������!");
		return false;
	}
	else
	return true;
}

function chkUser()  //�����û�ע��У��
{
	if(form1.username.value=="")
	{
		alert("�������û���!");
		form1.username.focus();
		return false;
	}
	if(!/^[\w\-\u4e00-\u9fa5]{4,16}$/.test(form1.username.value))
	{
		alert("�û���Ϊ4-16λ��ĸ,����,�»���,����!");
		form1.username.focus();
		return false;
	}
	else if(form1.userPwd.value=="")
	{
		alert("����������!");
		return false;
	}
	else if(form1.userPwd2.value=="")
	{
		alert("������ȷ������!");
		return false;
	}
	else if(form1.userPwd.value!=form1.userPwd2.value)
	{
		alert("�����������벻һ��!");
		return false;
	}
	else if(form1.realname.value=="")
	{
		alert("��������ʵ����!");
		return false;
	}
	else if(form1.tel.value=="")
	{
		alert("������绰!");
		return false;
	}
	else if(form1.email.value=="")
	{
		alert("����������!");
		return false;
	}
	else if(!/^[a-zA-Z0-9_\-\.]{2,20}@\w+(\.\w{2,3}){1,3}$/ig.test(document.form1.email.value))
    {  
        alert('���������ʽ����ȷ��');
        document.form1.email.focus();
        return  false
     }	
	else if(form1.prov.value=="0")
	{
		alert("��ѡ��ʡ��!");
		return false;
	}
	
	return true;
}

function chkUserModify()
{
	if(form1.userPwd.value!=""&&form1.userPwd.value!=form1.userPwd2.value)
	{
		alert("�����������벻һ��!");
		return false;
	}
	/*else if(form1.realname.value=="")
	{
		alert("��������ʵ����!");
		return false;
	}*/
	else if(form1.tel.value=="")
	{
		alert("������绰!");
		return false;
	}
	else if(form1.email.value=="")
	{
		alert("����������!");
		return false;
	}
	else if(!/^[a-zA-Z0-9_\-\.]{2,20}@\w+(\.\w{2,3}){1,3}$/ig.test(document.form1.email.value))
      {  
            alert('���������ʽ����ȷ��');
            document.form1.email.focus();
            return  false
        }
	else	
		return true;
}


function chkmessage() //У������
{
	if(form2.CName.value=="")
	{
		alert("����������!");
		return false;
	}
	else if(form2.email.value=="")
	{
		alert("����������!");
		return false;
	}
	else if(!/^[a-zA-Z0-9_\-\.]{2,20}@\w+(\.\w{2,3}){1,3}$/ig.test(document.form1.email.value))
      {  
            alert('���������ʽ����ȷ��');
            document.form2.email.focus();
            return  false
        }
else if(form2.content.value=="")
	{
		alert("��������������!");
		return false;
	}
	else	
		return true;
}

function chkGetPwd() //У��ȡ������
{
	if(form1.username.value=="")
	{
		alert("�������û���!");
		return false;
	}
	else if(form1.email.value=="")
	{
		alert("����������!");
		return false;
	}
	else if(!/^[a-zA-Z0-9_\-\.]{2,20}@\w+(\.\w{2,3}){1,3}$/ig.test(document.form1.email.value))
      {  
            alert('���������ʽ����ȷ��');
            document.form1.email.focus();
            return  false
        }
	else	
		return true;
}


function DrawImage(ImgD,FitWidth,FitHeight)
{ 
    var image=new Image();   
	image.src=ImgD.src;  
	if(image.width>0 && image.height>0)
	{ 
		if(image.width/image.height>= FitWidth/FitHeight)
		{   
			if(image.width>FitWidth)
			{     
				ImgD.width=FitWidth;     
				ImgD.height=(image.height*FitWidth)/image.width;    
			}
			else
			{
				ImgD.width=image.width;
				ImgD.height=image.height; 
			} 
		}
		else
		{
		 if(image.height>FitHeight)
		 { 
		   ImgD.height=FitHeight; 
		   ImgD.width=(image.width*FitHeight)/image.height;
		  }
		  else
		  {
		    ImgD.width=image.width;
			ImgD.height=image.height; 
		  } 
	   } 
	} 
}