<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<%@page import="com.yeepay.distribute.*, java.util.Map"%>
<%! 
// ���ɱ�ǰ����ҵ���߼�
public void logicBeforeSendReq() {
}
// ���ɱ�����ҵ���߼�
public void logicAfterSendReq() {
}
%>
<%
logicBeforeSendReq();
%>
<html>
<body onload="window.<%
out.print("form");
%>.submit();">
<%
try{
out.println(Distribute.getDistributeIndirectRegisterForm(request,"form","�ύ"));

}catch(Exception e){
out.println(e);
}
%>
<%
logicAfterSendReq();
%>
</body>
</html>
