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

import com.moody.dto.MemberDTO;
import com.moody.service.IMemberService;

@RestController
public class MemberResponseController {
	@Autowired
	private IMemberService memService;
	
	private static final Logger logger = LoggerFactory.getLogger(MemberResponseController.class);
	
	// 아이디 중복검사 ajax
	@RequestMapping(value="IdChkCtrl.do", produces = "application/text;charset=UTF-8", method=RequestMethod.GET)
	public @ResponseBody String idChk(@ModelAttribute("id") String id) {
		logger.info("idChk called ============");
		
		String jsonOut = memService.idChk(id);
		System.out.println("====" + jsonOut);
		return jsonOut;
	}
	
	// 닉네임 중복검사 ajax
	@RequestMapping(value="NickChkCtrl.do", produces = "application/text;charset=UTF-8", method=RequestMethod.GET)
	public @ResponseBody String nickChk(@ModelAttribute("nickName") String nickName) {
		System.out.println("닉네임" + nickName);
		
		logger.info("nickChk called ============");
		
		String jsonOut = memService.nickChk(nickName);
		System.out.println("====" + jsonOut);
		return jsonOut;
	}
	
	// 비밀번호 중복검사 ajax
	@RequestMapping(value="PassChkCtrl.do", produces = "application/text;charset=UTF-8", method=RequestMethod.GET)
	public @ResponseBody String PassChk(@ModelAttribute("password") String password, HttpSession session) {
		logger.info("PassChk called ============");
		
		MemberDTO getUser = (MemberDTO) session.getAttribute("user");
		String jsonOut = memService.passChk(getUser, password);
		System.out.println("====" + jsonOut);
		return jsonOut;
	}
}
