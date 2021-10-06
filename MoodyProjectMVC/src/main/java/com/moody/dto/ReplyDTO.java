package com.moody.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class ReplyDTO {
	private int rno;
	private int bno;
	private String id;
	private String nickName;	
	private String contents;
	private String regDate;
	private String updateDate;
	
	public ReplyDTO() {}
}
