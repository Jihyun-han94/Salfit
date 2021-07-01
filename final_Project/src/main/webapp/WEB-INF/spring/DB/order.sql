DROP TABLE order_detail;
DROP SEQUENCE ordered_seq;
DROP TABLE ordered;
DROP SEQUENCE order_detail_seq;

CREATE SEQUENCE ordered_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE TABLE ordered(
        id NUMBER,
        aid NUMBER,
        receiver NVARCHAR2(64),
        address NVARCHAR2(256),
        paytype NVARCHAR2(64),
        total NUMBER,
        pdate NVARCHAR2(256) DEFAULT to_char(sysdate,'yyyy-mm-dd'),
        ddate NVARCHAR2(256),
        edate NVARCHAR2(256),
        status NVARCHAR2(32) DEFAULT 'paid'
);


ALTER TABLE ordered ADD CONSTRAINT ordered_id_PK PRIMARY KEY(id);
ALTER TABLE ordered ADD CONSTRAINT ordered_aid_FK FOREIGN KEY(aid) REFERENCES account(id) ON DELETE CASCADE;
ALTER TABLE ordered MODIFY receiver CONSTRAINT ordered_receiver_NN NOT NULL;
ALTER TABLE ordered MODIFY address CONSTRAINT ordered_address_NN NOT NULL;
ALTER TABLE ordered MODIFY paytype CONSTRAINT ordered_paytype_NN NOT NULL;
ALTER TABLE ordered MODIFY total CONSTRAINT ordered_total_NN NOT NULL;
ALTER TABLE ordered ADD CONSTRAINT ordered_status_CK CHECK(status IN('paid', 'checked', 'shipping', 'delivered'));

COMMENT ON COLUMN ordered.id IS '주문번호  번호';
COMMENT ON COLUMN ordered.aid IS '주문자 식별 번호';
COMMENT ON COLUMN ordered.receiver IS '수령인';
COMMENT ON COLUMN ordered.address IS '배송지';
COMMENT ON COLUMN ordered.paytype IS '결제 방법';
COMMENT ON COLUMN ordered.total IS '총 결제 금액';
COMMENT ON COLUMN ordered.pdate IS '결제 일시';
COMMENT ON COLUMN ordered.ddate IS '배송 시작일';
COMMENT ON COLUMN ordered.edate IS '배송 완료일';
COMMENT ON COLUMN ordered.status IS '주문 상태 (결제완료, 주문확인, 배송중, 배송완료)';

CREATE SEQUENCE order_detail_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE TABLE order_detail(
        id NUMBER,
        oid NUMBER,
        pid NUMBER,
        qty NUMBER,
        price NUMBER,
        startdate NVARCHAR2(256),
        enddate NVARCHAR2(256),
        days NUMBER,
        status NVARCHAR2(32) DEFAULT 'paid'
);

ALTER TABLE order_detail ADD CONSTRAINT order_detail_id_PK PRIMARY KEY(id);
ALTER TABLE order_detail ADD CONSTRAINT order_detail_oid_FK FOREIGN KEY(oid) REFERENCES ordered(id);
ALTER TABLE order_detail ADD CONSTRAINT order_detail_pid_FK FOREIGN KEY(pid) REFERENCES product(id);
ALTER TABLE order_detail MODIFY qty CONSTRAINT order_detail_qty_NN NOT NULL;
ALTER TABLE order_detail MODIFY price CONSTRAINT order_detail_price_NN NOT NULL;
ALTER TABLE order_detail ADD CONSTRAINT order_detail_status_CK CHECK(status IN('paid', 'shipping', 'delived', 'holding', 'canceled'));

COMMENT ON COLUMN order_detail.id IS '구매목록 구분 식별 번호';
COMMENT ON COLUMN order_detail.oid IS '주문 번호';
COMMENT ON COLUMN order_detail.pid IS '구매 상품 식별 번호';
COMMENT ON COLUMN order_detail.qty IS '주문 상품 갯수';
COMMENT ON COLUMN order_detail.price IS '상품 가격';
COMMENT ON COLUMN order_detail.startdate IS '상품 구독 시작일';
COMMENT ON COLUMN order_detail.enddate IS '상품 구독 종료일';
COMMENT ON COLUMN order_detail.days IS '상품 구독 기간(일자)';
COMMENT ON COLUMN order_detail.status IS '주문 상태 (결제완료, 배송중, 배송완료, 취소요청, 취소완료)';


CREATE SEQUENCE review_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE TABLE review(
        id NUMBER,
        pid NUMBER,
        aid NUMBER,
        contents NVARCHAR2(1024),
        rating NUMBER DEFAULT 0,
        cdate DATE DEFAULT SYSDATE
);
DROP table review;

ALTER TABLE review ADD CONSTRAINT review_id_PK PRIMARY KEY(id);
ALTER TABLE review ADD CONSTRAINT review_pid_FK FOREIGN KEY(pid) REFERENCES product(id) ON DELETE CASCADE;
ALTER TABLE review ADD CONSTRAINT review_aid_FK FOREIGN KEY(aid) REFERENCES account(id) ON DELETE SET NULL;
ALTER TABLE review MODIFY contents CONSTRAINT review_contents_NN NOT NULL;
ALTER TABLE review MODIFY rating CONSTRAINT review_rating_NN NOT NULL;

COMMENT ON COLUMN review.id IS '리뷰 식별 번호';
COMMENT ON COLUMN review.pid IS '리뷰 단 게시글 식별 번호';
COMMENT ON COLUMN review.aid IS '리뷰 작성자 식별 번호';
COMMENT ON COLUMN review.contents IS '리뷰 내용';
COMMENT ON COLUMN review.rating IS '상품 별점';
COMMENT ON COLUMN review.cdate IS '리뷰 작성일';



--------------------------------------------------------------------------------------------------------
SELECT * FROM ordered;

DELETE FROM ordered WHERE id = 2;

INSERT INTO ordered VALUES(1, 2, '최예림', '광교호수로 152번길', '카드', 13000, SYSDATE, SYSDATE+1, 'paid');
INSERT INTO ordered VALUES(20, 1, '김은순', '광교호수로 153번길', '카카오페이', 119000, to_char(sysdate-1,'yyyy-mm-dd'), to_char(sysdate+1,'yyyy-mm-dd'), 'paid');
INSERT INTO ordered(id, aid, receiver, address, paytype, total) VALUES(1, 1, '김은순', '광교호수로 153번길', '카카오페이', 119000);
INSERT INTO ordered(id, aid, receiver, address, paytype, total) VALUES(2, 2, '최예림', '광교호수로 152번길', '카드', 13000);

INSERT INTO review VALUES(1, 21, 1, '너무너무맛있는 샐러드~~~~~', 5, SYSDATE);
INSERT INTO review VALUES(2, 21, 1, '맛있는 샐러드~~dddddddd~~~', 4, SYSDATE);
INSERT INTO review VALUES(3, 21, 1, ' 샐러드~~dddddddd~~~', 3, SYSDATE);
INSERT INTO review VALUES(4, 21, 1, ' ~~dddddddd~~~', 2, SYSDATE);
INSERT INTO review VALUES(10, 21, 1, ' dddddddd~~~', 2, SYSDATE);



ALTER TABLE ordered DROP CONSTRAINT ordered_status_CK;

SELECT *
	  FROM (SELECT ROW_NUMBER() OVER (ORDER BY pdate) NUM
	         , o.*
	          FROM ordered o
	         ORDER BY pdate
	        ) 
	 WHERE NUM BETWEEN 11 AND 20;
	 
SELECT count(id)
		FROM ordered
		WHERE id > 0;