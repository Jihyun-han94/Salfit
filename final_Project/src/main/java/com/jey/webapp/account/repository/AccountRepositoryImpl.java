package com.jey.webapp.account.repository;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.jey.webapp.account.dto.AccountAddressDTO;
import com.jey.webapp.account.dto.AccountDTO;

@Repository
public class AccountRepositoryImpl implements AccountRepository {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public AccountDTO select(AccountDTO dto) throws Exception {
		return sqlSession.selectOne("accountMapper.selectAccount", dto);
	}

	@Override
	public List<AccountDTO> selectList() throws Exception {
		return sqlSession.selectList("accountMapper.selectAll");
	}
	
	@Override
	public boolean insert(AccountDTO dto) {
		boolean res = false;
		int rs = sqlSession.insert("accountMapper.insertAccount", dto);
		if(rs == 1) {
			res = true;
		}
		return res;
	}

	@Override
	public AccountDTO login(AccountDTO dto) {
		dto = sqlSession.selectOne("accountMapper.checkLogin", dto);
		
		if(dto != null) {
			sqlSession.update("accountMapper.loginDate", dto.getId());
		}
		return dto;
	}
	
	@Override
	public int usedEmail(String email) {
		return sqlSession.selectOne("accountMapper.checkEmail", email);
	}

	@Override
	public boolean update(AccountDTO dto) throws Exception {
		boolean res = false;
		int rs = sqlSession.update("accountMapper.updateAccount", dto);
		if(rs == 1) {
			res = true;
		}
		return res;
	}

	@Override
	public boolean delete(AccountDTO dto) throws Exception {
		boolean res = false;
		int rs = sqlSession.delete("accountMapper.expireAccount", dto);
		if(rs == 1) {
			res = true;
		}
		return res;
	}

	@Override
	public boolean updateImage(AccountDTO dto) throws Exception {
		boolean res = false;
		int rs = sqlSession.update("accountMapper.saveImageAccount", dto);
		if(rs == 1) {
			res = true;
		}
		return res;
	}

	@Override
	public boolean insertAddress(AccountAddressDTO ad_dto) throws Exception {
		boolean res = false;
		int rs = sqlSession.insert("accountMapper.insertAddress", ad_dto);
		if(rs == 1) {
			res = true;
		}
		return res;
	}

	@Override
	public boolean deleteAddress(AccountAddressDTO ad_dto) throws Exception {
		boolean res = false;
		int rs = sqlSession.insert("accountMapper.deleteAddress", ad_dto);
		if(rs == 1) {
			res = true;
		}
		return res;
	}

	@Override
	public List<AccountAddressDTO> getListAddress(int aid) throws Exception {
		System.out.println(sqlSession.selectList("accountMapper.selectAddress", aid));
		return sqlSession.selectList("accountMapper.selectAddress", aid);
	}

}
