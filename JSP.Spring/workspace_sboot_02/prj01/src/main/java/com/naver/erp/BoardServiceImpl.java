package com.naver.erp;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class BoardServiceImpl {

	
	// ****************************************************
    // [1개 게시판 글 입력 후 입력 적용 행의 개수] 리턴하는 메소드 선언
	// ****************************************************
    public int insertBoard( BoardDTO boardDTO ){

        // ---------------------------------------
        // 1개 게시판 글 입력 적용 행의 개수 리턴하기
        // ---------------------------------------
        return 1;

    }
	
}
