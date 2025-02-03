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