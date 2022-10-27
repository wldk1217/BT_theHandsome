package com.thehandsome.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.thehandsome.domain.ColorVO;
import com.thehandsome.domain.ProductCriteria;
import com.thehandsome.domain.ProductVO;

/*****************************************************
 * @function : ProductMapper
 * @author : 심지연
 * @Date : 2022.10.21
 ******************************************************/

public interface ProductMapper {

	public ProductVO productGetDetail(String pid); // 상품 상세 정보

	public List<ColorVO> productGetColor(String pid); // 상품 컬러 리스트

	public List<ProductVO> getList(); // 상품리스트

	public List<ProductVO> getListWithPaging(ProductCriteria cri, @Param("clarge") String clarge,
			@Param("cmedium") String cmedium, @Param("csmall") String csmall); // 상품 리스트 페이징

	public int getTotal(@Param("clarge") String clarge, @Param("cmedium") String cmedium,
			@Param("csmall") String csmall); // 페이징 시 필요한 총 상품 개수

	public ProductVO read(String bname); // 상품 조회

	public List<String> getSize(@Param("pid") String pid); // 상품 사이즈 리스트
}