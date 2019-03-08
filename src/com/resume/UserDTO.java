package com.resume;

public class UserDTO {
	private String userEmail;
	private String userName;
	private String addr;
	private String birth;
	private String gender;

	String getUserEmail() {
		return userEmail;
	}

	void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	String getUserName() {
		return userName;
	}

	void setUserName(String userName) {
		this.userName = userName;
	}

	String getAddr() {
		return addr;
	}

	void setAddr(String addr) {
		this.addr = addr;
	}

	String getBirth() {
		return birth;
	}

	void setBirth(String birth) {
		this.birth = birth;
	}

	String getGender() {
		return gender;
	}

	void setGender(String gender) {
		this.gender = gender;
	}
}
