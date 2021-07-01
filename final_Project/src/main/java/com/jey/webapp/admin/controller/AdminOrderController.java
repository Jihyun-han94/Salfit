package com.jey.webapp.admin.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.jey.webapp.account.dto.AccountDTO;
import com.jey.webapp.order.dto.AdminOrderDTO;
import com.jey.webapp.order.dto.AdminOrderDetailDTO;
import com.jey.webapp.order.dto.Criteria;
import com.jey.webapp.order.dto.OrderDTO;
import com.jey.webapp.order.dto.OrderDetailDTO;
import com.jey.webapp.order.dto.PageMaker;
import com.jey.webapp.order.service.OrderService;

@Controller
@RequestMapping(value = "/admin/order")
public class AdminOrderController {
	
	@Autowired
	private OrderService order;

	/* 주문번호 생성 */
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String createOrder(Model m, @ModelAttribute OrderDTO dto, @ModelAttribute OrderDetailDTO detail, HttpServletRequest request, HttpSession session) throws Exception {
		
		
		// 주문 임의 설정 
		dto.setAid(2);
		dto.setReceiver("김은순");
		dto.setAddress("수원시 영통구 하동 광교호수로 152번길 23");
		dto.setPaytype("카카오페이");
		dto.setTotal(59600);
		dto.setStatus("paid");
		dto.setPdate("2021-06-25");
		dto.setDdate("2021-06-26");
		dto.setEdate("2021-06-27");
		
		// 디테일
		detail.setPid(22);
		detail.setOid(6);
		detail.setQty(2);
//		detail.setPrice(4000);
		detail.setStartdate("2021-06-29");
		detail.setEnddate("2021-06-29");
		detail.setDays(2);
		
		boolean res = order.add(dto, detail);
		
		if(res == true) {
			return "admin/order/list";
		}
		
		return "error/default";
	}
	
	
	/* 주문확인 */
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public void listPageTest() throws Exception{
//		Criteria cri = new Criteria();
//		cri.setPage(1);
//		cri.setPerPageNum(10);
//		List<AdminOrderDTO> boards = order.listPage(cri);
//		for (AdminOrderDTO board : boards) {
//			System.out.println(board.getId()+ ":" + board.getAddress());
//		}		
//		int totalCount = order.getTotalCount(cri);
//		System.out.println("totalCount: "+totalCount);
		
		int page = 6;
		int perPageNum = 10;
		
		UriComponents uriComponets = UriComponentsBuilder.newInstance()
				.path("/{module}/{page}")
				.queryParam("page", page)
				.queryParam("perPageNum", perPageNum)
				.build()
				.expand("admin","order/list")
				.encode();
		
		String uri = "/admin/order/list?page=" + page + "&perPageNum=" + perPageNum;
		
		System.out.println(uri);
		System.out.println(uriComponets.toString());
	}
	
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String manageOrder(@ModelAttribute Criteria cri, Model m, @ModelAttribute AdminOrderDTO dto, HttpServletRequest request, HttpSession session) throws Exception {
		List<AdminOrderDTO> orderlist = null;
		List<AdminOrderDetailDTO> orderdetaillist = null;
		
		System.out.println(cri.getPage() +","+ cri.getPerPageNum() +","+ cri.getId());
		
		
		if (dto.getDdate() == null || dto.getDdate() == "") {
			if (dto.getStatus() == null || dto.getStatus() == "") {
				orderlist = order.listPage(cri);
				orderdetaillist = order.findDetailList(dto);
			} else {
				orderlist = order.findListSelected(dto);
				orderdetaillist = order.findDetailListSelected(dto);
			}
		} else {
			orderlist = order.findListSelected(dto);
			orderdetaillist = order.findDetailListSelected(dto);
		}
		
		
		PageMaker pageMaker = new PageMaker(cri);
		int totalCount = order.getTotalCount(cri);
		pageMaker.setTotalCount(totalCount);

		m.addAttribute("pageMaker", pageMaker);
		m.addAttribute("orderlist",orderlist);
		m.addAttribute("orderdetaillist",orderdetaillist);
		m.addAttribute("dto",dto);
		m.addAttribute("cri", cri);
		return "admin/order/list";
	}
	
	
//	@RequestMapping(value = "/list", method = RequestMethod.GET)
//	public String manageOrder(@ModelAttribute Criteria cri, Model m, @ModelAttribute AdminOrderDTO dto, HttpServletRequest request, HttpSession session) throws Exception {
//		List<AdminOrderDTO> orderlist = null;
//		List<AdminOrderDetailDTO> orderdetaillist = null;
//		System.out.println("ddate : "+dto.getDdate());
//		System.out.println("status : "+dto.getStatus());
//		System.out.println("id : "+dto.getId());
//		System.out.println(cri.getPage() +","+ cri.getPerPageNum());
//		
//		if (dto.getDdate() == null || dto.getDdate() == "") {
//			if (dto.getStatus() == null || dto.getStatus() == "") {
//				orderlist = order.findList(dto);
//				orderdetaillist = order.findDetailList(dto);
//			} else {
//				orderlist = order.findListSelected(dto);
//				orderdetaillist = order.findDetailListSelected(dto);
//			}
//		} else {
//			orderlist = order.findListSelected(dto);
//			orderdetaillist = order.findDetailListSelected(dto);
//		}
//		
//		
//		m.addAttribute("orderlist",orderlist);
//		m.addAttribute("orderdetaillist",orderdetaillist);
//		m.addAttribute("dto",dto);
//		return "admin/order/list";
//	}
	
	
	/* 주문 상태 별  */
	@RequestMapping(value = "/selectStatus", method = RequestMethod.GET)
	public String selectOrderStatus(Model m, @ModelAttribute AdminOrderDTO dto, HttpServletRequest request, HttpSession session) throws Exception {
		
		List<AdminOrderDTO> orderlist = order.findList(dto);
		List<AdminOrderDetailDTO> orderdetaillist = order.findDetailList(dto);
		
		m.addAttribute("orderlist",orderlist);
		m.addAttribute("orderdetaillist",orderdetaillist);
		m.addAttribute("dto",dto);
		return "admin/order/manage";
	}
	
	
	/* 캘린더로 주문관리 */
	@RequestMapping(value = "/calendar", method = RequestMethod.GET)
	public String calendar(Model m, @ModelAttribute AdminOrderDTO dto, @ModelAttribute AdminOrderDetailDTO detail, HttpServletRequest request, HttpSession session) throws Exception {
		List<AdminOrderDTO> orderlist = order.findList(dto);
		List<AdminOrderDetailDTO> orderdetaillist = order.findDetailList(dto);
		
		m.addAttribute("orderlist",orderlist);
		m.addAttribute("orderdetaillist",orderdetaillist);
		return "admin/order/calendar";
	}
	
	
	/* 당일 배송 관리 */
	@RequestMapping(value = "/delivery", method = RequestMethod.GET)
	public String manageDelivery(Model m, @ModelAttribute AdminOrderDetailDTO dto, HttpServletRequest request, HttpSession session) throws Exception {
		
		List<AdminOrderDTO> orderlist = null;
		List<AdminOrderDetailDTO> orderdetaillist = null;
		System.out.println("startdate : "+dto.getStartdate());
		System.out.println("status : "+dto.getStatus());
		
		if (dto.getStartdate() == null || dto.getStartdate() == "") {
			if (dto.getStatus() == null || dto.getStatus() == "") {
				orderlist = order.findList(dto);
				orderdetaillist = order.findDetailList(dto);
			} else {
				orderlist = order.findListSelected(dto);
				orderdetaillist = order.findDetailListSelected(dto);
			}
		} else {
			orderlist = order.findListSelected(dto);
			orderdetaillist = order.findDetailListSelected(dto);
		}
		
		
		m.addAttribute("orderlist",orderlist);
		m.addAttribute("orderdetaillist",orderdetaillist);
		m.addAttribute("dto",dto);
		return "admin/order/delivery";
	}
}
