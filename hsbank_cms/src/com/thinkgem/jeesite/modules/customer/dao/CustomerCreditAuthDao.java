/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.customer.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.entity.CustomerCreditAuth;

/**
 * 会员信用认证信息DAO接口
 * @author ydt
 * @version 2015-07-13
 */
@MyBatisDao
public interface CustomerCreditAuthDao extends CrudDao<CustomerCreditAuth> {

	CustomerCreditAuth getByAccountId(Long accountId);
	
}