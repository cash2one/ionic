<!-- #include file="../common/yeepayCommon.asp" -->

<%
'**************************************************
'* @Title �ױ�֧�����˷���
'* @Description ���̻�ע��
'* @Copyriht (c) ����ͨ��ͨ��Ϣ���޹�˾���ױ�֧����
'* @Author    yang.yue
'* @Version   V2.0  
'**************************************************

' ��ʼ��ȡע����ύ����Ϣ 
For Each objItem in request.form

	objItemName = Trim(objItem)
	objItemValue = Request.Form(objItem)
	requestMap.add objItem,Request.Form(objItem)
	  
Next  
' �����ύ����
returnStr = doRequestHttp("IndirectRegister",requestMap,RegistMerchantHmacArray,1) 

%>