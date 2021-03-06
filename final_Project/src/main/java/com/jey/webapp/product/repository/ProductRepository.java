package com.jey.webapp.product.repository;

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


public interface ProductRepository {
	
	public boolean insert(ProductDTO dto)  throws Exception;
	public boolean update(ProductDTO dto)  throws Exception;
	public boolean delete(ProductDTO dto)  throws Exception;
	public ProductDTO select(ProductDTO dto) throws Exception;
	public List<ProductDTO> selectAll(ProductSearchDTO search) throws Exception;
	public List<ProductDTO> selectList(ProductSearchDTO search)  throws Exception;
	public List<ProductTypeDTO> selectProductTypes() throws Exception;
	public List<ProductRecommendDTO> selectSimilarList(ProductDTO dto);
	public List<ReviewDTO> selectReviewList(ProductDTO dto)  throws Exception;
	public List<ReviewDTO> findOldReviewList(ReviewSearchDTO search);
	public List<ProductDTO> findOldProductList(ProductSearchDTO search);
	public boolean addPtype(ProductTypeDTO dto);
	public boolean deletePtype(ProductTypeDTO dto);
	public List<ProductDTO> selectAllLike(int id);
	public boolean findLike(LikeDTO like);
	public boolean addLike(LikeDTO like);
	public boolean removeLike(LikeDTO like);
	public void updateView(int id);
	public boolean updatebcnt(ProductDTO productdto);
}