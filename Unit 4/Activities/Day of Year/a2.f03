program DayOfYear
    implicit none
    integer :: IYEAR, IDATE, MONTH, IDAY, L
    integer, dimension(3) :: I

    integer :: isLeapYear ! function definition 
    IYEAR = 0
    IDATE = 0


    do while (IDAY <= 31)

        write(*, *) "Enter values for YEAR and Day: "
        read(*, *) IYEAR, IDATE

        if(IDATE < 1 .or. IDATE > 366 .or. IYEAR < 0) then 
            call error(IYEAR, IDATE) 
        else if(IDATE <= 31) then 
            MONTH = 1
            IDAY = IDATE
            write(*, *) "Month/Day/Year", MONTH, IDAY, IYEAR
        end if
    end do

    L = 1
    if (isLeapYear(IYEAR, I) == 1) then 
        ! goto 20
    else if(isLeapYear(IYEAR, I) == 0) then 
        L = 0 
        if(IDATE > 365) then 
            call error(IYEAR, IDATE)
        else 
            !goto 20
        end if
    end if 

end program DayOfYear



subroutine error(IYEAR, IDATE)
    implicit none
    integer, intent(in) :: IDATE, IYEAR
    
    write(*, *)  "error with data? day/year: ", IDATE, IYEAR
    stop

end subroutine error

integer function isLeapYear(IYEAR, I)
    implicit none 
    integer, intent(in) :: IYEAR
    integer, intent(out) :: I

    I(1) = IYEAR/400 
    I(2) = IYEAR/100 
    I(3) = IYEAR/4 

    if(IYEAR - (I(1) * 400) <= 0 .or. IYEAR - (I(3) * 4)) then 
        isLeapYear = 1 ! goto 20  -- true 
    else if (IYEAR - (I(2) * 100  <= 0)) then 
        isLeapYear = 0! goto 10  -- false 
    end if 
end function isLeapYear



subroutine holder(IDATE, L) ! line 20
    implicit none 
    integer, intent(in) :: IDATE, L

    if(IDATE > (181 + L)) then 
        ! goto 181
    else if(IDATE > (90 + L)) then 
        ! goto 90
    else if(IDATE > (59 + L)) then 
        ! goto 59
    end if 

end subroutine holder
