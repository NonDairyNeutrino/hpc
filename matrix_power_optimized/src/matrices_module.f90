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
    function matrix_product(A, B, NUM_ROWS, NUM_COLS, NUM_SUM) result (C)
        implicit none
        ! DIMENSION DECLARATIONS
        integer, intent(in) :: NUM_ROWS, NUM_COLS, NUM_SUM
        ! ARRAY DECLARATIONS
        ! OPTIMIZATION: static arrays
        ! pass in array dimensions
        real(qp), intent(in) :: A(NUM_ROWS, NUM_SUM), B(NUM_SUM, NUM_COLS)
        ! OUTPUT DECLARATIONS
        real(qp) :: C(NUM_ROWS, NUM_COLS)
        ! ITERATOR DECLARATIONS
        integer :: i, j, k
        ! DUMMY DECLARATIONS
        real(qp) :: C_elem

        ! DECLARE SIZES
        ! OPTIMIZATION: predefine sizes to not access dimensions each loop iteration
        ! num_rows = size(A,1)
        ! num_cols = size(B,2)
        ! num_sum  = size(A,2) ! summation dimension is A columns and B rows
        
        ! ALLOCATE OUTPUT MEMORY
        ! allocate(C(num_rows, num_cols))

        ! MATRIX MULTIPLICATION
        ! OPTIMIZATION: Spatial Memory Caching
        ! Fortran is column-major so to take advantage of pre-fetching adjacent
        ! memory spaces, swap order of row and column loops
        do j = 1, NUM_COLS
            do i = 1, NUM_ROWS
                C_elem = 0
                do k = 1, NUM_SUM
                    C_elem = C_elem + A(i,k) * B(k,j)
                end do
                ! OPTIMIZATION: Indexing
                ! only write to matrix element once it's been calculated instead
                ! of indexing into the same place repeatedly reducing bounds
                ! checking from N^2 to 1
                C(i,j) = C_elem
            end do
        end do
    end function matrix_product

    !> @brief Calculate the power of a matrix
    !! @param[in] matrix The base matrix
    !! @param[in] power The power
    !! @return The matrix raised to the power
    function matrix_power(matrix, dim, power)
        implicit none
        integer,  intent(in) :: dim, power
        real(qp), intent(in) :: matrix(dim, dim)
        real(qp)             :: matrix_power(dim, dim)
        ! dummy variables
        integer :: i

        if (power == 1) then
            matrix_power = matrix
        else
            matrix_power = matrix ! initialize for shape
            do i = 2, power
                print '(A, I5, A, I5)', "Beginning power: ", i, "/", power
                matrix_power = matrix_product(matrix, matrix_power, dim, dim, dim)
            end do
        end if
    end function matrix_power
end module matrices
