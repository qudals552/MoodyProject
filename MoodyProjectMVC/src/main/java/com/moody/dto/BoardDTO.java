package com.moody.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class BoardDTO {
	private int bNo;
	private String id; // 아이디
	private String nickName; // 닉네임
	private char bMood; // 행복 : 1, 기쁨 : 2, 보통 : 3, 슬픔 : 4, 화남 : 5
	private String bTitle;
	private String bContent;
	private String bRegDate;
	private String bUpdateDate;
	private int bLike;
	private char bType; // 공지 : N, 상담실 : Q, 일반 : M
	
	public BoardDTO() {}
	
	public int getbNo() {
		return bNo;
	}	
	public void setbNo(int bNo) {
		this.bNo = bNo;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public char getbMood() {
		return bMood;
	}
	public void setbMood(char bMood) {
		this.bMood = bMood;
	}
	public String getbTitle() {
		return bTitle;
	}
	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}
	public String getbContent() {
		return bContent;
	}
	public void setbContent(String bContent) {
		this.bContent = bContent;
	}
	public String getbRegDate() {
		return bRegDate;
	}
	public void setbRegDate(String bRegDate) {
		this.bRegDate = bRegDate;
	}
	public String getbUpdateDate() {
		return bUpdateDate;
	}
	public void setbUpdateDate(String bUpdateDate) {
		this.bUpdateDate = bUpdateDate;
	}
	public int getbLike() {
		return bLike;
	}
	public void setbLike(int bLike) {
		this.bLike = bLike;
	}
	public char getbType() {
		return bType;
	}
	public void setbType(char bType) {
		this.bType = bType;
	}
}
