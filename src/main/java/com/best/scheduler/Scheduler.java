package com.best.scheduler;

import java.time.LocalDate;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.best.attendance.AttendanceService;
import com.best.calendar.CalendarService;

@EnableScheduling
@Component
public class Scheduler {
	
	Logger logger = LoggerFactory.getLogger(getClass());
    private final CalendarService calendarService;
    private final AttendanceService attendanceService;

    public Scheduler(CalendarService calendarService,AttendanceService attendanceService) {
        this.calendarService = calendarService;
    	this.attendanceService = attendanceService;
    }
	
	@Scheduled(cron = "0 0 0 1 1 *")//매년 1월 1일 00:00:00 에 실행
	public void insertHolidays() {
		calendarService.insertHolidays();
	}
	
	@Scheduled(cron = "0 0 6 ? * MON-FRI")
	public void executeExcludingHolidays() {
	    LocalDate today = LocalDate.now();
	    List<LocalDate> holidays = calendarService.getHolidayCalculate();

	    if (!holidays.contains(today)) {
	    	attendanceService.insertAttendance();
	    }
	    

	    
	}

}