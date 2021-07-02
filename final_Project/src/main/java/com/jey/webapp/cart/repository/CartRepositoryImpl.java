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
	
	
	
	//cart.id로 조회
	@Override 
	public CartDTO select(CartDTO dto) throws Exception {
		
		CartDTO  cart = sqlSession.selectOne("cartMapper.select",dto);
		return cart;
	}


	@Override //cart.aid를 통해 장바구니 조회 
	public List<CartDTO> selectList(CartDTO dto) throws Exception {
		
		 List<CartDTO> cartlist= sqlSession.selectList("cartMapper.selectAll", dto);
		return cartlist;
	}

	@Override
	public boolean insert(CartDTO dto) throws Exception {
		boolean result = false;
		int res = sqlSession.insert("cartMapper.insert",dto);
		if(res ==1) {
			result = true;
		}
		
		return result;
	}

	@Override
	public boolean update(CartDTO dto) throws Exception {
		boolean result = false;
		int res = sqlSession.update("cartMapper.update", dto);
		if(res == 1) {
			result = true;
		}
		
		return result;
	}

	@Override
	public boolean delete(CartDTO dto) throws Exception {
		boolean res = false;
		int result = sqlSession.delete("cartMapper.deleteCart", dto);
	
		if(result == 1) {
			 res = true;
		}else {
			 res = false;
		}
		return res;
	}


	@Override
	public boolean deleteall(CartDTO dto) throws Exception {
	
		return false;
	}


	@Override
	public int sumMoney(CartDTO dto) throws Exception {
		
		int sumMoney = sqlSession.selectOne("cartMapper.sumMoney", dto);
		return sumMoney;
	}


	@Override
	public int findPrice(CartDTO dto) {
		
		int price = sqlSession.selectOne("cartMapper.findPrice",dto);
		return price;
	}


	@Override
	public List<CartDTO> yselectList(CartDTO dto) {
		List<CartDTO> cartlist= sqlSession.selectList("cartMapper.yselectAll", dto);
		return cartlist;
	}

	@Override
	public boolean deletey(CartDTO dto) throws Exception {
		boolean result = false;
		int res = sqlSession.delete("cartMapper.deletey", dto);
		if(res == 1) {
			result = true;
		}
		
		return result;
	}

}