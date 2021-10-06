package com.moody.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.moody.dto.BoardSearchDTO;
import com.moody.dto.MemberDTO;

public interface IMemberQEBC {
	
	// 회원 페이징쿼리
	public ArrayList<MemberDTO> getList(HashMap<String, Object> hm);
	public int getPagingCount(); // 게시판 페이지수
	public int getMemberCount(); // 게시 글숫자
	
	// 회원검색 페이징쿼리
	public ArrayList<MemberDTO> getSearch(BoardSearchDTO boardSearchDto);
	public int getSearchPageCount(BoardSearchDTO boardSearchDto); // 검색게시판 페이지 수 type = 게시판 타입
	public int getSearchCount(BoardSearchDTO boardSearchDto); // 검색게시판 글숫자
	
	//닉네임 확인용
	public MemberDTO getNickName(String nickName);	
}
