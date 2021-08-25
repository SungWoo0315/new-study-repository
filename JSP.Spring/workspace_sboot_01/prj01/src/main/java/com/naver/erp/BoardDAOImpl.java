package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.apache.taglibs.standard.lang.jstl.test.beans.PublicInterface2;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

// mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
// [DAO 클래스]인 [BoardDAOImpl 클래스] 선언
// mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    // @Repository 를 붙임으로써 [DAO 클래스]임을 지정하게 되고, bean 태그로 자동 등록된다.  
// mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
@Repository
public class BoardDAOImpl implements BoardDAO {

    // ******************************************************
    // 속성변수 sqlSession 선언하고, [SqlSessionTemplate 객체]를 생성해 저장
    // ******************************************************
        // @Autowired 역할 -> 속성변수에 붙은 자료형이 [인터페이스]면 이를 구현한 [클래스]를 객체화하여 저장한다.
        // @Autowired 역할 -> 속성변수에 붙은 자료형이 [클래스]면 이를 객체화 하여 저장한다.  
    @Autowired
    private SqlSessionTemplate sqlSession;    

    // ******************************************************
    // [게시판 글 입력 후 입력 적용 행의 개수]를 리턴하는 메소드 선언
    // ******************************************************
    public int insertBoard(BoardDTO boardDTO){

        // ----------------------------------------------
        // SqlSessionTemplate 객체의 insert 메소드 호출로
        // 게시판 글 입력 SQL 구문을 실행하고 입력 성공 행의 개수 얻기.
        // ----------------------------------------------
        int boardRegCnt = sqlSession.insert(

            // ----------------------------------------------
            // 실행할 SQL 구문의 위치를 지정하기.
            // 실행할 SQL 구문의 위치 문자열 패턴은 아래와 같다.
            // xml 파일 중에 "mapper태그의namespace명.mapper태그내부의호출할SQL구문소유한태그id값"
            // ----------------------------------------------
            "com.naver.erp.BoardDAO.insertBoard"  
            // ----------------------------------------------
            // 호출할 SQL 구문에서 사용할 데이터 지정하기
            // ----------------------------------------------
            ,boardDTO                             
        );

        System.out.println("BoardDAOImpl. sqlSession.insert() 메서드 수행완료\r");

        return boardRegCnt;
    }

    // ******************************************************
    // [검색한 게시판 목록] 리턴하는 메소드 선언
    // ******************************************************
    public List<Map<String,String>>getBoardList(){


        List<Map<String,String>> boardList = this.sqlSession.selectList(

            "com.naver.erp.BoardDAO.getBoardList"  // 실행할 SQL 구문의 위치 지정  

         );
        return boardList;
    }





}
