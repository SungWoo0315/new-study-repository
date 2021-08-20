package com.naver.erp;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoginDAOImpl implements LoginDAO {

	/*
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	public int getLogin_idCnt( Map<String,String> id_pwd ) {
		
		int login_idCnt = this.sqlSession.selectOne(
					"com.naver.erp.LoginDAO.getLogin_idCnt" // xml 파일 내부의 select 문이 있는 곳의 위치
					,id_pwd
		);
		return login_idCnt;
	}
	*/
	
	
	@Autowired
	private SqlSessionTemplate sqlSession;


	public int getLogin_idCnt( Map<String,String> id_pwd  ) {
			System.out.println(11);
			System.out.println(id_pwd);

		int login_idCnt = this.sqlSession.selectOne(
					"com.naver.erp.LoginDAO.getLogin_idCnt"  //  xml 파일 내부의  select문이 있는 곳의 위치
					,id_pwd
		);
		System.out.println(12);
		return login_idCnt;
	}
	



}
