<?php

 /**
  * @Title �ױ�֧�����˷���
  * @Description ֧������
  * @Copyriht (c) ����ͨ��ͨ��Ϣ���޹�˾���ױ�֧����
  * @Author    wenhua.cheng
  * @Version   V2.0  
  */


require_once 'pay/DistributeBizPay.class.php';	
require_once 'function/Map.class.php';
require_once 'business.php';


$map = new Map();
foreach($_POST as $key=>$value)
{
  $map->put($key, $value);
} 


/*-----------------------------------------------*/
// �������Ա��ע
// ��ȡ���ύ����, �̻������Լ���Ҫ��ҵ����
/*-----------------------------------------------*/
// ��������business.php ��ʵ�֣�����˴����������Լ���Ʒ��Ϣд�����ݿ⣬���ñ�־λʾ"δ֧��"
doBeforPay();


// �ض���ʽ�ύ�������ױ�����
$distributeBizPay=new DistributeBizPay();
$rspHttpString=$distributeBizPay->doRequestHttp("pay",$map,$payHmacParaAry,$payFixParaAry,1,$actionURL);

?> 

