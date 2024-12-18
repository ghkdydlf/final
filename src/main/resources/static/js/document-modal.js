$(document).ready(function () {
  	// 작성 버튼 클릭 시 모달 열기
	$(".editbtn").click(function () {
		$("#customModal").fadeIn(); // 모달 열기 (fade 효과)
 	});

  	// 화살표 뒤로가기
  	$(".far.fa-arrow-alt-circle-left").click(function() {
		$("#customModal").fadeOut();  // 뒤로가기 기능 실행
  	});
  
  
  	// 특정 항목 클릭 시 서버로 데이터를 요청하는 예시
	$('.modal-item').click(function() {
  		var formType = $(this).text(); // 클릭한 항목의 텍스트를 받아옴 (예: '휴가신청서')

// 서버로 AJAX 요청
  $.ajax({
    type: 'GET', // HTTP 요청 방식 (GET, POST 등)
    url: '/getFormTemplate', // 서버 URL
    data: { formType: formType }, // 서버로 전달할 데이터 (formType)
    dataType: 'json', // 응답 데이터 형식
    success: function(data) { // 요청 성공 시 실행되는 콜백 함수
      console.log(data); // 서버에서 받은 데이터 출력 (응답에 맞게 처리)
      displayFormInModal(data); // 응답 받은 데이터를 모달에 표시하는 함수 호출
    },
    error: function(xhr, status, error) { // 요청 실패 시 실행되는 콜백 함수
      console.log('Error: ' + error); // 오류 메시지 출력
    }
  });
});

// 모달에 양식 내용을 표시하는 함수
function displayFormInModal(data) {
  var modal = $('#formModal'); // 모달 요소
  modal.find('.modal-content').html(data.formContent); // 서버에서 받은 양식 내용을 모달에 삽입
  modal.show(); // 모달을 표시
}
  
});