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


<!-- *********************************************************** -->
<!-- JSP 기술의 한 종류인 [Include Directive]를 이용하여 -->
<!-- common.jsp 파일 내의 소스를 삽입하기 -->
<!-- *********************************************************** -->
<%@include file="common.jsp"%>  


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>



<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BoardList2</title>

    <script>

        $(document).ready(function(){

        });


        // *****************************************
        // 페이지 번호를 클릭하면 호출되는 함수 선언
        // *****************************************
        function search_with_changePageNo( selectPageNo ){
            // ----------------------------------
            // class=selectPageNo 를 가진 입력양식에
            // 클릭한(=선택한) 페이지 번호를 value 값으로 삽입하기
            // 왜? 서버로 보내려고!
            // ----------------------------------
            $(".selectPageNo").val(selectPageNo);
            // ----------------------------------
            // search 함수 호출하기
            // ----------------------------------
            search();

        }



        // *****************************************
        // 새글쓰기 클릭하면 호출되는 함수선언 
        // *****************************************
        function goBoardRegForm( ){
            // Location 객체의 replace() 메소드 호출로 
            // [새글쓰기 화면]으로 이동하기.
            // 이 이동방법은 form 태그를 이용한 웹서버 접속 방법이 아니므로
            // 파라미터값을 가지고 가려면 URL 주소 뒷 부분에 ?파면=파값 을 붙여야만 한다.  
            // 즉, get 방식으로 웹서버에 접속하는 방법이다.  
            location.replace('/boardRegForm.do');

            <% System.out.println("============================"); %>
            <% System.out.println("boardList.jsp 접속 성공!!"); %>
            <% System.out.println("============================"); %>

           
        }

        // *****************************************
        // 게시판 목록에서, 행을 클릭할 경우 호출되는 함수 선언.  
        // 매개변수로 클릭한 행의 PK 값 즉, b_no 컬럼값이 전달 된다.  
        // [게시판 상세보기 화면]으로 이동하는 함수 선언
        // *****************************************
        function goBoardContentForm( b_no ){

            // alert("상세보기 화면 활성화 성공! PK 번호는 => " + b_no) // 테스트 확인용. PK 번호 확인. 
            
            // ---------------------------------------
            // name=boardContentForm 가진 form 태그 내부의 name=b_no 가진 입력 양식에  
            // 클릭한 행의 게시판 번호 저장하기
            // ---------------------------------------
            $("[name=boardContentForm] [name=b_no]").val(b_no) 
                // $("[name=boardContentForm]").find("[name=b_no]").val(b_no); // 위 코드와 같다.   
            // ---------------------------------------
            // name=boardContentForm 가진 form 태그 내부의 action 값의 URL 주소로 서버에 접속하기
            // 즉, 상세보기 화면으로 이동하기  
            // form 태그를 이용한 웹서버 접속 방법. POST 방식.
            // ---------------------------------------
            document.boardContentForm.submit();
            
        }

        // *****************************************
        // [검색] 버튼 클릭하면 호출되는 함수선언  
        // 키워드에 입력한 데이터를 가진 [게시판 목록]을 검색해서 그 결과를 보여주는 함수 선언
        // *****************************************
        function search(){
            // -----------------------------------------------
            // 입력한 키워드 얻어오기
            // -----------------------------------------------
            var keyword1 = $(".keyword1").val();
            // -----------------------------------------------
            // 만약 키워드가 비어있거나 공백으로 구성되어 있으면 "" 로 대체하기
            // -----------------------------------------------
            if( keyword1==null || keyword1.split(" ").join("")=="" ){

                keyword1 = "";
                
                // 개발 과정 중 테스트 코드.  
                // alert("[키워드] 가 비어 있어 검색 불가능합니다.") // 경고 띄우기
                // $(".keyword1").val(""); // 길이없는 데이터 입력양식값에 넣고
                // $(".keyword1").focus(); // 커서 들어가있게 하기
                // return;  // 함수 중단.  

            }
            // -----------------------------------------------
            // 입력한 키워드의 앞뒤 공백 제거하고 다시 입력 양식에 넣어주기
            // -----------------------------------------------
            $(".keyword1").val(  $.trim(keyword1)  );
            // -----------------------------------------------
            // 비동기 방식으로 웹서버에 접속하여 키워드를 만족하는 searchExe() 함수 호출하기.
            // -----------------------------------------------
            searchExe();
        }


        // *****************************************
        // [모두 검색] 버튼 클릭하면 호출되는 함수선언
        // *****************************************
        function searchAll(){
            // ---------------------------------
            // 키워드 입력 양식에 "" 넣어주기
            // ---------------------------------
            $(".keyword1").val("");
            $(".keyword2").val("");

            // ---------------------------------
            // class=day 를 가진 입력 양식의 체크 풀기
            // ---------------------------------
            $(".day").prop("checked", false);
            // ---------------------------------
            // 비동기 방식으로 웹서버에 접속하는 searchExe() 함수 호출하기
            // ---------------------------------
            searchExe();
        }

        // *****************************************
        // 비동기 방식으로 웹서버에 접속하는 searchExe() 함수 선언하기
        // *****************************************
        function searchExe(){
            // -----------------------------------------------
            // 현재 화면에서 페이지 이동 없이(=비동기 방식으로)
            // 서버쪽 /boardList.do 로 접속하여 html 을 응답받아 현 화면에 반영하기
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
                    // ----------------------------------------------------------
                    // 매개변수 responseHTML 로 들어온 검색 결과물 html 소스 문자열에서 
                    // class=pageNo 를 가진 태그 내부의 [총개수 문자열]을 얻어서
                    // 아래 현 화면의 html 소스중에 class=pageNo 를 가진 태그 내부에 덮어씌우기  
                    // ----------------------------------------------------------
                    var pageNo = $(responseHTML).find(".pageNo").html();

                    $(".pageNo").html(pageNo);


                
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

<!-- ---------------------------------------------------- -->
<!-- body 태그 선언하기 -->
<!-- body 태그에 keydown 이벤트를 걸면 특정 태그에 가는 포커스 상관없이 
    무조건 화면에서 키보드 누르면 자스코드를 실행하게 할 수 있다. -->
<!-- ---------------------------------------------------- -->
<body onkeydown="if(event.keyCode==13) {search();}">


 



    <!-- *********************************************************** -->
    <!-- [자바 변수 선언하고 검색 화면 구현에 필요한 데이터 꺼내서 저장하기] -->
    <!-- 검색 결과물, 검색된 총개수, 페이지번호에 관련된 데이터이다. -->
    <!-- *********************************************************** -->
    <%
        /*
        // --------------------------------------------------------------
        // HttpServletRequest 객체에 setAttribute 메소드로 "boardList" 라는 키값으로 저장된 데이터 꺼내기  
        // --------------------------------------------------------------
            // <참고> "/boardList.do" 로 접속하면 호출되는 메소드 안에서 ModelAndView 객체의 addObject 로 저장된 데이터는 
            //         HttpServletRequest 객체의 setAttribute 메소드로도 저장된 효과를 본다.    
        List<Map<String,String>> boardList = (List<Map<String,String>>)request.getAttribute("boardList");
        // --------------------------------------------------------------
        // HttpServletRequest 객체에 setAttribute 메소드로 "getBoardListCount" 라는 키값으로 저장된 데이터 꺼내기  
        // HttpServletRequest 객체에 setAttribute 메소드로 "selectPageNo" 라는 키값으로 저장된 데이터 꺼내기  
        // HttpServletRequest 객체에 setAttribute 메소드로 "rowCntPerPage" 라는 키값으로 저장된 데이터 꺼내기  
        // HttpServletRequest 객체에 setAttribute 메소드로 "last_pageNo" 라는 키값으로 저장된 데이터 꺼내기  
        // HttpServletRequest 객체에 setAttribute 메소드로 "min_pageNo" 라는 키값으로 저장된 데이터 꺼내기  
        // HttpServletRequest 객체에 setAttribute 메소드로 "max_pageNo" 라는 키값으로 저장된 데이터 꺼내기  
        // --------------------------------------------------------------
        int getBoardListCount = (Integer)request.getAttribute("getBoardListCount");
        int selectPageNo = (Integer)request.getAttribute("selectPageNo"); 
        int rowCntPerPage = (Integer)request.getAttribute("rowCntPerPage");
        int last_pageNo = (Integer)request.getAttribute("last_pageNo");
        int min_pageNo = (Integer)request.getAttribute("min_pageNo");
        int max_pageNo = (Integer)request.getAttribute("max_pageNo");
        */
    %>


    <!-- *********************************************************** -->
    <!-- 접속페이지 테스트 확인용. -->
    <center>
    <span style="font-size:30px; font-weight: bold; color: orange;">
        boardList2.jsp 접속 성공!!
    </span>
    <center>

        <hr>  
    <!-- *********************************************************** -->


    <!-- *********************************************************** -->
    <!-- [게시판 검색 조건 입력 양식] 내포한 form 태그 선언 -->
    <!-- *********************************************************** -->
    <form name="boardListForm" method="post" onsubmit="return false;">

            <!-- --------------------------------------------------- -->
            <!-- 키워드 데이터 저장할 입력양식 선언 -->
            <!-- --------------------------------------------------- -->
            [키워드] : <input type="text" name="keyword1" class="keyword1" >

            <!-- 다음주 숙제 부분 -->
            <select name="or_and_option" class="or_and_option">
                <option value="or" selected>or</option>
                <option value="and">and</option>
            </select>

            <input type="text" name="keyword2" class="keyword2" >  
            
            <hr>

            <input type="checkbox" name="day" class="day" value="오늘" > 오늘
            <input type="checkbox" name="day" class="day" value="어제" > 어제
            <input type="checkbox" name="day" class="day" value="그제" > 그제
            <!-- 다음주 숙제 부분 -->
            <input type="checkbox" name="day" class="day" value="최근7일" > 최근7일

            <!-- --------------------------------------------------- -->
            <!-- 선택한, 클릭한 페이지번호를 저장할 hidden 입력양식 선언 -->
            <!-- 페이징 처리 관련 데이터이다. -->
            <!-- --------------------------------------------------- -->
            <input type="hidden" name="selectPageNo" class="selectPageNo" value="1">
              
            <!-- --------------------------------------------------- -->
            <!-- 한 화면에 보여줄 검색 결과물 행의 개수 관련 입력양식 선언 -->
            <!-- 페이징 처리 관련 데이터이다. -->
            <!-- --------------------------------------------------- -->
            <select  name="rowCntPerPage" class="rowCntPerPage" onchange="search();">  
                <option value="10">10</option>
                <option value="15">15</option>
                <option value="20" selected>20</option>
                <option value="25">25</option>
                <option value="30">30</option>
                <option value="100">100</option>
            </select> 행보기

            <hr>

            <!-- --------------------------------------------------- -->
            <input type="button" value="검색" class="boardSearch" onclick="search();">&nbsp;
            <input type="button" value="모두검색" class="boardSearchAll" onclick="searchAll();">&nbsp;
            <hr>
            <a href="javascript:goBoardRegForm();">[새글쓰기]</a>
            <!-- --------------------------------------------------- -->



    </form>


    

    <center>

    <div style="height: 10px;"></div> <!-- 공백조절용 div 태그 -->

    <!-- *********************************************************** -->
    <!-- 검색된 목록의 총개수 출력하기 -->
    <!-- *********************************************************** -->
    <!-- EL(Expression Language) 을 사용하여 HttpServletRequest 객체에  -->
    <!-- setAttribute 메소드로 저장된 키값 "getBoardListCount" 로 저장된 데이터를 꺼내서 표현하기 -->
    <!-- <참고> EL 은 JSP 페이지에서 사용가능한 언어이다. -->
    <!--        즉, EL 은 JSP 기술의 한 종류이다. -->
    <!-- *********************************************************** -->
    <div class="boardListAllCnt" style="height: 10px;">총 ${requestScope.getBoardListCount}개</div> <br> <!-- EL 예시. 위 코드랑 비교. -->




    <!-- ********************************************************* -->
    <!-- 페이지 번호 출력하기 -->
    <!-- ********************************************************* -->
    <div class="pageNo">

        <!-- ********************************************************* -->  
        <%-- 
            ***************************************************************
            JSTL 이란 커스텀 태그 중에 C코어 태그 중에 c:if 조건문을 사용하여
            만약에 게시판 검색 개수가 0보다 크면
            ***************************************************************
            C코어 태그 중에 if 조건문 형식
            --------------------------------------------
            <c:if test="${EL조건식}">
            
            </c:if>
            --------------------------------------------
        --%>
        <!-- ********************************************************* -->
        <c:if test="${requestScope.getBoardListCount>0}">
            
            <!-- ==================================================== -->
            <!-- 선택한 페이지 번호가 1보다 크면 [처음], [이전] 글씨 보이기. 단, 클릭하면 함수 호출하도록 이벤트 걸기 -->
            <!-- ==================================================== -->
            <c:if test="${requestScope.selectPageNo>1}">
                <span style='cursor: pointer; font-weight:bold; color:#6495ED;' onclick='search_with_changePageNo(1);'>[[처음으로]]&nbsp;</span>
                <span style='cursor: pointer; font-weight:bold; color:#9400D3;' onclick='search_with_changePageNo(${requestScope.selectPageNo}-1);'>&nbsp;[[이전]]&nbsp;</span>
            </c:if>
            <!-- ==================================================== -->
            <!-- 선택한 페이지 번호가 1이면 [처음], [이전] 글씨 보이기. 단 클릭하면 함수 호출하는 이벤트 걸지 말기 -->
            <!-- ==================================================== -->
            <c:if test="${requestScope.selectPageNo<=1}">
                <span>[[처음으로]]&nbsp;</span>
                <span>&nbsp;[[이전]]&nbsp;</span>
            </c:if>
            


            <%-- 
            ***************************************************************
            JSTL 이란 커스텀 태그 중에 C코어 태그 중에 forEach 반복문을 사용하여
            [최소 페이지번호] 부터 [최대 페이지 번호]를 표현하기   
            ***************************************************************
                --------------------------------------------
                C코어 태그 중에 forEach 반복문을 형식1
                --------------------------------------------
                    <c:forEach var="반복문안에서사용할지역변수" begin="시작번호" end="끝번호" step="증감정수값">
                        HTML 코딩  
                    </c:forEach> 
                --------------------------------------------
                --------------------------------------------
                C코어 태그 중에 forEach 반복문을 형식2
                --------------------------------------------
                    <c:forEach var="반복문안에서사용할지역번수" items="EL로표현되는ArrayList객체" varStatus="loopTagStatus객체저장변수명">
                        HTML 코딩  
                    </c:forEach> 
                --------------------------------------------
            --%>
            <c:forEach var="i" begin="${requestScope.min_pageNo}" end="${requestScope.max_pageNo}" step="1">
                <!-- ======================================== -->
                <!-- 만약 출력되는 페이지번호와 선택한 페이지 번호가 일치하면 그냥 번호만 표현하기 -->
                <!-- ======================================== -->
                <c:if test="${i==requestScope.selectPageNo}">
                    <span style='font-weight:bold; color:red;'>${i}</span>
                </c:if>
                <!-- ======================================== -->
                <!-- 만약 출력되는 페이지번호와 선택한 페이지 번호가 일치하지 않으면 클릭하면 함수호출하도록 클릭이벤트 걸기 -->
                <!-- ======================================== -->
                <c:if test="${i!=requestScope.selectPageNo}">
                    <span style='cursor: pointer;' onclick='search_with_changePageNo("${i}");'>[${i}]</span>
                </c:if>

            </c:forEach>

      

            <!-- ==================================================== -->
            <!-- 선택한 페이지 번호가 마지막 페이지 번호보다 작으면 [다음], [마지막으로] 문자 표현하기 -->
            <!-- 단, 클릭하면 함수 호출하도록 클릭 이벤트 걸기 -->
            <!-- ==================================================== -->
            <c:if test="${requestScope.selectPageNo<requestScope.last_pageNo}">
                <span style='cursor: pointer; font-weight:bold; color:#9400D3;' onclick='search_with_changePageNo(${requestScope.selectPageNo}+1);'>&nbsp;[[다음]]&nbsp;</span>
                <span style='cursor: pointer; font-weight:bold; color:#6495ED;' onclick='search_with_changePageNo(${requestScope.last_pageNo});'>&nbsp;[[마지막으로]]</span>
            </c:if>
            <!-- ==================================================== -->
            <!-- 선택한 페이지 번호가 마지막 페이지 번호보다 크거나 같으면 [다음], [마지막으로] 문자 표현하기 -->
            <!-- 단, 클릭하면 함수 호출하는 이벤트는 걸지 않기 -->
            <!-- ==================================================== -->
            <c:if test="${requestScope.selectPageNo>=requestScope.last_pageNo}">
                <span>&nbsp;[[다음]]&nbsp;</span>
                <span>&nbsp;[[마지막으로]]</span>
            </c:if>

        </c:if> 

    </div>



    <!-- ********************************************************* -->
    <!-- div 태그를 이용하여 위아래 컨텐츠의 사이 여백 주기 -->
    <!-- ********************************************************* -->
    <div style="height: 10px;"></div> <!-- 공백조절용 div 태그 -->

    

    <div class="searchResult">

        <table border="1" class="tbcss0" style="border-collapse:collapse" cellpadding=5>
            <tr bgcolor="gray">
                <th>번호</th><th>제목</th><th>작성자</th><th>조회수</th><th>등록일</th></tr>

            <!-- 수업시간에 만든 커스텀태그 및 EL searchResult -->
            <c:forEach var="board" items="${requestScope.boardList}" varStatus="loopTagStatus">

                <tr bgcolor="${loopTagStatus.index%2==0?'white':'lightgray'}" 
                    style='cursor: pointer;' 
                    onclick='goBoardContentForm("${board.b_no}")'>

                    <td><!-- 역순번호 출력 -->
                        <!-- 보기 편하게 하기 위해서 requestScope. 은 생략 하였다. -->
        
                        <!-- 역순번호 -->
                        <%-- ${getBoardListCount - (selectPageNo * rowCntPerPage - rowCntPerPage +1) +1 -loopTagStatus.index} --%>
        
                        <!-- board.RNUM 을 사용한 역순번호 -->    
                        ${getBoardListCount-board.RNUM+1}   


                        <!-- 정순번호 -->
                        <%-- ${selectPageNo * rowCntPerPage - rowCntPerPage +1 +loopTagStatus.index} --%>
                        
                        <!-- board.RNUM 을 사용한 정순번호 -->    
                        <%-- ${board.RNUM} --%>


                    </td>

                    <td><!-- ㄴ으로 표현되는 들여쓰기 -->
                        <c:if test="${board.print_level>0}">
                            <c:forEach begin="1" end="${board.print_level}">
                                &nbsp;&nbsp;&nbsp;&nbsp;
                            </c:forEach>
                            &#10551;                       
                        </c:if>                         
                        ${board.subject}
                    </td>

                    <td><!-- 작성자 출력 -->${board.writer}</td>
                    <td><!-- readcount 출력 -->${board.readcount}</td>
                    <td><!-- 등록일 출력 -->${board.reg_date}</td>

                </tr>

            </c:forEach> 






        <%--
            <!-- 내가 만들어본 커스텀태그 및 EL searchResult -->

            <c:if test="${requestScope.boardList!=null}">

                <c:set var="serialNo1" value="${requestScope.selectPageNo*requestScope.rowCntPerPage-requestScope.rowCntPerPage+1}" />

                <c:set var="serialNo3" value="${requestScope.getBoardListCount-serialNo1+1}" />



                <c:forEach var="boardList1" varStatus="status" items="${boardList}" begin="0" end="${requestScope.boardList.size()}" step="1">
                                       
                    <tr style='cursor: pointer;' onclick='goBoardContentForm("${boardList1.b_no}")'>
                        <td>${requestScope.getBoardListCount - ((requestScope.selectPageNo-1) * requestScope.rowCntPerPage + status.index) }</td>
                        <td>       
                            <c:forEach var="j" begin="1" end="${boardList1.print_level}" step="1">
                                &nbsp;&nbsp;&nbsp;&nbsp;
                            </c:forEach>
                            <c:if test="${boardList1.print_level>0}">
                                &#10551;                       
                            </c:if> 
                            
                            ${boardList1.subject}</td>
                        <td>${boardList1.writer}</td>
                        <td>${boardList1.readcount}</td>
                        <td>${boardList1.reg_date}</td>
                    </tr>
                    <!--역순번호===> 전체 레코드 수 - ( (현재 페이지 번호 - 1) * 한 페이지당 보여지는 레코드 수 + 현재 게시물 출력 순서 ) -->

                </c:forEach>
              
            </c:if> 
        --%>


        <%
        /*
            // 자바로 뽑아낸 searchResult

            // ---------------------------------------------------------------------------
            // boardList 가 null 이 아니면, 검색결과물이 있으면,   + boardList 에는 ListMap 객체가 들어있다.  
            // ---------------------------------------------------------------------------
            if( boardList!=null){

                // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
                // 정순번호 => serialNo1
                // 역순번호 => serialNo2 , serialNo3 (페이지당 시작 역순번호)
                // 역순번호 = 총개수 - ( 선택페이지번호 * 한화면의행의개수 - 한화면의행의개수 + 1 )-1;
                // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
                    // -----------------------------------------------
                    // 선택한 페이지 번호에 맞는 검색결과물의 시작 정순번호 구하기
                    // 선택한 페이지 번호에 맞는 검색결과물의 시작 역순번호 구하기
                    // -----------------------------------------------
                    int serialNo1 = selectPageNo * rowCntPerPage - rowCntPerPage + 1;

                    int serialNo2 = getBoardListCount - ( selectPageNo * rowCntPerPage - rowCntPerPage + 1 ) + 1;

                    int serialNo3 = getBoardListCount - serialNo1 + 1;

                // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm


                // -----------------------------------------------
                // 검색결과물을 HTML 태그로 출력하기
                // boardList 안의 ArrayList 객체에 들어 있는 다량의 HashMap 객체를 꺼내어
                // HashMap 객체 안의 키값에 대응하는 문자를 꺼내어 HTML 태그로 출력하기 
                // -----------------------------------------------
                for( int i=0; i<boardList.size(); i++ ){
                    
                    // i 번째 HashMap 객체를 꺼내기
                    
                    Map<String,String> map = boardList.get(i);

                    // i번째 HashMap 객체에 키값 b_no 에 대응하는 저장 문자열 꺼내기
                    // i번째 HashMap 객체에 키값 subject 에 대응하는 저장 문자열 꺼내기
                    // i번째 HashMap 객체에 키값 writer 에 대응하는 저장 문자열 꺼내기
                    // i번째 HashMap 객체에 키값 readcount 에 대응하는 저장 문자열 꺼내기
                    // i번째 HashMap 객체에 키값 reg_date 에 대응하는 저장 문자열 꺼내기
                    // i번째 HashMap 객체에 키값 print_level 에 대응하는 저장 문자열 꺼내기

                    String b_no = map.get("b_no");

                    String subject = map.get("subject");
                    String writer = map.get("writer");
                    String readcount = map.get("readcount");
                    String reg_date = map.get("reg_date");
                    String print_level = map.get("print_level");

                    int print_level_int = Integer.parseInt(print_level,10);
                    // 들여쓰기 단계 번호에 맞게 공백을 누적하고 들여쓰기 단계가 1 이상이면 ㄴ 자 붙이기  
                    String xxx = "";

                    // 들여쓰기 단계 번호에 맞게 공백을 누적 시키기.   
                    // 웹브라우저는 공백을 두칸밖에 인식 안하기 때문에 `&nbsp;` 사용한다.
                    for( int j=0; j<print_level_int; j++){

                        xxx = xxx + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                    }
                    if( print_level_int > 0 ){xxx = xxx + " &#10551; "; }
                    // HTML 또는 문자열로 표현하기.  
                    out.println("<tr style='cursor: pointer;' onclick='goBoardContentForm("+b_no+")'><td>"
                                    + (serialNo3--) 
                                    +"<td>" + xxx + subject + "<td>"+writer+"<td>"+readcount+"<td>"+reg_date);

                }
            }   
        */    
        %>
        </table>
    </div>


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