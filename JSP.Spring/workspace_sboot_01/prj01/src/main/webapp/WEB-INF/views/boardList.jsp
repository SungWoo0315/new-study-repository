<!-- ******************************************************** -->
<!-- JSP 기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리 방식 선언하기 -->
<!-- ******************************************************** -->
    <!-- 현재 이 JSP 페이지 실행 후 생성되는 문서는 HTML 이고, 이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다라고 설정함 -->
    <!-- 현재 이 JSP 페이지는 UTF-8 방식으로 인코딩 한다. -->
    <!-- UTF-8 인코딩 방식은 한글을 포함 전 세계 모든 문자열ㅇ르 부호화 할 수 있는 방법이다.  -->
    <!-- 모든 JSP 페이지 상단에는 무조건 아래 설정이 들어간다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!-- ************************************************** -->
<!-- 현재 JSP 페이지에서 사용할 클래스의 패키지 수입하기 -->
<!-- ************************************************** -->
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<script src="/resources/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="/resources/common_func.js"></script>
<script src="/resources/common_data.js"></script>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BoardList</title>

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

    <div style="height: 10px;"></div> <!-- 공백조절용 div 태그 -->
    

    <table border="1" style="border-collapse:collapse" cellpadding=5>
        <tr><th>번호</th><th>제목</th><th>작성자</th><th>조회수</th><th>등록일</th></tr>


    

    <%
        List<Map<String,String>> boardList = (List<Map<String,String>>)request.getAttribute("boardList");

        if( boardList!=null){

            int totCnt = boardList.size();

            for( int i=0; i<boardList.size(); i++ ){

                Map<String,String> map = boardList.get(i);
                String b_no = map.get("b_no");
                String subject = map.get("subject");
                String writer = map.get("writer");
                String readcount = map.get("readcount");
                String reg_date = map.get("reg_date");
                String print_level = map.get("print_level");

                int print_level_int = Integer.parseInt(print_level,10);

                String xxx = "";

                for( int j=0; j<print_level_int; j++){

                    xxx = xxx + "&nbsp;&nbsp;&nbsp;";
                }
                if( print_level_int > 0 ){xxx = xxx + "↘"; }
                out.println("<tr><td>"+ (totCnt--) +"<td>" + xxx + subject + "<td>"+writer+"<td>"+readcount+"<td>"+reg_date);

            }
        }    
    %>
    </table>


    </center>

</body>

</html>