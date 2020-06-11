package com.itjob.demo.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.itjob.demo.bean.Shiiresaki;
import com.itjob.demo.bean.Shouhin;
import com.itjob.demo.mapper.ShouhinMapper;

@Service("shouhinService")
public class ShouhinService {
	@Resource
	private ShouhinMapper shouhinMapper;

	public List<Shiiresaki> selectShiiresakimei() {
		return shouhinMapper.selectShiiresakimei();
	}

	public List<Shouhin> selectHachuuShouhins(String shiiresakiCode) {
		return shouhinMapper.selectHachuuShouhins(shiiresakiCode);
	}
}