<!-- #include file="../Common/yeepayCommon.asp" -->

<%
'**************************************************
'* @Title �ױ�֧�����˷���
'* @Description �˿�ӿ�
'* @Copyriht (c) ����ͨ��ͨ��Ϣ���޹�˾���ױ�֧����
'* @Author    yang.yue
'* @Version   V2.0  
'**************************************************


' ��ʼ��ȡ�˿���ύ����Ϣ 
For Each objItem in request.form
   
	objItemName = trim(objItem)
    objItemValue = Request.Form(objItem)
    requestMap.add objItem,Request.Form(objItem)

Next
' 1Ϊ��ʹ���ض���ʽ�ύ�˿�����  
' Call doRequestHttp("RefundExt",requestMap,RefundExtHmacArray,1)   
' 2Ϊ��ʹ��ͨѶ��ʽ�ύ�˿�����   
returnStr = doRequestHttp("RefundExt",requestMap,RefundExtHmacArray,2)   
' ��ʾ���ؽ���ַ���
Response.Write returnStr

%>