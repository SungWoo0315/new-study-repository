

function setTrBgcolor( tableClassV, headBgcolor, oddTrBgcolor, evenTrBgcolor, mouseOverBgcolor ){

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



		// 글자색 조절 하는 메소드 css
		// 글자를 끌어안는 td, th 태그를 지칭해야 한다.  
		oddTrObj.find("td,th").css("color", "#800080");	
		evenTrObj.find("td,th").css("color", "black");




		oddTrObj.hover(
			function(){
				$(this).attr("bgColor",mouseOverBgcolor);
			}
			,function(){
				$(this).attr("bgColor",oddTrBgcolor);
			}
		);
		evenTrObj.hover(
			function(){
				$(this).attr("bgColor",mouseOverBgcolor);
			}
			,function(){
				$(this).attr("bgColor",evenTrBgcolor);
			}
		);

	}
	catch(e){
		alert("setTrBgcolor 함수 호출 시 예외발생!" + e.message);
	}
}


// --------------------------------------------------------------------------
function getRandomData( arr ){
	var randomData = "";
	var cnt = arr.length;
	var idx = Math.floor(Math.random()*cnt)
	randomData = arr[idx];

	return randomData;
}
// // --------------------------------------------------------------------------
// function getRandomDataArr( arr, cnt ){
// 	var randomDataArr = [];

// 	// ???

// 	return randomDataArr;
// }

// // --------------------------------------------------------------------------
// function getRandomDataArr2( arr, min_cnt, max_cnt ){
// 	var randomDataArr = [];

// 	for (i = min_cnt; i <= max_cnt; i += 1) {
// 		var 랜덤숫자 = Math.floor(Math.random() * 20) + 1;
// 		if (randomDataArr.indexOf(랜덤숫자) === -1) {
// 			randomDataArr.push(랜덤숫자);
// 		} 

// 	return randomDataArr;
// }












