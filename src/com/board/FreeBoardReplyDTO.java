package com.board;

public class FreeBoardReplyDTO {
	private int boardNum;
	private int replyNum;
	private String email;
	private String content;
	private String created;
	
	public final int getBoardNum() {
		return boardNum;
	}
	public final void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	public final int getReplyNum() {
		return replyNum;
	}
	public final void setReplyNum(int replyNum) {
		this.replyNum = replyNum;
	}
	public final String getEmail() {
		return email;
	}
	public final void setEmail(String email) {
		this.email = email;
	}
	public final String getContent() {
		return content;
	}
	public final void setContent(String content) {
		this.content = content;
	}
	public final String getCreated() {
		return created;
	}
	public final void setCreated(String created) {
		this.created = created;
	}
	
}
