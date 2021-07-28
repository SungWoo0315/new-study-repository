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
    // ---------------------------------------
    // 학생 번호를 매개변수 입력 받아 속성변수 s_no 에 저장하는 메소드 선언.
    // 속성변수 s_no 에 저장만 하고 이 메소드 호출한놈한테는 리턴할게 없으므로 
    // 메소드 앞에 리턴형은 void 로 설정한다.   
    // ---------------------------------------
    public void setStu_no(int stu_no){
        // 속성변수 stu_no 에 메소드의 매개변수 stu_no 안의 데이터를 저장하기.
        // 속성변수 명과 매개변수 같은 경우 혼동을 피하기 위해 속성변수 앞에 this. 을 붙인다. 
        this.stu_no = stu_no;
    }
    // ---------------------------------------
    // 학생번호를 리턴하는 메소드 선언.
    // 이 메소드를 호출하는 놈한테는 stu_no 변수 안의 데이터를 리턴한다는 의미에서 메소드 왼쪽에 int 를 붙인다.
    // ---------------------------------------
    public int getStu_no( ){
        // 속성변수 stu_no 안의 데이터 리턴하기.
        return this.stu_no;
    }
    // ---------------------------------------
    // 학생이름을 매개변수 입력 받아 속성변수 stu_name 에 저장하는 메소드 선언.
    // 속성변수 stu_name 에 저장만 하고 이 메소드 호출한놈한테는 리턴할게 없으므로 
    // 메소드 앞에 리턴형은 void 로 설정한다.
    // ---------------------------------------
    public void setStu_name(String stu_name){
        this.stu_name = stu_name;
    }
    // ---------------------------------------
    // 학생이름을 리턴하는 메소드 선언.
    // 이 메소드를 호출하는 놈한테는 stu_name 변수 안의 데이터를 리턴한다는 의미에서 메소드 왼쪽에 String 을 붙인다.
    // ---------------------------------------
    public String getStu_name( ){
        return this.stu_name;
    }
    // ---------------------------------------
    // 주민번호 를 매개변수 입력 받아 속성변수 stu_name 에 저장하는 메소드 선언.
    // 속성변수 jumin_num 에 저장만 하고 이 메소드 호출한놈한테는 리턴할게 없으므로 
    // 메소드 앞에 리턴형은 void 로 설정한다.
    // ---------------------------------------
    public void setjumin_num(String jumin_num){
        this.jumin_num = jumin_num;
    }
    // ---------------------------------------
    // 주민번호 를 리턴하는 메소드 선언.
    // 이 메소드를 호출하는 놈한테는 jumin_num 변수 안의 데이터를 리턴한다는 의미에서 메소드 왼쪽에 String 을 붙인다.
    // ---------------------------------------
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
        속성변수에는     동료 속성변수/메소드/생성자에서 공용으로 사용할 데이터가 저장된다.
        메소드에는       실행 코드(=실행구문)가 저장된다.
        생성자는         객체 생성 시 단 한번 호출되는 것으로, 외부에서 데이터가 들어온다.
                        외부에서 데이터 들어오지 않으면 메소드의 리턴값은 항성 일정하다.
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

**************************************
<2> void 키워드의 의미?
**************************************
    메소드명 왼쪽에 나오는 키워드이다.
    이 메소드를 호출하는 놈은 어떤 데이터도 선물 받을 수 없어!


**************************************
<3> int getStu_no( ){~} 에서 getStu_no 왼쪽의 int 의미?
**************************************
    이 메소드를 호출하는 놈은 int 형의 데이터를 선물 받을 수 있어!


**************************************
<4> return this.stu_no; 의 의미?
**************************************
    return this.stu_no; 를 가진 메소드를 호출한 놈은 속성변수 stu_no 안의 데이터를 선물 받는다.


**************************************
<5> 생성자 public Student( ~ ){~} 를 생략해도 되는가?
**************************************
    생성자는 0개 이상 선언이 가능하다.
    ------------------------------------
    생성자를 코딩상 생략하면 정말 존재하는 생성자는 0개 인가? 즉 없는가?
    ------------------------------------
    코딩상 생성자를 생략하면 자바는 기본생성자를 넣어준다.
    위 클래스에서 생성자를 생략하면 public Student( ){ } 가 컴파일 할 때 삽입된다.
    즉, 코딩상 0개 이상이지만 실존상으로는 1개이상이다.
    생성자는 없어선 안될 존재이다.


**************************************
<6> 메소드 안의 실행구문은 언제 실행되나?
**************************************
    누군가가 이 클래스를 객체화 한 후    객체의메위주.메소드(~)    형식으로 호출할 때 실행된다.  


**************************************
<7> 속성변수의 선언 형식은 어떻게되나?   // 아래의 [] 는 생략의 의미.
**************************************
    ---------------------------------------------------------------------------------------------------------
    public|protected|default|private  [static] [final]  기본자료형|클래스명|인터페이스명  속성변수명 [=데이터];
    ---------------------------------------------------------------------------------------------------------
        ---------------------------------
        public|protected|default|private
        ---------------------------------
            접근지정자
                ▶ 타 클래스 메소드에서 [속성변수의 호출 가능 여부]를 지정한다.
                ▶ 관용적으로 대부분 [속성변수]는 private 를 붙여 타 클래스에서 직접 호출을 막는다. 

            public 
                동일한 패키지 또는, 타 패키지안의 타 클래스에서 모두 호출을 허락.

            default
                동일한 패키지의 타 클래스에서만 호출을 허락. 타 패키지안의 타 클래스에서는 호출을 할수 없음. 타 패키지 클래스의 배척!
                
            protected    
                자식이라면 타 패키지라도 호출 가능. 자식이 아니라면 타 패키지에서 호출불가. 같은 패키지 안에서만 호출가능. 
                    
            private    
                모든 타 클래스에서는 호출을 할 수 없음. 모든 타 클래스의 배척! 

        ---------------------------------
        static
        ---------------------------------
            시험문제 타겟!
            --------------------------------------------------------------------
            <의미1> static 이 붙은 속성변수는 객체생성없이 아래 처럼 호출이 가능하다. 
            --------------------------------------------------------------------
                ---------------------------------
                클래스명.속성변수
                ---------------------------------
                    ---------------------------------
                    <참고> 원래 속성변수나 메서드는 아래와 같은 절차를 거쳐 호출이 된다.  
                    ---------------------------------                 
                        클래스명    객체참조변수명  =   new 생성자명(~);
                        객체참조변수명.속성변수
                        객체참조변수명.메서드명(~)
                    ---------------------------------
            --------------------------------------------------------------------
            <의미2> static 이 붙은 속성변수를 가진 클래스를 new 를 사용해여 2개 이상 객체화 했을 때
                    객체끼리 이 static 이 붙은 속성변수를 서로 공유한다.   
            --------------------------------------------------------------------

        ---------------------------------
        final
        ---------------------------------
            시험문제 타겟!
            --------------------------------------------------------------------
            <의미> final 이 붙은 속성변수는 처음 데이터를 저장한 후에는 절대 수정이 불가능하다.
            --------------------------------------------------------------------
            불변규칙, 과학적 불변 데이터 인 경우 수정을 불가능하게 하기 위함이다.  
            <예> 원주율 3.14, 회사규칙 중 불변, 직원수는 10000이하.
            --------------------------------------------------------------------
            <주의> final 이 붙은 속성변수는 자동 초기화가 될 수 없다.  
                   그러므로, 속성변수를 선언할 때 데이터를 저장하거나,
                   생성자 안에서 저장하는 코딩이 반드시 나와야 한다.  
                    
            <주의> final 이 안 붙은 속성변수는 자동 초기화가 될 수 있다.  





















*/