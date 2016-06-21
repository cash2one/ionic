package com.yeepay.util;

import java.util.Map;

import com.yeepay.util.UpgradeMap;
import com.yeepay.util.ProcessUtil;

public class errorMsgInfo{
	static{
		methodsAtStaticBlock();
	}
	private static Map errorMsg = null;
	private static String errorMsgCode = "gbk";
	private static void methodsAtStaticBlock(){
		initErrorMsg();
	}
	public static String getErrorMsg(String key){
		String returnString = (String)errorMsg.get(key);
		return returnString;
	}
	private static void changeErrorMsgCode(String afterChangeCode){
		String beforeChangeCode = errorMsgCode;
		errorMsgCode = afterChangeCode;
		errorMsg = ProcessUtil.changeMapCode(errorMsg, beforeChangeCode, afterChangeCode);
	}
	private static void initErrorMsg(){
		errorMsg = getDefaultErrorMsg();
		changeErrorMsgCode("iso-8859-1");
	}
	private static Map getDefaultErrorMsg(){
		Map returnMap = new UpgradeMap();
		returnMap.put("220000", "RequestId�ظ�");
		returnMap.put("220001", "���������Ч");
		returnMap.put("220002", "�������ظ�");
		returnMap.put("220003", "�������ظ�");
		returnMap.put("220004", "Զ�̷�������ʧ��");
		returnMap.put("223000", "δ�ҵ����˼�¼");
		returnMap.put("223001", "����״̬��Ч(������)");
		returnMap.put("223002", "����״̬��Ч(��ȷ��)");
		returnMap.put("223003", "����״̬��Ч(��ȡ��)");
		returnMap.put("223004", "����״̬��Ч(δ����)");
		returnMap.put("223005", "����ϵͳ���˾ܾ�");
		returnMap.put("223006", "�ظ��ķ�������");
		returnMap.put("223007", "���˽���");
		returnMap.put("223008", "���˽����Ч");
		returnMap.put("221001", "����״̬��Ч(�����)");
		returnMap.put("221002", "����״̬��Ч(δ���)");
		returnMap.put("221003", "����״̬��Ч(��ȡ��)");
		returnMap.put("221004", "����״̬��Ч(���˿�)");
		returnMap.put("221005", "���׽�ƥ��");
		returnMap.put("221006", "����ϵͳ�˿�ܾ�");
		returnMap.put("221007", "���׽���");
		returnMap.put("221008", "δ�ҵ����׼�¼");
		returnMap.put("221009", "���׽����Ч");
		returnMap.put("222001", "����ϵͳע��ʧ��");
		returnMap.put("222002", "�û���Ч");
		returnMap.put("222003", "�������п���Ϣʧ��");
		returnMap.put("222004", "���ý�������ʧ��");
		returnMap.put("222005", "�û���ע��");
		returnMap.put("222006", "�û��Ѵ���");
		returnMap.put("225001", "��ѯ�����̫��");
		returnMap.put("225002", "����ϵͳ�ܾ���ѯ");
		returnMap.put("224001", "�˿����");
		returnMap.put("224002", "�˿���ִ��");
		return returnMap;
	}
}
