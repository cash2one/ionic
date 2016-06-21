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
using com.yeepay.utils;


public partial class paymentConfirm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // ��Web.config�ļ����ȡ�̻���Կ
        string keyvalue = ConfigurationManager.AppSettings["keyValue"];
        // ��Web.config�ļ����ȡ�̻����
        string merchantId = ConfigurationManager.AppSettings["merchantId"];
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
}