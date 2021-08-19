package com.naver.erp;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

// ---------------------------------------------------------------
// URL 주소로 접속하면 호출되는 메소드를 소유한 [컨트롤러 클래스] 선언
// @Controller 를 붙임으로써 [컨트롤러 클래스]임을 지정한다.
// ---------------------------------------------------------------
@Controller
public class LoginController {

    // ********************************************
    // 가상주소 /loginForm.do 로 접근하면 호출되는 메소드 선언
    // ********************************************
    @RequestMapping( value="/loginForm.do")
    public ModelAndView loginForm( ){

        // System.out.print("정상 작동합니다..!");
        // ---------------------------
        // [ModelAndView 객체] 생성하기.
        // [ModelAndView 객체] 에 [호출 JSP 페이지명]을 저장하기
        // [ModelAndView 객체] 리턴하기.
        // ---------------------------
        ModelAndView mav = new ModelAndView();
        mav.setViewName("loginForm.jsp");
        return mav;

    }
}
