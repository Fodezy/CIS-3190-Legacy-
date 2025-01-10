program triangle
    real :: a, b, c, theta

    write (*,*) 'Enter the length of the hypotenuse C: '
    read (*,*) c
    write (*,*) 'Enter the angle theta in degrees: '
    read (*,*) theta

    a = c * cos(theta)
    b = c * sin(theta)

    ! This will not work unless theta is converted from degrees to radians which can be done as follows

    ! --> real :: theta_rad, pi = 3.141592
    ! --> theta_rad = theta * pi / 180

    write (*,*) 'The length of the adjacent side is ', a
    write (*,*) 'The length of the opposite side is ', b
end program triangle
