package com.moody.dao;

import com.moody.dto.BoardDTO;

public interface IBoardDAO {
	BoardDTO getBoard(int bNo); // 단건조회
	void insert(BoardDTO boardDto);
	void update(BoardDTO boardDto);
	void delete(int bNo);
}
