module io
    implicit none

contains

    function get_dimension() result (matrix_dimension)
        ! get user defined matrix dimension
        ! inputs: none
        ! outputs: matrix_dimension

        print *, "Matrix dimension: "
        read(*, *) matrix_dimension

        do while (matrix_dimension > 0)
            print *, "Please enter a positive integer"
            read(*,*) matrix_dimension
        end do
    end function get_dimension
    
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
end module io
