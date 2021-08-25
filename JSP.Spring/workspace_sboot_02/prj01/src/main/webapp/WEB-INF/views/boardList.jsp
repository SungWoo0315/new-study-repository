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

        // *****************************************
        // [게시판 상세보기 화면]으로 이동하는 함수 선언
        // *****************************************
        function goBoardContentForm( b_no ){

        // alert("상세보기 화면 활성화 성공! PK 번호는 => " + b_no) // 테스트 확인용. PK 번호 확인.  

        // ---------------------------------------
        // name=boardContentForm 가진 form 태그 내부의 name=b_no 가진 입력 양식에 클릭한 행의 
        // 게시판 번호 저장하기
        // ---------------------------------------
        $("[name=boardContentForm] [name=b_no]").val(b_no) 
        // ---------------------------------------
        // name=boardContentForm 가진 form 태그 내부의 action 값의 URL 주소로 서버에 접속하기
        // 즉, 상세보기 화면으로 이동하기  
        // ---------------------------------------
        document.boardContentForm.submit();

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
                        
                        xxx = xxx + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                    }
                    if( print_level_int > 0 ){xxx = xxx + " &#10551; "; }
                    out.println("<tr style='cursor: pointer;' onclick='goBoardContentForm("+b_no+")'><td>"+ (totCnt--) +"<td>" +  xxx + subject + "<td>"+writer+"<td>"+readcount+"<td>"+reg_date);
                }
            }
        %>
        </table>

        <!-- ********************************************************* -->
        <!-- 게시판 상세보기 화면 이동하는 form 태그 선언하기 -->
        <!-- ********************************************************* -->
        <form name="boardContentForm" method="post" action="/boardContentForm.do">
            <!-- ------------------------------------------------------ -->
            <!-- [클릭한 게시판 글의 고유번호]가 저장되는 [hidden 입력양식] 선언. -->
            <!-- ------------------------------------------------------ -->
            <input type="text" name="b_no">  


        </form>

    </center>

</body>
</html>