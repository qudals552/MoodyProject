package com.moody.service;

import org.springframework.ui.Model;

import com.moody.dto.ReplyDTO;
import com.moody.exception.BizException;

public interface IReplyService {
	// 댓글 단건조회
	public String getReplyRead(int rno);
	
	// 댓글 리스트
	public void getReplyList(int bNo, Model model);

	// 댓글 리스트 삭제
	public void deleteReplyList(int bNo) throws BizException;

	// 댓글 작성
	public void insertReply(ReplyDTO replyDTO) throws BizException;

	// 댓글 수정
	public void updateReply(ReplyDTO replyDTO) throws BizException;

	// 댓글 삭제
	public void deleteReply(int rno) throws BizException;

}