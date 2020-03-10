drop SEQUENCE seq_qnaboard;

DROP TABLE qna_board cascade constraints;

create sequence seq_qnaboard;

-- bno, title, content, writer, regdate, updateDate
CREATE TABLE qna_board(
	bno			number(10,0),
	title		varchar2(200) not null,
	content		varchar2(2000) not null,
	writer		varchar2(50) not null,
	regdate		date	default sysdate,
	updateDate	date	default sysdate
);

alter table qna_board add constraint pk_qna_board
primary key(bno);

insert into qna_board (bno, title, content, writer)
values (seq_qnaboard.nextval, '텍스트 제목', '텍스트 내용', 'user00'); --nextval로 매번 새로운 번호를 얻는다.
--더미 데이터 생성 5번 반복

