package com.wang.service;

import java.util.List;

import com.wang.dto.ParkinfoallData;
import com.wang.entity.Parkinfoall;


public interface ParkinfoallService {

	List<ParkinfoallData> findAllParkinfoall(int page,int size);

	void save(Parkinfoall parkinfoall);

	ParkinfoallData findById(int id);

	int findAllParkinfoallCount(String name);

	List<ParkinfoallData> findAllParkinfoallByLike(int i, int pAGESIZE, String name);

	List<ParkinfoallData> findByCardNum(String cardnum,String name);

	void updateCardnum(String cardnum, String cardnumNew);

	List<ParkinfoallData> findByCardNumByPage(int page, int size, String cardnum, String name);

}
