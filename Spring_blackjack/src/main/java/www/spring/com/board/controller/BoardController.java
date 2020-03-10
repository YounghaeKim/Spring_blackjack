package www.spring.com.board.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import www.spring.com.board.model.BoardAttachVO;
import www.spring.com.board.model.BoardVO;
import www.spring.com.board.model.Criteria;
import www.spring.com.board.model.PageDTO;
import www.spring.com.board.service.BoardService;
/**
 * BoardController 는 BoardService에 의존적이므로
 * @AllArgsConstructor를 이용 해서 생성자를 만들고 자동으로 주입하도록 한다.
 *
 */
@Log4j
@Controller
@RequestMapping("/board") // /board로 시작하는 모든 처리를 BoardController가 한다.
@AllArgsConstructor
public class BoardController {
	
		
	private BoardService service;
	
	/*
	@GetMapping("/list")
	public void list(Model model) { //model을 파라미터로 지정하고 view로 넘겨준다.
		System.out.println("list");
		
		model.addAttribute("list", service.getList());
	}
	*/
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) { //model을 파라미터로 지정하고 view로 넘겨준다.
		
		System.out.println("list: " + cri);
		model.addAttribute("list", service.getList(cri));
		//model.addAttribute("pageMaker", new PageDTO(cri, 123));
		
		int total = service.getTotal(cri);
		
		System.out.println("total: " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
	}
	
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		// RedirectAttributes등록 작업이 끈난 후 다시 목록 화면으로 이동
		// 추가적으로 새롭게 등록된 게시물의 번호를 같이 전달하기 위해서 RedirectAttributes를 사용
		log.info("==========================");
		
		log.info("register: " + board);
		
		if(board.getAttachList() != null) {
			
			board.getAttachList().forEach(attach -> log.info(attach));
			
		}
		
		log.info("==========================");
		
		service.register(board);;
		
		rttr.addFlashAttribute("result", board.getBno());
		
		return "redirect:/board/list"; //String을 리턴 타입으로 지정
		//redirect:이 접두어는 스프링MVC가 내부적으로 response.sendRedirect()를 처리해주기때문에 편리
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		
		System.out.println("/get or modify");
		model.addAttribute("board", service.get(bno));
	}
	
	@PostMapping("/modify")//수정
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		System.out.println("modify: " + board);
		
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
				
		return "redirect:/board/list" + cri.getListLink();
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, Criteria cri, RedirectAttributes rttr) {
		
		log.info("remove...." + bno);
		
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		
		if (service.remove(bno)) {
			
			//delete Attach Files
			deleteFiles(attachList);
			
			rttr.addFlashAttribute("result","success");
		}
		
		return "redirect:/board/list" + cri.getListLink();
	}
	
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) {
		
		log.info("getAttachList " + bno);
		
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		
		log.info("delete attach files...............................");
		log.info(attachList);
		
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\" + attach.getUuid()+"_"+ attach.getFileName());
				
				Files.deleteIfExists(file);
				
				if (Files.probeContentType(file).startsWith("image")) {
					
					Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_" + attach.getUuid()+"_"+ attach.getFileName());
					
					Files.delete(thumbNail);
				}
				
			}catch (Exception e) {
				log.error("delete file error" + e.getMessage());
			}//end catch
		});//end foreachd
	}
	
	
	
}
