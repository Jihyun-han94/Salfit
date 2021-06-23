package com.jey.webapp.cart.repository;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jey.webapp.cart.dto.CartDTO;

@Repository
public class CartRepositoryImpl implements CartRepository {

	@Autowired
	private SqlSession sqlSession;

	
	@Override
	public CartDTO select(CartDTO dto) throws Exception {
		return null;
	}


	@Override
	public List<CartDTO> selectList(CartDTO dto) throws Exception {
		return null;
	}

	@Override
	public boolean insert(CartDTO dto) throws Exception {
		boolean result = false;
		sqlSession.insert("cartMapper.insert",dto);
		
		
		return result;
	}

	@Override
	public boolean update(CartDTO dto) throws Exception {
		boolean result = false;
		return result;
	}

	@Override
	public boolean delete(CartDTO dto) throws Exception {
		
		
		return false;
	}


	@Override
	public boolean deleteall(CartDTO dto) throws Exception {
	
		return false;
	}


}