// ****************************************
// ****************************************
// 예외처리 하기 전. 공용함수 백업본. 

// Github 
// History for new-study-repository/Javascript/common_func.js
// d2db19879df002f0445f80e33fb36291b90276b7
// 참고하기.

// ****************************************
// ****************************************

	//------------------------------------------------------------------------
	// 매개변수로 들어온 데이터가 비어있거나 [공백]으로 구성되어 있으면 
	// true 를 리턴, 아니면 false 리턴하는 함수 선언
	//------------------------------------------------------------------------
	function isEmpty( str ){	// str => 문자열이 저장되는 매개변수
		var flag = false;
		if( str.split(" ").join("")=="" ) {
			flag = true;
		}
		return flag;
	}
	
	//------------------------------------------------------------------------
	// [이메일] 유효성 체크 공용함수 처리.
	// 매개변수로 들어온 이메일 문자가 이메일 문자 패턴에 맞으면 true 리턴하기.
	// 틀리면 false 리턴하기.
	//------------------------------------------------------------------------
	function isValidEmail( email ){	// email => 검사할 문자열(이메일)이 저장되는 매개변수
		// 이메일 문자열을 체크하는 RegExp 객체 생성하기.
		var regExp = new RegExp(/^([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/);
		return regExp.test(email);
	}

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
		return regExpObj.test(targetStr);
	}

	//------------------------------------------------------------------------
	// [checkbox] 또는 [radio] 의 체크 개수구해서 리턴하는 함수 선언
	//------------------------------------------------------------------------
	function getCheckedCnt( arrObj ){	// Array 객체의 메위주가 저장되는 매개변수선언.
										// Array 객체안의 배열 변수안에는 Radio 객체 또는  
										// checkbox 객체의 메위주가 들어 있다.
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
		// Radio 또는 checkbox 의 체크 개수가 저장되는 변수 checkedCnt 선언하고 0 저장..
		//------------------------------------------------------------------------
		var checkedCnt = 0;
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
		//------------------------------------------------------------------------
		// checkedCnt 변수 안의 데이터 리턴하기. 즉, Radio 또는 checkbox 입력양식에 체크 개수 리턴하기.
		//------------------------------------------------------------------------
		return checkedCnt;
	}catch(e){
		alert( "getCheckedCnt 함수 호출 시 에러가 발생했음" )
	}
	}	
