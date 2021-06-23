package com.jey.webapp.cart.repository;

import java.util.*;

import com.jey.webapp.cart.dto.CartDTO;

public interface CartRepository {
	
	public CartDTO select(CartDTO dto) throws Exception;
	public List<CartDTO> selectList(CartDTO dto)  throws Exception;
	public boolean insert(CartDTO dto)  throws Exception;
	public boolean update(CartDTO dto)  throws Exception;
	public boolean delete(CartDTO dto)  throws Exception;
	public boolean deleteall(CartDTO dto)  throws Exception;
}