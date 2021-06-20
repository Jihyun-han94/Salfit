//package com.jey.webapp.filter;
//
//import java.io.IOException;
//import java.util.Arrays;
//import java.util.List;
//
//import javax.servlet.Filter;
//import javax.servlet.FilterChain;
//import javax.servlet.FilterConfig;
//import javax.servlet.ServletException;
//import javax.servlet.ServletRequest;
//import javax.servlet.ServletResponse;
//import javax.servlet.annotation.WebFilter;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//@WebFilter(
//		urlPatterns = {"/account/info", "/product/add", "/product/update"}
//)
//public class LoginCheckFilter implements Filter {
//
//	private List<String> excludeUrls;
//
//    public LoginCheckFilter() {
//    }
//
//	public void destroy() {
//	}
//
//	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
//		 String path = ((HttpServletRequest) request).getServletPath();
//	        
//		 HttpServletRequest req = (HttpServletRequest)request;
//		 HttpServletResponse resp = (HttpServletResponse)response;
//		 HttpSession session = req.getSession();
//		    if(!excludeUrls.contains(path))
//		    {
//				
//				if(session.getAttribute("logined") != null /* && (boolean)session.getAttribute("logined")*/) {
//					if(session.getAttribute("account") != null) {
//						chain.doFilter(request, response);
//					} else {
//						session.invalidate();
//						resp.sendRedirect(req.getContextPath() + "/account/login");
//					}
//				} else {
//					resp.sendRedirect(req.getContextPath() + "/account/login");
//				}
//		    }
//		        
//		    // 제외하는 경우 흘려줌 
//
//		    chain.doFilter(req, resp);
//		
//		
//	}
//
//	public void init(FilterConfig fConfig) throws ServletException {
//		String excludePattern = fConfig.getInitParameter("excludedUrls");
//		excludeUrls = Arrays.asList(excludePattern.split(","));
//
//
//	}
//
//}
