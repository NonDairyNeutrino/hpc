program allocatable
    implicit none
    ! variable declarations
    integer :: matrix_dimension
    character :: is_id
    real, allocatable :: matrix(:, :)

    ! get user defined matrix dimension
    print *, "Matrix dimension: " ! TODO: add error checking
    read(*, *) matrix_dimension

    ! check if identity matrix should be used
    print *, "Use identity matrix? (y/n) " ! TODO: add error checking
    read(*, *) is_id
    
    if (is_id == 'y') then
        ! make matrix identity
    else
        ! make matrix random
    end if

    ! create initial matrix
    allocate(matrix(matrix_dimension, matrix_dimension)) 

    call random_number(matrix)
    print *, matrix

    deallocate(matrix)
    print *, "got through everything!"
end program allocatable

