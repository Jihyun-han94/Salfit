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
		System.out.println("aid!!"+dto.getAid());
		List<OrderDTO> orderlist = sqlSession.selectList("orderMapper.selectList", dto);
		
		System.out.println("pdate!!"+orderlist.get(0).getPdate());
		System.out.println("total!!"+orderlist.get(0).getTotal());
		return orderlist;
	}

	@Override
	public boolean insert(OrderDTO dto) throws Exception {
		boolean result = false;
		System.out.println("여기까지 오니?");
		int res = sqlSession.insert("orderMapper.insertordered", dto);
		if(res == 1) {
			result = true;
		}
		
		return result;
	}

	@Override
	public boolean insert(OrderDetailDTO dto) throws Exception {
		boolean result = false;
		int res = sqlSession.insert("orderMapper.insertorderdetail",dto);
		if(res ==1) {
			result = true;
		}
		return result;
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
	public OrderDTO selectone(OrderDTO dto) throws Exception {
		dto = sqlSession.selectOne("orderMapper.selectone",dto);
		return dto;
	}

	@Override
	public List<OrderDetailDTO> selectall(OrderDetailDTO dto) throws Exception {
		List<OrderDetailDTO> list = sqlSession.selectList("orderMapper.selectall", dto);
		return list;
	}

	

}