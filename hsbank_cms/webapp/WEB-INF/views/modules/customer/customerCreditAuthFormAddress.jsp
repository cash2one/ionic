<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>会员信用认证信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				messages: {
					addressCreditAuthRemark:{required:"请填写认证说明"}
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			var creditScore = $("#addressCreditAuthCode");
			$("#btnReject").click(function(){
				creditScore.removeClass("required");
				creditScore.val("");
				$("#addressCreditAuthCode").val("-1");
				$("#inputForm").submit();
				creditScore.addClass("required");
			});
			$("#btnAgree").click(function(){
				$("#addressCreditAuthCode").val("2");
				$("#inputForm").submit();
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/customer/customerCreditAuth/">会员信用认证信息列表</a></li>
		<li class="active"><a href="${ctx}/customer/customerCreditAuth/formAddress?id=${customerCreditAuth.id}">审核会员家庭情况<shiro:lacksPermission name="customer:customerCreditAuth:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form modelAttribute="customerBase" class="form-horizontal">
		<div class="control-group">
			<label class="control-label">婚姻状况：</label>
			<div class="controls">
				<form:select path="marriageCode" disabled="true" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('customer_marriage')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">居住地址：</label>
			<div class="controls">
				<form:input path="address" readonly="true" htmlEscape="false" maxlength="100" class="input-xlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">户籍：</label>
			<div class="controls">
				<form:input path="familyRegister" readonly="true" htmlEscape="false" maxlength="20" class="input-xlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">户口薄照片：</label>
			<div class="controls">
				<form:hidden id="familyRegisterFile" path="familyRegisterFile" htmlEscape="false" maxlength="500" class="input-xlarge required"/>
				<sys:ckfinder input="familyRegisterFile" readonly="true" type="images" uploadPath="/customer" selectMultiple="true"/>
			</div>
		</div>
	</form:form>
	<form:form id="inputForm" modelAttribute="customerCreditAuth" action="${ctx}/customer/customerCreditAuth/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<form:hidden path="addressCreditAuthCode"/>
		<div class="control-group">
			<label class="control-label">认证说明：</label>
			<div class="controls">
				<form:textarea path="addressCreditAuthRemark" placeholder="请填写认证说明" htmlEscape="false" rows="4" maxlength="500" class="input-xxlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">家庭情况得分：</label>
			<div class="controls">
				<form:input path="addressScore" htmlEscape="false" min="0" max="8" maxlength="11" class="input-xlarge number required"/>
				<span class="help-inline">分数范围：0分-8分。</span>
			</div>
		</div>
		<div class="form-actions">
			<c:if test="${customerCreditAuth.addressCreditAuthCode==1 }">
			<shiro:hasPermission name="customer:customerCreditAuth:edit">
			<input id="btnReject" class="btn btn-danger" type="button" value="驳 回"/>&nbsp;
			<input id="btnAgree" class="btn btn-success" type="button" value="通 过"/>&nbsp;
			</shiro:hasPermission>
			</c:if>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>