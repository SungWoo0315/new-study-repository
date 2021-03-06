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
	
        // *****************************************
        // 키워드에 입력한 데이터를 가진 [게시판 목록]을 검색해서 그 결과를 보여주는 함수 선언
        // *****************************************
        function search(){
            // -----------------------------------------------
            // 입력한 키워드 얻어오기
            // -----------------------------------------------
            var keyword1 = $(".keyword1").val();
            // -----------------------------------------------
            // 만약 키워드가 비어있거나 공백으로 구성되어 있으면 경고하고 비우고 함수 중단하기
            // -----------------------------------------------
            if( keyword1==null || keyword1.split(" ").join("")=="" ){
                
                //alert("[키워드] 가 비어 있어 검색 불가능합니다.") // 테스트 완료후 주석처리
                $(".keyword1").val("");
                // $(".keyword1").focus(); // 테스트 완료후 주석처리
                //return;  // 테스트 완료후 주석처리

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

        // *****************************************
        // [모두 검색] 버튼 클릭하면 호출되는 함수선언
        // *****************************************
        function searchAll(){
            // ---------------------------------
            // 키워드 입력 양식에 "" 넣어주기
            // ---------------------------------
            $(".keyword1").val("");
            // ---------------------------------
            // class=day 를 가진 입력 양식의 체크 풀기
            // ---------------------------------
            $(".day").prop("checked", false);
            // ---------------------------------
            // 비동기 방식으로 웹서버에 접속하는 searchExe() 함수 호출하기
            // ---------------------------------
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
                
                    $(".searchResult").html(html)
                    // ----------------------------------------------------------
                    // 매개변수 responseHTML 로 들어온 검색 결과물 html 소스 문자열에서 
                    // class=boardListAllCnt 를 가진 태그 내부의 [총개수 문자열]을 얻어서
                    // 아래 현 화면의 html 소스중에 class=boardListAllCnt 를 가진 태그 내부에 덮어씌우기  
                    // ----------------------------------------------------------
                    var cnt = $(responseHTML).find(".boardListAllCnt").text();

                    $(".boardListAllCnt").text(cnt);



                    var pageNo = $(responseHTML).find(".pageNo").html();

                    $(".pageNo").html(pageNo);


                    var test = $(responseHTML).find(".test").html();

                    $(".test").html(test);
                }
                // ----------------------------------------------------------
                // 서버의 응답을 못 받았을 경우 실행할 익명함수 설정
                // ----------------------------------------------------------
                ,error : function( ){
                    alert("서버 접속 실패! 관리자에게 문의 바람!");
                }




            });


        }


   

        // *****************************************
        // 페이지 번호를 클릭하면 호출되는 함수 선언
        // *****************************************
        function search_with_changePageNo( selectPageNo ){

        $(".selectPageNo").val(selectPageNo);
        search();

        }






	</script>

</head>

<body onkeydown="if(event.keyCode==13) {search();}">

    <!-- *********************************************************** -->
    <!-- [자바 변수 선언하고 검색 화면 구현에 필요한 데이터 저장하기] -->
    <!-- *********************************************************** -->
    <%

    List<Map<String,String>> boardList = (List<Map<String,String>>)request.getAttribute("boardList");

    int getBoardListCount = (Integer)request.getAttribute("getBoardListCount");
        
    int selectPageNo = (Integer)request.getAttribute("selectPageNo");
    int rowCntPerPage = (Integer)request.getAttribute("rowCntPerPage");

    int last_pageNo = (Integer)request.getAttribute("last_pageNo");
    int min_pageNo = (Integer)request.getAttribute("min_pageNo");
    int max_pageNo = (Integer)request.getAttribute("max_pageNo");


    %>






    <center>
    <span style="font-size:30px; font-weight: bold; color: orange;">
        boardList.jsp 접속 성공!!
    </span>
    <center>

        <hr>  

    <!-- *********************************************************** -->
    <!-- [게시판 검색 조건 입력 양식] 내포한 form 태그 선언 -->
    <!-- *********************************************************** -->
    <form name="boardListForm" method="post" onsubmit="return false">

        [키워드] : <input type="text" name="keyword1" class="keyword1">
        
        <hr>

        <input type="checkbox" name="day" class="day" value="today" > 오늘
        <input type="checkbox" name="day" class="day" value="yesterday" > 어제

        <input type="hidden" name="selectPageNo" class="selectPageNo" value="1">  
        
      

        <select  name="rowCntPerPage" class="rowCntPerPage" onchange="search();">  
            <option value="10">10</option>
            <option value="15">15</option>
            <option value="20" selected>20</option>
            <option value="25">25</option>
            <option value="30">30</option>
            <option value="100">100</option>
        </select> 행보기
        
        <hr>

        <input type="button" value="검색" class="contactSearch" onclick="search();">&nbsp;
        <input type="button" value="모두검색" class="contactSearchAll" onclick="searchAll();">&nbsp;
        
        <hr>

        <a href="javascript:goBoardRegForm();">[새글쓰기]</a>




    </form>
    <div style="height: 10px;"></div> <br> <!-- 공백조절용 div 태그 -->    
	
    <center>


	<!-- *********************************************************** -->
	<!-- EL(Expression Language) 을 사용하여 HttpServletRequest 객체에  -->
	<!-- setAttribute 메소드로 저장된 키값 "getBoardListCount" 로 저장된 데이터를 꺼내서 표현하기 -->
	
	<!-- <%-- ${requestScope.키값} --%> --> 
	
	<!-- <참고> EL 은 JSP 페이지에서 사용가능한 언어이다. -->
	<!--        즉, EL 은 JSP 기술의 한 종류이다. -->
	<!-- *********************************************************** -->
    <div class="boardListAllCnt" style="height: 10px;">
        검색 개수 : ${requestScope.getBoardListCount}개
    </div> 
    
    <br>

    <!-- 테스트용 페이지 번호 출력 -->
    <div class="test" style="height: 10px;">
        현재화면 페이지번호 => <%=selectPageNo%> 
    </div> <br>
        마지막 페이지 번호 => <%=last_pageNo%> <br>
        현재화면 최소페이지번호 => <%=min_pageNo%> <br>
        현재화면 최대페이지번호 => <%=max_pageNo%> <br>

    <hr>


    <div class="pageNo">

        <%

        // 10페이지 번호씩 넘어가는 코드.
        /*
            if( getBoardListCount>0 ){

                out.print( "<span style='cursor: pointer;' onclick='search_with_changePageNo("+(1)+");'>[[처음으로]]&nbsp;</span> " );

                if( min_pageNo > rowCntPerPage ){
                
                    out.print( "<span style='cursor: pointer;' onclick='search_with_changePageNo("+(min_pageNo-1)+");'>[이전]</span> " );

                }

                for( int i = min_pageNo; i<=max_pageNo; i++ ){
                    if( i==selectPageNo ){

                        out.print( "<span>" + i + "</span> " );

                    }else{
                        out.print( "<span style='cursor: pointer;' onclick='search_with_changePageNo("+i+");'>[" + i + "]</span> ");

                    }
                }

                if( last_pageNo > max_pageNo ){
                
                    out.print( "<span style='cursor: pointer;' onclick='search_with_changePageNo("+(max_pageNo+1)+");'>[다음]</span> " );

                }

                
                out.print( "<span style='cursor: pointer;' onclick='search_with_changePageNo("+(last_pageNo)+");'>&nbsp;[[마지막으로]]</span> " );
            }
        */

        /* EL 을 위한 주석처리
        // 한페이지씩 넘어가는코드.  처음으로 마지막으로 고정되어 보이게 하는 if 문.  
            if( selectPageNo > 1 ){
        
                out.print( "<span style='cursor: pointer; font-weight:bold; color:#6495ED;' onclick='search_with_changePageNo("+(1)+");'>[[처음으로]]&nbsp;</span> " );  
        
                out.print( "<span style='cursor: pointer; font-weight:bold; color:#9400D3;' onclick='search_with_changePageNo("+(selectPageNo-1)+");'>&nbsp;[[이전]]&nbsp;</span> " );
            
            }
            else{
                
                out.print( "<span>[[처음으로]]&nbsp;</span>" );  
        
                out.print( "<span>&nbsp;[[이전]]&nbsp;</span> " );
            
            }
        
            for( int i = min_pageNo; i<=max_pageNo; i++ ){
                if( i==selectPageNo ){
        
                    out.print( "<span style='font-weight:bold; color:red;'>" + i + "</span> " );
                
                }else{
        
                    out.print( "<span style='cursor: pointer;' onclick='search_with_changePageNo("+i+");'>[" + i + "]</span> " );
        
                }
            }
        
            if( selectPageNo < last_pageNo ){
                    
                out.print( "<span style='cursor: pointer; font-weight:bold; color:#9400D3;' onclick='search_with_changePageNo("+(selectPageNo+1)+");'>&nbsp;[[다음]]&nbsp;</span> " );
                out.print( "<span style='cursor: pointer; font-weight:bold; color:#6495ED;' onclick='search_with_changePageNo("+(last_pageNo)+");'>&nbsp;[[마지막으로]]</span> " );
            
            }
            else{
                
                out.print( "<span>&nbsp;[[다음]]&nbsp;</span>" );  
        
                out.print( "<span>&nbsp;[[마지막으로]]</span> " );
            
            }
            */
        %>
  
        <c:if test="${requestScope.getBoardListCount>0}">
            
            
            <c:if test="${requestScope.selectPageNo>1}">
                <span style='cursor: pointer; font-weight:bold; color:#6495ED;' onclick='search_with_changePageNo(1);'>[[처음으로]]&nbsp;</span>
                <span style='cursor: pointer; font-weight:bold; color:#9400D3;' onclick='search_with_changePageNo(${requestScope.selectPageNo}-1);'>&nbsp;[[이전]]&nbsp;</span>
            </c:if>
            
            <c:if test="${requestScope.selectPageNo<=1}">
                <span>[[처음으로]]&nbsp;</span>
                <span>&nbsp;[[이전]]&nbsp;</span>
            </c:if>
            
            

            <c:forEach var="a" begin="${requestScope.min_pageNo}" end="${requestScope.max_pageNo}">
                
                <c:if test="${a==requestScope.selectPageNo}">
                    <span style='font-weight:bold; color:red;'>${a}</span>
                </c:if>


                <c:if test="${a!=requestScope.selectPageNo}">
                    <span style='cursor: pointer;' onclick='search_with_changePageNo("${a}");'>[${a}]</span>
                </c:if>

            </c:forEach>



            <c:if test="${requestScope.selectPageNo<requestScope.last_pageNo}">
                <span style='cursor: pointer; font-weight:bold; color:#9400D3;' onclick='search_with_changePageNo(${requestScope.selectPageNo}+1);'>&nbsp;[[다음]]&nbsp;</span>
                <span style='cursor: pointer; font-weight:bold; color:#6495ED;' onclick='search_with_changePageNo(${requestScope.last_pageNo});'>&nbsp;[[마지막으로]]</span>
            </c:if>

            <c:if test="${requestScope.selectPageNo>=requestScope.last_pageNo}">
                <span>&nbsp;[[다음]]&nbsp;</span>
                <span>&nbsp;[[마지막으로]]</span>
            </c:if>


        </c:if> 


    </div>
    
    <br>




    
    <div class="searchResult">

        <table border="1" style="border-collapse:collapse" cellpadding=5>
            <tr><th>번호</th><th>제목</th><th>작성자</th><th>조회수</th><th>등록일</th></tr>

        <%
    
            if( boardList!=null){

                // 정순번호
                int serialNo1 = selectPageNo 
                * rowCntPerPage 
                - rowCntPerPage  
                + 1;

                // 역순번호 1
                int serialNo2 = getBoardListCount  
                - ( selectPageNo * rowCntPerPage  - rowCntPerPage  + 1 ) + 1;
                
                // 역순번호 2
                int serialNo3 = getBoardListCount - serialNo1 + 1;



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
                    out.println("<tr style='cursor: pointer;' onclick='goBoardContentForm("+b_no+")'><td>"
                        + (serialNo2--) +"<td>" +  xxx + subject + "<td>"+writer+"<td>"+readcount+"<td>"+reg_date);
                }
            }
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