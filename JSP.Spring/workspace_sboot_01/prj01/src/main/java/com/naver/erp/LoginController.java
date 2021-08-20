package com.naver.erp;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

// ---------------------------------------------------------------
// URL 주소로 접속하면 호출되는 메소드를 소유한 [컨트롤러 클래스] 선언
// @Controller 를 붙임으로써 [컨트롤러 클래스]임을 지정한다.
// ---------------------------------------------------------------
@Controller
public class LoginController {

    // ++++++++++++++++++++++++++++++++++++++++
    // SqlSessionTemplate 객체를 생성해 속성변수 sqlSession 에 저장
    // @Autowired 어노테이션을 붙이면 자료형에 맞는 SqlSessionTemplate 객체를 생성한다.
    // 결국 속성변수 sqlSession 에는 SqlSessionTemplate 객체의 메위주가 저장되어 있다.  
    // SqlSessionTemplate 객체의 메소드를 이용하면 xml 에 저장된 SQL 구문을 읽어 DB 연동을 할 수 있다.  
    // ++++++++++++++++++++++++++++++++++++++++
    @Autowired
    private SqlSessionTemplate sqlSession;







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
    // ********************************************
    // 가상주소 /loginProc.do 로 접근하면 호출되는 메소드 선언
    // ********************************************
    @RequestMapping( value="/loginProc.do")
    public ModelAndView loginProc( 
        // 클라이언트가 보낸 요청 메시지를 관리하는 HttpServletRequest 객체가 매개변수로 들어온다.
        // HttpServletRequest 객체의 메소드를 이용하면 파라미터값을 얻을 수 있다.
        HttpServletRequest request
    ){
        // --------------------------------------------------
        // 클라이언트가 보낸 요청 메시지 안의 "id" 라는 파라미터명의 파라미터값 꺼내기
        // 클라이언트가 보낸 아이디를 꺼내라
        // 클라이언트가 보낸 요청 메시지 안의 "pwd" 라는 파라미터명의 파라미터값 꺼내기
        // 클라이언트가 보낸 암호를 꺼내라
        // --------------------------------------------------
        String login_id = request.getParameter("login_id");
        String pwd = request.getParameter("pwd");
        
        System.out.println( "login_id => " + login_id );
        System.out.println( "pwd => " + pwd );
        // ---------------------------
        // [ModelAndView 객체] 생성하기.
        // [ModelAndView 객체] 에 [호출 JSP 페이지명]을 저장하기
        // [ModelAndView 객체] 에 아이디 암호 존재개수 저장하기. 즉, DB 연동 결과물 저장하기.
            // [ModelAndView 객체] 에 저장된 DB 연동 결과물은 
            // HttpServletRequest 객체에 setAttribute 메소드로 저장된다. 
        // [ModelAndView 객체] 리턴하기.
        // ---------------------------
        ModelAndView mav = new ModelAndView();
        mav.setViewName("loginProc.jsp");
        mav.addObject("idCnt", 1);      // DB 연동한 결과물이 1이라고 치고, 결과 보는것.  
            // 위 addObject 메소드로 저장된 DB 연동 결과물은 
            // HttpServletRequest 객체에 setAttribute 메소드로 저장된다.
        return mav;

    }

}
