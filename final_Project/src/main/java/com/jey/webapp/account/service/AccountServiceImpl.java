package com.jey.webapp.account.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jey.webapp.account.dto.AccountDTO;
import com.jey.webapp.account.repository.AccountRepository;

@Service	
public class AccountServiceImpl implements AccountService {

	@Autowired
	AccountRepository dao ;
	
	@Override
	public AccountDTO accountDetail(AccountDTO dto) throws Exception {
		AccountDTO data = dao.select(dto);
		return data;
	}

	@Override
	public List<AccountDTO> accountList() throws Exception {
		return dao.selectList();
	}
	
	@Override
	public boolean join(AccountDTO dto) throws Exception {
		return dao.insert(dto);
	}
	
	@Override
	public AccountDTO login(AccountDTO dto) throws Exception {
		if(dao.login(dto) != null) {
			dto = dao.login(dto);
			dto.setPassword("");
			return dto;
		} else {
			AccountDTO data = new AccountDTO();
			data.setId(-1);
			data.setPassword("");
			return data;
		}
	}
	
	
	@Override
	public boolean checkEmail(String email) {
		boolean res = true;
		int cnt = dao.usedEmail(email);
		if(cnt == 0) {
			res = false;
		}
		return res;
	}

	@Override
	public boolean updateProfile(AccountDTO dto) throws Exception {
		return dao.update(dto);
	}

	@Override
	public boolean signout(AccountDTO dto) throws Exception {
		return dao.delete(dto);
	}

	@Override
	public boolean saveImage(AccountDTO dto) throws Exception {
		return dao.updateImage(dto);
	}


}

