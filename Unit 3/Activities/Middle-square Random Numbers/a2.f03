program MiddleSquare 
    implicit none 
    integer, parameter :: n = 10
    double precision :: startSeed, seedTwo ! variables
    double precision :: seedSquared, midSquare ! function def
    double precision, dimension(n) :: randomArray ! array 
    integer :: i 

    call seedInput(startSeed)

    seedTwo = seedSquared(startSeed)
    randomArray(1) = midSquare(seedTwo) ! elements start at 1 in fortran 

    write(*, "(A, I10)") "First Random value is: ", INT(randomArray(1))

    ! generates and stores 9 additional random values 
    do i = 2, n ! i is current position 
        seedTwo = seedSquared(randomArray(i - 1))
        randomArray(i) = midSquare(seedTwo)
    end do

    write(*, *) "Random Values: "
    do i = 2, n
        write(*, "(A, I10)") "Random value is: ", INT(randomArray(i))
    end do



end program MiddleSquare 

! choose subroutine as it required I/O
subroutine seedInput(startSeed)
    implicit none
    double precision, intent(out) :: startSeed

    write(*, *) "Enter your six digit seed: "
    read(*, *) startSeed

    if(startSeed < 100000 .or. startSeed >999999) then 
        write(*, *) "Error: Seed must be a 6-digit number." 
        stop
    end if 

end subroutine seedInput

double precision function seedSquared(startSeed)
    implicit none 
    double precision, intent(in) :: startSeed

    seedSquared = startSeed**2

end function seedSquared

double precision function midSquare(seedTwo)
    implicit none 
    double precision :: holder
    double precision, intent(in) :: seedTwo

    holder =  seedTwo / 1000.0d0 ! removes last two digits 
    midSquare = mod(dble(int(holder)), 1000000.0d0)

    if (midSquare == 0) then 
        midSquare = 1
    end if

    if (midSquare == 0) then
        write(*, *) "Warning: Degeneration occurred, resetting to 1."
        midSquare = 1
    end if
end function midSquare