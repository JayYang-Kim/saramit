package com.resume;

public class CareerDTO{
	private int careerCode;
	private int resumeCode;
	private String gubun;
	private String copName;
	private String joinDate;
	private String resignDate;
	private String task;
	private String position;
	
	int getCareerCode() {
		return careerCode;
	}
	void setCareerCode(int careerCode) {
		this.careerCode = careerCode;
	}
	int getResumeCode() {
		return resumeCode;
	}
	void setResumeCode(int resumeCode) {
		this.resumeCode = resumeCode;
	}
	String getGubun() {
		return gubun;
	}
	void setGubun(String gubun) {
		this.gubun = gubun;
	}
	String getCopName() {
		return copName;
	}
	void setCopName(String copName) {
		this.copName = copName;
	}
	String getJoinDate() {
		return joinDate;
	}
	void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}
	String getResignDate() {
		return resignDate;
	}
	void setResignDate(String resignDate) {
		this.resignDate = resignDate;
	}
	String getTask() {
		return task;
	}
	void setTask(String task) {
		this.task = task;
	}
	String getPosition() {
		return position;
	}
	void setPosition(String position) {
		this.position = position;
	}
}
