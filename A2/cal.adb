-- Student Name: Eric Fode 
-- Student Email: efode@uoguelph.ca
-- Student Number: 1233839

-- This program/file is used to print a yearly calendar for a user defined year. 
-- To run the program use the command to compile: gnatmake -Wall cal.adb and then to run : linux --> ./cal windows --> ./cal.exe
-- The user will be first be prompted to enter a year, if the year is before 1582 the user will be asked for a new year. 
-- Next the will be asked to pick the language, 1 for french, 2 for english. If and incorrect value is picked the user will be asked again 
-- The program will then print the the year picked, the month names as headers and the days as headers for each month section and also the dates for each month.
-- The calendar will start on the correct days for each month, and will take into account the years that have an extra day in February.
-- This file reads from numeric_font.txt for the year banner, and is designed to follow the given style. 

with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Cal is

   --  Type declarations for the calendar structure. Allows for easy access the the types from multiple functions. 
   type cal_row is array(Integer range 1 .. 7) of Integer;
   type cal_month is array(Integer range 1 .. 6) of cal_row;
   type cal_year is array(Integer range 1 .. 12) of cal_month;

   ---------------------------------------------------------------------------------------------------------------
   --                                        Validation Checks 
   ---------------------------------------------------------------------------------------------------------------

   --  determines if the year picked by the user is valid (ie:  >= 1582 and < 9999)  
   function isvalid(year : Integer) return Boolean is
      isValidYear : Boolean := false;  -- rc stand for return code
   begin

      if year >= 1582 and year <= 9999 then  
         isValidYear := true;
      end if;

      return isValidYear; 
   end isvalid;

   -- determines if the year chosen is a leap year and returns true of false 
   function leapyear(year : Integer) return Boolean is 

      isLeapYear : Boolean := false; -- defualt return to false 
   begin 

      if year mod 4 /= 0 then 
         isLeapYear := false;
      elsif year mod 100 /= 0 then 
         isLeapYear := true;
      elsif year mod 400 = 0 then 
         isLeapYear := true;
      else 
         isLeapYear := false;
      end if;

      return isLeapYear;

   end leapyear;

   ---------------------------------------------------------------------------------------------------------------
   --                                        User Input 
   ---------------------------------------------------------------------------------------------------------------

   --  prints out instructions to the user, and reads the users input. The values read from the user are passed and modified through the parameters. 
   -- Includes error checking for the user input and re-prompts if invalid input is provided (within reason)
   procedure readcalinfo(year : out Integer; firstday : out Integer; lang : out Integer) is 
   
      y : Integer := 0;
      dayforfirst : Integer := 0;
   
   begin 

      New_Line; Put_Line ("Welcome to the calendar Program");  

      put ("Please enter a year: ");
      get(year);

      -- validates the users choice for the year 
      while not isvalid (year) loop
         New_Line; Put_Line ("Invalid Year");
         Put_Line ("Please Enter a new year: ");
         Get (year);
         New_Line;
      end loop;

      Put_Line ("Would you like the calendar to be in:"); 
      Put_Line ("French[1]"); 
      Put_Line ("English[2]");
      get(lang);

      -- validates the users choice for the language  
      while lang /= 1 and lang /= 2 loop 
         Put_Line("Invalid option please pick again");
         Put_Line ("French[1]"); 
         Put_Line ("English[2]");
         get(lang);   
      end loop;   

      if lang = 1 then 
         Put_Line("French Chosen");
      elsif lang = 2 then 
         Put_Line("English Chosen");
      else 
         put("Incorrect choice provided, exiting program...");
      end if;

      -- finds the first day of January for the given month
      y := year - 1;
      dayforfirst := (36 + y + (y / 4) - (y / 100) + (y / 400)) mod 7;

      firstday := dayforfirst;

   end readcalinfo;

   ---------------------------------------------------------------------------------------------------------------
   --                                        Calendar Building 
   ---------------------------------------------------------------------------------------------------------------

   --   determines assigns the amount of days in each year, also validates and adjusts for leap years
   function numdaysinmonth(month : in Integer; year : in Integer) return Integer is 

      type list is array (1 .. 12) of Integer;
      daysInMonth : list := (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
   
   begin 

      --  error checking for out of bounds 
      if month > 12 or else month < 1 then 
         Put_Line ("Month is out of range");
      end if;

      --  if the year is a leap year then change february from 28 to 29 days 
      if leapyear (year) and then month = 2 then 
         daysInMonth(2) := 29;
      end if;

      --  returns the number of days in the specified month 
      return daysInMonth(month);

   end numdaysinmonth;

   --  builds and structures the calendar, starts by building each month in a 7 X 6 grid for the days in a month. After assigning the correct positions for each day 
   --  it will store the specified month within the year grid, it will then reset the month grid to be empty and start the process for the next month going from month 1 to 12 
   function buildcalendar(year : in Integer; month : in out Integer; firstday : in out Integer) return cal_year is 

      --  types declared at top of file, month stores one month and is constantly re-set 
      month_grid : cal_month := (others => (others => 0)); 
      --   year grid stores each month for a specified year
      year_grid : cal_year := (others => (others => (others => 0)));
      counter : Integer := 1;
      lastDayTracker : Integer := 0;
   begin 

   --  Put_Line (Integer'Image(month));

   --  accounts for off by one issue with indexing 
   firstday := firstday + 1;

   --  loops for all 12 months in a year 
   for m in 1 .. 12 loop 
      --  Put_Line (Integer'Image(firstday));

      --  gets the number of days in specified month 
      month := numdaysinmonth (m, year);

      --  used to format the grid to have 6 rows, defined loop name to allow for specified exit case 
      monthLoop: for i in 1 .. 6 loop
         --  used to format 7 columns to account for the 7 days in a week 
         for j in 1 .. 7 loop
            --  if days counter exceeds days in a month exit specified loop
            if counter > month then
               exit monthLoop;
            end if;
            --  used to account for off by one 
            lastDayTracker := lastDayTracker + 1;

               --  used to store the first day of the month in the correct position 
               if i = 1 and then j >= firstday then 
                  month_grid(i)(j) := counter;
                  counter := counter + 1;
               end if;

               --  stores the rest of the dates in the proper spots 
               if i > 1 then 
                  month_grid(i)(j) := counter;
                  counter := counter + 1;
               end if;

         end loop;
      end loop monthLoop;

      --  stores specified month in the proper year grid, then determines the starting day of the next month, and resets the month grid 
      year_grid(m) := month_grid;
      firstday := (lastDayTracker mod 7) + 1;
      lastDayTracker := 0;
      counter := 1;
      month_grid := (others => (others => 0));

   end loop;

   --  returns the year so it can be formatd and printed 
   return year_grid;

   end buildcalendar;


   ---------------------------------------------------------------------------------------------------------------
   --                                        Output Calendar 
   ---------------------------------------------------------------------------------------------------------------

   --  prints the calendar that was passed through and format's it to look visually appealing
   procedure printrowmonth(calendar : in cal_year; i : in Integer) is 
      month_counter : Integer := 0;

   begin 

   --  for i in 1 ..4 loop -- change this to range parameters dont need this loop anymore 

   --  this looping logic just prints the year grid assigned in the above function
   -- it also format's it to fit in a 3 x 4 grid and adds some spacing 
   for j in 1 .. 6 loop 
      for k in 1 .. 3 loop 
         month_counter := (i - 1) * 3 + k;
         for l in 1 .. 7 loop 
            --  keeps track of the actual month 
            if calendar(month_counter)(j)(l) = 0 then 
               Put("    ");
            else 
               Put(calendar(month_counter)(j)(l), Width => 4);
            end if;
         end loop;
         Put ("  ");
      end loop;
      New_Line;
   end loop;
   New_Line;
   --  end loop;

   end printrowmonth;


   --  prints the row headings such as month names(english or french) and days of the week(english or french) 
   procedure printrowheading(lang : in Integer; calendar : in cal_year) is

      --  types to store the list of months, set to 15 characters per month 
      subtype names is String (1 .. 15);
      type monthsList is array(Integer range 1 .. 12) of names;
      
      --  types to store the days of a week set to 7 characters per day 
      subtype day is String(1 .. 2);
      type weekList is array(Integer range 1 .. 7) of day;

      --  englishList : monthsList := (1 => "January", 2 => "February", 3 => "March", 4 => "April", 5 => "May", 6 => "June", 7 => "July", 8 => "August", 9 => "September", 10 => "October", 11 => "November", 12 => "December");
      --  frenchList : monthsList := ("Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre");

      englishMonth : constant MonthsList := (
      1  => "January        ", 2  => "   February    ", 3  => "      March    ", 4  => "April          ", 5  => "   May         ", 6  => "      June     ",  
      7  => "July           ", 8  => "   August      ", 9  => "      September", 10 => "October        ", 11 => "   November    ", 12 => "      December ");

      --  My program would not compile if I used the accents on the months 
      frenchMonth : constant MonthsList := (
      1  => "Janvier        ", 2  => "   Fevrier     ", 3  => "      Mars     ", 4  => "Avril          ", 5  => "   Mai         ", 6  => "      Juin     ",
      7  => "Juillet        ", 8  => "   Aout        ", 9  => "      Septembre", 10 => "Octobre        ", 11 => "   Novembre    ", 12 => "      Decembre ");


      englishWeek : constant weekList := (
         1  => "Su", 2  => "Mo", 3  => "Tu", 4  => "We", 5  => "Th", 6  => "Fr", 7 => "Sa");

      frenchhWeek : constant weekList := (
         1  => "Di", 2  => "Lu", 3  => "Ma", 4  => "Me", 5  => "Je", 6  => "Ve", 7 => "Sa");

         counter : Integer := 0;

         month_counter : Integer := 0;
   begin 

   --  loops 4 times for the 4 rows being used to display the months in each year 
   for k in 1 .. 4 loop 
      --  loops 3 times for the 3 columns being used to display the months in each year 
      for l in 1 .. 3 loop 
         --  keeps track of the current month 
         month_counter := (k - 1) * 3 + l;

         --  language validation 
         if lang = 1 then  
            put("            " & frenchMonth(month_counter));
         else 
            put("            " & englishMonth(month_counter));
         end if;

         --  puts a new line every three months 
         if l mod 3 = 0 then 
            New_Line;
         end if;
      end loop;
      put("  ");
   
      --  prints the days names for each month 
      for i in 1 .. 3 loop 
         for j in 1 .. 7 loop
            if lang = 1 then 
               put(frenchhWeek(j) & "  ");
            else 
               put(englishWeek(j) & "  ");
            end if; 
         end loop;
         put("  ");
      end loop;

      counter := k;
      New_Line;
      --  calls the actual year grid to be printed 
      printrowmonth(calendar, counter);
      New_Line;
   end loop;

      New_Line;

   end printrowheading;


   --  this reads through my desired file and grabs the constructed numbers given the year and prints the banner 
   procedure banner(year : in Integer; indent : in Integer) is 

      file : File_Type;
      -- buffer size 
      line_buffer : String(1 .. 50);  
      -- characters actually read
      char_read : Natural; 
      -- lines to read from file (each digit is 11 lines tall)
      numLines : constant Integer  := 11; 

      curLine : Integer := 0;
      linesCovered : Integer := 1;

      row_start : Integer := 0;

      --  defines types to store a letter and the whole banner 
      type row_banner is array (Integer range 1 .. 80) of Character;
      type full_banner is array (Integer range 1 .. 11) of row_banner;
      banner : full_banner := (others => (others => ' '));

      --  types to store the starting line number for each number, and the full banner (only goes up to four digits)
      type intArrayOne is array (1 .. 10) of Integer; 
      type intArrayTwo is array (1 .. 4) of Integer; 

      --  starting line in the text file for each number 
      startLine : constant intArrayOne := (0, 13, 25, 37, 49, 61, 73, 85, 97, 109);
      yearArr : intArrayTwo;

      indentSize : constant   String := (1 .. indent => ' ');

   begin 

      --  breaks down the year into four integers
      yearArr(4) := (Year mod 10) + 1;
      yearArr(3) := ((Year / 10) mod 10) + 1;
      yearArr(2) := ((Year / 100) mod 10) + 1;
      yearArr(1) := ((Year / 1000)) + 1;


      open(file, In_File, "numeric_font.txt");

      --  loops for the needed four digits in the fle 
      for i in 1 .. 4 loop
         -- resets the file pointer to the start of the file  
         Reset(File);
         --  keeps track of the current line 
         curLine := 0;
         --  keeps track of the lines read so far 
         linesCovered := 1;

         --  reads to end of file or until 11 lines of been read 
         while not End_Of_File(file) and then (linesCovered <= numLines) loop
            Get_Line(file, line_buffer, char_read);
            curLine := curLine + 1;

            --  stores the values from the file when within the desired range 
            if curLine >= startLine(yearArr(i)) then
               for j in 1 .. char_read loop 
                  banner(linesCovered)(row_start + j) := line_buffer(j);
               end loop;
               linesCovered := linesCovered + 1;
            end if;
         end loop;
         row_start := row_start + 18;
      end loop;

      -- prints the banner   
      for i in 1 .. 11 loop
         put(indentSize); 
         for j in 1 .. 80 loop
            put(banner(i)(j));
         end loop;    
         New_Line;       
      end loop; 

   end banner;
    
   ---------------------------------------------------------------------------------------------------------------
   --                                        Main Driver 
   ---------------------------------------------------------------------------------------------------------------
   begin
   declare 

      --  declare values used in the main 
      year : Integer := 0;
      firstday : Integer := 0;
      lang : Integer := 1;
      month : Integer := 1;
      calendar : cal_year;
      
   begin 
   
   --  read user info 
   readcalinfo (year, firstday, lang);

   --  build and structure desired calendar 
   calendar := buildcalendar(year, month, firstday);   -- always start with january (1)

   --  print banner with an indent of 11
   banner (year, 11);
   New_Line;

   --  prints the full calendar 
   printrowheading(lang, calendar);

   end;
   
end Cal;