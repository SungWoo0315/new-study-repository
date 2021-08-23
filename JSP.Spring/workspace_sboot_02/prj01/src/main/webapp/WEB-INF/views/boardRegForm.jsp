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

        <% System.out.print("============================\r"); %>
        <% System.out.print("boardRegForm.jsp 접속 성공!!!\r"); %>
        <% System.out.print("============================\r"); %>

        // ***************************************************
        // [게시판 등록 화면]에 입력된 데이터의 유효성 체크를 자스로 하지 않고
        // 비동기 방식으로 서버에 "boardRegProc.do" 로 접속하는 함수 선언
        // ***************************************************
        function checkBoardRegForm(){
            // ------------------------------------
            // "정말 등록 하시겠습니까?" 라고 물어보기
            // ------------------------------------
            if(confirm("정말 등록 하시겠습니까??")==false) {return;}


            alert( $("[name=boardRegForm]").serialize()  ); // serialize 확인용 테스트 
            // return;                                         // serialize 확인용 테스트 
            // --------------------------------------------
            // 현재 화면에서 페이지 이동 없이(=비동기방식으로)
            // 서버쪽 boardRegProc.do 로 접속하여 게시판 글쓰기를 하고 
            // 글쓰기 성공 여부를 알려주기  
            // --------------------------------------------
            $.ajax({

                // ----------------------------------------------------------
                // 서버쪽 호출 URL 주소 지정
                // ----------------------------------------------------------
                url       : "/boardRegProc.do"
                // ----------------------------------------------------------
                // form 태그 안의 입력양식 데이터 즉, 파라미터값을 보내는 방법 지정
                // ----------------------------------------------------------
                ,type     : "post"
                // ----------------------------------------------------------
                // 서버로 보낼 파라미터명과 파라미터값을 설정. 
                // ----------------------------------------------------------
                ,data     : $("[name=boardRegForm]").serialize() 
                    
                ,dataType : "html"
                // ----------------------------------------------------------
                // 서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
                // 익명함수의 매개변수에는 서버가 보내온 html 소스가 문자열로 들어온다.
                // 즉, 응답 메시지 안의 html 소스가 문자열로써 익명함수의 매개변수로 들어온다.  
                // 응답 메시지 안의 html 소스는 loginProc.jsp 의 실행 결과물이다.
                // ----------------------------------------------------------
                ,success  : function( responseHTML ){
                    
                    location.replace("/boardRegProc.do")

                    alert(responseHTML) // boardRegProc.jsp 결과물 확인하기.  

                }
                // ----------------------------------------------------------
                // 서버의 응답을 못 받았을 경우 실행할 익명함수 설정
                // ----------------------------------------------------------
                ,error : function( ){
                    alert("서버 접속 실패! 관리자에게 문의 바람!");
                }


            });

        }
	
	</script>

</head>

<body><center>
	
    <span style="font-size:30px; font-weight: bold; color: rebeccapurple;">
        boardRegForm.jsp 접속 성공!!
    </span>

        <hr> 

    <!-- **************************************************** -->
    <!-- [게시판 글쓰기] 화면을 출력하는 form 태그 선언 -->
    <!-- **************************************************** -->
    <form name="boardRegForm" method="POST" action="/boardRegProc.do">
    
        <table border="1" style="border-collapse:collapse" cellpadding=5>
            <caption>새글쓰기</caption>
            <tr>
                <th bgcolor="lightgray">이  름</th>
                <td>
                <!-- ------------------------------------------------- -->
                <input type="text" size="10" name="writer" maxlength="10">
                <!-- ------------------------------------------------- -->
                </td>
            </tr>
            <tr>
                <th bgcolor="lightgray">제  목</th>
                <td>
                <!-- ------------------------------------------------- -->
                <input type="text" size="40" name="subject" maxlength="30">
                <!-- ------------------------------------------------- -->
                </td>
            </tr>
            <tr>
                <th bgcolor="lightgray">이메일</th>
                <td>
                <!-- ------------------------------------------------- -->
                <input type="text" size="40" name="email" maxlength="30">
                <!-- ------------------------------------------------- -->
                </td>
            </tr>
            <tr>
                <th bgcolor="lightgray">이메일</th>
                <td>
                <!-- ------------------------------------------------- -->
                <textarea name="content" rows="13" cols="40"  maxlength="300"></textarea>
                <!-- ------------------------------------------------- -->
                </td>
            </tr>
            <tr>
                <th bgcolor="lightgray">비밀번호</th>
                <td>
                <!-- ------------------------------------------------- -->
                <input type="password" size="8" name="pwd" maxlength="4">
                <!-- ------------------------------------------------- -->
                </td>
            </tr>
        </table>
        <div style="height: 6px;"></div> <!-- 공백조절용 div 태그 -->
        <input type="button" value="저장" onclick="checkBoardRegForm()">
        <input type="reset" value="다시작성">
        <input type="button" value="목록보기" onclick="document.boardListForm.submit();">
        
</form>
    
        



</body>
</html>