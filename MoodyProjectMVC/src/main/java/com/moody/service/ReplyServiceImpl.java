package com.moody.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.moody.dao.IBoardQEBC;
import com.moody.dao.IReplyDAO;
import com.moody.dto.ReplyDTO;
import com.moody.exception.BizException;

@Service
public class ReplyServiceImpl implements IReplyService {
	
	@Autowired
	IReplyDAO daoReply;
	@Autowired
	IBoardQEBC qebcReply;
	
	// 댓글 내용조회
	@Override
	public String getReplyRead(int rno) {
		ReplyDTO dto = daoReply.read(rno);		
		String contents = dto.getContents();
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("contents", contents);
		
		String jsonOut = jsonObj.toString();
		
		return jsonOut;		
	}
	
	// 댓글 리스트
	@Override
	public void getReplyList(int bNo, Model model) {
		ArrayList<ReplyDTO> replyList =  qebcReply.getReplyList(bNo);
		model.addAttribute("REPLY_LIST", replyList);
	}
	
	// 댓글 리스트 삭제
	@Override
	@Transactional
	public void deleteReplyList(int bNo) throws BizException {
		ArrayList<ReplyDTO> reply = qebcReply.getReplyList(bNo);
		
		if(reply == null) {
			throw new BizException("댓글리스트를 삭제할 수 없습니다.");
		}
		
		qebcReply.boardReplyDelete(bNo);
	}
	
	// 댓글 작성
	@Override
	@Transactional
	public void insertReply(ReplyDTO replyDTO) throws BizException {
		SimpleDateFormat dateFormat = new SimpleDateFormat ( "yyyyMMddHHmmss"); 
		Date regDate = new Date();
		String dt = dateFormat.format(regDate);
		
		if(daoReply.read(replyDTO.getRno()) != null) { // 안에 같은 번호가 있으면 오류처리
			throw new BizException("댓글을 작성할 수 없습니다.");
		}
		
		replyDTO.setRegDate(dt);
		replyDTO.setUpdateDate(dt);
		
		daoReply.insert(replyDTO);
	}
	
	// 댓글 수정
	@Override
	@Transactional
	public void updateReply(ReplyDTO replyDTO) throws BizException {
		SimpleDateFormat dateFormat = new SimpleDateFormat ( "yyyyMMddHHmmss"); 
		Date regDate = new Date();
		String dt = dateFormat.format(regDate);
		
		ReplyDTO chkReply = daoReply.read(replyDTO.getRno());
		
		System.out.println("수정체크 : " + chkReply);
		
		if(chkReply == null) { // 에러페이지로 이동
			throw new BizException("댓글을 수정할 수 없습니다.");
		}
		
		// 수정날짜 추가
		replyDTO.setUpdateDate(dt);
		// 업데이트
		daoReply.update(replyDTO);	
	}
	
	// 댓글 삭제
	@Override
	@Transactional
	public void deleteReply(int rno) throws BizException {
		ReplyDTO chkReply = daoReply.read(rno);
		
		if(chkReply == null) { // 에러페이지로 이동
			throw new BizException("댓글을 삭제할 수 없습니다.");
		}
		
		// 삭제
		daoReply.delete(rno);
	}
	
}
