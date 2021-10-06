package com.moody.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.moody.dto.BoardDTO;
import com.moody.dto.BoardSearchDTO;
import com.moody.dto.ReplyDTO;

public interface IBoardQEBC {
	
	// 무디게시판 페이징쿼리
	public ArrayList<BoardDTO> getList(HashMap<String, Object> hm);
	public int getPagingCount(HashMap<String, Object> hm); // 게시판 페이지수
	public int getBoardCount(HashMap<String, Object> hm); // 게시 글숫자
	
	// 무디게시판 검색 페이징쿼리
	public ArrayList<BoardDTO> getSearch(BoardSearchDTO boardSearchDto);
	public int getSearchPageCount(BoardSearchDTO boardSearchDto); // 검색게시판 페이지 수 type = 게시판 타입
	public int getSearchCount(BoardSearchDTO boardSearchDto); // 검색게시판 글숫자
	
	// 댓글목록
	public ArrayList<ReplyDTO> getReplyList(int bno);
	public void boardReplyDelete(int bno);
	
	// 차트	
	public int getChartLastWeek(HashMap<String, Object> hm); //지난주
	public int getChartThisWeek(HashMap<String, Object> hm); //이번주
	public int getChartThisMonth(HashMap<String, Object> hm); //이번달
	public int getChartThisYear(HashMap<String, Object> hm); //이번년
	public int getChartTotal(HashMap<String, Object> hm); // 전체통합
}
