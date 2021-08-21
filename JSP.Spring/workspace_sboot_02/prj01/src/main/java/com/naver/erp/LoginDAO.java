package com.naver.erp;

import java.util.Map;       // Map 객체를 import  

public interface LoginDAO {         // 클래스가 아닌 interface 로 변경해주어야 함.  
	
	
    // 인터페이스, 바디없는 getLogin_idCnt() 메서드 정의.  
    public int getLogin_idCnt(  Map<String,String> id_pwd  );
		

}
