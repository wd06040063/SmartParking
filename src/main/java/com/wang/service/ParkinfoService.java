package com.wang.service;

import com.wang.dto.FormData;
import com.wang.entity.ParkInfo;


public interface ParkinfoService {
	public void saveParkinfo(FormData data);
	public ParkInfo findParkinfoByParknum(int parknum);
	public void deleteParkinfoByParkNum(int parkNum);
	public ParkInfo findParkinfoByCardnum(String cardnum);
	public ParkInfo findParkinfoByCarnum(String carnum);
	public void updateCardnum(String cardnum, String cardnumNew);
}
