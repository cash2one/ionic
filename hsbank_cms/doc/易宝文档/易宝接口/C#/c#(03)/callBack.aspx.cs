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
	/// callBack ��ժҪ˵����
	/// </summary>
	public class callBack : System.Web.UI.Page
	{
		private void Page_Load(object sender, System.EventArgs e)
		{
			//�ڽ��յ�֧�����֪ͨ���ж��Ƿ���й�ҵ���߼�������Ҫ�ظ�����ҵ���߼�����
			// �ڴ˴������û������Գ�ʼ��ҳ��
			// ��Web.config�ļ����ȡ�̻���Կ
			string keyvalue = ConfigurationSettings.AppSettings["KeyValue"];
			// ��Web.config�ļ����ȡ�̻����
			string merchantId = ConfigurationSettings.AppSettings["merchantId"];
			// ����洢�ύ�����ַ����ļ���
			NameValueCollection Params = new NameValueCollection();
			log.createLog("Buy", "callBackUrl" + ":" + Request.RawUrl, "");
			// ����ҳ���ύ�Ĳ�������������д�뼯��
			foreach(string obj in Request.QueryString)
			{
				Params.Add(obj,Request.QueryString[obj]);
			}
			// ʵ�������շ���������
			doResponseHttp backParams = new doResponseHttp();
			// 
			string localhmac = backParams.getCallBackParams(Params);

			if (localhmac != Request.QueryString["hmac"])
			{
				Response.Write("Hmac��ƥ�䣬������Ϣ���۸ģ�");
			}
			else
			{
				if (Request.QueryString["r1_Code"] == "1")
				{
					Response.Write("success<br>���׳ɹ���");
					// ����֧���ɹ�ʱ��ҵ��
					Business.doSuccessAfterPay(Params);
				}
				else
				{
					Response.Write("����ʧ�ܣ�");
					// ����ʧ��ʱ��ҵ��
					Business.doFailAfterPay(Params);
				}
			}
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
