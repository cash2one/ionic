<!-- #include file="../common/yeepayCommon.asp" -->
<%
'**************************************************
'* @Title �ױ�֧�����˷���
'* @Description ��ȡ֧��֪ͨ�������Ԥ��ҵ����ģ��
'* @Copyriht (c) ����ͨ��ͨ��Ϣ���޹�˾���ױ�֧����
'* @Author    yang.yue
'* @Version   V2.0  
'**************************************************
'�ڽ��յ�֧�����֪ͨ���ж��Ƿ���й�ҵ���߼�������Ҫ�ظ�����ҵ���߼�����
Set backMap = Server.CreateObject( "Scripting.Dictionary")

' ��ʼ���֪ͨ���ز���
For Each objItem in request.querystring
	objItemName = trim(objItem)
	objItemValue = request(objItem)
	backMap.add objItem,request(objItem)
Next

' ��֪ͨ�����ַ���д����־
writestr = cstr(now) & "," & cstr(timer) & ",[callback],[str]" & request.QueryString
Call logStr(logFileName,writestr)

' ��ʼ���ɱ���Hmac���Է��ص�Hmac���бȶ�
For i=0 to ubound(BuyResHmacArray)
    ' ƴ������hmac���ַ���        
	hmacSource=hmacSource&backMap.item(BuyResHmacArray(i))  
Next
' ���ɱ���hmac	
localHmac = HmacMd5(hmacSource,keyValue)  
' ��÷���hmac	
returnHmac = backMap.item("hmac")         
' �жϽ���ǩ��(hmac)�Ƿ�һ��	
If localHmac <> returnHmac Then
	Response.Write "����ǩ�����۸�"
	Response.End 
End If		
	
	
If cint(backMap.item("r1_Code")) = 1 Then

	If backMap.item("r9_BType") = 1 Then 
	Response.Write "֧���ɹ���"
	ElseIf backMap.item("r9_BType") = 2 Then 
	    ' ��дsuccess����Сд������
    	Response.Write "success"    
	End If
	' �����̻�ҵ������
	Call Business(backMap) 	
	   
End If

%>