

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
// 1차원 Array 객체에 저장된 데이터 중에 랜덤하게 
// 하나의 데이터를 복사해서 리턴하는 함수  
// --------------------------------------------------------------------------
function getRandomData( arr ){
	// Array 객체의 배열변수의 개수, null 값도 개수에 들어간다.  
	var cnt = arr.length;
	// 랜덤한 인덱스번호 구하기  
	var idx = Math.floor(Math.random()*cnt)
	// 랜덤한 인덱스번호에 해당하는 배열변수의 데이터 리턴하기  
	return arr[idx];
}
// --------------------------------------------------------------------------
// 1차원 Array 객체에 저장된 데이터 중에 랜덤하게 
// 원하는 개수의 데이터를 복사해서 또 다른 Array 객체에 담아 리턴하는 함수.  
// --------------------------------------------------------------------------
function getRandomDataArr( arr, cnt ){
	var randomDataArr = [];
	var tmpArr = [];

	while( true ){
		var randomData = getRandomData( arr );
		var tmp_cnt = 0;
		for( var i=0; i<tmpArr.length; i++){
			if( randomData==tmpArr[i] ){
				tmp_cnt++;
				break;
			}
		}
		if( tmp_cnt>0 ){ continue; }
		randomDataArr.push(randomData);
		tmpArr.push(randomData);
		if( randomDataArr.length==cnt ){ break; }
	}
	return randomDataArr;
}

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












