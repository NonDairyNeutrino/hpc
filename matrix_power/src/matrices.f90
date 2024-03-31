! define functions and subroutines to support matrix operations such as
! matrix multiplication
! matrix powers
! printing a matrix

module matrices
    implicit none
    public
    
contains
    ! print matrix to standard output
    subroutine print_matrix(A)
        real, intent(in) :: A(:,:)
        integer :: i
        do i = 1, size(A, 1)
            print *, A(i,:) ! print row by row
                        ! otherwise will print everything in one line
        end do
    end subroutine print_matrix

    ! multiply two matrices
    ! inputs: NxM matrix A, MxL matrix B
    ! outputs: NxL matrix C
    function matrix_product(A, B) result (C)
        implicit none
        ! input declarations
        real, intent(in) :: A(:,:)
        real, intent(in) :: B(:,:)
        ! output declartions
        real, allocatable:: C(:,:)
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
