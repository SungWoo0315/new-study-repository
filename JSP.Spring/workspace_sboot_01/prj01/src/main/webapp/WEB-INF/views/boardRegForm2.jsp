<!-- ******************************************************** -->
<!-- JSP 기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리 방식 선언하기 -->
<!-- ******************************************************** -->
    <!-- 현재 이 JSP 페이지 실행 후 생성되는 문서는 HTML 이고, 이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다라고 설정함 -->
    <!-- 현재 이 JSP 페이지는 UTF-8 방식으로 인코딩 한다. -->
    <!-- UTF-8 인코딩 방식은 한글을 포함 전 세계 모든 문자열ㅇ르 부호화 할 수 있는 방법이다.  -->
    <!-- 모든 JSP 페이지 상단에는 무조건 아래 설정이 들어간다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- *********************************************************** -->
<!-- JSP 기술의 한 종류인 [Include Directive]를 이용하여 -->
<!-- common.jsp 파일 내의 소스를 삽입하기 -->
<!-- *********************************************************** -->
<%@include file="common.jsp"%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>




<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>boardRegForm2</title>

    <script>

        // 테스트용 입력양식 고정값 넣어주는 코드.  
        // 테스트가 끝나면 지우면 된다. 
        // 주석처리하면 소스보기에서 보여지기 때문에 지우는것이 좋다.   
        $(document).ready(function(){

            // writer subject email content pwd
            $(".writer").val("테스트");
            $(".subject").val("테스트 제목~~");
            $(".email").val("abc@naver.com");
            $(".content").val("테스트 내용을 쓰고있습니다.");
            $(".pwd").val("1234");
        })

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

                    var msg = $(responseHTML).filter(".msg").text();
                    msg = $.trim(msg);

                    if( msg!=null && msg.length>0 ){
                        alert(msg);
                        return;
                    }
                    

                    // location.replace("/boardRegProc.do") // boardRegProc.jsp 페이지 이동확인용.

                    alert(responseHTML) // boardRegProc.jsp 결과물 확인하기.  


                    // 매개변수 responseHTML 안의 HTML 소스 문자열에 DB 연동 결과물을 뽑아
                    // 현재 화면에 반영하는 등의 소스가 나온다.
                    
                    // alert(responseHTML);  // 테스트용 확인.

                    // ------------------------------------
                    // 매개변수로 들어온 html 소스에서 class="idCnt" 를 가진 태그가 끌어안고 있는 숫자 꺼내기.
                    // 게시판 글 입력 성공 행의 개수 꺼내기.
                    // 꺼낸 개수의 앞뒤 공백 제거하기
                    // ------------------------------------
                    var boardRegCnt = $(responseHTML).filter(".boardRegCnt").text();
                    boardRegCnt = $.trim(boardRegCnt);
                    boardRegCnt = parseInt(boardRegCnt,10);  // 정석적으로는 이렇게 해야 숫자변환된다. 
                    // ------------------------------------
                    // 만약 게시판 글 입력 성공 행의 개수가 1이면, 즉, 입력이 성공했으면
                    // ------------------------------------
                    if( boardRegCnt==1 ){

                        <c:if test="${empty param.b_no}">
                            alert("새글 쓰기 성공!")  
                        </c:if>

                        <c:if test="${!empty param.b_no}">
                            alert("댓글 쓰기 성공!")
                        </c:if>

                        location.replace("/boardList.do")
                    } 
                    else{
                        <c:if test="${empty param.b_no}">
                            alert("새글쓰기 실패...")
                        </c:if>

                        <c:if test="${!empty param.b_no}">
                            alert("댓글 쓰기 실패...")
                        </c:if>

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
        boardRegForm2.jsp 접속 성공!!
    </span>
    

        <hr> 

    <!-- **************************************************** -->
    <!-- [게시판 글쓰기] 화면을 출력하는 form 태그 선언 -->
    <!-- **************************************************** -->
    <form name="boardRegForm" method="POST" action="/boardRegProc.do">
    
        <table class="tbcss2" border="1" style="border-collapse:collapse" cellpadding=5>

        <%-- if문 두종류가 있다. 아래의 choose when 보면서 비교하기.  
            <c:if test="${empty param.b_no}">
                <caption>[새글쓰기]</caption>
            </c:if>

            <c:if test="${!empty param.b_no}">
                <caption>[댓글쓰기]</caption>
            </c:if> 
        --%>

            <c:choose>
                <c:when test="${empty param.b_no}">
                    <caption>[[새글쓰기]]</caption>
                </c:when>
                <c:otherwise>
                    <caption>[[댓글쓰기]]</caption>
                </c:otherwise>
            </c:choose>





            <tr>
                <th bgcolor="lightgray">이  름</th>  
                <td>
                <!-- ------------------------------------------------- -->
                <input type="text" size="10" name="writer" class="writer" maxlength="10">
                <!-- ------------------------------------------------- -->
                </td>
            </tr>
            <tr>
                <th bgcolor="lightgray">제  목</th>
                <td>
                <!-- ------------------------------------------------- -->
                <input type="text" size="40" name="subject" class="subject" maxlength="20">
                <!-- ------------------------------------------------- -->
                </td>
            </tr>
            <tr>
                <th bgcolor="lightgray">이메일</th>
                <td>
                <!-- ------------------------------------------------- -->
                <input type="text" size="40" name="email" class="email" maxlength="30">
                <!-- ------------------------------------------------- -->
                </td>
            </tr>
            <tr>
                <th bgcolor="lightgray">내용</th>
                <td>
                <!-- ------------------------------------------------- -->
                <textarea name="content" class="content" rows="13" cols="40"  maxlength="300"></textarea>
                <!-- ------------------------------------------------- -->
                </td>
            </tr>
            <tr>
                <th bgcolor="lightgray">비밀번호</th>
                <td>
                <!-- ------------------------------------------------- -->
                <input type="password" size="8" name="pwd" class="pwd" maxlength="4">
                <!-- ------------------------------------------------- -->
                </td>
            </tr>
        </table>
        <div style="height: 6px;"></div> <!-- 공백조절용 div 태그 -->
        <input type="button" value="저장" onclick="checkBoardRegForm()">
        <input type="reset" value="다시작성">
        <input type="button" value="목록보기" onclick="location.replace('/boardList.do')">
    
        
        <!-- ------------------------------------------------- -->
        <!-- 만약 파명 b_no 의 파값이 null 이면 name="b_no" 를 가진 hidden 태그의 value 에 0 입력하기 -->
        <!-- 만약 파명 b_no 의 파값이 null 아니면 name="b_no" 를 가진 hidden 태그의 value 에 파값을 입력하기 -->
        <!-- ------------------------------------------------- -->
        <c:if test="${empty param.b_no}">
            <input type="hidden" name="b_no" value="0">
        </c:if> 

        <c:if test="${!empty param.b_no}">
            <input type="hidden" name="b_no" value="${param.b_no}">
        </c:if> 



       
            <!-- *********************************************************** -->
            <!-- JSP 기술의 한 종류인 [Include Directive]를 이용한 -->
            <!-- common.jsp 파일 내의 소스 중 로그아웃 원하는 위치에 지정해주려면, -->
            <!-- 아래와 같이 div 태그를 주고 class 값으로 위치 지정을 해주면 된다. -->
            <!-- *********************************************************** -->
            <div class="logout"></div>
    </form>



   

</body>

</html>