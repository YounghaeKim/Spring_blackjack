package www.spring.com.user.mapper;

import java.util.List;

import www.spring.com.user.model.UserVO;

public interface UserMapper {
	public List<UserVO> getAllBoard();
	public UserVO loginCheck(UserVO logingUser);
}