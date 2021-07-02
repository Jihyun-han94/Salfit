package com.jey.webapp.order.service;

import java.util.*;

import com.jey.webapp.order.dto.OrderDTO;
import com.jey.webapp.order.dto.OrderDetailDTO;
import com.jey.webapp.product.dto.ProductDTO;


public interface OrderService {

	public boolean add(OrderDTO dto) throws Exception;
	public boolean addDetail(OrderDetailDTO dto) throws Exception;
	public boolean update(OrderDetailDTO dto) throws Exception;
	public OrderDetailDTO findId(int id) throws Exception;
	public List<OrderDTO> findList(OrderDTO dto) throws Exception; //주문 내역 전체 조회
	public boolean add(int id) throws Exception;	// 리뷰추가 : id 는 product 
	public OrderDTO selectone(OrderDTO dto) throws Exception;
	public List<OrderDetailDTO> selectall(OrderDetailDTO dto) throws Exception;
}