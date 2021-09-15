<!-- ******************************************************** -->
<!-- JSP 기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리 방식 선언하기 -->
<!-- ******************************************************** -->
    <!-- 현재 이 JSP 페이지 실행 후 생성되는 문서는 HTML 이고, 이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다라고 설정함 -->
    <!-- 현재 이 JSP 페이지는 UTF-8 방식으로 인코딩 한다. -->
    <!-- UTF-8 인코딩 방식은 한글을 포함 전 세계 모든 문자열ㅇ르 부호화 할 수 있는 방법이다.  -->
    <!-- 모든 JSP 페이지 상단에는 무조건 아래 설정이 들어간다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
$(document).ready(function(){
    $("body").prepend(    
        "<center><div><span style='cursor:pointer; font-weight:bold; color:#9400D3;' "
           + "onclick='location.replace(\"/${requestScope.naverPath}logout.do\");'>[로그아웃]</span></div></center>"
    );

	$("body").attr("bgcolor","${bodyColor}")
});


// *****************************************
// table 태그 내부의 배경색 바꾸는 함수 선언
// *****************************************
function changeBgColor(  ){
	setTrBgcolor( 
		// ---------------------------------------------------
		"tbcss0"        //tableClassV  //테이블 태그의 클래스값
		// ---------------------------------------------------
		, "#AD9AEE"        //headBgcolor  //헤드 tr 의 배경색값
		// ---------------------------------------------------
		, "#eef7ff"     //oddTrBgcolor //헤드 tr 이후의 홀수 tr 배경색값
		// , "white"	//주석 바꿔가면서 색상변경 할 수 있다.
		// , "red"
		// ---------------------------------------------------
		, "#D2D2FF"   //evenTrBgcolor//헤드 tr 이후의 짝수 tr 배경색값
		// ---------------------------------------------------
		, "lightyellow"   //mouseOverBgcolor//마우스 댔을 때 배경색값
	);
}
</script>






