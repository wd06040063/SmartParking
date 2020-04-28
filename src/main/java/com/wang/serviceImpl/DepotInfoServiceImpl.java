package com.wang.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wang.dao.DepotInfoDao;
import com.wang.dto.ChargeData;
import com.wang.entity.DepotInfo;
import com.wang.service.DepotInfoService;


@Service
public class DepotInfoServiceImpl implements DepotInfoService{

	@Autowired 
	private DepotInfoDao depotInfoDao;
	public void update(ChargeData chargeData) {
		depotInfoDao.update(chargeData);
	}
	public DepotInfo findById(int id) {
		return depotInfoDao.findById(id);
	}

}
