package com.moody.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class PageDTO {
	
	private int startPage;
	private int endPage;
	private boolean prev,next;
	
	private char bType; // 공지 = noticeBoard, 공지검색 = noticeSearch
	private String boardType;
	
	private int total;
/*	private Criteria cri;
	
	public PageDTO() {}
	
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int)(Math.ceil(cri.getPageNum() / 10.0)) * 10;
		this.startPage = endPage - 9;
		
		int realEnd = (int)(Math.ceil((total * 1.0) / cri.getAmount()));
		
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}*/
}
