		//------------------------------------------------------------------------
		// 매개변수로 들어온 데이터가 비어있거나 공백으로 구성되어 있으면 
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
		// 이메일 유효성 체크 공용함수 처리.
		// 매개변수로 들어온 이메일 문자가 이메일 문자 패턴에 맞으면 true 리턴하기.
		// 틀리면 false 리턴하기.
		//------------------------------------------------------------------------
		function isValidEmail( email ){	// email => 검사할 문자열(이메일)이 저장되는 매개변수
			// 이메일 문자열을 체크하는 RegExp 객체 생성하기.
			var regExp = new RegExp(/^([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/);
			return regExp.test(email);
		}


		//------------------------------------------------------------------------
		// 문자열의 패턴식 공용함수 처리.
		// 매개변수로 들어온 RegExp 객체와 검사문자열을 이용하여 
		// 검사문자열이 RegExp 객체가 관리하는 문자 패턴에 맞으면 true 리턴하기.
		// 틀리면 false 리턴하기.
		//------------------------------------------------------------------------
		function isValidPattern( regExpObj, targetStr ){	// regExpObj => RegExp 객체의 메모리 위치 주소값이 저장되는 매개변수
															// targetStr => 패턴을 검사할 문자열이 저장되는 매개변수
			return regExpObj.test(targetStr);
		}


		//------------------------------------------------------------------------
		// 회원가입 유효성 체크 
		//------------------------------------------------------------------------
		function checkMemRegForm(){
			// alert("내일 휴강입니다...")

			var mem_name = document.memberRegForm.mem_name.value;
			var uid = document.memberRegForm.uid.value;
			var pwd = document.memberRegForm.pwd.value;

			var regExp = new RegExp( /^[가-힣]{2,20}$/ );
			if( regExp.test(mem_name)==false ){
				alert("회원명에는 한글 2~20자 까지 입력해야 합니다.");
				document.memberRegForm.mem_name.value="";
				return;
			}

			var regExp = new RegExp( /^[a-z][a-z0-9_]{4,9}$/ );
			if( regExp.test(uid)==false ){
				alert("아이디는 영소문자로 시작하고 영소문자 또는 숫자 또는 _ 로 5~10자로 구성되야합니다.");
				document.memberRegForm.uid.value="";
				return;
			}

			var regExp = new RegExp( /^[a-z0-9_]{5,8}$/ );
			if( regExp.test(pwd)==false ){
				alert("암호는 영소문자 또는 숫자로 5~8자로 구성되야합니다.");
				document.memberRegForm.pwd.value="";
				return;
			}

			// alert( mem_name + " / " + uid + " / " + pwd) 입력 잘되는지 확인.
			
			alert("회원가입 성공!!");
			
			location.replace("loginForm.html")
		}