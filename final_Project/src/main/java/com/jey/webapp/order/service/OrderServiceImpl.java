package com.jey.webapp.order.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jey.webapp.order.dto.OrderDTO;
import com.jey.webapp.order.dto.OrderDetailDTO;
import com.jey.webapp.order.dto.ReviewDTO;
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

	@Override //결제 후 status 변경
	public boolean update(OrderDetailDTO dto) throws Exception {
		
		return dao.update(dto);
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

	@Override //결제 후 status 변경
	public boolean add(ReviewDTO dto) throws Exception {
		boolean result = dao.insert(dto);
		return result;
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
	public boolean updatestatus(OrderDTO dto) throws Exception {
		
		return dao.updatestatus(dto);
	}

	@Override
	public OrderDTO findorder(OrderDTO dto) throws Exception {
		dto = dao.findorder(dto);
		return dto;
	}

	@Override
	public boolean updatedel(OrderDTO dto) throws Exception {
		
		return dao.updatedel(dto);
	}

	@Override
	public boolean updatedel(OrderDetailDTO dto) throws Exception {
		
		return dao.updatedel(dto);
	}

	@Override
	public boolean holdorder(OrderDTO dto) throws Exception {
	
		return dao.holdorder(dto);
	}

	@Override
	public boolean holdorder(OrderDetailDTO dto) throws Exception {
		
		return dao.holdorder(dto);
	}

	@Override
	public boolean deleteorder(OrderDTO dto) throws Exception {
		
		return dao.deleteorder(dto);
	}

	@Override
	public boolean deleteorderdetail(OrderDetailDTO dto2) throws Exception {
		
		return dao.deleteorderdetail(dto2);
	}



}