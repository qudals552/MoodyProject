package com.moody.exception;

public class BizException extends Exception {	
	private static final long serialVersionUID = 1L;

	public BizException() {}
	
	public BizException(String msg) {
		super(msg);
	}
}
