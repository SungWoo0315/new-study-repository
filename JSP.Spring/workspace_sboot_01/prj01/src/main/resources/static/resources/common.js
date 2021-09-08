

function setTrBgcolor( tableClassV, headBgcolor, oddTrBgcolor, evenTrBgcolor ){

	// alert("공용함수 테스트");
	// return;
	
	try{
		var tableObj = $("."+tableClassV);
		var firstTrObj = tableObj.find("tr:eq(0)");
		// 아래는 위와 같은 코드들이다.
		// var firstrObj = tableObj.find("tr:first");
		// var firstrObj = tableObj.find("tr").first();
		var oddTrObj = firstTrObj.siblings("tr").filter(":even");
		var evenTrObj = firstTrObj.siblings("tr").filter(":odd");

		firstTrObj.attr("bgColor", headBgcolor);
		oddTrObj.attr("bgColor", oddTrBgcolor);
		evenTrObj.attr("bgColor", evenTrBgcolor);
	}
	catch(e){
		alert("setTrBgcolor 함수 호출 시 예외발생!" + e.message);
	}
}

















