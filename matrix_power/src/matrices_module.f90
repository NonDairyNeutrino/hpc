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
end module matrices
