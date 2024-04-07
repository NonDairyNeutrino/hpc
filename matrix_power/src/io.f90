!> @file io.f90
!! @brief Module to define input and output functionality for matrix powers
module io
    implicit none
    public

contains

    !> @brief Interactively get user-defined matrix dimension
    !! @return User-defined matrix dimension
    function get_dimension() result (matrix_dimension)
        implicit none
        integer :: matrix_dimension

        print *, "Matrix dimension: "
        read(*, *) matrix_dimension !> Define matrix dimension from stdin

        !> Error checking to make sure input is a positive integer
        do while (matrix_dimension < 1)
            print *, "Please enter a positive integer"
            read(*,*) matrix_dimension
        end do
    end function get_dimension

    !> @brief Interactively get user-defined matrix power
    !! @return User-defined matrix power
    function get_power() result (power)
        implicit none
        integer :: power
    
         print *, "Power: "
         read(*, *) power

        do while (power < 1)
            print *, "Please enter a positive integer"
            read(*, *) power
        end do
    end function get_power

    !> @brief Interactively get whether or not the matrix should be diagonal
    !! @return 1 or 0 if the matrix is diagonal or not, respectively
    function get_id() result (is_id)
        implicit none
        character :: id_input
        integer   :: is_id

        !> check if identity matrix should be used
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

    !> @brief Interactively get user-defined parameters
    !! @return Array of parameters [matrix_dimension, matrix_power, is_id]
    function get_parameters_interactive() result (parameters)
        implicit none
        integer :: matrix_dimension
        integer :: power
        integer :: is_id
        integer :: parameters(3)

        matrix_dimension = get_dimension()
        power            = get_power()
        is_id            = get_id()
        parameters       = [matrix_dimension, power, is_id]
    end function get_parameters_interactive

    !> @brief Get parameters from command line arguments
    !! @return Array of parameters [matrix_dimension, matrix_power, is_id]
    function get_parameters_cli() result (parameters)
        implicit none
        ! get parameters from command line arguments
        ! inputs: none
        ! outputs: matrix_dimension, power, is_id
        character(len=4) :: args(3)
        integer          :: parameters(3)
        ! dummy variables
        integer :: i
        integer :: stat
        
        do i = 1, 3
            call get_command_argument(i, args(i))
        end do

        read(args, *, iostat=stat) parameters
        
    end function get_parameters_cli

end module io
