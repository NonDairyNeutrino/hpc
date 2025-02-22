!> @file matrices_module.f90
!! @brief Functionality for common matrix operations
module matrices
    use, intrinsic :: iso_fortran_env, only : qp => real128
    implicit none
    public
    
contains
    !> @brief Print matrix to standard output
    !! @param[inout] A The matrix to be printed
    subroutine print_matrix(A)
        implicit none
        real(qp), intent(in) :: A(:,:)
        integer :: i
        do i = 1, size(A, 1)
            print *, A(i,:) ! print row by row
                            ! otherwise will print everything in one line
        end do
    end subroutine print_matrix

    !> @brief Multiply two matrices
    !! @param[in] A An NxM matrix
    !! @param[in] B An MxL matrix
    !! @return The product of the two input matrices
    function matrix_product(A, B) result (C)
        implicit none
        ! input declarations
        real(qp), intent(in) :: A(:,:)
        real(qp), intent(in) :: B(:,:)
        ! output declartions
        real(qp), allocatable:: C(:,:)
        ! iterator declarations
        integer :: i
        integer :: j
        integer :: k
        ! dummy variables
        integer :: d
        real    :: element

        d = size(A, 2) ! summation dimension is A columns and B rows
        allocate(C(size(A,1), size(B,2)))

        do i = 1, size(A, 1) ! loop through A rows
            do j = 1, size(B, 2) ! loop through B columns
                C(i,j) = sum([(A(i,k) * B(k,j), k = 1, d)])
            end do
        end do
    end function matrix_product

    !> @brief Calculate the power of a matrix
    !! @param[in] mat The base matrix
    !! @param[in] power The power
    !! @return The matrix raised to the power
    function matrix_power(mat, power)
        implicit none
        real(qp), intent(in) :: mat(:, :)
        integer,  intent(in) :: power
        real(qp)             :: matrix_power(size(mat, 1), size(mat, 2))
        ! dummy variables
        integer :: i
        if (power == 1) then
            matrix_power = mat
        else
            matrix_power = mat ! initialize for shape
            do i = 2, power
                print '(A, I5, A, I5)', "Beginning power: ", i, "/", power
                matrix_power = matrix_product(mat, matrix_power)
            end do
        end if
    end function matrix_power
end module matrices
