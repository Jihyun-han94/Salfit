package com.jey.webapp.order.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jey.webapp.order.dto.AdminOrderDTO;
import com.jey.webapp.order.dto.AdminOrderDetailDTO;
import com.jey.webapp.order.dto.Criteria;
import com.jey.webapp.order.dto.OrderDTO;
import com.jey.webapp.order.dto.OrderDetailDTO;
import com.jey.webapp.order.repository.OrderRepository;



@Service
public class OrderServiceImpl implements OrderService {


	@Autowired
	private OrderRepository dao;

	@Override
	public boolean add(OrderDTO dto, OrderDetailDTO detail) throws Exception {
		return dao.insert(dto, detail);
	}
	
	@Override
	public boolean add(OrderDTO dto) throws Exception {
		System.out.println("serviceimpl까지 왓음");
		return dao.insert(dto);
	}
	
	@Override
	public boolean addDetail(OrderDetailDTO dto) throws Exception {
		System.out.println("orderdetail service까지 왔음");
		return dao.insert(dto);
	}

	@Override
	public boolean update(OrderDetailDTO dto) throws Exception {
		return false;
	}

	@Override
	public OrderDetailDTO findId(int id) throws Exception {
		return null;
	}


	@Override
	public List<OrderDTO> findList(OrderDTO dto) throws Exception {
		List<OrderDTO> orderlist = dao.selectList(dto);
		return orderlist;
	}

	@Override
	public boolean add(int id) throws Exception {
		return false;
	}

	@Override
	public OrderDTO selectone(OrderDTO dto) throws Exception{
		dto = dao.selectone(dto);
		return dto;
	}

	@Override
	public List<OrderDetailDTO> selectall(OrderDetailDTO dto) throws Exception {
		List<OrderDetailDTO> list = dao.selectall(dto);
		return list;
	}


	@Override
	public boolean updateStatus(AdminOrderDTO dto) {
		return dao.updateStatus(dto);
	}
	
	@Override
	public List<AdminOrderDTO> findList(AdminOrderDTO dto) throws Exception {
		return dao.selectList(dto);
	}

	@Override
	public List<AdminOrderDetailDTO> findDetailList(AdminOrderDTO dto) {
		return dao.selectDetailList(dto);
	}

	@Override
	public List<AdminOrderDTO> findListSelected(AdminOrderDTO dto) {
		return dao.selectListSelected(dto);
	}

	@Override
	public List<AdminOrderDetailDTO> findDetailListSelected(AdminOrderDTO dto) {
		return dao.selectDetailListSelected(dto);
	}

	@Override
	public List<AdminOrderDTO> findList(AdminOrderDetailDTO dto) {
		return dao.selectList(dto);
	}

	@Override
	public List<AdminOrderDetailDTO> findDetailList(AdminOrderDetailDTO dto) {
		return dao.selectDetailList(dto);
	}

	@Override
	public List<AdminOrderDTO> findListSelected(AdminOrderDetailDTO dto) {
		return dao.selectListSelected(dto);
	}

	@Override
	public List<AdminOrderDetailDTO> findDetailListSelected(AdminOrderDetailDTO dto) {
		return dao.selectDetailListSelected(dto);
	}

	@Override
	public boolean updateDetailStatus(AdminOrderDetailDTO dto) {
		return dao.updateDetailStatus(dto);
	}

	@Override
	public List<AdminOrderDTO> listPage(Criteria cri) throws Exception {
		return dao.listPage(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) throws Exception {
		return dao.getTotalCount(cri);
	}




}