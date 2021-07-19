	//------------------------------------------------------------------------
	// 매개변수로 들어온 데이터가 비어있거나 [공백]으로 구성되어 있으면 
	// true 를 리턴, 아니면 false 리턴하는 함수 선언
	//------------------------------------------------------------------------
	function isEmpty( str ){	// str => 문자열이 저장되는 매개변수
	
/*	//------------------------------------------------------------------------
		try{
			var flag = false;
			if( str.split(" ").join("")=="" ) {
				flag = true;
			}
			return flag;
		}catch(e){
			alert("isEmpty 함수 호출 시 예외가 발생!" + e.message);
			return false;
		}	
	}
*/	
	//------------------------------------------------------------------------
	// 아래 코드가 가독성과 유지보수개발에 유리 하다.  [효율적인 코드]
	//------------------------------------------------------------------------
	var flag = false;
	//------------------------------------------------------------------------
	// try 구문 선언. try 구문 안에는 예외발생 가능성 있는 코드가 삽입됨.
	//------------------------------------------------------------------------
	
	try{
		// 매개변수로 들어온 문자가 길이가 없거나 공백으로 이루어져 있으면 
		// flag 변수에 true 저장하기
		if( str.split(" ").join("")=="" ) {
			flag = true;
		}
	//------------------------------------------------------------------------
	// catch 구문선언.
	// catch 구문 안에는 try 구문 에서 예외 발생 시 실행할 코드가 삽입됨.
	// catch 구문의 매개변수 e 에는 예외를 관리하는 객체의 메이ㅜ주가 들어온다.
	// catch(~){~} 구문은 try 구문에서 예외발생 시 호출하는 일종의 함수와 비슷하다.   
	//------------------------------------------------------------------------
	}catch(e){
		alert("isEmpty 함수 호출 시 예외가 발생!" + e.message);
		flag = false;
	}	
	//------------------------------------------------------------------------
	// flag 변수 안의 데이터를 리턴하기.
	//------------------------------------------------------------------------
	return flag;
	//------------------------------------------------------------------------
}



	
	//------------------------------------------------------------------------
	// [이메일] 유효성 체크 공용함수 처리.
	// 매개변수로 들어온 이메일 문자가 이메일 문자 패턴에 맞으면 true 리턴하기.
	// 틀리면 false 리턴하기.
	//------------------------------------------------------------------------
	function isValidEmail( email ){	// email => 검사할 문자열(이메일)이 저장되는 매개변수
		// 이메일 문자열을 체크하는 RegExp 객체 생성하기.
		var flag = false;
		try{
			//------------------------------------------------------------------------
			// 이메일의 문자의 패턴을 관리하는 RegExp 객체 생성하기
			// RegExp 객체의 test 메소드를 호출하여 매개변수로 들어온 문자의
			// 이메일 문자 패턴에 맞는지 여부를 구해 flag 변수에 저장하기
			//------------------------------------------------------------------------
			var regExp = new RegExp(/^([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/);
			flag = regExp.test(email);
		}
		catch(e){
			alert("isValidEmail 함수 호출 시 예외가 발생!" + e.message);
			flag = false;
		}
		//------------------------------------------------------------------------
		// flag 변수 안의 데이터를 리턴하기.
		//------------------------------------------------------------------------
		return flag;
	}

	/*
	try{
	}
	catch(e){
		alert("isValidEmail 함수 호출 시 예외가 발생!" + e.message);
		flag = false;
	}
	return flag;
	*/

	//------------------------------------------------------------------------
	// [핸드폰] 유효성 체크 공용함수 처리.
	// 매개변수로 들어온 핸드폰 문자가 핸드폰 문자 패턴에 맞으면 true 리턴하기.
	// 틀리면 false 리턴하기.
	//------------------------------------------------------------------------
	function isValidPhone( phone ){	// phone => 검사할 문자열(핸드폰)이 저장되는 매개변수
		// 이메일 문자열을 체크하는 RegExp 객체 생성하기.
		var regExp = new RegExp(/^01([0|1|6|7|8|9])-{0,1}[0-9]{3,4}-{0,1}[0-9]{4}$/);
		return regExp.test(phone);
	}


	//------------------------------------------------------------------------
	// [문자열]의 패턴식 공용함수 처리.
	// 매개변수로 들어온 RegExp 객체와 검사문자열을 이용하여 
	// 검사문자열이 RegExp 객체가 관리하는 문자 패턴에 맞으면 true 리턴하기.
	// 틀리면 false 리턴하기.
	//------------------------------------------------------------------------
	function isValidPattern( regExpObj, targetStr ){	// regExpObj => RegExp 객체의 메모리 위치 주소값이 저장되는 매개변수
														// targetStr => 패턴을 검사할 문자열이 저장되는 매개변수
		
		var flag = false;
		try{
			flag = regExpObj.test(targetStr);
		}
		catch(e){
			alert("isValidEmail 함수 호출 시 예외가 발생!" + e.message);
			flag = false;
		}
		return flag;
	}

	//------------------------------------------------------------------------
	// [checkbox] 또는 [radio] 의 체크 개수구해서 리턴하는 함수 선언
	//------------------------------------------------------------------------
	function getCheckedCnt( arrObj ){	// Array 객체의 메위주가 저장되는 매개변수선언.
										// Array 객체안의 배열 변수안에는 Radio 객체 또는  
										// checkbox 객체의 메위주가 들어 있다.
		//------------------------------------------------------------------------
		// Radio 또는 checkbox 의 체크 개수가 저장되는 변수 checkedCnt 선언하고 0 저장..
		//------------------------------------------------------------------------
		var checkedCnt = 0;

	try{ // 예외처리

		//------------------------------------------------------------------------
		// len 변수 선언하고 매개변수로 들어온 Array 객체의 배열변수 개수를 구해 저장하기.
		//------------------------------------------------------------------------
		var len = arrObj.length

		//------------------------------------------------------------------------
		// len 변수안의 undefined 면 즉, 
		// 매개변수로 Array 객체가 안들어오고 다른 객체 즉, checkbox 객체 또는 Radio 객체가 들어오면 
		// 존재하지 않는 length 라는 속성변수에는 undefined 가 들어 있다. 
		// Radio 객체 또는 Checkbox 객체의 메위주 상상도를 살펴봐야 한다.
		//------------------------------------------------------------------------
		if( len==undefined ){
			if( arrObj.checked==false ){
				return 0;
			}else{
				return 1;
			}
		}


		//------------------------------------------------------------------------
		// 반복문 선언. 반복문은 0~len 변수안의 배열변수 개수 미만 만큼 돈다.
		// 반복문을 돌려서 Array 객체의 배열변수 안에 저장된 Radio 객체 또는 checkbox 객체에 접근하기 위함.
		//------------------------------------------------------------------------
		for( var i=0; i<len; i++){
			// 만약 i번째 배열변수 안의 Radio 객체 또는 checkbox 객체의 속성변수 checked 에 true가 저장되어 있으면
			// checkedCnt 변수 안의 숫자를 1 업데이트하기
			// 즉, i번째 Radio 또는 checkbox 입력양식에 체크가 되어 있으면 checkedCnt 변수 안의 숫자를 1 업데이트 하기.
			if( arrObj[i].checked ) { checkedCnt++; }
		}
	}catch(e){
			alert( "getCheckedCnt 함수 호출 시 에러가 발생했음" );
			checkedCnt = 0;
	}
	//------------------------------------------------------------------------
	// checkedCnt 변수 안의 데이터 리턴하기. 즉, Radio 또는 checkbox 입력양식에 체크 개수 리턴하기.
	//------------------------------------------------------------------------
	return checkedCnt;

	}	



/*
	---------------------------------
	예외(=exception)
	---------------------------------
		자스에서 예외란 웹브라우저가 [감지]할수 있는 오류
	---------------------------------
	예외 처리
	---------------------------------
		예외 발생할 경우 try{}catch(e){~}finally{} 구문을 
		사용하여 프로그램의 갑작스런 중단을 막고 
		원하는 방향으로 프로그램을 진행하는 것을 말한다.
	---------------------------------
	try~catch~finally 구문
	---------------------------------
		try{
			예외 발생할 가능성이 있는 코드
		}
		catch(e){
			예외가 발생했을 때 실행할 코드		
		}
		finally{
			예외가 발생하든 안하든 무조건 실행할 코드		
		}
*/



	//------------------------------------------------------------------------
	// 현재시점 날짜의 요일
	// 현재 시각의 요일을 리턴하는 함수 선언. 
	//------------------------------------------------------------------------
	
	function getTodayWeek(){
		// ------------------------------
		// today 변수 선언. 현재 날짜를 관리하는 Date 객체 생성. Date 객체의 메위주를 today변수에 저장.
		// ------------------------------
		var today = new Date();
		// ------------------------------
		// weekNo 변수 선언. Date 객체의 getDay 메소드 호출하여 현재 요일 번호 얻어 weekNO 변수에 저장하기
		// ------------------------------
		var weekNo = today.getDay();
		// ------------------------------
		// week 변수 선언. "일요일" 저장하기 
		// ------------------------------
		var week = "일요일";
		// ------------------------------
		// 요일 번호에 따라 week 변수에 오는 요일문자 저장하기.
		// ------------------------------
		if( weekNo==1 ){
			week = "월요일";
		}
		else if( weekNo==2 ){
			week = "화요일";
		}
		else if( weekNo==3 ){
			week = "수요일";
		}
		else if( weekNo==4 ){
			week = "목요일";
		}
		else if( weekNo==5 ){
			week = "금요일";
		}
		else if( weekNo==6 ){
			week = "토요일";
		}
		// ------------------------------
		// 오늘 오일 문자 리턴하기
		// ------------------------------
		return week;
	}
	/*
	//------------------------------------------------------------------------
	// 위의 요일 리턴 함수와 똑같은 출력을 하는 함수 형식이다.  
	//------------------------------------------------------------------------
	function getTodayWeek(){
		return["일요일","월요일","화요일","수요일","목요일","금요일","토요일"][new Date().getDay()]
	}
	*/

	//------------------------------------------------------------------------
	// JSON 선언.
	//------------------------------------------------------------------------
	var weekMsg = {
		"월요일" : "월요일은 9시에 회의가 있는 날입니다. 보고서 준비해 주십시오."
		,"화요일" : "화요일은 대청소 날입니다." 
		,"수요일" : "수요일은 봉사활동 날입니다."
		,"목요일" : "부서별 회식이 있습니다."
		,"금요일" : "오후 12시에 대강의실에서 상 수여식이 있습니다."
	}	






