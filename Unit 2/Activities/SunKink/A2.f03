program SunKink 
implicit none

    double precision :: a, linExp, newLength

    a = 10

    linExp = 11 * a**(-6)

    newLength = linExp * 300 * 60

    print *, "Value: ", newLength

end program SunKink