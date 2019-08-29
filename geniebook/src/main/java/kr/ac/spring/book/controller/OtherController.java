package kr.ac.spring.book.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class OtherController {
	
	@RequestMapping("/404")
	public String error404() {
		
		return "404";
	}
	
}
