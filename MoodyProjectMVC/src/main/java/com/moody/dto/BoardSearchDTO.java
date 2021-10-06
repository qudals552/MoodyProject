package com.moody.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class BoardSearchDTO {
	private String page;
	private String type;
	private String searchType; // 검색창 타입
	private String keyword;
	private String boardType; // 게시판 타입
	private int startPage;
	private int endPage;
	
	private char bType;
	
	public BoardSearchDTO() {}
}
