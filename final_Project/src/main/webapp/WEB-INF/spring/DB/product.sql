CREATE TABLE product_type(
        id NUMBER,
        name NVARCHAR2(256)
);

ALTER TABLE product_type ADD CONSTRAINT product_type_id_PK PRIMARY KEY(id);
ALTER TABLE product_type MODIFY name CONSTRAINT product_type_name_NN NOT NULL;

COMMENT ON COLUMN product_type.id IS '상품 카테고리 구분 식별 번호';
COMMENT ON COLUMN product_type.name IS '상품 카테고리 (이름)';




CREATE SEQUENCE product_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE TABLE product(
        id NUMBER,
        ptype NUMBER,
        aid NUMBER,
        title NVARCHAR2(256),
        price NUMBER,
        contents NCLOB,
        vcnt NUMBER DEFAULT 0,
        gcnt NUMBER DEFAULT 0,
        bcnt NUMBER DEFAULT 0,
        cdate DATE DEFAULT SYSDATE,
        udate DATE DEFAULT SYSDATE,
        active CHAR(1) DEFAULT 'y'
);



ALTER TABLE product ADD CONSTRAINT product_id_PK PRIMARY KEY(id);
ALTER TABLE product ADD CONSTRAINT product_ptype_FK FOREIGN KEY(ptype) REFERENCES product_type(id);
ALTER TABLE product ADD CONSTRAINT product_aid_FK FOREIGN KEY(aid) REFERENCES account(id);
ALTER TABLE product MODIFY title CONSTRAINT product_title_NN NOT NULL;
ALTER TABLE product MODIFY price CONSTRAINT product_price_NN NOT NULL;
ALTER TABLE product ADD CONSTRAINT product_active_CK CHECK(active IN('n', 'y'));

COMMENT ON COLUMN product.id IS '상품 고유 번호';
COMMENT ON COLUMN product.ptype IS '상품 종류 식별 번호';
COMMENT ON COLUMN product.aid IS '상품 작성자(관리자) 식별 번호';
COMMENT ON COLUMN product.title IS '상품 제목';
COMMENT ON COLUMN product.price IS '상품 가격';
COMMENT ON COLUMN product.contents IS '상품 내용';
COMMENT ON COLUMN product.vcnt IS '상품 게시글 조회수';
COMMENT ON COLUMN product.gcnt IS '상품 좋아요 수';
COMMENT ON COLUMN product.bcnt IS '상품 구매 수';
COMMENT ON COLUMN product.cdate IS '상품 게시글 등록일';
COMMENT ON COLUMN product.udate IS '상품 게시글 수정일';
COMMENT ON COLUMN product.active IS '상품 공개 여부 (y인 경우 공개)';



CREATE SEQUENCE product_img_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE TABLE product_img(
        id NUMBER,
        pid NUMBER,
        name NVARCHAR2(512),
        path NVARCHAR2(1024),
        url NVARCHAR2(1024)
);

ALTER TABLE product_img ADD CONSTRAINT product_img_id_PK PRIMARY KEY(id);
ALTER TABLE product_img ADD CONSTRAINT product_img_pid_FK FOREIGN KEY(pid) REFERENCES product(id) ON DELETE CASCADE;
ALTER TABLE product_img MODIFY name CONSTRAINT product_img_name_NN NOT NULL;
ALTER TABLE product_img MODIFY path CONSTRAINT product_img_path_NN NOT NULL;
ALTER TABLE product_img MODIFY url CONSTRAINT product_img_url_NN NOT NULL;

COMMENT ON COLUMN product_img.id IS '상품 이미지 파일 식별 번호';
COMMENT ON COLUMN product_img.pid IS '상품 이미지 상품 식별 번호';
COMMENT ON COLUMN product_img.name IS '상품 이미지 파일명';
COMMENT ON COLUMN product_img.path IS '상품 이미지 실제 저장 경로(위치)';
COMMENT ON COLUMN product_img.url IS '상품 이미지 접근 URL 주소';


---------------------------------------------------------------------------------------------------------

INSERT INTO product_type VALUES(1, '채식주의자');
INSERT INTO product_type VALUES(2, '육식러버');
INSERT INTO product_type VALUES(3, '다이어터');

SELECT * FROM product ;


INSERT INTO product(id, ptype, aid, title, price, contents) VALUES(1, 1, 1, '체다치즈 샐러드', 3000, '맛있는 체다치즈가 듬뿍~!');
INSERT INTO product(id, ptype, aid, title, price, contents) VALUES(2, 2, 1, '닭가슴살 샐러드', 3500, '다이어트 시 단백질 보충~!');
INSERT INTO product(id, ptype, aid, title, price, contents) VALUES(3, 2, 1, '채끝살 샐러드', 5500, '프리미엄 소고기 샐러드~!');
INSERT INTO product(id, ptype, aid, title, price, contents) VALUES(4, 2, 1, '치킨 샐러드', 4000, '다이어트는 내일부터~!');
INSERT INTO product(id, ptype, aid, title, price, contents) VALUES(5, 1, 1, '기본 샐러드', 2500, '실속있는 샐러드~!');
INSERT INTO product(id, ptype, aid, title, price, contents) VALUES(6, 3, 1, '드레싱', 2000, EMPTY_CLOB());


DELETE FROM product where id = 3;

ALTER TABLE product_img DROP CONSTRAINT product_img_pid_FK;