<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <link href="resources/css/dashBoard.css" rel="stylesheet"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
  <style>
#newMessageIndicator2 {
	background-color: #E9396B;
	border-radius: 50%;
	width: 20px;
	text-align: center;
	display: none;
	position: absolute;
	top: 7px;
    left: 159px;
}

.unread-message-count2 {
	color: #FFF5E2;
}


.iPhone::-webkit-scrollbar {
    display: none;
}

.iPhone {
    width: 17vw;
    height: 45vh;
    background-color: #30005A;
    border-radius: 10px;
    margin: 0;
    padding: 10px;
    font-family: Arial, sans-serif;
    color: white;
    text-align: center;
    overflow-y: auto; /* 스크롤 활성화 */
}

.current-weather {
    margin-bottom: 20px;
}

.current-weather h2 {
    font-size: 18px;
    margin: 5px 0;
}

.current-weather .temperature {
    font-size: 48px;
    font-weight: bold;
    margin: 10px 0;
}

.current-weather p {
    font-size: 14px;
    margin: 5px 0;
}

.hourly-weather, .weekly-weather {
    margin-top: 20px;
}

.hourly-weather h3, .weekly-weather h3 {
    font-size: 16px;
    font-weight: bold;
    margin-bottom: 10px;
}

.hourly-forecast {
  display: flex;
  gap: 10px;
  overflow: hidden; /* 스크롤바 숨김 */
  cursor: grab; /* 드래그 가능한 커서 표시 */
}

.hourly-forecast.active {
  cursor: grabbing; /* 드래그 중 커서 표시 */
}

.hour, .day {
  background: #8B6AA7;
  padding: 10px;
  border-radius: 10px;
  text-align: center;
  min-width: 80px;
}
.day{
  margin-bottom: 10px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.hour img, .day img {
  width: 40px;
  height: 40px;
}

.hour p, .day p {
  font-size: 12px;
  margin: 5px 0;
}





.temperature-bar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 57%;
    margin: 10px 0;
}

.min-temp, .max-temp {
    font-size: 14px;
    color: #fff;
    margin: 0 5px;
}

.bar {
    position: relative;
    flex-grow: 1;
    height: 10px;
    background: #30005A; /* 기본 바 색상 */
    border-radius: 5px;
    margin: 0 10px;
    overflow: hidden;
}

.fill {
    position: absolute;
    top: 0;
    bottom: 0;
    left: var(--start);
    right: calc(100% - var(--end));
    background: linear-gradient(to right, #FFF5E2, #E9396B); /* 색상 그라디언트 */
    border-radius: 5px;
}
#current-location{
	font-size: 20px;
}
  </style>
</head>
 <jsp:include page="../main/header.jsp"></jsp:include>
<body class="bg-theme bg-theme1">
 	<div class="dashboard-body">
 		<div class="dash-profile">
 		<div class="user-profile"></div>
 		<ul class="user-Info">
 			<li style="font-size:20px; font-weight:400;"></li>
 			<li class="user-Info-depart" style="color: #8B6AA7;"></li>
 		</ul>
 		<ul class="sidebar-menu">
 			<li>
 				<a href="#">
          			<i class="fa-regular fa-clipboard"></i> <span>결재 할 문서</span>
          			<i class="fa-solid fa-angle-right"></i>
        		</a>
 			</li>
 			<li>
 				<a href="#">
          			<i class="bi bi-envelope-fill"></i><span>새로운 메일</span>
          			<i class="fa-solid fa-angle-right"></i>
        		</a>
 			</li>
 			<li style="position: relative;">
 				<a href="chatList.go">
          			<i class="bi bi-chat-left-text-fill"></i> <span>새로운 메시지</span>
          			<i class="fa-solid fa-angle-right"></i>
        		</a>
        		<div id="newMessageIndicator2" class="newMessageIndicator">
        
    			</div>
 			</li>
 		</ul>
 	</div>
 	<div class="drive-info">
 		<div class="drive-info2"><span>현재 운행 정보</span></div>
 		<div class="drive-info3"> 		
 			
 		</div>
 	</div>
 	<div class="year-graph">
 		<div><span>연간 매출</span></div>
 		<div class="year-graph2">
 			<div>
 				<div class="year-graph3"></div><span>1월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>2월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>3월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>4월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>5월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>6월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>7월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>8월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>9월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>10월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>11월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>12월</span>
 			</div>
 		</div>
 	</div>
 	<div class="dash-calendar">
 	
 	</div>
 	<div class="todoList">
 		<div><span>To Do List!</span></div>
 		<div class="todoList2"></div>
 	</div>
 	<div class="road-info">
 		<div><span>오늘의 교통 정보</span></div>
 		<div>
 			<ul>
 				<li><span></span></li>
 				<li><span></span></li>
 			</ul>
 		</div>
 	</div>
 	<div class="iPhone">
  <div class="weather-app">
    <div class="current-weather">
      <img id="current-icon" src="" alt="날씨 아이콘">
      <p id="current-location"></p>
      <h1 id="current-temp"></h1>
      <p id="feels-like"></p>
      <p id="high-low"></p>
    </div>
    <div class="hourly-weather">
      <div id="hourly-container" class="hourly-forecast"></div>
    </div>
    <div class="weekly-weather">
      <div id="weekly-container" class="weekly-forecast"></div>
    </div>
  </div>
</div>
</div>
</body>
<script>
loginId = parseInt(loginId);

$(document).ready(function () {
    loadEmpDetail();

    function loadEmpDetail() {
        $.ajax({
            url: 'empDetail.ajax', 
            type: 'GET',
            dataType: 'json',
            data: { emp_idx: loginId }, 
            success: function (data) {
                updateUserInfo(data);
            },
            error: function () {
                alert('회원 정보를 가져오는데 실패했습니다.');
            }
        });
    }

    function updateUserInfo(empDetail) {
        // 프로필 사진
        const photo = empDetail.photo; // 사진이 없으면 기본 이미지
        $('.user-profile').html('<img src="/photo/' + photo + '" alt="프로필 사진">');

        // 이름과 직급
        const name = empDetail.name;
        const rankName = empDetail.rank_name;
        $('.user-Info > li:first-child').html(name + ' / ' + rankName);

        // 부서명
        const departName = empDetail.depart_name;
        $('.user-Info-depart').html(departName);
    }
});

$(document).ready(function () {
    // 페이지 로드 시 AJAX로 데이터 가져오기
    loadBusDetails();

    function loadBusDetails() {
        $.ajax({
            url: 'busDetail.ajax', // busSum 데이터를 반환하는 API
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                // busSum 데이터 가져와서 drive-info에 뿌리기
                updateDriveInfo(data.busSum);
            },
            error: function () {
                alert('버스 정보를 불러오는데 실패했습니다.');
            }
        });
    }

    function updateDriveInfo(busSum) {
        // 현재 운행 정보 초기화
        const driveInfoContainer = $('.drive-info3');
        driveInfoContainer.empty();

        // busSum 데이터를 순서대로 추가
        busSum.forEach(function (route) {
            const routeName = route.route_name || 'N/A';
            const totalBuses = route.total_buses || 0;
            const normalCount = route.normal_count || 0;
            const maintenanceCount = route.maintenance_count || 0;

            const html = 
                '<div class="bus-header">' +
                    '<div class="bus-main-info">' +
                        '<div style="width: 6.5vw;">' +
                            (routeName.length == 3 
                                ? '<span class="bus-number blue">' + routeName + '</span>' 
                                : '<span class="bus-number green">' + routeName + '</span>') +
                        '</div>' +
                        '<input type="hidden" name="route_name" value="' + routeName + '"/>' +
                        '<div class="bus-sum">' +
                            '<ul>' +
                                '<li><strong>총 버스 : </strong>' +
                                    '<span>' + totalBuses + '</span>' +
                                '</li>' +
                                '<li><strong>운행 가능 : </strong>' +
                                    '<span>' + normalCount + '</span>' +
                                '</li>' +
                                '<li><strong>정비 중 : </strong>' +
                                    '<span>' + maintenanceCount + '</span>' +
                                '</li>' +
                            '</ul>' +
                        '</div>' +
                    '</div>' +
                '</div>';
            driveInfoContainer.append(html);
        });
    }

});








$(document).ready(function () {
    const API_KEY = 'a0a9424fe3fb4874ba371725243012';
    const LOCATION = '37.477308,126.887745';
    const URL = 'https://api.weatherapi.com/v1/forecast.json';

    function fetchWeather() {
        $.ajax({
            url: URL,
            type: 'GET',
            dataType: 'json',
            data: {
                key: API_KEY,
                q: LOCATION,
                days: 3,
                aqi: 'no',
                alerts: 'no',
                lang: 'ko' // 언어를 한국어로 설정
            },
            success: function (data) {
                renderWeather(data);
            },
            error: function () {
                alert('날씨 정보를 불러오는데 실패했습니다.');
            }
        });
    }

    function renderWeather(data) {
        // 현재 날씨
        let locationName = data.location.name;

    // 서울을 한국어로 표시
    	if (locationName === "Seoul") {
        	locationName = "서울특별시";
    	}

    	$('#current-location').text(locationName);
        $('#current-temp').text(data.current.temp_c + '°');
        $('#current-condition').text(data.current.condition.text);
        $('#current-icon').attr('src', 'https:' + data.current.condition.icon); // 아이콘 경로 수정
        $('#feels-like').text('체감 온도: ' + data.current.feelslike_c + '°');
        $('#high-low').text(
            '최고: ' + data.forecast.forecastday[0].day.maxtemp_c + '° / 최저: ' + data.forecast.forecastday[0].day.mintemp_c + '°C'
        );

        // 시간별 날씨
        const hourlyContainer = $('#hourly-container');
        hourlyContainer.empty();
        data.forecast.forecastday[0].hour.forEach(function (hour, index) {
            if (index % 1 === 0) { // 3시간 간격
                hourlyContainer.append(
                    '<div class="hour">' +
                    '<p>' + hour.time.split(' ')[1] + '</p>' +
                    '<img src="https:' + hour.condition.icon + '" alt="weather icon">' +
                    '<p>' + hour.temp_c + '°C</p>' +
                    '</div>'
                );
            }
        });

        // 주간 예보
        const weeklyContainer = $('#weekly-container');
weeklyContainer.empty();
const minGlobal = -10; // 예상 최소 온도
const maxGlobal = 10; // 예상 최대 온도

// 오늘 날짜 확인
const todayDate = new Date().toISOString().split('T')[0];

data.forecast.forecastday.forEach(function (day) {
    const minTemp = day.day.mintemp_c;
    const maxTemp = day.day.maxtemp_c;
    const isToday = day.date === todayDate; // 오늘인지 확인
    const weatherIcon = day.day.condition.icon; // 날씨 아이콘 경로

    // 온도 백분율 계산
    const startPercent = ((minTemp - minGlobal) / (maxGlobal - minGlobal)) * 100;
    const endPercent = ((maxTemp - minGlobal) / (maxGlobal - minGlobal)) * 100;

    weeklyContainer.append(
        '<div class="day">' +
        '<p>' + (isToday ? '오늘' : new Date(day.date).toLocaleDateString('ko-KR', { weekday: 'short' })) + '</p>' +
        '<img src="https:' + weatherIcon + '" alt="날씨 아이콘" class="weather-icon">' + // 날씨 아이콘 추가
        '<div class="temperature-bar">' +
        '<span class="min-temp">' + minTemp + '°</span>' +
        '<div class="bar">' +
        '<div class="fill" style="--start: ' + startPercent + '%; --end: ' + endPercent + '%;"></div>' +
        '</div>' +
        '<span class="max-temp">' + maxTemp + '°</span>' +
        '</div>' +
        '</div>'
    );
});



    }

    fetchWeather();

    // 시간별 날씨 드래그 기능
    let isDown = false;
    let startX;
    let scrollLeft;

    const hourlyForecast = document.querySelector('.hourly-forecast');
    hourlyForecast.addEventListener('mousedown', (e) => {
        isDown = true;
        hourlyForecast.classList.add('active');
        startX = e.pageX - hourlyForecast.offsetLeft;
        scrollLeft = hourlyForecast.scrollLeft;
    });

    hourlyForecast.addEventListener('mouseleave', () => {
        isDown = false;
        hourlyForecast.classList.remove('active');
    });

    hourlyForecast.addEventListener('mouseup', () => {
        isDown = false;
        hourlyForecast.classList.remove('active');
    });

    hourlyForecast.addEventListener('mousemove', (e) => {
        if (!isDown) return;
        e.preventDefault();
        const x = e.pageX - hourlyForecast.offsetLeft;
        const walk = (x - startX) * 2; // 드래그 속도 조절
        hourlyForecast.scrollLeft = scrollLeft - walk;
    });
});


$(document).ready(function () {
    const API_URL = 'http://openapi.seoul.go.kr:8088/594172616a6a616e3931644566524c/xml/AccInfo/1/100';

    $.ajax({
        url: API_URL,
        type: 'GET',
        dataType: 'text', // XML 응답을 텍스트로 처리
        success: function (response) {
            // XML 파싱
            const parser = new DOMParser();
            const xmlDoc = parser.parseFromString(response, "application/xml");

            // API 응답 코드 확인
            const resultCodeElement = xmlDoc.getElementsByTagName("CODE")[0];
            if (!resultCodeElement || resultCodeElement.textContent.trim() !== "INFO-000") {
                const errorMessageElement = xmlDoc.getElementsByTagName("MESSAGE")[0];
                const errorMessage = errorMessageElement ? errorMessageElement.textContent : "알 수 없는 오류";
                alert("API 오류: " + errorMessage);
                return;
            }

            // row 데이터 추출 및 파싱
            const rows = xmlDoc.getElementsByTagName("row");
            const trafficData = [];
            for (let i = 0; i < rows.length; i++) {
                const row = rows[i];
                const dateElement = row.getElementsByTagName("occr_date")[0];
                const timeElement = row.getElementsByTagName("occr_time")[0];
                const infoElement = row.getElementsByTagName("acc_info")[0];

                // 날짜와 시간을 결합하여 정렬 가능한 데이터 생성
                const rawDate = dateElement ? dateElement.textContent.trim() : null;
                const rawTime = timeElement ? timeElement.textContent.trim() : null;
                const formattedDate = rawDate ? formatDate(rawDate) : "날짜 정보 없음";
                const formattedTime = rawTime ? formatTime(rawTime) : "시간 정보 없음";

                const dateTime = rawDate && rawTime ? rawDate + rawTime : null;

                trafficData.push({
                    datetime: dateTime || "000000000000", // 정렬을 위해 기본값 설정
                    date: formattedDate,
                    time: formattedTime,
                    info: infoElement ? infoElement.textContent.trim() : "정보 없음"
                });
            }

            // 최신순으로 정렬 (datetime 기준 내림차순)
            trafficData.sort((a, b) => b.datetime.localeCompare(a.datetime));

            // 데이터를 화면에 렌더링
            renderTrafficInfo(trafficData);
        },
        error: function (xhr, status, error) {
            console.error("AJAX 호출 오류:", xhr.status, status, error);
            console.error("응답 내용:", xhr.responseText);
            alert("API 호출 중 오류가 발생했습니다.");
        }
    });

 // 날짜를 "YYYY년 MM월 DD일" 형식으로 변환하는 함수
    function formatDate(rawDate) {
        const year = rawDate.substring(0, 4);
        const month = rawDate.substring(4, 6);
        const day = rawDate.substring(6, 8);
        return year + "년 " + month + "월 " + day + "일";
    }

    // 시간을 "HH시 MM분" 형식으로 변환하는 함수
    function formatTime(rawTime) {
        const hour = rawTime.substring(0, 2);
        const minute = rawTime.substring(2, 4);
        return hour + "시 " + minute + "분";
    }


    // 화면에 데이터를 렌더링하는 함수
    function renderTrafficInfo(trafficData) {
        const roadInfoContainer = $('.road-info > div:last-child');
        const ulElement = $('<ul></ul>');

        trafficData.forEach(function (info) {
            const listItem =
                '<li class="road-info-date">' +
                    '<span>' + info.date + ' ' + info.time + '</span>' +
                '</li>' +
                '<li class="road-info-detail">' +
                    '<span>' + info.info + '</span>' +
                '</li>';

            ulElement.append(listItem);
        });

        // 기존 데이터를 초기화하고 새 데이터를 추가
        roadInfoContainer.empty();
        roadInfoContainer.append(ulElement);
    }
});






</script>
</html>
