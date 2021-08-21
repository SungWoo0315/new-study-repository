package com.naver.erp;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

// mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
// [DAO 클래스]인 [LoginDAOImpl 클래스] 선언
// mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// @Repository 를 붙임으로써 [DAO 클래스]임을 지정하게되고,
	// Spring 에서 인식해서 필요시 객체화 한다. 
// mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
@Repository
public class LoginDAOImpl implements LoginDAO {

	// ------------------------------------------------
    // LoginDAO.java(인터페이스) 를 implements(상속) 한 것이다.  
    // LoginDAO 부모의 메소드를 오버라이딩 해야한다.  
    // 인터페이스를 구현한 클래스이다.  
	// ------------------------------------------------
	


    
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	public int getLogin_idCnt( Map<String,String> id_pwd ) {
		
		int login_idCnt = this.sqlSession.selectOne(
					"com.naver.erp.LoginDAO.getLogin_idCnt" // xml 파일 내부의 select 문이 있는 곳의 위치
					,id_pwd
		);
		return login_idCnt;
	}
	
	
	
	

}
