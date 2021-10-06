package com.moody.service;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.moody.dto.BoardDTO;
import com.moody.dto.BoardSearchDTO;
import com.moody.dto.MemberDTO;
import com.moody.exception.BizException;

public interface IBoardService {
	
	// 게시글 단건조회
	String getBoard(BoardSearchDTO search, int bNo, Model model);	
	// 게시글 리스트
	String getBoardList(String setBoardType, char boardType, String strPageNo, Model model);	
	// 검색글 리스트
	String getSearchList(String boardType, char bType, BoardSearchDTO search, Model model);	
	// 글 작성 페이지로 이동
	String insertBoardPage(String page, Model model);

	// 일반게시글 작성
	void insertBoard(BoardDTO dto, HttpSession session) throws BizException;	
	// 게시글 수정페이지로 이동
	String updateBoardPage(BoardSearchDTO searchDTO, int bNo, Model model);	
	// 추천수
	public String recommend(BoardDTO boardDTO, MemberDTO memberDTO) throws Exception;	
	// 게시글 수정
	void updateBoard(BoardDTO boardDTO) throws BizException;	
	// 게시글 삭제
	void deleteBoard(int bNo) throws BizException;
	
	// 지난주 통계차트
	public String getLastWeekChart(MemberDTO memberDTO);
	// 이번주 통계차트
	public String getThisWeekChart(MemberDTO memberDTO);
	// 이번달 통계차트
	public String getThisMonthChart(MemberDTO memberDTO);
	// 이번년도 통계차트
	public String getThisYearChart(MemberDTO memberDTO);
	// 종합 통계 차트
	public String getChartTotal(MemberDTO memberDTO);
	

}