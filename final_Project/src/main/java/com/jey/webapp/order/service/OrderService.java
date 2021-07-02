package com.jey.webapp.order.service;

import java.util.*;

import com.jey.webapp.order.dto.AdminOrderDTO;
import com.jey.webapp.order.dto.AdminOrderDetailDTO;
import com.jey.webapp.order.dto.Criteria;
import com.jey.webapp.order.dto.OrderDTO;
import com.jey.webapp.order.dto.OrderDetailDTO;
import com.jey.webapp.product.dto.ProductDTO;


public interface OrderService {

	public boolean add(OrderDTO dto, OrderDetailDTO detail) throws Exception;
	public boolean add(OrderDTO dto) throws Exception;
	public boolean addDetail(OrderDetailDTO dto) throws Exception;
	public boolean update(OrderDetailDTO dto) throws Exception;
	public OrderDetailDTO findId(int id) throws Exception;
	public OrderDTO selectone(OrderDTO dto) throws Exception;
	public List<OrderDetailDTO> selectall(OrderDetailDTO dto) throws Exception;
	public List<OrderDTO> findList(OrderDTO dto) throws Exception; //주문 내역 전체 조회
	public boolean add(int id) throws Exception;	// 리뷰추가 : id 는 product 
	public boolean updateStatus(AdminOrderDTO dto);		// 관리자 주문관리용 
	public List<AdminOrderDTO> findList(AdminOrderDTO dto) throws Exception;
	public List<AdminOrderDetailDTO> findDetailList(AdminOrderDTO dto);
	public List<AdminOrderDTO> findListSelected(AdminOrderDTO dto);
	public List<AdminOrderDetailDTO> findDetailListSelected(AdminOrderDTO dto);
	public List<AdminOrderDTO> findList(AdminOrderDetailDTO dto);
	public List<AdminOrderDetailDTO> findDetailList(AdminOrderDetailDTO dto);
	public List<AdminOrderDTO> findListSelected(AdminOrderDetailDTO dto);
	public List<AdminOrderDetailDTO> findDetailListSelected(AdminOrderDetailDTO dto);
	public boolean updateDetailStatus(AdminOrderDetailDTO dto);
	public List<AdminOrderDTO> listPage(Criteria cri) throws Exception;
	public int getTotalCount(Criteria cri) throws Exception;
}