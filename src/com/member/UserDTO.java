package com.member;

public class UserDTO {
	private String userEmail; //�̸���
	private String userPwd; //��й�ȣ
	private String userName; //�̸�
	private String postCode; // �����ȣ
	private String address; //�ּ�
	private String detailAddress; // ���ּ�
	private String extraAddress; // �����׸�
	private String birth; //�������
	private String gender; //����
	private int statusCode; //ȸ�� ����
	private int levelCode; //����,��� ����
	public final String getUserEmail() {
		return userEmail;
	}
	public final void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public final String getUserPwd() {
		return userPwd;
	}
	public final void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public final String getUserName() {
		return userName;
	}
	public final void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPostCode() {
		return postCode;
	}
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}
	public final String getAddress() {
		return address;
	}
	public final void setAddress(String address) {
		this.address = address;
	}
	public String getDetailAddress() {
		return detailAddress;
	}
	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}
	public String getExtraAddress() {
		return extraAddress;
	}
	public void setExtraAddress(String extraAddress) {
		this.extraAddress = extraAddress;
	}
	public final String getBirth() {
		return birth;
	}
	public final void setBirth(String birth) {
		this.birth = birth;
	}
	public final String getGender() {
		return gender;
	}
	public final void setGender(String gender) {
		this.gender = gender;
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
