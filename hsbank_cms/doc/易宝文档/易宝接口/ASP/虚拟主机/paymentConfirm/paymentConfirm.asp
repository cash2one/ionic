<!-- #include file="../common/yeepayCommon.asp" -->

<%
'**************************************************
'* @Title �ױ�֧�����˷���
'* @Description �ⶳ����֧������
'* @Copyriht (c) ����ͨ��ͨ��Ϣ���޹�˾���ױ�֧����
'* @Author    yang.yue
'* @Version   V2.0  
'**************************************************

' ��ʼ��ȡ�ⶳ���˱��ύ����Ϣ 
For Each objItem in request.form

	objItemName = Trim(objItem)
    objItemValue = Request.Form(objItem)
    requestMap.add objItem,Request.Form(objItem)
	  
Next
' 1Ϊ��ʹ���ض���ʽ�ύ�˿�����   
' Call doRequestHttp("PaymentConfirm",requestMap,PaymentConfirmHmacArray,1)   
' 2Ϊ��ʹ��ͨѶ��ʽ�ύ�˿�����  
returnStr = doRequestHttp("PaymentConfirm",requestMap,PaymentConfirmHmacArray,2)   
' ��ʾ���ؽ���ַ���
Response.Write returnStr
%>
