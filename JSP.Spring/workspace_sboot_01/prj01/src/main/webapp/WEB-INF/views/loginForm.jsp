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

<script src="/resources/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="/resources/common_func.js"></script>
<script src="/resources/common_data.js"></script>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>

	<script>
		
		// ***************************************************
		// 유저가 입력한 아이디와 암호의 유효성을 체크할 checkForm 함수 선언
		// ***************************************************
		function checkForm(){
			// ---------------------------------------------------
			// 변수 uid 선언. 입력한 아이디를 얻어서 변수 uid에 저장하기.
			// ---------------------------------------------------
			// class=uid 를 가진 태그를 관리하는 JQuery 객체 생성하고 val() 메소드 호출로 
			// 웹브라우저에서 상에 입력한 아이디를 가져와 리턴하기 
			// var uid = document.loginForm.uid.value; 아래와 같은 결과를 가진다 DOM 객체 사용.  
			// ---------------------------------------------------
			var id = $("[name=loginForm] .id").val();
			// ---------------------------------------------------
			// 변수 pwd 선언. 입력한 아이디를 얻어서 변수 pwd 에 저장하기.
			// ---------------------------------------------------
			// class=pwd 를 가진 태그를 관리하는 JQuery 객체 생성하고 val() 메소드 호출로 
			// 웹브라우저에서 상에 입력한 암호를 가져와 리턴하기 
			// var pwd = document.loginForm.pwd.value; 아래와 같은 결과를 가진다 DOM 객체 사용.  
			// ---------------------------------------------------
			var pwd = $("[name=loginForm] .pwd").val();

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
		}



		//*********************************************************
		// body 태그 안의 소스를 모두 실행한 후에 실행할 자스 코드 설정
		//*********************************************************
		$(document).ready(function(){
			// 로그인 버튼 클릭하면 경고상자 뜨게 클릭 이벤트를 걸기

			$("[name=loginForm] .login").click(
				function(){
					// checkForm 함수 호출하기.
					checkForm();

					//alert("클릭성공!") // 테스트용 확인.  
				}
			);

		})



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
				<td><input type="text" name="id" class="id" size="20"></td>
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