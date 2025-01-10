program WaveBreaking
implicit none

    double precision :: B, Hb, g, m, T
    g = 981

    write (*, *) "Enter values for m, Hb and T: "
    read (*, *)  m, Hb, T 

    B = Hb / (g * m * T**(2))

    print *, "Output: ", B

    if (B < 0.003) then 
        print *, "Surging"
    else if (B > 0.068) then 
        print *, "Spilling"
    else 
        print *, "Plunging"
    end if

end program WaveBreaking