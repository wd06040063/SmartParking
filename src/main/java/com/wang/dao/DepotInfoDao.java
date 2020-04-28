package com.wang.dao;

import com.wang.dto.ChargeData;
import com.wang.entity.DepotInfo;


public interface DepotInfoDao extends BaseDao<DepotInfo>{
	public void update(ChargeData chargeData);
	public DepotInfo findById(int id);
}
