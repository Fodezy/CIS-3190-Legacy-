program RQSORT
    use intIO

    implicit none 
    integer, dimension( : ), allocatable :: unorderedList 
    integer :: size

    print *, "Starting recurise sort:"

    size = readUnsorted(unorderedList)

    ! inspiration and credit for recurive qsort: 
    ! https://www.geeksforgeeks.org/quick-sort-in-c/ 
    call quicksort(unorderedList, 1, size)
    
    call writeSorted(unorderedList)

    deallocate(unorderedList)


    contains 

    subroutine swap(a, b)
        implicit none
        integer, intent(inout) :: a, b 
        integer :: temp 

        temp = a 
        a = b 
        b = temp 
    end subroutine swap

    integer function partition(unorderedList, low, high) !int array, int, int
        implicit none 
        integer, dimension(:), intent(inout) :: unorderedList
        integer, intent(in) :: low, high 
        integer :: pivot, i, j

        pivot = unorderedList(low)
        i = low
        j = high 

        do while(i < j)

            do while(unorderedList(i) <= pivot .and. i <= high - 1)
                i = i + 1
            end do

            do while(unorderedList(j) > pivot .and. j >= low + 1)
                j = j - 1
            end do

            if(i < j) then
                call swap(unorderedList(i), unorderedList(j))
            end if
        end do 

        call swap(unorderedList(low), unorderedList(j))
        partition = j

    end function partition


    recursive subroutine quicksort(unorderedList, low, high) !int array, int, int 
        implicit none
        integer, dimension(:), intent(inout) :: unorderedList
        integer, intent(in) :: low, high 
        integer :: pi 

        if(low < high) then 
            pi = partition(unorderedList, low, high)

            call quicksort(unorderedList, low, pi - 1)
            call quicksort(unorderedList, pi + 1, high)

        end if
    end subroutine quicksort


end program RQSORT