CREATE SEQUENCE ordered_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE TABLE ordered(
        id NUMBER,
        aid NUMBER,
        reciever NVARCHAR2(64),
        address DATE DEFAULT SYSDATE,
        paytype NVARCHAR2(64),
        total NUMBER,
        pdate DATE DEFAULT SYSDATE
);


ALTER TABLE ordered ADD CONSTRAINT ordered_id_PK PRIMARY KEY(id);
ALTER TABLE ordered ADD CONSTRAINT ordered_aid_FK FOREIGN KEY(aid) REFERENCES account(id) ON DELETE CASCADE;
ALTER TABLE ordered MODIFY reciever CONSTRAINT ordered_reciever_NN NOT NULL;
ALTER TABLE ordered MODIFY address CONSTRAINT ordered_address_NN NOT NULL;
ALTER TABLE ordered MODIFY paytype CONSTRAINT ordered_paytype_NN NOT NULL;
ALTER TABLE ordered MODIFY total CONSTRAINT ordered_total_NN NOT NULL;

COMMENT ON COLUMN ordered.id IS '주문번호  번호';
COMMENT ON COLUMN ordered.aid IS '주문자 식별 번호';
COMMENT ON COLUMN ordered.reciever IS '수령인';
COMMENT ON COLUMN ordered.address IS '배송지';
COMMENT ON COLUMN ordered.paytype IS '결제 방법';
COMMENT ON COLUMN ordered.total IS '총 결제 금액';
COMMENT ON COLUMN ordered.pdate IS '결제 일시';

CREATE SEQUENCE order_detail_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE TABLE order_detail(
        id NUMBER,
        oid NUMBER,
        pid NUMBER,
        qty NUMBER,
        price NUMBER,
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

INSERT INTO review VALUES(1, 21, 1, '너무너무맛있는 샐러드~~~~~', 5, SYSDATE);
INSERT INTO review VALUES(2, 21, 1, '맛있는 샐러드~~dddddddd~~~', 4, SYSDATE);
INSERT INTO review VALUES(3, 21, 1, ' 샐러드~~dddddddd~~~', 3, SYSDATE);
INSERT INTO review VALUES(4, 21, 1, ' ~~dddddddd~~~', 2, SYSDATE);
INSERT INTO review VALUES(10, 21, 1, ' dddddddd~~~', 2, SYSDATE);