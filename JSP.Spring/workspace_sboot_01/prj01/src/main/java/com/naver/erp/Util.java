package com.naver.erp;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// 유틸적인 메소드를 가진 클래스 선언.
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
public class Util {    
    // --------------------------------------------
    // 응답 메시지에 쿠키명-쿠키값 을 저장하는 메소드   
    // --------------------------------------------
    public static void addCookie(
        String cookieName
        ,String cookieVal
        ,int cookieAge
        ,HttpServletResponse response
    ){
        // Cookie 객체를 생성하고 쿠키명-쿠키값을 저장하기
        Cookie cookie = new Cookie(cookieName, cookieVal);
        // Cookie 객체 저장된 쿠키의 수명을 주기
        cookie.setMaxAge(cookieAge);  
        // Cookie 객체가 소유한 쿠키를 응답메시지에 저장하기.  
        // 결국 Cookie 객체가 소유한 쿠키명-쿠키값이 응답메시지에 저장되는 셈이다.
        // 응답메시지에 저장된 쿠키는 클라이언튼쪽으로 전송되어 클라이언트쪽에 저장된다. 
        response.addCookie(cookie);
    }
    // --------------------------------------------
    // String 형 변수 안에 null 또는 "" 가 있으면 true 를 리턴하는 메소드 
    // --------------------------------------------
    public static boolean isNull( String str ){

        return str==null || str.length()==0;
    }
    // --------------------------------------------
    // 페이징 처리 관련 데이터를 구하고 Map<String,Integer> 객체에 저장하여 
    // Map<String,Integer> 객체 메소드 선언  
    // --------------------------------------------
    public static Map<String,Integer> getPagingNos(
        int totCnt
        ,int selectPageNo
        ,int rowCntPerPage
        ,int pageNoCntPerPage
    ){
        Map<String,Integer> map = new HashMap<String,Integer>();
        map.put("last_pageNo", 0);
        map.put("min_pageNo", 0);
        map.put("max_pageNo", 0);
        
        map.put("selectPageNo", 0);
        map.put("rowCntPerPage", 0);
        map.put("pageNoCntPerPage", 0);

        // ???


        return map;
    }

}




/*  공용처리 위해서 LoginController.java 에서 코드 복사해옴.  위에서 커스텀 함.  

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