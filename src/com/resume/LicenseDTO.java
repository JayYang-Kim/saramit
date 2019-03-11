package com.resume;

public class LicenseDTO {
	private int licenseCode;
	private int resumeCode;
	private String license_name;
	private String license_date;
	private String license_publisher;
	
	public int getLicenseCode() {
		return licenseCode;
	}
	public void setLicenseCode(int licenseCode) {
		this.licenseCode = licenseCode;
	}
	public int getResumeCode() {
		return resumeCode;
	}
	public void setResumeCode(int resumeCode) {
		this.resumeCode = resumeCode;
	}
	public String getLicense_name() {
		return license_name;
	}
	public void setLicense_name(String license_name) {
		this.license_name = license_name;
	}
	public String getLicense_date() {
		return license_date;
	}
	public void setLicense_date(String license_date) {
		this.license_date = license_date;
	}
	public String getLicense_publisher() {
		return license_publisher;
	}
	public void setLicense_publisher(String license_publisher) {
		this.license_publisher = license_publisher;
	}
}