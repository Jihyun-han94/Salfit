DROP SEQUENCE account_seq;
DROP TABLE account;
DROP SEQUENCE address_seq;
DROP TABLE deliver_address;

CREATE SEQUENCE account_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE TABLE account(
        id NUMBER,
        email NVARCHAR2(128),
        password NVARCHAR2(64),
        name NVARCHAR2(64),
        phone NVARCHAR2(64),
        atype NVARCHAR2(64) DEFAULT 'i',
        joindate DATE DEFAULT SYSDATE,
        logindate DATE DEFAULT SYSDATE,
        expiredate DATE DEFAULT NULL
);

ALTER TABLE account ADD CONSTRAINT account_id_PK PRIMARY KEY(id);
ALTER TABLE account MODIFY email CONSTRAINT account_email_NN NOT NULL;
ALTER TABLE account MODIFY password CONSTRAINT account_password_NN NOT NULL;
ALTER TABLE account MODIFY name CONSTRAINT account_name_NN NOT NULL;
ALTER TABLE account MODIFY phone CONSTRAINT account_phone_NN NOT NULL;
ALTER TABLE account ADD CONSTRAINT account_atype_CK CHECK(atype IN('a', 'i'));

COMMENT ON COLUMN account.id IS '사용자 계정 식별 번호';
COMMENT ON COLUMN account.email IS '사용자 이메일 주소(로그인 아이디로 사용)';
COMMENT ON COLUMN account.password IS '사용자 로그인 비밀번호';
COMMENT ON COLUMN account.name IS '사용자 이름';
COMMENT ON COLUMN account.phone IS '사용자 핸드폰 번호';
COMMENT ON COLUMN account.atype IS '사용자 구분(관리자"a"/일반회원"i")';
COMMENT ON COLUMN account.joindate IS '사용자 가입일';
COMMENT ON COLUMN account.logindate IS '사용자 접속일';
COMMENT ON COLUMN account.expiredate IS '사용자 탈회일';


CREATE SEQUENCE address_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE TABLE deliver_address(
		id NUMBER,
        aid NUMBER,
        address NVARCHAR2(1024)
);


ALTER TABLE deliver_address ADD CONSTRAINT deliver_address_id_PK PRIMARY KEY(id);
ALTER TABLE deliver_address ADD CONSTRAINT deliver_address_aid_FK FOREIGN KEY(aid) REFERENCES account(id) ON DELETE CASCADE;

COMMENT ON COLUMN deliver_address.id IS '배송지 식별 번호';
COMMENT ON COLUMN deliver_address.aid IS '사용자 식별 번호';
COMMENT ON COLUMN deliver_address.address IS '배송지';

INSERT INTO deliver_address VALUES(address_seq.NEXTVAL, 8, '서울시 동작구 신대방동 78-2');
INSERT INTO deliver_address VALUES(address_seq.NEXTVAL, 8, '서울시 강남구 논현동 102-3');

ALTER TABLE account ADD (profile_img VARCHAR2(1024));
COMMENT ON COLUMN account.profile_img IS '사용자 프로필 이미지';

------------------------------------------------------TEST--------------------------------------
SELECT * FROM account;

SELECT * FROM DELIVER_ADDRESS;

ALTER TABLE account RENAME COLUMN type TO atype;

INSERT INTO account VALUES(1, 'admin@admin.com', 'admin', '관리자', 01012345678, 'a', SYSDATE, SYSDATE, NULL, NULL);

		SELECT a.email
			 , a.name
			 , b.aid
			 , b.id AS ano
			 , b.address
		FROM deliver_address b
		JOIN account a
		  ON a.id = b.aid
		WHERE a.id = 8;