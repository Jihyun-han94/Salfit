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
	public int sumMoney(CartDTO dto) throws Exception;
	public int findPrice(CartDTO dto)throws Exception;
	public List<CartDTO> yselectList(CartDTO dto) throws Exception;
	public boolean deletey(CartDTO dto) throws Exception;
	public String findDdate(CartDTO dto);
	public String findEdate(CartDTO dto);
}