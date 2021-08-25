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

        $(document).ready(function(){
            <% System.out.println("============================"); %>
            <% System.out.println("boardContentForm.jsp 접속 성공!!"); %>
            <% System.out.println("PK 값 출력 => " + (int)request.getAttribute("b_no") ); %>
            <% System.out.println("============================"); %>
        })
        
	</script>

</head>

<body><center>
	
    <span style="font-size:30px; font-weight: bold; color: rebeccapurple;">
        boardRegForm.jsp 접속 성공!!
    </span>

        <hr> 

        
    <%
        out.print(  (int)request.getAttribute("b_no") );
    %>


    <hr> 
    <input type="button" value="목록보기" onclick="location.replace('/boardList.do')">
   


</body>
</html>