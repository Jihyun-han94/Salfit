package com.jey.webapp.order.repository;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jey.webapp.order.dto.OrderDTO;
import com.jey.webapp.order.dto.OrderDetailDTO;



@Repository
public class OrderRepositoryImpl implements OrderRepository {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public OrderDetailDTO select(OrderDTO dto) throws Exception {
		return null;
	}

	@Override
	public List<OrderDTO> selectList(OrderDTO dto) throws Exception {
		return null;
	}

	@Override
	public boolean insert(OrderDTO dto) throws Exception {
		return false;
	}

	@Override
	public boolean insert(OrderDetailDTO dto) throws Exception {
		return false;
	}

	@Override
	public boolean update(OrderDetailDTO dto) throws Exception {
		return false;
	}

	@Override
	public boolean insert(int id) throws Exception {
		return false;
	}

	

}