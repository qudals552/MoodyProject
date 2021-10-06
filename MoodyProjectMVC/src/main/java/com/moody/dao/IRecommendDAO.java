package com.moody.dao;

import java.util.HashMap;

public interface IRecommendDAO {
	// 추천 중복확인 단건조회
	public String getRecommend(HashMap<String, Object> hm);
	// 추천수 +1
	public void recommend(HashMap<String, Object> hm);
	// 추천이력 추가
	public void insertRecommendHist(HashMap<String, Object> hm);
	// 추천이력 삭제
	public void deleteRecommendHist(int bNo);
}
