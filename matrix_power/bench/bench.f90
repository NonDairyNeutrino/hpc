! use the ftllowing procedures to time calculations
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
!
! etime

!> @file bench.f90
!! @brief Benchmark matrix multiplication implementations
program bench
    implicit none
    integer        :: start_mclock, end_mclock
    integer        :: start_time8,  end_time8
    real           :: start_cpu,    end_cpu
    real           :: etime_array(2), etime_total

    character(255) :: cmd
    character(255) :: prog
    integer        :: i

    !> parse command line
    call get_command(cmd)
    prog = cmd(15:) ! 14 is the number of characters in './bench/bench '
    
    !> begin timing
    start_mclock = mclock()
    start_time8  = time8()
    call cpu_time(start_cpu)

    ! call execute_command_line(prog, wait=.true.)
    call sleep(5)

    end_mclock = mclock()
    end_time8  = time8()
    call cpu_time(end_cpu)
    call etime(etime_array, etime_total)

    print '(A, I4)',   "mclock time = ", end_mclock - start_mclock
    print '(A, I4)',   "time8  time = ", end_time8 - start_time8
    print '(A, F7.3)', "mclock time = ", end_cpu - start_cpu
    print '(A, F7.3, A, F7.3, A, F7.3)', &
    "etime user = ", etime_array(1), &
    " etime system = ", etime_array(2), &
    " etime total = ", etime_total

end program bench
