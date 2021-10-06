package com.moody.dao;

import com.moody.dto.ReplyDTO;

public interface IReplyDAO {
	void insert(ReplyDTO replyDTO);
	ReplyDTO read(int rno);
	void update(ReplyDTO replyDTO);
	void delete(int rno);
	
}
