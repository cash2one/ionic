<?php

 /**
  * @Title �ױ�֧�����˷���
  * @Description �ص�ҳ�棬�û�֪ͨ�̻������Ƿ񷢻���ҵ���߼�
  * @Copyriht (c) ����ͨ��ͨ��Ϣ���޹�˾���ױ�֧����
  * @Author    wenhua.cheng
  * @Version   V2.0  
  */
 
require_once 'pay/DistributeBizPay.class.php';
require_once 'business.php';

// ���ױ���д�ı� 
echo "success";
//�ڽ��յ�֧�����֪ͨ���ж��Ƿ���й�ҵ���߼�������Ҫ�ظ�����ҵ���߼�����
// ����ױ�����Ļص���QUERY_STRING,������urldecode
$rspHttpString=urldecode($_SERVER["QUERY_STRING"]);

$distributeBizPay=new DistributeBizPay();
$resultString=$distributeBizPay->doResponseHttp($rspHttpString,$payRspHmacParaAry,1);

if(gettype($resultString)==boolean){
	echo "����ǩ�����۸�!";
	
}

else if(gettype($resultString)==object){


// HmacУ�����������֧�������1Ϊ�ɹ�
$r1CodeValue=$resultString->getValueAt("r1_Code");
$r9BTypeValue=$resultString->getValueAt("r9_BType");

if ($r1CodeValue==1){

     /*--------------------------------------------------------------------------------------*/
	 // �������Ա��ע����
	 // ��������ҵ���߼������������磺�����̻����ݿ����Ʒ�Ƿ񷢻���״̬���ظ�������У�飩��������Ʒ�۸�У���
	 // doSuccessAfterPay(),doFailAfterPay();��������business.php���
	/*--------------------------------------------------------------------------------------*/
	// �ض���. ͨ���˴���ʾ�̻����û����Կ�����֧�����
	if($r9BTypeValue==1){
		// echo "������������ܿ�������Ϣ";
		doSuccessAfterPay();
	
	}
	
	// ��Ե㡣ͨ���˴��̻������Լ���ҵ�񣬱��磺�����̻����ݿ����Ʒ�Ƿ񷢻���״̬���ظ�������У�飩��������Ʒ�۸�У���
	else if($r9BTypeValue==2){
		// echo "�����Ƿ��������Ե�֪ͨ";
		doSuccessAfterPay();
	
	
	}

}

// ֧��ʧ��
else{
	doFailAfterPay();
}
	  
	 
	}
	
?> 

