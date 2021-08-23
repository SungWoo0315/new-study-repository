package com.naver.erp;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

// ---------------------------------------------------------------
// URL 주소로 접속하면 호출되는 메소드를 소유한 [컨트롤러 클래스] 선언
// @Controller 를 붙임으로써 [컨트롤러 클래스]임을 지정한다.
// ---------------------------------------------------------------
@Controller
public class BoardController {

    // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    // 가상주소 /boardList.do 로 접근하면 호출되는 메소드 선언
    //      @RequestMapping 내부에, method="RequestMethod.POST" 가 없으므로
    //      가상주소 /boardList.do 로 접근 시 get 또는 post 방식 접근 모두 허용한다. 
    // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    @RequestMapping( value = "/boardList.do" )
    public ModelAndView getBoardList(


    ){
        // ***************************************
        // [ModelAndView 객체] 생성하기
        // ***************************************
        ModelAndView mav = new ModelAndView();
        // ***************************************
        // [ModelAndView 객체] 에 [호출 JSP 페이지명]을 저장하기
        // ***************************************
        mav.setViewName("boardList.jsp");
        // ***************************************
        // [ModelAndView 객체] 리턴하기
        // ***************************************
        return mav;
    }

    // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    // 가상주소  /boardRegForm.do 로 접근하면 호출되는 메소드 선언
    // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    @RequestMapping( value = "/boardRegForm.do" )
    public ModelAndView goBoardRegForm(
    
    
    ){
        // ***************************************
        // [ModelAndView 객체] 생성하기
        // ***************************************
        ModelAndView mav = new ModelAndView();
        // ***************************************
        // [ModelAndView 객체] 에 [호출 JSP 페이지명]을 저장하기
        // ***************************************
        mav.setViewName("boardRegForm.jsp");
        // ***************************************
        // [ModelAndView 객체] 리턴하기
        // ***************************************
        return mav;

    }


    // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    // 가상주소 /boardRegProc.do 로 접근하면 호출되는 메소드 선언
    // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    @RequestMapping( value="/boardRegProc.do")
    public ModelAndView boardRegProc( 
        
        HttpServletRequest request

    ){

        String writer = request.getParameter("writer");
        String subject = request.getParameter("subject");
        String email = request.getParameter("email");
        String content = request.getParameter("content");
        String pwd = request.getParameter("pwd");
        
        System.out.println("==============================================\r ");
        System.out.println("BoardController.boardRegProc.do => 파라미터명 writer => " + writer);
        System.out.println("LoginController.boardRegProc.do => 파라미터명 subject => " + subject);
        System.out.println("LoginController.boardRegProc.do => 파라미터명 email => " + email);
        System.out.println("LoginController.boardRegProc.do => 파라미터명 content => " + content);
        System.out.println("LoginController.boardRegProc.do => 파라미터명 pwd => " + pwd);
        System.out.println("==============================================\r ");

        // ***************************************
        // [ModelAndView 객체] 생성하기
        // ***************************************
        ModelAndView mav = new ModelAndView();
        // ***************************************
        // [ModelAndView 객체] 에 [호출 JSP 페이지명]을 저장하기
        // ***************************************
        mav.setViewName("boardList.jsp");
        // ***************************************
        // [ModelAndView 객체] 리턴하기
        // ***************************************
        System.out.println("LoginController 수행완료\r");
        return mav;


    }

}
