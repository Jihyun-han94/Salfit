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

	@Override
	public boolean remove(CartDTO dto) throws Exception {
		return false;
	}

	@Override
	public List<CartDTO> findAll() throws Exception {
		return null;
	}
	
	
	@Override
	public CartDTO find(CartDTO dto) throws Exception {
		return dao.select(dto);
	}
	
	



}