module stackADT
    implicit none
    type :: ADT_Stack
            integer :: left, right
    end type ADT_Stack
contains 

    function initStack(arraySize) result(stack)  ! returns stack 
        implicit none 
        integer, intent(in) :: arraySize
        type(ADT_Stack), dimension( : ), allocatable :: stack

        ! allocate space for the stack based on the number of integers from the input file
        allocate(stack(arraySize))

        ! initializes all stack elements to be 0
        stack( : )%left = 0
        stack( : )%right = 0

    end function initStack

    subroutine pop(stack, popped_element, top_element)
        implicit none
        type(ADT_Stack), dimension( : ), intent(inout) :: stack
        type(ADT_Stack), intent(inout) :: popped_element
        integer, intent(inout) :: top_element

        if(top_element < 0) then 
            write(*, *) "Stack underlow error, attempting to remove item but the stack is empty"
        else 
            popped_element = stack(top_element)
            top_element = top_element - 1  
        end if

    end subroutine pop

    subroutine push(stack, new_Element, top_element, arraySize)
        implicit none
        type(ADT_Stack), dimension( : ), intent(inout) :: stack
        type(ADT_Stack), intent(inout) :: new_Element
        integer, intent(inout) :: top_element, arraySize

        if(top_element > arraySize) then 
            write(*, *) "Stack overflow error, attempting to add item to a full stack"
        else 
            top_element = top_element + 1
            stack(top_element) = new_Element
        end if

    end subroutine push

end module stackADT