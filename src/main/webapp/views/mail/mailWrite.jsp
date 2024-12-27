<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/css/root.css" />
	<link rel="stylesheet" href="<c:url value='/resources/richtexteditor/res/style.css' />" />
	<link rel="stylesheet" href="<c:url value='/resources/richtexteditor/rte_theme_default.css' />" />
	<link rel="stylesheet" href="<c:url value='/resources/richtexteditor/runtime/richtexteditor_content.css' />" />

	<script type="text/javascript" src="resources/richtexteditor/rte.js"></script>
	<script type="text/javascript" src='resources/richtexteditor/plugins/all_plugins.js'></script>	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script> 
  
  
  
  <style>
	:root{
		--primary-color: #30005A;
		--secondary-color: #8B6AA7;
		--accent-color: #E9396B;
	}
	.dashboard-body{
	    margin-left: 12vw;
	    width: 85vw;
	    margin-top: 7vh;
	    flex-wrap: wrap;
	    padding: 2vh;
	    height: 100%;
	    display: flex;
	    flex-direction: column;
	    align-content: center;
	    align-items: flex-start;
	}
	.maintext{
		display: flex;
		margin-left: 10px;
	}
	.mail{
		color: var(--secondary-color);
		margin-right: 30px;
	    margin-bottom: 40px;
	}
	.mailbox{
		border: 2px solid var(--primary-color);
	    width: -webkit-fill-available;
		height: 85%;
	    border: 2px solid var(--primary-color);
	    border-radius: 10px;
	    padding: 10px; 
	}
		
	.mailnav{
		display: flex;
    	justify-content: space-between;
		align-items: center;
		margin: 0 48px;
		padding: 0 5px;
	}
	.opt{
		width: 42%;
		display: flex;
		justify-content: space-between;
	    align-items: center;
	    color: var(--secondary-color);
	}
	.opt div{
		align-content: center;
	}
	.opt div:first-child{
		color: var(--primary-color);
		font-weight: bold;
		border-bottom: 3px solid var(--accent-color);
	}
	.opt div:not(:last-child){
		font-size: 20px;
		font-weight: bold;
		height: 60px;
	}
	.opt div:hover{
		cursor: pointer;
		color: var(--primary-color);
		font-weight: bold;
		border-bottom: 3px solid var(--accent-color);
	}
	.opt div:last-child:hover {
	    border-bottom: none;
	}
	.drop{
	    height: 28px;
	    font-size: 14px;
	    border: 1px solid var(--primary-color);
	    border-radius: 4px;
	    color: var(--primary-color);
	    cursor: pointer;
	}
	.drop option{
		background-color: white !important;
	}
	.drop option:hover{
		cursor: pointer;
		background-color:var(--secondary-color);
	}
	.searchbox{
		width: 20%;
		display: flex;
		align-items: center;
		justify-content: space-between;
	}
	.search{
		position: relative;
    	display: inline-block;
	}
	.search input{
		border-radius: 10px;
		padding-left: 10px;
		border: 1px solid var(--primary-color);
	}
	.search i{
		position: absolute;
		right: 10px;
		top: 50%;
		transform: translateY(-50%);
		font-size: 18px;
		pointer-events: none;
		color: var(--accent-color);
	}
	.editbtn{
		color: white;
		background-color: var(--accent-color);
		border-radius: 10px;
		width: 70px;
	}
	.fa-trash-alt:hover{
		color: var(--accent-color);
		cursor: pointer;
	}
	
	.mailForm{
		border-collapse: collapse; /* 테이블 셀 간 간격 제거 */
		margin-bottom: 0 !important;
	}
	
	table, tr, td{
		color: var(--primary-color);
	}
	
	tr input[type='text']{
		width: 70%;
		background-color: #FFFBF2;
		border: none;
	}
	
	
	
	
	table {
    border-collapse: collapse; /* 셀 간격 제거 */
    width: 100%; /* 테이블 전체 너비 */
    height: 100% !important;
	}

td {
    padding: 5px 10px; /* 상하 padding 조정 */
    vertical-align: middle; /* 내용 수직 정렬 */
    line-height: 1.2; /* 텍스트 줄 간격 조정 */
}

tr input[type='text'] {
    height: auto; /* 기본 높이 자동 */
    padding: 3px; /* 입력 필드 padding 조정 */
    font-size: 14px; /* 입력 필드 텍스트 크기 */
    background-color: #FFFBF2;
    border: none;
}
	
	
	
	label{
		color: #30005A !important;
		width: 70px;
	}
	
	.specialChk{
		color: var(--accent-color) !important;
	}
	
	  /* 버튼 크기와 폰트 크기 통일 */
	  button[type="button"] {
	      height: 40px; /* 버튼 높이 */
	      min-width: 120px; /* 버튼 최소 너비 */
	      padding: 5px 10px; /* 내부 여백 */
	      font-size: 16px; /* 버튼 내부 폰트 크기 */
	      font-weight: bold; /* 폰트 굵기 */
	      background-color: var(--secondary-color); /* 기본 배경색 */
	      border: none; /* 테두리 제거 */
	      border-radius: 5px; /* 둥근 모서리 */
	      color: white; /* 폰트 색상 */
	      display: inline-flex; /* 아이콘과 텍스트 정렬 */
	      align-items: center; /* 수직 정렬 */
	      justify-content: center; /* 텍스트와 아이콘 중앙 정렬 */
	  }
	  button[type="button"]:hover {
	      background-color: var(--primary-color); /* 호버 시 배경색 변경 */
	  }
	  button[type="button"] i {
	      margin-right: 5px; /* 아이콘과 텍스트 간격 */
	      font-size: 18px; /* 아이콘 크기 */
	  }
	
	.btnArea{
		text-align: right;
	}
	
  /* Placeholder 스타일 적용 */
  input::placeholder {
    color: #888 !important; /* 원하는 색상으로 변경 */
    opacity: 1 !important;  /* 투명도 조정 */
  }

  textarea::placeholder {
    color: #888 !important; /* 텍스트 영역 placeholder 색상 */
    opacity: 1 !important;
  }
  
  
  
  
  .receiver-item {
    display: inline-block;
    background-color: #d1badb; /* 바이올렛? 배경 */
    padding: 5px 10px; /* 내부 여백 */
    border-radius: 15px; /* 둥근 모서리 */
    margin: 5px; /* 항목 간 여백 */
    color: #30005A; /* 글자 색상 */
    font-weight: bold; /* 글자 굵기 */
}
  
.receiver-item button {
    background: none; /* 배경 제거 */
    border: none; /* 테두리 제거 */
    color: #d32f2f; /* 빨간색 글자 */
    font-weight: bold; /* 글자 굵기 */
    cursor: pointer; /* 마우스 포인터 변경 */
    margin-left: 10px; /* 버튼과 텍스트 간격 */
}

.receiver-item button:hover {
    color: #b71c1c; /* 호버 시 더 진한 빨간색 */
}  
  

  
/* #receiver-container, #refer-container{
  display: flex;
  align-items: center;
  justify-content: space-between;
} */

#receiver-container, #refer-container, #subject-container{
  display: flex;
  align-items: center;
  justify-content: flex-start;
}


#add-receiver-btn, #add-refer-btn {
    min-width: fit-content !important;
    width: fit-content !important;
}



.chkArea{
	margin-right: 20px;
}



.form-group{
	margin: 0 !important;
}

.filebox {
    display: flex;
    align-items: center;
}

.file-content {
    display: inline-flex;
    align-items: center;
    gap: 5px; /* 아이콘과 텍스트 사이 간격 */
}

.delete-icon {
    cursor: pointer;
    color: #d32f2f;
}

.delete-icon:hover {
    color: #b71c1c;
}


.editor-td {
    height: 100% !important; /* 원하는 높이로 설정 */
    vertical-align: top; /* 콘텐츠를 상단에 정렬 */
}

#div_editor {
    width: 100%; /* 에디터의 너비 */
    height: 100%; /* 원하는 고정 높이 */
    overflow-y: auto; /* 세로 스크롤바 추가 */
    overflow-x: hidden; /* 가로 스크롤바 숨김 */
    border: 1px solid #ccc; /* 경계선 추가 */
    border-radius: 5px; /* 경계선 둥글게 */
    padding: 10px; /* 내부 여백 */
    box-sizing: border-box; /* 패딩 포함 */
    background-color: #fff; /* 배경색 */
}
	
	
  </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 <jsp:include page="../modal/findAdd.jsp"></jsp:include>
 <c:set var="emp_idx" value="${param.emp_idx}" />
 	<div class="dashboard-body">
		<div class="maintext">
			<h3 class="mail">메일함</h3>
			<h3>>&nbsp;&nbsp;메일작성</h3>
		</div>
		<div class="mailbox">
			<form action="mailWrite.do" method="POST">
				<table class="mailForm">
					<tr>
						<td>
							<label>작성자</label>
							<input type="text" name="sender_name" value="에이스" readonly/>
						</td>
						<!-- 보낸사람idx -->
						<input type="text" name="sender_idx" value="1" hidden/>
						<!-- 보낸사람 email -->
						<input type="text" name="sender_email" value="naver@naver.com" hidden/>
					</tr>
					<tr>
						<td>
							<div id="subject-container">
								<label>제목</label>
								<input type="text" name="subject" placeholder="제목을 입력 하세요! 50자 이내 작성" maxlength="50"/>
								<div class="chkArea">
									<input type="checkbox" name="specail_flag" id="mailType" value="1">
									<span class="specialChk">&nbsp;&nbsp;중요!</span>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<!-- 받는사람 입력 -->
							<div class="form-group">
							  <div id="receiver-container">
							  	<label>받는사람</label>
							    <input type="text" id="receiver-input" placeholder="이름 또는 이메일을 입력하세요" maxlength="50" />
							    <button type="button" id="add-receiver-btn" onclick="findAdd(0)"><i class="bi bi-person-add"></i></button>
							  </div>
							  <div id="receiver-list" class="mt-3"></div> <!-- 수신자가 표시될 영역 -->
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<!-- 참조 입력 -->
							<div class="form-group">
							  <div id="refer-container">
							  	<label>참조</label>
							    <input type="text" id="refer-input" placeholder="이름 또는 이메일을 입력하세요" maxlength="50" />
							    <button type="button" id="add-refer-btn" onclick="findAdd(1)"><i class="bi bi-person-add"></i></button>
							  </div>
							  <div id="refer-list" class="mt-3"></div> <!-- 참조자가 표시될 영역 -->
							</div>
						</td>
					</tr>
					<!-- 수신자와 참조자의 통합 JSON 데이터 -->
					<input type="hidden" name="receiver_data" id="receiver-data" />
					<tr>
						<td>
		                    <!-- 파일 첨부 -->
							<div class="form-group">
							  <label>파일 첨부</label> <span><small>첨부파일은 최대 5개까지 가능합니다.</small></span>
							  
							  <input type="file" name="file" id="upfile" class="form-control-file" multiple onchange="addFile();" />
							  <div id="file-list" class="file-list mt-2"></div> <!-- 파일 목록 표시 영역 -->
							</div>
						</td>
					</tr>
					<tr>
						<td class="editor-td">
							<div id="div_editor">
							</div>
							<input type="hidden" name="content"/>
						</td>
					</tr>
					<tr>
						<th class="btnArea">
							<button type="button" class="btn btn-primary" onclick="history.go(-1);">
								<i class="fas fa-undo"></i> 취소
							</button>
							<button type="button" class="btn btn-secondary" onclick="saveMail()">
							    <i class="far fa-save"></i> 임시저장
							</button>
							<button type="button" class="btn btn-third" onclick="sendMail()">
							    <i class="fas fa-paper-plane"></i> 메일전송
							</button>
						</th>
					</tr>
				</table>
			</form>
			
		</div>
 	</div>
</body>
<script>
/* 전역변수 */
var receiverList = []; // 수신자 데이터 저장용 배열

var emp_idx; // 작성자 사번
var receiver_idx = []; // 수신자 또는 참조자의 사번

/* 작성자 정보가져와서 input태그에 넣어주기..? 이름, 사번, 이메일 */
// 사원 이메일, idx, 이름가져오기


/* 
$.ajax({
	url: 'empInfo.ajax'
	method: 'POST',
	dataType: 'JSON',
	data: {
		'name' = 'name',
		'email' = 'email'
	},
	success: function(list){
		$.each(list, function(index, item){
			name = item.name;
			email = item.email;
			emp_idx = item.emp_idx;
		});
	},
	error: function(e){
		console.log(e);
	}
	
});
		 */


var config = {};
config.toolbar = "basic";
config.editorResizeMode = "none";


// 파일 업로드 핸들러 설정
config.file_upload_handler = function(file, pathReplace) {
    console.log(file);

    if (file.size > (1 * 1024 * 1024)) { // 파일 크기 제한 (1MB)
        alert('2MB 이상의 파일은 올릴 수 없습니다.');
        pathReplace('/img/noimage.png');
    }
};

var editor = new RichTextEditor("#div_editor", config);






//수신자 입력 필드에 대한 엔터 키 이벤트 핸들러
$("#receiver-input").keypress(function (e) {
    if (e.which === 13) { // Enter 키
        e.preventDefault(); // 기본 동작 방지
        addReceiverOrReferHandler("#receiver-input", "receiver-list", 0); // 수신자 추가
    }
});

$("#refer-input").keypress(function (e) {
    if (e.which === 13) { // Enter 키
        e.preventDefault(); // 기본 동작 방지
        addReceiverOrReferHandler("#refer-input", "refer-list", 1); // 참조자 추가
    }
});




//전역 변수 선언
var receiverList = []; // 수신자 및 참조자 정보를 담을 배열

// 이메일 형식 확인 함수
function validateEmail(email) {
    // 이메일 형식을 확인하기 위한 정규식
    var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

// 수신자 및 참조자 항목 추가
function addReceiverOrRefer(entry, listContainerId) {
    // 항목 표시를 위한 텍스트 생성
    var displayText = entry.name + " <" + entry.email + ">";

    // HTML 요소 생성
    var $newDiv = $("<div>").addClass("receiver-item").text(displayText);

    // 삭제 버튼 생성 및 클릭 이벤트 핸들러 추가
    var $removeBtn = $("<button>").text("x");
    $removeBtn.on("click", function () {
        // 배열에서 해당 항목 제거
        for (var i = 0; i < receiverList.length; i++) {
            if (receiverList[i].name === entry.name && receiverList[i].email === entry.email) {
                receiverList.splice(i, 1);
                break;
            }
        }
        // HTML 요소 제거
        $newDiv.remove();

        // hidden input 데이터 갱신
        updateHiddenField();
    });

    // 삭제 버튼을 div에 추가하고 컨테이너에 추가
    $newDiv.append($removeBtn);
    $("#" + listContainerId).append($newDiv);

    // hidden input 데이터 갱신
    updateHiddenField();
}

// 데이터 갱신 함수
function updateHiddenField() {
    // hidden input에 데이터를 업데이트
    $("#receiver-data").val(receiverList);
}

// 수신자 및 참조자 추가 핸들러
function addReceiverOrReferHandler(input, listContainerId, type) {
    var inputVal, isObjectInput = typeof input === "object";

    if (isObjectInput) {
        inputVal = input.email;
    } else {
        inputVal = $(input).val().trim();
    }

    // 입력값 유효성 검사
    if (inputVal === "") {
        alert("이름 또는 이메일을 입력하세요.");
        return;
    }

    // 중복 확인
    var isDuplicate = receiverList.some(function (item) {
        return item.name === inputVal || item.email === inputVal;
    });

    if (isDuplicate) {
        alert("이미 추가된 항목입니다.");
        return;
    }

    // 입력값 처리
    var newEntry;
    if (isObjectInput) {
        newEntry = {
            name: input.name,
            email: input.email,
            type: type
        };
    } else {
        if (validateEmail(inputVal)) {
            newEntry = {
                name: "알 수 없음",
                email: inputVal,
                type: type
            };
        } else {
            newEntry = {
                name: inputVal,
                email: "unknown@example.com",
                type: type
            };
        }
    }

    // 배열에 추가
    receiverList.push(newEntry);
    console.log('receiverList : ', receiverList);

    // UI 업데이트
    addReceiverOrRefer(newEntry, listContainerId);

    // 입력 필드 초기화
    if (!isObjectInput) {
        $(input).val("");
    }
}



















//500자 제한
$(document).on('input', '#div_editor', function() {
    var maxLength = 500;
    var text = $(this).text();
    if (text.length > maxLength) {
        $(this).text(text.substring(0, maxLength));
    }
});



// 메일 '전송'시 실행하는 함수
function sendMail() {
    // RichTextEditor 내용 가져오기
    var content = editor.getHTMLCode();

    // 에디터 내용이 100MB 이상인 경우 처리
    if (content.length > 100 * 1024 * 1024) {
        alert("100MB 이상의 크기는 전송이 불가능합니다.");
        return;
    }

    // 에디터 내용을 hidden input 필드에 설정
    $('input[name="content"]').val(content);

    // 필수 항목 검증
    if ($("#receiver-input").val().trim() === "") {
        alert("받는 사람 주소를 입력해 주세요.");
        return;
    }

    if ($('input[name="subject"]').val().trim() === "") {
        let confirmResult = confirm("제목이 지정되지 않았습니다. 제목 없이 메일을 보내시겠습니까?");
        if (!confirmResult) {
            $('input[name="subject"]').focus();
            return;
        }
    }

    // 폼 전송
    $('form').submit();
}



// 메일 '임시저장'시 실행하는 함수
function saveMail() {
    // RichTextEditor 내용 가져오기
    var content = editor.getHTMLCode();

    // 에디터 내용이 100MB 이상인 경우 처리
    if (content.length > 100 * 1024 * 1024) {
        alert("100MB 이상의 크기는 저장할 수 없습니다.");
        return;
    }

    // 필수 항목 검증
    if ($("#receiver-input").val().trim() === "") {
        alert("받는 사람을 입력해 주세요.");
        $("#receiver-input").focus();
        return;
    }

    if ($('input[name="subject"]').val().trim() === "") {
        alert("제목을 입력해 주세요.");
        $('input[name="subject"]').focus();
        return;
    }

    // 에디터 내용을 hidden input 필드에 설정
    $('input[name="content"]').val(content);

    // 폼의 action 경로를 임시저장용으로 설정
    $('form').attr('action', 'saveTemporaryMail.do');

    // 폼 제출
    $('form').submit();
}











var fileNo = 0; // 첨부파일 번호
var filesArr = new Array(); // 다중 첨부파일 들어갈 파일 배열



function renderFileList() {
    var fileListDiv = document.getElementById("file-list");
    fileListDiv.innerHTML = "";

    for (var i = 0; i < filesArr.length; i++) {
        var fileDiv = document.createElement("div");
        fileDiv.id = "file" + i;
        fileDiv.className = "filebox";

        // 파일명 및 아이콘 컨테이너 생성
        var fileContent = document.createElement("span");
        fileContent.className = "file-content";
        fileContent.innerHTML = filesArr[i].name + '<i class="far fa-minus-square delete-icon"></i>';

        // 삭제 버튼 클릭 이벤트 추가
        fileContent.querySelector(".delete-icon").onclick = (function (index) {
            return function () {
                deleteFile(index);
            };
        })(i);

        fileDiv.appendChild(fileContent);
        fileListDiv.appendChild(fileDiv);
    }
}



/* 첨부파일 추가 */
function addFile() {
	
	// 안내문 삭제
	$(".fileMsg").remove();
	
	var maxFileCnt = 5; // 첨부파일 최대 개수
	var attFileCnt = document.querySelectorAll('.filebox').length; // 기존 추가된 첨부파일 개수
	var remainFileCnt = maxFileCnt - attFileCnt; // 추가로 첨부가능한 개수
	var files = $('#upfile')[0].files; // 현재 선택된 첨부파일 리스트 FileList

	// 첨부파일 개수 확인
	if (files.length > remainFileCnt) {
		alert("첨부파일은 최대 " + maxFileCnt + "개 까지 첨부 가능합니다.");
		
		fileDataTransfer();
	}else{
		// 파일 배열에 담기
		let currFileArr = Array.from(files); // FileList => Array로 변환
		filesArr = filesArr.concat(currFileArr); // 추가한 fileList에 또 추가할 수 있도록 설정
		
		fileDataTransfer();
	    
	}
	renderingFileDiv(); // 추가 및 삭제할 때 마다 호출해서 index번호 초기화
	
}

/* 첨부파일 목록 html */
function renderingFileDiv(){
	
	let htmlData = '';
	for(let i=0; i<filesArr.length; i++){
		// i => 삭제할 파일 인덱스 번호
		
		// 목록 추가
		htmlData += '<div id="file' + i + '" class="filebox">';
		htmlData += '<span class="name">'+ filesArr[i].name + '</span>';
		htmlData += '<a class="delete" onclick="deleteFile('+ i + ');"><i class="far fa-minus-square"></i></a>';
		htmlData += '</div>';
	}
	
	$(".file-list").html(htmlData); // change가 발생할 때마다 목록 초기화한 뒤 넣어짐

}

/* 첨부파일 삭제 */
function deleteFile(fileNo) { // 매개변수 : 첨부된 파일 번호(fileNo, i)

	console.log(fileNo);
	
	// class="fileMsg"에 있는 문구 삭제
	document.querySelector("#file" + fileNo).remove();
	
    filesArr.splice(fileNo, 1);	// 해당되는 index의 파일을 배열에서 제거(1 : 한개만 삭제하겠다 라는 의미)
	
    fileDataTransfer();

    renderingFileDiv();
}


/* 첨부파일 담는 배열 */
function fileDataTransfer(){
	
	const dataTransfer = new DataTransfer();

    filesArr.forEach(function(file){ 
    //남은 배열을 dataTransfer로 처리(Array -> FileList)
    	dataTransfer.items.add(file); 
    });
    
    $('#upfile')[0].files = dataTransfer.files;	//제거 처리된 FileList를 돌려줌
}





function findAdd(type) {
    console.log("findAdd 호출됨. 타입:", type);

    openUserBoxModal();

    // 선택된 사원 정보 확인
    $("#addEmployeeButton").off("click").on("click", function () {
        if (window.selectedEmployee) {
            console.log("선택된 사원 정보:", window.selectedEmployee);

            addReceiverOrReferHandler(
                window.selectedEmployee, // 전역 변수에서 가져오기
                type === 0 ? "receiver-list" : "refer-list",
                type
            );

            $(".modalD").fadeOut();
            // 검색창 값 비워주기
            $("#searchInput").val('');
        } else {
            console.error("선택된 사원 정보가 없습니다.");
        }
    });
}







</script>
</html>