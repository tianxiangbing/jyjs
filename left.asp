<table style="margin-left:5px;">
  <tr>
    <td width="200px" valign="top">
	
	<!--#include file="userLogin.asp"-->
        <table>
          <tr>
            <td><img src="images/gg.gif" /></tD>
          </tr>
          <tR>
            <td>
			<!--ѭ�������еĹ���Notice-->
			<li><a href="http://www.yingchengshi.cn/jianren.asp?keyword=����" title="����" target="_blank">����</a></li>
			<li><a href="mieshenweb.asp">����Web��ҳ��Ϸ</a></li>
			<%
			sql="select top 5 ArticleTitle,ArticleId,ArticleClass,Power,Addtime  from Article where ArticleClass=50 and Recycle=false order by Power asc,ArticleId desc"
			set rs=conn.execute(sql)
			do while not rs.eof
			%>
			<li><a href="Notice.asp?newid=<%=rs("ArticleId")%>">
			<% =left(trim(rs("ArticleTitle")),12) %>
			<% if len(trim(rs("ArticleTitle")))>12 then response.write "..." %>
			</a>
                  <hr /></li>
				  <%
				  rs.movenext()
				  loop
				  %>
            </tD>
          </tr>
        </table>
      <table>
        <tR>
          <td><img src="images/yhtj.gif" /> </td>
        </tr>
          <tR>
            <td><li class="discli"><a href="http://www.chpanshi.com">�㽭��ʯ</a>
                    <hr />
              <li class="discli"><a href="contact.asp">���������</a>
                    <hr />
                <li class="discli"><a href="http://www.mieshenweb.net">����WEBGame</a>
                    <hr />
                <li class="discli"><a href="http://www.52letao.com">�Ұ�����</a>
                    <hr />
                <li class="discli"><a href="http://www.nextsee.com">��������</a>
                    <hr />
            </tD>
          </tr>
      </table>
      <table>
          <tr>
            <td><img src="images/khzx.gif" width="209" height="56" /></td>
          </tr>
          <tr>
            <td width="28%"><a href="contact.asp"><img src="images/gywm.gif" width="55" height="50" /><span class="STYLE7">|</span>��������</a></td>
          </tr>
        <tr>
            <td width="28%" valign="top"><a href="contact.asp"><img src="images/lxwm.gif" width="55" height="50" /><span><span class="STYLE7">|</span><span>��ϵ��ʽ</span></a></td>
        </tr>
        <tr>
            <td width="28%"><img src="images/hkfs.gif" width="55" height="50" /><span class="STYLE7">|</span>��ʽ</td>
        </tr>
        <tr>
            <td width="28%"><img src="images/cywd.gif" width="55" height="50" /><span class="STYLE7">|</span>�����ĵ�</td>
        </tr>
        <tr>
            <td width="28%"><img src="images/hyzx.gif" width="55" height="50" /><span class="STYLE7">|</span>��Ա����</td>
        </tr>
      </table></td>
  </tr>
</table>
