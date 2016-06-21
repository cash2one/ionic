<?php

 /**
  * @Title �ױ�֧�����˷���
  * @Description ���࣬����������doRequestHttp()����Ե�ͨѶ����/�ص�doResponseHttp(),ǩ��У��checkHmac()�ȷ���
  * @Copyriht (c) ����ͨ��ͨ��Ϣ���޹�˾���ױ�֧����
  * @Author    wenhua.cheng
  * @Version   V2.0  
  */
  
ob_start();
require_once 'function/merchantProperties.php';
require_once 'function/HttpClient.class.php';
require_once 'function/Map.class.php';
class DistributeBizBase{

/*--------- �ָ������̶������� -------------*/
// �����ı������ָ��
private $rspHttpParaFlag="\n";

// �ص������ָ���
private $rspCallbackParaFlag="&";

// �������ֵ�ָ��
private $paraItemFlag="=";

// hmac����
private $paraHmacName="hmac";

// ����������
private $codeFlag="r1_Code";



/**
 * @Description ������Map
 * @$map  �����Map
 * @$typeFlag Ϊ1������ƴ�Ӳ���ֵ��Ϊǩ��Դ��Ϊ2��������Ҫ���ݵĲ�����/ֵ�Լ�Hmac������
 */
function traverseMap($map, $typeFlag){
	$resultString="";
	foreach($map as $key=>$value){
		if($typeFlag==1){
			//$value=urldecode($value); 
			$resultString.=$value;
	}
	else if($typeFlag==2){
        $querystring = '';
    		foreach($map as $key=>$val){
    				$querystring .= urlencode($key).'='.urlencode($val).'&';
    			}
    		$querystring = substr($querystring, 0, -1); 
    	return $querystring;
    }
	else {
			echo "����Map���ͱ�־λ����";
	}
	}
	return $resultString;
}


/**
 * @Description  ��������
 * @$actionType  �������ͣ�������־��ӡ
 * @$requestMap  �������еĲ��������Map
 * @$hmacParaAry ��Ҫ����ǩ���Ĳ�������
 * @$fixParaAry  �̶�ֵ�Ĳ���
 * @$httpFlag 	 �ض���/��Ե�ͨѶ��־λ��1Ϊ�ض���2Ϊ��Ե�ͨѶ
 */
public function doRequestHttp($actionType,$requestMap,$hmacParaAry, $fixParaAry,$httpFlag,$actionURL)
{	
	global $merchantKey;
	
	// ʵ������Ҫ����ǩ����Map
	$hmacMap=new Map();
	
	// �����Ĺ̶�ֵ������ֵ��copy�������Map
	$requestMap->copyData($fixParaAry);
	
	// ����Ҫ����ǩ���Ĳ�����ֵ�Է���hmacMap
	foreach($hmacParaAry as $value){
		$returnValue=$requestMap->getValueAt($value);
		$hmacMap->put($value,$returnValue);
	}
	
	// ����ǩ��Դ
	$hmacSource=$this->traverseMap($hmacMap,1);
	
	// �����贫�ݵ�Hmac
	$paraHmacValue=$this->HmacMd5($hmacSource, $merchantKey);
	
	// ��¼����ǩ������־
	$this->loghmac($hmacSource,$merchantKey,$paraHmacValue);
	
	// �����贫�ݵ�Hmac��ֵ
	$requestMap->put($this->paraHmacName,$paraHmacValue);

	// ƴ���������
	$resultHttpString=$this->traverseMap($requestMap,2);
	$actionString=$actionURL.'?'.$resultHttpString;
	
	// ��¼����������־
	$this->logurl($actionType,$actionString);
	
	// �ض���
	if($httpFlag==1){
		header("Location:".$actionString);
	    exit;
	}
	
	// ��Ե�ͨѶ
	else if($httpFlag==2)  {
	
	// ��������
	$pageContents=HttpClient::quickPost($actionURL,$resultHttpString);
	
	$this->logurl($actionType,$pageContents);
	// echo $pageContents;
	if($pageContents==""){
		echo "���ӳ�ʱ!";
	}
	else {
	    return $pageContents;
	}
	}
}


/**
 * @Description      ������Ӧ
 * @$responseString  �ױ��������ݻ�ص�ʱ�ױ����̻����������
 * @$rspHmacParaAry  ��Ҫ����ǩ���Ĳ�������
 * @$isRspFlag   	 �ص�/ͨѶ�ύ���ر�־λ��1Ϊ�ص���2ΪͨѶ�ύ����
 */
public function doResponseHttp($responseString,$rspHmacParaAry,$isRspFlag)
{	
	global $errorCodeAry;
	
	// HamcУ�����������õ���Ϣ
    $rspMapAll=new Map();
	
	$rspHmacMap=new Map();
	$rspHmacValue="";
	
	//  �ָ�ص��Ĳ�����ֵ����ʱ�ָ���httpĬ�ϵ�"&"
	if($isRspFlag==1){
		$result=explode($this->rspCallbackParaFlag,$responseString);
	}
	
	// �ֵ���Ե�ͨѶ�ױ����ص��ı�����ʱ�ָ���Ϊ"\n"
	else if($isRspFlag==2){
		$result=explode($this->rspHttpParaFlag,$responseString);
		}
	
	// ����ȡ����Ϣ��ֳɼ�ֵ�Է���Map	
	for($index=0;$index<count($result);$index++){		
		$result[$index] = trim($result[$index]);
		if (strlen($result[$index]) == 0) {
			continue;
		}
		$aryReturn= explode($this->paraItemFlag,$result[$index]);
		$sKey= $aryReturn[0];
		$sValue	= $aryReturn[1];
		$rspMapAll->put($sKey,$sValue);
		}
	$resultCode=$rspMapAll->getValueAt($this->codeFlag);

	$rspHmacValue=$rspMapAll->getValueAt($this->paraHmacName);
	foreach($rspHmacParaAry as $value){
		$returnValue=$rspMapAll->getValueAt($value);
		$rspHmacMap->put($value,$returnValue);
	}
		

	if($this->checkHmac($rspHmacMap,$rspHmacValue)){
			
		
		// ����ǻص�����ͨѶ�ύ����Ϊ1��return $rspMapAll
		if($resultCode==1&&$isRspFlag==2 || $isRspFlag==1){
		
			return $rspMapAll;
		}
		else  if($resultCode!=1&&$isRspFlag==2){
		
          // �����ͨѶ�ύ����r1_Code	
			if(array_key_exists($resultCode,$errorCodeAry)){
			 	$errorCodeValue=$rspMapAll->getValueAt('errorMsg');
				if($errorCodeValue==''){
					$errorCodeValue=$errorCodeAry[$resultCode];
				}
				$errorResult="�������:".$resultCode."</br>"."����ԭ��:".$errorCodeValue;
	 		}		
			
	 		else{
				 $errorResult="δ֪����";
			}
			
			echo $errorResult;
	}
		}	
	else {
	
	
	
		return  false;
	}

	
		// ��¼��־
		$this->logurl("ͨѶ����",$errorResult);
	
}



/*-----------------------------------*/
//-- У��hmac
/*-----------------------------------*/
function checkHmac($sourceMap,$hmacValue){
	global $merchantKey;
	$hmacSource=$this->traverseMap($sourceMap,1);
	$localHmacValue=$this->HmacMd5($hmacSource, $merchantKey);
	if($localHmacValue==$hmacValue){

		return true;
	}
	else{
	
		return false;
	}
}



/*------------------------------*/
//-- ����hmac�ĺ���
/*-----------------------------*/
public function HmacMd5($data,$key)
{
	//logurl("iconv Q logdata",$data);
	$logdata=$data;
	$logkey=$key;

	// RFC 2104 HMAC implementation for php.
	// Creates an md5 HMAC.
	// Eliminates the need to install mhash to compute a HMAC
	// Hacked by Lance Rushing(NOTE: Hacked means written)

	// ��Ҫ���û���֧��iconv���������Ĳ���������������
	$ke=iconv("GB2312","UTF-8",$key);
	$data=iconv("GB2312","UTF-8",$data);
	$b=64; // byte length for md5
	if (strlen($key) > $b) {
			$key = pack("H*",md5($key));
								}
	$key=str_pad($key, $b, chr(0x00));
	$ipad=str_pad('', $b, chr(0x36));
	$opad=str_pad('', $b, chr(0x5c));
	$k_ipad=$key ^ $ipad ;
	$k_opad=$key ^ $opad;
	$log_hmac=md5($k_opad . pack("H*",md5($k_ipad . $data)));
	return md5($k_opad . pack("H*",md5($k_ipad . $data)));
}


/**
 * @Description   ��¼����URL����־
 * @$title        ��־����
 * @$content      ��ӡ������
 */
public function logurl($title,$content)
{
	global $logName;
	$james=fopen($logName,"a+");
	date_default_timezone_set(PRC);
	fwrite($james,"\r\n".date("Y-m-d H:i:s,A")." ��".$title."��   ".$content."\n");
	fclose($james);
}


/*------------------------------*/
//-- ��¼����hmacʱ����־��Ϣ
/*-----------------------------*/
public function loghmac($str,$merchantKey,$hmac)
{
	global $logName;
	global $merchantKey;
	$james=fopen($logName,"a+");
	date_default_timezone_set(PRC);
	fwrite($james,"\r\n".date("Y-m-d H:i:s,A")."  [����ǩ���Ĳ���:]".$str."  [�̻���Կ:]".$merchantKey."   [����HMAC:]".$hmac);
	fclose($james);
}
}

?>