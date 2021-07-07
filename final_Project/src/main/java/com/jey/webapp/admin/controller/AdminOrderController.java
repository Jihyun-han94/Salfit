package com.jey.webapp.admin.controller;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

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
import com.jey.webapp.admin.dto.AdminOrderDTO;
import com.jey.webapp.admin.dto.AdminOrderDetailDTO;
import com.jey.webapp.admin.dto.Criteria;
import com.jey.webapp.admin.dto.PageMaker;
import com.jey.webapp.admin.dto.SummaryDTO;
import com.jey.webapp.admin.service.AdminService;
import com.jey.webapp.product.dto.ProductDTO;
import com.sun.istack.internal.Nullable;

@Controller
@RequestMapping(value = "/admin/order")
public class AdminOrderController {
	
	@Autowired
	private AdminService order;

	/* 주문확인 */
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
	
	
	/* 통계 */
	@RequestMapping(value = "/summary", method = RequestMethod.GET)
	public String summary(Model m,@ModelAttribute ProductDTO dto, SummaryDTO summary, @RequestParam(required=false) String selectedYear) throws Exception{
		Calendar calendar = Calendar.getInstance();
		
		int year = calendar.get(Calendar.YEAR);
		if(selectedYear != null) {
			year = Integer.parseInt(selectedYear);
		} 
		
//		한달동안 매출액, 주문건수, 총 상품 갯수 
		
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
        
        int start; int end; int dates;
        List<Integer> numOfProducts = new ArrayList<>();
        List<Integer> numOforders = new ArrayList<>();
        List<Integer> revenue = new ArrayList<>();
        int numOfdeliveryToday = 0;
        String searchdate = "";
        
        for(int month=0; month < 12; month++,numOfdeliveryToday=0) {
        	calendar.set(year, month, 1);
        	start = calendar.getActualMinimum(Calendar.DAY_OF_MONTH);
        	end = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
        	dates = end - start + 1;
        	
        	summary.setMonth(dateFormat.format(calendar.getTime()));
        	SummaryDTO monthlyOrderSum = order.monthlyOrderSum(summary);
        	numOforders.add(monthlyOrderSum.getNumOfOrders());
        	revenue.add(monthlyOrderSum.getRevenue());
	        
        	for(int i = 0; i < dates; i++,start++) {
	        	calendar.set(year, month, start);
	        	summary.setMonth(dateFormat.format(calendar.getTime()));
	        	numOfdeliveryToday += order.numOfProducts(summary);
	        }
	        numOfProducts.add(numOfdeliveryToday);
        }
        m.addAttribute("numOfProducts",numOfProducts);
        m.addAttribute("numOforders",numOforders);
        m.addAttribute("revenue",revenue);
		
		
//		인기상품
		List<ProductDTO> top5list = null;
		List<String> top5 = new ArrayList<String>();
		List<Integer> top5bcnt = new ArrayList<Integer>();
		
		top5list = order.topselling(dto);
		for(ProductDTO l: top5list) {
			top5.add(l.getTitle()); 
		}
		for(ProductDTO l: top5list) {
			top5bcnt.add(l.getBcnt());
		}
		m.addAttribute("top5list",top5list);
		m.addAttribute("top5",top5);
		m.addAttribute("top5bcnt",top5bcnt);
		
		
		
		
		return "admin/order/chart";
	}
	
}
