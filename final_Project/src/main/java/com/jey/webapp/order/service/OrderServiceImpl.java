package com.jey.webapp.order.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jey.webapp.order.dto.AdminOrderDTO;
import com.jey.webapp.order.dto.AdminOrderDetailDTO;
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
	public boolean addDetail(OrderDetailDTO dto) throws Exception {
		return false;
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
	public List<AdminOrderDTO> findList(OrderDTO dto) throws Exception {
		return dao.selectList(dto);
	}

	@Override
	public boolean add(int id) throws Exception {
		return false;
	}

	@Override
	public boolean updateState(OrderDTO dto) {
		return dao.updateStatus(dto);
	}

	@Override
	public List<AdminOrderDetailDTO> findDetailList(OrderDTO dto) {
		return dao.selectDetailList(dto);
	}




}