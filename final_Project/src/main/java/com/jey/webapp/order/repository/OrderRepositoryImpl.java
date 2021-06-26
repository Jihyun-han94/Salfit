package com.jey.webapp.order.repository;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jey.webapp.order.dto.OrderDTO;
import com.jey.webapp.order.dto.OrderDetailDTO;
import com.jey.webapp.product.dto.ProductTypeDTO;



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
		List<OrderDTO> data = sqlSession.selectList("orderMapper.orderlist");
		return data;
	}

	@Override
	public boolean insert(OrderDTO dto) throws Exception {
		int seq_order = sqlSession.selectOne("orderMapper.seq_order");
		if(seq_order > 0) {
			dto.setId(seq_order);
			int rs = sqlSession.insert("orderMapper.insertOrder", dto);
			if(rs == 1) {
				return true;
			} else {
				return false;
			}
		} 
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

	@Override
	public boolean updateStatus(OrderDTO dto) {
		boolean result = false;
		int rs = sqlSession.update("orderMapper.updateOrder", dto);		
		if(rs == 1) {
			return true;
		} else {
			return false;
		}
	}

	

}