package com.jey.webapp.cart.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jey.webapp.cart.dto.CartDTO;
import com.jey.webapp.cart.repository.CartRepository;


@Service
public class CartServiceImpl implements CartService {

	@Autowired
	private CartRepository dao;


	
	@Override
	public boolean add(CartDTO dto) throws Exception {
		boolean res = dao.insert(dto);
		return res;
	}

	public boolean changeQty(CartDTO dto) throws Exception {
		boolean res = dao.update(dto);
		return res;
	}

	@Override //장바구니 비우기 
	public boolean remove(CartDTO dto) throws Exception {
		boolean res = dao.delete(dto);
		return res;
	}

	@Override //장바구니 목록
	public List<CartDTO> findAll(CartDTO dto) throws Exception {
		List<CartDTO> cartlist = dao.selectList(dto);
		
		return cartlist;
	}
	
	


	@Override
	public boolean removeall(CartDTO dto) throws Exception {
	
		return false;
	}

	@Override
	public int sumMoney(CartDTO dto) throws Exception {
	
		return dao.sumMoney(dto);
	}

	@Override
	public int findPrice(CartDTO dto) throws Exception {
		int price = dao.findPrice(dto);
		System.out.println("디버깅"+price);
		return price;
	}

	@Override
	public boolean updateOrderState(CartDTO dto) throws Exception {
		boolean res = dao.update(dto);
		return res;
	}

	@Override
	public CartDTO find(CartDTO dto) throws Exception {
		CartDTO cartlist = dao.select(dto);
		return cartlist;
	}

	@Override
	public List<CartDTO> yfindAll(CartDTO dto) throws Exception {
		List<CartDTO> cartlist = dao.yselectList(dto);
		return cartlist;
	}

	@Override
	public boolean delete(CartDTO dto) throws Exception{
		
		return dao.deletey(dto);
	}

	@Override
	public String findDdate(CartDTO dto) {
		return dao.findDdate(dto);
	}

	@Override
	public String findEdate(CartDTO dto) {
		return dao.findEdate(dto);
	}
	
	



}