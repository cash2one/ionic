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
Map map = Distribute.getDistributeRefundExtBackMap(request);

if((Boolean)map.get("httpConnection") == false){
out.println("ͨѶʧ��" + "<br/>");
}else{
Map parameter = (Map)map.get("parameter");
Boolean checkHmac = (Boolean)map.get("checkHmac");
if((Boolean)map.get("checkHmac") ){
if(((String)parameter.get("r1_Code")).equals("1")){
out.println("�˿�ɹ�" + "<br/>");
}else{
out.println("�˿�ʧ��" + "<br/>");
}

out.println("ҵ������:" + parameter.get("r0_Cmd") + "<br>");
out.println("֧�����:" + parameter.get("r1_Code") + "<br>");
out.println("Ψһ�����:" + parameter.get("r1_RequestId") + "<br>");
out.println("ҵ����ɵ�ʱ��:" + parameter.get("r1_Time") + "<br>");
out.println("��������:" + new String(((String)parameter.get("errorMsg")).getBytes("gbk"), "iso-8859-1") + "<br>");
out.println("�������:" + parameter.get("r2_OrderAmount") + "<br>");
out.println("֧�����:" + parameter.get("r3_SrcAmount") + "<br>");
out.println("�˿���:" + parameter.get("r4_RefundAmount") + "<br>");
out.println("ƽ̨�˿���:" + parameter.get("r5_MerRefundAmount") + "<br>");
out.println("�˿���ϸ:" + parameter.get("r6_Details") + "<br>");
out.println("֪ͨ����:" + parameter.get("r9_BType") + "<br>");

logicAfterSendReq();
}else{
out.println("����ǩ����Ч" + "<br/>");
}
}
%> 