//CheckForm JS

function chkLogin()	//�û���½У��
{
	if (document.form1.username.value=="")
	 {
	  alert ("�������û�����");
	  document.form1.username.focus();
	  return false;
	 }
	 if (document.form1.userpwd.value=="")
	 {
	  alert ("����д��¼���룡");
	  document.form1.userpwd.focus();
	  return false;
	 }
	  if (document.form1.passcode.value==""||isNaN(document.form1.passcode.value))
	 {
	  alert ("��֤�벻��Ϊ��,��Ϊ���֣�");
	  document.form1.passcode.focus();
	  return false;
	 }

 	return true

}

function del(obj)  //ɾ����¼
{
	for(i=0;i<document.getElementsByName(obj).length;i++)
	{
	  if(document.getElementsByName(obj)[i].checked) return confirm("��ȷ����Ҫִ�еĲ�����");
	}	
	alert("����ѡ��һ����Ϣ��¼��");
	return false;
}


function selectAll(form)
{		//ȫѡ����
	for(var i=0;i<form.elements.length;i++)
	{
		if(form.elements[i].name=="selectId")
		{
			form.elements[i].checked=form.checkAll.checked;
		}
	}
}

function chkAddManager()	//��ӹ���Ա
{
	if(form1.username.value=="")
	{
		alert("���������Ա�˺ţ�");
		document.form1.username.focus();
		return false;
	}
	if(form1.userpwd.value=="")
	{
		alert("���������Ա���룡");
		document.form1.userpwd.focus();
		return false;
	}
	if(form1.userpwd2.value=="")
	{
		alert("���������Աȷ�����룡");
		document.form1.userpwd2.focus();
		return false;
	}
	if(form1.userpwd.value!=form1.userpwd2.value)
	{
		alert("�����������벻һ�£����������룡");
		document.form1.userpwd.focus();
		return false;
	}
	
}

function chkEditManager()	//�޸Ĺ���Ա
{
	if(form1.userpwd.value=="")
	{
		alert("���������Ա���룡");
		document.form1.userpwd.focus();
		return false;
	}
	if(form1.userpwd2.value=="")
	{
		alert("���������Աȷ�����룡");
		document.form1.userpwd2.focus();
		return false;
	}
	if(form1.userpwd.value!=form1.userpwd2.value)
	{
		alert("�����������벻һ�£����������룡");
		document.form1.userpwd.focus();
		return false;
	}
	
}

function chkAddClass()	//������
{
	if(form1.className.value=="")
	{
		alert("������������ƣ�");
		document.form1.className.focus();
		return false;
	}
	if (form1.power.value==""||isNaN(form1.power.value)){
			alert("����ȷ�����������֣�");
			document.form1.power.focus();
			return false;
	}

}

function chkAddMenu()	//������
{
	if(form1.className.value=="")
	{
		alert("������˵����ƣ�");
		document.form1.className.focus();
		return false;
	}
	if (form1.power.value==""||isNaN(form1.power.value)){
			alert("����ȷ�����������֣�");
			document.form1.power.focus();
			return false;
	}

}



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

function show(obj)
{
	if (obj.style.display==""){
	obj.style.display="none";
	}
	else
	{
	obj.style.display="";
	}
}

function chkNews(){		//�������
		if (document.form1.newsClass.value==""){
			alert("��ѡ���������");
			document.form1.newsClass.focus();
			return false;
		}
		if (document.form1.title.value==""){
			alert("���ⲻ��Ϊ�գ�");
			document.form1.title.focus();
			return false;
		}
		if (document.form1.power.value==""||isNaN(document.form1.power.value)){
			alert("����ȷ�����������֣�");
			document.form1.power.focus();
			return false;
		}
		if (eWebEditor1.getHTML()==""){
			alert("�������ݲ���Ϊ�գ�");
			return false;
		}
		
		return true;
}

function chkAddPro(){		//��Ӳ�Ʒ
		if (document.form1.proClass.value==""){
			alert("��ѡ���Ʒ���");
			document.form1.proClass.focus();
			return false;
		}
		if (document.form1.proName.value==""){
			alert("�������Ʒ���ƣ�");
			document.form1.proName.focus();
			return false;
		}
		//if (document.form1.proPic.value==""){
//			alert("���ϴ�ͼƬ��");
//			document.form1.proPic.focus();
//			return false;
//		}
		if (document.form1.power.value!=""&&isNaN(document.form1.power.value)){
			alert("����ȷ�����������֣�");
			document.form1.power.focus();
			return false;
		}
		
		return true;
}

function chkInfo()
{
	if (eWebEditor1.getHTML()==""){
		alert("��Ϣ���ݲ���Ϊ�գ�");
		return false;
	}
}

function chkAddFL(){
		
		if (document.form1.linkName.value==""){
			alert("�����������������ƣ�");
			document.form1.linkName.focus();
			return false;
		}
		if (document.form1.linkPic.value==""){
			alert("���ϴ�����ͼƬ��");
			document.form1.linkPic.focus();
			return false;
		}
		if (document.form1.power.value!=""&&isNaN(document.form1.power.value)){
			alert("����ȷ�����������֣�");
			document.form1.power.focus();
			return false;
		}
		
		return true;
}
	
function chkAddFile(){
		if (document.form1.fileClass.value==""){
			alert("��ѡ���ļ����");
			document.form1.fileClass.focus();
			return false;
		}
		if (document.form1.filename.value==""){
			alert("�������ļ����ƣ�");
			document.form1.filename.focus();
			return false;
		}
		if (document.form1.power.value!=""&&isNaN(document.form1.power.value)){
			alert("����ȷ�����������֣�");
			document.form1.power.focus();
			return false;
		}
		if (document.form1.filepath.value==""){
			alert("���ϴ��ļ���");
			document.form1.filepath.focus();
			return false;
		}
		
		return true;
}

function chkAddAd(){
		if (document.form1.adClass.value==""){
			alert("��ѡ�������");
			document.form1.adClass.focus();
			return false;
		}
		if (document.form1.adName.value==""){
			alert("�����������ƣ�");
			document.form1.adName.focus();
			return false;
		}
		
		if (document.form1.adPic.value==""){
			alert("���ϴ�ͼƬ��");
			document.form1.adPic.focus();
			return false;
		}
		
		return true;
}


function chkAddTP(){
		
		if (document.form1.voteTitle.value==""){
			alert("������ͶƱ���ƣ�");
			document.form1.voteTitle.focus();
			return false;
		}
		if (isNaN(document.form1.voteNum.value)){
			alert("����ȷ����Ʊ�����֣�");
			document.form1.voteNum.focus();
			return false;
		}
		if (document.form1.power.value!=""&&isNaN(document.form1.power.value)){
			alert("����ȷ�����������֣�");
			document.form1.power.focus();
			return false;
		}
		
		return true;
	}

function chkModifyTopic()
	{
		
		if (document.form1.voteTitle.value==""){
			alert("ͶƱ���ⲻ��Ϊ�գ�");
			document.form1.voteTitle.focus();
			return false;
		}
	}

function ConfirmDel()
{
	return confirm("�����Ҫɾ�����ļ���ɾ���󽫲��ɻָ���");
}

function reConfirm()
{
	return confirm("ȷ������?");
}

function chkAddJob(){
		
		if (document.form1.jobName.value==""){
			alert("��������Ƹ��λ��");
			document.form1.jobName.focus();
			return false;
		}
		if (document.form1.jobNum.value==""||isNaN(document.form1.jobNum.value)){
			alert("����ȷ������Ƹ������");
			document.form1.jobNum.focus();
			return false;
		}
		if (document.form1.endTime.value==""){
			alert("��������ֹʱ�䣡");
			document.form1.endTime.focus();
			return false;
		}
		if (document.form1.power.value!=""&&isNaN(document.form1.power.value)){
			alert("����ȷ�����������֣�");
			document.form1.power.focus();
			return false;
		}
		if (document.form1.content.value==""){
			alert("�������λ������");
			document.form1.content.focus();
			return false;
		}
		return true;
	}

function chkBackData()
{
	if(document.form1.backupName.value=="")
	{
		alert("�����뱸��·����");
		document.form1.backupName.focus();
		return false;
	}	
}

function chkAddRole()
{
	if(document.form1.username.value=="")
	{
		alert("�������ɫ���֣�");
		document.form1.username.focus();
		return false;
	}	
}