! intIO.f03: This program is made as a module to allow access to it and its methods for other programs.
! This program has two methods, readUnsorted and writeSorted.
! readUnsorted is used to read in a user defined unsorted file, find the size needed to allocate the list, and store the values within the list.
! it uses pass by refrence to modify the list within the function, and also returns the size of the file 
! writeSorted is used to write the sorted list into the a file called sortedNUM.txt
!Both of these functions have error handling to ensure operations are stopped if an issue arises such as an invalid file name

module intIO 
    implicit none
contains 
    integer function readUnsorted(unorderedList)
        implicit none 

        !declares intent for each variable 
        integer, dimension( : ), allocatable, intent(inout) :: unorderedList
        integer :: numLines, i, file_ioStat

        ! max sixe of char is 256 characters
        character(len = 256) :: fname, line 

        write(*, *) "Enter unordered file name: "
        read(*, *) fname

        numLines = 0
        fname = trim(fname)

        ! opens file specfied, file value set to one, file must exist, reading from file, check file status 
        ! if theres an issue with file access send out error message then terminate the program 
        open(unit = 1, file = fname, status = 'old', action = 'read', iostat = file_ioStat)
        if(file_ioStat .ne. 0) then 
            write(*, *) "Error: Issue with opening file access"
            write(*, *) "Ending program now ..."
            stop 
            return 
        end if


        ! used to read from file till either end of file or error
        do 
            ! reads the file input and finds the number of lines, used to determine list size
            ! exits do at end of file
            read(1, '(A)', iostat = file_ioStat) line
            if(file_ioStat < 0) then  ! handles when end of file is reached
                exit
            end if

            ! if an error occurs send out a error message and terminate program 
            if(file_ioStat > 0) then ! handles issues related to the read operation
                write(*, *) "Error: Issue with reading from file"
                write(*, *) "Ending program now ..."
                stop                
                return
            end if 

            numLines = numLines + 1
        end do

        ! retunr value: returns total amount of numbers(list size)
        readUnsorted = numLines

        !allocates space for the list based of number of integers in the file
        allocate(unorderedList(numLines))

        ! moves file pointer back to the beggining of the file
        rewind(1)
        
        ! reads from file and stores each integer within the array list
        do i = 1, numLines 
            read(1, *, iostat = file_ioStat) unorderedList(i)
            if(file_ioStat < 0) then 
                exit 
            end if 

            ! error checkign 
            if(file_ioStat > 0) then 
                write(*, *) "Error: Issue with read"
                write(*, *) "Ending program now ..."
                stop
                return 
            end if 
        end do 

        ! closes file access 
        close(1)       

    end function readUnsorted

    subroutine writeSorted(orderedList)
        implicit none

        !declares intent for each variable 
        integer, dimension( : ), allocatable, intent(inout) :: orderedList
        integer :: file_ioStat, i

        ! opens specified file, allows file to exist or be created, write access, checks file status 
        open(unit = 1, file = 'sortedNUM.txt', status = 'replace', action = 'write', iostat = file_ioStat)
        !error checking 
        if(file_ioStat .ne. 0) then 
            write(*, *) "Error: Issue with opening file access"
            write(*, *) "Ending program now ..."
            stop
            return 
        end if

        ! writes sorted list to file, one integer per line
        do i = 1, size(orderedList)
            write(1, '(I0)') orderedList(i)
        end do 

        ! closes file access 
        close(1)


    end subroutine writeSorted

end module intIO