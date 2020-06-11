package com.itjob.demo.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itjob.demo.bean.Tantousya;

@Mapper
public interface TantousyaMapper {
	public Tantousya selectTantousya(String tantousyaCode);
}
