<?php

/**
  * @Title �ױ�֧�����˷���
  * @Description ���̻�ע��
  * @Copyriht (c) ����ͨ��ͨ��Ϣ���޹�˾���ױ�֧����
  * @Author    wenhua.cheng
  * @Version   V2.0  
  */
require_once 'Subreg/DistributeBizSubreg.class.php';	
require_once 'function/Map.class.php';

$map = new Map();
foreach($_POST as $key=>$value)
{
  $map->put($key, $value);
}

// �ض���ʽ�ύ���������ױ�����ע��
$distributeBizSubreg=new DistributeBizSubreg();
$rspHttpString=$distributeBizSubreg->doRequestHttp("subreg",$map,$subregHmacParaAry,$subregFixParaAry,1,$actionURL_reg);


	
?> 

