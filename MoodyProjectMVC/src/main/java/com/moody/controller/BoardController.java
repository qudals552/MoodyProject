package com.moody.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.moody.dto.BoardDTO;
import com.moody.dto.BoardSearchDTO;
import com.moody.dto.ReplyDTO;
import com.moody.exception.BizException;
import com.moody.service.IBoardService;
import com.moody.service.IReplyService;

@Controller
public class BoardController {
	@Autowired
	private IBoardService boardService;
	@Autowired
	private IReplyService replyService;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	// 인기글 리스트
	@RequestMapping(value="/getBestList", method=RequestMethod.GET)
	public String getBestList(String page, Model model) {
		logger.info("getBestList called ============");		
		String setBoardType = "getBestList";
		char boardType = 'M'; // db검색용 게시판 글type
		String url = boardService.getBoardList(setBoardType, boardType, page, model);
		return url;
	}
	
	// 인기글 검색 리스트
	@RequestMapping(value="/getBestSearch", method=RequestMethod.GET)
	public String getBestSearch(BoardSearchDTO search, Model model) {		
		logger.info("getBestSearch called ============");
		
		String setBoardType = "getBestSearch";
		char boardType = 'M';
		String url = boardService.getSearchList(setBoardType, boardType, search, model);		
		return url;
	}
	
	// 공지글 리스트
	@RequestMapping(value="/getNoticeList", method=RequestMethod.GET)
	public String getNoticeList(String page, Model model) {
		logger.info("getNoticeList called ============");
		
		String setBoardType = "getNoticeList";
		char boardType = 'N';
		String url = boardService.getBoardList(setBoardType, boardType, page, model);
		return url;
	}
	
	// 공지글 검색 리스트
	@RequestMapping(value="/getNoticeSerach", method=RequestMethod.GET)
	public String getNoticeSerach(BoardSearchDTO search, Model model) {		
		logger.info("getNoticeSerach called ============");
		
		String setBoardType = "getNoticeSerach";
		char boardType = 'N';
		String url = boardService.getSearchList(setBoardType, boardType, search, model);		
		return url;
	}
	
	// 게시글보기
	@RequestMapping(value="/getBoard", method=RequestMethod.GET)
	public String getBoard(BoardSearchDTO searchDTO, @ModelAttribute("bNo") int bNo, Model model) {
		logger.info("getBoard called ============");
		
		replyService.getReplyList(bNo, model);
		String url = boardService.getBoard(searchDTO, bNo, model);
		return url;
	}
	
	// 일반게시글 리스트 
	@RequestMapping(value="/getBoardList", method=RequestMethod.GET)
	public String getBoardList(String page, Model model) {
		logger.info("getBoardList called ============");
		
		String setBoardType = "getBoardList";
		char boardType = 'M';
		String url = boardService.getBoardList(setBoardType, boardType, page, model);
		return url;
	}
	
	// 일반게시글 검색 리스트
	@RequestMapping(value="/getSerachList", method=RequestMethod.GET)
	public String getSearchList(BoardSearchDTO search, Model model) {		
		logger.info("getSerachList called ============");
		
		String setBoardType = "getSerachList";
		char boardType = 'M';
		String url = boardService.getSearchList(setBoardType, boardType, search, model);		
		return url;
	}
	
	// 게시글 작성화면
	@RequestMapping(value="/insertBoardPage", method=RequestMethod.GET)
	public String insertBoardPage() {
		logger.info("insertBoardPage called ============");
		
		return "boardRegister";
	}
	
	// 게시글 작성, 그 후 게시글 리스트 화면 띄우기
	@RequestMapping(value="/insertBoard", method=RequestMethod.POST)
	public String insertBoard(BoardDTO boardDto, Model model, HttpSession session) throws BizException {
		logger.info("insertBoard called ============");
		boardService.insertBoard(boardDto, session); // 글삽입
		String page = null; // 글작성시 메인페이지로 돌아감
		
		char bType = 'M';
		String setBoardType = "getBoardList";		
		model.addAttribute("BOARD_TYPE", setBoardType);
		
		String url = boardService.getBoardList(setBoardType, bType, page, model);
		return url;
	}
	
	// 글 수정화면
	@RequestMapping(value="/updateBoardPage", method=RequestMethod.GET)
	public String updateBoardPage(BoardSearchDTO searchDTO, @ModelAttribute("bNo") int bNo, Model model) {
		logger.info("updateBoardPage called ============");		
		
		String url = boardService.updateBoardPage(searchDTO, bNo, model);		
		return url;
	}
	
	// 글 수정
	@RequestMapping(value="/updateBoard", method=RequestMethod.POST)
	public String updateBoard(BoardSearchDTO searchDTO, BoardDTO boardDTO, Model model) throws BizException {
		logger.info("updateBoard called ============");
		boardService.updateBoard(boardDTO); // 글수정
		
		replyService.getReplyList(boardDTO.getbNo(), model);
		String url = boardService.getBoard(searchDTO, boardDTO.getbNo(), model);
		return url;
	}
	
	// 글 삭제
	@RequestMapping(value="/deleteBoard", method=RequestMethod.GET)
	public String deleteBoard(BoardDTO boardDTO, String page, Model model) throws BizException {
		logger.info("deleteBoard called ============");
		
		replyService.deleteReplyList(boardDTO.getbNo()); // 댓글리스트 삭제
		boardService.deleteBoard(boardDTO.getbNo()); // 글삭제
		
		char bType = 'M';
		String setBoardType = "getBoardList";		
		model.addAttribute("BOARD_TYPE", setBoardType);
		
		String url = boardService.getBoardList(setBoardType, bType, page, model);
		return url;
	}
	
	// 댓글 작성
	@RequestMapping(value="/insertReply", method=RequestMethod.POST)
	public String insertReply(BoardSearchDTO searchDTO, ReplyDTO replyDTO, Model model) throws BizException {
		logger.info("insertReply called ============");
		
		System.out.println(replyDTO);
		
		replyService.insertReply(replyDTO); // 글수정
		
		replyService.getReplyList(replyDTO.getBno(), model);
		String url = boardService.getBoard(searchDTO, replyDTO.getBno(), model);
		return url;
	}
	
	// 댓글 수정
	@RequestMapping(value="/updateReply", method=RequestMethod.GET)
	public String updateReply(BoardSearchDTO searchDTO, ReplyDTO replyDTO, Model model) throws BizException {
		logger.info("updateReply called ============");
		
		replyService.updateReply(replyDTO); // 댓글수정
		
		replyService.getReplyList(replyDTO.getBno(), model);
		String url = boardService.getBoard(searchDTO, replyDTO.getBno(), model);
		return url;
	}
	
	// 댓글 삭제
	@RequestMapping(value="/deleteReply", method=RequestMethod.GET)
	public String deleteReply(BoardSearchDTO searchDTO, ReplyDTO replyDTO, @ModelAttribute("bno") int bno, Model model) throws BizException {
		logger.info("deleteReply called ============");
		
		replyService.deleteReply(replyDTO.getRno()); //댓글삭제
		
		replyService.getReplyList(replyDTO.getBno(), model);
		String url = boardService.getBoard(searchDTO, bno, model);
		return url;
	}
	
	// 차트화면
	@RequestMapping(value="/chartPage", method=RequestMethod.GET)
	public String chartPage() {
		logger.info("chartPage called ============");
		
		return "userChartView";
	}
}
