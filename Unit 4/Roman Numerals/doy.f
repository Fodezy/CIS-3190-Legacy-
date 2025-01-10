      PROGRAM DAY_OF_YEAR
  5   READ (*,*) IYEAR, IDATE
      IF (IDATE .LT. 1 .OR. IDATE .GT. 366 .OR. IYEAR .LT. 0) GO TO 999
      IF (IDATE .LE. 31) GO TO 800
      L = 1
      I = IYEAR / 400
      IF (IYEAR - (I * 400) .EQ. 0) GO TO 20
      I = IYEAR / 100
      IF (IYEAR - (I * 100) .EQ. 0) GO TO 10
      I = IYEAR / 4
      IF (IYEAR - (I * 4) .EQ. 0) GO TO 20
  10  L = 0
      IF (IDATE .GT. 365) GO TO 999
  20  IF (IDATE .GT. 181 + L) GO TO 181
      IF (IDATE .GT. 90 + L) GO TO 90
      IF (IDATE .GT. 59 + L) GO TO 59
      MONTH = 2
      IDAY = IDATE - 31
      GO TO 900
  59  MONTH = 3
      IDAY = IDATE - (59 + L)
      GO TO 900
  90  IF (IDATE .GT. 120 + L) GO TO 120
      MONTH = 4
      IDAY = IDATE - (90 + L)
      GO TO 900
 120  IF (IDATE .GT. 151 + L) GO TO 151
      MONTH = 5
      IDAY = IDATE - (120 + L)
      GO TO 900
 151  MONTH = 6
      IDAY = IDATE - (151 + L)
      GO TO 900
 181  IF (IDATE .GT. 273 + L) GO TO 273
      IF (IDATE .GT. 243 + L) GO TO 243
      IF (IDATE .GT. 212 + L) GO TO 212
      MONTH = 7
      IDAY = IDATE - (181 + L)
      GO TO 900
 212  MONTH = 8
      IDAY = IDATE - (212 + L)
      GO TO 900
 243  MONTH = 9
      IDAY = IDATE - (243 + L)
      GO TO 900
 273  IF (IDATE .GT. 334 + L) GO TO 334
      IF (IDATE .GT. 304 + L) GO TO 304
      MONTH = 10
      IDAY = IDATE - (273 + L)
      GO TO 900
 304  MONTH = 11
      IDAY = IDATE - (304 + L)
      GO TO 900
 334  MONTH = 12
      IDAY = IDATE - (334 + L)
      GO TO 900
 800  MONTH = 1
      IDAY = IDATE
      GO TO 900
 900  WRITE (*,*) MONTH, IDAY, IYEAR
      GO TO 5
 999  WRITE (*,*) "error with data? ", IDATE, IYEAR
      END
