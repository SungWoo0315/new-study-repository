package com.naver.erp;

import java.io.File;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

public class FileUpLoad {
	// ---------------------------------------
	private MultipartFile multi;
	private	String newFileName;
	// ---------------------------------------
	public FileUpLoad(MultipartFile multi){
		// 매개변수로 들어온 MultipartFile 객체를 속성변수 multi 에 저장하기.
		this.multi = multi;
		// 만약 업로드된 파일이 존재하면
		if( multi!=null && multi.isEmpty()==false ){
			// 업로드한 파일의 원래 파일명 얻기. 파일명에는 확장자가 포함한다.  
			String oriFileName = multi.getOriginalFilename();
			// 업로드한 파일의 파일 확장자 얻기
			String file_extension = oriFileName.substring( oriFileName.lastIndexOf(".")+1 );
			// 고유한 새 파일명 얻기. 파일명에는 확장자가 포함한다. 
			newFileName = UUID.randomUUID() + "." + file_extension;
		}
	}
	// ---------------------------------------
	public String getNewFileName(){
		
		return newFileName;
	}
	// ---------------------------------------
	public String getNewFileName(boolean flag){
	
		return flag?newFileName:null;  // 삼항연산자
	}
	// ------------------------------
	public void uploadFile( String upLoadDir ) throws Exception {
		// 만약 업로드된 파일이 있으면 
		if( multi!=null && multi.isEmpty()==false && newFileName!=null && newFileName.length()>0 ){
			// 새 파일을 생성하기 File 객체를 생성하면 새 파일을 생성할 수 있다.  
			File file = new File( upLoadDir + newFileName );
			// 업로드한 파일을 새 파일에 전송하여 덮어쓰기
			multi.transferTo(file);
		}
	}
	// ------------------------------
	public void delete( String filePath ) {
		File file = new File( filePath );
		file.delete();
	}
	// ------------------------------
	public void delete( String filePath, boolean flag ) {
		if( flag==true ){
			delete( filePath );
		}
	}
}


/*
	<모듈 쓰는 법 예시>
	(새글쓰기에서 파일 업로드)   

	FileUpLoad fileUpLoad = new FileUpLoad(multi);

	board.setPic( fileUpLoad.getNewFileName() );

	DB 연동 코드 

	fileUpLoad.getNewFileName();

*/


