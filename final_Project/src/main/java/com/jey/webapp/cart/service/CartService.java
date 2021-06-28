package com.jey.webapp.cart.service;

import java.util.*;

import com.jey.webapp.cart.dto.CartDTO;


public interface CartService {

	public CartDTO find(CartDTO dto) throws Exception;
	public List<CartDTO> findAll(CartDTO dto) throws Exception;
	public boolean add(CartDTO dto) throws Exception;
	public boolean changeQty(CartDTO dto) throws Exception;
	public boolean remove(CartDTO dto) throws Exception;
	public boolean removeall(CartDTO dto) throws Exception;
	public int sumMoney(CartDTO dto) throws Exception;
	public int findPrice(CartDTO dto) throws Exception;
	public boolean updateOrderState(CartDTO dto) throws Exception;
	public List<CartDTO> yfindAll(CartDTO dto);
}