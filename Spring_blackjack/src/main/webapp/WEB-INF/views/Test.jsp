<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="java.util.Map"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Calendar 클래스 사용</title>
</head>
<body>

<%
	Calendar cal = Calendar.getInstance();
%>
오늘은
<%= cal.get(Calendar.YEAR) %>년
<%= cal.get(Calendar.MONTH)+1 %>월
<%= cal.get(Calendar.DATE) %>일
입니다.<br> 

클라이언트 IP = <%= request.getRemoteAddr() %> <br>
요청정보길이 = <%= request.getContentLength() %> <br>
요청정보 인코딩 = <%= request.getCharacterEncoding() %> <br>
요청정보 컨텐츠타입 = <%= request.getContentType() %> <br>
요청정보 프로토콜 = <%= request.getProtocol() %> <br>
요청정보 전송방식 = <%= request.getMethod() %> <br>
요청 URI= <%= request.getRequestURI() %> <br>
컨텍스트 경로 = <%= request.getContextPath() %> <br>
서버이름 = <%= request.getServerName() %> <br>
서버포트 = <%= request.getServerPort() %> <br>

<form action="/chap02/viewParameter.jsp" method="post">
이름: <input type="text" name="name" size="10"> <br>
주소: <input type="text" name="address" size="30"> <br>
좋아하는동물:
	 <input type="checkbox" name="pet" value="dog">강아지
	 <input type="checkbox" name="pet" value="cat">고양이
	 <input type="checkbox" name="pet" value="pig">돼지
	 <br>
	 <input type="submit" value="전송">
</form>

<b>request.getParameter() 메서드 사용</b><br>
name 파라미터 = <%= request.getParameter("name") %> <br>
address 파라미터 = <%= request.getParameter("address") %> <br>
<p>
<b>request.getParameterValue() 메서드 사용</b><br>
<%
	String[] values = request.getParameterValues("pet");
	if(values != null){
		for (int i = 0; i < values.length; i++){
%>
	<%= values[i] %>			
<%			
		}
	}
%>
<p>
<b>request.getParameterNames() 메서드 사용</b><br>
<%
	Enumeration paramEnum = request.getParameterNames();
	while(paramEnum.hasMoreElements()){
		String name = (String)paramEnum.nextElement();
	
%>
	<%= name %>
<%
	}
%>
<p>
<b>request.getParameterMap() 메서드 사용</b><br>
<%
	Map ParameterMap = request.getParameterMap();
	String[] nameParam = (String[])ParameterMap.get("name");
	if(nameParam != null){
%>
name = <%= nameParam[0] %>
<%
	}
%>

<!-- 이 jsp 파일은 지워도 됨 테스트 하는용임 -->
</body>
</html>