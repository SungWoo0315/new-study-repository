package com.naver.erp;

import java.util.HashMap;
import java.util.Map;

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

    /*  잘못된 코딩 
    // ++++++++++++++++++++++++++++++++++++++++
    // SqlSessionTemplate 객체를 생성해 속성변수 sqlSession 에 저장
    // @Autowired 어노테이션을 붙이면 자료형에 맞는 SqlSessionTemplate 객체를 생성한다.
    // 결국 속성변수 sqlSession 에는 SqlSessionTemplate 객체의 메위주가 저장되어 있다.  
    // SqlSessionTemplate 객체의 메소드를 이용하면 xml 에 저장된 SQL 구문을 읽어 DB 연동을 할 수 있다.  
    // ++++++++++++++++++++++++++++++++++++++++
    @Autowired
    private SqlSessionTemplate sqlSession;
    */

    // ===================================
    // 속성변수 loginDAO 선언하고, LoginDAO 라는 인터페이스를
    // 구현한 클래스를 객체화하여 저장
    // 즉, 속성변수 loginDAO 에는 loginDAOImpl 객체의 메위주가 저장된다.  
    // ===================================
        // @Autowired 가 붙은 속성변수에는 인터페이스 자료형을 쓰고
        // 이 인터페이스를 구현한 클래스를 객체화하여 저장한다.
        // LoginDAO 라는 인터페이스를 구현한 클래스의 이름을 몰라도 관계없다.
        // 1개 존재하기만 하면된다.  
    // ===================================
    @Autowired
    private LoginDAO loginDAO;





    // ********************************************
    // 가상주소 /loginForm.do 로 접근하면 호출되는 메소드 선언
    // ********************************************
    @RequestMapping( value="/loginForm.do")
    public ModelAndView loginForm( ){

        System.out.print("접속 성공, 로그인화면 진입했습니다..!");
        System.out.print("  ");
        System.out.print("==================================");
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
        System.out.println("LoginController.loginProc 메소드 호출 시작!");
        System.out.println("LoginController.loginProc => " + 1);
        // --------------------------------------------------
        // 클라이언트가 보낸 요청 메시지 안의 "id" 라는 파라미터명의 파라미터값 꺼내기
        // 클라이언트가 보낸 아이디를 꺼내라
        // 클라이언트가 보낸 요청 메시지 안의 "pwd" 라는 파라미터명의 파라미터값 꺼내기
        // 클라이언트가 보낸 암호를 꺼내라
        // --------------------------------------------------
        String login_id = request.getParameter("login_id");
        String pwd = request.getParameter("pwd");
        
        System.out.println("LoginController.loginProc => 파라미터명 login_id => " + login_id);
        System.out.println("LoginController.loginProc => 파라미터명 pwd => " + pwd);

        
        // --------------------------------------------------
        // HashMap 객체 생성하기
        // HashMap 객체에 로그인 아이디 저장하기
        // HashMap 객체에 암호 저장하기
        // --------------------------------------------------
        Map<String,String> map = new HashMap<String,String>();
        map.put("login_id", login_id);
        map.put("pwd", pwd);

        // --------------------------------------------------
        // loginDAOImpl 객체의 getLogin_idCnt 메소드를 호출하여 
        // 로그인 아이디와 암호의 전체 개수 얻기
        // --------------------------------------------------
        System.out.println("LoginController.loginProc => " + 2);
        System.out.println("LoginController.loginProc 해시맵 객체 => " + map);

        int login_idCnt = loginDAO.getLogin_idCnt(map);
        System.out.println("LoginController.loginProc => " + 3);
        System.out.println("LoginController.loginProc login_idCnt 보기 => " + login_idCnt);
        

        // System.out.println( "login_id => " + login_id ); // 입력된 아이디값 콘솔출력.
        // System.out.println( "pwd => " + pwd );           // 입력된 암호값 콘솔 출력.   


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
        mav.addObject("idCnt", login_idCnt);      // DB 연동한 결과물이 1이라고 치고, 결과 보는것.  
            // 위 addObject 메소드로 저장된 DB 연동 결과물은 
            // HttpServletRequest 객체에 setAttribute 메소드로 저장된다.
        
        System.out.println("LoginController.loginProc 메소드 호출 완료!");

        return mav;

    }

}
