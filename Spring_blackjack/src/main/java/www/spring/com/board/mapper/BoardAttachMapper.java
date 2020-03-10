package www.spring.com.board.mapper;

import java.util.List;

import www.spring.com.board.model.BoardAttachVO;

public interface BoardAttachMapper {
// └첨부파일의 수정이 필요 없으므로 입력과 삭제만 처리한다.
	
	public void insert(BoardAttachVO vo);
	
	public void delete(String uuid);
	
	public List<BoardAttachVO> findByBno(Long bno);
	// └특정 게시물의 번호로 첨부파일을 찾는 작업이 필요하므로 findByBno()메서드를 추가했다.
	
	public void deleteAll(Long bno);
	// └첨부파일 삭제
	
	public List<BoardAttachVO> getOldFiles();
	// └첨부파일 목록을 가져온다.
}
