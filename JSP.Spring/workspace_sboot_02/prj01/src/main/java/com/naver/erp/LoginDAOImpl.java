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
	

    // +++++++++++++++++++++++++++++++++++++++++++++
	// SqlSessionTemplate 객체를 생성해 속성변수 sqlSession 에 저장
	// @Autowired 어노테이션을 붙이면 속성변수 자료형에 맞는 SqlSessionTemplate 객체를 생성한 후 
	// 객체의 메위주를 속성변수에 저장한다.
	// +++++++++++++++++++++++++++++++++++++++++++++
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// +++++++++++++++++++++++++++++++++++++++++++++
	// 로그인 아이디와 암호 존재 개수를 리턴하는 메소드 선언
    // 메소드 오버라이딩.
	// +++++++++++++++++++++++++++++++++++++++++++++
	public int getLogin_idCnt( Map<String,String> id_pwd_map ) {

		// ------------------------------------------------------
        // 진행과정 콘솔 확인용.  
		// ------------------------------------------------------
        System.out.println( "=================================");
        System.out.println( "LoginDAOImpl 메소드 호출 시작!");
        System.out.println( "LoginDAOImpl.getLogin_idCnt => " + 1);
        System.out.println( "LoginDAOImpl 매개변수 id_pwd_map => " + id_pwd_map);
		// ------------------------------------------------------




		// ------------------------------------------------------
		// SqlSessionTemplate 객체의 selectOne 메소드 호출로
		// mybatis 프레임워크가 관리하는 SQL 구문을 호출하여
        // 매개변수로 받은 id_pwd_map 를 이용하여,
		// 1행의 데이터인 [로그인 아이디, 암호 존재개수]를 얻기
		// ------------------------------------------------------

		int login_idCnt = this.sqlSession.selectOne(

            // ----------------------------------------------
			// SQL 구문 설정 XML 파일(=mapper_login.xml)에서 
			// <mapper namespace="com.naver.erp.LoginDAO"> 태그 내부의 
			// <select id="getLogin_idCnt" ~> 태그 내부의 
			// [1행 리턴 select 쿼리문]을 실행하고 얻은 데이터를 int 로 리턴한다. 
			// ----------------------------------------------
			// 실행할 SQL 구문의 위치를 지정하기.
			// 실행할 SQL 구문의 위치 문자열 패턴은 아래와 같다.  
			// xml 파일 중에   "mapper태그의namespace명.mapper태그내부의호출할SQL구문소유한태그id값"
			// ---------------------------------------------- 
            "com.naver.erp.LoginDAO.getLogin_idCnt" // xml 파일 내부의 select 문이 있는 곳의 위치


            // ----------------------------------------------
			// 호출할 SQL 구문에서 사용할 데이터 지정하기.
			// ----------------------------------------------
			// <select id="getLogin_idCnt" ~> 태그 내부에 전달되는 데이터 설정
            ,id_pwd_map
		);

            // ------------------------------------------------------
            // 진행과정 콘솔 확인용.  
            // ------------------------------------------------------
            System.out.println( "LoginDAOImpl.getLogin_idCnt => " + 2);
            System.out.println( "LoginDAOImpl 메소드 호출 종료!");
            System.out.println( "=================================");
		    // ------------------------------------------------------
            
            // ------------------------------------------------------
            // 진행과정 콘솔 확인용.  
            // ------------------------------------------------------
            System.out.println( "LoginDAOImpl 최종리턴값 확인 => " + login_idCnt);
            System.out.println( "=================================");
		    // ------------------------------------------------------

		    return login_idCnt;

	}
	
	
            // ------------------------------------------------------
            // 위 코딩을 해주고, 
            // SQL 쿼리를 날리기 위해,
            // mapper_login.xml 파일을 만들어주어야 한다.  
            // src/main/java 경로안의,
            // com/naver/erp 경로에 xml 파일 만들어주어야 한다.
            // ------------------------------------------------------
	

}
