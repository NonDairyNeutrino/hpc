module io
    implicit none
    private
    public get_parameters
contains

    function get_dimension() result (matrix_dimension)
        ! get user defined matrix dimension
        ! inputs: none
        ! outputs: matrix_dimension
        integer :: matrix_dimension

        print *, "Matrix dimension: "
        read(*, *) matrix_dimension

        do while (matrix_dimension < 1)
            print *, "Please enter a positive integer"
            read(*,*) matrix_dimension
        end do
    end function get_dimension

    function get_power() result (power)
        ! get user defined matrix power
        ! inputs: none
        ! outputs: power
        integer :: power
    
         print *, "Power: "
         read(*, *) power

        do while (power < 1)
            print *, "Please enter a positive integer"
            read(*, *) power
        end do
    end function get_power

    function get_id() result (is_id)
        ! get whether or not the matrix is the identity
        ! inputs: none
        ! outputs: 
        character :: id_input
        integer   :: is_id

        ! check if identity matrix should be used
        print *, "Use identity matrix? (y/n) "
        read(*, *) id_input

        do while (id_input /= 'y' .and. id_input /= 'n')
            print *, "Please enter either 'y' or 'n'"
            read (*,*) id_input
        end do

        if (id_input == 'y') then
            is_id = 1
        else
            is_id = 0
        end if
    end function get_id

    function get_parameters() result (parameters)
        ! get all parameters
        ! inputs: none
        ! outputs: matrix dimension, matrix power, if the matrix should be the identity
        integer :: matrix_dimension
        integer :: power
        integer :: is_id
        integer :: parameters(3)

        matrix_dimension = get_dimension()
        power            = get_power()
        is_id            = get_id()
        parameters       = [matrix_dimension, power, is_id]
    end function get_parameters
end module io
