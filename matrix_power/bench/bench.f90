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
! etime

!> @file bench.f90
!! @brief Benchmark matrix multiplication implementations
program bench
    implicit none

    !> timing variables
    integer        :: start_mclock, end_mclock
    integer        :: start_time8,  end_time8
    real           :: start_cpu,    end_cpu
    real           :: etime_array(2), etime_total

    !> command line parsing
    character(128) :: cmd
    character(128) :: prog
    character(32)  :: args(4) ! should always be "bin dimension power id_id" or "python python_script dimension power"
    integer        :: stat, matrix_dimension, power ! argument parsing

    !> file IO
    integer        :: io
    character(20)  :: file_path
    logical        :: exists

    !> loop iterators
    integer        :: i
    integer        :: arg_i

    !> parse command line
    call get_command(cmd)
    prog = cmd(15:) ! 14 is the number of characters in './bench/bench '
    
    do arg_i = 1, 4
        call get_command_argument(arg_i, args(arg_i))
    end do

    if (args(1) == "python") then
        read(args(3:4), *, iostat=stat) matrix_dimension, power
    else
        read(args(2:3), *, iostat=stat) matrix_dimension, power
    end if
    
    !> begin timing
    start_mclock = mclock()
    start_time8  = time8()
    call cpu_time(start_cpu)

    call execute_command_line(prog, wait=.true.)
    ! call sleep(5)

    end_mclock = mclock()
    end_time8  = time8()
    call cpu_time(end_cpu)
    call etime(etime_array, etime_total)

    print '(A, I4)',   "mclock time = ", end_mclock - start_mclock
    print '(A, I4)',   "time8  time = ", end_time8 - start_time8
    print '(A, F7.3)', "cpu_time time = ", end_cpu - start_cpu
    print '(A, F7.3, A, F7.3, A, F7.3)', &
    "etime user = ", etime_array(1), &
    " etime system = ", etime_array(2), &
    " etime total = ", etime_total

    file_path = "bench/benchmarks.csv"
    inquire(file = file_path, exist = exists) !> check if file exists

    if (exists) then
        ! write timings to file
        open(newunit = io, file = file_path, position = "append", &
            status = "old", action = "write")
            write(io, '(I6, ",", I6, ",", I6)') matrix_dimension, power, end_time8 - start_time8 ! only save time8 timings
        close(io)
    else
        ! create new file and write the header to the first line
        open(newunit = io, file = file_path, status = "new", action = "write")
        write(io, '("dimension,power,time(s)")')
        close(io)

        ! write timings to file
        open(newunit = io, file = file_path, position = "append", &
            status = "old", action = "write")
            write(io, '(I6, ",", I6, ",", I6)') matrix_dimension, power, end_time8 - start_time8 ! only save time8 timings
        close(io)
    end if
end program bench
