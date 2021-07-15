package com.jey.webapp.ajax.controller;


import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jey.webapp.cart.dto.CartDTO;
import com.jey.webapp.cart.service.CartService;

@Controller
@RequestMapping("/ajax/cart")
public class AjaxCartController {
	
	@Autowired
	private CartService cart;
	
	
//commit
	/* 장바구니에 상품 담기 */
	
	@RequestMapping(value = "/add", method = RequestMethod.POST, produces = "application/json; charset=utf-8" )
	@ResponseBody	
	public void addToCart(Model m, @ModelAttribute CartDTO dto, HttpServletResponse resp) throws Exception {
		PrintWriter out = resp.getWriter();
		boolean res = cart.add(dto);
		
		JSONObject json = new JSONObject();			
		json.put("result", res);
			
		out.print(json.toJSONString());
	}
	
	
	
	
	/* 장바구니 아이템 수량 조정 -> update 하나로 통합하고 매개변수에 +/- 정보 넣기 -> 동적 sql 사용  */
	
	@RequestMapping(value = "/changeQty", method = RequestMethod.GET, produces = "application/json; charset=utf-8" )
	@ResponseBody	
	public String plusQty(@ModelAttribute CartDTO dto) throws Exception {
		boolean res = cart.changeQty(dto);
		
		JSONObject json = new JSONObject();			
		json.put("result", res);
		
		return json.toJSONString();
	}
	
	
	/* 장바구니 아이템 삭제 */
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST, produces = "application/json; charset=utf-8" )
	@ResponseBody	
	public String deleteVisit(@RequestParam(value = "chbox[]") List<String> chArr, @ModelAttribute CartDTO dto, HttpServletRequest request) throws Exception {
		
		
		JSONObject json = new JSONObject();		
		int cartNum =0;
		boolean res;
		
		for(String i : chArr) {   
			
			   cartNum = Integer.parseInt(i);
			   dto.setId(cartNum);
			 
			   if(res =cart.remove(dto)) {
				   json.put("result", res);
				   json.put("redirect", request.getContextPath() + "/cart");   
			   }else {
				   json.put("result", "fail");
			   }
		}
		return json.toJSONString();
	}
	

	@RequestMapping(value = "/buy", method = RequestMethod.POST, produces = "application/json; charset=utf-8" )
	@ResponseBody	
	public String buy(@RequestParam(value = "chbox[]") List<String> chArr, @ModelAttribute CartDTO dto, HttpServletRequest request, Model m) throws Exception {
		
	
		JSONObject json = new JSONObject();		
		int cartNum =0;
		List list = null;		
		for(String i : chArr) {   
				
			   cartNum = Integer.parseInt(i);
			   dto.setId(cartNum);
			   list = cart.findAll(dto); // 사려고 하는 리스트 
		}
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(list);
		
		return jsonStr;
	
	}
	@RequestMapping(value = "/sum", method = RequestMethod.POST, produces = "application/json; charset=utf-8" )
	@ResponseBody	
	public String sum(@RequestParam(value = "chbox[]") List<String> chArr, @ModelAttribute CartDTO dto, HttpServletRequest request) throws Exception {
		
	
		JSONObject json = new JSONObject();		
		int cartNum =0;
		List list = null;
		List<CartDTO> cartlist = new ArrayList<CartDTO>();
	    int price =0;
	    List<Integer> price_arr = new ArrayList<Integer>();
	    int sumMoney =0;
	    int totalMoney = 0;
	    int delfee = 0; //배송비
	      
	
		for(String i : chArr){
			   cartNum = Integer.parseInt(i);
		       dto.setId(cartNum);
		       dto = cart.find(dto);
		       cartlist.add(dto);
		       price_arr.add(dto.getMoney());
		      }
		      
		      for(int i : price_arr) {
		         sumMoney =sumMoney + i;
		      }
		      
		      if(sumMoney >=30000) {
		         delfee=0;
		         totalMoney = sumMoney;
		         json.put("totalMoney", totalMoney);
		         json.put("delfee",delfee);
		         
		      }else {
		         delfee = 3000;
		         totalMoney = sumMoney +delfee;
		         json.put("totalMoney",totalMoney);
		         json.put("delfee",delfee);
		      }
		      
		      
		json.put("sumMoney", sumMoney);
		
		
		return json.toJSONString();
	
	}

}