package com.moody.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.moody.dto.BoardSearchDTO;
import com.moody.dto.MemberDTO;
import com.moody.exception.BizException;
import com.moody.service.IBoardService;
import com.moody.service.IMemberService;

@Controller
public class MemberController {
	@Autowired
	private IMemberService memService;
	@Autowired
	private IBoardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	// 디폴트 화면
	@RequestMapping(value = "/", method=RequestMethod.GET)
	public String home() {
		logger.info("home called =============");
		return "redirect:loginForm";
	}
	
	// 로그인 화면
	@RequestMapping(value="/loginForm", method=RequestMethod.GET)
	public String login(HttpSession session) {
		session.invalidate(); // 로그인창으로 넘어오면 세션삭제
		logger.info("loginForm called ============");
		return "loginForm";
	}
	
	// 회원가입 화면
	@RequestMapping(value="/joinForm", method=RequestMethod.GET)
	public String joinForm() {
		logger.info("joinForm called ============");
		return "joinForm";
	}
	
	// 로그인 확인
	@RequestMapping(value="/loginOK", method=RequestMethod.POST)
	public String loginOK(MemberDTO mem, HttpSession session, String page, Model model) { // 스프링한테 session 달라고 요청
		MemberDTO user = memService.loginOK(mem);
		
		char boardType = 'M';
		
		String setBoardType = "getBoardList";
		model.addAttribute("BType", boardType);
		
		if(user == null) {
			return "loginForm"; // 로그인 실패
		} else {
			char manager = 'M'; // 매니저 권한
			session.setAttribute("Manager", manager);
			session.setAttribute("user", user);
			return boardService.getBoardList(setBoardType, boardType, page, model);
		}
	}
	
	// 회원정보 수정 화면으로 이동
	@RequestMapping(value="/updateUserPage", method=RequestMethod.GET)
	public String updateUserPage() {
		logger.info("updateUserPage called ================");
		return "userForm";
	}
	
	// 회원수정
	@RequestMapping(value="/updateUser", method=RequestMethod.POST)
	public String updateUser(MemberDTO mem, Model model, HttpSession session) throws Exception{
		memService.updateUser(mem);
		
		char boardType = 'M';
		String page = "1";
		
		String setBoardType = "getBoardList";
		model.addAttribute("BType", boardType);
		
		MemberDTO user = memService.loginOK(mem);
		session.setAttribute("user", user);
		
		return boardService.getBoardList(setBoardType, boardType, page, model);
	}
	
	// 회원가입
	@RequestMapping(value="/insertUser", method=RequestMethod.POST)
	public String insertUser(MemberDTO mem) throws Exception{
		memService.insertUser(mem);
		return "successRegister";
	}
	
	// 회원탈퇴
	@RequestMapping(value="/deleteUser", method=RequestMethod.GET)
	public String deleteUser(String id, HttpSession session) throws Exception{
		
		MemberDTO mem = (MemberDTO) session.getAttribute("user");		
		memService.deleteUser(mem.getId());
		
		session.invalidate(); // 로그인창으로 넘어오면 세션삭제
		return "loginForm";
	}
	

	// 내 글보기
	@RequestMapping(value="/UserPostList", method=RequestMethod.GET)
	public String UserPostList(BoardSearchDTO search, Model model, HttpSession session) {		
		logger.info("UserPostList called ============");
		
		MemberDTO mem = (MemberDTO) session.getAttribute("user");
		
		search.setType("W");
		search.setKeyword(mem.getNickName());
		String setBoardType = "getSerachList";
		char boardType = 'M';
		String url = boardService.getSearchList(setBoardType, boardType, search, model);		
		return url;
	}
	
	// 관리자 회원 리스트
	@RequestMapping(value="/getMemberList", method=RequestMethod.GET)
	public String getMemberList(String page, Model model) {
		logger.info("getMemberList called ============");
		
		String setBoardType = "getMemberList";
		String url = memService.getBoardList(setBoardType, page, model);
		return url;
	}
	
	// 관리자 회원 검색리스트
	@RequestMapping(value="/getMemberSerachList", method=RequestMethod.GET)
	public String getMemberSerachList(BoardSearchDTO search, Model model) {		
		logger.info("getMemberSerachList called ============");
		
		String setBoardType = "getMemberSerachList";
		String url = memService.getSearchList(setBoardType, search, model);
		return url;
	}
	
	// 관리자 회원 검색리스트 탈퇴
	@RequestMapping(value="/deleteMember", method=RequestMethod.GET)
	public String deleteMember(String id, String page, BoardSearchDTO search, Model model) throws BizException {		
		logger.info("deleteMember called ============");
		
		memService.deleteUser(id); // 회원탈퇴
		
		String setBoardType;
		String url;
		
		if("getMemberSerachList".equals(search.getBoardType())) {
			setBoardType = "getMemberSerachList";
			url = memService.getSearchList(setBoardType, search, model);
		} else {			
			setBoardType = "getMemberList";
			url = memService.getBoardList(setBoardType, page, model);
		} 		 
		return url;
	}
}
