package com.moody.service;

import org.springframework.ui.Model;

import com.moody.dto.BoardSearchDTO;
import com.moody.dto.MemberDTO;
import com.moody.exception.BizException;

public interface IMemberService {
	
	public MemberDTO loginOK(MemberDTO mem);
	
	public String passChk(MemberDTO getUser, String password);
	
	public String idChk(String id);
	
	public String nickChk(String nickName);
	
	public void updateUser(MemberDTO mem) throws BizException;
	
	public void insertUser(MemberDTO mem) throws BizException;
	
	public void deleteUser(String id) throws BizException;
	
	public String getSearchList(String setBoardType, BoardSearchDTO searchDTO, Model model);
	
	public String getBoardList(String setBoardType, String page, Model model);
}
