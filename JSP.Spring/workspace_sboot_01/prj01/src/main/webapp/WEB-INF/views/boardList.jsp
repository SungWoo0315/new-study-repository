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

        // *****************************************
        // 키워드에 입력한 데이터를 가진 [게시판 목록]을 검색해서 그 결과를 보여주는 함수 선언
        // *****************************************
        function search(){
            // -----------------------------------------------
            // 입력한 키워드 얻어오기
            // -----------------------------------------------
            var keyword1 = $(".keyword1").val();
            if( keyword1==null ){
                keyword1 = "";
            }
            // -----------------------------------------------
            // 만약 키워드가 비어있거나 공백으로 구성되어 있으면 경고하고 비우고 함수 중단하기
            // -----------------------------------------------
            if( keyword1==null || keyword1.split(" ").join("")=="" ){
                
                alert("[키워드] 가 비어 있어 검색 불가능합니다.")
                $(".keyword1").val("");
                $(".keyword1").focus();
                return;

            }
            // -----------------------------------------------
            // 입력한 키워드의 앞뒤 공백 제거하고 다시 넣어주기
            // -----------------------------------------------
            $(".keyword1").val(  $.trim(keyword1)  );
            // -----------------------------------------------
            // 비동기 방식으로 웹서버에 접속하여 키워드를 만족하는
            // 검색 결과물을 응답받아 현 화면에 반영하기 
            // -----------------------------------------------
            searchExe();

          

        }

        function searchExe(){
            // -----------------------------------------------
            // 현재 화면에서 페이지 이동 없이(=비동기 방식으로)
            // 서버쪽 /boardList.do 로 접속하여 키워드를 만족하는
            // 검색 결과물을 응답받아 현 화면에 반영하기
            // -----------------------------------------------
            $.ajax({

                // ----------------------------------------------------------
                // 서버쪽 호출 URL 주소 지정
                // ----------------------------------------------------------
                url       : "/boardList.do"
                // ----------------------------------------------------------
                // form 태그 안의 입력양식 데이터 즉, 파라미터값을 보내는 방법 지정
                // ----------------------------------------------------------
                ,type     : "post"
                // ----------------------------------------------------------
                // 서버로 보낼 파라미터명과 파라미터값을 설정. 
                // ----------------------------------------------------------
                ,data     : $("[name=boardListForm]").serialize() 
                    
                ,dataType : "html"
                // ----------------------------------------------------------
                // 서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
                // 익명함수의 매개변수에는 서버가 보내온 html 소스가 문자열로 들어온다.
                // 즉, 응답 메시지 안의 html 소스가 문자열로써 익명함수의 매개변수로 들어온다.  
                // 응답 메시지 안의 html 소스는 boardList.jsp 의 실행 결과물이다.
                // ----------------------------------------------------------
                ,success  : function( responseHTML ){
                    // ----------------------------------------------------------
                    // 매개변수 responseHTML 로 들어온 검색 결과물 html 소스 문자열에서 
                    // class=searchResult 를 가진 태그 내부의 [검색 결과물 html 소스]를 얻어서
                    // 아래 현 화면의 html 소스중에 class=searchResult 를 가진 태그 내부에 덮어씌우기  
                    // ----------------------------------------------------------
                    var html = $(responseHTML).find(".searchResult").html();

                    $(".searchResult").html(html);

                    // ----------------------------------------------------------
                    // 매개변수 responseHTML 로 들어온 검색 결과물 html 소스 문자열에서 
                    // class=boardListAllCnt 를 가진 태그 내부의 [총개수 문자열]을 얻어서
                    // 아래 현 화면의 html 소스중에 class=boardListAllCnt 를 가진 태그 내부에 덮어씌우기  
                    // ----------------------------------------------------------
                    var cnt = $(responseHTML).find(".boardListAllCnt").text();

                    $(".boardListAllCnt").text(cnt);



                
                }
                // ----------------------------------------------------------
                // 서버의 응답을 못 받았을 경우 실행할 익명함수 설정
                // ----------------------------------------------------------
                ,error : function( ){
                    alert("서버 접속 실패! 관리자에게 문의 바람!");
                }




            });


        }

        function searchAll(){

            $(".keyword1").val("");
            searchExe();

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


    <!-- *********************************************************** -->
    <!-- [게시판 검색 조건 입력 양식] 내포한 form 태그 선언 -->
    <!-- *********************************************************** -->
    <form name="boardListForm" method="post">

            [키워드] : <input type="text" name="keyword1" class="keyword1" 
            onkeydown="if(event.keyCode==13) {search();}">


            <input type="hidden" name="selectPageNo" class="selectPageNo" value="1">  
            <select  name="rowCntPerPage" class="rowCntPerPage" onchange="search();">  
                <option value="10">10</option>
                <option value="15">15</option>
                <option value="20">20</option>
                <option value="25">25</option>
                <option value="30">30</option>
                <option value="100">100</option>
            </select> 행보기


            <input type="button" value="검색" class="boardSearch" onclick="search();">&nbsp;
            <input type="button" value="모두검색" class="boardSearchAll" onclick="searchAll();">&nbsp;
            <a href="javascript:goBoardRegForm();">[새글쓰기]</a>



    </form>


    

    <center>

    <div style="height: 10px;"></div> <!-- 공백조절용 div 태그 -->

    <!-- *********************************************************** -->
    <div class="boardListAllCnt" style="height: 10px;">총 <%=(Integer)request.getAttribute("getBoardListCount")%>개</div> <br><!-- 공백조절용 div 태그 -->
    <!-- *********************************************************** -->

    <div class="searchResult">

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
                    out.println("<tr style='cursor: pointer;' onclick='goBoardContentForm("+b_no+")'><td>"+ (totCnt--) +"<td>" + xxx + subject + "<td>"+writer+"<td>"+readcount+"<td>"+reg_date);

                }
            }    
        %>
        </table>
    </div>

    <!-- 페이지 번호 출력 -->

    <hr> 
    <input type="button" value="로그아웃" onclick="location.replace('/loginForm.do')">

    <!-- ********************************************************* -->
    <!-- 게시판 상세보기 화면 이동하는 form 태그 선언하기 -->
    <!-- ********************************************************* -->
    <form name="boardContentForm" method="post" action="/boardContentForm.do">
        <!-- ------------------------------------------------------ -->
        <!-- [클릭한 게시판 글의 고유번호]가 저장되는 [hidden 입력양식] 선언. -->
        <!-- ------------------------------------------------------ -->
        <input type="hidden" name="b_no">  
    
    
    
    </form>

    </center>

</body>

</html>




<!-- 

    mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    공식 => [페이지 당 보여줄 행의 개수], [선택페이지번호], [총개수]로
            검색 결과물의 [시작행 번호]과 검색 결과물의 [끝행 번호]를 구하는 공식
            단 변수는 아래와 같다.
    ------------------------------------------------------------------
                totCnt        => 검색된 총 결과물 개수
                rowCntPerPage => 페이지 당 보여줄 행의 개수
                selectPageNo  => 선택한 페이지 번호
                beginRowNo    => 검색된 총 결과물에서 가져올 범위의 시작행
                endRowNo      => 검색된 총 결과물에서 가져올 범위의 끝행
    mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    if( totCnt>0){
        int endRowNo = selectPageNo * rowCntPerPage;
        int beginRowNo = endRowNo - rowCntPerPage + 1;
        if( endRowNo>totCnt ){
            endRowNo = totCnt;
        }
    }
    ---------------------------------
    if( totCnt>0){
        int beginRowNo = selectPageNo * rowCntPerPage - rowCntPerPage + 1;
        int endRowNo = beginRowNo + rowCntPerPage -1;
        if( endRowNo>totCnt ){
            endRowNo = totCnt;
        }
    }


    mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    공식 => [총개수], [페이지 당 보여줄 행의 개수], [선택된 페이지 번호]
            [한 화면에 보여지는 페이지번호 개수]로 
            [현재 화면에 보여지는 페이지 번호의 최소 번호]와
            [현재 화면에 보여지는 페이지 번호의 최대 번호]를 구하는 공식
            단, 변수는 아래와 같다.  
    ---------------------------------------------------------------
            totCnt             => 검색된 총 결과물 개수
            rowCntPerPage      => 페이지 당 보여줄 행의 개수
            selectPageNo       => 선택한 페이지 번호  
            pageNoCntPerPage   => 페이지당 보여줄 페이지 번호의 개수
            last_pageNo        => 마지막 페이지 번호의 개수
            min_pageNo         => 현재 화면에 보여지는 페이지 번호의 최소 페이지 번호
            max_pageNo         => 현재 화면에 보여지는 페이지 번호의 최대 페이지 번호
    mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    if( totCnt > 0 ){
        int last_pageNo = totCnt/rowCntPerPage;
            if( totCnt%rowCntPerPage > 0 ){last_pageNo++;}

        int min_pageNo = (selectPageNo - 1)/pageNoCntPerPage * pageNoCntPerPage + 1;
        int max_pageNo = min_pageNo + pageNoCntPerPage - 1;
            if( max_pageNo > last_pageNo ) { max_pageNo = last_pageNo; }
    }


 -->