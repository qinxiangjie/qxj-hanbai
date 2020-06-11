package com.itjob.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class IndexController {
	@RequestMapping(value = "index", method = RequestMethod.GET)
	public String index() {
		return ("index");
	}
	@RequestMapping(value = "PR30101", method = RequestMethod.GET)
	public String PR30101() {
		return ("PR30101");
	}
}
