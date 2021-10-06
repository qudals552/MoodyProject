package com.moody.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.moody.dao.IMemberDAO;
import com.moody.dao.IMemberQEBC;
import com.moody.dto.BoardSearchDTO;
import com.moody.dto.MemberDTO;
import com.moody.dto.PageDTO;
import com.moody.exception.BizException;

@Service
public class MemberServiceImpl implements IMemberService{
	@Autowired
	private IMemberDAO daoMem;
	@Autowired
	private IMemberQEBC qebcMem;
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	// 로그인 확인
	@Override
	public MemberDTO loginOK(MemberDTO mem) {
		logger.info("loginOK called ==============");
		String inId = mem.getId();
		String inPw = mem.getPassword();
		logger.info("입력한 ID : {}", inId);
		logger.info("입력한 PW : {}", inPw);
		
		MemberDTO user = daoMem.getUser(inId);		
		if(user == null) {
			return null;
		}
		
		String grade = String.valueOf(user.getGrade());		
		if("F".equals(grade)) { // 회원등급이 F면 null 반환
			return null;
		}
		
		String getPw = user.getPassword();
		
		if(inPw.equals(getPw)) {
			return user;
		} else {
			return null;
		}
	}
	
	// 회원정보 중복체크
	@Override
	public String idChk(String id) { 
		MemberDTO dto = daoMem.getUser(id);
		
		System.out.println(dto);
		
		boolean result = false;
		if(dto == null) {
			result = true;
		} else {
			result = false;
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", result);
		String jsonOut = jsonObj.toString();
		
		return jsonOut;
	}
	
	// 닉네임 중복체크
	@Override
	public String nickChk(String nickName) { 
		MemberDTO dto = qebcMem.getNickName(nickName);
		
		System.out.println(dto);
		
		boolean result = false;
		if(dto == null) {
			result = true;
		} else {
			result = false;
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", result);
		String jsonOut = jsonObj.toString();
		
		return jsonOut;
	}
	
	// 회원수정 비밀번호 중복검사
	@Override
	public String passChk(MemberDTO getUser, String password) {		
		MemberDTO dto = daoMem.getUser(getUser.getId());
		
		String chkPass = dto.getPassword();
		
		boolean result = false;
		if((chkPass == null)||(!password.equals(chkPass))) {
			result = false;
		} else if((chkPass != null)&&(password.equals(chkPass))) {
			result = true;
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("result", result);
		String jsonOut = jsonObj.toString();
		
		return jsonOut;
	}
	
	// 회원가입
	@Override
	@Transactional
	public void insertUser(MemberDTO mem) throws BizException {
		
		String 			id 		  = mem.getId();
		String 			pw 		  = mem.getPassword();
		String 			email 	  = mem.getEmail();
		String 			nickName  = mem.getNickName();
		char 			grade 	  = mem.getGrade();
		
		SimpleDateFormat dateFormat = new SimpleDateFormat ( "yyyyMMddHHmmss"); 
		Date regDate = new Date();
		String dt = dateFormat.format(regDate);
		
		if(daoMem.getUser(id) != null) {
			throw new BizException("이미 존재하는 아이디입니다.");
		}
		
		logger.info("insertUser called ==============");
		logger.info("입력한 ID : {}", id);
		logger.info("입력한 PW : {}", pw);
		logger.info("입력한 EM : {}", email);
		logger.info("입력한 NN : {}", nickName);
		logger.info("입력한 GR : {}", grade);
		logger.info("입력한 RD : {}", dt);		
		
		mem.setGrade('C'); // 일반회원C 매니저M
		mem.setRegDate(String.valueOf(dt));
		
		daoMem.insertUser(mem); // 이거 하기전에 단건조회를 먼저 해줘야됨.

	}
	
	// 회원 수정
	@Override
	@Transactional
	public void updateUser(MemberDTO mem) throws BizException {		
		String 			id 		  = mem.getId();
		
		if(daoMem.getUser(id) == null) { // Biz예외처리
			throw new BizException("존재하지 않는 아이디입니다.");
		}		
		daoMem.update(mem);
	}	
	
	// 회원탈퇴
	@Override
	@Transactional
	public void deleteUser(String id) throws BizException {
		
		if(daoMem.getUser(id) == null) { // Biz예외처리
			throw new BizException("존재하지 않는 아이디입니다.");
		}		
		daoMem.delete(id);
	}
	
	// 회원 검색
	@Override
	public String getSearchList(String setBoardType, BoardSearchDTO searchDTO, Model model) { // 검색후에 1페이지로 보내기 때문에 페이지 필요없음

		final int END_PAGE_NO = 10; // 페이지당 최대글 수
		int nPageNo;
		PageDTO pageDto = new PageDTO();
		
		if("I".equals(searchDTO.getType())) {
			searchDTO.setSearchType("M_ID");
		} else if("N".equals(searchDTO.getType())) {
			searchDTO.setSearchType("M_NICK");
		} else if("G".equals(searchDTO.getType())) {
			searchDTO.setSearchType("M_GRADE");
		}
		
		if(searchDTO.getPage() == null) {
			nPageNo = 1;
		} else {
			nPageNo = Integer.parseInt(searchDTO.getPage());
		}		
		
		searchDTO.setStartPage((nPageNo-1)*END_PAGE_NO + 1);
		searchDTO.setEndPage(END_PAGE_NO + 1);
		searchDTO.setBoardType(setBoardType);
		
		int total = qebcMem.getSearchCount(searchDTO);//게시글 숫자
		int pageCount = qebcMem.getSearchPageCount(searchDTO); // 페이지 카운트
		ArrayList<MemberDTO> list = qebcMem.getSearch(searchDTO);

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
		
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("page", nPageNo);
		model.addAttribute("pageDTO", pageDto);
		model.addAttribute("MEM_LIST", list);
		model.addAttribute("BOARD_TYPE", boardType);
		
		model.addAttribute("searchDTO", searchDTO);
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
		
		return "memberList";
	}
	
	// 회원 리스트페이징
	@Override
	public String getBoardList(String setBoardType, String strPageNo, Model model) {
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
		pageDto.setBoardType(setBoardType);
		
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("pageDTO", pageDto);
		hm.put("boardType", setBoardType);
		
		ArrayList<MemberDTO> list = qebcMem.getList(hm);
		
		if(list.size() > END_PAGE_NO) {
			list.remove(END_PAGE_NO);
		}
		
		logger.info("getList called ==============");
		
		int total = qebcMem.getMemberCount(); //게시글 숫자
		int pageCount = qebcMem.getPagingCount(); // 페이지 카운트
		
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

		model.addAttribute("pageCount", pageCount);
		model.addAttribute("page", nPageNo);
		model.addAttribute("pageDTO", pageDto);
		model.addAttribute("MEM_LIST", list);
		model.addAttribute("BOARD_TYPE", setBoardType);
		
		// 검색삭제
		model.addAttribute("searchDTO", null);
		model.addAttribute("type", null);
		model.addAttribute("keyword", null);
		
		return "memberList";
	}
}
