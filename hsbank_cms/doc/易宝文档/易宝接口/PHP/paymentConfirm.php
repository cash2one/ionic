<?php

/**
  * @Title �ױ�֧�����˷���
  * @Description �ⶳ
  * @Copyriht (c) ����ͨ��ͨ��Ϣ���޹�˾���ױ�֧����
  * @Author    wenhua.cheng
  * @Version   V2.0  
  */
require_once 'Thaw/DistributeBizThaw.class.php';	
require_once 'function/Map.class.php';

$map = new Map();
foreach($_POST as $key=>$value)
{
  $map->put($key, $value);
}
$distributeBizThaw=new DistributeBizThaw();
$rspHttpString=$distributeBizThaw->doRequestHttp("thaw",$map,$thawHmacParaAry,$thawFixParaAry,2,$actionURL);
$resultString=$distributeBizThaw->doResponseHttp($rspHttpString,$thawRspHmacParaAry,2);
if(gettype($resultString)==boolean){
	echo "����ǩ�����۸ģ�";
}
else if(gettype($resultString)==object){
		
	// ���ýⶳ�̳��࣬��ӡ�ⶳ��Ϣ
	$paraInfo=$distributeBizThaw->doParaInfo($resultString);
	echo $paraInfo;
	
}
	
	
	
?> 

