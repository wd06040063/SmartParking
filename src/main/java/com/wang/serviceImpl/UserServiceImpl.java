package com.wang.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wang.dao.UserDao;
import com.wang.entity.User;
import com.wang.service.UserService;


@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;
	
	public User findUserByUsername(String username) {
		return userDao.findUserByUserName(username);
	}

	public void saveByaddDepotCard(String username,String name, int cardid) {
		userDao.saveByaddDepotCard(username,name,cardid);
	}

	public User findUserByCardid(int cardid) {
		return userDao.findUserByCardid(cardid);
	}

	public List<User> findAllUser(int page,int size) {
		return userDao.findAllUser(page,size);
	}

	public void deleteUserByCardid(int cardid) {
		userDao.deleteUserByCardid(cardid);
	}

	public void save(User user) {
		userDao.save(user);
	}

	public List<User> findUsersByRole(int role,int page,int size) {
		return userDao.findUsersByRole(role,page,size);
	}

	public List<User> findUsersByRoleMan(int role,int page,int size){return userDao.findUsersByRoleMan(role,page,size);};

	public User findUserById(int uid) {
		return userDao.findUserById(uid);
	}

	public void update(User user) {
		userDao.update(user);
	}

	public void delUserById(int uid) {
		userDao.delUserById(uid);
	}

	public int findAllUserCount(int role) {
		return userDao.findAllUserCount(role);
	}

	public int findAllUserCountMan(int role){return userDao.findAllUserCountMan(role);};

	public List<User> finAllUserByRole(int role) {
		return userDao.finAllUserByRole(role);
	}

}
