<?php

 /**
  * @Title �ױ�֧�����˷���
  * @Description �˿�����
  * @Copyriht (c) ����ͨ��ͨ��Ϣ���޹�˾���ױ�֧����
  * @Author    wenhua.cheng
  * @Version   V2.0  
  */
require_once 'Refund/DistributeBizRefund.class.php';	
require_once 'function/Map.class.php';

$map = new Map();
foreach($_POST as $key=>$value)
{
  $map->put($key, $value);
}

$distributeBizRefund=new DistributeBizRefund();
$rspHttpString=$distributeBizRefund->doRequestHttp("refund",$map,$refundHmacParaAry,$refundFixParaAry,2,$actionURL_ref);
$resultString=$distributeBizRefund->doResponseHttp($rspHttpString,$refundRspHmacParaAry,2);
if(gettype($resultString)==boolean){
	echo "����ǩ�����۸ģ�";
	}
else if(gettype($resultString)==object){
	// �˿�̳��࣬��ӡ�˿���Ϣ
	$paraInfo=$distributeBizRefund->doParaInfo($resultString);
	echo $paraInfo;
	
	}
	
	
	
?> 

