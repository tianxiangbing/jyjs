<%
'**************************
	'��̨���������ļ�
	'���峣��,����ĸ��д
'**************************
'Option Explicit
'on error resume next
response.Buffer = true


Const IsSqlDataBase=0					'�������ݿ����0ΪAccess���ݿ⣬1ΪSQL���ݿ�

Const NewsClassNum=1 					'���ŷ�����
Const ProClassNum=1 					'��Ʒ������
Const DownloadClassNum=1 				'�������

Const EnableUploadPic="jpg|gif"			'�����ϴ��Ĳ�ƷͼƬ��ʽ
Const EnableUploadPicSize=1048576		'�����ϴ��Ĳ�ƷͼƬ��С ��λByte(�ֽ�) 1M ע��:1KB��1000B ���� 1KB=1024B
Const EnableUploadAd="jpg|gif|swf"		'�����ϴ��Ĺ���ļ���ʽ
Const EnableUploadAdSize=1048576		'�����ϴ��Ĺ���ļ���С ��λByte(�ֽ�) 1M
Const EnableUploadFile="doc|xls|pdf|rar|zip|txt"		'�����ϴ����ĵ���ʽ
Const EnableUploadFileSize=10485760		'�����ϴ����ĵ���С  10M

'Const EnableMessageCheck="Yes"        '�Ƿ�����������˹���
'Const EnableMessageReply="Yes"        '�Ƿ��������Իظ�����





%>
