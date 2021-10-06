package com.moody.controller;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import com.moody.exception.BizException;

import lombok.extern.slf4j.Slf4j;

@ControllerAdvice
@Slf4j
public class ExceptionController {
	// 404에러
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String NoHandlerFoundException(final NoHandlerFoundException ex) {
		log.info(ex.getClass().getName());
		log.error(ex.getMessage());
		return "error/error404";
	}
	
	// 500에러
	@ExceptionHandler(Exception.class)
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
	public String handlerAll(final Exception ex) {
		log.info(ex.getClass().getName());
		log.error(ex.getMessage());
		return "error/error500";
	}
	
	// 비지니스 로직 에러
	@ExceptionHandler(BizException.class)
	public String BizException(final BizException ex, Model model) {
		log.info(ex.getClass().getName());
        log.error(ex.getMessage());
        model.addAttribute("ERR", ex.getMessage());
		return "error/bizError";
	}
}
