package com.jey.webapp.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(
		urlPatterns = {
					 "/account/update"
					, "/account/update_view"
					, "/account/profile_update"
					, "/account/signout"
					, "/cart"
					, "/order"
					, "/order/detail"
					, "/order/review/add"
					}
)
public class LoginCheckFilter implements Filter {


    public LoginCheckFilter() {
    }

	public void destroy() {
	}

	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		HttpSession session = req.getSession();
		
		if(session.getAttribute("logined") != null && (boolean)session.getAttribute("logined")) {
			if(session.getAttribute("account") != null) {
				chain.doFilter(request, response);
			} else {
				session.invalidate();
				resp.sendRedirect(req.getContextPath() + "/account/login");
			}
		} else {
			resp.sendRedirect(req.getContextPath() + "/account/login");
		}

		
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
