drop table qna_attach cascade constraints;

CREATE TABLE qna_attach (
    uuid VARCHAR2(100) not null,
    uploadPath VARCHAR2(200) not null,
    fileName VARCHAR2(100) not null,
    fileType char(1) DEFAULT 'I',
    bno number(10,0)
);
--첨부파일 보관은 uuid가 포함된 이름을 pk로 하는 uuid칼럼과 실제 파일이 업로드 된 경로를 의미하는 uploadPath,
--파일 이름을 의미하는 fileName, 이미지 파일 여부를 판단하는 fileType, 해당 게시물 번호를 확인하는 bno 칼럼을 이용한다.

ALTER TABLE qna_attach add CONSTRAINT pk_attach PRIMARY KEY (uuid);
--테이블을 생성할 때 PK를 정의한다.
--PK는 각 행을고유하게 식별하는 역할을 담당한다.
--테이블당 하나만 정의 가능하다.
--지정된 컬럼에는 중복된 값이나 NULL값이 입력될 수 없다.
--NOT NULL + UNIQUE(UK)를 한 것과 같은 기능을 한다.
--PK로 지정 가능한 컬럼이 여러 개 있을 때는 검색에 많이 사용되고 간단하고 짧은 컬럼을 지정한다.
--주 식별자, 주키 등으로 불린다.
--고유 인덱스(Unique index)가 자동으로 생성된다.


ALTER TABLE qna_attach add CONSTRAINT fk_board_attach FOREIGN key (bno)
REFERENCES qna_board(bno);
/*
테이블을 생성할 때 FK를 정의한다.
FK가 정의된 테이블이 자식 테이블이다.
참조되는 테이블을 부모 테이블이라고 한다.
부모 테이블은 미리 생성되어 있어야 한다.
부모 테이블의 참조되는 컬럼에 존재하는 값만을 입력 할 수 있다.
부모 테이블은 FK로 인해 삭제가 불가능하다.
REFERENCES : 참조할 부모 테이블과 부모 테이블에 있는 컬럼을 정의한다.
ON DELETE CASCADE : 참조되는 부모 테이블의 행에 대한 DELETE를 허용한다.
부모 테이블의 행이 지워지면 자식 테이블의 행도 같이 지워진다.
ON DELETE SET NULL : 참조되는 부모 테이블의 행에 대한 DELETE를 허요한다.
부모 테이블의 행이 지워지면 자식 테이블의 행은 NULL 값으로 설정된다.
데이터 타입이 반드시 일치해야 한다.
참조되는 컬럼은 PK이거나 UK(Unique key)만 가능하다.
외부키, 참조키, 외부 식별자 등으로 불린다.
*/
 

