<!-- ******************************************************** -->
<!-- JSP 기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리 방식 선언하기 -->
<!-- ******************************************************** -->
    <!-- 현재 이 JSP 페이지 실행 후 생성되는 문서는 HTML 이고, 이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다라고 설정함 -->
    <!-- 현재 이 JSP 페이지는 UTF-8 방식으로 인코딩 한다. -->
    <!-- UTF-8 인코딩 방식은 한글을 포함 전 세계 모든 문자열ㅇ르 부호화 할 수 있는 방법이다.  -->
    <!-- 모든 JSP 페이지 상단에는 무조건 아래 설정이 들어간다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<!-- --------------------------------------------------------------------- -->
<!-- JQuery 라이브러리 수입하기 -->
<!-- --------------------------------------------------------------------- -->
<script src="/resources/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="/resources/common_func.js"></script>
<script src="/resources/common_data.js"></script>

<!-- --------------------------------------------------------------------- -->
<!-- CSS 파일 수입하기 -->
<!-- --------------------------------------------------------------------- -->
<link href="/resources/common.css" rel="stylesheet" type="text/css">



<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>

    <script>
        
        //*********************************************************
        // body 태그 안의 소스를 모두 실행한 후에 실행할 자스 코드 설정
        //*********************************************************
        $(document).ready(function(){
            // ----------------------------------------
            // 로그인 버튼 클릭하면 로그인 버튼에 클릭 이벤트를 걸기
            // click 이벤트 발생 시 실행할 코드 설정하기  
            // ----------------------------------------
            $("[name=loginForm] .login").click(
                function(){
                    // 아이디와 암호의 유효성 체크하는 
                    // checkLoginForm() 함수 호출하기.
                    checkLoginForm();

                    //alert("클릭성공!") // 테스트용 확인.  
                });


            // 테스트용 자동입력
            // $('.login_id').val("abc");
            // $('.pwd').val("123");

        });
        // ***************************************************
        // 로그인 정보 유효성 체크하고 비동기 방식으로 서버와 통신하여
        // 로그인 정보와 암호의 존재 여부에 따른 자스 코드 실행하기.
        // ***************************************************
        function checkLoginForm(){		
            // ---------------------------------------------------
            // 입력된 [아이디]를 가져와 변수에 저장
            // ---------------------------------------------------
            var login_id = $('.login_id').val();
            // 아이디를 입력 안했거나 공백으로 이루어져 있으면
            // 아이디 입력란을 비우고 경고하고 함수 중단.  
            if(login_id.split(" ").join("")==""){
                alert("로그인 아이디 입력 요망");
                $('.login_id').val("");
                $('.login_id').focus();
                return;
            }
            // ---------------------------------------------------
            // 입력된 [암호]를 가져와 변수에 저장
            // ---------------------------------------------------
            var pwd = $('.pwd').val();
            // 암호 입력 안했거나 공백으로 이루어져 있으면
            // 암호 입력란을 비우고 경고하고 함수 중단.  
            if(pwd.split(" ").join("")==""){
                alert("암호 입력 요망");
                $('.pwd').val("");
                $('.pwd').focus();
                return;
            }


            // ---------------------------------------------------
            // 현재 화면에서 페이지 이동 없이(=비동기 방식으로)
            // 서버쪽 loginProc.do 로 접속하여 아이디, 암호의 존재 개수를 얻기
            // ---------------------------------------------------
            // alert($("[name=loginForm]").serialize())  // 테스트. 확인용.  
            // return;  // 테스트. 확인용. 
            $.ajax(
                    {
                        // ----------------------------------------------------------
                        // 서버쪽 호출 URL 주소 지정
                        // ----------------------------------------------------------
                        url       : "/loginProc.do"
                        // ----------------------------------------------------------
                        // form 태그 안의 입력양식 데이터 즉, 파라미터값을 보내는 방법 지정
                        // ----------------------------------------------------------
                        ,type     : "post"
                        // ----------------------------------------------------------
                        // 서버로 보낼 파라미터명과 파라미터값을 설정. 
                        // 즉, 입력한 아이디와 암호, 아이디/암호 기억체크여부를 지정
                        // ----------------------------------------------------------
                        ,data     : $("[name=loginForm]").serialize() 
                            // 위 설정은 아래 처럼도 가능
                            //"id=" + id + "&pwd=" + pwd
                            // ,data : {'id':id, 'pwd':pwd}   // JSON 형태로도 가능.
                        // ----------------------------------------------------------
                        // 서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
                        // 익명함수의 매개변수에는 서버가 보내온 아이디 암호의 존재 개수가 들어온다.
                        // ----------------------------------------------------------
                        ,success  : function( idCnt ){
                            // ------------------------------------
                            // 만약 아이디, 암호의 존재가 1이면, 즉, 존재하면
                            // ------------------------------------
                            if( idCnt == 1 ){
                                alert("로그인 성공!")	// 테스트용 확인.  
                                location.replace("/boardList.do")
                            }
                            // ------------------------------------
                            // 그렇지 않으면, 즉, 아이디, 암호가 존재하지 않으면
                            // ------------------------------------
                            else{
                                alert("로그인 실패...")
                            }

                        }
                        // ----------------------------------------------------------
                        // 서버의 응답을 못 받았을 경우 실행할 익명함수 설정
                        // ----------------------------------------------------------
                        ,error    : function( ){
                            alert("서버 접속 실패! 관리자에게 문의 바람!");
                        }
                    }
            );





/*  공용함수 사용한것.  
            // ---------------------------------------------------
            // 변수 uid 선언. 입력한 아이디를 얻어서 변수 uid에 저장하기.
            // ---------------------------------------------------
            // class=uid 를 가진 태그를 관리하는 JQuery 객체 생성하고 val() 메소드 호출로 
            // 웹브라우저에서 상에 입력한 아이디를 가져와 리턴하기 
            // var uid = document.loginForm.uid.value; 아래와 같은 결과를 가진다 DOM 객체 사용.  
            // ---------------------------------------------------
            var id = $(".id").val();
            // ---------------------------------------------------
            // 변수 pwd 선언. 입력한 아이디를 얻어서 변수 pwd 에 저장하기.
            // ---------------------------------------------------
            // class=pwd 를 가진 태그를 관리하는 JQuery 객체 생성하고 val() 메소드 호출로 
            // 웹브라우저에서 상에 입력한 암호를 가져와 리턴하기 
            // var pwd = document.loginForm.pwd.value; 아래와 같은 결과를 가진다 DOM 객체 사용.  
            // ---------------------------------------------------
            var pwd = $(".pwd").val();

            //------------------------------------------------------
            // 만약에 유저가 입력한 아이디가 비어있거나 공백으로 이루어져있으면
            // isEmpty 함수 호출하여 true 를 리턴받으면, 즉, 비어있거나 공백으로 이루어져 있으면
            //------------------------------------------------------
            if( isEmpty(id) ) {
                // 경고 상자 띄우기
                alert("아이디가 비어있음. 입력바람.");
                // 함수 중단하기. 이후 코딩은 실행되지 않는다.  
                return;
            }
            //------------------------------------------------------
            // 만약에 유저가 입력한 암호가 비어있으면 
            //------------------------------------------------------
            if( isEmpty(pwd) ){
                // 경고 상자 띄우기
                alert("암호가 비어있음. 입력바람.");
                // 함수 중단하기. 이후 코딩은 실행되지 않는다.
                return;
            }
            //------------------------------------------------------
            // 만약에 아이디가 "abc" 이고 암호가 123이면  // DB 연동했다고 가정.
            //------------------------------------------------------
            if( id=="abc" && pwd=="123" ){

                if( confirm("로그인할까요?") ){
                    // form 태그의 설정한 서버쪽 URL 주소로 서버로 접근하기. 즉, 새로운 페이지를 열기.
                    document.loginForm.submit();
                }
            }else{
                alert( "아이디 또는 암호가 틀렸음! 재입력 바람" );
                //------------------------------------------------------
                // 아이디 입력란 비우기
                //------------------------------------------------------
                // class=uid 를 가진 태그를 관리하는 JQuery 객체 생성하고 val("") 메소드 호출로 
                // 웹브라우저에서 상 아이디 입력란에 "" 삽입하기.
                //------------------------------------------------------
                // document.loginForm.uid.value = "";	// JQuery 로 대체
                //------------------------------------------------------
                $("[name=loginForm] .id").val("")

                //------------------------------------------------------
                // 암호 입력란 비우기
                //------------------------------------------------------
                // class=pwd 를 가진 태그를 관리하는 JQuery 객체 생성하고 val("") 메소드 호출로 
                // 웹브라우저에서 상 암호 입력란에 "" 삽입하기.
                //------------------------------------------------------
                // document.loginForm.pwd.value = "";	// JQuery 로 대체
                //------------------------------------------------------
                $("[name=loginForm] .pwd").val("")

            }
            alert(id + " / " + pwd)		
*/
        }



    </script>



</head>
<body>
    <center>
    <!-- *************************************************** -->
    <!-- [로그인 정보 입력 양식] 내포한 form 태그 선언 -->
    <!-- *************************************************** -->
    <form name="loginForm" method="post">
        
        <table class="tbcss2" border=1 style="border-collapse:collapse" cellpadding=5 >
            <caption><b>[로그인]</b></caption>
            <tr>
                <th bgcolor="lightgray" align="center">아이디</th>
                <td><input type="text" name="login_id" class="login_id" size="20" value="${cookie.login_id.value}"></td>
            </tr>	
            <tr>
                <th bgcolor="lightgray" align="center">암호</th>
                <td><input type="password" name="pwd" class="pwd" size="20" value="${cookie.pwd.value}"></td>
            </tr>
        </table>
        <table cellpadding=3>
            <tr align=center>
                <td>
                    <input type="button" value="로그인" class="login">
                    <input type="checkbox" name="is_login" value="yes" ${empty cookie.login_id.value?'':'checked'}>아이디/암호 기억

            </tr>
            <tr align=center>
                <td>
                    <!-- <input type="checkbox" name="is_login" value="y"> 아이디,암호 기억 -->
                    <span style="cursor:pointer" onClick="location.replace('/memRegForm.do')">[회원가입]</span>
            </tr>
        </table>


    </form>
    </center>

    <!-- 세션 테스트용. -->
    <a href="http://localhost:8081/boardList.do" style="cursor:pointer">localhost:8081/boardList.do</a> <br>
    <a href="http://localhost:8081/boardRegForm.do" style="cursor:pointer">localhost:8081/boardRegForm.do</a> <br>
    <a href="http://localhost:8081/boardContentForm.do/?b_no=1" style="cursor:pointer">localhost:8081/boardContentForm.do</a> <br>
    <a href="http://localhost:8081/boardUpDelForm.do/?b_no=1" style="cursor:pointer">localhost:8081/boardUpDelForm.do</a> <br>
    
    <hr>

    <span style="cursor: pointer;" onclick="location.replace('/boardList.do')">localhost:8081/boardList.do</span><br>
</body>

</html>