package com.jey.webapp.account.repository;

import java.util.List;
import java.util.Map;

import com.jey.webapp.account.dto.AccountAddressDTO;
import com.jey.webapp.account.dto.AccountDTO;


public interface AccountRepository {
	public AccountDTO select(AccountDTO dto) throws Exception;
	public List<AccountDTO> selectList() throws Exception;
	public int usedEmail(String email);
	public boolean insert(AccountDTO dto) throws Exception;
	public AccountDTO login(AccountDTO dto) throws Exception;
	public boolean update(AccountDTO dto) throws Exception;
	public boolean delete(AccountDTO dto) throws Exception;
	public boolean updateImage(AccountDTO dto) throws Exception;
	public boolean insertAddress(Map m) throws Exception;
	public boolean deleteAddress(AccountAddressDTO ad_dto) throws Exception;
	public List<AccountAddressDTO> getListAddress(int aid) throws Exception;
	public boolean deletenewAddress(AccountAddressDTO dto) throws Exception;
}
