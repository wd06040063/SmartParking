package com.wang.dao;

import org.apache.ibatis.annotations.Param;

import com.wang.entity.ParkInfo;


public interface ParkinfoDao extends BaseDao<ParkInfo>{
	//添加停车位信息
	public void save(ParkInfo parkInfo);
	public ParkInfo findParkinfoByParknum(@Param("parknum")int parknum);
	public void deleteParkinfoByParkNum(@Param("parknum")int parknum);
	public ParkInfo findParkinfoByCardnum(@Param("cardnum")String cardnum);
	//根据停车号信息查询
	public ParkInfo findParkinfoByCarnum(@Param("carnum")String carnum);
	public void updateCardnum(@Param("cardnum")String cardnum, @Param("cardnumNew")String cardnumNew);
}
