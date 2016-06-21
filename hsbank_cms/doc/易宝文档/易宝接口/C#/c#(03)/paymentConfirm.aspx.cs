using System;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Configuration;
using com.yeepay.utils;
using com.yeepay.fengzhangbiz;

namespace YeePay_Distrubute2._0
{
	/// <summary>
	/// paymentConfirm ��ժҪ˵����
	/// </summary>
	public class paymentConfirm : System.Web.UI.Page
	{
		private void Page_Load(object sender, System.EventArgs e)
		{
			// �ڴ˴������û������Գ�ʼ��ҳ��
			// ��Web.config�ļ����ȡ�̻���Կ
			string keyvalue = ConfigurationSettings.AppSettings["keyValue"];
			// ��Web.config�ļ����ȡ�̻����
			string merchantId = ConfigurationSettings.AppSettings["merchantId"];
			// ����洢�ύ�����ַ����ļ���
			NameValueCollection Params = new NameValueCollection();
			// ���̻���ż��뵽������
			Params.Add("p1_MerId",merchantId);
			// ����ҳ���ύ�Ĳ�������������д�뼯��
			foreach(string obj in Request.Form)
			{
				Params.Add(obj,Request.Form[obj]);
			}
			// ʵ��������ҵ������
			doRequestHttp req = new doRequestHttp();
			// �����ύ��������÷��ؽ���ַ���  ����һ��PaymentConfirmΪ�ύҵ������,��������ParamsΪ��������,������������1Ϊ�������ض���;2Ϊ��������Ե�ͨѶ
			string resultStr = req.returnResult("PaymentConfirm",Params,"2");
			// ������
			Response.Write(resultStr);
		}

		#region Web ������������ɵĴ���
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: �õ����� ASP.NET Web ���������������ġ�
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// �����֧������ķ��� - ��Ҫʹ�ô���༭���޸�
		/// �˷��������ݡ�
		/// </summary>
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
