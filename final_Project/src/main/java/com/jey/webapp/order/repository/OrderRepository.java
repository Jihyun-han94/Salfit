package com.jey.webapp.order.repository;

import java.util.*;

import com.jey.webapp.order.dto.OrderDTO;
import com.jey.webapp.order.dto.OrderDetailDTO;
import com.jey.webapp.order.dto.ReviewDTO;


public interface OrderRepository {
	
	public OrderDetailDTO select(OrderDTO dto) throws Exception;
	public OrderDTO selectone(OrderDTO dto) throws Exception;
	public List<OrderDTO> selectList(OrderDTO dto)  throws Exception;
	public boolean insert(OrderDTO dto)  throws Exception;
	public boolean insert(OrderDetailDTO dto)  throws Exception;
	public boolean update(OrderDetailDTO dto)  throws Exception;
	public boolean insert(ReviewDTO dto)  throws Exception;	// 리뷰추가용
	public List<OrderDetailDTO> selectall(OrderDetailDTO dto) throws Exception;
	public boolean updatestatus(OrderDTO dto) throws Exception;
	public OrderDTO findorder(OrderDTO dto) throws Exception;
	public boolean updatedel(OrderDTO dto) throws Exception;
	public boolean updatedel(OrderDetailDTO dto) throws Exception;
	public boolean holdorder(OrderDTO dto) throws Exception;
	public boolean holdorder(OrderDetailDTO dto) throws Exception;
}