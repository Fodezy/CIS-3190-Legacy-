with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Hello is

   userChoice : Integer := 0;

   --  determines if the year is valid - 
   function isvalid(year : Integer) return Boolean is
      rc : Boolean := false;  -- rc stand for return code
   begin

      if year >= 1582 then  
         rc := true;
      end if;

      return rc; 
   end isvalid;

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
      for j in 1 .. 80 loop 
         put(banner(i)(j));
      end loop;    
      New_Line;       
   end loop; 

   end banner;

   
    
begin
    -- program to print a greeting message 
   New_Line; Put_Line ("Welcome to the Calender Program");  
   Put_Line ("Would you like the Calender to be in:"); 
   Put_Line ("French[1]"); 
   Put_Line ("English[2]");
   get(userChoice);

   if userChoice = 1 then 
      Put_Line("French Chosen");
   elsif userChoice = 2 then 
      Put_Line("English Chosen");
   else 
      put("Incorrect choice provided, exiting program...");
      return; 
   end if;

   Put_Line ("test print");

   banner (2025, 10);

   

    
end Hello;