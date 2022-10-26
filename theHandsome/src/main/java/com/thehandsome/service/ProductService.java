package com.thehandsome.service;

import java.util.List;
import com.thehandsome.domain.ColorVO;
import com.thehandsome.domain.Criteria;
import com.thehandsome.domain.ProductVO;

/*****************************************************
 * @function : ProductService
 * @author : 심지연
 * @Date : 2022.10.19
 *****************************************************/

public interface ProductService {

	// 상품 상세 조회
	public ProductVO productGetDetail(String pid);

	// 상품 색상 조회
	public List<ColorVO> productGetColor(String pid);

	public ProductVO get(String bname);
	
	// 대, 중, 소 분류에 해당하는 상품 리스트 조회
	public List<ProductVO> getList(Criteria cri, String clarge, String cmedium, String csmall);
	
	// 대, 중, 소 분류에 해당하는 상품 총 개수 조회
	public int getTotal(String clarge, String cmedium, String csmall);

	public List<String> getSize(String pid);
}
