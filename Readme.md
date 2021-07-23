# About Salfit 

- 샐러드 상품의 판매, 결제가 가능한 인터넷 쇼핑몰
- 원하는 날짜에 배송 받을 수 있는 구독 서비스를 제공하여 Booking Web Site 의 특징과 E-Commerse Web Site을 결합
- 관리자 주문, 배송, 판매 관리를 편리하게 도와주는 기능 제공  

## 주요 기능 

- 로그인/ 회원가입
- 회원 정보 관리 
- 상품 게시판
- 상품 리뷰 
- 주문 내역 조회
- 관리자 주문 관리
- 장바구니
- 결제

## 담당 역할

- 최예림 : 총괄, DataBase 관리, 구조 설계, 상품 게시판, 주문관리 
- 김은지 : 전반적인 CSS 작성 및 디자인, 로그인/ 회원가입, 마이페이지 
- 한지현 : 장바구니, 결제, 주문 내역 조회, 상품 리뷰 

## ERD
![ERD](https://user-images.githubusercontent.com/62541678/125650839-48c49fa4-333f-4652-936b-2410e307e79f.png)


## Site Map
![Site_Map](https://user-images.githubusercontent.com/62541678/125650645-60394786-9976-40c8-81ee-cac8e456d8fa.png)

## Use Case
![ERD-Page-1 (1)](https://user-images.githubusercontent.com/62541678/125651237-03f4b3ef-7683-4e77-b4fb-536be1e35488.png)

## Class Diagram
main_cd.gif![main_cd](https://user-images.githubusercontent.com/62541678/125652910-c8c0429e-4f50-4dd0-a121-2a8a5436c1fc.gif)
account_cd.gif![account_cd](https://user-images.githubusercontent.com/62541678/125652918-ceb145b7-de6e-4770-bf35-8ad1c615f486.gif)
order_cd.gif![order_cd](https://user-images.githubusercontent.com/62541678/125652930-547e671d-5502-4fab-9a2e-58c1e99582c8.gif)
admin_cd.gif![admin_cd](https://user-images.githubusercontent.com/62541678/125652944-52d642da-736f-438f-b58a-f6f32431a8d2.gif)

## Develope Environments
- OS : Window10 , Mac OS X
- DB : Oracle 11g
- Language : Java
- Framework : Spring, MyBatis, JDBC
- Software : Bootstrap 4.6.0, VSCode
- WAS : Tomcat 9.0.44
- IDE : Eclipse 2020-12(4.18.0)
- SCM Tool : GIT
- Distribution : Maven

## 구현 기능 
(직접 맡은 구현 기능만 설명)

### 장바구니
![image](https://user-images.githubusercontent.com/77036739/126757514-c568d59c-61db-419a-90e1-4c57e868557d.png)

**화면설명: 제품을 장바구니에 담고, 구매할 상품을 선택하여 주문할 수 있는 페이지.**
- 상품 상세보기에서 Add to cart를 클릭하면 장바구니에 담기 가능 
- 삭제 버튼 클릭시 선택한 제품이 장바구니에서 삭제 가능 
- 모두 선택 박스를 클릭시 장바구니에 담긴 모든 제품이 선택 가능 
- 선택박스를 선택함에 따라 결제 예정 금액이 계산 
- 장바구니에 담긴 제품은 30,000원이상 구매시 배송비 무료로 계산 
- 선택 상품 주문을 클릭하면 주문서 작성 페이지로 이동


### 주문서 작성
![image](https://user-images.githubusercontent.com/77036739/126758239-8739c6b5-e255-481a-bd8f-6a388beb0386.png)

**화면설명: 사용자가 구매할 제품을 목록을 확인하고, 배송정보를 입력하는 페이지**
- 고객이 선택한 주문 내역을 확인 가능 
- 배송 정보에 받으시는 분, 주소를 선택 가능 
- 주소 선택 시 마이페이지의 주소와 연동 되며, 직접 입력하여 작성 가능 
- 결제 버튼을 누르면 KG 이니시스 결제창으로 이동


### 결제
![image](https://user-images.githubusercontent.com/77036739/126758366-8ac011ff-84ab-4899-a2af-ac93c6a8180b.png)

**화면설명: 사용자가 구매한 제품의 비용을 결제하는 페이지.**
- I am port lib를 사용하여 결제 기능 구현, KG 이니시스 결제 대행사를 이용하여 다양한 수단으로 결제가 가능하다. 
- I am port site : https://www.iamport.kr/?gclid=Cj0KCQjw0emHBhC1ARIsAL1QGNcXl5cMbh8aTlZ7vyuIRnqOU8rnpn7jPST7ju029YKCty0DPxNPK_YaAtcUEALw_wcB


### 주문내역 조회 , 주문 상세 조회
![image](https://user-images.githubusercontent.com/77036739/126757747-4bd8b651-cbd5-49fa-a01e-4c5097caefaa.png)
![image](https://user-images.githubusercontent.com/77036739/126757758-42cb4fe6-fdad-4352-9c90-aff5e0e2f016.png)

**화면설명: 사용자의 주문 내역을 확인할 수 있는 페이지.**
- MY page 탭에서 order버튼을 클릭하면 최근날짜별로 나열된 주문내역 확인 가능
- 주문 상태를 확인할 수 있으며, 미결제 주문건은 결제하러가기 버튼을 클릭하면 결제 가능
- 결제 완료된 건은 배송확인 버튼을 클릭하면 배송완료 확정 (단, 주문의 마지막 배송일부터 배송완료 버튼 클릭 가 능) 
- 주문을 완료하였지만, 결제를 완료하지 못한 경우 삭제 요청 버튼을 누르면 주문 삭제 가능 
- 주문과 결제 모두 완료한 경우 취소 요청 버튼을 누르면 주문 취소 가능 (단, 첫 배송시작일 하루 전까지 취소 요청 이 가능) 
- 주문건의 날짜를 클릭하면 주문건에 대한 주문 상세 정보 확인이 가능 (구매한 제품 내역, 주문처리상태, 리뷰작성)


### 리뷰작성
![image](https://user-images.githubusercontent.com/77036739/126758552-a7d5aa1a-ee88-40e0-915c-86bfb371a317.png)

**화면설명: 사용자가 구매한 제품의 리뷰를 작성하는 페이지**
- 주문 상세 정보 확인 페이지에서, 배송완료 된 제품은 리 뷰 작성란의 버튼을 누르면 리뷰 작성이 가능 
- 리뷰 작성에서 별점으로 평점 매기기 가능 
- 리뷰를 작성 버튼을 누르면, 제품 상세페이지로 연결되며 작성된 리뷰 확인 가능 (프로필 사진, 별점 연동)


## 프로젝트를 진행하며 아쉬웠던 점
**기능 구현을 시작할 때 Mockup을 만들지 않았다.**
처음 프로젝트를 진행할 당시, 팀원들끼리 Mockup을 만들고 협의하지않고 무작정 기능 구현을 시작했다. 
Mockup을 만드는게 시간낭비라고 생각하기도 했었고, 일단은 기능 구현에 마음이 급해 바로 기능구현에 들어갔다. 
하지만 기능 구현을 다 마친 후에, 다른 팀원들과 DB가 겹치는 부분이 있었기 때문에 그 후에 많은 수정이 있었고 결과적으로 수정하는데 시간을 많이 허비했다.  
Mockup을 확실히 짜고 팀원들과 서로 자기가 맡은 부분에 대한 공유를 하고 DB를 설계하는 데에 있어서도 많은 의사소통을 했으면 좋았을 것이라고 생각된다.

**오류를 못찾겠으면, 기초적인 걸 다시 살펴보자!**
Javascript에서 document.getElementsByName()에서 s를 빠뜨린 것 때문에 오류나서 시간을 많이 허비했었다. 
내가 도대체 뭘 잘못했지? 다 맞는 거 같은데? 라는 생각이 들때는 기초적인 문법이 틀리지 않았는지 확인해보자!


## 프로젝트 소감
부족함을 많이 느껴 힘들었던 적도 있지만, 그래도 많이 성장한 나에게 칭찬을 해주고싶다! 확실히 spring framework 강의를 들을 때는 와닿지 않았던 것도, 직접 코드를 짜보니 이해가 되었다. 앞으로 프로젝트를 부지런히 많이 해야겠다는 생각을 했다. 조급하게 생각하지 말고, 차근차근 해나가면 못할게 없다! 그리고 팀원들을 보며 나의 부족한 부분을 많이 느끼는 계기가 되었고, 정말 많이 배워 뜻깊고 소중한 시간이였다.





