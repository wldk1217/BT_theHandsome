package com.thehandsome.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thehandsome.domain.MemberVO;
import com.thehandsome.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	// 회원가입
	@Override
	public void memberJoin(MemberVO member) throws Exception {
		mapper.memberJoin(member);
	}
	
	// 아이디 중복체크
	@Override
	public int idCheck(String mid) {
        int cnt = mapper.idCheck(mid);
        return cnt;
    }
	
	// 로그인
	@Override
	public MemberVO memberLogin(MemberVO member) throws Exception {
		return mapper.memberLogin(member);
	}
	
	// 회원정보 수정
	@Override
	public int modifyInfo(MemberVO member) throws Exception {
		return mapper.modifyInfo(member);
	}
	
	// 회원 탈퇴
	@Override
	public int memberWithdrawal(MemberVO member) throws Exception {
		return mapper.memberWithdrawal(member);
	}

}// end class
