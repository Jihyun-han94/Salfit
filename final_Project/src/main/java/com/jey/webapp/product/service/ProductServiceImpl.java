package com.jey.webapp.product.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jey.webapp.order.dto.ReviewDTO;
import com.jey.webapp.product.dto.LikeDTO;
import com.jey.webapp.product.dto.ProductDTO;
import com.jey.webapp.product.dto.ProductFileDTO;
import com.jey.webapp.product.dto.ProductRecommendDTO;
import com.jey.webapp.product.dto.ProductSearchDTO;
import com.jey.webapp.product.dto.ProductTypeDTO;
import com.jey.webapp.product.dto.ReviewSearchDTO;
import com.jey.webapp.product.repository.ProductRepository;


@Service
public class ProductServiceImpl implements ProductService {


	@Autowired
	private ProductRepository dao;


	@Override
	public boolean add(ProductDTO dto) throws Exception {
		boolean res = dao.insert(dto);
		return res;
	}

	@Override
	public boolean update(ProductDTO dto) throws Exception {
		boolean res = dao.update(dto);
		return res;
	}

	@Override
	public boolean remove(ProductDTO dto) throws Exception {
		return dao.delete(dto);
	}
	
	@Override
	public ProductDTO findId(int id) throws Exception {
		ProductDTO data = new ProductDTO();
		data.setId(id);
		return dao.select(data);
	}
	
	
	@Override
	public List<ProductDTO> findAll(ProductSearchDTO search) throws Exception {
		List<ProductDTO> data = dao.selectAll(search);
		return data;
	}

	@Override
	public List<ProductTypeDTO> getProductTypes() throws Exception {
		List<ProductTypeDTO> data = dao.selectProductTypes();
		return data;
	}

	@Override
	public List<ProductDTO> findList(ProductSearchDTO search) throws Exception {
		List<ProductDTO> data = dao.selectList(search);
		return data;
	}


	@Override
	public List<ReviewDTO> findReviewList(ProductDTO dto) throws Exception {
		return dao.selectReviewList(dto);
	}

	@Override
	public List<ProductRecommendDTO> findSimilarList(ProductDTO dto) {
		return dao.selectSimilarList(dto);
	}

	@Override
	public List<ReviewDTO> searchOldReviewList(ReviewSearchDTO search) {
		return dao.findOldReviewList(search);
	}

	@Override
	public List<ProductDTO> getAllLikePid(int id) {
		return dao.selectAllLike(id);
	}

	@Override
	public void dislike(LikeDTO like) {
		dao.removeLike(like);
	}

	@Override
	public void like(LikeDTO like) {
		dao.addLike(like);
	}

	@Override
	public boolean checkLikeExist(LikeDTO like) {
		return dao.findLike(like);
	}


}