package com.jey.webapp.admin.service;

import java.util.*;

import com.jey.webapp.admin.dto.AdminOrderDTO;
import com.jey.webapp.admin.dto.AdminOrderDetailDTO;
import com.jey.webapp.admin.dto.Criteria;
import com.jey.webapp.admin.dto.SummaryDTO;
import com.jey.webapp.order.dto.ReviewDTO;
import com.jey.webapp.product.dto.ProductDTO;



public interface AdminService {

	public boolean updateStatus(AdminOrderDTO dto);		// 관리자 주문관리용 
	public List<AdminOrderDTO> findList(AdminOrderDTO dto) throws Exception;
	public List<AdminOrderDetailDTO> findDetailList(AdminOrderDTO dto);
	public List<AdminOrderDTO> findListSelected(AdminOrderDTO dto);
	public List<AdminOrderDetailDTO> findDetailListSelected(AdminOrderDTO dto);
	public List<AdminOrderDTO> findList(AdminOrderDetailDTO dto);
	public List<AdminOrderDetailDTO> findDetailList(AdminOrderDetailDTO dto);
	public List<AdminOrderDTO> findListSelected(AdminOrderDetailDTO dto);
	public List<AdminOrderDetailDTO> findDetailListSelected(AdminOrderDetailDTO dto);
	public boolean updateDetailStatus(AdminOrderDetailDTO dto);
	public List<AdminOrderDTO> listPage(Criteria cri) throws Exception;
	public int getTotalCount(Criteria cri) throws Exception;
	public List<ProductDTO> topselling(ProductDTO dto);
	public int numOfProducts(SummaryDTO summary);
	public SummaryDTO monthlyOrderSum(SummaryDTO summary);
	public List<ReviewDTO> toprating();
	public boolean findOrderedProduct(ProductDTO dto);
}