program MTBF
    implicit none 
    integer, parameter :: n = 6
    integer :: totalComps, totalSurvival 
    integer, dimension(n) :: numComps, failTimes
    integer :: i
    double precision :: m
    totalComps = 0
    totalSurvival = 0


    write(*, *) "Enter the # of components that fails & time to failure (x6): "

    do i = 1, n
        read(*, *) numComps(i), failTimes(i)
    end do


    do i = 1, n 

        if(failTimes(i) .ne. 0) then
            totalSurvival = totalSurvival + (numComps(i) * failTimes(i))
        else   
            totalSurvival = totalSurvival + (numComps(i) * 4000)
        end if
        

        totalComps = totalComps + numComps(i)

    end do




    m = dble(totalSurvival) / dble(14)
    write(*, *) totalSurvival, " / ", 14
    write(*, "(A, F10.0)") "m = ", INT(m)



end program MTBF