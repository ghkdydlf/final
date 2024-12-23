<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/main.min.css" rel="stylesheet">
  <script src="/BEST/resources/js/index.global.js"></script>
  <script src="resources/jquery.twbsPagination.js"></script>
  <link rel="stylesheet" href="/BEST/resources/css/pagination.css">
  
  
  <style>
  :root{
      --primary-color: #30005A;
      --secondary-color: #8B6AA7;
      --accent-color: #E9396B;
   }
    .dashboard-body{
       margin-left: 14vw;
       width: 85vw;
       margin-top: 7vh;
       flex-wrap: wrap;
       padding: 2vh;
       color: var(--primary-color);
       border: 1px solid #00000000;
       height: 857px;
       display: flex;
       flex-direction: column;
       align-content:center;
       justify-content: center;
   }
   
/*  기본 css   */
	.title-name{
		display: block;
		position: absolute;
		top: 12%;
		left: 17%;
		width: 79%;
	}
	.title-line{
		width: 100%;
		height: 1px;
		background-color: #100f0f4a;
	}
    .btn-addRoom {
       	margin: 21px 0 0 40px;
      	font-size: 14px;
    }
    .material-container {
        width: 96%; 
        height: 85%;
        position: relative;
        top: 72px;
        background-color: #f8f9fa;
        padding: 15px;
        border: 1px solid #ddd;
    }
    .wrapper-container {
		float: left;
		width: 30%;
		height: 100%;
		background-color: #efbfbf;
    }
	/* 테이블 기본 스타일 */
	.materialInfo-table {
	    width: 100%; /* 테이블 전체 너비 */
	    border-collapse: collapse; /* 셀 경계선 겹침 */
	    margin: 0 0; /* 위아래 여백 */
	    font-size: 12px; /* 글씨 크기 */
	    text-align: left; /* 텍스트 왼쪽 정렬 */
	    height: 94%;
	}
	
	/* 테이블 헤더 스타일 */
	.materialInfo-table thead th {
	    background-color: #8B6AA7; /* 헤더 배경색 */
	    color: #30005A; /* 글씨 색 */
	    border: 1px solid #ddd; /* 헤더 보더 */
	    padding: 10px; /* 셀 내부 여백 */
	    border: none;
	}
	.material-title {
		font-size: 19px;
		font-weight: 700
	}
	#pagination .page-item.active a {
		font-size: 19px;
	}
	.materialInfo-table tr,td {
	    background-color: #f4f4f4; /* 헤더 배경색 */
	    color: #30005A; /* 글씨 색 */
	    border: 1px solid #ddd; /* 헤더 보더 */
	    padding: 10px; /* 셀 내부 여백 */
	    width: 100px;
	}
	.btn-del {
		margin:0 -37px 0 13px;
		
	}
	#pagination {
		height: 32px;
		margin: 0 0 0 0;
	}
	.btn-normal {
		background-color: #8B6AA7;
		color: white;
		border-radius: 10px;
		border: 2px solid #e6c9ff;
	}
	.btn-normal:hover {
		background-color: #6C0F6C;
	}
	#material-modal{
		display: none;
	}
	
/* 모달 기본 스타일 */
.material-modal {
    display: none; /* 기본적으로 숨김 */
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
}

/* 모달 콘텐츠 스타일 */
.material-modal-content {
    background-color: #fff;
    margin: 7% auto;
    padding: 20px;
    border: 1px solid #ccc;
    width: 15%;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    position: relative;
}

/* 닫기 버튼 */
.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
}

.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
}

/* 제목 스타일 */
.material-modal-content h3 {
    text-align: center;
    margin-bottom: 20px;
}

/* 테이블 스타일 */
.form-table {
    width: 100%;
    margin-bottom: 20px;
    border-collapse: collapse;
}

.form-table td {
    padding: 10px;
    vertical-align: middle;
}

td > label {
    font-weight: bold;
    width: 95px;
    color: #6C0F6C;
}

/* 입력 필드 스타일 */
input[type="text"],
input[type="number"] {
    width: 100%;
    padding: 0px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

/* 버튼 스타일 */
.button-area {
    text-align: center;
}

.btn-submit {
    background-color: #6C0F6C;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
}

.btn-submit:hover {
    background-color: #b31bb3;
}
.update-modal {
	display: none;
}
.delAlertModal {
	display: none;
}

/* alert 모달 */
.modal_alert {
    display: none; /* 기본적으로 숨김 */
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
}
.modal_container {
    background-color: #FFF5E2;
    margin: 7% auto;
    padding: 20px;
    border: 1px solid #FFF5E2;
    width: 10%;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    position: relative;
    display: flex;
    flex-direction: column;
    align-items:center;
}
.modal_body {
	color: #30005A;
}
.btn_confirm {
	background-color: #6C0F6C;
	color: #FFF5E2;
	border: 1px solid #6C0F6C;
	border-radius: 10px;
}
.differentColor {
	background-color: #E9396B;
	color: #FFF5E2;
	border: 1px solid #E9396B;
	margin: 0 0 0 10px;

}
.modal_footer {
	display: flex;
	width: 71%;
	height: 3%;
	margin: 7px 0 0 0;
}

/* 기자재 예약목록 css */
.wrapper-borrowContainer {
	width: 67%;
	background-color: #cfbdbd;
	height: 100%;
	display: flex;
	flex-direction: column;
	align-items: center;
}

	/* 테이블 기본 스타일 */
	.borrow-table {
	    width: 100%; /* 테이블 전체 너비 */
	    border-collapse: collapse; /* 셀 경계선 겹침 */
	    margin: 0 0; /* 위아래 여백 */
	    font-size: 12px; /* 글씨 크기 */
	    text-align: left; /* 텍스트 왼쪽 정렬 */
	    height: 94%;
	    display: flex;
	    flex-direction: column;
	    align-items:center;
	}
	
	/* 테이블 헤더 스타일 */
	.borrow-table thead th {
	    background-color: #8B6AA7; /* 헤더 배경색 */
	    color: #30005A; /* 글씨 색 */
	    border: 1px solid #ddd; /* 헤더 보더 */
	    padding: 10px; /* 셀 내부 여백 */
	    border: none;
	}
	#pagination .page-item.active a {
		font-size: 19px;
	}
	.borrow-table-table tr,td {
	    background-color: #f4f4f4; /* 헤더 배경색 */
	    color: #30005A; /* 글씨 색 */
	    border: 1px solid #ddd; /* 헤더 보더 */
	    padding: 10px; /* 셀 내부 여백 */
	    width: 100px;
	}
	
	/* 셀렉 옵션 과 p 그 윂퍼 */
	
/* Flexbox 스타일 */
.title-filter-container {
    display: flex; 
    align-items: center;
    justify-content: space-between; 
    margin-bottom: 10px; 
}

.borrow-title {
    font-size: 19px;
    font-weight: 700;
    margin: 0; 
    color: #30005A;
}

.filter-container {
    margin-left: auto; 
}

.filter-select {
    font-size: 14px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background-color: #ffffff00;
    color: #30005A;
    outline: none;
    cursor: pointer;
    margin: 0 0 0 21px;
}

.filter-select > option {
	background-color: #ffffff00 !important;
}





  </style>
  
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="title-name">
	    <h3>기자재 관리</h3>
	    <div class="title-line"></div>
	    <button class="btn-primary btn-addRoom" onclick="openModal()">기자재 등록</button>
	</div>
 	<div class="dashboard-body">
		<div class="material-container">
			<div class="wrapper-container">
				<p class="material-title">기자재 목록</p>
		            <table class="materialInfo-table">
		                <thead>
		                    <tr>
		                        <th>기자재 이름</th>
		                        <th>총 수량</th>
		                        <th>잔여 수량</th>
		                        <th>편집</th>
		                    </tr>
		                </thead>
		                <tbody id="materialTableBody">
		                	
		                </tbody>
			            <tr>
			               <th colspan="4">
			                  <div class="pagination-container">
			                      <nav aria-label="Page navigation">
			                          <ul class="pagination" id="pagination"></ul>
			                      </nav>
			                  </div>
			               </th>
			            </tr>
		            </table>
	         </div>
            
			<div class="wrapper-borrowContainer">
					<div class="title-filter-container">
					    <p class="borrow-title">기자재 예약 현황</p>
					    <div class="filter-container">
					        <!-- 반납 여부 필터 -->
					        <select id="returnStatusFilter" class="filter-select">
					            <option value="전체">전체</option>
					            <option value="반납완료">반납 완료</option>
					            <option value="미반납">미반납</option>
					        </select>
					    </div>
					</div>
					
		            <table class="borrow-table">
		                <thead>
		                    <tr>
					            <th>사원 이름(부서)(직급)(사원번호)</th>
					            <th>회의실 이름</th>
					            <th>예약일정</th>
					            <th>대여 기자재</th>
					            <th>반납 확인일자</th>
					            <th>반납 여부</th>
					            <th>반납 확인 사원</th>
					            <th>반납 처리</th>
		                    </tr>
		                </thead>
		                <tbody id="borrowTableBody">
		                	
		                </tbody>
			            <tr>
			               <th colspan="8">
			                  <div class="pagination-container">
			                      <nav aria-label="Page navigation">
			                          <ul class="pagination" id="paginationBorrow"></ul>
			                      </nav>
			                  </div>
			               </th>
			            </tr>
		            </table>
			</div>
		</div>
 	</div>

    <!-- 모달 창 -->
<div id="material-modal" class="material-modal">
    <div class="material-modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h3>기자재 추가</h3>
        <table class="form-table">
            <tr>
                <td><label for="material-name">기자재 이름:</label></td>
                <td><input id="material-name" class="material-name" type="text" placeholder="기자재 명을 입력하세요"></td>
            </tr>
            <tr>
                <td><label for="material-input">기자재 수량:</label></td>
                <td><input id="material-input" type="number" name="quantity" placeholder="수량 입력" class="quantity-input"></td>
            </tr>
        </table>
        <div class="button-area">
            <button class="btn-submit" onclick="saveMaterialInfo()">저장</button>
        </div>
    </div>
</div>

<div id="update-modal" class="update-modal material-modal">
    <div class="material-modal-content">
        <span class="close" onclick="closeUpdateModal()">&times;</span>
        <h3>기자재 수정</h3>
        <table class="form-table">
            <tr>
                <td><label for="material-name">기자재 이름:</label><input type="hidden" value="" class="hidden-materialIdx"></td>
                <td><span class="updateModalMaterialName">item.material_name</span></td>
            </tr>
            <tr>
                <td><label for="material-input">기자재 총수량:</label></td>
                <td><input id="updateTotalQuantity" type="number" name="quantity" placeholder="수량 입력" class="quantity-input"></td>
            </tr>
        </table>
        <div class="button-area">
            <button class="btn-submit" onclick="saveUpdateMaterialInfo()">저장</button>
        </div>
    </div>
</div>

  <!-- Alert Modal 삭제용 -->
  <div class="modal_alert delAlertModal" id="delAlertModal">
  	<input type="hidden" value="" class="delMaterialIdx">
    <div class="modal_container">
      <div class="modal_body">삭제 하시겠습니까?</div>
      <div class="modal_footer">
        <button class="btn_confirm" style="width: 100%;" onclick="delMaterial()">확인</button>
        <button class="btn_confirm differentColor" style="width: 100%;"onclick="closeDelAlertModal()">취소</button>
      </div>
    </div>
  </div>

 	
</body> 
<script>
var paginationBoolean= false;

if (!paginationBoolean) {
	var page = 1;
}

pageCall();

function pageCall(page) {
    $.ajax({
        type: 'POST',
        url: 'materialList.ajax',
        data: {
            'page': page,
            'cnt': 10
        },
        dataType: 'JSON',
        success: function(data) {
            console.log('AJAX 데이터:', data);

            if (data.list && data.list.length) {
                drawList(data.list);

                if (!paginationBoolean) {
                    $('#pagination').twbsPagination({
                        startPage: data.currentPage, 
                        totalPages: data.totalPages, 
                        visiblePages: 5, 
                        onPageClick: function(evt, page) {
                            pageCall(page); 
                        }
                    });
                    paginationBoolean = true; 
                }
            } else {
                noList();
            }
        },
        error: function(e) {
            console.log(e);
        }
    });
}

function drawList(list) {
    const listBody = $('#materialTableBody');
    listBody.empty(); // 기존 테이블 내용을 초기화

    list.forEach(function(item, index) {
    	const row = 
    	    '<tr>' +
    	        '<td>' + item.material_name + '</td>' +
    	        '<td>' + item.quantity + '</td>' +
    	        '<td>' + item.remain_quantity + '</td>' +
    	        '<td>' +
    	       		'<button class="btn-normal btn-update" onclick="openUpdateModal(' + item.material_idx + ', \'' + item.material_name + '\')">수정</button>' +
    	            '<button class="btn-normal btn-del" onclick="openDelAlertModal(' + item.material_idx + ')">삭제</button>' +
    	        '</td>' +
    	    '</tr>';
        listBody.append(row);
    });
}



function noList() {
    const listBody = $('#materialTableBody');
    listBody.empty();
    listBody.append('<tr><td colspan="4">기자재가 없습니다.</td></tr>');
}

function openModal() {
    document.getElementById("material-modal").style.display = "block";
}

function closeModal() {
    document.getElementById("material-modal").style.display = "none";
    document.getElementById("material-name").innerHTML= "";
    document.getElementById("material-input").innerHTML= "";
    
}

function saveMaterialInfo() {
    const materialName = document.getElementById("material-name").value;
    const materialQuantity = document.getElementById("material-input").value;
    const formData = new FormData();
    formData.append("materialName", materialName);
    formData.append("materialQuantity", materialQuantity);
    $.ajax({
        type: 'POST',
        url: 'saveMaterialInfo.ajax', 
        data: formData,
        processData: false, 
        contentType: false, 
        success: function(data) {
            alert(data.msg);
            closeModal();
        	pageCall(1);
        },
        error: function(error) {
            console.error('저장 실패:', error);
            alert('저장 중 오류가 발생했습니다.');
        }
    });
    
}

	/* 기자재 수정 버튼 함수 */
function openUpdateModal(materialIdx,materialName){
	document.getElementById("update-modal").style.display = "block";
	document.querySelector(".updateModalMaterialName").innerHTML=materialName;
	document.querySelector(".hidden-materialIdx").value=materialIdx;
}
 
function closeUpdateModal() {
    document.getElementById("update-modal").style.display = "none";
	document.querySelector(".updateModalMaterialName").innerHTML="";
	document.querySelector(".hidden-materialIdx").value="";
    document.getElementById("updateTotalQuantity").value = "";
    
}	

function saveUpdateMaterialInfo(){
    const materialIdx = document.querySelector(".hidden-materialIdx").value;
    const updateTotalQuantity = document.getElementById("updateTotalQuantity").value;
    const formData = new FormData();
    formData.append("materialIdx", materialIdx);
    formData.append("updateTotalQuantity", updateTotalQuantity);
	
    $.ajax({
        type: 'POST',
        url: 'saveUpdateMaterialInfo.ajax', 
        data: formData,
        processData: false, 
        contentType: false, 
        success: function(data) {
            alert(data.msg);
            closeUpdateModal();
        	pageCall(1);
        },
        error: function(error) {
            console.error('저장 실패:', error);
            alert('저장 중 오류가 발생했습니다.');
        }
    });
	
}

/* 삭제 함수 */
function openDelAlertModal(materialIdx){
	document.getElementById("delAlertModal").style.display = "block";
	document.querySelector(".delMaterialIdx").value=materialIdx;
	
}
function closeDelAlertModal(){
	document.getElementById("delAlertModal").style.display = "none";
	document.querySelector(".delMaterialIdx").value="";

}

function delMaterial(){
    const materialIdx = document.querySelector(".delMaterialIdx").value;
    const formData = new FormData();
    formData.append("materialIdx", materialIdx);

    $.ajax({
        type: 'POST',
        url: 'delMaterial.ajax', 
        data: formData,
        processData: false, 
        contentType: false, 
        success: function(data) {
            alert(data.msg);
            closeDelAlertModal();
        	pageCall(1);
        },
        error: function(error) {
            console.error('저장 실패:', error);
            alert('저장 중 오류가 발생했습니다.');
        }
    });
	
}


/* 최초 페이지 접근시 전체 기자재 예약 현황 리스트 함수 */
document.addEventListener("DOMContentLoaded", () => {
    loadBorrowList({ returnStatus: "전체" }); // 페이지 최초 로드 시 전체 데이터를 불러옴
});

document.getElementById("returnStatusFilter").addEventListener("change", (event) => {
    const returnStatus = event.target.value; 
    console.log(returnStatus);
    loadBorrowList({ returnStatus });
});

function loadBorrowList(filters) {
    console.log("요청 필터:", filters);
    $.ajax({
        type: 'POST',
        url: 'borrowList.ajax',
        data: JSON.stringify(filters),
        contentType: 'application/json; charset=UTF-8',
        dataType: 'json',
        success: function(data) {
        	if (data) {
	        	console.log("서버 응답 데이터:", data);
	            renderBorrowList(data);
			}
        },
        error: function(error) {
            console.error("데이터 로드 실패:", error);
        }
    });
}

function renderBorrowList(data) {
    const tbody = document.getElementById("borrowTableBody");
    tbody.innerHTML = ""; // 기존 데이터를 초기화
	

    data.forEach(item => {
        function formatDate(dateStr) {
            const date = new Date(dateStr);
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
            const hours = String(date.getHours()).padStart(2, '0');
            return year + '-' + month + '-' + day + ' ' + hours + ':00';
        }

        // 시작 날짜와 종료 시간 포맷팅
        const formattedStart = formatDate(item.start_datetime);
        const endTime = new Date(item.end_datetime).getHours().toString().padStart(2, '0') + ':00';
        console.log(formattedStart);
        console.log(endTime);

        // 버튼 동적 생성
        let buttonContent = '';
        if (item.flag == 0) {
            buttonContent = 
                '<button onclick="markAsReturned(' + item.borrow_idx + ')">반납</button> | ' +
                '<button onclick="confirmReturn(' + item.borrow_idx + ')">반납완료</button>';
        } else {
            buttonContent = '<span>반납 처리됨</span>';
        }

        // 동적으로 행(row) 생성
        const row = document.createElement("tr");
        
        row.innerHTML = 
            '<td>' + item.name + ' (' + item.depart_name + ') (' + item.rank_name + ') (' + item.emp_idx + ')</td>' +
            '<td>' + item.room_name + '</td>' +
            '<td>' + formattedStart.split(' ')[0] + ' ' + formattedStart.split(' ')[1] + ' - ' + endTime + '</td>' +
            '<td>' + item.material_with_quantity + '</td>' +
            '<td>' + item.confirmation_datetime + '</td>' +
            '<td>' + item.handler_emp_idx + '</td>' +
            '<td>' + (item.flag == 0 ? '미반납' : '반납완료') + '</td>' +
            '<td>' + (item.returnStatus || '') + '</td>' +
            '<td>' + (item.confirmedBy || '미확인') + '</td>' +
            '<td>' + buttonContent + '</td>';

        tbody.appendChild(row);
    });

}

function noListData(){
    const tbody = document.getElementById("borrowTableBody");
    tbody.innerHTML = ""; // 기존 데이터를 초기화
    tbody.innerHTML = '<tr class="nolist" ><td colspan="7">예약된 기자재가 없습니다.</td></tr>';
}

</script>
</html>





































