package com.jey.webapp.product.repository;

import java.util.*;

import com.jey.webapp.order.dto.ReviewDTO;
import com.jey.webapp.product.dto.ProductDTO;
import com.jey.webapp.product.dto.ProductFileDTO;
import com.jey.webapp.product.dto.ProductSearchDTO;
import com.jey.webapp.product.dto.ProductTypeDTO;


public interface ProductRepository {
	
	public ProductDTO select(ProductDTO dto) throws Exception;
	public List<ProductDTO> selectAll(ProductSearchDTO search) throws Exception;
	public List<ProductDTO> selectList(ProductSearchDTO search)  throws Exception;
	public List<ProductTypeDTO> selectProductTypes() throws Exception;
	public List<ReviewDTO> selectReviewList(ProductDTO dto)  throws Exception;
	public boolean insert(ProductDTO dto)  throws Exception;
	public boolean update(ProductDTO dto)  throws Exception;
	public boolean delete(ProductDTO dto)  throws Exception;
}