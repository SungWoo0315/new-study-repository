<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm -->
<!-- JSP 페이지에서 사용할 [사용자 정의 태그]의 한 종류인 [JSTL의 C 코어 태그]를 사용하겠다고 선언 -->
<!-- mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!--
		--------------------------------------
		JSTL 이란?
		--------------------------------------
			=>자카르타라는 단체에서 만든 [사용자 정의 태그]를 말한다.
			=>자바 문법을 HTML 과 같은 태그 형태로 표현한다.
			=>HTML 과 같은 태그 형태로 표현하면 뒤에서 자바 문법으로 바뀌어 실행된다.
			=>JSTL 사용 장점
				-태그 형태이므로 디자이너 퍼블리셔, 초급 개발자가 접근이 쉽다.
				-큰 에러가 아닌 이상 화면이 멈추지 않는다.
				-null 처리에 대해 관대하다. null에 대해 민감한 반응을 보이지않는다. 
			=>JSTL 은 EL 과 같이 쓰인다.
	-->


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>common</title>


	
<script src="/resources/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="/resources/common_func.js"></script>
<script src="/resources/common_data.js"></script>

<script>
	$(document).ready(function(){
		$("body").prepend(    
			"<center><div><span style='cursor:pointer' "
			   + "onclick='location.replace(\"/logout.do\");'>[로그아웃]</span></div></center>"
		);
	});
</script>

</head>

<body>
	
	
</body>
</html>