<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<%@page import="com.yeepay.distribute.Distribute,java.util.Map"%>
<%
Map map = Distribute.distributePayCallback(request);

if(((String)request.getParameter("r9_BType")).equals("2")){
out.println("success</br>");
//�ڽ��յ�֧�����֪ͨ���ж��Ƿ���й�ҵ���߼�������Ҫ�ظ�����ҵ���߼�����
}
	if((Boolean)map.get("checkHmac")){
	out.println("�̻����:" + request.getParameter("p1_MerId") + "</br>");
	out.println("ҵ������:" + request.getParameter("r0_Cmd") + "</br>");
	out.println("֧�����:" + request.getParameter("r1_Code") + "</br>");
	out.println("�ױ�֧��������ˮ��:" + request.getParameter("r2_TrxId") + "</br>");
	out.println("��Ʒ�۸�:" + request.getParameter("r3_Amt") + "</br>");
	out.println("���ױ���:" + request.getParameter("r4_Cur") + "</br>");
	out.println("��Ʒ���:" + request.getParameter("r5_Pid") + "</br>");
	out.println("������:" + request.getParameter("r6_Order") + "</br>");
	out.println("�̼���չ��Ϣ:" + request.getParameter("r8_MP") + "</br>");
	out.println("��������:" + request.getParameter("r9_BType") + "</br>");
	out.println("���˵��б�:" + request.getParameter("ra_Details") + "</br>");
	
	logicAtCallback();
	
	}else{
	out.println("����ǩ����Ч");
	}
%>
<%!
public void logicAtCallback(){

}
%>