package com.jey.webapp.admin.repository;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jey.webapp.admin.dto.AdminOrderDTO;
import com.jey.webapp.admin.dto.AdminOrderDetailDTO;
import com.jey.webapp.admin.dto.Criteria;
import com.jey.webapp.admin.dto.SummaryDTO;
import com.jey.webapp.order.dto.ReviewDTO;
import com.jey.webapp.product.dto.ProductDTO;



@Repository
public class AdminRepositoryImpl implements AdminRepository {
	@Autowired
	private SqlSession sqlSession;

	
	@Override
	public List<AdminOrderDTO> selectList(AdminOrderDTO dto) throws Exception {
		List<AdminOrderDTO> data = sqlSession.selectList("adminMapper.orderlist", dto);
		return data;
	}

	@Override
	public List<AdminOrderDetailDTO> selectDetailList(AdminOrderDTO dto) {
		List<AdminOrderDetailDTO> data = sqlSession.selectList("adminMapper.orderdetaillist");
		return data;
	}
	
	@Override
	public List<AdminOrderDTO> selectListSelected(AdminOrderDTO dto) {
		List<AdminOrderDTO> data = sqlSession.selectList("adminMapper.orderlistsel", dto);
		for(AdminOrderDTO d : data) {
			
		}
		return data;
	}

	@Override
	public List<AdminOrderDetailDTO> selectDetailListSelected(AdminOrderDTO dto) {
		List<AdminOrderDetailDTO> data = sqlSession.selectList("adminMapper.orderdetaillistsel", dto);
		return data;
	}
	

	@Override
	public boolean updateStatus(AdminOrderDTO dto) {
		boolean res = false;
		int rs = sqlSession.update("adminMapper.updateOrder", dto);	
		if(rs == 1) {
			if(dto.getStatus().equals("canceled")) {
				int dtrs = sqlSession.update("adminMapper.updateOrderDetails", dto);	
				if(dtrs == 1) {
					res =  true;
					System.out.println("here!");
				} 
			} else {
				res = true;
			}
		} 
		return res;
	}

	@Override
	public List<AdminOrderDTO> selectList(AdminOrderDetailDTO dto) {
		List<AdminOrderDTO> data = sqlSession.selectList("adminMapper.deliverlist");
		return data;
	}

	@Override
	public List<AdminOrderDetailDTO> selectDetailList(AdminOrderDetailDTO dto) {
		List<AdminOrderDetailDTO> data = sqlSession.selectList("adminMapper.deliverdetaillist");
		return data;
	}

	@Override
	public List<AdminOrderDTO> selectListSelected(AdminOrderDetailDTO dto) {
		List<AdminOrderDTO> data = sqlSession.selectList("adminMapper.deliverlistsel", dto);
		return data;
	}

	@Override
	public List<AdminOrderDetailDTO> selectDetailListSelected(AdminOrderDetailDTO dto) {
		List<AdminOrderDetailDTO> data = sqlSession.selectList("adminMapper.deliverdetaillistsel", dto);
		return data;
	}

	@Override
	public boolean updateDetailStatus(AdminOrderDetailDTO dto) {
		int rs = sqlSession.update("adminMapper.updateDelivery", dto);	
		if(rs == 1) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public List<AdminOrderDTO> listPage(Criteria cri) {
		return sqlSession.selectList("adminMapper.listPage", cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		return sqlSession.selectOne("adminMapper.gettotalcount",cri);
	}

	@Override
	public List<ProductDTO> topselling(ProductDTO dto) {
		return sqlSession.selectList("adminMapper.top5products", dto);
	}

	@Override
	public int numOfProducts(SummaryDTO summary) {
		return sqlSession.selectOne("adminMapper.numOfProducts",summary);
	}

	@Override
	public SummaryDTO monthlyOrderSum(SummaryDTO summary) {
		return sqlSession.selectOne("adminMapper.monthlySum",summary);
	}

	@Override
	public List<ReviewDTO> toprating() {
		return sqlSession.selectList("adminMapper.ratingTop5");
	}



	

}