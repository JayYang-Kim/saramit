package com.companies;

public class EvaluationDTO {
	private int BoardNum,ListNum;
	private String cop_name;
	private String userEmail;
	private String companyEmail;
	private String savefilename;
	private int star;
	private String content1;
	private String content2;
	private String content3;
	private String content4;
	private String created;
	
	public String getContent1() {
		return content1;
	}
	public void setContent1(String content1) {
		this.content1 = content1;
	}
	public String getContent2() {
		return content2;
	}
	public void setContent2(String content2) {
		this.content2 = content2;
	}
	public String getContent3() {
		return content3;
	}
	public void setContent3(String content3) {
		this.content3 = content3;
	}
	public String getContent4() {
		return content4;
	}
	public void setContent4(String content4) {
		this.content4 = content4;
	}

	
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getCompanyEmail() {
		return companyEmail;
	}
	public void setCompanyEmail(String companyEmail) {
		this.companyEmail = companyEmail;
	}
	public int getStar() {
		return star;
	}
	public void setStar(int star) {
		this.star = star;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public int getBoardNum() {
		return BoardNum;
	}
	public void setBoardNum(int boardNum) {
		BoardNum = boardNum;
	}
	public int getListNum() {
		return ListNum;
	}
	public void setListNum(int listNum) {
		ListNum = listNum;
	}
	public String getCop_name() {
		return cop_name;
	}
	public void setCop_name(String cop_name) {
		this.cop_name = cop_name;
	}
	public String getSavefilename() {
		return savefilename;
	}
	public void setSavefilename(String savefilename) {
		this.savefilename = savefilename;
	}
	
}
