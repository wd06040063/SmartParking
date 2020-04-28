package com.wang.service;

import com.wang.dto.ChargeData;
import com.wang.entity.DepotInfo;

public interface DepotInfoService {

	void update(ChargeData chargeData);

	DepotInfo findById(int i);

}
