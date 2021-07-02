package com.jey.webapp.order.repository;

import java.util.*;

import com.jey.webapp.order.dto.AdminOrderDTO;
import com.jey.webapp.order.dto.AdminOrderDetailDTO;
import com.jey.webapp.order.dto.Criteria;
import com.jey.webapp.order.dto.OrderDTO;
import com.jey.webapp.order.dto.OrderDetailDTO;


public interface OrderRepository {
	
	public OrderDetailDTO select(OrderDTO dto) throws Exception;
	public OrderDTO selectone(OrderDTO dto) throws Exception;
	public List<AdminOrderDTO> selectList(AdminOrderDTO dto)  throws Exception;
	public List<AdminOrderDetailDTO> selectDetailList(AdminOrderDTO dto);
	public boolean insert(OrderDTO dto, OrderDetailDTO detail)  throws Exception;
	public boolean insert(OrderDTO dto)  throws Exception;
	public boolean insert(OrderDetailDTO dto)  throws Exception;
	public boolean update(OrderDetailDTO dto)  throws Exception;
	public boolean insert(int id)  throws Exception;	// 리뷰추가용
	public List<OrderDetailDTO> selectall(OrderDetailDTO dto) throws Exception;
	public boolean updateStatus(AdminOrderDTO dto);	// 관리자 주문관리용 
	public List<AdminOrderDTO> selectListSelected(AdminOrderDTO dto);
	public List<AdminOrderDetailDTO> selectDetailListSelected(AdminOrderDTO dto);
	public List<AdminOrderDTO> selectList(AdminOrderDetailDTO dto);
	public List<AdminOrderDetailDTO> selectDetailList(AdminOrderDetailDTO dto);
	public List<AdminOrderDTO> selectListSelected(AdminOrderDetailDTO dto);
	public List<AdminOrderDetailDTO> selectDetailListSelected(AdminOrderDetailDTO dto);
	public boolean updateDetailStatus(AdminOrderDetailDTO dto);
	public List<AdminOrderDTO> listPage(Criteria cri);
	public int getTotalCount(Criteria cri);
	
}