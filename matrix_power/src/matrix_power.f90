program allocatable
    implicit none
    ! variable declarations
    integer :: matrix_dimension
    real, allocatable :: matrix(:, :)
    real, allocatable :: matrix_power(:, :)
    character :: is_id
    integer :: power
    ! loop iterators
    integer :: i
    integer :: j

    ! get user defined matrix dimension
    print *, "Matrix dimension: " ! TODO: add error checking
    read(*, *) matrix_dimension
    ! allocate matrix memories
    allocate(matrix(matrix_dimension, matrix_dimension)) 
    allocate(matrix_power(matrix_dimension, matrix_dimension))
    
    ! get user defined power
    print *, "Power: "
    read(*, *) power

    do while (power < 1)
        print *, "Please enter a positive integer"
        read(*, *) power
    end do

    ! check if identity matrix should be used
    print *, "Use identity matrix? (y/n) " ! TODO: add error checking
    read(*, *) is_id
    
    if (is_id == 'y') then
        ! make matrix identity
    else
        ! make matrix random
    end if

    call random_number(matrix) ! initialize matrix with random numbers

    matrix_power = matrix ! initialize matrix_power as the matrix itself.

    ! multiply the matrix by itself power times
    do i = 1, power - 1
        matrix_power = matmul(matrix, matrix_power)
    end do

    ! print matrix_power to the screen
    do j = 1, matrix_dimension
        print *, matrix_power(j, :)
    end do

    ! free memory used by matrices
    deallocate(matrix_power)
    deallocate(matrix)
end program allocatable

