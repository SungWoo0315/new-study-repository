package com.naver.erp;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.connector.Response;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
    //      @Autowired
    //      인터페이스명 속성변수;
    // ===================================
        // 인터페이스를 구현한 클래스를 찾아서 객체화한 후 객체의 메위주를 속성변수에 저장한다.
        // 객체의 이름은 무엇이든 상관없다. 인터페이스를 구현한 객체이면 된다.    
        // 즉, 속성변수에는 null 저장이 아니다.
        // <주의> 인터페이스를 구현한 객체는 1개 이어야 한다.  
    @Autowired
    private LoginDAO loginDAO;





    // ********************************************
    // 가상주소 /loginForm.do 로 접근하면 호출되는 메소드 선언
    // ********************************************
    @RequestMapping( value="/loginForm.do")
    public ModelAndView loginForm(
        
     ){


        System.out.print("==================================\r");  

        System.out.print("접속 성공, 로그인화면 진입했습니다..!\r");   

        System.out.print("==================================\r");   
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
    // 가상주소 /loginProc3.do 로 접근하면 호출되는 메소드 선언
    // 메소드 앞에 @RequestMapping(~,~,produces = "application/json;charset=UTF8") 하고
    // @ResponseBody 가 붙으면 리턴하는 데이터가 클라이언트에게 전송된다.  
    // ModelAndView 객체를 리턴하면 JSP 를 호출하고 그 JSP 페이지의 실행결과인 HTML 문서가 응답 메시지에 저장되어 전송되지만  
    // @RequestMapping(~) 와 @ResponseBody 가 붙으면 리턴하는 데이터가 JSON 형태로 응답메시지에 저장되어 전송된다.  
    // ********************************************
    // 아래 코드 원본과 loginProc() 매서드 매개변수가 달라진 코딩이다.  
    @RequestMapping( 
        value="/loginProc.do"
        ,method = RequestMethod.POST
        ,produces = "application/json;charset=UTF8"
    )
    @ResponseBody
    public int loginProc3(
        // ---------------------------------------
        // "login_id" 라는 파라미터명에 해당하는 파라미터값을 꺼내서 매개변수 login_id 에 저장하고 들어온다.
        // ---------------------------------------
        @RequestParam( value="login_id" ) String login_id 
        // ---------------------------------------
        // "pwd" 라는 파라미터명에 해당하는 파라미터값을 꺼내서 매개변수 pwd 에 저장하고 들어온다.
        // ---------------------------------------
        ,@RequestParam( value="pwd" ) String pwd

        // ---------------------------------------
        // "is_login" 라는 파라미터명에 해당하는 파라미터값을 꺼내서 매개변수 is_login 에 저장하고 들어온다.
        // ---------------------------------------
        ,@RequestParam( value="is_login", required = false ) String is_login


        // ---------------------------------------
        // HttpSession 객체의 메위주를 저장하는 매개변수 session 선언하기
        // ---------------------------------------
        ,HttpSession session
        // ---------------------------------------
        // [HttpServletResponse객체] 가 들어올 매개변수 선언
        // ---------------------------------------
        ,HttpServletResponse response
     ){

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
        System.out.println("LoginController.loginProc 해시맵 객체 => " + map);

        int login_idCnt = loginDAO.getLogin_idCnt(map);

        // --------------------------------------------------
        // 만약 login_idCnt q변수 안의 데이터가 1이면
        // 즉, 만약 입력한 아이디 암호가 DB에 존재하면
        // 즉, 만약 로그인이 성공했으면
        // --------------------------------------------------
        if( login_idCnt==1 ){
            
            // HttpSession 객체에 로그인 아이디 저장하기  
            // HttpSession 객체에 로그인 아이디를 저장하면 재 접속 했을 때 다시 꺼내 볼 수 있다.  
            // <참고> HttpSession 객체는 접속한 이우에도 제거되지 않고, 지정된 기간동안 살아 있는 객체이다.  
            // <참고> HttpServlet Request,  HttpServlet Response 객체는 접속할때 생성되고, 응답이후 삭제되는 객체이다.
            session.setAttribute( "login_id", login_id );

            // -------------------------------------------
            // 매개변수 is_login 에 null 이 저장되어 있으면 (+ [아이디,암호 자동입력]의사 없을 경우 )
            // -------------------------------------------
            if(is_login==null){

                /* 공용함수로 인해서 주석처리.
                // Cookie 객체를 생성하고 쿠키명-쿠키값을 ["login_id"-null]로 하기
                Cookie cookie1 = new Cookie("login_id",null);
                // Cookie 객체 저장된 쿠키의 수명은 0으로 하기
                cookie1.setMaxAge(0);  
                // Cookie 객체를 생성하고 쿠키명-쿠키값을 ["pwd"-null]로 하기
                Cookie cookie2 = new Cookie("pwd",null);
                // Cookie 객체 저장된 쿠키의 수명은 0으로 하기
                cookie2.setMaxAge(0); 

                // Cookie 객체가 소유한 쿠키를 응답메시지에 저장하기.  
                // 결국 Cookie 객체가 소유한 쿠키명-쿠키값이 응답메시지에 저장되는 셈이다.
                // 응답메시지에 저장된 쿠키는 클라이언튼쪽으로 전송되어 클라이언트쪽에 저장된다.  
                response.addCookie(cookie1);
                response.addCookie(cookie2);
                */

                // Util.java 에서 함수 호출해서 사용.  
                Util.addCookie(
                    "login_id"
                    ,null
                    ,0
                    ,response
                );
                Util.addCookie(
                    "pwd"
                    ,null
                    ,0
                    ,response
                );
                

            } 
            // -------------------------------------------
            // 매개변수 is_login 에 "yes" 가 저장되어 있으면(=[아이디, 암호 자동입력]의사 있을 경우)
            // -------------------------------------------
            else{

                /* 공용함수로 인한 주석처리.
                // -------------------------------------------
                // 클라이언트가 보낸 아이디, 암호를 응답메시지에 쿠키명-쿠키값으로 저장하기. 
                // -------------------------------------------
                // Cookie 객체를 생성하고 쿠키명-쿠키값을 ["login_id"-"입력아이디"]로 하기
                Cookie cookie1 = new Cookie("login_id",login_id);
                // Cookie 객체에 저장된 쿠키의 수명은 60*60*24 로 하기.(하루)
                cookie1.setMaxAge(60*60*24);  

                // Cookie 객체를 생성하고 쿠키명-쿠키값을 ["pwd"-"입력암호"]로 하기
                Cookie cookie2 = new Cookie("pwd",pwd);
                // Cookie 객체에 저장된 쿠키의 수명은 60*60*24 로 하기.(하루)
                cookie2.setMaxAge(60*60*24);  

                // Cookie 객체가 소유한 쿠키를 응답메시지에 저장하기.  
                response.addCookie(cookie1);
                response.addCookie(cookie2);
                */

                // Util.java 에서 함수 호출해서 사용.  
                Util.addCookie(
                    "login_id"
                    ,login_id
                    ,60*60*24
                    ,response
                );
                Util.addCookie(
                    "pwd"
                    ,pwd
                    ,60*60*24
                    ,response
                );
            }

        }

        System.out.println("LoginController.loginProc login_idCnt 보기 => " + login_idCnt);
        // System.out.println( "login_id => " + login_id ); // 입력된 아이디값 콘솔출력.
        // System.out.println( "pwd => " + pwd );           // 입력된 암호값 콘솔 출력.   

        return login_idCnt;
    }





























    // ********************************************
    // 가상주소 /logout.do 로 접근하면 호출되는 메소드 선언
    // ********************************************
    @RequestMapping( value="/logout.do")
    public ModelAndView logout(
        HttpSession session
    ){
        // ----------------------------------------------------------
        // HttpSession 객체에 "login_id" 라는 키값으로 저장된 데이터 삭제하기
        // HttpSession 객체에 로그인 성공 후 저장된 아이디값을 지우기  
        // HttpSession 객체에 저장된, 즉, 로그인 정보를 삭제하기
        // ----------------------------------------------------------
        session.removeAttribute("login_id");
        // ----------------------------------------------------------
        // [ModelAndView 객체] 생성하기.
        // [ModelAndView 객체] 에 [호출 JSP 페이지명]을 저장하기
        // [ModelAndView 객체] 리턴하기.
        // ----------------------------------------------------------
        ModelAndView mav = new ModelAndView();
        mav.setViewName("logout.jsp");
        System.out.println("/logout.do 호출");
        return mav;
    } 
    // ********************************************
    // 가상주소 /login_alert.do 로 접근하면 호출되는 메소드 선언
    // ********************************************
    @RequestMapping( value="/login_alert.do")
    public ModelAndView login_alert(){

        // ----------------------------------------------------------
        // [ModelAndView 객체] 생성하기.
        // [ModelAndView 객체] 에 [호출 JSP 페이지명]을 저장하기
        // [ModelAndView 객체] 리턴하기.
        // ----------------------------------------------------------
        ModelAndView mav = new ModelAndView();
        mav.setViewName("login_alert.jsp");
        System.out.println("/login_alert.do 호출");
        return mav;

    } 




}











/* 코드정리

    // ********************************************
    // 가상주소 /loginProc.do 로 접근하면 호출되는 메소드 선언
    // ********************************************
    // 아래 코드 원본과 loginProc() 매서드 매개변수가 달라진 코딩이다.  
    @RequestMapping( value="/loginProc.do")
    public ModelAndView loginProc( 
        // ---------------------------------------
        // "login_id" 라는 파라미터명에 해당하는 파라미터값을 꺼내서 매개변수 login_id 에 저장하고 들어온다.
        // ---------------------------------------
        @RequestParam( value="login_id" ) String login_id 
        // ---------------------------------------
        // "pwd" 라는 파라미터명에 해당하는 파라미터값을 꺼내서 매개변수 pwd 에 저장하고 들어온다.
        // ---------------------------------------
        ,@RequestParam( value="pwd" ) String pwd

        // ---------------------------------------
        // "is_login" 라는 파라미터명에 해당하는 파라미터값을 꺼내서 매개변수 is_login 에 저장하고 들어온다.
        // ---------------------------------------
        ,@RequestParam( value="is_login", required = false ) String is_login


        // ---------------------------------------
        // HttpSession 객체의 메위주를 저장하는 매개변수 session 선언하기
        // ---------------------------------------
        ,HttpSession session
        // ---------------------------------------
        // [HttpServletResponse객체] 가 들어올 매개변수 선언
        // ---------------------------------------
        ,HttpServletResponse response
    ){
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

        // --------------------------------------------------
        // 만약 login_idCnt q변수 안의 데이터가 1이면
        // 즉, 만약 입력한 아이디 암호가 DB에 존재하면
        // 즉, 만약 로그인이 성공했으면
        // --------------------------------------------------
        if( login_idCnt==1 ){
            
            // HttpSession 객체에 로그인 아이디 저장하기  
            // HttpSession 객체에 로그인 아이디를 저장하면 재 접속 했을 때 다시 꺼내 볼 수 있다.  
            // <참고> HttpSession 객체는 접속한 이우에도 제거되지 않고, 지정된 기간동안 살아 있는 객체이다.  
            // <참고> HttpServlet Request,  HttpServlet Response 객체는 접속할때 생성되고, 응답이후 삭제되는 객체이다.
            session.setAttribute( "login_id", login_id );

            // -------------------------------------------
            // 매개변수 is_login 에 null 이 저장되어 있으면 (+ [아이디,암호 자동입력]의사 없을 경우 )
            // -------------------------------------------
            if(is_login==null){

                //  공용함수로 인해서 주석처리.
                // // Cookie 객체를 생성하고 쿠키명-쿠키값을 ["login_id"-null]로 하기
                // Cookie cookie1 = new Cookie("login_id",null);
                // // Cookie 객체 저장된 쿠키의 수명은 0으로 하기
                // cookie1.setMaxAge(0);  
                // // Cookie 객체를 생성하고 쿠키명-쿠키값을 ["pwd"-null]로 하기
                // Cookie cookie2 = new Cookie("pwd",null);
                // // Cookie 객체 저장된 쿠키의 수명은 0으로 하기
                // cookie2.setMaxAge(0); 

                // // Cookie 객체가 소유한 쿠키를 응답메시지에 저장하기.  
                // // 결국 Cookie 객체가 소유한 쿠키명-쿠키값이 응답메시지에 저장되는 셈이다.
                // // 응답메시지에 저장된 쿠키는 클라이언튼쪽으로 전송되어 클라이언트쪽에 저장된다.  
                // response.addCookie(cookie1);
                // response.addCookie(cookie2);
                

                // Util.java 에서 함수 호출해서 사용.  
                Util.addCookie(
                    "login_id"
                    ,null
                    ,0
                    ,response
                );
                Util.addCookie(
                    "pwd"
                    ,null
                    ,0
                    ,response
                );
                

            } 
            // -------------------------------------------
            // 매개변수 is_login 에 "yes" 가 저장되어 있으면(=[아이디, 암호 자동입력]의사 있을 경우)
            // -------------------------------------------
            else{

                //  공용함수로 인한 주석처리.
                // // -------------------------------------------
                // // 클라이언트가 보낸 아이디, 암호를 응답메시지에 쿠키명-쿠키값으로 저장하기. 
                // // -------------------------------------------
                // // Cookie 객체를 생성하고 쿠키명-쿠키값을 ["login_id"-"입력아이디"]로 하기
                // Cookie cookie1 = new Cookie("login_id",login_id);
                // // Cookie 객체에 저장된 쿠키의 수명은 60*60*24 로 하기.(하루)
                // cookie1.setMaxAge(60*60*24);  

                // // Cookie 객체를 생성하고 쿠키명-쿠키값을 ["pwd"-"입력암호"]로 하기
                // Cookie cookie2 = new Cookie("pwd",pwd);
                // // Cookie 객체에 저장된 쿠키의 수명은 60*60*24 로 하기.(하루)
                // cookie2.setMaxAge(60*60*24);  

                // // Cookie 객체가 소유한 쿠키를 응답메시지에 저장하기.  
                // response.addCookie(cookie1);
                // response.addCookie(cookie2);
                

                // Util.java 에서 함수 호출해서 사용.  
                Util.addCookie(
                    "login_id"
                    ,login_id
                    ,60*60*24
                    ,response
                );
                Util.addCookie(
                    "pwd"
                    ,pwd
                    ,60*60*24
                    ,response
                );
            }

        }



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
        mav.setViewName("loginProc2.jsp");
        mav.addObject("idCnt", login_idCnt);      // DB 연동한 결과물이 1이라고 치고, 결과 보는것.  
            // 위 addObject 메소드로 저장된 DB 연동 결과물은 
            // HttpServletRequest 객체에 setAttribute 메소드로 저장된다.
        
        System.out.println("LoginController.loginProc 메소드 호출 완료!");

        return mav;
    }
*/


/*
    // ********************************************
    // 가상주소 /loginProc2.do 로 접근하면 호출되는 메소드 선언
    // ********************************************
    // 원본 코딩이다. 위 코딩과 다른점 공부하기. loginProc2() 메소드 매개변수와 아래 코딩이 다르다.   
    @RequestMapping( value="/loginProc2.do")
    public ModelAndView loginProc2( 
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
*/