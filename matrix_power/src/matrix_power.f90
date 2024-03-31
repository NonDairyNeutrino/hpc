program allocatable
    use iso_fortran_env, only: real64
    use matrices
    use io
    implicit none
    ! variable declarations
    integer :: parameters(3)
    integer :: matrix_dimension
    integer :: power
    integer :: is_id
    real*16, allocatable :: matrix(:, :) ! TODO: figure out wtf is going on with the types
    real*16, allocatable :: matrix_power(:, :)
    ! loop iterators
    integer :: i
    integer :: j

    parameters       = get_parameters()
    matrix_dimension = parameters(1)
    power            = parameters(2)
    is_id            = parameters(3)
 
    allocate(matrix(matrix_dimension, matrix_dimension))
    if (is_id == 1) then
        ! make matrix identity
    else
        ! make matrix random
        call random_number(matrix) ! initialize matrix with random numbers
    end if


    allocate(matrix_power(matrix_dimension, matrix_dimension))
    matrix_power = matrix ! initialize matrix_power as the matrix itself.

    ! if power == 1, power_matrix == matrix
    if (power /= 1) then
        ! multiply the matrix by itself power times
        do i = 2, power
            matrix_power = matrix_product(matrix, matrix_power)
        end do
    end if

    ! print matrix_power to the screen
    call print_matrix(matrix_power)

    ! free memory used by matrices
    deallocate(matrix_power)
    deallocate(matrix)
end program allocatable

