package com.wang.service;

import java.util.List;

import com.wang.dto.CouponData;
import com.wang.entity.Coupon;

public interface CouponService {

	List<CouponData> findAllCoupon(int i, int pAGESIZE, String name);

	int findAllDepotcardCount(String name);

	Coupon findCouponById(int id);

	void deleteCoupon(Integer id);

	List<CouponData> findAllCouponByCardNum(String cardnum,String name);

	void updateCardnum(String cardnum, String cardnumNew);

	void addCoupon(Coupon coupon);

}
