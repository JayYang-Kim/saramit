package com.resume;

public class AwardsDTO {
	private int awardsCode;
	private int resumeCode;
	private String awardsName;
	private String awards_date;
	private String awards_publisher;
	
	int getAwardsCode() {
		return awardsCode;
	}
	void setAwardsCode(int awardsCode) {
		this.awardsCode = awardsCode;
	}
	int getResumeCode() {
		return resumeCode;
	}
	void setResumeCode(int resumeCode) {
		this.resumeCode = resumeCode;
	}
	String getAwardsName() {
		return awardsName;
	}
	void setAwardsName(String awardsName) {
		this.awardsName = awardsName;
	}
	String getAwards_date() {
		return awards_date;
	}
	void setAwards_date(String awards_date) {
		this.awards_date = awards_date;
	}
	String getAwards_publisher() {
		return awards_publisher;
	}
	void setAwards_publisher(String awards_publisher) {
		this.awards_publisher = awards_publisher;
	}
}
