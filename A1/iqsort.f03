program IQSORT
    use intIO
    use stackADT
    implicit none
    integer, dimension( : ), allocatable :: unorderedList 

    integer, dimension(10) :: a 
    integer :: i, size, maxSize, topElement
    type(ADT_Stack), dimension(:), allocatable :: myStack
    type(ADT_Stack) :: newElement, poppedElement

    a = (/45, 12, 89, 7, 56, 33, 98, 21, 5, 67/)
    maxSize = 10


    size = readUnsorted(unorderedList)
    allocate(myStack(size))

    myStack = initStack(size)
    call iterativeQsort(unorderedList, myStack, size)


    topElement = 0


   


    ! Test pushing items onto the stack
    ! print *, "Testing stack push:"
    ! do i = 1, size
    !     newElement%left = unorderedList(i)
    !     newElement%right = unorderedList(i) * 2
    !     call push(myStack, newElement, topElement, maxSize)
    ! end do

    ! ! Test popping items from the stack
    ! print *, "Testing stack pop:"
    ! do i = 1, size
    !     call pop(myStack, poppedElement, topElement)
    !     print *, "Popped: ", poppedElement%left, poppedElement%right
    ! end do


    print *, "Sorted Array:"
    do i = 1, size
        print *, unorderedList(i)
    end do
    call writeSorted(unorderedList)

contains 
    subroutine iterativeQsort(unorderedList, myStack, maxSize)
        implicit none

        integer, dimension(:), intent(inout) :: unorderedList
        type(ADT_Stack), dimension( : ), intent(inout) :: myStack
        integer, intent(inout) :: maxSize
        !-----------------------------------------------------
        ! initialize the variables and stack 
        integer :: top_Element
        type(ADT_Stack) :: new_Element, popped_Element

        integer, parameter :: m = 5

        integer :: i,j, l, r !index values 
        integer :: x, w ! integer
        integer :: s ! 0..m --> range

        type :: stack_Ind
            integer :: l, r ! index
        end type stack_Ind

        type(stack_Ind), dimension(m) :: stack !array of stack 

        ! s = 1 ! set s to 1

        ! left and right are the bounds of the array
        top_Element = 0
        new_Element%left = 1 ! set left in stack to 1
        new_Element%right = maxSize! set right in stack to 10 
        call push(myStack, new_Element, top_Element, maxSize)

        !-----------------------------------------------------

        do while(top_Element > 0)
            call pop(myStack, popped_Element, top_Element)
            l = popped_Element%left
            r = popped_Element%right 

            do while(l < r)
                i = l
                j = r
                x = unorderedList((l + r) / 2)

                do while(i <= j)
                    do while(unorderedList(i) < x) 
                        i = i + 1
                    end do 

                    do while(x < unorderedList(j)) 
                        j = j - 1
                    end do

                    if(i <= j) then 
                        w = unorderedList(i)
                        unorderedList(i) = unorderedList(j)
                        unorderedList(j) = w 
                        i = i + 1
                        j = j - 1
                    end if 
                end do

                if((j - l) < (r - 1)) then 
                    if(i < r) then 
                        new_Element%left = i
                        new_Element%right = r 
                        call push(myStack, new_Element, top_Element, maxSize)
                    end if 
                    r = j
                else 
                    if(l < j) then 
                        new_Element%left = i
                        new_Element%right = r 
                        call push(myStack, new_Element, top_Element, maxSize)
                    end if 
                    l = i 
                end if
            end do
        end do

    end subroutine iterativeQsort


end program IQSORT