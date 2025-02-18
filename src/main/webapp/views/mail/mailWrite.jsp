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
	<script src="https://kit.fontawesome.com/0e9db4cdc9.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script> 
  
  	<link href="resources/css/mail/mailWrite.css" rel="stylesheet"/>
  
<style>

</style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 <jsp:include page="../modal/findAdd.jsp"></jsp:include>
 <jsp:include page="../modal/modal.jsp"></jsp:include>
 <c:set var="empIdx" value="${sessionScope.loginId}" />
 	<div class="dashboard-body">
		<div class="maintext">
			<span class="lPurple">메일함</span>
      			<i class="fa-solid fa-angle-right" style="color:#8B6AA7;"></i>
    		<span class="cPurple">메일작성</span>
		</div>
		<div class="mailbox">
			<form action="mailWrite.do" method="POST" enctype="multipart/form-data">
				<table class="mailForm">
					<tr>
						<td class="purple">
							<label>작성자</label>
						</td>
						<td>
							<input type="text" id="sender_info" readonly/>
						</td>
						<input type="text" id="sender_name" name="sender_name" value="" readonly hidden/>
						<input type="text" id="sender_email" name="sender_email" value="" readonly hidden/>
						<!-- 보낸사람idx -->
						<input type="text" id="sender_idx" name="sender_idx" value="" readonly hidden/>
					</tr>
					<tr>
						<td>
							<label>제목</label>
						</td>
						<td>
							<div id="subject-container">
								<input type="text" name="subject" placeholder="제목을 입력 하세요! 50자 이내 작성" maxlength="50"/>
								<div class="chkArea">
								    <!-- 기본값은 hidden input으로 설정 -->
								    <input type="hidden" name="special_flag" id="hidden_special_flag" value="0">
								    <input type="checkbox" id="mailType" value="1" onclick="setSpecialFlag(this);">
								    <span class="specialChk">&nbsp;&nbsp;중요!</span>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<label>받는사람</label>
						</td>
						<td>
							<!-- 받는사람 입력 -->
							<div class="form-group">
							  <div id="receiver-container">
							    <input type="text" id="receiver-input" placeholder="사원명 또는 이메일을 입력하세요" maxlength="50" />
							    <div id="autocomplete-list0" class="autoComplete" style="display:none; position:absolute;"></div>
							    <button type="button" id="add-receiver-btn" onclick="findAdd(0)"><i class="bi bi-person-add"></i></button>
							  </div>
							  <div id="receiver-list" class="mt-3"></div> <!-- 수신자가 표시될 영역 -->
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<label>참조</label>
						</td>
						<td>
							<!-- 참조 입력 -->
							<div class="form-group">
							  <div id="refer-container">
							    <input type="text" id="refer-input" placeholder="사원명 또는 이메일을 입력하세요" maxlength="50" />
							    <div id="autocomplete-list1" class="autoComplete" style="display:none; position:absolute;"></div>
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
							<label>파일 첨부</label>
						</td>
						<td>
		                    <!-- 파일 첨부 -->
							<div class="form-group">
							  <input type="file" name="files" id="upfile" class="form-control-file" multiple onchange="addFile();" />
							  <div id="file-list" class="file-list mt-2"></div> <!-- 파일 목록 표시 영역 -->
							</div>
							<span><small>첨부파일은 최대 5개까지 가능합니다.</small></span>
						</td>
					</tr>
					<tr>
						<td class="editor-td" colspan="2">
							<div id="div_editor">
							</div>
							<input type="hidden" name="content"/>
						</td>
					</tr>
					<tr>
						<td class="btnArea" colspan="2">
							<button type="button" class="btn btn-primary" onclick="history.go(-1);">
								<i class="fas fa-undo"></i> 취소
							</button>
							<button type="button" class="btn btn-secondary" onclick="sendMail(0)">
							    <i class="far fa-save"></i> 임시저장
							</button>
							<button type="button" class="btn btn-third" onclick="sendMail(1)">
							    <i class="fas fa-paper-plane"></i> 메일전송
							</button>
						</td>
						<!-- 0: 발송 1: 임시저장 -->
						<input type="hidden" name="status"/>
					</tr>
				</table>
			</form>
			
		</div>
 	</div>
</body>
<script>
/* 전역변수 */
var receiverList = []; // 수신자 데이터 저장용 배열

var emp_idx = ${empIdx}; // 작성자 사번
var receiver_idx = []; // 수신자 또는 참조자의 사번
var filesArr = []; // 첨부파일 데이터를 담을 배열

// 작성자 정보가져오기
empInfo(emp_idx, 2, 'sender');



// 사원 이메일, idx, 이름가져오기
// type 0: 받는사람, 1: 참조, 2: 작성자
function empInfo(inputVal, type, listContainerId) {
    // 변수 초기화
    var name = '';
    var email = '';
    var dataType = '';
    
    if (type !== 2) { // 받는사람 또는 참조자
        if (!validateEmail(inputVal)) {
            name = inputVal;
            dataType = 'name';
        } else {
            email = inputVal;
            dataType = 'email';
        }
    } else { // 작성자
        dataType = 'emp_idx';
    }
    
    $.ajax({
        url: 'empInfo.ajax',
        method: 'POST',
        dataType: 'JSON',
        data: { name, email, emp_idx, dataType },
        success: function(list) {
            if (list.length > 0) {
                if (type !== 2) { // 받는사람 또는 참조자인 경우
                    var $list = $("#autocomplete-list" + type);
                    $list.empty().show();
                    
                    // 이미 추가된 항목 제외
                    var filteredList = list.filter(function(item) {
                        return !receiverList.some(function(existingItem) {
                            return existingItem.email === item.email;
                        });
                    });

                    if (filteredList.length === 0) {
                        $list.hide(); // 필터링 후 표시할 항목이 없으면 리스트 숨기기
                        return;
                    }
                    
                    // 리스트 항목이 1개인 경우 자동 추가
                    if (filteredList.length === 1) {
                        var item = filteredList[0];
                        var newEntry = {
                            email: item.email,
                            type: type,
                            name: item.name,
                            emp_idx: item.emp_idx,
                        };

                        receiverList.push(newEntry);
                        addReceiverOrRefer(newEntry, listContainerId); // UI 업데이트
                        
                     	// 입력값 초기화
                        if(type == 0){  // 받는사람
                        	$("#receiver-input").val(""); 
                        }else if(type == 1){ // 참조자
                        	$("#refer-input").val(""); 
                        }
                        
                        $list.hide();
                        return;
                    }

                    // 필터링된 항목 리스트에 추가
                    filteredList.forEach(function(item) {
                        var $option = $("<div>")
                            .text(item.name + " <" + item.email + ">")
                            .data(item);

                        $option.on("click", function() {
                            var selected = $(this).data();
                            var newEntry = {
                                'email': selected.email,
                                'type': type,
                                'name': selected.name,
                                'emp_idx': selected.emp_idx
                            };

                            receiverList.push(newEntry);
                            addReceiverOrRefer(newEntry, listContainerId); // UI 업데이트

                            // 입력값 초기화
                            if(type == 0){  // 받는사람
                            	$("#receiver-input").val(""); 
                            }else if(type == 1){ // 참조자
                            	$("#refer-input").val(""); 
                            }
                            $list.hide();
                        });

                        $list.append($option);
                    });
                } else { // 작성자인 경우
                    var item = list[0];
                    $("#" + listContainerId + "_info").val(item.name + ' < ' + item.email + ' >');
                    $("#" + listContainerId + "_name").val(item.name);
                    $("#" + listContainerId + "_email").val(item.email);
                    $("#" + listContainerId + "_idx").val(item.emp_idx);
                }
            } else {
               /* alert("해당 사원을 찾을 수 없습니다."); */
                $("#autocomplete-list" + type).hide();
            }
        },
        error: function(e) {
            console.error("사원 정보 가져오기 중 오류 발생:", e);
        }
    });
}


		 


var config = {};
config.toolbar = "basic";
config.editorResizeMode = "none";


// 파일 업로드 핸들러 설정
config.file_upload_handler = function(file, pathReplace) {
    console.log(file);

    if (file.size > (1 * 1024 * 1024)) { // 파일 크기 제한 (1MB)
        modal.showAlert('2MB 이상의 파일은 올릴 수 없습니다.');
        pathReplace('/img/noimage.png');
    }
};

var editor = new RichTextEditor("#div_editor", config);






$("#receiver-input").on("keyup", function (e) {
    const inputVal = $(this).val().trim();
    
    // 최소 1글자 이상 입력된 경우에만 검색 수행
    if (inputVal.length >= 1) {
        empInfo(inputVal, 0, "receiver-list"); // 수신자 검색
    } else {
        $("#autocomplete-list0").hide(); // 글자수가 부족하면 자동완성 숨김
    }
});

$("#refer-input").on("keyup", function (e) {
    const inputVal = $(this).val().trim();
    
    // 최소 1글자 이상 입력된 경우에만 검색 수행
    if (inputVal.length >= 1) {
        empInfo(inputVal, 1, "refer-list"); // 참조자 검색
    } else {
        $("#autocomplete-list1").hide(); // 글자수가 부족하면 자동완성 숨김
    }
});

//작성자란 및 참조란에서 Enter 키 기본 동작 방지
$("#receiver-input, #refer-input").on("keydown", function (e) {
    if (e.key === "Enter") {
        e.preventDefault(); // 기본 동작(폼 제출) 방지
    }
});

$("#receiver-input, #refer-input").on("blur", function () {
    $(this).val(""); // 입력 필드 초기화
});


//전역 변수 선언
var receiverList = []; // 수신자 및 참조자 정보를 담을 배열

// 이메일 형식 확인 함수
function validateEmail(email) {
    return email.includes("@");
}

// 수신자 및 참조자 항목 추가
function addReceiverOrRefer(entry, listContainerId) {
	
    if (!entry || !entry.name || !entry.email) {
        return; // 잘못된 entry가 전달되면 함수 종료
    }else{
    	var displayText = entry.name + " <" + entry.email + ">";
    }
	
    
 // 항목 표시를 위한 텍스트 생성
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
	// receiverList를 JSON 문자열로 변환 후 hidden input에 설정
    const jsonData = JSON.stringify(receiverList);
    $("#receiver-data").val(jsonData);

    // 디버깅 로그 추가
    console.log("Receiver Data JSON:", jsonData);
}

// 수신자 및 참조자 추가 핸들러
function addReceiverOrReferHandler(input, listContainerId, type) {
    var inputVal, isObjectInput = typeof input === "object";

    if (isObjectInput) { // 사원목록에서 추가한 경우
        inputVal = input.email;
    } else { // 텍스트로 추가한 경우
        inputVal = $(input).val().trim();
    }

    // 입력값 유효성 검사
    if (inputVal === "") {
    	modal.showAlert("이름 또는 이메일을 입력하세요.");
        return;
    }

    // 중복 확인 (기존 receiverList 배열에서 중복 검사)
    var isDuplicate = receiverList.some(function (item) {
        return (
            item.name === inputVal || item.email === inputVal
        );
    });

    if (isDuplicate) {
    	modal.showAlert("이미 추가된 항목입니다.");
        return; // 중복 시 추가 중단
    }

    // 입력값 처리
    var newEntry;

    if (isObjectInput) { // 사원목록에서 추가한 경우
        newEntry = {
            'name': input.name,
            'email': input.email,
            'emp_idx': input.emp_idx,
            'type': type
        };

        // 배열에 추가
        receiverList.push(newEntry);
        console.log('receiverList : ', receiverList);

        // UI 업데이트
        addReceiverOrRefer(newEntry, listContainerId);

    } else { // 텍스트로 추가한 경우
        // 사원정보 가져오기
        empInfo(inputVal, type, listContainerId);
    }

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
function sendMail(status) {
    // RichTextEditor 내용 가져오기
    var content = editor.getHTMLCode();

    // 에디터 내용이 100MB 이상인 경우 처리
    if (content.length > 100 * 1024 * 1024) {
    	modal.showAlert("100MB 이상의 크기는 전송이 불가능합니다.");
        return;
    }

    // 에디터 내용을 hidden input 필드에 설정
    $('input[name="content"]').val(content);

    
    // 필수 항목 검증
    if (receiverList.length === 0) {
    	modal.showAlert("받는 사람 주소를 입력해 주세요.");
        return;
    }

    if ($('input[name="subject"]').val().trim() === "") {
        modal.showAlert("제목을 입력해 주세요.");
        return;
    }

    
 	// 메일의 상태를 hidden input 필드에 설정
    $('input[name="status"]').val(status);
    
    // 폼 전송
    $('form').submit();
}





var fileNo = 0; // 첨부파일 번호



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
    var maxFileSize = 50 * 1024 * 1024; // 50MB
    var attFileCnt = document.querySelectorAll('.filebox').length; // 기존 추가된 첨부파일 개수
    var remainFileCnt = maxFileCnt - attFileCnt; // 추가로 첨부가능한 개수
    var files = $('#upfile')[0].files; // 현재 선택된 첨부파일 리스트 FileList

    // 중복 파일 방지 확인
    let duplicateFiles = Array.from(files).filter(file => 
        filesArr.some(existingFile => existingFile.name === file.name && existingFile.size === file.size)
    );

    if (duplicateFiles.length > 0) {
        modal.showAlert("이미 추가된 파일이 있습니다: " + duplicateFiles.map(file => file.name).join(", "));
        return; // 중복된 파일이 있으면 추가를 중단
    }
    
    // 파일 크기 확인 및 제한 초과 처리
    let invalidFiles = Array.from(files).filter(file => file.size > maxFileSize);
    if (invalidFiles.length > 0) {
        modal.showAlert("첨부파일 크기는 최대 50MB까지 가능합니다: " + invalidFiles.map(file => file.name).join(", "));
        return; // 크기 초과 파일이 있으면 추가 중단
    }

    // 첨부파일 개수 확인
    if (files.length > remainFileCnt) {
        modal.showAlert("첨부파일은 최대 " + maxFileCnt + "개 까지 첨부 가능합니다.");
        return;
    }

    // 새로운 파일들을 배열에 추가
    let currFileArr = Array.from(files); // FileList => Array로 변환
    filesArr = filesArr.concat(currFileArr); // 기존 파일 배열에 새 파일 추가

    // 파일 상태를 업데이트 및 UI 갱신
    fileDataTransfer(); // FileList 업데이트
    renderingFileDiv(); // 추가 및 삭제할 때마다 목록 갱신
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

//파일 선택 이벤트 리스너
$("#upfile").on("change", function () {
	const dataTransfer = new DataTransfer();

    // filesArr의 모든 파일을 DataTransfer 객체에 추가
    filesArr.forEach(file => dataTransfer.items.add(file));

    // input 태그 파일 업데이트
    this.files = dataTransfer.files;

    // UI에 파일 목록 렌더링
    renderFileList();
});

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
function fileDataTransfer() {
    const dataTransfer = new DataTransfer();

    filesArr.forEach(function (file) {
        dataTransfer.items.add(file); // 배열의 파일들을 DataTransfer로 변환
    });

    $('#upfile')[0].files = dataTransfer.files; // FileList를 업데이트
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



//체크박스 상태에 따라 hidden input 값을 업데이트
function setSpecialFlag(checkbox) {
    if (checkbox.checked) {
        $("#hidden_special_flag").val("1");
    } else {
        $("#hidden_special_flag").val("0");
    }
}



</script>
</html>
