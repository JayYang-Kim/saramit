package com.resume;

public class ResumeDTO {  
	private int resumeCode;
	private String userEmail;
	private String name;
	private String addr;
	private String gender;
	private String birth;
	private String created;
	private String title;

	int getResumeCode() {
		return resumeCode;
	}

	void setResumeCode(int resumeCode) {
		this.resumeCode = resumeCode;
	}

	String getUserEmail() {
		return userEmail;
	}

	void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	String getName() {
		return name;
	}

	void setName(String name) {
		this.name = name;
	}

	String getAddr() {
		return addr;
	}

	void setAddr(String addr) {
		this.addr = addr;
	}

	String getGender() {
		return gender;
	}

	void setGender(String gender) {
		this.gender = gender;
	}

	String getBirth() {
		return birth;
	}

	void setBirth(String birth) {
		this.birth = birth;
	}

	String getCreated() {
		return created;
	}

	void setCreated(String created) {
		this.created = created;
	}

	String getTitle() {
		return title;
	}

	void setTitle(String title) {
		this.title = title;
	}
}
