DROP TABLE cart;
DROP SEQUENCE cart_seq;

CREATE SEQUENCE cart_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE TABLE cart(
        id NUMBER,
        aid NUMBER,
        pid NUMBER,
        qty NUMBER,
        startdate NVARCHAR2(256),
        enddate NVARCHAR2(256),
        days NUMBER
);

ALTER TABLE cart ADD CONSTRAINT cart_PK PRIMARY KEY(id, pid);
ALTER TABLE cart ADD CONSTRAINT cart_aid_FK FOREIGN KEY(aid) REFERENCES account(id) ON DELETE CASCADE;
ALTER TABLE cart ADD CONSTRAINT cart_pid_FK FOREIGN KEY(pid) REFERENCES product(id) ON DELETE CASCADE;
ALTER TABLE cart MODIFY qty CONSTRAINT cart_qty_NN NOT NULL;

COMMENT ON COLUMN cart.id IS '장바구니 고유 번호';
COMMENT ON COLUMN cart.aid IS '장바구니 소유주 식별 번호';
COMMENT ON COLUMN cart.pid IS '상품 식별 번호';
COMMENT ON COLUMN cart.qty IS '상품 주문 갯수';
COMMENT ON COLUMN cart.startdate IS '상품 구독 시작일';
COMMENT ON COLUMN cart.enddate IS '상품 구독 종료일';
COMMENT ON COLUMN cart.days IS '상품 구독 기간(일자)';



------------------------------------------------------------------------------------------------------
SELECT * FROM cart;