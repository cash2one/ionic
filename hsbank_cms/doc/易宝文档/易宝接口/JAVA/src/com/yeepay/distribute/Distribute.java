package com.yeepay.distribute;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import com.yeepay.interFace.DigestUtilInterFace;
import com.yeepay.interFace.HttpUtilInterFace;
import com.yeepay.interFace.FormUtilInterFace;
import com.yeepay.interFace.UrlUtilInterFace;
import com.yeepay.interFace.YeepayInterFace;
import com.yeepay.distribute.Info;
import com.yeepay.server.ServerInfo;
import com.yeepay.util.ProcessUtil;
import com.yeepay.util.UpgradeMap;
import javax.servlet.http.HttpServletRequest;
// ����
public class Distribute {	
	// ����֧���������ض����url
	public static String getDistributePayUrl(HttpServletRequest request){
		Map fixParameter = Info.getDistributePayFixParameter();
		String url = Info.getDistributePayUrl();
		String[] hmacOrder = Info.getDistributePayHmacOrder();
		String keyValue = Info.getKeyValue();
		return YeepayInterFace.getRequestUrl(request, fixParameter, url, hmacOrder, keyValue);
	}
	// ����֧���������ύ��form����submitValueΪ�ύ��form��ʱ��
	public static String getDistributePayForm(HttpServletRequest request, String formName, String submitValue){
		Map fixParameter = Info.getDistributePayFixParameter();
		String[] hmacOrder = Info.getDistributePayHmacOrder();
		String keyValue = Info.getKeyValue();
		String url = Info.getDistributePayUrl();
		return YeepayInterFace.getRequestForm(request, formName, submitValue, fixParameter, hmacOrder, keyValue, url);
	}
	// ���֧������callback�Ĳ���
	public static Map distributePayCallback(HttpServletRequest request){
		String[] callbackHmacOrder = Info.getDistributePayCallbackHmacOrder();
		String keyValue = Info.getKeyValue();
		return YeepayInterFace.getCallbackMap(request, callbackHmacOrder, keyValue );
	}
	// �˿�
	public static Map getDistributeRefundExtBackMap(HttpServletRequest request){
		Map fixParameter = Info.getDistributeRefundExtFixParameter();
		String[] hmacOrder = Info.getDistributeRefundExtHmacOrder();
		String[] backHmacOrder = Info.getDistributeRefundExtBackHmacOrder();
		String url = Info.getDistributeRefundExtUrl();
		String keyValue = Info.getKeyValue();
		return YeepayInterFace.getRequestBackMap(request, fixParameter, hmacOrder, backHmacOrder, url, keyValue );
	}
	// ���̻�ע��
	public static String getDistributeIndirectRegisterForm(HttpServletRequest request, String formName, String submitValue){
		Map fixParameter = Info.getDistributeRegistMerchantFixParameter();
		String[] hmacOrder = Info.getDistributeRegistMerchantHmacOrder();
		String keyValue = Info.getKeyValue();
		String url = Info.getDistributeRegistMerchantUrl();
		return YeepayInterFace.getRequestForm(request, formName, submitValue, fixParameter, hmacOrder, keyValue, url);
	}	
	// �ⶳ����
	public static Map getDistributePaymentConfirmBackMap(HttpServletRequest request){
		Map fixParameter = Info.getDistributePaymentConfirmFixParameter();
		String[] hmacOrder = Info.getDistributePaymentConfirmHmacOrder();
		String[] backHmacOrder = Info.getDistributePaymentConfirmBackHmacOrder();
		String url = Info.getDistributePaymentConfirmUrl();
		String keyValue = Info.getKeyValue();
		return YeepayInterFace.getRequestBackMap(request, fixParameter, hmacOrder, backHmacOrder, url, keyValue );
	}
}
