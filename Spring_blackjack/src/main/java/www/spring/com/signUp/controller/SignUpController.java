package www.spring.com.signUp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import www.spring.com.signUp.service.SignUpService;
import www.spring.com.user.model.UserVO;

@Controller
public class SignUpController {
	
	@Autowired
	private SignUpService signUpService;//서비스에 연결시킨다.
	
	@RequestMapping("/signUp.do") //회원가입 페이지 이동
	public String openSignUpPage(Model model) {
		return "signUp/signUpPage";
	}
	
	@PostMapping("/memberSingUp.do")//
	public String signUp(UserVO signUpRequestUser) { //회원가입 요청 처리 후 회원가입 성공하면 로비로이동
		//System.out.println(signUpRequestUser.getGender());
		signUpService.requestSignUp(signUpRequestUser);
		
		return "robby/robbyPage";
	}
}
