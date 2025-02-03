! iqsort.f03: This program uses an iterative qucksort moddeled and enhanced from a pascal algorthim. 
! It implements a stack based approach to sort the content.
! The program reads an unsorted file filled with integers, stores them, sorts them, then writes them to a specified
! It also tracks how long iterative quicksort takes using cpu_time and prints the value to terminal 

program IQSORT
    ! allows access to reading and writing to file methods
    use intIO
    ! allows access to the stack and its methods 
    use stackADT
    implicit none

    ! creates dynamic and allocatable array 
    integer, dimension(:), allocatable :: unorderedList 
    integer :: size, topElement, maxSize
    type(ADT_Stack), dimension(:), allocatable :: myStack
    real :: start, end, time

    ! read in unsorted list and allocate space and set up the stack
    size = readUnsorted(unorderedList)
    maxSize = ceiling(log(real(size)))
    allocate(myStack(maxSize))
    myStack = initStack(maxSize)

    print *, "Starting iterative Sort"
    print *, "Starting Timer at 0 Second"

    ! starts timer 
    call cpu_time(start)
    ! starts the sorting process
    call iterativeQsort(unorderedList, myStack, maxSize, size)

    !ends timer
    call cpu_time(end)

    time = end - start

    print *, "Ending Timer at: ", time, " Second"

    topElement = 0

    ! writes sorted list to file
    call writeSorted(unorderedList)

    deallocate(unorderedList)
    deallocate(myStack)

    print *, "Finished iterative Sort"
    

contains

    subroutine iterativeQsort(unorderedList, myStack, maxSize, size)
        implicit none

        ! array to be sorted
        integer, dimension(:), intent(inout) :: unorderedList

        ! stack used to store subarray boundaries
        type(ADT_Stack), dimension(:), intent(inout) :: myStack

        ! maximum size used to check for stack overflow 
        integer, intent(inout) :: maxSize, size

        ! top_Element used to check for stack underflow and track current position
        integer :: top_Element_Pos, i, j, left, right, pivot, temp

        ! next elemnt to be pushed, and latest element popped
        type(ADT_Stack) :: new_Element, popped_Element

        ! Initialize stack with the full array bounds
        top_Element_Pos = 0
        new_Element%left = 1
        new_Element%right = size

        ! first call to push: used to put values onto the top of the stack
        call push(myStack, new_Element, top_Element_Pos, maxSize)

        ! process subarrays until the stack is empty
        do while (top_Element_Pos > 0)

            ! first call to pop: used to retrive values from top of the stack
            call pop(myStack, popped_Element, top_Element_Pos)
            left = popped_Element%left
            right = popped_Element%right

            do while (left < right)
                i = left
                j = right
                pivot = unorderedList((left + right) / 2)

                ! partition the subarray based around the pivot
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

                ! push the larger subarray onto the stack and continue working with the smaller subarray
                if ((j - left) < (right - i)) then
                    if (i < right) then
                        new_Element%left = i
                        new_Element%right = right
                        call push(myStack, new_Element, top_Element_Pos, maxSize)
                    end if
                    right = j
                else
                    if (left < j) then
                        new_Element%left = left
                        new_Element%right = j
                        call push(myStack, new_Element, top_Element_Pos, maxSize)
                    end if
                    left = i
                end if
            end do
        end do

    end subroutine iterativeQsort

end program IQSORT
