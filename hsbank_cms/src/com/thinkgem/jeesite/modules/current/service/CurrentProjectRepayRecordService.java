/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.current.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.entity.CurrentProjectRepayRecord;
import com.thinkgem.jeesite.modules.current.dao.CurrentProjectRepayRecordDao;

/**
 * 活期产品付款记录Service
 * @author ydt
 * @version 2015-12-09
 */
@Service
@Transactional(readOnly = true)
public class CurrentProjectRepayRecordService extends CrudService<CurrentProjectRepayRecordDao, CurrentProjectRepayRecord> {

	public CurrentProjectRepayRecord get(String id) {
		return super.get(id);
	}
	
	public List<CurrentProjectRepayRecord> findList(CurrentProjectRepayRecord currentProjectRepayRecord) {
		return super.findList(currentProjectRepayRecord);
	}
	
	public Page<CurrentProjectRepayRecord> findPage(Page<CurrentProjectRepayRecord> page, CurrentProjectRepayRecord currentProjectRepayRecord) {
		return super.findPage(page, currentProjectRepayRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(CurrentProjectRepayRecord currentProjectRepayRecord) {
		super.save(currentProjectRepayRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(CurrentProjectRepayRecord currentProjectRepayRecord) {
		super.delete(currentProjectRepayRecord);
	}
	
}