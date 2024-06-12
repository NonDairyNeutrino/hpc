program allocatable
implicit none

    call to_binary(13)

contains

    subroutine to_binary(n) !result (binary_list)
        implicit none
        ! inputs
        integer, intent(in) :: n
        ! output
        integer  :: binary_list(floor(log(real(n)) / log(2.)) + 1) ! with allocation later, could run into segfault
        ! other
        real     :: log2
        real     :: a
        integer  :: b, bound

        binary_list(:) = 0

        log2 = log(2.) ! 2. because log takes reals
        a = n
        b = floor(log(a) / log2)
        bound = modulo(n + 1, 2)

        do while (b > bound)
            print *, b
            binary_list(b + 1) = 1
            a = a - 2**b
            b = floor(log(a) / log2)
        end do
        ! binary_list(1) = 1
        print *, binary_list
    end subroutine
end program