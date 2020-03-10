<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<script src="/resources/jQuery/jquery-3.4.1.min.js"></script>
	<link rel="stylesheet" href="/resources/css/header.css"  type="text/css" />
	<link rel="stylesheet" href="/resources/css/boardPage.css"  type="text/css" />
	
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
			<h1 style="color:#0B3B2E; font-family:verdana;">Q&A Board Register</h1>
			<!--
		<img alt="casino" src="resources/img/main.png" style="width:100%">
		  -->
			  <div class="panel-default">
			  	<div class="panel-head">질문 작성 게시판</div>
			  
				  <div class="panel-body">
				  	<!-- start form -->
					<form role="form" action="/board/register" method="post">
						<div class="form-group">
							<label>제목</label> <input required class="form-control" name="title">
						</div>
						
						<div class="form-group">
							<label>내용</label>
							<textarea required class="form-controller" rows="7" name='content'></textarea>
						</div>			
						
						<div class="form-group">
							<label>작성자</label> <input required class="form-control" name="writer">
						</div>
						
						<button type="submit" id="btnSave" class="btn btn-default">Submit Button</button>
						<button type="reset" class="btn btn-default">Reset Button</button>
					
					</form> <!-- end form -->
				</div>	<!-- end panel-body -->
			</div> <!-- end panel-default -->
			
			
		
			
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-head">File Attach</div>
							<div class="panel-body">
								<div class="form-group uploadDiv">
									<input type="file" name="uploadFile" multiple>
								</div>
							
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
			
		</div> <!-- end column middle  -->
	   
	   <div class="column side">
			<h2>advertisement</h2>
			<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit..</p>
		</div>
		
   </div><!-- row End -->
   
   
<script>
$(document).ready(function(e){
	
	
	var formObj = $("form[role='form']");
	
	$("button[type='submit']").on("click", function(e){
		// └submit button을 클릭했을때 첨부파일 관련 처리를 할 수 있도록 기본 동작을 막는작업
		
		e.preventDefault();
		
		console.log("submit clicked");
		
		var str = "";
		
		$(".uploadResult ul li").each(function(i, obj){
			/*브라우저에서 게시물 등록을 선택하면 이미 업로드 된 항목들을 내부적으로 
			input type = 'hidden' 태그들로 만들어서 form 태그가 submit 될 때 같이 전송되도록 한다.*/
			
			var jobj = $(obj);
			
			console.dir(jobj);
			
			str += "<input type = 'hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			str += "<input type = 'hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type = 'hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			str += "<input type = 'hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
			
		}); // end uploadResult
		
		formObj.append(str).submit();
		
	}); // end "button[type='submit']"
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$"); //바이러스 방지용 확장자 제어
	var maxSize = 5242880; //5MB
	
	function checkExtension(fileName, fileSize){
		
		if(fileSize >= maxSize){//파일 사이즈 검사 5MB 이상은 경고문구가 뜬다.
			alert("파일 사이즈 초과");
			return false;
		}
		
		if(regex.test(fileName)){ //exe|sh|zip|alz 종류의 파일 형식을 올릴 경우 경고문구뜬다.
			alert("해당 종류의 파일은 업로드 할 수 없습니다.");
			return false;
		}
		return true;
	} //end checkExtension
	
	function showUploadResult(uploadResultArr){
		
		if(!uploadResultArr || uploadResultArr.length == 0){ return; }
		
		var uploadUL = $(".uploadResult ul");
		
		var str = "";
		
		$(uploadResultArr).each(function(i, obj) {
			
			
			if (obj.image) { //이미지 파일일 경우 섬네일을 보여준다.
				//str += "<li>" + obj.fileName + "</li>";
				
				var fileCallPath = encodeURIComponent(obj.uploadPath+ "/s_"+obj.uuid+"_"+obj.fileName);
				
				str += "<li data-path='"+obj.uploadPath+"'";
				str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
				str +" ><div>";
				str += "<span> "+ obj.fileName+"</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' "
				str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/display?fileName="+fileCallPath+"'>";
				str += "</div>";
				str +"</li>";
				//업로드된 정보 json으로 처리		
				
			} else { 
				
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
				
				var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
				
				str += "<li "
				str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
				str += "<span> "+ obj.fileName+"</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' "
				str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/resources/img/attach.png'></a>";
				str += "</div>";
				str +"</li>";
				//업로드된 정보 json으로 처리
			}
		}); // end uploadResultArr
		
		uploadUL.append(str);
		
	} // end showUploadResult

	$(".uploadResult").on("click", "button", function(e) {
		// └ 첨부파일 X(delete) 버튼 클릭시  작동하는 함수
		console.log("delete file");
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		
		var targetLi = $(this).closest("li");
		
		$.ajax({
			url: '/deleteFile',
			data: {fileName: targetFile, type:type},
			dataType:'text',
			type: 'POST',
				success: function(result){
					alert(result);
					targetLi.remove();
				}
		}); //$.ajax
	});
	
	
	$("input[type='file']").change(function(e){
		
		var formData = new FormData();
			
		var inputFile = $("input[name='uploadFile']");
	
		var files = inputFile[0].files;

			//첨부파일 전송
			for (var i = 0; i < files.length; i++) {

				if (!checkExtension(files[i].name, files[i].size) ) {
					return false; //파일 검사 
				}

				formData.append("uploadFile", files[i]);//첨부파일 데이터 추가

			}
			
			$.ajax({
				url : '/uploadAjaxAction',
				processData : false,
				contentType : false, //processData, contentTypesms를 'false'로 지정해야만 전송된다.
				data : formData, //ajax를 통해서 formData 자체를 전송한다.
				type : 'POST',
				dataType : 'json', //ajax를 호출했을때 결과 타입(data type)을 'json'으로 변경한다. 
				success : function(result) {

					console.log(result); //브라우저에서 결과 출력	

					showUploadResult(result); //화면에 업로드 된 파일의 이름을 출력해준다.

				}
			});//$.ajax

	});

});
	
	
</script>


</body>
</html>