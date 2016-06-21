<?php

 /**
  * @Title �ױ�֧�����˷���
  * @Description ��Ϣ�����࣬���̻�ID����Կ�������ַ�������ǩ���Ĳ���������Ϣ
  * @Copyriht (c) ����ͨ��ͨ��Ϣ���޹�˾���ױ�֧����
  * @Author    wenhua.cheng
  * @Version   V2.0  
  */
  
/*----------------------------- �������Ա��ע���� -----------------------------------*/ 
 
// �̻�ID������ʽ�������Ϊ��ʽ�̻�ID
// ��ʽ �̻���ź���Կ�����ͨ����,��ϵһ��,���˾��ϵ���ױ�ҵ����Ա(�Ǽ���֧�ֹ���ʦ)���
$p1_MerIdAry=Array('p1_MerId'=>'10001126856');

// �̻���Կ,��������hmac(hmac��˵������ĵ�)
$merchantKey='69cl522AV6q613Ii4W6u8K6XuW8vM1N6bFgyv769220IuYe9u37N4y7rI4Pl';


// ����֧��������ѯ���ⶳ���ʽӿ������ַ
$actionURL='https://www.yeepay.com/app-airsupport/AirSupportService.action';


// �˿������ַ
$actionURL_ref="https://www.yeepay.com/app-airsupport/AirSupportCommand.action";


// ���̻�ע�������ַ
$actionURL_reg="https://www.yeepay.com/selfservice/indirectRegister.action";



 
/*----------------------------- �������Ա��ע���� ----------------------------------*/ 



/*------------ ��־�ļ�·�� ---------------*/
$logName='YeePay_Distribute.log';


/*---- ֧�������ǩ���Ĳ����Լ��̶�ֵ -----*/
// ֧��
$payHmacParaAry=Array('p0_Cmd','p1_MerId','p2_Order','p3_Amt','p4_Cur','p5_Pid','p6_Url','p7_MP','p8_FrpId','p9_TelNum','pa_Details',
'pc_AutoSplit','pm_Period','pn_Unit','pr_NeedResponse','py_IsYeePayName');
$payFixParaAry_pro=Array('p0_Cmd'=>'Buy');
$payFixParaAry=array_merge($payFixParaAry_pro,$p1_MerIdAry);

// ֧������
$payRspHmacParaAry=Array('p1_MerId','r0_Cmd','r1_Code','r2_TrxId','r3_Amt','r4_Cur','r5_Pid','r6_Order','r8_MP','r9_BType','ra_Details','rb_SplitStatus');


/*---- �˿������ǩ���Ĳ����Լ��̶�ֵ -----*/
// �˿�
$refundHmacParaAry=Array('p0_Cmd','p1_MerId','p1_RequestId','p2_TrxId','p3_Desc','p4_Details','p5_Amt');


$refundFixParaAry_pro=Array('p0_Cmd'=>'RefundExt');
$refundFixParaAry=array_merge($refundFixParaAry_pro,$p1_MerIdAry);

// �˿��.errorMsg��ʾr1_CodeΪ��1ʱ�����ǩ���Ĳ���
$refundRspHmacParaAry=Array('r0_Cmd','r1_Code','r1_RequestId','r1_Time','errorMsg','r2_OrderAmount','r3_SrcAmount','r4_RefundAmount','r5_MerRefundAmount','r6_Details','r9_BType');




/*---- ���̻�ע�������ǩ���Ĳ����Լ��̶�ֵ -----*/
// ���̻�ע��
$subregHmacParaAry=Array('p0_Cmd','p1_MerId');
$subregFixParaAry_pro=Array('p0_Cmd'=>'IndirectRegister');
$subregFixParaAry=array_merge($subregFixParaAry_pro,$p1_MerIdAry);

// ���̻�ע��Ϊ�������ױ�ƽ̨���޷���.
// $subregRspHmacParaAry=Array('r0_Cmd','r1_Code','r2_MerId');




/*---- �ⶳ�����ǩ���Ĳ����Լ��̶�ֵ -----*/
// �ⶳ
$thawHmacParaAry=Array('p0_Cmd','p1_MerId','p2_TrxId');


$thawFixParaAry_pro=Array('p0_Cmd'=>'PaymentConfirm');
$thawFixParaAry=array_merge($thawFixParaAry_pro,$p1_MerIdAry);

// �ⶳ����.errorMsg��ʾr1_CodeΪ��1ʱ�����ǩ���Ĳ���
$thawRspHmacParaAry=Array('r0_Cmd','r1_Code','errorMsg');




/*---- ��������б� -----*/
// �������
$errorCodeAry=array('220000'=>'RequestId�ظ�','220001'=>'���������Ч','220002'=>'�������ظ�','220003'=>'�������ظ�','220004'=>'Զ�̷�������ʧ��',
'223000'=>'δ�ҵ����˼�¼','223001'=>'����״̬��Ч(������)','223002'=>'����״̬��Ч(��ȷ��)','223003'=>'����״̬��Ч(��ȡ��)','223004'=>'����״̬��Ч(δ����)',
'223005'=>'����ϵͳ���˾ܾ�','223006'=>'�ظ��ķ�������','223007'=>'���˽���','223008'=>'���˽����Ч','221001'=>'����״̬��Ч(�����)',
'221002'=>'��״̬��Ч(δ���)','221003'=>'����״̬��Ч(��ȡ��)','221004'=>'����״̬��Ч(���˿�)','221005'=>'���׽�ƥ��','221006'=>'����ϵͳ�˿�ܾ�',
'221007'=>'���׽���','221008'=>'δ�ҵ����׼�¼','221009'=>'���׽����Ч','222001'=>'����ϵͳע��ʧ��','222002' =>'�û���Ч','222003'=>'�������п���Ϣʧ��',
'222004'=>'���ý�������ʧ��','222005'=>'�û���ע��','222006'=>'�û��Ѵ���','225001'=>'��ѯ�����̫��','225002'=>'����ϵͳ�ܾ���ѯ','224001'=>'�˿����',
'224002'=>'�˿���ִ��','-1'=>'ϵͳ����');


?> 