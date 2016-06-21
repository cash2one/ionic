using System;
using System.Text;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Collections.Specialized;
using System.Net;
using System.IO;
using com.yeepay.utils;



namespace com.yeepay.fengzhangbiz
{   
	 // ����ҵ������
   public class doRequestHttp
	 {
	    public doRequestHttp() 
        {
        }
	    private string [] hmacArray;
	    private string msgTitle;
	   
	   public string returnResult(string actionType,NameValueCollection nvc,string httpFlag)
	   {
	      string hmacResource = "";
	      string postParams = "";
		  string postUrl = "";
         // ��Web.config�ļ����ȡ�̻���Կ
		  string keyvalue = ConfigurationSettings.AppSettings["KeyValue"];               
		  if(actionType == "RefundExt")
         {
             // ��Web.config�ļ����ȡͨѶ��ַ
		       postUrl = ConfigurationSettings.AppSettings["distributeRefundUrl"];           
		  }
          else if (actionType == "IndirectRegister")
         {
             // ��Web.config�ļ����ȡ���ص�ַ
             postUrl = ConfigurationSettings.AppSettings["distributeRegisterUrl"];        
         }
		  else
		  {
              // ��Web.config�ļ����ȡ���ص�ַ
		       postUrl = ConfigurationSettings.AppSettings["distributeUrl"];                 
		  }
		  
		  switch(actionType)
		  {
		     case "Buy":
		     hmacArray = buyHmacArray;
				 msgTitle = "����֧��";
				 break;
				 case "QueryBalance":
				 hmacArray = queryHmacArray;
				 msgTitle = "����ѯ";
				 break;  
	       case "RefundExt":
				 hmacArray = refundHmacArray;
				 msgTitle = "�����˿�";
				 break;
	       case "IndirectRegister":
	       hmacArray = regMerchantHmacArray;
				 msgTitle = "���̻�ע��";
				 break;
				 case "PaymentConfirm":
				 hmacArray = payConfirmHmacArray;
				 msgTitle = "���˽ⶳ";
				 break;
		  }
		  
		  
		  
	    for(int i=0;i<hmacArray.Length;i++)
	    {
         hmacResource = hmacResource + nvc[hmacArray[i]];
		     postParams = postParams + hmacArray[i] + "=" + nvc[hmacArray[i]]+"&";
      }
         log.createLog(actionType, "sbold:" + hmacResource, "");
		     string hmac = Digest.HmacSign(hmacResource, keyvalue);
         log.createLog(actionType,"keyvalue"+":"+keyvalue,"hmac"+":"+hmac);
           
			postParams = postParams + "hmac=" + hmac;		   		
			
			if(httpFlag == "1")
      {
             // ��¼�ض��������url
         log.createLog(actionType, "requestUrl:" + postUrl + "?" + postParams, "");
		     return postUrl + "?" + postParams; 
            
			}			
           // ��������Ե�ͨѶ
			else
      {
			
			   StringBuilder strResult = new StringBuilder();
            WebRequest req = WebRequest.Create(postUrl);
            // ��¼ͨѶ�����url
            log.createLog(actionType, "requestUrl:" + postUrl + "?" + postParams, "");
            req.Method = "POST";
            req.ContentType = "application/x-www-form-urlencoded";

            byte[] tempBytes = Encoding.Default.GetBytes(postParams);

            req.ContentLength = tempBytes.Length;
            Stream newStream = req.GetRequestStream();
            newStream.Write(tempBytes, 0, tempBytes.Length);
            newStream.Close();
            WebResponse result = req.GetResponse();
            Stream ReceiveStream = result.GetResponseStream();
            Byte[] read = new Byte[512];
            int bytes = ReceiveStream.Read(read, 0, 512);
            while (bytes > 0)
            {
                // ע�⣺
                // ����ٶ���Ӧʹ�� UTF-8 ��Ϊ���뷽ʽ��
                // ��������� ANSI ����ҳ��ʽ�����磬932�����ͣ���ʹ�������������䣺
                //  Encoding encode = System.Text.Encoding.GetEncoding("shift-jis");
                Encoding encode = System.Text.Encoding.Default;//.GetEncoding(encodingName);
                strResult.Append(encode.GetString(read, 0, bytes));
                bytes = ReceiveStream.Read(read, 0, 512);
            }
			
			     string resultStr = strResult.ToString();

            // ��¼ͨѶ������Ϣ

            log.createLog(actionType, "returnMsg:" + resultStr, "");

            NameValueCollection reParams = new NameValueCollection(); 
	  	  
	  		   string[] aryStr = resultStr.Split('\n');
	  
	         foreach(string i in aryStr)
	         {
	            
							string[] aryParams = i.Split('=');
							reParams.Add(aryParams[0],aryParams[1]);
	         } 	
			 
				  if(reParams["r1_Code"]=="1")
					{
					   string returnStr = msgTitle + "�ɹ���<br>"+resultStr;
					   return returnStr;
					}
					else
					{  
					   string returnStr = msgTitle + "ʧ�ܣ�<br>"+resultStr + "<br>ʧ��ԭ��<font color=red>"+showErrorCode(reParams["r1_Code"])+"</font>"; 		 
				       return returnStr;
					}
			}
		}  
		  
		  
		  
		  
//-----------------------------����֧������---------------------------------//
		
		// ����֧�������������
		public string[] buyHmacArray = {"p0_Cmd","p1_MerId","p2_Order","p3_Amt","p4_Cur","p5_Pid","p6_Url","p7_MP","p8_FrpId","p9_TelNum","pa_Details","pc_AutoSplit","pm_Period","pn_Unit","pr_NeedResponse","py_IsYeePayName"};
		
		// ���˷��ز�������
		public string[] buyReHmacArray = {"p1_MerId","r0_Cmd","r1_Code","r2_TrxId","r3_Amt","r4_Cur","r5_Pid","r6_Order","r8_MP","r9_BType","ra_Details","rb_SplitStatus"};
		
//-----------------------------��������ѯ---------------------------------//
		
		// ���˲�ѯ�����������
		public string[] queryHmacArray = {"p0_Cmd","p1_MerId","p2_TargetId","py_IsYeePayName"};
		
		// ���˲�ѯ���ز�������
		public string[] queryReHmacArray = {"r0_Cmd","r1_Code","r2_Blance","r3_Frozen","errorMsg"};
		
//------------------------------�����˿�------------------------------------//
		
		// �����˿������������
		public string[] refundHmacArray = {"p0_Cmd","p1_MerId","p1_RequestId","p2_TrxId","p3_Desc","p4_Details","p5_Amt"};
		
		// �����˿�ز�������
		public string[] refundReHmacArray = {"r0_Cmd","r1_Code","r1_RequestId","r1_Time","errorMsg","r2_OrderAmount","r3_SrcAmount","r4_RefundAmount","r5_MerRefundAmount","r6_Details","r9_BType"};
	
//-----------------------------���̻�ע��--------------------------------------//
	
	    // �������̻�ע�������������
        public string[] regMerchantHmacArray = { "p0_Cmd", "p1_MerId"};
		
//--------------------------------���˽ⶳ---------------------------------------//
		
		// ���˽ⶳ�����������
		public string[] payConfirmHmacArray = {"p0_Cmd","p1_MerId","p2_TrxId","py_IsYeePayName"};
		
		// ���˽ⶳ���ز�������
		public string[] payReConfirmHmacArray = {"r0_Cmd","r1_Code","errorMsg"};


	
		
       // ��������б�		
		private string showErrorCode(string err_Code)
		{
		
		    NameValueCollection errorCode = new NameValueCollection(); 
		    errorCode.Add("220000"," RequestId�ظ�");
            errorCode.Add("220001","���������Ч");
		    errorCode.Add("220002","�������ظ�");
		    errorCode.Add("220003","�������ظ�");
		    errorCode.Add("220004","Զ�̷�������ʧ��");
		    errorCode.Add("223000","δ�ҵ����˼�¼");
		    errorCode.Add("223001","����״̬��Ч(������)");
		    errorCode.Add("223002","����״̬��Ч(��ȷ��)");
		    errorCode.Add("223003","����״̬��Ч(��ȡ��)");
		    errorCode.Add("223004","����״̬��Ч(δ����)");
		    errorCode.Add("223005","����ϵͳ���˾ܾ�");
		    errorCode.Add("223006","�ظ��ķ�������");
		    errorCode.Add("223007","���˽���");
		    errorCode.Add("223008","���˽����Ч");
		    errorCode.Add("221001","����״̬��Ч(�����)");
		    errorCode.Add("221002","��״̬��Ч(δ���)");
		    errorCode.Add("221003","����״̬��Ч(��ȡ��)");
		    errorCode.Add("221004","����״̬��Ч(���˿�)");
		    errorCode.Add("221005","���׽�ƥ��");
		    errorCode.Add("221006","����ϵͳ�˿�ܾ�");
		    errorCode.Add("221007","���׽���");
		    errorCode.Add("221008","δ�ҵ����׼�¼");
		    errorCode.Add("221009","���׽����Ч");
		    errorCode.Add("222001","����ϵͳע��ʧ��");
		    errorCode.Add("222002","�û���Ч");
		    errorCode.Add("222003","�������п���Ϣʧ��");
		    errorCode.Add("222004","���ý�������ʧ��");
		    errorCode.Add("222005","�û���ע��");
		    errorCode.Add("222006","�û��Ѵ���");	
		    errorCode.Add("225001","��ѯ�����̫��");
		    errorCode.Add("225002","����ϵͳ�ܾ���ѯ");
		    errorCode.Add("224001","�˿����");
		    errorCode.Add("224002","�˿���ִ��");	
    		  
		    return errorCode[err_Code];
	   }    
	}	
	
	
	// doResponseHttp��	���ܷ���ʱ����������hmac
	public class doResponseHttp
	{    	    
	   private string [] hmacArray;
	   private string hmacResource;
      // ��Web.config�ļ����ȡ�̻���Կ
		string keyvalue = ConfigurationSettings.AppSettings["KeyValue"];

       public string getCallBackParams(NameValueCollection nvc)
		{
    		   
		   hmacArray = buyReHmacArray;
    		   
		   for(int i=0;i<hmacArray.Length;i++)
	      {
	      	hmacResource = hmacResource + nvc[hmacArray[i]];    		    
        }
    		  
		   string hmac = Digest.HmacSign(hmacResource, keyvalue);
          //��¼���������ص�hmac�ͱ����յ�������Ϣ�����ɵ�hmac
          log.createLog("Buy", "serverhmac" + ":" + nvc["hmac"], "localhmac" + ":" + "[" + hmac + "]");

          return hmac;          
          
		}

       // ���˷��ز�������
       public string[] buyReHmacArray = { "p1_MerId", "r0_Cmd", "r1_Code", "r2_TrxId", "r3_Amt", "r4_Cur", "r5_Pid", "r6_Order", "r8_MP", "r9_BType", "ra_Details", "rb_SplitStatus" };
			
	}	

}