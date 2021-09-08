

function setTrBgcolor( tableClassV, headBgcolor, oddTrBgcolor, evenTrBgcolor ){

	var tableObj = $("."+tableClassV);

	var firstTrObj = tableObj.find("tr:eq(0)");
	// 아래는 위와 같은 코드들이다.
	// var firstrObj = tableObj.find("tr:first");
	// var firstrObj = tableObj.find("tr").first();
	var oddTrObj = firstTrObj.siblings("tr").filter(":even");
	var evenTrObj = firstTrObj.siblings("tr").filter(":odd");


}