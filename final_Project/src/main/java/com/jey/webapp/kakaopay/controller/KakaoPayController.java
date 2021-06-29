package com.jey.webapp.kakaopay.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jey.webapp.cart.dto.CartDTO;
import com.jey.webapp.cart.service.CartService;
import com.jey.webapp.order.dto.OrderDTO;
import com.jey.webapp.order.dto.OrderDetailDTO;
import com.jey.webapp.order.service.OrderService;

@Controller
@RequestMapping(value="/pay")
public class KakaoPayController {
	
	@Autowired
	private CartService cart;
	@Autowired	
	private OrderService order;

	
	
	@RequestMapping(value="", method = RequestMethod.GET)
	public String payment(Model m, HttpServletRequest request,@ModelAttribute CartDTO dto) throws Exception {
		
		String[] id = request.getParameterValues("id");
		int cartNum = 0;
		List<CartDTO> cartlist = new ArrayList<CartDTO>();
		int price =0;
		List<Integer> price_arr = new ArrayList<Integer>();
		int sumMoney =0;
		int totalMoney = 0;
		int delfee = 0; //배송비
		
		System.out.println("디버그!!!!!!!!");
	
		for(int i=0;i<id.length;i++){
		 System.out.print(id[i]+", ");
		 cartNum = Integer.parseInt(id[i]);
		 dto.setId(cartNum);
		 System.out.println("디버그!!!!!!!!");
		 dto = cart.find(dto);
		 cart.updateOrderState(dto);
		
		 
		 System.out.println("cart.aid"+dto.getAid());
		 System.out.println("cart.pid"+dto.getPid());
		 System.out.println("cart.qty"+dto.getQty());
		 System.out.println("cartdto price"+dto.getPrice());
		 System.out.println("cartdto money"+dto.getMoney());
		 
		 
		 
		 cartlist.add(dto);
		 price_arr.add(dto.getMoney());
		}
		
		for(int i : price_arr) {
			sumMoney =sumMoney + i;
		}
		System.out.println("summoney 디버깅"+sumMoney);
		
		if(sumMoney >=30000) {
			delfee=0;
			totalMoney = sumMoney;
			m.addAttribute("totalMoney", totalMoney);
			m.addAttribute("delfee",delfee);
			
		}else {
			delfee = 3000;
			totalMoney = sumMoney +delfee;
			m.addAttribute("totalMoney",totalMoney);
			m.addAttribute("delfee",delfee);
		}
		
		m.addAttribute("cartlist",cartlist);
		m.addAttribute("sumMoney", sumMoney);
		
		
		
		String forward  = "kakaopay/payment";
		
		
		return forward;
	}
	@RequestMapping(value="", method = RequestMethod.POST )
	
	public String getpayment( @ModelAttribute CartDTO dto,@ModelAttribute OrderDTO order_dto,Model m) throws Exception {
		String forward="kakaopay/paystep1";
		
		int aid = dto.getAid();
		String receiver = order_dto.getReceiver();
		String address = order_dto.getAddress();
		int total = order_dto.getTotal();
		order_dto.setAid(aid);
		
		System.out.println(receiver);
		System.out.println(address);
		System.out.println("주문자 계정 :"+order_dto.getAid());
		System.out.println(total);
		
		List<CartDTO>cartlist = cart.yfindAll(dto); //장바구니에 담은 제품만 조회
		
		boolean result = order.add(order_dto); //ordered table에 insert
		
		//ordered table 조회
		order_dto = order.selectone(order_dto);
		
		System.out.println(result);
		
		OrderDetailDTO orderdetail_dto = new OrderDetailDTO();
			
			
			orderdetail_dto.setOid(order_dto.getId());
		
			for(CartDTO data:cartlist) {
			orderdetail_dto.setPid(data.getPid());
			orderdetail_dto.setPrice(data.getPrice());
			orderdetail_dto.setQty(data.getQty());
			
			System.out.println("productid 디버깅중"+data.getPid());
			result = order.addDetail(orderdetail_dto);
			System.out.println("order_detail insert"+result);
			
			
		}
			m.addAttribute("ordered", order_dto);
		
		
		return forward;
	}
}
