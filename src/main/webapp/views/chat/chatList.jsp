<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<script src="https://kit.fontawesome.com/6282a8ba62.js"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="resources/css/chatList.css" rel="stylesheet" />

<style>
</style>
</head>
<body class="bg-theme bg-theme1">
	<jsp:include page="../main/header.jsp"></jsp:include>
	<div class="dashboard-body">

		<div class="naviPath bold f32 w100 tm2">
			<span style="var(- -primary-color);">메신져</span>
		</div>


		<div class="chat-controls">
			<button class="start-chat-button" onclick="openCreateChatModal();">
				<i class="fas fa-comment-alt"></i> 대화하기
			</button>
			<div class="searchbar">
				<input type="text" placeholder="검색"> <i
					class="fas fa-search"></i>
			</div>
		</div>


		<div class="messenger-container">
			<div class="line-box">
				<div class="sidebar">

					<!-- 참여중인 대화방 리스트 -->
					<!-- <div class="chat-item">
						<div class="chat-avatar">
							<img src="" alt="Avatar">
						</div>
						<div class="chat-details">
							<div class="chat-header">
								<span class="chat-title">
									대화방 리스트
								</span> 
								<span class="chat-time">
									해당 대화방 최신 메시지 시간
								</span>
							</div>
							<div class="chat-preview">
								해당 대화방 최신 메시지 내용 
							</div>
						</div>
					</div> -->


				</div>

				<!-- 사용자 리스트 -->
				<div class="member-list-wrapper">
					<div class="member-list">
						<div class="image-label-wrapper">
							<img src="" alt="이미지" class="custom-image">
							<!-- 사용자 프로필 사진 -->
							<span class="custom-label">
								<!-- 사용자 이름 -->
							</span>
						</div>
					</div>
				</div>


			</div>
		</div>
	</div>
</body>
<div id="createChatModal" class="modal" style="display: none;">
	<div class="modal-content">
		<span class="close" onclick="closeCreateChatModal();">&times;</span>
		<h3>대화방 생성</h3>
		<form id="createChatForm">
			<label for="chatSubject">대화방 제목</label> <input type="text"
				id="chatSubject" name="chatSubject" required>
			<button type="button" onclick="createChat();">대화방 생성</button>
		</form>
	</div>
</div>


<script>

$(document).ready(function() {
    $.ajax({
        type: "GET",
        url: "chatList.ajax",
        success: function(response) {
            if (response && response.length > 0) {
                var sidebar = $(".sidebar");
                sidebar.empty(); // 기존 내용 초기화
                response.forEach(function(chat) {
                    var chatItem =
                    	'<input type="hidden" class="chat-idx" value="' + chat.chat_idx + '">' +
                    	'<div class="chat-item" data-chat-idx="'+ chat.chat_idx +'" onclick="location.href=\'chat.go?chat_idx=' + chat.chat_idx + '\'">' +
                            '<div class="chat-avatar">' +
                                '<img src="" alt="Avatar">' +
                            '</div>' +
                            '<div class="chat-details">' +
                                '<div class="chat-header">' +
                                    '<span class="chat-title">' + chat.chat_subject + '</span>' +
                                    '<span class="chat-time"></span>' +
                                '</div>' +
                                '<div class="chat-preview">' +
                                    '<!-- 최신 메시지 내용 -->' +
                                '</div>' +
                            '</div>' +
                        '</div>';
                    sidebar.append(chatItem);
                });
            } else {
                $(".sidebar").html("<p>참여 중인 대화방이 없습니다.</p>");
            }
        },
        error: function() {
            alert("대화방 리스트를 불러오는 데 실패했습니다.");
        }
    });
});







	//모달 열기
	function openCreateChatModal() {
		document.getElementById('createChatModal').style.display = 'block';
	}

	// 모달 닫기
	function closeCreateChatModal() {
		document.getElementById('createChatModal').style.display = 'none';
	}

	function createChat() {
		const chatSubject = document.getElementById("chatSubject").value;

		if (!chatSubject.trim()) {
			alert("대화방 제목을 입력해주세요.");
			return;
		}

		$.ajax({
			type : "POST",
			url : "createChat.do",
			data : {
				chat_subject : chatSubject
			},
			success : function(response) {
				if (response.success) {
					alert("대화방이 생성되었습니다!");
					location.href = "chat.go?chatIdx=" + response.chatIdx; // 생성된 대화방으로 이동
				} else {
					alert("대화방 생성에 실패했습니다. 다시 시도해주세요.");
				}
			},
			error : function() {
				alert("서버와 통신 중 문제가 발생했습니다.");
			},
		});
	}
</script>
</html>