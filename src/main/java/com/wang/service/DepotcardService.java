package com.wang.service;

import java.util.List;

import com.wang.dto.DepotcardManagerData;
import com.wang.entity.Depotcard;


public interface DepotcardService {

	List<DepotcardManagerData> findAllDepotcard(String cardnum,int page,int size);

	Depotcard save(DepotcardManagerData depotcardManagerData);

	Depotcard findByCardid(int cardid);

	Depotcard findByCardnum(String cardnum);

	void updateDepotcardBycardnum(Depotcard depotcard);

	void deleteDepotCard(String cardnum);

	void addMoney(String cardnum, double money);

	int findAllDepotcardCount(String cardnum);

	List<DepotcardManagerData> findByCardId(int cardid);

	void updateCardnum(String cardnum, String cardnumNew);

	String findCardnumByCarnum(String carnum);


}
