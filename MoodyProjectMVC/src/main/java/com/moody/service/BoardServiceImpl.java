package com.moody.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.moody.dao.IBoardDAO;
import com.moody.dao.IBoardQEBC;
import com.moody.dao.IRecommendDAO;
import com.moody.dto.BoardDTO;
import com.moody.dto.BoardSearchDTO;
import com.moody.dto.MemberDTO;
import com.moody.dto.PageDTO;
import com.moody.exception.BizException;

@Service
public class BoardServiceImpl implements IBoardService {
	@Autowired
	private IBoardDAO daoBoard;
	@Autowired
	private IBoardQEBC qebcBoard;
	@Autowired
	private IRecommendDAO daoRecommend;	
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	// 게시글 단건조회
	@Override
	public String getBoard(BoardSearchDTO searchDTO, int bNo, Model model) {
		
		BoardDTO boardDto = daoBoard.getBoard(bNo);
		
		int nPageNo;
		if(searchDTO.getPage() == null) {
			nPageNo = 1;
		} else {
			nPageNo = Integer.parseInt(searchDTO.getPage());
		}
		
		model.addAttribute("boardDTO", boardDto);
		model.addAttribute("page", nPageNo);
		
		model.addAttribute("searchDTO", searchDTO);
		model.addAttribute("type", searchDTO.getType());
		model.addAttribute("keyword", searchDTO.getKeyword());
		
		return "boardView";
	}
	
	// 무디게시글 검색
	@Override
	public String getSearchList(String setBoardType, char bType, BoardSearchDTO searchDTO, Model model) { // 검색후에 1페이지로 보내기 때문에 페이지 필요없음

		final int END_PAGE_NO = 10; // 페이지당 최대글 수
		int nPageNo;
		PageDTO pageDto = new PageDTO();
		
		if("T".equals(searchDTO.getType())) {
			searchDTO.setSearchType("B_TITLE");
		} else if("C".equals(searchDTO.getType())) {
			searchDTO.setSearchType("B_CONTENT");
		} else if("W".equals(searchDTO.getType())) {
			searchDTO.setSearchType("M.M_NICK");
		}
		
		if(searchDTO.getPage() == null) {
			nPageNo = 1;
		} else {
			nPageNo = Integer.parseInt(searchDTO.getPage());
		}
		
		
		searchDTO.setStartPage((nPageNo-1)*END_PAGE_NO + 1);
		searchDTO.setEndPage(END_PAGE_NO + 1);
		searchDTO.setBType(bType);
		searchDTO.setBoardType(setBoardType);
		
		int total = qebcBoard.getSearchCount(searchDTO);//게시글 숫자
		int pageCount = qebcBoard.getSearchPageCount(searchDTO); // 페이지 카운트
		ArrayList<BoardDTO> list = qebcBoard.getSearch(searchDTO);
		
		/*if(list.size() == 0) { // list안이 비었을 때
			return "SearchErrPage";
		}*/
		
		if(list.size() > END_PAGE_NO) {
			list.remove(END_PAGE_NO);
		} 
		
		logger.info("getSearchList called ==============");
				
		int endPage = (int)(Math.ceil(nPageNo / 10.0)) * 10;
		int startPage = endPage - 9;
		
		int realEnd = (int)(Math.ceil((total * 1.0) / 10));
		
		if(realEnd < endPage) {
			endPage = realEnd;
		}

		boolean prev = startPage > 1;
		boolean next = endPage < realEnd;
		
		pageDto.setPrev(prev);
		pageDto.setNext(next);
		pageDto.setStartPage(startPage);
		pageDto.setEndPage(endPage);
		searchDTO.setStartPage(startPage);
		searchDTO.setEndPage(endPage);
		pageDto.setTotal(total); // 페이지 갯수넣어서 갯수마다 버튼숫자
		
		searchDTO.setBoardType(setBoardType);
		String boardType = searchDTO.getBoardType();
		String type = searchDTO.getType();
		String keyword = searchDTO.getKeyword();		
		
		model.addAttribute("BType", bType);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("page", nPageNo);
		model.addAttribute("pageDTO", pageDto);
		model.addAttribute("BOARD_LIST", list);
		model.addAttribute("BOARD_TYPE", boardType);
		
		model.addAttribute("searchDTO", searchDTO);
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
		
		return "boardList";
	}
	
	// 게시글 리스트페이징
	@Override
	public String getBoardList(String setBoardType, char bType, String strPageNo, Model model) {
		final int END_PAGE_NO = 10;
		int nPageNo;
		PageDTO pageDto = new PageDTO();
		
		if(strPageNo == null) {
			nPageNo = 1;
		} else {
			nPageNo = Integer.parseInt(strPageNo);
		}
		
		pageDto.setStartPage((nPageNo-1)*END_PAGE_NO + 1);
		pageDto.setEndPage(END_PAGE_NO + 1);
		pageDto.setBType(bType);
		pageDto.setBoardType(setBoardType);
		
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("pageDTO", pageDto);
		hm.put("boardType", setBoardType);
		hm.put("bType", bType);
		
		System.out.println(hm);
		
		ArrayList<BoardDTO> list = qebcBoard.getList(hm);
		
		//확인용
		/*for(int i = 0; i < list.size(); i++) {
			System.out.println("list = " + list.get(i));
		}*/
		
		if(list.size() > END_PAGE_NO) {
			list.remove(END_PAGE_NO);
		}
		
		logger.info("getList called ==============");
		
		int total = qebcBoard.getBoardCount(hm); //게시글 숫자
		int pageCount = qebcBoard.getPagingCount(hm); // 페이지 카운트
		
		int endPage = (int)(Math.ceil(nPageNo / 10.0)) * 10;
		int startPage = endPage - 9;
		System.out.println("스타트=" + startPage + ", 엔드=" + endPage);
		
		int realEnd = (int)(Math.ceil((total * 1.0) / 10));
		
		if(realEnd < endPage) {
			endPage = realEnd;
		}

		boolean prev = startPage > 1;
		boolean next = endPage < realEnd;
		
		String test = String.valueOf(prev) + " " + String.valueOf(next);
		
		System.out.println("스타트=" + startPage + ", 엔드=" + endPage);
		System.out.println("테스트=" + test);
		
		pageDto.setPrev(prev);
		pageDto.setNext(next);
		pageDto.setStartPage(startPage);
		pageDto.setEndPage(endPage);	
		pageDto.setTotal(total); // 페이지 갯수넣어서 갯수마다 버튼숫자
		
//		String boardType = "getBoardList";
		
		model.addAttribute("BType", bType);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("page", nPageNo);
		model.addAttribute("pageDTO", pageDto);
		model.addAttribute("BOARD_LIST", list);
		model.addAttribute("BOARD_TYPE", setBoardType);
		
		// 검색삭제
		model.addAttribute("searchDTO", null);
		model.addAttribute("type", null);
		model.addAttribute("keyword", null);
		
		return "boardList";
	}
	
	// 글 작성 페이지로 이동
	@Override
	public String insertBoardPage(String page, Model model) {
		int nPageNo;
		if(page == null) {
			nPageNo = 1;
		} else {
			nPageNo = Integer.parseInt(page);
		}
		model.addAttribute("page", nPageNo);
		
		return "boardRegister";
	}
	
	// 일반게시글 작성
	@Override
	@Transactional
	public void insertBoard(BoardDTO dto, HttpSession session) throws BizException {
		SimpleDateFormat dateFormat = new SimpleDateFormat ( "yyyyMMddHHmmss"); 
		Date regDate = new Date();
		String dt = dateFormat.format(regDate);
		
		if(daoBoard.getBoard(dto.getbNo()) != null) { // 안에 같은 번호가 있으면 오류처리
			throw new BizException("글 작성 중 오류가 발생했습니다.");
		}
		
		dto.setbLike(0); // 추천수 20 이상인 글은 인기글
		dto.setbRegDate(dt);
		dto.setbUpdateDate(dt);
		
		MemberDTO chkGrade = (MemberDTO) session.getAttribute("user");
		
		System.out.println(chkGrade.getGrade());
		
		String chk = String.valueOf(chkGrade.getGrade());
		
		if("M".equals(chk)) {
			dto.setbType('N'); // 공지 : N, 일반 : M
		} else {
			dto.setbType('M'); // 공지 : N, 일반 : M
		}
		
		System.out.println(dto);
		
		daoBoard.insert(dto);
	}
	
	// 게시글 수정페이지
	public String updateBoardPage(BoardSearchDTO searchDTO, int bNo, Model model) {
		BoardDTO boardDto = daoBoard.getBoard(bNo);
		
		int nPageNo;
		if(searchDTO.getPage() == null) {
			nPageNo = 1;
		} else {
			nPageNo = Integer.parseInt(searchDTO.getPage());
		}
		
		model.addAttribute("boardDTO", boardDto);
		model.addAttribute("page", nPageNo);
		
		model.addAttribute("searchDTO", searchDTO);
		model.addAttribute("type", searchDTO.getType());
		model.addAttribute("keyword", searchDTO.getKeyword());
		
		return "boardUpdate";
	}
	
	// 추천
	@Override
	@Transactional
	public String recommend(BoardDTO boardDTO, MemberDTO chkMem) throws Exception {
		String id = chkMem.getId(); // 세션아이디
		HashMap<String, Object> sethm = new HashMap<>();
		sethm.put("bNo", boardDTO.getbNo());
		sethm.put("id", id);
		
		String getRecommend = daoRecommend.getRecommend(sethm);
		
		boolean result = false;
		JSONObject jsonObj = new JSONObject();
		String JsonOut;
		
		if(id.equals(getRecommend)) { // 같은 아이디가 있으면
			result = true;
			jsonObj.put("result", result); // 결과값 true
			JsonOut = jsonObj.toString();
			
			return JsonOut; // 결과값 false을 리턴
		} else {
			result = false;
		}
		
		BoardDTO chkBoard = daoBoard.getBoard(boardDTO.getbNo());
		
		// RECOMMEND 테이블에 저장
		daoRecommend.insertRecommendHist(sethm);
		
		// 추천수 +1
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("bNo", boardDTO.getbNo());
		hm.put("bLike", chkBoard.getbLike()+1);
		
		daoRecommend.recommend(hm);
		
		jsonObj.put("result", result); // 결과값 false
		JsonOut = jsonObj.toString();
		
		// 추천수 업뎃
		return JsonOut;
	}
	
	// 게시글 수정
	@Override
	@Transactional
	public void updateBoard(BoardDTO boardDTO) throws BizException {
		SimpleDateFormat dateFormat = new SimpleDateFormat ( "yyyyMMddHHmmss"); 
		Date regDate = new Date();
		String dt = dateFormat.format(regDate);
		
		BoardDTO chkBoard = daoBoard.getBoard(boardDTO.getbNo());
		
		if(chkBoard == null) {
			throw new BizException("글 수정 중 오류가 발생했습니다.");
		}
		// 수정날짜 추가
		boardDTO.setbUpdateDate(dt);
		// 업데이트
		daoBoard.update(boardDTO);		
	}
	
	// 게시글 삭제
	@Override
	@Transactional
	public void deleteBoard(int bNo) throws BizException {
		BoardDTO chkBoard = daoBoard.getBoard(bNo);
		if(chkBoard == null) { // 에러페이지로 이동
			throw new BizException("글 삭제 중 오류가 발생했습니다.");
		}
		// 게시글 안에 댓글 전부삭제
//		qebcBoard.boardReplyDelete(bNo);
		// 추천이력 삭제
		daoRecommend.deleteRecommendHist(bNo);
		// 게시글 삭제
		daoBoard.delete(bNo);
	}
	
	@Override
	public String getChartTotal(MemberDTO memberDTO) {
		String id = memberDTO.getId();
		JSONObject jsonObj = new JSONObject();	
		HashMap<String, Object> hm = new HashMap<>();
		
		hm.put("id", id);
		hm.put("bMood", '1');
		int mood1 = qebcBoard.getChartTotal(hm); // 1.행복해요
		jsonObj.put("Moody1", mood1);
		hm.put("bMood", '2');
		int mood2 = qebcBoard.getChartTotal(hm); // 2.기뻐요
		jsonObj.put("Moody2", mood2);
		hm.put("bMood", '3');
		int mood3 = qebcBoard.getChartTotal(hm); // 3.보통이에요
		jsonObj.put("Moody3", mood3);
		hm.put("bMood", '4');
		int mood4 = qebcBoard.getChartTotal(hm); // 4.슬퍼요
		jsonObj.put("Moody4", mood4);
		hm.put("bMood", '5');
		int mood5 = qebcBoard.getChartTotal(hm); // 5.화나요
		jsonObj.put("Moody5", mood5);		
		
		String jsonOut = jsonObj.toString();
		
		return jsonOut;
	}
	
	@Override
	public String getLastWeekChart(MemberDTO memberDTO) {
		String id = memberDTO.getId();
		JSONObject jsonObj = new JSONObject();	
		HashMap<String, Object> hm = new HashMap<>();		
		
		hm.put("id", id);
		hm.put("bMood", '1');
		int mood1 = qebcBoard.getChartLastWeek(hm); // 1.행복해요
		jsonObj.put("Moody1", mood1);
		hm.put("bMood", '2');
		int mood2 = qebcBoard.getChartLastWeek(hm); // 2.기뻐요
		jsonObj.put("Moody2", mood2);
		hm.put("bMood", '3');
		int mood3 = qebcBoard.getChartLastWeek(hm); // 3.보통이에요
		jsonObj.put("Moody3", mood3);
		hm.put("bMood", '4');
		int mood4 = qebcBoard.getChartLastWeek(hm); // 4.슬퍼요
		jsonObj.put("Moody4", mood4);
		hm.put("bMood", '5');
		int mood5 = qebcBoard.getChartLastWeek(hm); // 5.화나요
		jsonObj.put("Moody5", mood5);
		
		String jsonOut = jsonObj.toString();
		
		return jsonOut;
	}
	
	@Override
	public String getThisWeekChart(MemberDTO memberDTO) {
		String id = memberDTO.getId();
		JSONObject jsonObj = new JSONObject();	
		HashMap<String, Object> hm = new HashMap<>();		
		
		hm.put("id", id);
		hm.put("bMood", '1');
		int mood1 = qebcBoard.getChartThisWeek(hm); // 1.행복해요
		jsonObj.put("Moody1", mood1);
		hm.put("bMood", '2');
		int mood2 = qebcBoard.getChartThisWeek(hm); // 2.기뻐요
		jsonObj.put("Moody2", mood2);
		hm.put("bMood", '3');
		int mood3 = qebcBoard.getChartThisWeek(hm); // 3.보통이에요
		jsonObj.put("Moody3", mood3);
		hm.put("bMood", '4');
		int mood4 = qebcBoard.getChartThisWeek(hm); // 4.슬퍼요
		jsonObj.put("Moody4", mood4);
		hm.put("bMood", '5');
		int mood5 = qebcBoard.getChartThisWeek(hm); // 5.화나요
		jsonObj.put("Moody5", mood5);	
		
		String jsonOut = jsonObj.toString();
		
		/*int total = (int) (Math.ceil((mood1 + mood2 + mood3 + mood4 + mood5) / 5));
		if(total == 0) {
			jsonOut = null;
		}*/
		
		return jsonOut;
	}
	
	@Override
	public String getThisMonthChart(MemberDTO memberDTO) {
		String id = memberDTO.getId();
		JSONObject jsonObj = new JSONObject();	
		HashMap<String, Object> hm = new HashMap<>();		
		
		hm.put("id", id);
		hm.put("bMood", '1');
		int mood1 = qebcBoard.getChartThisMonth(hm); // 1.행복해요
		jsonObj.put("Moody1", mood1);
		hm.put("bMood", '2');
		int mood2 = qebcBoard.getChartThisMonth(hm); // 2.기뻐요
		jsonObj.put("Moody2", mood2);
		hm.put("bMood", '3');
		int mood3 = qebcBoard.getChartThisMonth(hm); // 3.보통이에요
		jsonObj.put("Moody3", mood3);
		hm.put("bMood", '4');
		int mood4 = qebcBoard.getChartThisMonth(hm); // 4.슬퍼요
		jsonObj.put("Moody4", mood4);
		hm.put("bMood", '5');
		int mood5 = qebcBoard.getChartThisMonth(hm); // 5.화나요
		jsonObj.put("Moody5", mood5);
		
		String jsonOut = jsonObj.toString();
		
		return jsonOut;
	}
	
	@Override
	public String getThisYearChart(MemberDTO memberDTO) {
		String id = memberDTO.getId();
		JSONObject jsonObj = new JSONObject();	
		HashMap<String, Object> hm = new HashMap<>();		
		
		hm.put("id", id);
		hm.put("bMood", '1');
		int mood1 = qebcBoard.getChartThisYear(hm); // 1.행복해요
		jsonObj.put("Moody1", mood1);
		hm.put("bMood", '2');
		int mood2 = qebcBoard.getChartThisYear(hm); // 2.기뻐요
		jsonObj.put("Moody2", mood2);
		hm.put("bMood", '3');
		int mood3 = qebcBoard.getChartThisYear(hm); // 3.보통이에요
		jsonObj.put("Moody3", mood3);
		hm.put("bMood", '4');
		int mood4 = qebcBoard.getChartThisYear(hm); // 4.슬퍼요
		jsonObj.put("Moody4", mood4);
		hm.put("bMood", '5');
		int mood5 = qebcBoard.getChartThisYear(hm); // 5.화나요
		jsonObj.put("Moody5", mood5);
		
		String jsonOut = jsonObj.toString();
		
		return jsonOut;
	}
}
