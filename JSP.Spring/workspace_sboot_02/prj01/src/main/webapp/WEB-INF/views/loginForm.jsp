<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<script src="/resources/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="/resources/common_func.js"></script>
<script src="/resources/common_data.js"></script>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>

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
        });
     	// ***************************************************
		// 유저가 입력한 아이디와 암호의 유효성을 체크할 checkForm 함수 선언
		// ***************************************************
		function checkLoginForm(){
			// ---------------------------------------------------
			// 변수 uid 선언. 입력한 아이디를 얻어서 변수 uid에 저장하기.
			// ---------------------------------------------------
			// class=uid 를 가진 태그를 관리하는 JQuery 객체 생성하고 val() 메소드 호출로 
			// 웹브라우저에서 상에 입력한 아이디를 가져와 리턴하기 
			// var uid = document.loginForm.uid.value; 아래와 같은 결과를 가진다 DOM 객체 사용.  
			// ---------------------------------------------------
			var login_id = $(".login_id").val();
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
			if( isEmpty(login_id) ) {
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
                        ,dataType : "html"
                        // ----------------------------------------------------------
                        // 서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
                        // 익명함수의 매개변수에는 서버가 보내온 html 소스가 문자열로 들어온다.
                        // 즉, 응답 메시지 안의 html 소스가 문자열로써 익명함수의 매개변수로 들어온다.  
                        // 응답 메시지 안의 html 소스는 loginProc.jsp 의 실행 결과물이다.
                        // ----------------------------------------------------------
                        ,success  : function( responseHTML ){
                            // 매개변수 responseHTML 안의 HTML 소스 문자열에 DB 연동 결과물을 뽑아
                            // 현재 화면에 반영하는 등의 소스가 나온다.
                            
                            // alert(responseHTML);  // 테스트용 확인.

                            // ------------------------------------
                            // 매개변수로 들어온 html 소스에서 class="idCnt" 를 가진 태그가 끌어안고 있는 숫자 꺼내기.
                            // 즉, 아이디, 암호의 존재 개수 꺼내기.
                            // 꺼낸 존재 개수의 앞뒤 공백 제거하기
                            // ------------------------------------
                            var idCnt = $(responseHTML).filter(".idCnt").text();
                            idCnt = $.trim(idCnt);
                            // idCnt = parseInt(idCnt,10);  // 정석적으로는 이렇게 해야 숫자변환된다. 
                            // ------------------------------------
                            // 만약 아이디, 암호의 존재가 1이면, 즉, 존재하면
                            // ------------------------------------
                            if( idCnt == 1 ){
                                alert("로그인 성공!")	// 테스트용 확인.  
                                // location.replace("/boardList.do")
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




			
		}
	
	
	</script>

</head>

<body>
	<center>
    <!-- *************************************************** -->
    <!-- [로그인 정보 입력 양식] 내포한 form 태그 선언 -->
    <!-- *************************************************** -->
    <form name="loginForm" method="post">
        
        <table border=1 style="border-collapse:collapse" cellpadding=5 >
            <caption><b>[로그인]</b></caption>
            <tr>
                <th bgcolor="lightgray" align="center">아이디</th>
                <td><input type="text" name="login_id" class="login_id" size="20"></td>
            </tr>	
            <tr>
                <th bgcolor="lightgray" align="center">암호</th>
                <td><input type="password" name="pwd" class="pwd" size="20"></td>
            </tr>
        </table>
        <table cellpadding=3>
            <tr>
                <td align=center><input type="button" value="로그인" class="login">
            </tr>
            <tr align=center>
                <td>
                    <!--<input type="checkbox" name="is_login" value="y"> 아이디,암호 기억-->
                    <span style="cursor:pointer" onClick="location.replace('/memRegForm.do')">[회원가입]</span>
            </tr>
        </table>

    </form>
    </center>
</body>
</html>