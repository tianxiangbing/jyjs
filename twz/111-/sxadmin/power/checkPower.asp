<%
	
	function needCheck()	'�ж��ļ���������߲˵���Ȩ��,�����ڵ�,�����ж�
	   dim havePower,tPower,powerRs,getPower,i,getSmallPower,arrmenuName,fileStr,arrFileStr,j,arrLeftMenu
	   needCheck=false
	    for i=0 to ubound(leftMenu,1)	'��ȡ�˵������������˵�ֵ��
		    if isempty(leftMenu(i,0)) then exit for
			for j=1 to  ubound(leftMenu,2)	'��ȡ�Ӳ˵�������ֵ��
				if isempty(leftMenu(i,j)) then exit for
				arrLeftMenu=split(leftMenu(i,j),",")
				if(lcase(arrLeftMenu(1))=getScriptName) then
					'needCheck=true
					docheckPower
					exit function
				end if
			 next
		next	
	 end function
	 
	sub doCheckPower()
		   dim havePower,tPower,powerRs,getPower,i,getSmallPower 
		   havePower=false
		   tPower=conn.execute("select power from psadmin where username='"&session("admin")&"'")(0)
		   set powerRs=conn.execute("select * from power where id="&tPower)
		   getPower=split(powerRs("power"),",")
		   closeRs(powerRs)
		   for i=0 to ubound(getPower)
			 getSmallPower=split(getPower(i),"_")
			 'response.write menuFileName(getSmallPower(0),getSmallPower(1))
			 if(menuFileName(getSmallPower(0),getSmallPower(1))=getScriptName) then
				 havePower=true
				 exit for
			 end if 
		   next
			
			 '�ų�����ҪȨ�޵��ļ�
		   dim fileStr,arrFileStr,scriptName
		   fileStr="security/adminUploadFile.asp,security/database.asp"
		   arrFileStr=split(fileStr,",")
		   for i=0 to ubound(arrFileStr)
			  if(scriptName=lcase(arrFileStr(i))) then
				 havePower=true
				 exit for
			  end if
		   next
			 
		   if havePower=false then erro "Ȩ�޲��������ܷ��ʴ�ҳ�档"
	   'end if
   end sub
   
   function getScriptName()
   	  dim scriptName
      scriptName=request.ServerVariables("SCRIPT_NAME")
	  'response.Write(scriptName) 
	  'response.Write(right(scriptName,len(scriptName)-instr(2,scriptName,"/")))
	  getScriptName=lcase(right(scriptName,len(scriptName)-instr(2,scriptName,"/")))
	  
   end function
   
   
   function menuFileName(fid,pid)  '��������˵���ID���õ��ļ���
   		dim arrMenuName
   		arrMenuName=split(leftMenu(fid,pid),",")
		menuFileName=lcase(arrmenuName(1))
   end function
   
'---------------------------------------------------------Ȩ��ϸ���ж�
	'����˵�� 
	'mePid �˵���ID
	'meid  �˵���ID
	'sId   Ȩ��ϸ��ID
	'effectInt  0����1   0Ϊҳ��ֱ�ӵ���ʹ��,1����Booleanֵ
   function PowerDetailInfo(mePid,meid,sId,effectInt)  '�ж�Ȩ����ϸ����������޸ģ�ɾ����
   	   gPower=conn.execute("select power from psadmin where username='"&session("admin")&"'")(0)
	   gpowerD=conn.execute("select powerDetail from power where id="&gPower)(0)
	   dim havePowerDetail
	   havePowerDetail=false
	   if gpowerD<>"" then
	   	set dRs=conn.execute("select * from powerDetail where id in("&gpowerD&") and MenuPId="&mePid&" and MenuId="&meId&" and PowerName="&sId&" ")
		if not dRs.eof then havePowerDetail=true
		closeRs(dRs)
	   end if
	   
	   if effectInt=0 then
		   if not havePowerDetail then
				erro "Ȩ�޲��������ܷ��ʴ�ҳ�档"
		   end if
		else
		   if havePowerDetail then  '����Booleanֵ
			  PowerDetailInfo=true
		   else
			  PowerDetailInfo=false
		   end if
		end if   
   end function
 
   
   function getPowerName(powerId)	'ȡȨ������
   		getPowerName=conn.execute("select powerDName from powerDName where id="&powerId)(0)
   end function
   
%>