with Ada.Task_Identification;
with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Hello is

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
      lang := 2;

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

   procedure buildcalender(year : in Integer; month : in out Integer; firstday : in out Integer) is 

      type cal_row is array(Integer range 1 .. 7) of Integer;
      type cal_month is array(Integer range 1 .. 6) of cal_row;
      type cal_year is array(Integer range 1 .. 12) of cal_month;

      month_grid : cal_month := (others => (others => 0));

      year_grid : cal_year := (others => (others => (others => 0)));

      counter : Integer := 1;
   begin 

   month := numdaysinmonth (month, year);

   Put_Line (Integer'Image(month));

   firstday := firstday + 1;

   for i in 1 .. 6 loop
      for j in 1 .. 7 loop
         if counter > month then
            exit;
         end if;

            if i = 1 and then j >= firstday then 
               month_grid(i)(j) := counter;
               counter := counter + 1;
            end if;

            if i > 1 then 
               month_grid(i)(j) := counter;
               counter := counter + 1;
            end if;

      end loop;
   end loop;

   year_grid(1) := month_grid;

   --  for i in 1 .. 6 loop
   --     New_Line;
   --     for j in 1 .. 7 loop
   --        Put (month_grid(i)(j), Width => 5);
   --     end loop;
   --  end loop;

   for i in 1 ..4 loop 
      for j in 1 .. 6 loop 
         for k in 1 .. 3 loop 
            for l in 1 .. 7 loop 
               Put(year_grid(k)(j)(l), Width => 3);
            end loop;
            Put ("  ");
         end loop;
         New_Line;
      end loop;
      New_Line;
   end loop;


   end buildcalender;



   procedure banner(year : in Integer; indent : in Integer) is 

      file : File_Type;
      line_buffer : String(1 .. 50);  -- buffer size 
      char_read : Natural; -- characters actually read
      numLines : Integer := 11; -- lines to read from file 

      curLine : Integer := 0;
      linesCovered : Integer := 1;

      row_start : Integer := 0;


      type row_banner is array (Integer range 1 .. 80) of Character;
      type full_banner is array (Integer range 1 .. 11) of row_banner;
      banner : full_banner := (others => (others => ' '));

      type intArrayOne is array (1 .. 10) of Integer; 
      type intArrayTwo is array (1 .. 4) of Integer; 

      startLine : intArrayOne := (0, 13, 25, 37, 49, 61, 73, 85, 97, 109);
      yearArr : intArrayTwo;

      indentSize : String := (1 .. indent => ' ');

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
      userChoice : Integer := 0;
      cal_Year : Integer := 0;
      cal_firstday : Integer := 0;
      cal_lang : Integer := 1;

      cal_month : Integer := 1;
      
   
   begin 
   
   
  

   --  banner (2025, 10);

   
   readcalinfo (cal_Year, cal_firstday, cal_lang);

   Put_Line (Integer'Image(cal_firstday));

   buildcalender(cal_Year, cal_month, cal_firstday);   -- always start with january (1)

   --  Put_Line(Boolean'Image( leapyear (cal_Year)));

   --  Put_Line (Integer'Image( numdaysinmonth(2, cal_Year)));

   --  Put_Line (Integer'Image(cal_Year));
   --  Put_Line (Integer'Image(cal_firstdat));
   --  Put_Line (Integer'Image(cal_lang));

   
   
   
   
   
   
   
   
   end;
   

    
end Hello;