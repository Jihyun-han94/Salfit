package com.jey.webapp.admin.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jey.webapp.admin.dto.AdminOrderDTO;
import com.jey.webapp.admin.dto.AdminOrderDetailDTO;
import com.jey.webapp.admin.dto.Criteria;
import com.jey.webapp.admin.dto.SummaryDTO;
import com.jey.webapp.admin.repository.AdminRepository;
import com.jey.webapp.order.dto.ReviewDTO;
import com.jey.webapp.product.dto.ProductDTO;


@Service
public class AdminServiceImpl implements AdminService {


	@Autowired
	private AdminRepository dao;

	
	@Override
	public List<AdminOrderDTO> findList(AdminOrderDTO dto) throws Exception {
		return dao.selectList(dto);
	}
	@Override
	public List<AdminOrderDTO> listPage(Criteria cri) throws Exception {
		return dao.listPage(cri);
	}

	@Override
	public List<AdminOrderDTO> findListSelected(AdminOrderDTO dto) {
		return dao.selectListSelected(dto);
	}
	
	@Override
	public List<AdminOrderDetailDTO> findDetailList(AdminOrderDTO dto) {
		return dao.selectDetailList(dto);
	}

	@Override
	public List<AdminOrderDetailDTO> findDetailList(AdminOrderDetailDTO dto) {
		return dao.selectDetailList(dto);
	}

	@Override
	public boolean updateStatus(AdminOrderDTO dto) {
		return dao.updateStatus(dto);
	}
	
	@Override
	public boolean updateDetailStatus(AdminOrderDetailDTO dto) {
		return dao.updateDetailStatus(dto);
	}


	@Override
	public int getTotalCount(Criteria cri) throws Exception {
		return dao.getTotalCount(cri);
	}

	@Override
	public List<ProductDTO> topselling(ProductDTO dto) {
		return dao.topselling(dto);
	}

	@Override
	public int numOfProducts(SummaryDTO summary) {
		return dao.numOfProducts(summary);
	}

	@Override
	public SummaryDTO monthlyOrderSum(SummaryDTO summary) {
		return dao.monthlyOrderSum(summary);
	}

	@Override
	public List<ReviewDTO> toprating() {
		return dao.toprating();
	}

	@Override
	public boolean findOrderedProduct(ProductDTO dto) {
		return dao.findOrderedProduct(dto);
	}




}