package com.moody.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.moody.dto.BoardDTO;
import com.moody.dto.MemberDTO;
import com.moody.service.IBoardService;
import com.moody.service.IReplyService;

@RestController
public class BoardResponseController {
	
	@Autowired
	private IBoardService boardService;
	@Autowired
	private IReplyService replyService;
	private static final Logger logger = LoggerFactory.getLogger(BoardResponseController.class);
	
	// 글 추천 아이디 있으면 0 없으면 추천 후 1 리턴	ajax
	@RequestMapping(value="recommend", produces = "application/text;charset=UTF-8", method=RequestMethod.GET)
	public @ResponseBody String recommend(BoardDTO boardDTO, HttpSession session) throws Exception {
		logger.info("recommend called ============");
		
		MemberDTO chkMem = (MemberDTO) session.getAttribute("user");
		String jsonOut = boardService.recommend(boardDTO, chkMem);	
		
		return jsonOut;
	}
	
	// 댓글 내용조회
	@RequestMapping(value="replyRead.do", produces = "application/text;charset=UTF-8", method=RequestMethod.GET)
	public @ResponseBody String replyRead(@ModelAttribute("rno") int rno) throws Exception {
		logger.info("replyRead called ============");
		
		String jsonOut = replyService.getReplyRead(rno);
		
		return jsonOut;
	}
	
	// 지난주 차트
	@RequestMapping(value="lastWeekChart.do", produces = "application/text;charset=UTF-8", method=RequestMethod.GET)
	public @ResponseBody String lastWeekChart(HttpSession session) throws Exception {
		logger.info("lastWeekChart called ============");
		
		MemberDTO mem = (MemberDTO) session.getAttribute("user");
		String jsonOut = boardService.getLastWeekChart(mem);
		System.out.println("====" + jsonOut);
		
		return jsonOut;
	}
	
	// 이번주 차트
	@RequestMapping(value="ThisWeekChart.do", produces = "application/text;charset=UTF-8", method=RequestMethod.GET)
	public @ResponseBody String ThisWeekChart(HttpSession session) throws Exception {
		logger.info("ThisWeekChart called ============");
				
		MemberDTO mem = (MemberDTO) session.getAttribute("user");
		String jsonOut = boardService.getThisWeekChart(mem);
		System.out.println("====" + jsonOut);
				
		return jsonOut;
	}
	
	// 이번달 차트
	@RequestMapping(value="ThisMonthChart.do", produces = "application/text;charset=UTF-8", method=RequestMethod.GET)
	public @ResponseBody String ThisMonthChart(HttpSession session) throws Exception {
		logger.info("ThisMonthChart called ============");
		
		MemberDTO mem = (MemberDTO) session.getAttribute("user");
		String jsonOut = boardService.getThisMonthChart(mem);
		System.out.println("====" + jsonOut);
		
		return jsonOut;
	}
	
	// 이번년도 차트
	@RequestMapping(value="ThisYearChart.do", produces = "application/text;charset=UTF-8", method=RequestMethod.GET)
	public @ResponseBody String ThisYearChart(HttpSession session) throws Exception {
		logger.info("ThisYearChart called ============");
		
		MemberDTO mem = (MemberDTO) session.getAttribute("user");
		String jsonOut = boardService.getThisYearChart(mem);
		System.out.println("====" + jsonOut);
		
		return jsonOut;
	}
	
	// 전체차트
	@RequestMapping(value="ChartTotal.do", produces = "application/text;charset=UTF-8", method=RequestMethod.GET)
	public @ResponseBody String chart(HttpSession session) throws Exception {
		logger.info("Chart called ============");
		
		MemberDTO mem = (MemberDTO) session.getAttribute("user");
		String jsonOut = boardService.getChartTotal(mem);
		System.out.println("====" + jsonOut);
		
		return jsonOut;
	}
}
