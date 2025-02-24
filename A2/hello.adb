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
   line : String(1 .. 200);
   last : Natural;
   numLines : Integer := 11;
   curLine : Integer := 0;
   printedLines : Integer := 0;
   startPos : Integer := 1;

   subtype  banner_row is String(1 .. 15);
   current_banner_row : banner_row;
   
   type banner_col is array(1 .. 11) of banner_row;
   current_banner_col : banner_col;

   --  type banner is array(1 .. 80) of String;  -- 60 used, 20 blank space for now 
   --  full_banner : banner := (others => (others => ' '));


   subtype full_banner_row is string(1 .. 80);
   full_banner : full_banner_row;

   
   

   type intArrayOne is array (1 .. 10) of Integer; 
   type intArrayTwo is array (1 .. 4) of Integer; 

   startLine : intArrayOne := (0, 13, 25, 37, 49, 61, 73, 85, 97, 109);
   yearArr : intArrayTwo;
    
   begin 

   yearArr(4) := (Year mod 10) + 1;
   yearArr(3) := ((Year / 10) mod 10) + 1;
   yearArr(2) := ((Year / 100) mod 10) + 1;
   yearArr(1) := ((Year / 1000)) + 1;


   Open(file, In_File, "numeric_font.txt");


   for i in 1 .. 4 loop 
      Reset(File);
      curLine := 0;
      printedLines := 0;

      while not End_Of_File(file) and then (printedLines < numLines) loop 
         Get_Line(file, line, last);
         curLine := curLine + 1;
         -- yearArr returns the each char from the year, so 4321 would be [4][3][2][1]
         -- starLine returns the start line of the number in text file such as line 0 for 0[1], or line 13 for 1[2] ect. (off by one so I add 1 earlier)
         if curLine >= startLine(yearArr(i)) then -- change 1 later to i 
            for i in 1 .. last loop 
               current_banner_row(i) := line(i);
            end loop;
            Put_Line(current_banner_row(1 .. last));
            full_banner(startPos .. startPos + current_banner_row'Length - 1) := current_banner_row;
            exit;
            printedLines := printedLines + 1;
         end if;
      end loop;
      startPos := startPos + 17;
   end loop;

   Put_Line (full_banner);

   close(file);




   --  while not End_Of_File(file) and then (printedLines < numLines) loop 
   --     Get_Line(file, line, last);
   --     curLine := curLine + 1;

   --     if curLine >= startLine(yearArr(1)) then -- change 1 to i later
   --        if last >= 15 then 
   --           current_banner_row := line(1 .. 15);
   --        else 
   --           Put_Line("Issue");
   --        end if;
   --     Put_Line(current_banner_row);      
   --     printedLines := printedLines + 1;   
   --     end if;

   --  end loop;

   --  for i in 1 .. 4 loop 
   --     Reset(File);
   --     curLine := 0;
   --     printedLines := 0;

   --     while not End_Of_File(file) and then (printedLines < numLines) loop 
   --        Get_Line(file, line, last);
   --        curLine := curLine + 1;

   --        if curLine >= startLine(yearArr(i)) then 
   --           Put_Line(line(1 .. Last));
   --           printedLines := printedLines + 1;
   --        end if;
   --     end loop;

   --  end loop;
   

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

   banner (4321, 10);

   

    
end Hello;