package com.jey.webapp.order.repository;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jey.webapp.order.dto.AdminOrderDTO;
import com.jey.webapp.order.dto.AdminOrderDetailDTO;
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
	public List<AdminOrderDTO> selectList(OrderDTO dto) throws Exception {
		List<AdminOrderDTO> data = sqlSession.selectList("orderMapper.orderlist");
		return data;
	}

	@Override
	public List<AdminOrderDetailDTO> selectDetailList(OrderDTO dto) {
		List<AdminOrderDetailDTO> data = sqlSession.selectList("orderMapper.orderdetaillist");
		return data;
	}
	
	@Override
	public boolean insert(OrderDTO dto, OrderDetailDTO detail) throws Exception {
		int seq_order = sqlSession.selectOne("orderMapper.seq_order");
		int seq_order_detail = sqlSession.selectOne("orderMapper.seq_order_detail");
		if(seq_order > 0 && seq_order_detail > 0) {
			dto.setId(seq_order);
			detail.setId(seq_order_detail);
			int rs = sqlSession.insert("orderMapper.insertOrder", dto);
			int rsd = sqlSession.insert("orderMapper.insertOrderDetail", detail);
			if(rs == 1 && rsd == 1) {
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