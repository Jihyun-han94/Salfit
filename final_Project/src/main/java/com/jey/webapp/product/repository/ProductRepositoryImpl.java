package com.jey.webapp.product.repository;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jey.webapp.order.dto.ReviewDTO;
import com.jey.webapp.product.dto.LikeDTO;
import com.jey.webapp.product.dto.ProductDTO;
import com.jey.webapp.product.dto.ProductFileDTO;
import com.jey.webapp.product.dto.ProductRecommendDTO;
import com.jey.webapp.product.dto.ProductSearchDTO;
import com.jey.webapp.product.dto.ProductTypeDTO;
import com.jey.webapp.product.dto.ReviewSearchDTO;


@Repository
public class ProductRepositoryImpl implements ProductRepository {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ProductDTO select(ProductDTO dto) throws Exception {
		dto = sqlSession.selectOne("productMapper.selectone", dto);
		return dto;
	}
	
	@Override
	public List<ProductTypeDTO> selectProductTypes() throws Exception {
		List<ProductTypeDTO> data = sqlSession.selectList("productMapper.producttypes");
		return data;
	}
	
	@Override
	public List<ProductDTO> selectAll(ProductSearchDTO search) throws Exception {
		List<ProductDTO> data = sqlSession.selectList("productMapper.all", search);
		return data;
	}

	@Override
	public List<ProductDTO> selectList(ProductSearchDTO search) throws Exception {
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
			rs = sqlSession.insert("productMapper.insertProduct", dto);
			if(rs == 1) {
				rs = sqlSession.update("productMapper.productCLOB", dto);
				if(rs == 1) {
					System.out.println("CLOB 저장 완료!");
					int seq_img = sqlSession.selectOne("productMapper.seq_img");
					if(seq_img > 0) {
						dto.setImgid(seq_img);
						rs = sqlSession.insert("productMapper.fileInsert", dto);
						if(rs == 1) {
							System.out.println("이미지 저장 완료");
							result = true;
						}
					}
				}
			}
		}
		return result;
	}

	@Override
	public boolean update(ProductDTO dto) throws Exception {
		boolean result = false;
		int rs = sqlSession.update("productMapper.updateProduct", dto);		
		if(rs == 1) {
			rs = sqlSession.update("productMapper.updateImage", dto);
			if(rs == 1) {
				result = true;
			}
		}
		return result;
	}

	@Override
	public boolean delete(ProductDTO dto) throws Exception {
		boolean res = false;
		int rs = sqlSession.delete("productMapper.deleteProduct", dto);	
		if(rs == 1) {
			res = true;
		}
		return res;
	}

	@Override
	public List<ReviewDTO> selectReviewList(ProductDTO dto) throws Exception {
		List<ReviewDTO> data = sqlSession.selectList("productMapper.productReviews", dto);
		return data;
	}

	@Override
	public List<ProductRecommendDTO> selectSimilarList(ProductDTO dto) {
		List<ProductRecommendDTO> data = sqlSession.selectList("productMapper.similarProduct", dto);
		return data;
	}

	@Override
	public List<ReviewDTO> findOldReviewList(ReviewSearchDTO search) {
		List<ReviewDTO> data = sqlSession.selectList("productMapper.oldReviews", search);
		return data;
	}

	@Override
	public List<ProductDTO> selectAllLike(int id) {
		List<ProductDTO> data = sqlSession.selectList("productMapper.likedProduct", id);
		return data;
	}


	@Override
	public void removeLike(LikeDTO like) {
		sqlSession.delete("productMapper.degradeLike", like);		
		sqlSession.update("productMapper.minusGcnt", like);
	}


	@Override
	public void addLike(LikeDTO like) {
		int likedseq = sqlSession.selectOne("productMapper.likedseq");
		if(likedseq > 0) {
			like.setId(likedseq);
			sqlSession.insert("productMapper.upgradeLike", like);		
			sqlSession.update("productMapper.plusGcnt", like);
		}
	}

}