package com.naver.erp;

import org.apache.taglibs.standard.lang.jstl.test.beans.PublicInterface2;
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
    // [게시판 글 입력 후 입력 적용 행의 개수]를 리턴하는 메소드 선언
    // ******************************************************
    public int insertBoard(BoardDAO boardDAO){


        return 1;
    }



}
