program IQSORT
    use intIO
    use stackADT
    implicit none
    integer, dimension( : ), allocatable :: unorderedList 

    integer, dimension(10) :: a 
    integer :: i, size, maxSize, topElement
    type(ADT_Stack), dimension(:), allocatable :: myStack

    size = readUnsorted(unorderedList)
    allocate(myStack(size))

    myStack = initStack(size)
    call iterativeQsort(unorderedList, myStack, size)
    topElement = 0


    print *, "Sorted Array:"
    do i = 1, size
        print *, unorderedList(i)
    end do
    call writeSorted(unorderedList)

contains 
    subroutine iterativeQsort(unorderedList, myStack, maxSize)
        implicit none

        ! decalres unorderedList as a 1 dimensional array, that can be changed within the subroutine 
        integer, dimension(:), intent(inout) :: unorderedList

        ! declares myStack type and can be changed within the subarray: is used to store the bound of the subarray 
        type(ADT_Stack), dimension( : ), intent(inout) :: myStack

        ! max size of the dynamic array, this value is used to check if you attempt to access an area out of bounds within the stack 
        integer, intent(inout) :: maxSize

        ! top_Element_Pos represents the current head/top element within the stack 
        integer :: top_Element_Pos

        ! both new_Element & popped_Element are used to store values from the subarray
        ! new_Element stores the new value being pushed onto the stack 
        ! popped_Element stores the most recent element that was popped from the stack 
        type(ADT_Stack) :: new_Element, popped_Element


        ! Left and Right represent the bounds of the subarray being sorted
        ! i and j represent the indexes positions used to traverse through the subarray and access its elements 
        integer :: i, j, left, right 

        ! pivot is used to partition the elements within the subarray into smaller or larger 
        ! a temporary variable used to swap betweeen to elements 
        integer :: pivot, temp 


        ! left and right are the bounds of the array
        top_Element_Pos = 0
        new_Element%left = 1 ! set left in stack to 1
        new_Element%right = maxSize! set right within the stack to max size found from the number of lines in the input file 
        call push(myStack, new_Element, top_Element_Pos, maxSize)

        ! this will check if the top element's position is empty
        ! if it is that means the values have all been sorted and will exit the loop
        ! if it's not empty it will continue to sort based on the instructions below
        do while(top_Element_Pos > 0)
            call pop(myStack, popped_Element, top_Element_Pos)
            left = popped_Element%left
            right = popped_Element%right 

            do while(left < right)
                i = left
                j = right
                pivot = unorderedList((left + right) / 2)

                do while(i <= j)
                    do while(unorderedList(i) < pivot) 
                        i = i + 1
                    end do 

                    do while(pivot < unorderedList(j)) 
                        j = j - 1
                    end do

                    if(i <= j) then 
                        temp = unorderedList(i)
                        unorderedList(i) = unorderedList(j)
                        unorderedList(j) = temp 
                        i = i + 1
                        j = j - 1
                    end if 
                end do

                if((j - left) < (right - 1)) then 
                    if(i < right) then 
                        new_Element%left = i
                        new_Element%right = right 
                        call push(myStack, new_Element, top_Element_Pos, maxSize)
                    end if 
                    right = j
                else 
                    if(left < j) then 
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