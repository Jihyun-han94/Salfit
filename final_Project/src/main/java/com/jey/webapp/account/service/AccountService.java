package com.jey.webapp.account.service;

import java.util.List;

import com.jey.webapp.account.dto.AccountAddressDTO;
import com.jey.webapp.account.dto.AccountDTO;


public interface AccountService {
// 문제 없으면 삭제해도 됨 - 은지
//	public AccountDTO accountDetail(AccountDTO dto) throws Exception;
//	public List<AccountDTO> accountList() throws Exception;
	public boolean checkEmail(String nickname);
	public boolean join(AccountDTO dto) throws Exception;
	public AccountDTO login(AccountDTO dto) throws Exception;
	public boolean updateProfile(AccountDTO dto) throws Exception;
	public boolean signout(AccountDTO dto) throws Exception;
	public boolean saveImage(AccountDTO dto) throws Exception;
	public boolean addAddress(int aid, String address) throws Exception;
	public boolean removeAddress(AccountAddressDTO ad_dto) throws Exception;
	public List<AccountAddressDTO> getList(int aid) throws Exception;
	public boolean deleteAddress(AccountAddressDTO dto) throws Exception;
	public boolean deletenewAddress(AccountAddressDTO dto) throws Exception;
}
