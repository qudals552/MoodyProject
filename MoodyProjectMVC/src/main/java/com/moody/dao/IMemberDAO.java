package com.moody.dao;

import com.moody.dto.MemberDTO;

public interface IMemberDAO {
	// 한 사람에 대한 정보 => select문
	public MemberDTO getUser(String id);
	
	// insert문
	public void insertUser(MemberDTO mbrDto);
	
	// update문
	public void update(MemberDTO mbrDto);
	
	// grade = "F"로 변경. 유저 데이터를 남김
	public void delete(String id);
}
