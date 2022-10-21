package com.thehandsome.mapper;

import java.util.List;

import com.thehandsome.domain.ColorVO;
import com.thehandsome.domain.Criteria;
import com.thehandsome.domain.ProductVO;

public interface ProductMapper {

	public ProductVO productGetDetail(String pid); // 상품 상세 정보

	public List<ColorVO> productGetColor(String pid); // 상품 컬러 리스트

	public ProductVO getList(String bname); // 상품 리스트

	public List<ProductVO> getListWithPaging(Criteria cri, String clarge, String cmedium, String csmall); // 상품 리스트 페이징

	public int getTotal(String clarge, String cmedium, String csmall); // 페이징 시 필요한 총 상품 개수

	public ProductVO read(String bname); // 상품 조회 테스트
}