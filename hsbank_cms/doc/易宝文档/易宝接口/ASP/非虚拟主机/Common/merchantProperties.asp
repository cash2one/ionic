<%
'**************************************************
'* @Title �ױ�֧�����˷���
'* @Description ��Ϣ�����࣬���̻�ID����Կ�������ַ�������ǩ���Ĳ���������Ϣ
'* @Copyriht (c) ����ͨ��ͨ��Ϣ���޹�˾���ױ�֧����
'* @Author    yang.yue
'* @Version   V2.0  
'**************************************************

'*----------------------------- �������Ա��ע���� -----------------------------*' 
    

' �̻���ţ�ID��������ʽ�������Ϊ��ʽ�̻�ID
' ��ʽ �̻���ź���Կ�����ͨ����,��ϵһ��,���˾��ϵ���ױ�ҵ����Ա(�Ǽ���֧�ֹ���ʦ)���
Dim p1_MerId

' �̻���Կ,��������hmac(hmac��˵������ĵ�)
Dim keyValue

' �������̻����
merIdname="p1_MerId"
p1_MerId = "10001126856"
' �������̻���Կ
keyValue = "69cl522AV6q613Ii4W6u8K6XuW8vM1N6bFgyv769220IuYe9u37N4y7rI4Pl"

' ������־���ļ���
logFileName = "YeePay_Distribute.log"
 

' ��ʽ��ַ
reqURL= "https://www.yeepay.com/app-airsupport/AirSupportService.action"  
' ���̻��˿��ַ
reqURLRefund = "http://www.yeepay.com/app-airsupport/AirSupportCommand.action"
' ����ע���ַ
reqURLReg = "https://www.yeepay.com/selfservice/indirectRegister.action"

Set requestMap = Server.CreateObject( "Scripting.Dictionary")

'*----------------------------- ���������ǩ���Ĳ����Լ��̶�ֵ ------------------------------*'


' ������������hmac�Ĳ���
Dim buyHmacArray
buyHmacArray = Array("p0_Cmd","p1_MerId","p2_Order","p3_Amt","p4_Cur","p5_Pid","p6_Url","p7_MP","p8_FrpId","p9_TelNum","pa_Details","pc_AutoSplit","pm_Period","pn_Unit","pr_NeedResponse","py_IsYeePayName")


' ���˷�������hmac�Ĳ��� ,"rb_BankId","ro_BankOrderId","rp_PayDate"
Dim BuyResHmacArray
BuyResHmacArray = Array("p1_MerId","r0_Cmd","r1_Code","r2_TrxId","r3_Amt","r4_Cur","r5_Pid","r6_Order","r8_MP","r9_BType","ra_Details","rb_SplitStatus")


'*----------------------------- �˿������ǩ���Ĳ����Լ��̶�ֵ ------------------------------*'
' �˿��������
Dim RefundExtHmacArray
RefundExtHmacArray = Array("p0_Cmd","p1_MerId","p1_RequestId","p2_TrxId","p3_Desc","p4_Details","p5_Amt")
' �˿�ز���
Dim RefundExtResHmacArray
RefundExtResHmacArray = Array("r0_Cmd","r1_Code","r1_RequestId","r1_Time","errorMsg","r2_OrderAmount","r3_SrcAmount","r4_RefundAmount","r5_MerRefundAmount","r6_Details","r9_BType")



'*----------------------------- ���̻�ע�������ǩ���Ĳ����Լ��̶�ֵ ------------------------------*'
' ���̻�ע���������
Dim RegistMerchantHmacArray
RegistMerchantHmacArray = Array("p0_Cmd","p1_MerId","p2_RemoteLoginName","p8_Url","pa0_Mode","pa1_Mode","pa2_Mode")
' ���̻�ע�᷵�ز���
Dim RegistMerchantResHmacArray
RegistMerchantResHmacArray = Array("p1_MerId","r0_Cmd","r1_Code","r2_AgentUserName","r3_AgentCustomerNumber")



'*----------------------------- �ⶳ�����ǩ���Ĳ����Լ��̶�ֵ ------------------------------*'
' �ⶳ�������
Dim PaymentConfirmHmacArray
PaymentConfirmHmacArray = Array("p0_Cmd","p1_MerId","p2_TrxId")
' �ⶳ���ز���
Dim PaymentConfirmResHmacArray
PaymentConfirmResHmacArray = Array("r0_Cmd","r1_Code","errorMsg")


'*---- ��������б� -----*'
Dim errorCodeAry
errorCodeAry = Array("220000=RequestId�ظ�","220001=���������Ч","220002=�������ظ�","220003=�������ظ�","220004=Զ�̷�������ʧ��","223000=δ�ҵ����˼�¼","223001=����״̬��Ч(������)","223002=����״̬��Ч(��ȷ��)","223003=����״̬��Ч(��ȡ��)","223004=����״̬��Ч(δ����)","223005=����ϵͳ���˾ܾ�","223006=�ظ��ķ�������","223007=���˽���","223008=���˽����Ч","221001=����״̬��Ч(�����)","221002=��״̬��Ч(δ���)","221003=����״̬��Ч(��ȡ��)","221004=����״̬��Ч(���˿�)","221005=���׽�ƥ��","221006=����ϵͳ�˿�ܾ�","221007=���׽���","221008=δ�ҵ����׼�¼","221009=���׽����Ч","222001=����ϵͳע��ʧ��","222002=�û���Ч","222003=�������п���Ϣʧ��","222004=���ý�������ʧ��","222005=�û���ע��","222006=�û��Ѵ���","225001=��ѯ�����̫��","225002=����ϵͳ�ܾ���ѯ","224001=�˿����","224002=�˿���ִ��")
%>