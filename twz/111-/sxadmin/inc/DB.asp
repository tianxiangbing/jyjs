<%
	private sub initialize(objConn,tDbPath)
		dim connStr
		If IsSqlDataBase=0 Then
	 		connStr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath(dbPath)
  		else	''' SQL���ݿ����� ''''''''''
	 		dim sqlDataBase
			sqlDataBase	= "ch#$%shixiang.asa"		'���ݿ���	
			connStr="Provider=SQLOLEDB; User ID=sa; Password=123456; Initial CataLog="&SqlDataBase&"; Data Source=(local);"
		end If
		
		set objConn = server.CreateObject("adodb.connection")
		objConn.open connStr	
  
		if err then
	 		err.clear
			set objConn = nothing
			response.Write "���ݿ����ӳ������������ַ�����"
			response.End()
		end if
	end sub

	sub closeRs(objRs)
  		objRs.close()
		set objRs = nothing
	end sub
  
	sub closeConn()
  		conn.close()
		set conn = nothing
	end sub	
%>