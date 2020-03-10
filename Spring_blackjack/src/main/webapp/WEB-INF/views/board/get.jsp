<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<script src="/resources/jQuery/jquery-3.4.1.min.js"></script>
	<link rel="stylesheet" href="/resources/css/header.css"  type="text/css" />
	<link rel="stylesheet" href="/resources/css/getPage.css"  type="text/css" />
	
	<title>Board Register</title>
</head>
<body>
	<%@include file="../includes/header.jsp"%>
	  	
	  	<div class="row">
	  	<div class="column side">
			<h2>advertisement</h2>
			<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit..</p>
		</div>

		<div class="column middle">
			<h1 style="color:#0B3B2E; font-family:verdana;">Q&A Board Info</h1>
			<!--
		<img alt="casino" src="resources/img/main.png" style="width:100%">
		  -->
			  <div class="panel-default">
			  	<div class="panel-head" style="color: blue">질문 상세 게시판</div>
			  
				  <div class="panel-body">
						<div class="form-group">
		                     <label><strong>Bno</strong></label> <input class="form-control" name="bno"
		                     value='<c:out value="${board.bno}"/>' readonly="readonly">
		                  </div>
		                  
		                  <div class="form-group">
		                     <label><strong>제목</strong></label> <input class="form-control" name="title"
		                     value='<c:out value="${board.title}"/>' readonly="readonly">
		                  </div>
		                  
		                  <div class="form-group">
		                     <label><strong>내용</strong></label>
		                     <textarea class="form-control" rows="7" name='content' readonly="readonly"><c:out value="${board.content}" /></textarea>
		                  </div>         
		                  
		                  <div class="form-group">
		                     <label><strong>작성자</strong></label> <input class="form-control" name="writer"
		                     value='<c:out value="${board.writer}"/>' readonly="readonly">
		                  </div>
						
						<button data-oper="modify" class="btn btn-default">수정</button>
						<button data-oper="list" class="btn btn-info">리스트</button>
						
						<form id="operForm" action="/board/modify" method="get">
							<input type="hidden" id="bno" name="bno" value="<c:out value='${board.bno}'/>">
							<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>">
							<input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>">
							<input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>">
							<input type="hidden" name="type" value="<c:out value='${cri.type}'/>">
						</form>
					
				</div>	
			</div>
			<!-- end panel-default -->
			
			<div class="bigPictureWrapper">
				<div class="bigPicture">
				</div>
			</div>
			
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
					
						<div class="panel-head">Files</div>
						<!-- End panel-head -->
							<div class="panel-body">
							
								<div class="uploadResult">
									<ul>
									</ul>
								</div>
							</div>
							<!-- end panel-body -->
					</div>
					<!-- end panel -->
				</div>
				<!-- end col-lg-12 -->
			</div>
			<!-- end row -->
			
			<!-- Start Reply -->
			<div class="panel panel-default">
				<!-- <div class="panel-head">
					<i class="fa fa-comments fa-fw"></i> Reply
				</div>
				-->
				<div class="panel_head">
					<i class="fa fa-comments fa-fw"></i>Reply
					<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>
				</div>
			
			
			
				<div class="panel_body">
					
					<ul class="chat">
						<li class="left clearfix" data-rno='12'>
							<div>
								<div class="panel-head2">
									<strong class="primary-font">user00</strong>
									<small class="pull-right text-muted">2018-01-01 13:13</small>
								</div>
								<p>Good job!</p>
							</div>
						</li>
					</ul>
				</div>
				
				<div class="panel-footer">
				
				</div>
				
			</div>
			<!-- End Reply -->
			
		</div>
	   
	   <div class="column side">
			<h2>advertisement</h2>
			<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit..</p>
		</div>
		
   </div><!-- row End -->
   
   
<!-- Modal Start -->
<div class="modal hidden" id="myModal">
	 <div class="modal_overlay"></div>
	 <div class="modal_content">
     <div class="modal-header">
       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times</button>
      <h4 class="modal-title" id=myModalLabel>REPLY MODAL</h4>
     </div>

     <div class="modal-body">
       <div class="form-group">
         <label>REPLY</label>
         <input class="form-control" name="reply" value="NewReply!!!!">
       </div>

       <div class="form-group">
         <label>REPLYER</label>
         <input class="form-control" name="replyer" value="replyer">
       </div>

       <div class="form-group">
         <label>REPLY DATE</label>
         <input class="form-control" name="replyDate" value="">
       </div>

     </div>
	    


    <div class="modal-footer">
      <button id="modalModBtn" type="button" class="btn btn-warnig">Modify</button>
      <button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
      <button id="modalRegisterBtn" type="button" class="btn btn-primary">Regiter</button>
      <button id="modalCloseBtn" type="button" class="btn btn-default">Close</button>
	  </div>
   </div>
 
  </div>

<!-- Modal End -->


<script type="text/javascript" src="/resources/js/reply.js"></script>
<!--  
<script>

console.log("=======================");
console.log("JS TEST");

var bnoValue = '<c:out value="${board.bno}"/>';

replyService.getList({bno:bnoValue, page:1}, function(list){

	for (var i = 0,  len = list.length || 0; i <len; i++) {
		console.log(list[i]);
	}
});
//13번 댓글 삭제 테스트
replyService.remove(13, function(count){
	
	console.log(count);
	
	if (count === "success") {
		alert("REMOVED");
	}
}, function(err) {
	alert('ERROR...');
});

//12번 댓글 수정
replyService.update({
	rno : 12,
	bno : bnoValue,
	reply : "Modified Reply...."
}, function(result) {
	alert("수정완료...");
});

//10번 조회
replyService.get(10, function(data){
	console.log(data);
	
});

</script>
-->

<script>
$(document).ready(function() {
	
	(function(){
		
		var bno = '<c:out value="${board.bno}"/>';
		
		$.getJSON("/board/getAttachList", {bno: bno}, function(arr){
			//첨부파일의 데이터를 가져오는 부분을 즉시 실행 함수를 이용해서 처리한다.
			console.log(arr);
			
			var str = "";
			
			$(arr).each(function(i, attach){
				
				//image Type
				if (attach.fileType) {
					var fileCallPath = encodeURIComponent(attach.uploadPath+ "/s_"+attach.uuid+"_"+attach.fileName);
					
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>"
					str += "<img src='/display?fileName="+fileCallPath+"'>";
					str += "</div>";
					str +"</li>";
				}else{
					
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>"
					str += "<span> "+ attach.fileName+"</span></br>";
					str += "<img src='/resources/img/attach.png'></a>";
					str += "</div>";
					str +"</li>";
				}
			});
			
			$(".uploadResult ul").html(str);
			
		});//end getjsone
		
	})();//end function
	
	
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUL = $(".chat");

	
	showList(1);
	
	function showList(page) {
		
			console.log("show list " + page);
			
			replyService.getList({bno:bnoValue,page: page|| 1}, 
		function(replyCnt, list) {
			
			console.log("replyCnt: " + replyCnt);	
			console.log("list: " + list);	
			console.log(list);	
			
			if(page == -1){
				pageNum = Math.ceil(replyCnt/10.0);
				showList(pageNum);
				return;
				
			}
			
			var str="";
			
			if (list == null || list.length == 0) {
				return;
			}
			
			for (var i = 0,  len = list.length || 0; i < len; i++) {
				str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
				str +="	<div><div class='panel-head2'><strong class='primary-font'>["+list[i].rno+"] "+list[i].replyer+"</strong>";
				str +="		<small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
				str +="		<p>"+list[i].reply+"</p></div></li>";
			}
			
		replyUL.html(str);
		
		showReplyPage(replyCnt);//showlist 마지막에 댓글페이지넘버 출력
			
		});//end function
	}//end showList
	
	var modal = $(".modal");
	var modalInputReply = modal.find("input[name='reply']");
	var modalInputReplyer = modal.find("input[name='replyer']");
	var modalInputReplyDate = modal.find("input[name='replyDate']");
	
	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalRegisterBtn = $("#modalRegisterBtn");
	
	//새로운 댓글 등록 버튼 클릭 이벤트
	$("#addReplyBtn").on("click", function(e) {
		
		modal.find("input").val("");
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id !='modalCloseBtn']").hide();		
		
		modalRegisterBtn.show();
		
		$(".modal").css("display","flex");
	});
	
	//close 버튼 클릭시 이벤트
	 $("#modalCloseBtn").on("click", function(){
		 $(".modal").css("display","none");
	   });
	
	 
	 //새로운 댓글 작성후 작성완료 버튼 클릭시 이벤트
	modalRegisterBtn.on("click",function(e){
		
		var reply = {
				reply: modalInputReply.val(),
				replyer: modalInputReplyer.val(),
				bno:bnoValue
			};
		replyService.add(reply, function(result){
			
			alert(result);
			
			modal.find("input").val("");
			$(".modal").css("display","none");//css속성중 display 옵션을 활용해서 모달창을 감춘다.
			
			//showList(1); //여러번 서버를 호출해야하는 단점이 있지만 댓글 등록이 조회나 페이징에 비해 적어서 문제 없음
			showList(-1);
		});
	});
	
	
	//댓글 클릭 이벤트 처리
	$(".chat").on("click", "li", function(e){
		
		var rno = $(this).data("rno");
		
		replyService.get(rno, function(reply){
			
			modalInputReply.val(reply.reply);
			modalInputReplyer.val(reply.replyer);
			modalInputReplyDate.val(replyService.displayTime( reply.replyDate)).attr("readonly","readonly");
			modal.data("rno",reply.rno);
			
			modal.find("button[id !='modalCloseBtn']").hide();
			modalModBtn.show();
			modalRemoveBtn.show();
			
			$(".modal").css("display","flex");//modal창의 css속성을 활용해서 모달창을 띄운다.
		})
	});
	
	//댓글 내용 수정
	modalModBtn.on("click", function(e){
		
		var reply = {rno:modal.data("rno"), reply: modalInputReply.val()};
		
		replyService.update(reply, function(result){
			
			alert(result);
			$(".modal").css("display","none");//css속성중 display 옵션을 활용해서 모달창을 감춘다.
			showList(pageNum);//수정시 현재 댓글이 포함된 페이지로 이동한다
		});
	});
	
	
	//댓글 내용 삭제
	modalRemoveBtn.on("click", function(e){
		
		var rno = modal.data("rno");
		
		replyService.remove(rno, function(result){
			
			alert(result);
			$(".modal").css("display","none");//css속성중 display 옵션을 활용해서 모달창을 감춘다.
			showList(pageNum);//수정시 현재 댓글이 포함된 페이지로 이동한다
		});
	});
	
	
	//댓글 아랫창 번호출력
	var pageNum = 1;
	var replyPageFooter = $(".panel-footer");
	
	function showReplyPage(replyCnt) {
		
		var endNum = Math.ceil(pageNum / 10.0) * 10;
		var startNum = endNum - 9;
		
		var prev = startNum != 1;
		var next = false;
		
		if(endNum * 10 >= replyCnt){
			endNum = Math.ceil(replyCnt/10.0);
		}
		
		if(endNum * 10 < replyCnt){
			next = true;
		}
		
		var str = "<ul class='pagination pull-right'>";
		
		if (prev) {
			str += "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
			
		}
		
		for (var i = startNum; i <= endNum; i++) {
			
			var active = pageNum == i? "active":"";
			
			str += "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
		}
		
		if (next) {
			str += "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
		}

		str += "</ul></div>";
		
		console.log(str);
		
		replyPageFooter.html(str);
	}
	
	
	//페이지 번호 클릭시 새로운 댓글을 가져오기
	replyPageFooter.on("click","li a", function(e){
		e.preventDefault();
    console.log("page click");

    var targetPageNum = $(this).attr("href");

    console.log("targetPageNum: " + targetPageNum);

    pageNum = targetPageNum;

    showList(pageNum);
		
	});
	
	$(".uploadResult").on("click","li", function(e){
		
		console.log("view image");
		
		var liObj = $(this);
		
		var path = encodeURIComponent(liObj.data("path")+ "/"+liObj.data("uuid")+"_"+liObj.data("filename"));
		
		if (liObj.data("type")) {
			
			showImage(path.replace(new RegExp(/\\/g),"/"));
		}else{
			//download
			self.location = "/download?fileName="+path;
		}
		
	});
	
	function showImage(fileCallPath){
		
		alert(fileCallPath);
		
		$(".bigPictureWrapper").css("display","flex").show();
		
		$(".bigPicture")
		.html("<img src='/display?fileName="+fileCallPath+"'>")
		.animate({width:'100%', height:'100%'}, 1000);
		// 이미지 클릭하면 섬네일 크게 나오기
	}
	
	
	//업로드 원본 이미지가 보이는 창을 닫는다.
	$(".bigPictureWrapper").on("click", function(e){
		$(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
		setTimeout(function(){
			$(".bigPictureWrapper").hide();
		}, 1000);
	});
	
	
});
</script>

<script type="text/javascript">
$(document).ready(function() {
	
	 var operForm = $("#operForm");
	 
	 $("button[data-oper='modify']").on("click", function(e){
		
		 operForm.attr("action","/board/modify").submit();
		
	 });
	
	 $("button[data-oper='list']").on("click", function(e){
	 
	 operForm.find("#bno").remove();
	 operForm.attr("action","/board/list")
	 operForm.submit();
	 
	 });
 });
</script>


</body>
</html>