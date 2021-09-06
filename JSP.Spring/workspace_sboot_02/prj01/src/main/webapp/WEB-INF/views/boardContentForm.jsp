<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!-- ***************************************************** -->
<!-- 현재 JSP 페이지에서 사용할 클래스 수입하기 -->
<!-- ***************************************************** -->
<%@ page import="com.naver.erp.BoardDTO"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<!-- *********************************************************** -->
<!-- JSP 기술의 한 종류인 [Include Directive]를 이용하여 -->
<!-- common.jsp 파일 내의 소스를 삽입하기 -->
<!-- *********************************************************** -->
<%@include file="common.jsp"%>  

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>boardContentForm</title>

   
	<script>	

        $(document).ready(function(){
            


        })
        // -----------------------------------------
        // 게시판 수정/삭제 화면으로 이동하는 함수 선언
        // -----------------------------------------
        function goBoardUpDelForm(){
            // -----------------------------------------
            // name=boardUpDelForm 을 가진 form 태그의 action 값을 URL로 서버에 접속하라
            // -----------------------------------------
            document.boardUpDelForm.submit();
        }

        // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
        // 게시판 댓글 화면으로 이동하는 함수 선언
        // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
        function goBoardRegFrom(){

        // alert("댓글쓰기 확인"); // 테스트용. 버튼 작동 확인.  

        // -----------------------------------------
        // name=boardRegForm 을 가진 form 태그의 action 값을 URL로 서버에 접속하라
        // -----------------------------------------
        document.boardRegForm.submit();



        }


        
	</script>

</head>

<body><center>
	
    <span style="font-size:30px; font-weight: bold; color: rebeccapurple;">
        boardContentForm.jsp 접속 성공!!
    </span>

        <% System.out.println("============================"); %>
        <% System.out.println("boardContentForm.jsp 접속 성공!!"); %>
        <% System.out.println("============================"); %>

        <hr> 

        
    <%
        BoardDTO boardDTO = (BoardDTO)request.getAttribute("boardDTO");
        int b_no = 0;
        if( boardDTO!=null ){
            b_no = boardDTO.getB_no();
            String subject = boardDTO.getSubject();
            String writer = boardDTO.getWriter();
            String reg_date = boardDTO.getReg_date();
            String content = boardDTO.getContent();
            int readcount = boardDTO.getReadcount();
            String email = boardDTO.getEmail();
    %>

    <b>[글 상세 보기]</b>

    <div style="height: 10px;"></div> <!-- 공백조절용 div 태그 -->

    <table border="1" style="border-collapse:collapse" cellpadding=5>
        <tr align="center">
            <th bgcolor="lightgray">글번호</th>
            <td><%=b_no%></td>
            <th bgcolor="lightgray">조회수</th>
            <td><% out.print(readcount); %></td>
        </tr>
        <tr align="center">
            <th bgcolor="lightgray">작성자</th>
            <td><% out.print(writer); %></td>
            <th bgcolor="lightgray">작성일</th>
            <td><% out.print(reg_date); %></td>
        </tr>
        <tr align="center">
            <th bgcolor="lightgray">글제목</th>
            <td colspan="3"><% out.print(subject); %></td>
        </tr>
        <tr align="center">
            <th bgcolor="lightgray">글내용</th>
            <td colspan="3">
                <textarea name="content" rows="13" cols="45" style="border: 0;" readonly><%out.print(content);%></textarea></td>
        </tr>



    </table><br>
    <input type="button" value="댓글쓰기" onclick="goBoardRegFrom();">&nbsp;
    <input type="button" value="수정/삭제" onclick="goBoardUpDelForm();">&nbsp;
    <input type="button" value="글 목록 보기" onclick="location.replace('/boardList.do')">

 
   
    <%
    }
    else{
        out.print("<script>alert('삭제된 글입니다.'); location.replace('/boardList.do');</script>");
    }
    %>

    <!-- ****************************************************** -->
    <!-- [게시판 수정/삭제] 화면으로 이동하는 form 태그 선언 -->
    <!-- ****************************************************** -->
    <form name="boardUpDelForm" method="POST" action="/boardUpDelForm.do">
        <input type="hidden" name="b_no" value="<%=b_no%>">
    </form>

    <hr> 

    <!-- ****************************************************** -->
    <!-- [게시판 댓글쓰기] 화면으로 이동하는 form 태그 선언 -->
    <!-- ****************************************************** -->
    <form name="boardRegForm" method="POST" action="/boardRegForm.do">
        <input type="hidden" name="b_no" value="<%=b_no%>">
    </form>

</body>
</html>