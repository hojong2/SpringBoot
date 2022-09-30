package com.academy.bootspa.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.academy.bootspa.exception.BoardException;
import com.academy.bootspa.model.board.BoardService;
import com.academy.bootspa.model.domain.Board;
import com.academy.bootspa.util.Message;

@RestController
@RequestMapping("/rest")
public class RestBoardController {
	
	@Autowired
	private BoardService boardService;
	
	//기존폼을 시리얼화하여 전송 파라미터로 만든 후 전송된 요청 받음
	@PostMapping("/serial/board")
	public ResponseEntity<Message> registByParam(Board board){
		System.out.println("registBySerial 등록 요청 받음 "+board);
		boardService.insert(board);
		Message message = new Message(1, "registBySerial 성공");
		ResponseEntity<Message> entity= new ResponseEntity<Message>(message, HttpStatus.OK);
		return entity;
	}
	
	//기존폼을 시리얼화하여 전송 json문자열로 변환한 후 전송된 요청 받음
	@PostMapping("/json/board")
	public ResponseEntity<Message> registByJson(@RequestBody Board board){
		System.out.println("registByJson 등록 요청 받음 "+board);
		boardService.insert(board);
		Message message = new Message(1, "registByJson 성공");
		ResponseEntity<Message> entity= new ResponseEntity<Message>(message, HttpStatus.OK);
		return entity;
	}
	
	@GetMapping("/board")
	public List getMain() {
		List list = boardService.selectAll();
		return list;
	}
	@GetMapping("/board/{board_id}")
	public Board getBoard(@PathVariable("board_id") int board_id) {
		Board board = boardService.select(board_id);
		return board;
	}
	
	//한건 수정 요청
	@PutMapping("/board")
	public ResponseEntity<Message> update(Board board){
		System.out.println("수정 요청으로 받은 파라미터는 "+board);
		boardService.update(board);
		Message message = new Message(1, "수정 성공");
		ResponseEntity<Message> entity = new ResponseEntity<Message>(message, HttpStatus.OK);
		return entity;
	}
	
	//한건 삭제 요청
	@DeleteMapping("/board")
	public ResponseEntity<Message> del(Board board){
		boardService.delete(board);
		Message message = new Message(0, "삭제 성공");
		ResponseEntity<Message> entity = new ResponseEntity<Message>(message, HttpStatus.OK);
		return entity;
	}
	
	@ExceptionHandler
	public ResponseEntity<Message> handle(BoardException e){
		Message message = new Message(0, e.getMessage());
		ResponseEntity<Message> entity= new ResponseEntity<Message>(message, HttpStatus.INTERNAL_SERVER_ERROR);
		return entity;
	}
}
