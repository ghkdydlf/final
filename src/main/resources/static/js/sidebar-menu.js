document.addEventListener("DOMContentLoaded", function () {
    "use strict";

    // 모든 <a> 태그 클릭 이벤트 처리
    document.querySelectorAll("a").forEach(function (link) {
        link.addEventListener("click", function (e) {
            e.preventDefault(); // 기본 동작 방지
            const href = link.getAttribute("href");
            console.log(href); // 링크 주소 확인
            if (href) window.location.href = href; // 페이지 이동
        });
    });

    // URL에서 드롭다운 상태 읽기
    const urlParams = new URLSearchParams(window.location.search);
    const dropdownIndex = urlParams.get("dropdownIndex");
    const selectedIndex = urlParams.get("selectedIndex");

    // 페이지 로드 시 드롭다운 상태 복원
    if (dropdownIndex !== null) {
        const dropD = document.querySelectorAll(".dropD")[parseInt(dropdownIndex, 10)];
        if (dropD) {
            const dropMenu = dropD.querySelector(".dropD-menu");
            const icon = dropD.querySelector("a > .fa-solid");

            if (dropMenu) dropMenu.classList.add("show");
            if (icon) {
                icon.classList.remove("fa-angle-right");
                icon.classList.add("fa-angle-down");
            }
        }
    }

    // 페이지 로드 시 선택된 항목 복원
    if (selectedIndex !== null) {
        const selectedItem = document.querySelectorAll(".dropD-menu > li")[parseInt(selectedIndex, 10)];
        if (selectedItem) selectedItem.classList.add("selected");
    }

    // 드롭다운 클릭 이벤트
    document.querySelectorAll(".dropD").forEach(function (dropD, index) {
        dropD.addEventListener("click", function (e) {
            e.stopPropagation(); // 이벤트 전파 방지

            const dropMenu = dropD.querySelector(".dropD-menu");
            const icon = dropD.querySelector(".fa-solid");
            const isOpen = dropMenu && dropMenu.classList.contains("show");

            // 다른 드롭다운 초기화
            document.querySelectorAll(".dropD-menu").forEach(function (menu) {
                menu.classList.remove("show");
            });
            document.querySelectorAll(".fa-solid").forEach(function (icon) {
                icon.classList.remove("fa-angle-down");
                icon.classList.add("fa-angle-right");
            });

            // 현재 드롭다운 열기
            if (!isOpen && dropMenu) {
                dropMenu.classList.add("show");
                if (icon) {
                    icon.classList.remove("fa-angle-right");
                    icon.classList.add("fa-angle-down");
                }
            }

            // URL 쿼리 파라미터에 상태 저장
            const currentUrl = new URL(window.location.href);
            currentUrl.searchParams.set("dropdownIndex", index);
            window.history.replaceState({}, "", currentUrl); // URL 갱신
        });
    });

    // 드롭다운 내부 링크 클릭 이벤트
    document.querySelectorAll(".dropD-menu > li > a").forEach(function (link) {
        link.addEventListener("click", function (e) {
            e.preventDefault(); // 기본 동작 방지
            const listItem = link.closest("li");
            const dropdownIndex = Array.from(document.querySelectorAll(".dropD")).indexOf(listItem.closest(".dropD"));
            const selectedIndex = Array.from(document.querySelectorAll(".dropD-menu > li")).indexOf(listItem);

            // 모든 항목에서 selected 클래스 제거
            document.querySelectorAll(".dropD-menu > li").forEach(function (item) {
                item.classList.remove("selected");
            });

            // 현재 항목에 selected 클래스 추가
            if (listItem) listItem.classList.add("selected");

            // URL에 상태 저장
            const currentUrl = new URL(link.getAttribute("href"), window.location.href);
            currentUrl.searchParams.set("dropdownIndex", dropdownIndex);
            currentUrl.searchParams.set("selectedIndex", selectedIndex);
            window.location.href = currentUrl.toString(); // 페이지 이동
        });
    });

    // 외부 클릭 시 모든 드롭다운 닫기
    document.addEventListener("click", function () {
        document.querySelectorAll(".dropD-menu").forEach(function (menu) {
            menu.classList.remove("show");
        });
        document.querySelectorAll(".fa-solid").forEach(function (icon) {
            icon.classList.remove("fa-angle-down");
            icon.classList.add("fa-angle-right");
        });
    });

    // 사이드바 메뉴 초기화 함수
    function sidebarMenu(menu) {
        const animationSpeed = 300; // 애니메이션 속도
        const subMenuSelector = ".sidebar-submenu";

        menu.querySelectorAll("li > a").forEach(function (link) {
            link.addEventListener("click", function (e) {
                const checkElement = link.nextElementSibling;

                if (checkElement && checkElement.matches(subMenuSelector)) {
                    e.preventDefault(); // 기본 동작 방지

                    if (checkElement.style.display === "block") {
                        checkElement.style.display = "none";
                        checkElement.classList.remove("menu-open");
                        link.closest("li").classList.remove("active");
                    } else {
                        const parent = link.closest("ul");

                        // 다른 서브메뉴 닫기
                        parent.querySelectorAll(subMenuSelector).forEach(function (submenu) {
                            submenu.style.display = "none";
                            submenu.classList.remove("menu-open");
                        });

                        parent.querySelectorAll("li.active").forEach(function (activeLi) {
                            activeLi.classList.remove("active");
                        });

                        // 현재 서브메뉴 열기
                        checkElement.style.display = "block";
                        checkElement.classList.add("menu-open");
                        link.closest("li").classList.add("active");
                    }
                }
            });
        });
    }

    // 사이드바 메뉴 초기화
    const sidebar = document.querySelector(".sidebar-menu");
    if (sidebar) {
        sidebarMenu(sidebar);
    }
});

const chatParticipants = {}; // 참여자 목록 캐시

// 대화방 참여자 목록 가져오기
function fetchChatParticipants(chatIdx) {
    if (!chatParticipants[chatIdx]) {
        $.ajax({
            type: "GET",
            url: "chatParticipants.ajax",
            data: { chat_idx: chatIdx },
            dataType: "json",
            async: false, // 캐싱을 위한 동기 처리 (필요 시)
            success: function (participants) {
                chatParticipants[chatIdx] = participants.map(participant => participant.emp_idx);
            },
            error: function (xhr, status, error) {
                console.error("참여자 목록 가져오기 실패: ", error);
            }
        });
    }
}



/* 우측 하단 알림 메시지 */
function showNotification(photo, name, message, chatIdx, rank_name) {
    // 대화방 참여자 목록 가져오기
    if (!chatParticipants[chatIdx]) {
        fetchChatParticipants(chatIdx); // 참여자 목록이 없으면 로드
    }

    // 참여자인 경우에만 알림 표시
    if (chatParticipants[chatIdx]?.includes(loginId)) {
        const notification = $("#notification");

        // 알림 메시지 설정
        const notificationContent =
            '<div class="notification-profile">' +
                '<img src="/photo/' + photo + '" alt="프로필 사진" class="custom-image">' +
                '<div class="notifi-profile">' +
                    '<div>' + name + ' / ' + rank_name + '</div>' +
                    '<div>' + message + '</div>' +
                '</div>' +
            '</div>';

        notification.html(notificationContent);

        // 알림 클릭 시 채팅방으로 이동
        notification.off("click").on("click", function () {
            redirectToChat(chatIdx);
        });

        // 알림 표시
        notification.addClass("show");

        // 일정 시간 후 알림 숨김
        setTimeout(() => {
            notification.removeClass("show");
        }, 5000); // 5초 후 숨김
    }
}


/* 헤더 드롭 다운 */
document.addEventListener("DOMContentLoaded", function () {
    const dropdownToggles = document.querySelectorAll(".headerDropdownToggle");
    const dropdownMenus = document.querySelectorAll(".dropdownMenu");

    // 드롭다운 토글 클릭 시 열고 닫기
    dropdownToggles.forEach(function (toggle) {
        toggle.addEventListener("click", function (event) {
            event.stopPropagation(); // 이벤트 전파 방지
            const dropdownMenu = this.nextElementSibling; // 다음 요소를 찾아 열기/닫기
            dropdownMenus.forEach(function (menu) {
                if (menu !== dropdownMenu) {
                    menu.classList.remove("show");
                }
            });
            dropdownMenu.classList.toggle("show");
        });
    });

    // 드롭다운 외부 클릭 시 닫기
    document.addEventListener("click", function () {
        dropdownMenus.forEach(function (menu) {
            menu.classList.remove("show");
        });
    });
});

/* 헤더 메시지 알림 */
function updateMessageDropdown(photo, name, message, chatIdx, rank_name) {
    // 대화방 참여자 목록 가져오기
    if (!chatParticipants[chatIdx]) {
        fetchChatParticipants(chatIdx); // 참여자 목록이 없으면 로드
    }

    // 참여자인 경우에만 드롭다운 업데이트
    if (chatParticipants[chatIdx]?.includes(loginId)) {
        const messageDropdown = $(".messageDropdown");

        const messageItem =
            '<div class="dropdown-item" onclick="redirectToChat(' + chatIdx + ')">' +
                '<div class="notification-profile">' +
                    '<img src="/photo/' + photo + '" alt="프로필 사진" class="custom-image">' +
                    '<div class="notifi-profile">' +
                        '<div>' + name + ' / ' + rank_name + '</div>' +
                        '<div>' + message + '</div>' +
                    '</div>' +
                '</div>' +
            '</div>';

        messageDropdown.prepend(messageItem);

        // 최대 5개의 메시지만 유지
        if (messageDropdown.children().length > 5) {
            messageDropdown.children().last().remove();
        }
    }
}



/* 알림 메시지 채팅방 이동 */
function redirectToChat(chatIdx) {
    if (chatIdx) {
        window.location.href = 'chat.go?chat_idx=' + chatIdx;
    } else {
        console.error('채팅방 이동에 필요한 chatIdx가 없습니다.');
    }
}
/* 안 읽은 메시지 총 갯수 */
$(document).ready(function () {
    // 페이지 로드 시 호출
    $.ajax({
        type: 'GET',
        url: 'unreadTotal.ajax',
        success: function (totalUnreadCount) {
            const newMessageIndicator = $(".newMessageIndicator");

            // 기존 내용 초기화
            newMessageIndicator.empty();

            if (totalUnreadCount > 0) {
                // 읽지 않은 메시지가 있으면 표시
                newMessageIndicator.append(
                    '<div class="unread-count-list">' +
                        '<span class="unread-message-count">' + totalUnreadCount + '</span>' +
                    '</div>'
                ).css("display", "block");
                
                $("#newMessageIndicator3").css("display", "block");
            } else {
                // 읽지 않은 메시지가 없으면 숨김
                newMessageIndicator.css("display", "none");
                $("#newMessageIndicator3").css("display", "none");
            }
        },
        error: function (xhr, status, error) {
            console.error("AJAX 요청 실패: ", error);
        }
    });
});
/* 메시지 알림 */
$(document).ready(function () {
    const empIdx = loginId;

    // Ajax로 읽지 않은 메시지를 가져오기
    function loadUnreadMessages() {
        $.ajax({
            type: 'GET',
            url: 'msgAlarm.ajax',
            data: { emp_idx: empIdx },
            success: function (messages) {
                // 드롭다운 초기화
                const messageDropdown = $(".messageDropdown");
                messageDropdown.empty();

                if (messages.length === 0) {
                    // 메시지가 없을 때 표시
                    messageDropdown.append('<div class="dropdown-item"><div class="notification-profile"><i class="bi bi-chat-left-dots"></i> 새로운 메시지가 없습니다.</div></div>');
                    $("#newMessageIndicator3").css("display", "none"); // 알림 숨김
                } else {
                    // 메시지가 있을 때 추가
                    messages.reverse().forEach(function (message) {
                        updateMessageDropdown(
                            message.photo,
                            message.name,
                            message.content,
                            message.chat_idx,
                            message.rank_name
                        );
                    });

                    $("#newMessageIndicator3").css("display", "block"); // 알림 표시
                }
            },
            error: function (xhr, status, error) {
                console.error("AJAX 요청 실패: ", error);
            }
        });
    }

    // 페이지 로드 시 메시지 로드
    loadUnreadMessages();
});

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
        $('.profile-photo').html('<img src="/photo/' + photo + '" alt="프로필 사진">');

        // 이름과 직급
        const name = empDetail.name;
        const rankName = empDetail.rank_name;
        $('.user-Info > li:first-child').html(name + ' / ' + rankName);
        $('.user-Info > li:last-child').html(empDetail.email);

    }
});
