package com.itjob.demo.controller;

import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import com.itjob.demo.bean.Shiiresaki;
import com.itjob.demo.bean.Shouhin;
import com.itjob.demo.service.ShouhinService;

@Controller
public class HachuuController {
	@Resource
	private ShouhinService shouhinService;

	@RequestMapping(value = "/toHachuu")
	public ModelAndView toHachuu(ModelAndView mv, HttpSession session) {
		List<Shiiresaki> shiiresakiList = shouhinService.selectShiiresakimei();
		session.setAttribute("shiiresakiList", shiiresakiList);
		mv.setViewName("PR30101");
		return mv;
	}

	@RequestMapping(value = "/search")
	public ModelAndView selectHachuuShouhins(@RequestParam(value = "shiiresakiCode") String shiiresakiCode,
			ModelAndView mv, HttpSession session) {
		List<Shouhin> shouhinList = shouhinService.selectHachuuShouhins(shiiresakiCode);
		mv.addObject("shouhinList", shouhinList);
		session.setAttribute("shouhinList", shouhinList);
		session.setAttribute("shiiresakiCode", shiiresakiCode);
		mv.setViewName("PR30101");
		return mv;
	}
}
