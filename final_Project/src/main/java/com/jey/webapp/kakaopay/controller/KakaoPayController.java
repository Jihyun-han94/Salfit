package com.jey.webapp.kakaopay.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.jey.webapp.account.dto.AccountAddressDTO;
import com.jey.webapp.account.dto.AccountDTO;
import com.jey.webapp.account.service.AccountService;
import com.jey.webapp.alert.AlertHandler;
import com.jey.webapp.cart.dto.CartDTO;
import com.jey.webapp.cart.service.CartService;
import com.jey.webapp.order.dto.OrderDTO;
import com.jey.webapp.order.dto.OrderDetailDTO;
import com.jey.webapp.order.service.OrderService;
import com.jey.webapp.product.dto.ProductDTO;
import com.jey.webapp.product.service.ProductService;

@Controller
@RequestMapping(value="/pay")
public class KakaoPayController {
   
   @Autowired
   private CartService cart;
   @Autowired   
   private OrderService order;
   @Autowired   
   private AccountService account;
   @Autowired
   private ProductService product;
   @Autowired
   private AlertHandler alerthandler;
   
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
      
      HttpSession session = request.getSession();
      //계정 정보 확인
      AccountDTO accountdto = (AccountDTO) session.getAttribute("account");
      
      List<AccountAddressDTO> address_arr =account.getList(accountdto.getId());
      
   
      for(int i=0;i<id.length;i++){
       cartNum = Integer.parseInt(id[i]);
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
      m.addAttribute("address_arr", address_arr);
      
      
      String forward  = "kakaopay/payment";
      
      return forward;
   }
   @RequestMapping(value="", method = RequestMethod.POST )
   
   public String getpayment( @ModelAttribute CartDTO dto,@ModelAttribute OrderDTO order_dto,Model m,HttpServletRequest request) throws Exception {
      String forward="kakaopay/paystep1";
      
      
      
      int aid = dto.getAid();
      String receiver = order_dto.getReceiver();
      String address = order_dto.getAddress();
      order_dto.setAddress(address);
      int total = order_dto.getTotal();
      order_dto.setAid(aid);
      

      int cartNum = 0;
      String[] id = request.getParameterValues("cartid");
      for(int i=0;i<id.length;i++){
         cartNum = Integer.parseInt(id[i]);
          dto.setId(cartNum);
          dto = cart.find(dto);
          cart.updateOrderState(dto);
      }
      
       
      List<CartDTO>cartlist = cart.yfindAll(dto); //장바구니에 담은 제품만 조회
      order_dto.setDdate(cart.findDdate(dto));   // 가장 빠른 배송일 
      order_dto.setEdate(cart.findEdate(dto));   // 가장 늦은 배송일
      
      order_dto.setPaytype("KG 이니시스");
      boolean result = order.add(order_dto); //ordered table에 insert
      
      //ordered table 셋팅 
      order_dto = order.selectone(order_dto);
      
      OrderDetailDTO orderdetail_dto = new OrderDetailDTO();
      
      for(CartDTO data:cartlist) {
      
         orderdetail_dto.setOid(order_dto.getId());
         orderdetail_dto.setPid(data.getPid());
         orderdetail_dto.setPrice(data.getPrice());
         orderdetail_dto.setQty(data.getQty());
         orderdetail_dto.setStartdate(data.getStartdate());
         orderdetail_dto.setEnddate(data.getEnddate());
         orderdetail_dto.setDays(data.getDays());
         
         //order_detail table 셋팅
         result = order.addDetail(orderdetail_dto);
      }
         //cart에서 삭제하는 method
         boolean deleteresult = cart.delete(dto);
         
         
         // 주문알림 
         List<WebSocketSession>sList = this.alerthandler.sockList;
         for(WebSocketSession ws: sList) {
            String text = "새로운 주문이 들어왔습니다.";
            TextMessage msg = new TextMessage(text);
            ws.sendMessage(msg);
         }
         
         
         m.addAttribute("ordered", order_dto);
      
      return forward;
   }
   
   @RequestMapping(value="confirm", method = RequestMethod.GET)
   public ModelAndView confirmpayment(Model m, HttpServletRequest request,@ModelAttribute OrderDTO dto) throws Exception {
      
      ModelAndView mv = new ModelAndView();

      HttpSession session = request.getSession();
      //계정 정보 확인
      AccountDTO accountdto = (AccountDTO) session.getAttribute("account");
      
   
      String paymethod = request.getParameter("paymethod");
      System.out.println("paymethod : "+paymethod);
      dto.setPaytype(paymethod);
      //ordered table과 order_detail status 바꿔야됨!!
      dto.setAid(accountdto.getId());
      order.updatestatus(dto); //ordered status 'paid'로 변경
      OrderDetailDTO detailDTO = new OrderDetailDTO();
      detailDTO.setOid(dto.getId());
      order.update(detailDTO); // order_detail status 'paid'로 변경
      
      // 결제 정보 Model m 으로 paystep2.jsp 에 전달하기!!
      dto = order.findorder(dto);
      
      ProductDTO productdto = new ProductDTO();
      //결제 완료시 product bcnt 1 증가
      List<OrderDetailDTO> detail_arr = order.selectall(detailDTO);
      for(OrderDetailDTO data:detail_arr) {
         productdto.setId(data.getPid());
         product.updatebcnt(productdto);
      
      }
      m.addAttribute("paymethod", paymethod);
      m.addAttribute("orderDTO", dto);
      m.addAttribute("username", accountdto.getName());
      mv.setViewName("/kakaopay/paystep2");
      
      return mv;
   }
   
}