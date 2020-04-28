package com.wang.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wang.dao.CardtypeDao;
import com.wang.entity.CardType;
import com.wang.service.CardtypeService;


@Service
public class CardtypeServiceImpl implements CardtypeService {

	@Autowired
	private CardtypeDao cardtypeDao;
	
	public List<CardType> findAllCardType() {
		List<CardType> cardTypes=cardtypeDao.findAllCardType();
		return cardTypes;
	}

	public CardType findCardTypeByid(int typeid) {
		return cardtypeDao.findCardTypeByid(typeid);
	}

}
