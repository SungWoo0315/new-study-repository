package com.naver.erp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

// mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
// [서비스 클래스]인 [BoardServiceImpl 클래스]선언
// mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    // [서비스 클래스]에는 @Service 와 @Transactional 를 붙인다. 
    // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    // @Service         => [서비스 클래스] 임을 지정하고 bean 태그로 자동 등록된다.
    // @Transactional   => [서비스 클래스]의 메소드 내부에서 일어나느 모든 작업에는 [트랜잭션]이 걸린다.  
// mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
@Service
@Transactional
public class BoardServiceImpl implements BoardService {

    // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    // 속성변수 boardDAO 선언하고, [BoardDAO 인터페이스]를 구현한 클래스를 객체화 해서 저장한다.
    // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
        // @Autowired 역할 => 속성변수에 붙은 자료형인 [인터페이스]를 구현한 [클래스]를 객체화하여 저장한다.
    // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    @Autowired
    private BoardDAO boardDAO;

    
	// ****************************************************
    // [1개 게시판 글 입력 후 입력 적용 행의 개수] 리턴하는 메소드 선언
	// ****************************************************
    public int insertBoard( BoardDTO boardDTO ){

        // ---------------------------------------
        // BoardDAOImpl 객체의 insertBoard 메소드 호출하여 게시판 글 입력 후 입력 적용 행의 개수 얻기
        // ---------------------------------------
        int boardRegCnt = this.boardDAO.insertBoard(boardDTO);
        // ---------------------------------------
        // 1개 게시판 글 입력 적용 행의 개수 리턴하기
        // ---------------------------------------
       
        System.out.println("BoardServiceImpl. insertBoard() 메서드 수행완료\r");
       
        return boardRegCnt;



    }
	// ****************************************************
    // [1개 게시판 글] 리턴하는 메소드 선언
	// ****************************************************
    public BoardDTO getBoard(int b_no) {
        // -------------------------------------------
        // [BoardDAOImpl 객체]의 updateReadcount 메소드를 호출하여 
        // [조회수 증가]하고 수정한 행의 개수를 얻는다
        // -------------------------------------------
        int updateCnt = this.boardDAO.updateReadcount(b_no);

        // -------------------------------------------
        // BoardDAOImpl 객체의 getBoard 메소드를 호출하여
        // [1개 게시판 글]을 얻는다
        // -------------------------------------------
        BoardDTO board = this.boardDAO.getBoard(b_no); 
        // -------------------------------------------
        // [1개 게시판 글]이 저장된 BoardDTO 객체 리턴하기
        // -------------------------------------------
        return board;

    }


}
