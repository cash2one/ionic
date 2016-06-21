using System;
using System.IO;  
using System.Net;  
using System.Text; 
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Specialized;
using YeePay_Distribute;
using com.yeepay.utils;


public partial class callBack : System.Web.UI.Page
{
	protected void Page_Load(object sender, EventArgs e)
    {
	//�ڽ��յ�֧�����֪ͨ���ж��Ƿ���й�ҵ���߼�������Ҫ�ظ�����ҵ���߼�����
    		// ��Web.config�ļ����ȡ�̻���Կ
        string keyvalue = ConfigurationManager.AppSettings["KeyValue"];
        // ��Web.config�ļ����ȡ�̻����
        string merchantId = ConfigurationManager.AppSettings["merchantId"];
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
}