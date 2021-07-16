//***************************************
// 클래스의 소속 패키지명을 선언
// 모든 자바 클래스 상단에는 무조건 소속 패키지명 선언이 나온다.
//***************************************
package com.naver.erp;


//***************************************
// Student 라는 이름의 클래스 선언.
// 클래스는 자바에서 단위 프로그램의 중의 하나이다.  
//***************************************
class Student {

    // --------------------------
    // 속성변수(=멤버변수) 선언하기
    // --------------------------
    private int stu_no;
    private String stu_name;
    private String jumin_num;
    // private double weight;
    // private double tall;
    
    // --------------------------
    // 생성자 선언하기
    // --------------------------
    public Student(int stu_no, String stu_name, String jumin_num){
        this.stu_no = stu_no;
        this.stu_name = stu_name;
        this.jumin_num = jumin_num;
    }
    // --------------------------
    // 메소드 선언하기
    // --------------------------
    public void setStu_no(int stu_no){
        this.stu_no = stu_no;
    }
    public int getStu_no( ){
        return this.stu_no;
    }
    public void setStu_name(String stu_name){
        this.stu_name = stu_name;
    }
    public String getStu_name( ){
        return this.stu_name;
    }
    public void setjumin_num(String jumin_num){
        this.jumin_num = jumin_num;
    }
    public String getjumin_num( ){
        return this.jumin_num;
    }
}
/*
**************************************
<1> 자바에서 최소단위 프로그램은?
**************************************
    ----------------------
    클래스(=class)
    ----------------------
        ------------------------------------------------------ 
        속성변수(=멤버변수), 생성자, 메소드 로 구성되어 있다.
        ------------------------------------------------------ 
        속성변수에는 동료 속성변수/메소드/생성자에서 공용으로 사용할 데이터가 저장된다.
        메소드에는 실행 코드(=실행구문)가 저장된다.
        생성자는 객체 생성 시 단 한번 호출되는 것으로, 외부에서 데이터가 들어온다.
        ------------------------------------------------------ 
        클래스 객체의 전신이다. 즉, 객체를 생성하기 위한 단위 프로그램이다.
    ----------------------
    인터페이스(=interface) 
    ----------------------
        public, static, final 의 성격을 가진 속성변수와 
        public, abstract 의 성격을 가진 메소드로만 구성된 단위 프로그램이다.
        <주의> 생성자가 없다.  
        객체 생성 목적으로 만들어지지 않았다.  
        클래스의 설계도 역할을 한다.  

*/