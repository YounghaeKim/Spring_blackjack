package www.spring.com.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import www.spring.com.board.mapper.BoardAttachMapper;
import www.spring.com.board.mapper.BoardMapper;
import www.spring.com.board.model.BoardAttachVO;
import www.spring.com.board.model.BoardVO;
import www.spring.com.board.model.Criteria;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod=@__({@Autowired}))
	private BoardMapper mapper;

	@Setter(onMethod=@__({@Autowired}))
	private BoardAttachMapper attachMapper;
	
	@Transactional //qna_board 와 qna_attach 테이블 모두 insert가 진행 되어야 하기때문에 사용함
	@Override
	public void register(BoardVO board) {
		log.info("register....." + board);
		
		mapper.insertSelectKey(board); //qna_board에 먼저 등록
		
		if (board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return; // 값이 null이거나 size가 0이하이면 리턴
		}
		
		board.getAttachList().forEach(attach ->{//람다식 문제가 없다면 qna_attach 테이블에 등록
			
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
		
	}

	@Override
	public BoardVO get(Long bno) {

		System.out.println("get테스트 입니다. :" + bno);
		return mapper.read(bno);
	}
	
	@Override
	public int getTotal(Criteria cri) {
		
		System.out.println("get total count");
		return mapper.getTotalCount(cri);
	}

	@Transactional
	@Override
	public boolean modify(BoardVO board) { //수정하다

		log.info("modify..................." + board);
		
		attachMapper.deleteAll(board.getBno());
		
		boolean modifyResult = mapper.update(board) == 1 ;
		
		if (modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0) {
			
			board.getAttachList().forEach(attach -> {
				
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		
		return modifyResult;
	}
	
	@Transactional //첨부파일 삭제와 실제 게시물의 삭제가 같이 처리되도록 트랜잭션하에 delleteAll()을 호출
	@Override
	public boolean remove(Long bno) {
		
		log.info("remove...." + bno);
		
		attachMapper.deleteAll(bno);
		
		return mapper.delete(bno) == 1;
	}
/*
	@Override
	public List<BoardVO> getList() {
		System.out.println("getList...............");
		return mapper.getList();
	}
*/
	@Override
	public List<BoardVO> getList(Criteria cri) {
		
		System.out.println("get List With Criteria: " + cri);
		
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {//게시물의 첨부파일들의 목록 가져오기
		
		log.info("get Attach list by bno " + bno);
		
		return attachMapper.findByBno(bno); //게시물 번호를 이용해서 BoardAttachVO 타입으로 변환
		
	}

}
