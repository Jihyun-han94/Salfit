package com.jey.webapp.order.service;

import java.util.*;

import com.jey.webapp.order.dto.AdminOrderDTO;
import com.jey.webapp.order.dto.AdminOrderDetailDTO;
import com.jey.webapp.order.dto.OrderDTO;
import com.jey.webapp.order.dto.OrderDetailDTO;
import com.jey.webapp.product.dto.ProductDTO;


public interface OrderService {

	public boolean add(OrderDTO dto, OrderDetailDTO detail) throws Exception;
	public boolean add(OrderDTO dto) throws Exception;
	public boolean addDetail(OrderDetailDTO dto) throws Exception;
	public boolean update(OrderDetailDTO dto) throws Exception;
	public OrderDetailDTO findId(int id) throws Exception;
	public boolean add(int id) throws Exception;	// 리뷰추가 : id 는 product 
	public boolean updateStatus(OrderDTO dto);		// 관리자 주문관리용 
	public List<AdminOrderDTO> findList(OrderDTO dto) throws Exception;
	public List<AdminOrderDetailDTO> findDetailList(OrderDTO dto);
	public List<AdminOrderDTO> findListSelected(OrderDTO dto);
	public List<AdminOrderDetailDTO> findDetailListSelected(OrderDTO dto);

}