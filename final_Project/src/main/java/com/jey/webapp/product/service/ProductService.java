package com.jey.webapp.product.service;

import java.util.*;

import com.jey.webapp.order.dto.ReviewDTO;
import com.jey.webapp.product.dto.ProductDTO;
import com.jey.webapp.product.dto.ProductFileDTO;
import com.jey.webapp.product.dto.ProductSearchDTO;
import com.jey.webapp.product.dto.ProductTypeDTO;


public interface ProductService {

	public boolean add(ProductDTO dto) throws Exception;
	public boolean update(ProductDTO dto) throws Exception;
	public boolean remove(ProductDTO dto) throws Exception;
	public ProductDTO findId(int id) throws Exception;
	public List<ProductDTO> findAll(ProductSearchDTO search) throws Exception;
	public List<ProductTypeDTO> getProductTypes() throws Exception;
	public List<ProductDTO> findList(ProductSearchDTO search) throws Exception;
	public List<ReviewDTO> findReviewList(ProductDTO dto) throws Exception;

}