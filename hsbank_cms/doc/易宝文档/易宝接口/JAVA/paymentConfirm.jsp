<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<%@page import="com.yeepay.distribute.*,java.util.Map,com.yeepay.util.*"%>
<%! 
// �ύǰ����ҵ���߼�
public void logicBeforeSendReq() {
}
// �ύ����ҵ���߼�
public void logicAfterSendReq() {
}
%>
<%
logicBeforeSendReq();
Map map = Distribute.getDistributePaymentConfirmBackMap(request);

if((Boolean)map.get("httpConnection") == false){
out.println("ͨѶʧ��" + "<br/>");
}else{
Map parameter = (Map)map.get("parameter");
Boolean checkHmac = (Boolean)map.get("checkHmac");
if((Boolean)map.get("checkHmac") ){
if(((String)parameter.get("r1_Code")).equals("1")){
out.println("ȷ�Ͻ��׳ɹ�" + "<br/>");
}else{
out.println("ȷ�Ͻ���ʧ��" + "<br/>");
}
out.println("ҵ������:" + parameter.get("r0_Cmd") + "<br>");
out.println("ҵ������:" + new String(((String)parameter.get("errorMsg")).getBytes("gbk"), "iso-8859-1") + "<br>");

logicAfterSendReq();
}else{
out.println("����ǩ����Ч" + "<br/>");
}
}
%> 