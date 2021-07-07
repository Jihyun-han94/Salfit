package com.jey.webapp.admin.repository;

import java.util.*;

import com.jey.webapp.admin.dto.AdminOrderDTO;
import com.jey.webapp.admin.dto.AdminOrderDetailDTO;
import com.jey.webapp.admin.dto.Criteria;
import com.jey.webapp.admin.dto.SummaryDTO;
import com.jey.webapp.product.dto.ProductDTO;


public interface AdminRepository {
	
	public List<AdminOrderDTO> selectList(AdminOrderDTO dto)  throws Exception;
	public List<AdminOrderDetailDTO> selectDetailList(AdminOrderDTO dto);
	public boolean updateStatus(AdminOrderDTO dto);	// 관리자 주문관리용 
	public List<AdminOrderDTO> selectListSelected(AdminOrderDTO dto);
	public List<AdminOrderDetailDTO> selectDetailListSelected(AdminOrderDTO dto);
	public List<AdminOrderDTO> selectList(AdminOrderDetailDTO dto);
	public List<AdminOrderDetailDTO> selectDetailList(AdminOrderDetailDTO dto);
	public List<AdminOrderDTO> selectListSelected(AdminOrderDetailDTO dto);
	public List<AdminOrderDetailDTO> selectDetailListSelected(AdminOrderDetailDTO dto);
	public boolean updateDetailStatus(AdminOrderDetailDTO dto);
	public List<AdminOrderDTO> listPage(Criteria cri);
	public int getTotalCount(Criteria cri);
	public List<ProductDTO> topselling(ProductDTO dto);
	public int numOfProducts(SummaryDTO summary);
	public SummaryDTO monthlyOrderSum(SummaryDTO summary);
	
}