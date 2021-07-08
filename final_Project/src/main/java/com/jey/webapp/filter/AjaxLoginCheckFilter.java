package com.jey.webapp.filter;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

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

import org.json.simple.JSONObject;

import com.jey.webapp.account.dto.AccountDTO;

@WebFilter(
	urlPatterns = {"/ajax/product/like"
				,"/ajax/cart/add"
//				,"/ajax/cart/changeQty"
//				,"/ajax/cart/delete"
//				,"/ajax/cart/buy"
	}
)
public class AjaxLoginCheckFilter implements Filter {

    public AjaxLoginCheckFilter() {
    }

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// session 정보 중 login 과 관련한 세션 정보 값이 존재하는지 확인하여 Login 검사
		response.setContentType("application/json; charset=utf-8");
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		HttpSession session = req.getSession();
		
		PrintWriter out = response.getWriter();
		JSONObject json = new JSONObject();
		json.put("res", "no_login");
		json.put("redirect",
				((HttpServletRequest)request).getContextPath() + "/account/login?next=" + req.getHeader("referer"));
		if(session.getAttribute("logined") != null) {
			if((boolean)session.getAttribute("logined")) {
				if(session.getAttribute("account") != null && !((AccountDTO)session.getAttribute("account")).getAtype().equals("a")) {
					out.flush();
					chain.doFilter(request, response);
					out.close();
				} else if(session.getAttribute("account") != null  && ((AccountDTO)session.getAttribute("account")).getAtype().equals("a")) {
					resp.sendRedirect(req.getContextPath() + "/");
				} else {
					session.invalidate();
					out.println(json.toJSONString());
				}
			} else {
				out.println(json.toJSONString());
			}
		} else {
			out.println(json.toJSONString());
		}
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
