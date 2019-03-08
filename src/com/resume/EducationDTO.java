package com.resume;

public class EducationDTO {
	private int educationCode;
	private int resumeCode;
	private String schoolName;
	private String region;
	private String major;
	private String entrance;
	private String graduate;
	private String graduate_status;
	
	int getEducationCode() {
		return educationCode;
	}
	void setEducationCode(int educationCode) {
		this.educationCode = educationCode;
	}
	int getResumeCode() {
		return resumeCode;
	}
	void setResumeCode(int resumeCode) {
		this.resumeCode = resumeCode;
	}
	String getSchoolName() {
		return schoolName;
	}
	void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}
	String getRegion() {
		return region;
	}
	void setRegion(String region) {
		this.region = region;
	}
	String getMajor() {
		return major;
	}
	void setMajor(String major) {
		this.major = major;
	}
	String getEntrance() {
		return entrance;
	}
	void setEntrance(String entrance) {
		this.entrance = entrance;
	}
	String getGraduate() {
		return graduate;
	}
	void setGraduate(String graduate) {
		this.graduate = graduate;
	}
	String getGraduate_status() {
		return graduate_status;
	}
	void setGraduate_status(String graduate_status) {
		this.graduate_status = graduate_status;
	}
}
