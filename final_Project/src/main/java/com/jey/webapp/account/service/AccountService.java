package com.jey.webapp.account.service;

import java.util.List;

import com.jey.webapp.account.dto.AccountDTO;


public interface AccountService {
	public AccountDTO accountDetail(AccountDTO dto) throws Exception;
	public List<AccountDTO> accountList() throws Exception;
	public boolean checkEmail(String nickname);
	public boolean join(AccountDTO dto) throws Exception;
	public AccountDTO login(AccountDTO dto) throws Exception;
	public boolean updateProfile(AccountDTO dto) throws Exception;
	public boolean signout(AccountDTO dto) throws Exception;
	public boolean saveImage(AccountDTO dto) throws Exception;
}
