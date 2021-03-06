package com.jey.webapp.account.controller;


import java.awt.image.BufferedImage;
import java.io.File;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.io.FilenameUtils;
import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jey.webapp.account.dto.AccountAddressDTO;
import com.jey.webapp.account.dto.AccountDTO;
import com.jey.webapp.account.service.AccountService;
import com.jey.webapp.product.dto.ProductDTO;
import com.jey.webapp.product.dto.ProductSearchDTO;
import com.jey.webapp.product.service.ProductService;

@Controller
@RequestMapping(value = "/account")
public class AccountController {
	
	@Autowired
	private AccountService account;
	@Autowired
	private ProductService product;
	
	/* 회원가입 */
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join() throws Exception {
		return "account/join";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String userJoin(Model m, @ModelAttribute AccountDTO dto) throws Exception {
		boolean res = account.join(dto);
		if(res) {
			m.addAttribute("dto",dto);
			return "account/login";
		} else {
			m.addAttribute("error","회원가입 실패!");
			return "account/join";
		}
	}
	
	/* 로그인 */
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String googleLogin(HttpServletRequest request, Model m) {
		HttpSession session = request.getSession();
		if(session.getAttribute("logined") != null) { 
			session.invalidate();
		}
		return "account/login";
	}
	
	// 일반회원 로그인 
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String userLogin(Model m, @ModelAttribute AccountDTO dto, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String forward = "";
		String next = "/";
		if(dto.getNext() != null && !dto.getNext().equals("null")) {
			next = dto.getNext();
		}
		dto = account.login(dto);
		if(dto != null && dto.getId() > 0) {
			HttpSession session = request.getSession();
			//session.setMaxInactiveInterval(60*60);
			
			session.setAttribute("account", dto);
			session.setAttribute("logined", true);
			System.out.println(dto.getAtype());
			session.setAttribute("atype", dto.getAtype());
			m.addAttribute("dto",dto);

			if(dto.getAtype().equals("a")) {
				forward = "redirect:/";
			} else {
					forward = "redirect:"+next;
			}
		} else {
			m.addAttribute("error", "아이디 또는 비밀번호를 다시 입력하세요.");
			if(!next.equals("/")) {
				forward = "redirect:/account/login?next=" + next; 
			} else {
				forward = "redirect:/account/login";
			}
		}
		return forward;
	}
	

	  
	// 구글 login
	@RequestMapping(value = "/google_login", method = RequestMethod.POST )
	public String googlelogin(Model m, @ModelAttribute AccountDTO dto, HttpServletRequest request, HttpServletResponse response) throws Exception {
	  	String forward = "";
		String next = "/";
		if(dto.getNext() != null && !dto.getNext().equals("null")) {
			next = dto.getNext();
		}
		
		boolean res = account.checkEmail(dto.getEmail());
		
		if(!res) {
			// 회원가입
		dto.setPhone("000-0000-0000");
		dto.setAtype("g");
			account.join(dto);
		}
		
		dto = account.login(dto);
		
		dto.setPhone("");
		dto.setAtype("g");
		dto.setId(dto.getId());
		HttpSession session = request.getSession();
		// session.setMaxInactiveInterval(60*60);
		
		session.setAttribute("account", dto);
		session.setAttribute("logined", true);
		session.setAttribute("atype", dto.getAtype());
		m.addAttribute("dto",dto);
		
		forward = "redirect:"+next;
		return forward;
	
	}
	
	/* 로그아웃 */
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/";
	}
	
	/* 회원정보 수정 */
	
	@RequestMapping(value = "/update_view", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView modify(HttpServletRequest req, HttpSession session,
			Model m, AccountAddressDTO addressDTO) throws Exception {
		
		
		ModelAndView mv = new ModelAndView("account/update");
		session = req.getSession();
		AccountDTO dto = (AccountDTO) session.getAttribute("account");
		String pass = req.getParameter("password");
		dto.setPassword(pass);
		
		dto = account.login(dto);
		if(dto.getId() == -1) {
			mv.setViewName("redirect:/");
			return mv;
		}
		
		mv.addObject("account", dto);
		
		int userid = dto.getId();
		addressDTO.setAid(userid);
		
		// 주소 목록 띄우기
		List<AccountAddressDTO> addressList = account.getList(addressDTO.getAid());
		mv.addObject("addressList", addressList);
	
		return mv;
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String modify(HttpServletRequest request, Model m, HttpSession session) throws Exception {
		AccountDTO dto = (AccountDTO) session.getAttribute("account");
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String phone = request.getParameter("phone");
		dto.setName(name);
		dto.setPassword(password);
		dto.setPhone(phone);
		m.addAttribute("account", account.updateProfile(dto));
		return "redirect:/";
	}
	
	/* 프로필 사진 추가 */
	@RequestMapping(value = "/profile_update", method = RequestMethod.POST)
	public String profile_modify(@RequestParam MultipartFile file,
			HttpServletRequest req, Model m, HttpSession session, AccountAddressDTO addressDTO) throws Exception {
		// 1. 사용자가 업로드한 이미지를 추출한다. --> file 자체로 추출 함 (하나기 때문)
		
		// 2. 추출한 이미지를 특정 경로(설정)에 이미지파일로 저장한다.
		String origin_name = file.getOriginalFilename();
		String root = req.getServletContext().getRealPath("/");
//		FileUpload fileupload = new FileUpload(root, "/resources/file/");
		File save_path = new File(root, "/resources/file/");
		if(!save_path.exists()) {
			Files.createDirectories(save_path.toPath());
		} file.transferTo(new File(save_path + "/" + origin_name));
		// 3. 저장된 이미지를 불러온다.
		File f = new File(root = (save_path + "/" + origin_name));
		BufferedImage src_img = ImageIO.read(f);
		// 4. 불러온 이미지의 크기를 조정한다.
		BufferedImage thumbnail = Scalr.resize(src_img, Scalr.Mode.FIT_EXACT, 200, 200);
		// 5. 조정된 이미지를 저장한다.
		String thumbnail_name = "thumb_" + f.getName();
		File tf = new File(save_path + "/" + thumbnail_name);
		ImageIO.write(thumbnail, "png", tf);
		String thumbnail_path = "/file/" + thumbnail_name;
		// 6. 이미지 저장된 경로를 DB에 저장한다.
		AccountDTO dto = (AccountDTO) session.getAttribute("account");
		dto.setProfile_img(thumbnail_path);
		account.saveImage(dto);
		m.addAttribute("account", dto);
		int userid = dto.getId();
		addressDTO.setAid(userid);
		List<AccountAddressDTO> addressList = account.getList(addressDTO.getAid());
		m.addAttribute("addressList", addressList);
		return "account/update";
	}
	
	/* 회원탈퇴 */
	@RequestMapping(value = "/signout", method = RequestMethod.POST)
	public String signout(Model m, AccountDTO dto, HttpSession session, HttpServletRequest req) throws Exception {
		AccountDTO accountDTO = (AccountDTO) session.getAttribute("account");
		// String sessionPass = accountDTO.getPassword();
		String dtoPass = dto.getPassword();
		String pass = req.getParameter("password");
		if(!(dtoPass.equals(pass))) {
			m.addAttribute("error", "회원탈퇴 실패");
			return "redirect:/account/update_view";
		}
		account.signout(dto);
		m.addAttribute("dto",dto);
		session.invalidate();
		return "redirect:/";
	}
	
	
	/* 찜목록 */
	@RequestMapping(value = "/liked", method = RequestMethod.GET)
	public ModelAndView liked(@ModelAttribute ProductSearchDTO search, AccountDTO account, HttpServletRequest request, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("account/liked");
		List<ProductDTO> likedProduct = null;
		List<Integer> liked = new ArrayList<Integer>();
		
		if(session.getAttribute("logined") != null && (boolean)session.getAttribute("logined")) {
			if(session.getAttribute("account") != null) {
				account = (AccountDTO) session.getAttribute("account");

				search.setAid(account.getId());  
				likedProduct = product.getAllLikePid(account.getId()); 
				liked = new ArrayList<Integer>();
				for(ProductDTO lk : likedProduct) {
					liked.add(lk.getId());
				}
			}
		}
		mv.addObject("liked", liked);
		mv.addObject("likedProduct", likedProduct);
		return mv;
	}
	
	
}
