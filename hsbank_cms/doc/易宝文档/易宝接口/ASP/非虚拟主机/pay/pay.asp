<!-- #include file="../common/yeepayCommon.asp" -->

<%
'**************************************************
'* @Title �ױ�֧�����˷���
'* @Description ����֧���ӿ�
'* @Copyriht (c) ����ͨ��ͨ��Ϣ���޹�˾���ױ�֧����
'* @Author    yang.yue
'* @Version   V2.0  
'**************************************************


' ��ʼ��ȡ֧�����ύ����Ϣ 
 For Each objItem in request.form

	objItemName = Trim(objItem)
	objItemValue = Request.Form(objItem)
    requestMap.add objItem,Request.Form(objItem)
  
Next

' ֧���ӿ�ֻ��ʹ���ض����ύ��ʽ��1Ϊ�ض���2Ϊ��Ե�ͨѶ��
Call doRequestHttp("Buy",requestMap,buyHmacArray,1) 
' ��ʾ���ؽ���ַ���
Response.Write returnStr & "abc"
%>
