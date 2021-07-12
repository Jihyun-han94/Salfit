package com.jey.webapp.order.repository;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jey.webapp.order.dto.OrderDTO;
import com.jey.webapp.order.dto.OrderDetailDTO;
import com.jey.webapp.order.dto.ReviewDTO;
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
		List<OrderDTO> orderlist = sqlSession.selectList("orderMapper.selectList", dto);
		return orderlist;
	}

	@Override
	public boolean insert(OrderDTO dto) throws Exception {
		boolean result = false;
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
		boolean result = false;
		int res = sqlSession.update("orderMapper.update", dto);
		if(res ==1) {
			result = true;
		}
		return result;
	}

	@Override
	public boolean insert(ReviewDTO dto) throws Exception {
		boolean result = false;
		int res = sqlSession.insert("orderMapper.insertReview",dto);
		if(res ==1) {
			result = true;
		}
		return result;
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

	@Override
	public boolean updatestatus(OrderDTO dto) throws Exception {
		boolean result = false;
		int res = sqlSession.update("orderMapper.updatestatus", dto);
		if (res == 1) {
			result = true;
		}
		return result;
	}

	@Override
	public OrderDTO findorder(OrderDTO dto) throws Exception {
		dto = sqlSession.selectOne("orderMapper.findorder", dto);
		return dto;
	}

	@Override
	public boolean updatedel(OrderDTO dto) throws Exception {
		boolean result = false;
		int res = sqlSession.update("orderMapper.updatedelordered",dto);
		if(res ==1) {
			result = true;
		}
		return result;
	}

	@Override
	public boolean updatedel(OrderDetailDTO dto) throws Exception {
		boolean result = false;
		int res = sqlSession.update("orderMapper.updatedeldetail",dto);
		if(res ==1) {
			result = true;
		}
		return result;
	}

	@Override
	public boolean holdorder(OrderDTO dto) throws Exception {
		boolean result = false;
		int res = sqlSession.update("orderMapper.holdorder", dto);
		if(res ==1) {
			result = true;
		}
		return result;
	}

	@Override
	public boolean holdorder(OrderDetailDTO dto) throws Exception {
		boolean result = false;
		int res = sqlSession.update("orderMapper.holdorderdetail", dto);
		if(res ==1) {
			result = true;
		}
		return result;
	}



	

}