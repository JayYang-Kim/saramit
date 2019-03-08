package com.resume;

public class LicenseDTO {
	private int licenseCode;
	private int resumeCode;
	private String license_name;
	private String license_date;
	private String license_publisher;

	int getLicenseCode() {
		return licenseCode;
	}

	void setLicenseCode(int licenseCode) {
		this.licenseCode = licenseCode;
	}

	int getResumeCode() {
		return resumeCode;
	}

	void setResumeCode(int resumeCode) {
		this.resumeCode = resumeCode;
	}

	String getLicense_name() {
		return license_name;
	}

	void setLicense_name(String license_name) {
		this.license_name = license_name;
	}

	String getLicense_Date() {
		return license_date;
	}

	void setLicense_Date(String license_date) {
		this.license_date = license_date;
	}

	String getLicense_publisher() {
		return license_publisher;
	}

	void setLicense_publisher(String license_publisher) {
		this.license_publisher = license_publisher;
	}
}
