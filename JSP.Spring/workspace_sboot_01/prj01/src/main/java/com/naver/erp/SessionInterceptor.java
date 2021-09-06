package com.naver.erp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
//import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.HandlerInterceptor;


public class SessionInterceptor implements HandlerInterceptor{		

	@Override
	public boolean preHandle(
		HttpServletRequest request 
		, HttpServletResponse response 
		, Object handler
	) throws Exception {

		HttpSession session = request.getSession();   
		String login_id = (String)session.getAttribute("login_id");	
		
		if(login_id==null) {	
			response.sendRedirect( "/loginForm.do" );

			System.out.println("※※로그인하지 않고 접속하여 다시 로그인페이지 이동※※");
			
			return false;
		}
		else { 
			return true;
		}
		
	}

}
