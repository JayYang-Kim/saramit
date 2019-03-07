package com.resume;

public class ResumeDTO {
	private int resumeCode;		//이력서코드
	private String userEmail;	//개인이메일
	private String name;		//이름
	private String addr;		//주소
	private String gender;		//성별
	private String birth;		//생년월일
	private String created;		//작성일자
	private String title;		//제목
	/*
	private int licenseCode;			//자격증코드
	private String licenseName;			//자격증명
	private String lisence_publisher;	//발급처
	private String license_date;		//날짜
	
	private int awardsCode;				//수상경력코드
	private String awardsName;			//수상명
	private String awards_publisher;	//발급처
	private String awards_date;			//날짜
	
	private int careerCode;		//경력사항코드
	private String gubun;		//구분
	private String copName;		//회사이름
	private String joinDate;	//입사일자
	private String resignDate;	//퇴사일자
	private String task;		//업무내용
	private String position;	//직위
	
	private int educationCode; 		//학력번호
	private String schoolName;		//학교이름
	private String region;			//지역
	private String major;			//전공
	private String entrance;		//입학일자
	private String graduate;		//졸업일자
	private String graduate_status;	//졸업여부
	*/
	
	
	
	
	public int getResumeCode() {
		return resumeCode;
	}
	public void setResumeCode(int resumeCode) {
		this.resumeCode = resumeCode;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
}
