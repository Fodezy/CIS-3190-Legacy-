! stackADT.f03: This program is made as a module to allow access to it and its methods for other programs.
! This program has a multiude of methods and also a type decleration. 
! It declares a stack with two integers, left and right
! Methods include: initStack which is used to initalize and set the stack 
! pop, which is used to pop the top elements off the stack, also has error checking for underflow 
! push, which is used to push new values onto the stack, also has error checking for overflow 
! clear, which clears all elements in the stack and sets everythin to zero
! isEmpty, which checks if the stack is empty, returns a boolean value

module stackADT
    implicit none
    type :: ADT_Stack
            integer :: left, right
    end type ADT_Stack
contains 

    !inperation for my stack design: [https://github.com/jake-87/fstack/blob/main/fstack.f90]

    function initStack(arraySize) result(stack)  ! returns stack 
        implicit none 
        integer, intent(in) :: arraySize
        type(ADT_Stack), dimension(:), allocatable :: stack

        ! allocate space for the stack based on log(n) where in is number of integers
        allocate(stack(arraySize))

        ! initializes all stack elements to be 0
        stack(:)%left = 0
        stack(:)%right = 0

    end function initStack

    subroutine pop(stack, popped_element, top_element)
        implicit none
        type(ADT_Stack), dimension(:), intent(inout) :: stack
        type(ADT_Stack), intent(inout) :: popped_element
        integer, intent(inout) :: top_element

        if(top_element == 0) then 
            write(*, *) "Stack underflow error, attempting to remove item but the stack is empty"
            write(*, *) "Ending program ..."
            stop
        else 
            popped_element = stack(top_element)
            top_element = top_element - 1  
        end if

    end subroutine pop

    subroutine push(stack, new_Element, top_element, arraySize)
        implicit none
        type(ADT_Stack), dimension(:), intent(inout) :: stack
        type(ADT_Stack), intent(inout) :: new_Element
        integer, intent(inout) :: top_element, arraySize

        if(top_element >= arraySize) then 
            write(*, *) "Stack overflow error, attempting to add item to a full stack"
            write(*, *) "Ending program ..."
            stop
        else 
            top_element = top_element + 1
            stack(top_element) = new_Element
        end if

    end subroutine push

    subroutine clear(stack, top_element)
        implicit none
        type(ADT_Stack), dimension( : ), intent(inout) :: stack
        integer, intent(inout) :: top_element

        top_Element = 0
        stack(:)%left = 0
        stack(:)%right = 0


    end subroutine clear

    integer function isEmpty(top_element)
        implicit none
        integer, intent(inout) :: top_element
         
        isEmpty = 0 ! set to false 

        if(top_Element == 0) then 
            isEmpty = 1 ! true 
        end if
    end function isEmpty

end module stackADT