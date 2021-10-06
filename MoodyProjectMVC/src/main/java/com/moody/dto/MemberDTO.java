package com.moody.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class MemberDTO {
	private String id; // 아이디(PK)
	private String nickName; // 닉네임(유니크)
	private String password; // 패스워드
	private String email; // 이메일(유니크)	
	private String regDate; // 가입일(0000년 00월 00일 00시 00분 00초)
	private char grade; // 회원권한(관리자:M, 회원:C);
	
	public MemberDTO() {}
}
