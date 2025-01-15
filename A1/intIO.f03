module intIO 
    implicit none
contains 
    subroutine readUnsorted(unorderedList)
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
            write(*, *) "Error: Issue with file access"
            return 
        end if


        do 
            read(1, '(A)', iostat = file_ioStat) line
            if(file_ioStat < 0) then  ! handles when end of file is reached
                exit
            end if

            if(file_ioStat > 0) then ! handles issues related to the read operation
                write(*, *) "Error: Issue with read"
                return
            end if 

            numLines = numLines + 1
        end do

        allocate(unorderedList(numLines))

        rewind(1)
        
        do i = 1, numLines 
            read(1, *, iostat = file_ioStat) unorderedList(i)
            if(file_ioStat < 0) then 
                exit 
            end if 

            if(file_ioStat > 0) then 
                write(*, *) "Error: Issue with read"
                return 
            end if 
        end do 

        close(1) 

        write(*, *) "File size: ", numLines
        write(*, *) "Contents of the file: "
        
        do i = 1, numLines
            write(*, *) unorderedList(i)
        end do 

        close(1)         

    end subroutine readUnsorted

    subroutine writeSorted(unorderedList)
        implicit none
        integer, dimension( : ), allocatable, intent(inout) :: unorderedList
        integer :: file_ioStat, i

        open(1, file = 'sortedNUM.txt', status = 'replace', action = 'write')
        if(file_ioStat .ne. 0) then 
            write(*, *) "Error: Issue with file access"
            return 
        end if

        do i = 1, size(unorderedList)
            write(1, *, iostat = file_ioStat) unorderedList(i)
        end do 

        close(1)


    end subroutine writeSorted

end module intIO