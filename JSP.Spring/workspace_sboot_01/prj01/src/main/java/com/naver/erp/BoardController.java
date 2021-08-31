package com.naver.erp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.swing.plaf.basic.BasicInternalFrameTitlePane.SystemMenuBar;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
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
    // 속성변수 boardService 선언하고 [BoardService 인터페이스]를 구현한 클래스를 찾아 객체 생성해 객체의 메위주를 저장.
    // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
        // @Autowired 역할 -> 속성변수에 붙은 자료형인 [인터페이스]를 구현할 [클래스]를 객체화하여 객체의 메위주를 저장한다.
        // [인터페이스]를 구현한 [클래스]가 1개가 아니면 에러가 발생한다.  
        // 단, @Autowired( required=false ) 로 선언하여 [인터페이스]를 구현할 [클래스]가 0개 이어도 에러없이 null 이 저장된다.    
    @Autowired
    private BoardService boardService;

    // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    // 속성변수 boardDAO 선언하고 [BoardDAO 인터페이스]를 구현한 클래스를 찾아 객체 생성해 객체의 메위주를 저장.
    // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
        // @Autowired 역할 -> 속성변수에 붙은 자료형인 [인터페이스]를 구현할 [클래스]를 객체화하여 객체의 메위주를 저장한다.
        // [인터페이스]를 구현한 [클래스]가 1개가 아니면 에러가 발생한다.  
        // 단, @Autowired( required=false ) 로 선언하여 [인터페이스]를 구현할 [클래스]가 0개 이어도 에러없이 null 이 저장된다.    
    @Autowired
    private BoardDAO boardDAO;

    // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    // 가상주소 /boardList.do 로 접근하면 호출되는 메소드 선언
    //      @RequestMapping 내부에, method="RequestMethod.POST" 가 없으므로
    //      가상주소 /boardList.do 로 접근 시 get 또는 post 방식 접근 모두 허용한다. 
    // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    @RequestMapping( value = "/boardList.do" )
    public ModelAndView getBoardList(

        // --------------------------------------------------
        // 파라미터 값을 저장하고 있는 BoardSearchDTO 객체를 받아오는 매개변수 선언
        // --------------------------------------------------
        BoardSearchDTO boardSearchDTO
        

    ){

        // ***************************************
        // 오라클 board 테이블 안의 데이터를 검색해와 자바 객체에 저장하기 즉, [게시판 목록] 얻기
        // 검색 조건에 맞는 [게시판 목록] 얻기
        // ***************************************
        List<Map<String, String>> boardList = this.boardDAO.getBoardList( boardSearchDTO );


        // ***************************************
        // 검색 조건에 맞는 [게시판 목록의 총개수] 얻기
        // ***************************************
        int getBoardListCount = this.boardDAO.getBoardListCount( boardSearchDTO );

        System.out.println("컨트롤러에서 검색개수 확인 => " + getBoardListCount);

        // ***************************************
        // [ModelAndView 객체] 생성하기
        // ***************************************
        ModelAndView mav = new ModelAndView();
        // ***************************************
        // [ModelAndView 객체] 에 [호출 JSP 페이지명]을 저장하기
        // ***************************************
        mav.setViewName("boardList.jsp");

        // ***************************************
        // [ModelAndView 객체] 에 [게시판 목록 검색 결과]를 저장하기
        // [ModelAndView 객체] 에 [게시판 목록의 총개수]를 저장하기
        // ***************************************
        mav.addObject("boardList", boardList);
        
        mav.addObject("getBoardListCount", getBoardListCount);

        // ***************************************
        // [ModelAndView 객체] 에 [현재 화면에 보여지는 페이지 번호의 최소 번호]를 저장하기
        // [ModelAndView 객체] 에 [현재 화면에 보여지는 페이지 번호의 최대 번호]를 저장하기
        // ***************************************
        


        

        System.out.println("컨트롤러 /boardList.do 진행... ");

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
        // ---------------------------------------------------------------
        // 파라미터명이 b_no 인 파라미터값을 받아오는 매개변수 b_no 선언하기
        // ---------------------------------------------------------------
        @RequestParam(
            value="b_no"            // 파라미터명 설정
            , required = false      // 파라미터명, 값이 안들어와도 허용한다는 의미
            , defaultValue = "0"    // 파라미터값 없으면 파라미터값을 0으로 저장
            ) int b_no

        // HttpServletRequest request
    
    ){

        System.out.println("BoardController 에서 댓글쓰기 부모 PK 값 확인 ==> " + b_no); // PK 파라미터값 확인.  

        /*  HttpServletRequest request 썻을때의 조건 코드.  
        String b_no = request.getParameter("b_no");
        if( b_no == null){

        }
        else{

        }
        */

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
    public ModelAndView insertBoard( 
        // **********************************************
        // 파라미터값을 저장할 [BoardDTO 객체]를 매개변수로 선언
        // **********************************************
            // [파라미터명]과 [BoardDTO 객체]의 [속성변수명]이 같으면
            // setter 메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다.
            // [속성변수명]에 대응하는 [파라미터명]이 없으면 setter 메소드가 작동되지 않는다.
            // [속성변수명]에 대응하는 [파라미터명]이 있는데 [파라미터값]이 없으면
            // [속성변수]의 자료형에 관계없이 무조건 null 값이 저장된다.
            // 이때 [속성변수]의 자료형이 기본형일 경우 null 값이 저장될 수 없어 에러가 발생한다. 
            // 이런 에러를 피하려면 파라미터값이 기본형이거나 속성변수의 자료형을 String 으로 해야한다.
            // 이런 에러가 발생하면 메소드안의 실행구문은 하나도 실행되지 않음에 주의한다.
            // 매개변수로 들어온 [DTO 객체]는 이 메소드가 끝난 후 호출되는 JSP 페이지로 그대로 이동한다.
            // 즉, HttpServletRequest 객체에 boardDTO 라는 키값명으로 저장된다.  

        BoardDTO boardDTO
        // **********************************************
        // Error 객체를 관리하는 BindingResult 객체가 저장되어 들어오는 매개변수 bindingResult 선언
        // **********************************************
        , BindingResult bindingResult


    ){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("boardRegProc.jsp");

        try{

            /* 인위적 예외발생하기. 
            if( boardDTO.getB_no()>0 ){
                throw new Exception();
            }
            */ 

            System.out.println( "====================\r" );
            System.out.println( "BoardController 에서 받아오는 값 확인.\r" );
            System.out.println( "getB_no => " + boardDTO.getB_no() );
            System.out.println( "getSubject => " + boardDTO.getSubject() );
            System.out.println( "getWriter => " + boardDTO.getWriter() );
            System.out.println( "getContent => " + boardDTO.getContent() );
            System.out.println( "getPwd => " + boardDTO.getPwd() );
            System.out.println( "====================\r" );


            // *********************************************
            // check_BoardDTO 메소드를 호출하여 [유효성 체크]하고 경고문자 얻기
            // *********************************************
            // 유효성 체크 에러 메시지 저장할 변수 선언
            String msg = "";
            // check_BoardDTO 메소드를 호출하여 [유효성 체크]하고 [에러 메시지] 문자 얻기

            msg = check_BoardDTO( boardDTO, bindingResult );  

            // 만약 msg 안에 "" 가 저장되어 있으면, 즉, 유효성 체크를 통과했으면  
            if( msg.equals("") ){

                // *********************************************
                // [BoardServiceImpl 객체]의 insertBoard 메소드 호출로
                // 게시판 글 입력하고 [게시판 입력 적용행의 개수] 얻기
                // *********************************************
                int boardRegCnt = this.boardService.insertBoard(boardDTO); 

                System.out.println( "boardRegCnt 값 확인 => " + boardRegCnt );  


                // ***************************************
                // [ModelAndView 객체] 생성하기
                // [ModelAndView 객체] 에 [호출 JSP 페이지명]을 저장하기
                // [ModelAndView 객체] 에 [게시판 입력 적용행의 개수] 저장하기  
                // [ModelAndView 객체] 에 [유효성 체크 에러 메시지] 저장하기  
                // ***************************************
                mav.addObject("boardRegCnt", boardRegCnt);        
                mav.addObject("msg", msg);        
            
            }
            // 만약 msg 안에 "" 가 저장되어 있지 않으면, 즉, 유효성 체크를 통과 못했으면
            else{
                
                mav.addObject("boardRegCnt", 0);        
                mav.addObject("msg", msg); 

            }

            // ***************************************
            // [ModelAndView 객체] 리턴하기
            // ***************************************
            
            System.out.println("BoardController. insertBoard() 메서드 수행완료");
        }catch(Exception ex){
            
            System.out.println("예외처리 발생, 조치바람!!");

            mav.addObject("boardRegCnt", -1); 
            mav.addObject("msg", "서버에서 문제 발생! 서버 관리자에게 문의 하세요."); 
            
        }    
        return mav;


    }

    // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    // 게시판 입력 또는 수정 시 게시판 입력글의 입력양식의 유효성을 검사하고
    // 문제가 있으면 경고 문자를 리턴하는 메소드 선언.
    // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    public String check_BoardDTO( BoardDTO boardDTO, BindingResult bindingResult ){
        String checkMsg = "";
        // *******************************************
        // BoardDTO 객체에 저장된 데이터의 유효성 체크할 BoardValidator 객체 생성하기
        // BoardValidator 객체의 validate 메소드 호출하여 유효성 체크 실행하기.  
        // *******************************************
        BoardValidator boardValidator = new BoardValidator();
        boardValidator.validate(
            boardDTO            // 유효성 체크할 DTO 객체
            , bindingResult     // 유효성 체크 결과 관리하는 BindingResult 객체

        );
        // *******************************************
        // 만약 BindingResult 객체의 hasErrors() 메소드 호출하여 true 값을 얻으면
        // *******************************************
        if( bindingResult.hasErrors() ) {
            // 변수 checkMsg 에 BoardValidator 객체에 저장된 경고문구 얻어 저장하기.
            checkMsg = bindingResult.getFieldError().getCode();
        }
        // *******************************************
        // checkMsg 안의 문자 리턴하기.
        // *******************************************
        return checkMsg;
    }


    //mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    // /boardContentForm.do 접속 시 호출되는 메소드 선언
    //mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    @RequestMapping( value="/boardContentForm.do" )
    public ModelAndView goBoardContentForm( 
            @RequestParam(value="b_no") int b_no
    ){

        // ******************************************
        // [BoardServiceImpl 객체]의 getBoard 메소드 호출로 [1개의 게시판 글]을 BoardDTO 객체에 담아오기
        // ******************************************
        BoardDTO boardDTO = this.boardService.getBoard(b_no);


        System.out.println("boardDTO 객체 메위주 확인 => " + boardDTO);

        if( boardDTO!=null ){
        // ========================================================================
        String email = boardDTO.getEmail(); // 테스트용, 출력값 콘솔확인.

        System.out.println("상세목록 email 값 출력 컨트롤러에서 => " + email); // 테스트용, 출력값 콘솔확인. 
        System.out.println("상세목록 PK 값 출력 컨트롤러에서 => " + b_no); // 테스트용, 출력값 콘솔확인. 
        System.out.println("PK 값 출력 컨트롤러에서 boardDTO 객체 메위주 => " + boardDTO); // 테스트용, 출력값 콘솔확인.  
        // ========================================================================
        }else{
            System.out.println("null 값이 들어와 에러가 났습니다. 확인하세요.");
        }


        //*******************************************
        // [ModelAndView 객체] 생성하기
        // [ModelAndView 객체]에 [호출 JSP 페이지명]을 저장하기
        //*******************************************
        ModelAndView mav = new ModelAndView( );
        mav.setViewName("boardContentForm.jsp");
        mav.addObject("boardDTO", boardDTO);

        //*******************************************
        // [ModelAndView 객체] 리턴하기
        //*******************************************
        return mav;
    }

    //mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    // /boardUpDelForm.do 접속 시 호출되는 메소드 선언
    //mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    @RequestMapping( value="/boardUpDelForm.do" )
    public ModelAndView goBoardUpDelForm( 
        // -------------------------------
        // "b_no" 라는 파라미터명의 파라미터값이 저장되는 매개변수 b_no 선언
        // 수정 또는 삭제할 게시판 고유번호가 들어오는 매개변수 선언
        // -------------------------------
        @RequestParam(value="b_no") int b_no
    ){
        //*******************************************
        // boardDAOImp 객체의 getBoard 메소드 호출로
        // 1개의 게시판글을 boardDTO 객체에 담아서 가져오기
        //*******************************************
        BoardDTO boardDTO = this.boardDAO.getBoard(b_no);
        //*******************************************
        // [ModelAndView 객체] 생성하기
        // [ModelAndView 객체]에 [호출 JSP 페이지명]을 저장하기
        //*******************************************
        ModelAndView mav = new ModelAndView( );
        mav.setViewName("boardUpDelForm.jsp");
        mav.addObject("boardDTO", boardDTO);
        return mav;
    }

    // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    // /boardUpDelProc.do 접속 시 호출되는 메소드 선언
    // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    @RequestMapping( value="/boardUpDelProc.do" )
    public ModelAndView boardUpDelProc( 
        // ***********************************************
        // 파라미터값을 저장할 [BoardDTO 객체]를 매개변수로 선언
        // ***********************************************
        BoardDTO boardDTO
        // ***********************************************
        // "upDel" 라는 파라미터명의 파라미터값이 저장된 매개변수 b_no 선언
        // ***********************************************
        ,@RequestParam(value = "upDel") String upDel
        // **********************************************
        // Error 객체를 관리하는 BindingResult 객체가 저장되어 들어오는 매개변수 bindingResult 선언
        // 유효성 검사결과를 관리
        // **********************************************
        , BindingResult bindingResult
    ){

        // ***************************************
        // [ModelAndView 객체] 생성하기
        // [ModelAndView 객체] 에 [호출 JSP 페이지명]을 저장하기
        // [ModelAndView 객체] 에 [수정/삭제할 1개의 게시판 글 정보] 저장하기  
        // [ModelAndView 객체] 리턴하기
        // ***************************************
        ModelAndView mav = new ModelAndView( );
        mav.setViewName("boardUpDelProc.jsp");

        // **********************************************
        // 만약 게시판 삭제 모드이면
        // **********************************************
        if( upDel.equals("del") ){
            // 삭제 실행하고 삭제 적용행의 개수 얻기
            int boardUpDelCnt = this.boardService.deleteBoard(boardDTO);
            mav.addObject("boardUpDelCnt", boardUpDelCnt);        

            System.out.println( "====================" );
            System.out.println( "BoardController 에서 /boardUpDelProc.do 접속." );
            System.out.println( "삭제할 PK 번호 호출 getB_no => " + boardDTO.getB_no() );
            


        }



        // **********************************************
        // 만약 게시판 수정 모드이면 수정 실행하고 수정 적용행의 개수 얻기
        // **********************************************
        else if(upDel.equals("up")){

            // *********************************************
            // check_BoardDTO 메소드를 호출하여 [유효성 체크]하고 경고문자 얻기
            // *********************************************
            // 유효성 체크 에러 메시지 저장할 변수 선언
            String msg = "";
            // check_BoardDTO 메소드를 호출하여 [유효성 체크]하고 [에러 메시지] 문자 얻기
            msg = check_BoardDTO( boardDTO, bindingResult );  
            
            // [ModelAndView 객체]에 유효성체크 시 발생한 [유효성 체크 에러 메시지] 저장하기
            mav.addObject("msg", msg);        

            // 만약 msg 안에 "" 가 저장되어 있으면, 즉, 유효성 체크를 통과했으면  
            if( msg.equals("") ){
                // -----------------------------------------
                // BoardServiceImpl 객체의 updateBoard 라는 메소드 호출로
                // 게시판 수정 실행하고 수정 적용행의 개수 얻기
                // -----------------------------------------
                int boardUpDelCnt = this.boardService.updateBoard(boardDTO);
                // -----------------------------------------
                // [ModelAndView 객체]에 [게시판 수정 적용행의 개수] 저장하기
                // -----------------------------------------
                mav.addObject("boardUpDelCnt", boardUpDelCnt);  
                
                System.out.println( "유효성체크 통과." );
                

            }
            // 만약 msg 안에 "" 가 저장되어 있지 않으면, 즉, 유효성 체크를 통과 못했으면
            else{

                mav.addObject("boardUpDelCnt", 0);        

                System.out.println( "유효성체크 통과 못함." );

                
            }


        }
        
        return mav;




    }

}
