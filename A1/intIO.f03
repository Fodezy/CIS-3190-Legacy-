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
        integer, dimension( : ), allocatable, intent(inout) :: unorderedList
        integer :: numLines, i, file_ioStat
        character(len = 256) :: fname, line 

        write(*, *) "Enter unordered file name: "
        read(*, *) fname

        numLines = 0
        fname = trim(fname)

        open(unit = 1, file = fname, status = 'old', action = 'read', iostat = file_ioStat)
        if(file_ioStat .ne. 0) then 
            write(*, *) "Error: Issue with opening file access"
            write(*, *) "Ending program now ..."
            stop 
            return 
        end if


        do 
            read(1, '(A)', iostat = file_ioStat) line
            if(file_ioStat < 0) then  ! handles when end of file is reached
                exit
            end if

            if(file_ioStat > 0) then ! handles issues related to the read operation
                write(*, *) "Error: Issue with reading from file"
                write(*, *) "Ending program now ..."
                stop                
                return
            end if 

            numLines = numLines + 1
        end do

        readUnsorted = numLines

        allocate(unorderedList(numLines))

        rewind(1)
        
        do i = 1, numLines 
            read(1, *, iostat = file_ioStat) unorderedList(i)
            if(file_ioStat < 0) then 
                exit 
            end if 

            if(file_ioStat > 0) then 
                write(*, *) "Error: Issue with read"
                write(*, *) "Ending program now ..."
                stop
                return 
            end if 
        end do 

        close(1)       

    end function readUnsorted

    subroutine writeSorted(unorderedList)
        implicit none
        integer, dimension( : ), allocatable, intent(inout) :: unorderedList
        integer :: file_ioStat, i

        open(unit = 1, file = 'sortedNUM.txt', status = 'replace', action = 'write', iostat = file_ioStat)
        if(file_ioStat .ne. 0) then 
            write(*, *) "Error: Issue with opening file access"
            write(*, *) "Ending program now ..."
            stop
            return 
        end if

        do i = 1, size(unorderedList)
            write(1, '(I0)') unorderedList(i)
        end do 

        close(1)


    end subroutine writeSorted

end module intIO