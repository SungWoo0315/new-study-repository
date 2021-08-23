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

        // *****************************************
        // [게시판 글쓰기 화면]으로 이동하는 함수 선언
        // *****************************************
        function goBoardRegForm( ){

        location.replace('/boardRegForm.do');

        <% System.out.print("============================\r"); %>
        <% System.out.print("boardList.jsp 접속 성공!!\r"); %>
        <% System.out.print("============================\r"); %>
        
        }
	
	</script>

</head>

<body>

    <center>
    <span style="font-size:30px; font-weight: bold; color: orange;">
        boardList.jsp 접속 성공!!
    </span>
    <center>

        <hr>  
	
    <center>
        <a href="javascript:goBoardRegForm( );">[새글쓰기]</a>
    </center>

</body>
</html>