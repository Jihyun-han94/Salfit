package com.jey.webapp.product.repository;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jey.webapp.order.dto.ReviewDTO;
import com.jey.webapp.product.dto.ProductDTO;
import com.jey.webapp.product.dto.ProductSearchDTO;
import com.jey.webapp.product.dto.ProductTypeDTO;


@Repository
public class ProductRepositoryImpl implements ProductRepository {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ProductDTO select(ProductDTO dto) throws Exception {
		ProductDTO data = sqlSession.selectOne("productMapper.selectone", dto);
		return data;
	}
	
	@Override
	public List<ProductTypeDTO> selectProductTypes() throws Exception {
		List<ProductTypeDTO> data = sqlSession.selectList("productMapper.producttypes");
		return data;
	}
	
	@Override
	public List<ProductDTO> selectAll() throws Exception {
		List<ProductDTO> data = sqlSession.selectList("productMapper.all");
		return data;
	}

	@Override
	public List<ProductDTO> selectList(ProductSearchDTO search) throws Exception {
//		System.out.println("getptype : " + search.getPtype());
//		System.out.println("getSearch : " + search.getSearch());
		List<ProductDTO> data = sqlSession.selectList("productMapper.productSearch", search);
		return data;
	}

	@Override
	public boolean insert(ProductDTO dto) throws Exception {
		boolean result = false;
		int rs = 0;
		int seq = sqlSession.selectOne("productMapper.seq");
		if(seq > 0) {
			dto.setId(seq);
			rs = sqlSession.insert("productMapper.productInsert", dto);
			if(rs == 1) {
				rs = sqlSession.update("productMapper.productCLOB", dto);
				if(rs == 1) {
					System.out.println("CLOB 저장 완료!");
					result = true;
				}
			}
		}
		return result;
	}

	@Override
	public boolean update(ProductDTO dto) throws Exception {
		boolean result = false;
		int rs = sqlSession.update("productMapper.productUpdate", dto);		
		if(rs == 1) {
			result = true;
		}
		return result;
	}

	@Override
	public boolean delete(ProductDTO dto) throws Exception {
		return false;
	}

	@Override
	public List<ReviewDTO> selectReviewList(ProductDTO dto) throws Exception {
		return null;
	}

}