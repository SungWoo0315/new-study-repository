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
<title>BoardList</title>

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
                    

                    // location.replace("/boardRegProc.do") // boardRegProc.jsp 페이지 이동확인용.

                    alert(responseHTML) // boardRegProc.jsp 결과물 확인하기.  


                    // 매개변수 responseHTML 안의 HTML 소스 문자열에 DB 연동 결과물을 뽑아
                    // 현재 화면에 반영하는 등의 소스가 나온다.
                    
                    // alert(responseHTML);  // 테스트용 확인.

                    // ------------------------------------
                    // 매개변수로 들어온 html 소스에서 class="idCnt" 를 가진 태그가 끌어안고 있는 숫자 꺼내기.
                    // 즉, 아이디, 암호의 존재 개수 꺼내기.
                    // 꺼낸 존재 개수의 앞뒤 공백 제거하기
                    // ------------------------------------
                    var boardRegCnt = $(responseHTML).filter(".boardRegCnt").text();
                    boardRegCnt = $.trim(boardRegCnt);
                    // boardRegCnt = parseInt(boardRegCnt,10);  // 정석적으로는 이렇게 해야 숫자변환된다. 
                    // ------------------------------------
                    // 만약 아이디, 암호의 존재가 1이면, 즉, 존재하면
                    // ------------------------------------
                    if( boardRegCnt == 1 ){
                        alert("새글쓰기 성공!")	// 테스트용 확인.  
                        location.replace("/boardList.do")
                    }
                    // ------------------------------------
                    // 그렇지 않으면, 즉, 아이디, 암호가 존재하지 않으면
                    // ------------------------------------
                    else{
                        alert("새글쓰기 실패...")
                    }




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
    
        
        <!-- <input type="hidden" name="b_no" value="1"> -->
    
    
    </form>



   

</body>

</html>