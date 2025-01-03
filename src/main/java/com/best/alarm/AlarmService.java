package com.best.alarm;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.best.mail.MailReceiveDTO;
import com.best.mail.MailSendDTO;
import com.best.websocket.GlobalWebsocketHandler;

@Service
public class AlarmService {
	
	private MailSendDTO storedSender;
	private List<MailReceiveDTO> storedReceivers;
	@Autowired AlarmDAO alarmDAO;

	public List<AlarmDTO> alarmList(int emp_idx, String type, Integer flag, int offset, int limit) {
	    return alarmDAO.alarmList(emp_idx, type, flag, offset, limit);
	}

	public int getTotalAlarmCount(int emp_idx, String type, Integer flag) {
	    return alarmDAO.getTotalAlarmCount(emp_idx, type, flag);
	}

	// 발신자 데이터를 저장
	public void processSenderData(MailSendDTO sender) {
	    if (sender == null) {
	        throw new IllegalArgumentException("발신자 데이터가 유효하지 않습니다.");
	    }
	    this.storedSender = sender;
	    checkAndBroadcast();
	}

	// 수신자 데이터를 저장
	public void processReceiverData(List<MailReceiveDTO> receivers) {
	    if (receivers == null || receivers.isEmpty()) {
	        throw new IllegalArgumentException("수신자 데이터가 유효하지 않습니다.");
	    }
	    this.storedReceivers = receivers;
	    checkAndBroadcast();
	}

	// 발신자와 수신자 데이터가 모두 준비되었을 때 알림 실행
	private void checkAndBroadcast() {
	    if (storedSender != null && storedReceivers != null) {
	        insertAlarmAndBroadcast(storedSender, storedReceivers);
	        clearStoredData(); // 저장된 데이터를 초기화
	    }
	}

	// 저장된 데이터 초기화
	private void clearStoredData() {
	    this.storedSender = null;
	    this.storedReceivers = null;
	}


	private void insertAlarmAndBroadcast(MailSendDTO sender, List<MailReceiveDTO> receivers) {
	    for (MailReceiveDTO receiver : receivers) {
	        AlarmDTO alarm = new AlarmDTO();
	        alarm.setEmp_idx(receiver.getReceiver_idx());
	        alarm.setType("mail");
	        alarm.setContent("<i class=\"bi bi-send\"></i> " + sender.getSender_name() + "님 으로부터 새로운 메일이 도착했습니다.");
	        alarm.setDate(new Date());

	        // 알림 저장
	        alarmDAO.insertAlarm(alarm);

	        // WebSocket 브로드캐스트 실행
	        GlobalWebsocketHandler.broadcastNewMail(
	            receiver.getReceiver_idx(),
	            alarm.getContent(),
	            alarm.getType() // type 전달
	        );
	    }
	}

    
    
    public void sendAlarms(List<AlarmDTO> alarms) {
        for (AlarmDTO alarm : alarms) {
            // 알림 저장
            alarmDAO.insertAlarm(alarm);

            // WebSocket 브로드캐스트
            GlobalWebsocketHandler.broadcastNewMail(
                alarm.getEmp_idx(),
                alarm.getContent(),
                alarm.getType() // type 전달
            );
        }
    }

    
    public void sendUpcomingEventAlarms() {
        // 회의실 예약 일정 가져오기
        List<Map<String, Object>> upcomingRoomEvents = alarmDAO.getUpcomingEvents();
        // 일반 캘린더 일정 가져오기
        List<Map<String, Object>> upcomingCalendarEvents = alarmDAO.getUpcomingCalendarEvents();

        // 회의실 예약 일정 알림 처리
        sendEventAlarms(upcomingRoomEvents, "reserve");

        // 일반 캘린더 일정 알림 처리
        sendEventAlarms(upcomingCalendarEvents, "calendar");
    }

    private void sendEventAlarms(List<Map<String, Object>> events, String eventType) {
        for (Map<String, Object> event : events) {
            int empIdx = (int) event.get("employeeId");
            String subject = (String) event.get("subject");
            String content = "<i class=\"bi bi-alarm-fill\"></i> 등록 된 " + subject + " 일정 10분 전 입니다.";

            // 알림 DTO 생성
            AlarmDTO alarm = new AlarmDTO();
            alarm.setEmp_idx(empIdx);
            alarm.setType(eventType.toLowerCase());
            alarm.setContent(content);
            alarm.setDate(new Date());

            // 알림 저장
            alarmDAO.insertAlarm(alarm);

            // WebSocket 브로드캐스트
            GlobalWebsocketHandler.broadcastNewMail(empIdx, content, eventType.toLowerCase());
        }
    }

    
    public void updateAlarmFlag(int alarm_idx, int flag) {
        alarmDAO.updateAlarmFlag(alarm_idx, flag);
    }

	public List<Map<String, Object>> unreadAlarm(int emp_idx) {
		return alarmDAO.unreadAlarm(emp_idx);
	}

}
