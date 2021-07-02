package com.jey.webapp.email.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class EmailRepositoryImpl implements EmailRepository {

	@Autowired SqlSession sqlSession;
}
