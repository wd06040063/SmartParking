package com.wang.service;

import java.util.List;

import com.wang.entity.CardType;


public interface CardtypeService {

	List<CardType> findAllCardType();

	CardType findCardTypeByid(int typeid);

}
