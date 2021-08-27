<!-- ******************************************************** -->
<!-- JSP 기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리 방식 선언하기 -->
<!-- ******************************************************** -->
    <!-- 현재 이 JSP 페이지 실행 후 생성되는 문서는 HTML 이고, 이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다라고 설정함 -->
    <!-- 현재 이 JSP 페이지는 UTF-8 방식으로 인코딩 한다. -->
    <!-- UTF-8 인코딩 방식은 한글을 포함 전 세계 모든 문자열ㅇ르 부호화 할 수 있는 방법이다.  -->
    <!-- 모든 JSP 페이지 상단에는 무조건 아래 설정이 들어간다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- ***************************************************** -->
<!-- 현재 JSP 페이지에서 사용할 클래스 수입하기 -->
<!-- ***************************************************** -->
<%@ page import="com.naver.erp.BoardDTO"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<script src="/resources/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="/resources/common_func.js"></script>
<script src="/resources/common_data.js"></script>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>boardUpDelForm</title>

    <script>

        // 테스트용 입력양식 고정값 넣어주는 코드.  
        // 테스트가 끝나면 지우면 된다. 
        // 주석처리하면 소스보기에서 보여지기 때문에 지우는것이 좋다.   
        $(document).ready(function(){


            // 리셋버튼으로 내용물 비우는 JQuery 만들어보기.  
            $(".reset").click(function(){

                if(confirm("입력되어있는 내용을 지우시겠습니까?")==false) {return;}

                $("[name=boardUpDelForm]").find(":text").val("");
                $("[name=boardUpDelForm]").find(".content").val("");
            
            });



           
        })

        <% System.out.println("============================"); %>
        <% System.out.println("boardUpDelForm.jsp 접속 성공!!!"); %>
        <% System.out.println("============================"); %>

        // ***************************************************
        // [게시판 등록 화면]에 입력된 데이터의 유효성 체크 함수 선언
        // ***************************************************
        function checkBoardUpDelForm( upDel ){
            
            // -----------------------------------------------------
            // 매개변수로 들어온 upDel 에 "up" 이 저장되었으면
            // 즉, 수정 버튼을 눌렀으면 각 입력양식의 유효성 체크하고 수정 여부 물어보기
            // -----------------------------------------------------
            if(upDel=='up'){
                // $(".xxx").remove()       // 테스트 확인용.
                // $("body").append("<div class=xxx>테스트 메시지.</div>")  // 테스트 확인용.
                if(confirm("정말 수정 하시겠습니까??")==false) {return;}
                $("[name=upDel]").val("up");
            }
            // ------------------------------------------
            // 매개변수로 들어온 upDel 에 "del" 이 저장되었으면
            // 즉, 삭제 버튼을 눌렀으면 암호 확인하고 삭제 여부를 물어보기
            // ------------------------------------------
            else if (upDel=='del'){
                if(confirm("정말 삭제 하시겠습니까??")==false) {return;}
                $("[name=upDel]").val("del");

            }    

                // --------------------------------------------
                // 현재 화면에서 페이지 이동 없이(=비동기방식으로)
                // 서버쪽 boardUpDelProc.do 로 접속해서 수정 또는 삭제하기 
                // --------------------------------------------
                $.ajax({

                // ----------------------------------------------------------
                // 서버쪽 호출 URL 주소 지정
                // ----------------------------------------------------------
                url       : "/boardUpDelProc.do"
                // ----------------------------------------------------------
                // form 태그 안의 입력양식 데이터 즉, 파라미터값을 보내는 방법 지정
                // ----------------------------------------------------------
                ,type     : "post"
                // ----------------------------------------------------------
                // 서버로 보낼 파라미터명과 파라미터값을 설정. 
                // ----------------------------------------------------------
                ,data     : $("[name=boardUpDelForm]").serialize() 
                    
                ,dataType : "html"
                // ----------------------------------------------------------
                // 서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
                // 익명함수의 매개변수에는 서버가 보내온 html 소스가 문자열로 들어온다.
                // 즉, 응답 메시지 안의 html 소스가 문자열로써 익명함수의 매개변수로 들어온다.  
                // 응답 메시지 안의 html 소스는 boardUpDelProc.jsp 의 실행 결과물이다.
                // ----------------------------------------------------------
                ,success  : function( responseHTML ){

                    var msg = $(responseHTML).filter(".msg").text();
                    msg = $.trim(msg);

                    if( msg!=null && msg.length>0 ){
                        alert(msg);
                        return;
                    }

                    var boardUpDelCnt = $(responseHTML).filter(".boardUpDelCnt").text();
                    boardUpDelCnt = $.trim(boardUpDelCnt);
                    boardUpDelCnt = parseInt(boardUpDelCnt,10);  
                    
                    if(upDel=="up"){

                        if( boardUpDelCnt==-1 ){
                            alert("게시판 글이 삭제 되었습니다.");
                        }
                        else if( boardUpDelCnt==-2 ){
                            alert("암호가 틀립니다.");
                            $("[name=boardUpDelForm]").find(".pwd").val("");
                            $("[name=boardUpDelForm]").find(".pwd").focus();

                        }
                        else if( boardUpDelCnt==1 ){
                            alert("수정 성공.");

                            if(confirm("목록화면으로 이동할까요?")==false) {return;}

                            location.replace("/boardList.do")

                        }
                        else{
                            alert("서버 에러발생! 관리자게엑 문의하세요. : boardUpDelForm")
                        }
                    }
                    else if( upDel=="del"){

                        //????
                    }
                    


                    // alert(responseHTML) // 테스트용. boardRegProc.jsp 결과물 확인하기.  


                    // 매개변수 responseHTML 안의 HTML 소스 문자열에 DB 연동 결과물을 뽑아
                    // 현재 화면에 반영하는 등의 소스가 나온다.
                    
                    // alert(responseHTML);  // 테스트용 확인.

                    // ------------------------------------
                    // 매개변수로 들어온 html 소스에서 class="idCnt" 를 가진 태그가 끌어안고 있는 숫자 꺼내기.
                    // 게시판 글 입력 성공 행의 개수 꺼내기.
                    // 꺼낸 개수의 앞뒤 공백 제거하기
                    // ------------------------------------
                    

                    // ------------------------------------
                    // 만약 게시판 글 입력 성공 행의 개수가 1이면, 즉, 입력이 성공했으면
                    // ------------------------------------
             
                    // ------------------------------------
                    // 그렇지 않고, 즉, 입력이 실패했으면
                    // ------------------------------------
              




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
        boardUpDelForm.jsp 접속 성공!!
    </span>
    

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



    <!-- **************************************************** -->
    <!-- [게시판 글쓰기] 화면을 출력하는 form 태그 선언 -->
    <!-- **************************************************** -->
    <form name="boardUpDelForm">

        <input type="hidden" name="b_no" value="<%=b_no%>">
        <input type="hidden" name="upDel" value="">
    
        <table border="1" class="upDeltable" style="border-collapse:collapse" cellpadding=5>
            <caption>게시판 수정/삭제</caption>
            
            <tr>
                <th bgcolor="lightgray">이  름</th>  
                <td>
                <!-- ------------------------------------------------- -->
                <input type="text" size="10" name="writer" class="writer" maxlength="10" value="<%=writer%>">
                <!-- ------------------------------------------------- -->
                </td>
            </tr>
            <tr>
                <th bgcolor="lightgray">제  목</th>
                <td>
                <!-- ------------------------------------------------- -->
                <input type="text" size="40" name="subject" class="subject" maxlength="20" value="<%=subject%>">
                <!-- ------------------------------------------------- -->
                </td>
            </tr>
            <tr>
                <th bgcolor="lightgray">이메일</th>
                <td>
                <!-- ------------------------------------------------- -->
                <input type="text" size="40" name="email" class="email" maxlength="30" value="<%=email%>">
                <!-- ------------------------------------------------- -->
                </td>
            </tr>
            <tr>
                <th bgcolor="lightgray">내용</th>
                <td>
                <!-- ------------------------------------------------- -->
                <textarea name="content" class="content" rows="13" cols="40"  maxlength="300"><%=content%></textarea>
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
        <input type="button" value="수정" onclick="checkBoardUpDelForm('up')">
        <input type="button" value="삭제" onclick="checkBoardUpDelForm('del')">
        <input type="button" value="목록보기" onclick="location.replace('/boardList.do');">
    
        <br>
        <hr>
        <input type="button" class="reset" value="내용삭제">
    
    </form>

    <%
    }
    else{
        out.print("<script>alert('삭제된 글입니다.'); location.replace('/boardList.do');</script>");
    }
    %>


   

</body>

</html>