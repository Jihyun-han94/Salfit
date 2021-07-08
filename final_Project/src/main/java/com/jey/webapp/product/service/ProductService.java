package com.jey.webapp.product.service;

import java.util.*;

import com.jey.webapp.admin.dto.PtypeDTO;
import com.jey.webapp.order.dto.ReviewDTO;
import com.jey.webapp.product.dto.LikeDTO;
import com.jey.webapp.product.dto.ProductDTO;
import com.jey.webapp.product.dto.ProductFileDTO;
import com.jey.webapp.product.dto.ProductRecommendDTO;
import com.jey.webapp.product.dto.ProductSearchDTO;
import com.jey.webapp.product.dto.ProductTypeDTO;
import com.jey.webapp.product.dto.ReviewSearchDTO;


public interface ProductService {

	public boolean add(ProductDTO dto) throws Exception;
	public boolean update(ProductDTO dto) throws Exception;
	public boolean remove(ProductDTO dto) throws Exception;
	public ProductDTO findId(int id) throws Exception;
	public List<ProductDTO> findAll(ProductSearchDTO search) throws Exception;
	public List<ProductTypeDTO> getProductTypes() throws Exception;
	public List<ProductDTO> findList(ProductSearchDTO search) throws Exception;
	public List<ReviewDTO> findReviewList(ProductDTO dto) throws Exception;
	public List<ProductRecommendDTO> findSimilarList(ProductDTO dto);
	public List<ReviewDTO> searchOldReviewList(ReviewSearchDTO search);
	public List<ProductDTO> getAllLikePid(int id);
	public boolean dislike(LikeDTO like);
	public boolean like(LikeDTO like);
	public boolean checkLikeExist(LikeDTO like);
	public void incview(int id);
	public List<ProductDTO> searchOldProductList(ProductSearchDTO search);
	public boolean addPtype(ProductTypeDTO dto);
	public boolean deletePtype(ProductTypeDTO dto);
	public boolean updatebcnt(ProductDTO productdto) throws Exception;

}