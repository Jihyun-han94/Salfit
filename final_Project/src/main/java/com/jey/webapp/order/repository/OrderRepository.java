package com.jey.webapp.order.repository;

import java.util.*;

import com.jey.webapp.order.dto.OrderDTO;
import com.jey.webapp.order.dto.OrderDetailDTO;


public interface OrderRepository {
	
	public OrderDetailDTO select(OrderDTO dto) throws Exception;
	public List<OrderDTO> selectList(OrderDTO dto)  throws Exception;
	public boolean insert(OrderDTO dto)  throws Exception;
	public boolean insert(OrderDetailDTO dto)  throws Exception;
	public boolean update(OrderDetailDTO dto)  throws Exception;
	public boolean insert(int id)  throws Exception;	// 리뷰추가용
}