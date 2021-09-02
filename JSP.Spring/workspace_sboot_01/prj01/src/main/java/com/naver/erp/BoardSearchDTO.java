package com.naver.erp;

import java.util.List;

public class BoardSearchDTO {

	// -------------------------------------------------
	// [검색 키워드] 저장하는 속성변수 선언
	// 현재 [선택된 페이지 번호]를 저장하는 속성변수 선언.
	// 한 화면에 보여줄 [행의 개수]를 저장하는 속성변수 선언.
	// -------------------------------------------------
	private String keyword1;
	private String keyword2;

	private String or_and_option="or";

	private int selectPageNo=1;
	private int rowCntPerPage=20;
	
	// private String[] day;  // 배열로 받을수 있다. 아래코드와 이 코드 방식 두가지로 체크박스르 담을 수 있다.  
	private List<String> day;
	

	// -------------------------------------------------
	// getter, setter 메소드 선언
	// -------------------------------------------------
	public String getKeyword1() {
		return keyword1;
	}
	public void setKeyword1(String keyword1) {
		this.keyword1 = keyword1;
	}
	public int getSelectPageNo() {
		return selectPageNo;
	}
	public void setSelectPageNo(int selectPageNo) {
		this.selectPageNo = selectPageNo;
	}
	public int getRowCntPerPage() {
		return rowCntPerPage;
	}
	public void setRowCntPerPage(int rowCntPerPage) {
		this.rowCntPerPage = rowCntPerPage;
	}

	
	public List<String> getDay() {
		return day;
	}
	public void setDay(List<String> day) {
		this.day = day;
	}
	
	
	
	public String getKeyword2() {
		return keyword2;
	}
	public void setKeyword2(String keyword2) {
		this.keyword2 = keyword2;
	}
	
	
	public String getOr_and_option() {
		return or_and_option;
	}
	public void setOr_and_option(String or_and_option) {
		this.or_and_option = or_and_option;
	}

	


	
	







    
}
