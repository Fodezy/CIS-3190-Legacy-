program IQSORT
    implicit none
    integer, dimension(10) :: a 
    integer :: i 
    a = (/45, 12, 89, 7, 56, 33, 98, 21, 5, 67/)

    call iterativeQsort(a)

    print *, "Sorted Array:"
    do i = 1, size(a)
        print *, a(i)
    end do

contains 
    subroutine iterativeQsort(a)
        implicit none

        integer, dimension(:), intent(inout) :: a 

        !-----------------------------------------------------
        ! initialize the variables and stack 
        integer, parameter :: m = 5

        integer :: i,j, l, r !index values 
        integer :: x, w ! integer
        integer :: s ! 0..m --> range

        type :: stack_Ind
            integer :: l, r ! index
        end type stack_Ind

        type(stack_Ind), dimension(m) :: stack !array of stack 

        s = 1 ! set s to 1

        ! left and right are the bounds of the array
        stack(1)%l = 1 ! set left in stack to 1
        stack(1)%r = 10 ! set right in stack to 10 

        !-----------------------------------------------------

        do while(s > 0)
            l = stack(s)%l
            r = stack(s)%r 
            s = s - 1

            do while(l < r)
                i = l
                j = r
                x = a((l + r) / 2)

                do while(i <= j)
                    do while(a(i) < x) 
                        i = i + 1
                    end do 

                    do while(x < a(j)) 
                        j = j - 1
                    end do

                    if(i <= j) then 
                        w = a(i)
                        a(i) = a(j)
                        a(j) = w 
                        i = i + 1
                        j = j - 1
                    end if 
                end do

                if((j - 1) < (r - 1)) then 
                    if(i < r) then 
                        s = s + 1
                        stack(s)%l = i 
                        stack(s)%r = r 
                    end if 
                    r = j
                else 
                    if(l < j) then 
                        s = s + 1
                        stack(s)%l = l 
                        stack(s)%r = j
                    end if 
                    l = i 
                end if
            end do
        end do
    end subroutine iterativeQsort


end program IQSORT