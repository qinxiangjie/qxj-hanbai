package com.itjob.demo.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import javax.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import com.itjob.demo.bean.Tantousya;
import com.itjob.demo.form.TantousyaForm;
import com.itjob.demo.mapper.TantousyaMapper;

@Service("tantousyaService")
public class TantousyaService {
	@Resource
	private TantousyaMapper tantousyaMapper;
	@Autowired
	private MessageSource messageSource;
	private Locale locale = Locale.getDefault();

	public List<String> getLoginUser(TantousyaForm userForm) {
		Tantousya tantousya = tantousyaMapper.selectTantousya(userForm.getTantousyaCode());
		List<String> errorList = new ArrayList<String>();
		if (tantousya == null) {
			errorList.add(messageSource.getMessage("login.message.tantousyaCode.error", null, locale));
		} else if (!tantousya.getPassword().equals(userForm.getPassword())) {
			errorList.add(messageSource.getMessage("login.message.password.error", null, locale));
		}
		return errorList;
	}
}
