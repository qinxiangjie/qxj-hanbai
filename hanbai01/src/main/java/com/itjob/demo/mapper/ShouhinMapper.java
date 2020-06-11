package com.itjob.demo.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.itjob.demo.bean.Shiiresaki;
import com.itjob.demo.bean.Shouhin;

@Mapper
public interface ShouhinMapper {
	public List<Shiiresaki> selectShiiresakimei();
	public List<Shouhin> selectHachuuShouhins(String shiiresakiCode);
}
