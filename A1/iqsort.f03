program IQSORT
    use intIO
    use stackADT
    implicit none

    integer, dimension(:), allocatable :: unorderedList 
    integer :: size, topElement, maxSize
    type(ADT_Stack), dimension(:), allocatable :: myStack

    ! Read unsorted list and allocate & initialize the stack
    size = readUnsorted(unorderedList)
    maxSize = ceiling(log(real(size))/log(2.0))
    allocate(myStack(maxSize))
    myStack = initStack(maxSize)

    print *, "Startign iterative Sort"

    call iterativeQsort(unorderedList, myStack, maxSize)
    topElement = 0

    call writeSorted(unorderedList)

    deallocate(unorderedList)
    deallocate(myStack)

    print *, "Finished iterative Sort"
    

contains

    subroutine iterativeQsort(unorderedList, myStack, maxSize)
        implicit none

        ! Input/Output array to be sorted
        integer, dimension(:), intent(inout) :: unorderedList

        ! Stack used to store subarray boundaries
        type(ADT_Stack), dimension(:), intent(inout) :: myStack

        ! Maximum size (used for bounds checking)
        integer, intent(inout) :: maxSize

        integer :: top_Element_Pos, i, j, left, right, pivot, temp
        type(ADT_Stack) :: new_Element, popped_Element

        ! Initialize stack with the full array bounds
        top_Element_Pos = 0
        new_Element%left = 1
        new_Element%right = maxSize
        call push(myStack, new_Element, top_Element_Pos, maxSize)

        ! Process subarrays until the stack is empty
        do while (top_Element_Pos > 0)
            call pop(myStack, popped_Element, top_Element_Pos)
            left = popped_Element%left
            right = popped_Element%right

            do while (left < right)
                i = left
                j = right
                pivot = unorderedList((left + right) / 2)

                ! Partition the subarray around the pivot
                do while (i <= j)
                    do while (unorderedList(i) < pivot)
                        i = i + 1
                    end do
                    do while (pivot < unorderedList(j))
                        j = j - 1
                    end do
                    if (i <= j) then
                        temp = unorderedList(i)
                        unorderedList(i) = unorderedList(j)
                        unorderedList(j) = temp
                        i = i + 1
                        j = j - 1
                    end if
                end do

                ! Push the larger subarray onto the stack and continue with the smaller
                if ((j - left) < (right - 1)) then
                    if (i < right) then
                        new_Element%left = i
                        new_Element%right = right
                        call push(myStack, new_Element, top_Element_Pos, maxSize)
                    end if
                    right = j
                else
                    if (left < j) then
                        new_Element%left = i
                        new_Element%right = right
                        call push(myStack, new_Element, top_Element_Pos, maxSize)
                    end if
                    left = i
                end if
            end do
        end do

    end subroutine iterativeQsort

end program IQSORT
