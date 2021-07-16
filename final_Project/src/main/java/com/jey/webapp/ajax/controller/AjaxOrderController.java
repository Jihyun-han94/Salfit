package com.jey.webapp.ajax.controller;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jey.webapp.cart.dto.CartDTO;
import com.jey.webapp.order.dto.OrderDTO;
import com.jey.webapp.order.dto.OrderDetailDTO;
import com.jey.webapp.order.service.OrderService;

@Controller
@RequestMapping("/ajax/order")
public class AjaxOrderController {

   @Autowired
   private OrderService order;
   
   
   /* ordered, order_detail status delivered로 변경*/
   @RequestMapping(value = "/update", method = RequestMethod.POST, produces = "application/json; charset=utf-8" )
   @ResponseBody
   public String updatestatus(@ModelAttribute OrderDTO dto, HttpServletResponse resp) throws Exception {
      
      JSONObject json = new JSONObject();         
     
      
      dto = order.selectedate(dto);
      String edate = dto.getEdate();
      String[] array = edate.split("-");
      String edate2 = array[0]+array[1]+array[2];
      int edate_int = Integer.parseInt(edate2);
      
      String pattern = "yyyyMMdd";
      SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
      String date = simpleDateFormat.format(new Date());
      System.out.println(date);
      int today = Integer.parseInt(date);
      
      if(today>=edate_int) {
    	  order.updatedel(dto);
    	  OrderDetailDTO dto2 = new OrderDetailDTO();
    	  dto2.setOid(dto.getId());
    	  order.updatedel(dto2);
    	 
    	  json.put("result", "배송완료 확정되었습니다.");    	  
      }else {
    	  json.put("result", "마지막 구독 종료일에 배송 확정 가능합니다.");
      }
      
  
         
      return json.toJSONString();
   }
   
   @RequestMapping(value = "/hold", method = RequestMethod.POST, produces = "application/json; charset=utf-8" )
   @ResponseBody
   public String holdorder(@ModelAttribute OrderDTO dto, HttpServletResponse resp) throws Exception {
      
      JSONObject json = new JSONObject();         
      
      dto = order.selectedate(dto);
      String ddate = dto.getDdate();
      String[] array = ddate.split("-");
      String ddate2 = array[0]+array[1]+array[2];
      int ddate_int = Integer.parseInt(ddate2);
      
      String pattern = "yyyyMMdd";
      SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
      String date = simpleDateFormat.format(new Date());
      System.out.println(date);
      int today = Integer.parseInt(date);
      //ordered, order_detail status holding으로 바꾸기
      if(today<ddate_int) {
    	  order.holdorder(dto);
    	  OrderDetailDTO dto2 = new OrderDetailDTO();
    	  dto2.setOid(dto.getId());
    	  order.holdorder(dto2);
    	  json.put("result", "주문취소 요청 완료했습니다.");
    	  json.put("res", "취소 요청 중");
    	  
      }else {
    	  json.put("result", "주문취소는 불가합니다.");
    	  json.put("res", "취소불가");
      }
      
      
         
      return json.toJSONString();
   }
   
   @RequestMapping(value = "/delete", method = RequestMethod.POST, produces = "application/json; charset=utf-8" )
   @ResponseBody
   public String deleteorder(@ModelAttribute OrderDTO dto, HttpServletResponse resp,HttpServletRequest request) throws Exception {
      
      JSONObject json = new JSONObject();         
      
      //ordered, order_detail 에서 주문 삭제 
      OrderDetailDTO dto2 = new OrderDetailDTO();      
      dto2.setOid(dto.getId());
      order.deleteorderdetail(dto2);
      order.deleteorder(dto);
      json.put("result", "주문이 삭제되었습니다.");
      json.put("redirect", request.getContextPath() + "/order");
         
      return json.toJSONString();
   }
   
   
}