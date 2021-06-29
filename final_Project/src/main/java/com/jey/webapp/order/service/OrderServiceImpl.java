package com.jey.webapp.order.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jey.webapp.order.dto.OrderDTO;
import com.jey.webapp.order.dto.OrderDetailDTO;
import com.jey.webapp.order.repository.OrderRepository;



@Service
public class OrderServiceImpl implements OrderService {


	@Autowired
	private OrderRepository dao;

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
		return null;
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




}