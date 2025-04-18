IDENTIFICATION DIVISION.
PROGRAM-ID. STATMOLD.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.

FILE-CONTROL.
    SELECT INPUT-FILE ASSIGN TO "input.txt"
        ORGANIZATION IS LINE SEQUENTIAL.
    SELECT OUTPUT-FILE ASSIGN TO "output.txt"
        ORGANIZATION IS LINE SEQUENTIAL.

DATA DIVISION.
FILE SECTION.
FD INPUT-FILE.
01 INPUT-RECORD.
 02 INPUT-X PIC S9(6)V9(2).
 02 FILLER PIC X(72).
 *> totals to 80 characters 

FD OUTPUT-FILE.
01 OUTPUT-LINE PIC X(80).


WORKING-STORAGE SECTION.
77 SUM-OF-X-SQR PIC 9(14)V9(2).
77 SUM-OF-X PIC S9(10)V9(2).
77 N PIC S9(4).
77 MEAN PIC S9(6)V9(2).
77 I PIC S9(4).

01 ARRAY-AREA.
 02 X PIC S9(6)V9(2) OCCURS 1000 TIMES.

01 INPUT-VALUE-RECORD.
 02 IN-X PIC S9(6)V9(2).
 02 FILLER PIC X(72).

01 OUTPUT-TITLE-LINE.
 02 FILLER PIC X(28) VALUE
 " MEAN AND STANDARD DEVIATION".

01 OUTPUT-UNDERLINE.
 02 FILLER PIC X(28) VALUE
 "----------------------------".

01 OUTPUT-COL-HEADS.
 02 FILLER PIC X(10) VALUE SPACES.
 02 FILLER PIC X(11) VALUE "DATA VALUES".

01 OUTPUT-DATA-LINE.
 02 FILLER PIC X(10) VALUE SPACES.
 02 OUT-X PIC -(6).9(2).

01 OUTPUT-RESULTS-LINE-1.
 02 FILLER PIC X(9) VALUE " MEAN= ".
 02 OUT-MEAN PIC -(6)9.9(2).

01 OUTPUT-RESULTS-LINE-2.
 02 FILLER PIC X(9) VALUE " STD DEV=".
 02 STD-DEVIATION PIC -(6)9.9(2).

PROCEDURE DIVISION.
 OPEN INPUT INPUT-FILE, OUTPUT OUTPUT-FILE.
 MOVE 0 TO IN-X.
 PERFORM PROC-BODY
 UNTIL IN-X IS NOT LESS THAN 999999.98.
 PERFORM END-OF-JOB.

PROC-BODY.
 WRITE OUTPUT-LINE FROM OUTPUT-TITLE-LINE
 AFTER ADVANCING 0 LINES.
 WRITE OUTPUT-LINE FROM OUTPUT-UNDERLINE
 AFTER ADVANCING 1 LINE.
 WRITE OUTPUT-LINE FROM OUTPUT-COL-HEADS
 AFTER ADVANCING 1 LINE.
 WRITE OUTPUT-LINE FROM OUTPUT-UNDERLINE
 AFTER ADVANCING 1 LINE.
 MOVE 0 TO SUM-OF-X.
 READ INPUT-FILE INTO INPUT-VALUE-RECORD
 AT END PERFORM END-OF-JOB.
 PERFORM INPUT-LOOP
 VARYING N FROM 1 BY 1
 UNTIL N IS GREATER THAN 1000 OR IN-X IS NOT LESS THAN 999999.98.
 SUBTRACT 1 FROM N.
 DIVIDE N INTO SUM-OF-X GIVING MEAN ROUNDED.
 MOVE 0 TO SUM-OF-X-SQR.
 PERFORM SUM-LOOP
 VARYING I FROM 1 BY 1
 UNTIL I IS GREATER THAN N.
 COMPUTE STD-DEVIATION ROUNDED = (SUM-OF-X-SQR / N) ** 0.5.
 WRITE OUTPUT-LINE FROM OUTPUT-UNDERLINE
 AFTER ADVANCING 1 LINE.
 MOVE MEAN TO OUT-MEAN.
 WRITE OUTPUT-LINE FROM OUTPUT-RESULTS-LINE-1
 AFTER ADVANCING 1 LINE.
 WRITE OUTPUT-LINE FROM OUTPUT-RESULTS-LINE-2
 AFTER ADVANCING 1 LINE.

INPUT-LOOP.
 MOVE IN-X TO X(N) OUT-X.
 WRITE OUTPUT-LINE FROM OUTPUT-DATA-LINE
 AFTER ADVANCING 1 LINE.
 ADD X(N) TO SUM-OF-X.
 READ INPUT-FILE INTO INPUT-VALUE-RECORD
 AT END PERFORM END-OF-JOB.

SUM-LOOP.
 COMPUTE SUM-OF-X-SQR = SUM-OF-X-SQR + (X(I) - MEAN) ** 2.

END-OF-JOB.
 CLOSE INPUT-FILE, OUTPUT-FILE.
 STOP RUN.
