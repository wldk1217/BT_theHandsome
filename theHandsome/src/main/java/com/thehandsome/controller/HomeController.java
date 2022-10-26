package com.thehandsome.controller;

import java.util.Locale;
//�ȳ��ϼ��� test���Դϴ�
// �׽�Ʈ���Գ״�
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/*****************************************************
 * @function : HomeController
 * @author : 구영모, 김민선, 심지연 공동작업
 * @Date : 2022.10.17
 *****************************************************/

@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "home";
	}
}
