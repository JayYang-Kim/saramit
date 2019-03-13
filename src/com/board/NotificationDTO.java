package com.board;

public class NotificationDTO {
	private int boardNum;
	private String subject;
	private String content;
	private String email;
	private String name;
	private int hitCount;
	private String created;
	private String saveFileName;
	private String originalFileName;
	private long fileSize;
	private int listNum;
	private long gap;
	
	
	
	public final long getGap() {
		return gap;
	}
	public final void setGap(long gap) {
		this.gap = gap;
	}
	public final int getListNum() {
		return listNum;
	}
	public final void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public final String getName() {
		return name;
	}
	public final void setName(String name) {
		this.name = name;
	}
	public final String getSaveFileName() {
		return saveFileName;
	}
	public final void setSaveFileName(String saveFileName) {
		this.saveFileName = saveFileName;
	}
	public final String getOriginalFileName() {
		return originalFileName;
	}
	public final void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}
	public final long getFileSize() {
		return fileSize;
	}
	public final void setFileSize(long l) {
		this.fileSize = l;
	}
	public final int getBoardNum() {
		return boardNum;
	}
	public final void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	public final String getSubject() {
		return subject;
	}
	public final void setSubject(String subject) {
		this.subject = subject;
	}
	public final String getContent() {
		return content;
	}
	public final void setContent(String content) {
		this.content = content;
	}
	public final String getEmail() {
		return email;
	}
	public final void setEmail(String email) {
		this.email = email;
	}
	public final int getHitCount() {
		return hitCount;
	}
	public final void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	public final String getCreated() {
		return created;
	}
	public final void setCreated(String created) {
		this.created = created;
	}
}
