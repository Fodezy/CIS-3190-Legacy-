program RadioactiveDecay
    
    integer :: T, N, time 
    real :: lambda, x, N0

    x = 2

    ! Input values
    write(*, *) "Enter value for T, N, time:"
    read(*, *) T, N, time

    ! finding value of lamda 
    lambda = log(x) / T

    ! N0 = N / exp(-lambda * time)

    ! or could be written as 

    N0 = N * exp(lambda * time)


    print "(A, F6.2)", 'Output: ', N0  ! formates output to two decimal places for real numbers

end program RadioactiveDecay
