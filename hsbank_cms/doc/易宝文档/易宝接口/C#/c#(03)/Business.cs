using System;
using System.Collections.Specialized;

namespace YeePay_Distrubute2._0
{
	/// <summary>
	/// Business ��ժҪ˵����
	/// </summary>
	// �̻����ڴ˴���ҵ��
	public class Business
	{
		// ����֧������ʱ��Ҫ����ҵ��
		public static void doBeforPay()
		{
        
		}
		// ֧��ʧ�ܺ���Ҫ����ҵ��
		public static void doFailAfterPay(NameValueCollection reParams)
		{
			string p1_MerId = reParams["p1_MerId"];
			string r0_Cmd = reParams["r0_Cmd"];
			string r1_Code = reParams["r1_Code"];
			string r2_TrxId = reParams["r2_TrxId"];
			string r3_Amt = reParams["r3_Amt"];
			string r4_Cur = reParams["r4_Cur"];
			string r5_Pid = reParams["r5_Pid"];
			string r6_Order = reParams["r6_Order"];
			string r8_MP = reParams["r8_MP"];
			string r9_BType = reParams["r9_BType"];
			string ra_Details = reParams["ra_Details"];
			string rb_SplitStatus = reParams["rb_SplitStatus"];

			// ���ڴ˴���дSQL���
			//#-----��ʾ-----#//
			//���ڸ�������֮ǰ���ж��Ƿ�����ظ�����
		}
		// �����̻�ҵ������
		public static void doSuccessAfterPay(NameValueCollection reParams)
		{

			string p1_MerId = reParams["p1_MerId"];
			string r0_Cmd = reParams["r0_Cmd"];
			string r1_Code = reParams["r1_Code"];
			string r2_TrxId = reParams["r2_TrxId"];
			string r3_Amt = reParams["r3_Amt"];
			string r4_Cur = reParams["r4_Cur"];
			string r5_Pid = reParams["r5_Pid"];
			string r6_Order = reParams["r6_Order"];
			string r8_MP = reParams["r8_MP"];
			string r9_BType = reParams["r9_BType"];
			string ra_Details = reParams["ra_Details"];
			string rb_SplitStatus = reParams["rb_SplitStatus"];

			// ���ڴ˴���дSQL���
			//#-----��ʾ-----#//
			//���ڸ�������֮ǰ���ж��Ƿ�����ظ�����

		}
	}
}
