package com.resume;

public class EducationDTO {
	private int educationCode;
	private int resumeCode;
	private String schoolName;
	private int region;
	private String major;
	private String entrance;
	private String graduate;
	private String graduate_status;
	private int gubun;
	
	public int getGubun() {
		return gubun;
	}
	public void setGubun(int gubun) {
		this.gubun = gubun;
	}
	public int getEducationCode() {
		return educationCode;
	}
	public void setEducationCode(int educationCode) {
		this.educationCode = educationCode;
	}
	public int getResumeCode() {
		return resumeCode;
	}
	public void setResumeCode(int resumeCode) {
		this.resumeCode = resumeCode;
	}
	public String getSchoolName() {
		return schoolName;
	}
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}
	
	public int getRegion() {
		return region;
	}
	public void setRegion(int region) {
		this.region = region;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getEntrance() {
		return entrance;
	}
	public void setEntrance(String entrance) {
		this.entrance = entrance;
	}
	public String getGraduate() {
		return graduate;
	}
	public void setGraduate(String graduate) {
		this.graduate = graduate;
	}
	public String getGraduate_status() {
		return graduate_status;
	}
	public void setGraduate_status(String graduate_status) {
		this.graduate_status = graduate_status;
	}
}
