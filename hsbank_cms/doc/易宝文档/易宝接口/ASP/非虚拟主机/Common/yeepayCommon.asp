<!-- #include file="merchantProperties.asp" -->

<%
'''''''''''''''''''''''''''''''''''''''''''''''''''
'' @Title �ױ�֧�����˷���
'' @Description ����������doRequestHttp()����Ե�ͨѶ���ػص�doResponseHttp()����
'' @Copyriht (c) ����ͨ��ͨ��Ϣ���޹�˾���ױ�֧����
'' @Author  yang.yue
'' @Version  V2.0
'''''''''''''''''''''''''''''''''''''''''''''''''''



'''''''''''''''''''''''''''''''''''''''''''''
' @Description  ��������
' @actionType  �������ͣ�������־��ӡ
' @requestMap  �������еĲ��������Map
' @hmacParaAry ��Ҫ����ǩ���Ĳ�������
' @httpFlag 	 �ض����Ե�ͨѶ��־λ��1Ϊ�ض���2Ϊ��Ե�ͨѶ
'''''''''''''''''''''''''''''''''''''''''''''

Set mctSDK = Server.CreateObject("HmacMd5API.HmacMd5Com")

Function doRequestHttp(actionType,requestMap,hmacParaAry,httpFlag)

	If actionType = "RefundExt" then
		reqURL = reqURLRefund
    End If

	If actionType = "IndirectRegister" then
		reqURL = reqURLReg
    End If
		
	Set hmacMap = Server.CreateObject( "Scripting.Dictionary")
	hmacSource=""
	requestString=""    
	returnString=""           
	requestMap.add merIdName,p1_MerId

	
	' ����Ҫ����ǩ���Ĳ�����ֵ�Է���requestMap
	For i=0 to ubound(hmacParaAry)
		If requestMap.Exists(hmacParaAry(i))=false Then
			requestMap.add hmacParaAry(i),""
		End If
	Next
	
	' ����ǩ��Դ
	For i=0 to ubound(hmacParaAry)
		hmacSource=hmacSource&requestMap.item(hmacParaAry(i))
	Next	
	
	' �����贫�ݵ�Hmac
	hmacValue=mctSDK.HmacMd5(hmacSource,keyValue)
	' �����ɵ�hmac���뵽������
	requestMap.add "hmac",hmacValue
	
	itemKeys=requestMap.keys
	itemValue=requestMap.Items   
	For  each  itemObject in itemKeys
		requestStringItem=itemObject&"="&Server.URLEncode(requestMap.item(itemObject))&"&"
		requestString=requestString&requestStringItem
	Next
	' ƴ��д����־���ַ���
	writestr = cstr(now) & "," & cstr(timer) & "["&actionType&"] ,[KeyValue]" & keyValue & ",[sbold]" & hmacSource & ",[hmac]" & hmacValue
	
    Call logStr(logFileName,writestr)
	' �ض���
	If httpFlag=1 Then 	
		writestr = cstr(now) & "," & cstr(timer) & ",["&actionType&"] ,[url]" & reqURL & ",[content]" & requestString 
    	Call logStr(logFileName,writestr)
		doRequestHttp=reqURL&"?"&requestString
		response.write "�ض����doRequestHttp"&"</br>"
		response.write "<a target='_blank' href='"& doRequestHttp &"'>" & doRequestHttp & "</a>"
	
	' ���͵�Ե�����
	Else If httpFlag=2  Then 
	' ƴ��д����־���ַ���
	writestr = cstr(now) & "," & cstr(timer) & "["&actionType&"] ,[KeyValue]" & keyValue & ",[sbold]" & hmacSource & ",[hmac]" & hmacValue & "[reqURL]" & reqURL & "[requestString]" & requestString
	' ��ͨѶ�ύ����д����־
    Call logStr(logFileName,writestr)
		set objHttp = Server.CreateObject("MSXML2.ServerXMLHTTP")
		objHttp.open "post", reqURL , false
		objHttp.setRequestHeader "Content-Type","application/x-www-form-urlencoded"
    	objHttp.setRequestHeader "Connection", "Keep-Alive"
    	objHttp.Send requestString

		If (objHttp.status <> 200 ) Then
	        	writestr = cstr(now) & "," & cstr(timer) & "["&actionType&"]" & ",[objHttp.status]" & objHttp.status
	        	' ��ͨѶ���ز���д����־
			Call logStr(logFileName,writestr)
		    ' HTTP ������
	  		response.Write("Status="&objHttp.status&"�������쳣")
			response.End
		Else
    		'strCallBack = objHttp.ResponseText
            strCallBack = BytesToBstr(objHttp.ResponseBody)

	    	set objHttp = nothing

	        writestr = cstr(now) & "," & cstr(timer) & "["&actionType&"]" & ",[strCallBack]" & strCallBack
		' ��ͨѶ���ز���д����־
 
        	Call logStr(logFileName,writestr)

			actionName = ""
			Select Case actionType
	   		Case "PaymentConfirm"
	    	backResHmacArray= PaymentConfirmResHmacArray
	    	Case "RefundExt"
	    	backResHmacArray= RefundExtResHmacArray
	    	Case "IndirectRegister"
	    	backResHmacArray= RegistMerchantResHmacArray
			End Select

        	resultStr =  doResponseHttp(actionType,strCallBack,backResHmacArray)
	    	doRequestHttp = resultStr	
	 	End If 
	  
	End If 
	End If 
	
	
End Function


'''''''''''''''''''''''''''''''''''''''''''''
' @Description  ���շ���
' @strCallBack  ������
' @rspHmacParaAry ��Ҫ����ǩ���Ĳ�������
'''''''''''''''''''''''''''''''''''''''''''''

Function doResponseHttp(actionType,strCallBack,rspHmacParaAry)    
	actionName = ""
	Select Case actionType
	   Case "PaymentConfirm"
	   actionName = "�ⶳ֧������"
	   Case "RefundExt"
	   actionName = "�˿����"
	   Case "IndirectRegister"
	   actionName = "���̻�ע��"
	   Case "QueryBalance"
	   actionName = "�˻�����ѯ"
	End Select
	
	hmacSource = ""
	Set rspMap = Server.CreateObject( "Scripting.Dictionary")
	aryCallBack = Split(strCallBack,vbLf)
	returnMsg = ""
	
	For i = LBound(aryCallBack) To UBound(aryCallBack)
		If InStr(aryCallBack(i),"=") =< 0 Then
			returnMsg = strCallBack
			doResponseHttp = returnMsg				
			Exit Function
		End If

		aryReturn = Split(aryCallBack(i),"=")
		sKey = aryReturn(0)
		sValue = aryReturn(1)
	    ' �����ز���д��Dictionary
		rspMap.add sKey,sValue
	Next

	writestr = cstr(now) & "," & cstr(timer) & "["&actionType&"] ,[returnString]" & strCallBack
		
    Call logStr(logFileName,writestr)
	
	If rspMap.item("r1_Code")=1 Then 
		
		For i=0 to ubound(rspHmacParaAry)
			hmacSource=hmacSource&rspMap.item(rspHmacParaAry(i))
		Next
		' ƴ������Hmac���ַ���
		hmacValue=mctSDK.HmacMd5(hmacSource,keyValue)	
		' ����Hmac
		If hmacValue = rspMap.item("hmac") Then	
			resultStr = actionName & "�ɹ�<br>"
			itemKeys=rspMap.keys	     
	    For Each itemObject In itemKeys
		 	resultStr = resultStr & itemObject & "=" & rspMap.item(itemObject) & "<br>"
	    Next
		doResponseHttp = resultStr
		Else
		resultStr = actionName & "<br>����ǩ�����۸ģ�"
		doResponseHttp = resultStr		
		End if
	Else 
         
	     resultStr = actionName & "ʧ�ܣ�<br>"
		 
		 itemKeys=rspMap.keys 
	     For each itemObject in itemKeys
		 	resultStr = resultStr & itemObject & "=" & rspMap.item(itemObject) & "<br>"
	     Next
		 
		 For i = 0 to Ubound(errorCodeAry)
		   If instr(errorCodeAry(i),rspMap.Item("r1_Code")) then
		      resultStr = resultStr & "����ԭ��<font color='red'>" & replace(errorCodeAry(i),rspMap.Item("r1_Code")&"=","") & "</font><br>"
			  Exit For
		   End If
		   
		 Next
		 
         doResponseHttp = resultStr
		 
	End If 
		
End function



' ��־
Sub logStr(logFileName, str)
    filename = "../" & logFileName
    content = str
    
    Set FSO = Server.CreateObject("Scripting.FileSystemObject")   
    Set TS = FSO.OpenTextFile(Server.MapPath(filename),8,true,-1) 
    TS.write content   
    TS.Writeline ""
    TS.Writeline ""
    Set TS = Nothing   
    Set FSO = Nothing   
End Sub


' �̻��յ��ױ�������Ϣ��ҵ������
Function Business(paraMap)

	Response.Write "<br> Return parameter list:<br>"
    ' �����յ��Ĳ�����ʾ����
    For i=0 to Ubound(BuyResHmacArray)
		Response.Write BuyResHmacArray(i) & " = " & paraMap.Item(BuyResHmacArray(i)) & "<br>"	   
    Next
   
End function

Function BytesToBstr(body)
set objstream = Server.CreateObject("adodb.stream")
objstream.Type = 1
objstream.Mode = 3
objstream.Open
objstream.Write body
objstream.Position = 0
objstream.Type = 2
objstream.Charset = "gb2312"
BytesToBstr = objstream.ReadText 
objstream.Close
set objstream = nothing
End Function

%>