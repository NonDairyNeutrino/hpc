!> @file main.f90
!! @brief Main program to calculate the power of a matrix
program allocatable
    use matrices
    use io
    use, intrinsic :: iso_fortran_env, only : qp => real128 !> use 128 bit floats
    implicit none

    !> variable declarations
    integer :: parameters(3)
    integer :: matrix_dimension
    integer :: power
    integer :: is_id
    logical :: bench
    real(qp), allocatable :: matrix(:, :)
    real(qp), allocatable :: power_matrix(:,:)

    !> loop iterators
    integer :: i
    integer :: j

    !> Get parameters from user
    parameters       = get_parameters_cli()
    matrix_dimension = parameters(1)
    power            = parameters(2)
    is_id            = parameters(3)
 
    !> create base matrix
    allocate(matrix(matrix_dimension, matrix_dimension))
    if (is_id == 1) then

        !> create a matrix with 2s along the diagonal
        do i = 1, matrix_dimension
            do j = 1, matrix_dimension
                if (i == j) then
                    matrix(i,j) = 2
                else
                    matrix(i,j) = 0
                end if
            end do
        end do
    else
        ! make matrix random
        call random_number(matrix) ! initialize matrix with random numbers
    end if

    !> create matrix power
    allocate(power_matrix(matrix_dimension, matrix_dimension))

    bench = .false. ! just for the time being
    if (bench) then
        ! begin timing here
        power_matrix = matrix_power(matrix, power)
        ! end timing here
    else
        power_matrix = matrix_power(matrix, power)
    end if

    !> print matrix_power to the screen
    call print_matrix(power_matrix)

    !> free memory used by matrices
    deallocate(power_matrix)
    deallocate(matrix)
end program allocatable

