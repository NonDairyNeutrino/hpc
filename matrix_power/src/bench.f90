! use the following procedures to time calculations
! mclock
! - Returns the number of clock ticks since the start of the process, based on the function clock(3) in the C standard library. 
! - RESULT = MCLOCK()
!
! time8
! - Returns the current time encoded as an integer (in the manner of the function time(3) in the C standard library)
! - RESULT = TIME8()
!
! cpu_time
! - Returns a REAL value representing the elapsed CPU time in seconds. This is useful for testing segments of code to determine execution time. 
! - CALL CPU_TIME(TIME)
! - program test_cpu_time
!    real :: start, finish
!    call cpu_time(start)
!        ! put code to test here
!    call cpu_time(finish)
!    print '("Time = ",f6.3," seconds.")',finish-start
!   end program test_cpu_time
!
! system_clock
!
! date_and_time
