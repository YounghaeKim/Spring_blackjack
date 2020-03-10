<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
   <script src="/resources/jQuery/jquery-3.4.1.min.js"></script>
   <link rel="stylesheet" href="/resources/css/header.css"  type="text/css" />
   <link rel="stylesheet" href="/resources/css/boardPage.css"  type="text/css" />
   <title>게시판</title>
</head>
<body>
   <%@include file="../includes/header.jsp"%>
        
        <div class="row">
        <div class="column side">
         <h2>advertisement</h2>
         <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit..</p>
      </div>

      <div class="column middle">
         <h1 style="color:#F7F8E0; font-family:verdana; text-align:center; background-color:#1b2936;">고객 게시판</h1>
         <!--
      <img alt="casino" src="resources/img/main.png" style="width:100%">
        -->
         <div class="panel-heading" >
            <button id="regBtn" type="button" class="btn">새로운 글 작성</button>
            <div class="headTxt"><p>Board List Page</p></div>
         </div>
         
         <table id="customers">
            <thead>
              <tr> 
                <th>#번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>수정일</th>
              </tr>
            </thead>
            
            <c:forEach items="${list}" var="board">
               <tr>
                  <td><c:out value="${board.bno}" /></td>
                  <td><a class='move' href='<c:out value="${board.bno}"/>'>
                  <c:out value="${board.title}" />	<b>[<c:out value="${board.replyCnt}"/>]</b>
                  </a>
                  </td>
                  <td><c:out value="${board.writer}" /></td>
                  <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}" /></td>
                  <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}" /></td>
               </tr>
            </c:forEach>
         </table>
         <!-- table End -->
         
         <!-- 검색조건처리 -->
         
         <div class="row">
         	<div class="col-lg-12">
         	
         	<form id="searchForm" action="/board/list" method="get">
         		<select name="type">
         			<option value=""
         			<c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
         			<option value="T"
         			<c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
         			<option value="C"
         			<c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
         			<option value="W"
         			<c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
         			<option value="TC"
         			<c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목 or 내용</option>
         			<option value="TW"
         			<c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목 or 작성자</option>
         			<option value="TWC"
         			<c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>제목 or 내용 or 작성자</option>
         		</select>
         		<input type="text" name="keyword" value="<c:out value='${pageMaker.cri.keyword}'/>"/>
         		<input type="hidden" name="pageNum" value="<c:out value='${pageMaker.cri.pageNum}'/>"/>
         		<input type="hidden" name="amount" value="<c:out value='${pageMaker.cri.amount}'/>"/>
         		<button class="btn btn-default">Search</button>
         	</form>
         	</div>
         </div>
         <!-- 검색조건처리 ENd -->
          
         <div class="pull-right">
         	<ul class="pagination">
				<c:if test="${pageMaker.prev}">
					<li class="paginate_button previous">
					<a href="${pageMaker.startPage -1}">Previous</a>
					</li>
				</c:if>         	
         	
         		<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
         		 <li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""}">
         		  <a href="${num }">${num}</a> 
         		  </li> 
         		  </c:forEach>

         		
         		<c:if test="${pageMaker.next}">
         			<li class="paginate_button next"><a href="${pageMaker.endPage +1}">Next</a></li>
         		</c:if>
         	</ul>
         </div>
         
         <form id="actionForm" action="/board/list" method="get">
         	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
         	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
         	<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'>
         	<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
         </form>
         
         <!-- end pagination -->
         
      </div>
   
      
      <div class="column side">
         <h2>advertisement</h2>
         <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit..</p>
      </div>
      
   </div><!-- row End -->
   
   <!-- Modal 추가 -->
        <div class="modal hidden" id="myModal">
            <div class="modal_overlay"></div>
            <div class="modal_content">
               <div class="content">
              <h3>처리가 완료되었습니다.</h3>
              </div>
              <div class="modal_button">
              <button type="button">CLOSE</button>
              </div>
           </div>
        </div>
         
         <!-- Modal End -->
   
<script type="text/javascript">
$(document).ready(
 function() {
    
    var result = '<c:out value="${result}"/>';
    
    checkModal(result);
    
    history.replaceState({},null,null);
    
    function checkModal(result) {
       
       if (result === '' || history.state) {
         return;
      }
       
       if (parseInt(result) > 0) {
          
          $(".content").html("게시글 " + parseInt(result) + " 번이 등록되었습니다." + "<br><br>");
      }
       else if (result === null) {
    	   $(".content").html("에러" + "<br><br>");	
		} 
   
       
       $(".modal").css("display","flex");
      
    }
   $(".modal_button").on("click", function(){
      $("#myModal").fadeOut(300);
   });
    
   $("#regBtn").on("click", function(){
   
     self.location = "/board/register";
     alert("새글등록 이동!!");
   });
   
   /* 페이징 번호 처리 */
   var actionForm = $("#actionForm");
   
   $(".paginate_button a").on("click", function(e) {
	   
	   e.preventDefault();
	   
	   console.log('click');
	   
	   actionForm.find("input[name='pageNum']").val($(this).attr("href"));
	   actionForm.submit();
   });
   
   $(".move").on("click", function(e){
	  
	   e.preventDefault();
	   actionForm.append("<input type='hidden' name='bno' value='"+
	$(this).attr("href")+"'>");
	   actionForm.attr("action","/board/get");
	   actionForm.submit();
	   
   });
   /* 페이징 번호 처리 끝 */
   
   
   /* 검색버튼 이벤트 처리 */
   var searchForm = $("#searchForm");
   
   $("#searchForm button").on("click", function(e){
	   
	   if(!searchForm.find("option:selected").val()){
		   alert("검색종류를 선택하세요");
		   return false;
	   }
	   
	   
	   if(!searchForm.find("input[name='keyword']").val()){
		   alert("키워드를 입력하세요");
		   return false;
	   }
   
	   searchForm.find("input[name='pageNum']").val("1");
	   e.preventDefault();
	   
	   searchForm.submit();
   
   });
   /* 검색버튼 이벤트 처리 끝*/
   
 });

</script>
   
</body>
</html>




