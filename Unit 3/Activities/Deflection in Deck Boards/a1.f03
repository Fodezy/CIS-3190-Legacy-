program DeflectionIndeck
    implicit none 
    double precision :: D, P, L, E, I
    double precision deflection

    P = 100

    write(*, *) "Enter values for: L, E, and I" 
    read(*, *) L, E, I

    if(I <= 0) then 
        call Inertia(I)
    end if

    D = deflection(P, L, E, I)

    write(*, *) "Output D = ", D


! example of a function -- returns only one perameter and should be used for small and non complex tasks
end program DeflectionIndeck

 
    double precision function deflection(P, L, E, I)
        implicit none
        double precision, intent(in) :: P, L, E, I

        deflection = (P * L**3) / (48  * E * I)


end function deflection

! example of a subroutine -- does not directly return a value instead modifies values through pass by refrence 
! used when multiple values need to be modified and/or the task is more complex and/or input/output is required 
subroutine Inertia(I)
    implicit none 
    double precision, intent(out) :: I 
    double precision :: b, t

    write(*, *) "Enter values to find I: b, t"
    read(*, *) b, t 

    I = (b * t**3) / 12


end subroutine Inertia 