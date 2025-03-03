with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Cal is

   type cal_row is array(Integer range 1 .. 7) of Integer;
   type cal_month is array(Integer range 1 .. 6) of cal_row;
   type cal_year is array(Integer range 1 .. 12) of cal_month;

   --  determines if the year is valid - 
   function isvalid(year : Integer) return Boolean is
      rc : Boolean := false;  -- rc stand for return code
   begin

      if year >= 1582 then  
         rc := true;
      end if;

      return rc; 
   end isvalid;

   procedure readcalinfo(year : out Integer; firstday : out Integer; lang : out Integer) is 
   
      y : Integer := 0;
      dayforfirst : Integer := 0;
   
   begin 

      New_Line; Put_Line ("Welcome to the Calender Program");  

      put ("Please enter a year: ");
      get(year);

      while not isvalid (year) loop
         New_Line; Put_Line ("Invalid Year");
         Put_Line ("Please Enter a new year: ");
         Get (year);
         New_Line;
      end loop;

      Put_Line ("Would you like the Calender to be in:"); 
      Put_Line ("French[1]"); 
      Put_Line ("English[2]");
      get(lang);

      if lang = 1 then 
         Put_Line("French Chosen");
      elsif lang = 2 then 
         Put_Line("English Chosen");
      else 
         put("Incorrect choice provided, exiting program...");
      end if;

      y := year - 1;
      dayforfirst := (36 + y + (y / 4) - (y / 100) + (y / 400)) mod 7;

      firstday := dayforfirst;

   end readcalinfo;

   function leapyear(year : Integer) return Boolean is 

      rc : Boolean := false; -- defualt return to false
   begin 

      if year mod 4 /= 0 then 
         rc := false;
      elsif year mod 100 /= 0 then 
         rc := true;
      elsif year mod 400 = 0 then 
         rc := true;
      else 
         rc := false;
      end if;

      return rc;

   end leapyear;

   function numdaysinmonth(month : in Integer; year : in Integer) return Integer is 

      type list is array (1 .. 12) of Integer;
      daysInMonth : list := (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
   
   begin 

      if month > 12 or else month < 1 then 
         Put_Line ("Month is out of range");
      end if;

      if leapyear (year) and then month = 2 then 
         daysInMonth(2) := 29;
      end if;

      return daysInMonth(month);

   end numdaysinmonth;

   function buildcalender(year : in Integer; month : in out Integer; firstday : in out Integer) return cal_year is 

      month_grid : cal_month := (others => (others => 0));

      year_grid : cal_year := (others => (others => (others => 0)));

      counter : Integer := 1;

      lastDayTracker : Integer := 0;
   begin 

   

   --  Put_Line (Integer'Image(month));

   firstday := firstday + 1;


   for m in 1 .. 12 loop 
      --  Put_Line (Integer'Image(firstday));

      month := numdaysinmonth (m, year);

      monthLoop: for i in 1 .. 6 loop
         for j in 1 .. 7 loop
            if counter > month then
               exit monthLoop;
            end if;
            lastDayTracker := lastDayTracker + 1;

               if i = 1 and then j >= firstday then 
                  month_grid(i)(j) := counter;
                  counter := counter + 1;
               end if;

               if i > 1 then 
                  month_grid(i)(j) := counter;
                  counter := counter + 1;
               end if;

         end loop;
      end loop monthLoop;
      year_grid(m) := month_grid;

      firstday := (lastDayTracker mod 7) + 1;
      lastDayTracker := 0;
      counter := 1;
      month_grid := (others => (others => 0));

   end loop;

   return year_grid;

   end buildcalender;

   procedure printrowmonth(calender : in cal_year; i : in Integer) is 
      month_counter : Integer := 0;

   begin 

   --  for i in 1 ..4 loop -- change this to range parameters dont need this loop anymore 
      for j in 1 .. 6 loop 
         for k in 1 .. 3 loop 
            month_counter := (i - 1) * 3 + k;
            for l in 1 .. 7 loop 
               if calender(month_counter)(j)(l) = 0 then 
                  Put("    ");
               else 
                  Put(calender(month_counter)(j)(l), Width => 4);
               end if;
            end loop;
            Put ("  ");
         end loop;
         New_Line;
      end loop;
      New_Line;
   --  end loop;

   end printrowmonth;

   procedure printrowheading(lang : in Integer; calender : in cal_year) is
      subtype names is String (1 .. 15);
      type monthsList is array(Integer range 1 .. 12) of names;
      
      subtype day is String(1 .. 2);
      type weekList is array(Integer range 1 .. 7) of day;

      --  englishList : monthsList := (1 => "January", 2 => "February", 3 => "March", 4 => "April", 5 => "May", 6 => "June", 7 => "July", 8 => "August", 9 => "September", 10 => "October", 11 => "November", 12 => "December");
      --  frenchList : monthsList := ("Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre");

       englishList : constant MonthsList := (
      1  => "January        ", 2  => "   February    ", 3  => "      March    ", 4  => "April          ", 5  => "   May         ", 6  => "      June     ",  
      7  => "July           ", 8  => "   August      ", 9  => "      September", 10 => "October        ", 11 => "   November    ", 12 => "      December ");

      --  My program would not compile if I used the accents on the months 
      frenchList : constant MonthsList := (
      1  => "Janvier        ", 2  => "   Fevrier     ", 3  => "      Mars     ", 4  => "Avril          ", 5  => "   Mai         ", 6  => "      Juin     ",
      7  => "Juillet        ", 8  => "   Aout        ", 9  => "      Septembre", 10 => "Octobre        ", 11 => "   Novembre    ", 12 => "      Decembre ");


      englishWeek : constant weekList := (
         1  => "Su", 2  => "Mo", 3  => "Tu", 4  => "We", 5  => "Th", 6  => "Fr", 7 => "Sa");

      frenchhWeek : constant weekList := (
         1  => "Di", 2  => "Lu", 3  => "Ma", 4  => "Me", 5  => "Je", 6  => "Ve", 7 => "Sa");

         counter : Integer := 0;

         month_counter : Integer := 0;
   begin 


      for k in 1 .. 4 loop 
         for l in 1 .. 3 loop 
            month_counter := (k - 1) * 3 + l;
            if lang = 1 then  
               put("            " & frenchList(month_counter));

            else 
               put("            " & englishList(month_counter));
            end if;

            if l mod 3 = 0 then 
               New_Line;
            end if;
         end loop;

         put("  ");
      
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
         printrowmonth(calender, counter);


         New_Line;

      end loop;


      New_Line;


   end printrowheading;



   procedure banner(year : in Integer; indent : in Integer) is 

      file : File_Type;
      line_buffer : String(1 .. 50);  -- buffer size 
      char_read : Natural; -- characters actually read
      numLines : constant Integer  := 11; -- lines to read from file 

      curLine : Integer := 0;
      linesCovered : Integer := 1;

      row_start : Integer := 0;


      type row_banner is array (Integer range 1 .. 80) of Character;
      type full_banner is array (Integer range 1 .. 11) of row_banner;
      banner : full_banner := (others => (others => ' '));

      type intArrayOne is array (1 .. 10) of Integer; 
      type intArrayTwo is array (1 .. 4) of Integer; 

      startLine : constant intArrayOne := (0, 13, 25, 37, 49, 61, 73, 85, 97, 109);
      yearArr : intArrayTwo;

      indentSize : constant   String := (1 .. indent => ' ');

   begin 

   yearArr(4) := (Year mod 10) + 1;
   yearArr(3) := ((Year / 10) mod 10) + 1;
   yearArr(2) := ((Year / 100) mod 10) + 1;
   yearArr(1) := ((Year / 1000)) + 1;


   open(file, In_File, "numeric_font.txt");

   for i in 1 .. 4 loop
      Reset(File);
      curLine := 0;
      linesCovered := 1;
      
      while not End_Of_File(file) and then (linesCovered <= numLines) loop
         Get_Line(file, line_buffer, char_read);
         curLine := curLine + 1;

         if curLine >= startLine(yearArr(i)) then -- change to i later 
            for j in 1 .. char_read loop 
               banner(linesCovered)(row_start + j) := line_buffer(j);
            end loop;
            linesCovered := linesCovered + 1;
         end if;
      end loop;
      row_start := row_start + 18;
   end loop;

   for i in 1 .. 11 loop
      put(indentSize); 
      for j in 1 .. 80 loop
         put(banner(i)(j));
      end loop;    
      New_Line;       
   end loop; 

   end banner;

   
    
   begin
   declare 
      year : Integer := 0;
      firstday : Integer := 0;
      lang : Integer := 1;

      month : Integer := 1;

      calender : cal_year;
      
   
   begin 
   
   
  


   
   readcalinfo (year, firstday, lang);

   calender := buildcalender(year, month, firstday);   -- always start with january (1)

   banner (year, 11);
   New_Line;

   printrowheading(lang, calender);




   end;
   

    
end Cal;