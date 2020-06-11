package com.itjob.demo.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.itjob.demo.form.TantousyaForm;
import com.itjob.demo.service.TantousyaService;

@Controller
public class LoginController {
	@Resource
	private TantousyaService tantousyaService;

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(@ModelAttribute("form") TantousyaForm userForm, Model model) {
		return ("login");
	}

	@PostMapping("/auth")
	public ModelAndView auth(@ModelAttribute("form") @Valid TantousyaForm tantousyaForm, BindingResult result,
			ModelAndView mv, HttpSession session) {
		if (result.hasErrors()) {
			List<ObjectError> errorList = result.getAllErrors();
			mv.addObject("errorList", errorList);
			mv.setViewName("login");
			return mv;
		}
		List<String> errorList = tantousyaService.getLoginUser(tantousyaForm);
		if (!(errorList.size() == 0)) {
			mv.addObject("message", errorList.get(0));
			mv.setViewName("login");
			return mv;
		} else {
			session.setAttribute("tantousyaCode", tantousyaForm.getTantousyaCode());
			// session.setSessionTimeout=30;
			mv.setViewName("index");
			session.setMaxInactiveInterval(5 * 60);
			return mv;
		}
	}
}
