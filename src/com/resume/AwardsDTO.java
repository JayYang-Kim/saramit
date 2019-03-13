package com.resume;

public class AwardsDTO {
	private int awardsCode;
	private int resumeCode;
	private String awardsName;
	private String awards_date;
	private String awards_publisher;
	
	public int getAwardsCode() {
		return awardsCode;
	}
	public void setAwardsCode(int awardsCode) {
		this.awardsCode = awardsCode;
	}
	public int getResumeCode() {
		return resumeCode;
	}
	public void setResumeCode(int resumeCode) {
		this.resumeCode = resumeCode;
	}
	public String getAwardsName() {
		return awardsName;
	}
	public void setAwardsName(String awardsName) {
		this.awardsName = awardsName;
	}
	public String getAwards_date() {
		return awards_date;
	}
	public void setAwards_date(String awards_date) {
		this.awards_date = awards_date;
	}
	public String getAwards_publisher() {
		return awards_publisher;
	}
	public void setAwards_publisher(String awards_publisher) {
		this.awards_publisher = awards_publisher;
	}
}
