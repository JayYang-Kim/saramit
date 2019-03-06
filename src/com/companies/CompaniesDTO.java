package com.companies;

public class CompaniesDTO {
	private String companyEmail;
	private String companyPwd;
	private String businessLicenseNum;
	private String companyName;
	private String owner;
	private String establishmentDate;
	private int employees;
	private int sale;
	private String location;
	private int salary;
	private String introduction;
	private String homepage;
	private String logo; //logo 어떻게 할 것인가.
	private int statusCode; //회원 상태
	private int levelCode; //개인,기업 종류
	private String savefilename;

	public String getSavefilename() {
		return savefilename;
	}
	public void setSavefilename(String savefilename) {
		this.savefilename = savefilename;
	}

	public final String getCompanyEmail() {
		return companyEmail;
	}
	public final void setCompanyEmail(String companyEmail) {
		this.companyEmail = companyEmail;
	}
	public final String getCompanyPwd() {
		return companyPwd;
	}
	public final void setCompanyPwd(String companyPwd) {
		this.companyPwd = companyPwd;
	}
	public final String getBusinessLicenseNum() {
		return businessLicenseNum;
	}
	public final void setBusinessLicenseNum(String businessLicenseNum) {
		this.businessLicenseNum = businessLicenseNum;
	}
	public final String getCompanyName() {
		return companyName;
	}
	public final void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public final String getOwner() {
		return owner;
	}
	public final void setOwner(String owner) {
		this.owner = owner;
	}
	public final String getEstablishmentDate() {
		return establishmentDate;
	}
	public final void setEstablishmentDate(String establishmentDate) {
		this.establishmentDate = establishmentDate;
	}
	public final int getEmployees() {
		return employees;
	}
	public final void setEmployees(int employees) {
		this.employees = employees;
	}
	public final int getSale() {
		return sale;
	}
	public final void setSale(int sale) {
		this.sale = sale;
	}
	public final String getLocation() {
		return location;
	}
	public final void setLocation(String location) {
		this.location = location;
	}
	public final int getSalary() {
		return salary;
	}
	public final void setSalary(int salary) {
		this.salary = salary;
	}
	public final String getIntroduction() {
		return introduction;
	}
	public final void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public final String getHomepage() {
		return homepage;
	}
	public final void setHomepage(String homepage) {
		this.homepage = homepage;
	}
	public final String getLogo() {
		return logo;
	}
	public final void setLogo(String logo) {
		this.logo = logo;
	}
	public final int getStatusCode() {
		return statusCode;
	}
	public final void setStatusCode(int statusCode) {
		this.statusCode = statusCode;
	}
	public final int getLevelCode() {
		return levelCode;
	}
	public final void setLevelCode(int levelCode) {
		this.levelCode = levelCode;
	}

}
