with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;

procedure QueenArmies is 

   type row is array(1 .. 10 ) of Integer; -- have min set to 3 max set to 10
   type column is array(1 .. 10) of row; -- same as row

   function validateN(n : in Integer ) return Boolean is
   begin
      if(n > 10 or else n < 3) then 
         return False;
      end if;

      return True;
   end validateN;

   function validateM(m : in Integer ) return Boolean is
   begin
      if(m > 4 or else m < 1) then 
         return False;
      end if;

      return True;
   end validateM;

   procedure readBoardInfo(n: out Integer; m : out Integer) is
   begin 

   New_Line;
   Put_Line ("Welcome to CHESS ARMIES OF QUEENS");
   Put_Line ("The goal of Peaceful Armies of Queens is to arrange m black queens and m white queens on an n-by-n square grid, (the board),");
   Put_Line("so that no queen attacks another of a different colour.");
   New_Line;

   Put_Line ("Please Pick the size of the board where 10 >= N >= 3");
   Put("N: ");
   Get(n);

   while ( not validateN(n)) loop 
      New_Line;
      Put_Line ("Invalid Input for N");
      Put_Line ("Please enter new value for N");
      Put ("N: ");
      Get (n);
   end loop;

   Put_Line ("Please Pick the Number of Queens on the board where 4 >= M >= 1");
   Put("M: ");
   Get(m);

   while ( not validateM(m)) loop 
      New_Line;
      Put_Line ("Invalid Input for M");
      Put_Line ("Please enter new value for M");
      Put ("M: ");
      Get (m);
   end loop;

   New_Line; New_Line;

   while( n < 2 * m) loop
      Put_Line ("Invalid combination for M and N, values cannot co-exist together");

      n := 0;
      m := 0;
      while ( not validateN(n)) loop 
         New_Line;
         Put_Line ("Invalid Input for N");
         Put_Line ("Please enter new value for N");
         Put ("N: ");
         Get (n);
      end loop;

      while ( not validateM(m)) loop 
         New_Line;
         Put_Line ("Invalid Input for M");
         Put_Line ("Please enter new value for M");
         Put ("M: ");
         Get (m);
      end loop;

   end loop;

      New_Line; New_Line;


   New_Line; New_Line;
   Put_Line ("Choosen Values are Valid: ");
   Put_Line ("N:" & Integer'Image(n));
   Put_Line ("M:" & Integer'Image(m));

   end readBoardInfo;

   procedure testArrays(n : in Integer; board : in column) is
   begin 

   for I in 1 .. n loop 
      for J in 1 .. n loop
         put(Integer'Image(board(I)(J)) & " ");
      end loop;
      New_Line;
   end loop;

   end testArrays;

   function isAccrossLineSafe(board : in column; row : in Integer; n : in Integer; queenType : in Integer) return Boolean is
      isSafe : Boolean := True;

   begin 

      for i in 1 .. n loop 
         if queenType = 1 then -- white 
            if board(row)(i) = 2 then 
               isSafe := False;
            end if;
         else 
            if board(row)(i) = 1 then 
               isSafe := False;
            end if;
         end if;
      end loop;
   
      return isSafe;

   end isAccrossLineSafe;

   function isDownLineSafe(board : in column; column : in Integer; n : in Integer; queenType : in Integer) return Boolean is
      isSafe : Boolean := True;
   begin

      for i in 1 .. n loop
         if queenType = 1 then -- white 
            if board(i)(column) = 2 then 
               isSafe := False;
            end if;
         else 
            if board(i)(column) = 1 then 
               isSafe := False;
            end if;
         end if;
      end loop;

      return isSafe;

   end isDownLineSafe;

   function isLineSafe(board : in column; row : in Integer ;column : in Integer; n : in Integer; queenType : in Integer) return Boolean is
      isSafe : Boolean := False;
   begin

      if isAccrossLineSafe (board, row, n , queenType) and then isDownLineSafe (board, column, n, queenType) then 
         isSafe := True;
      end if;

      return isSafe;

   end isLineSafe;

   function isDiagonalsRigthSafe(board : in column; column, row, n, queenType : in Integer) return Boolean is
      isSafe : Boolean := True;

      --  reduced checking current position 
      row_spot : Integer := row + 1;
      column_spot : Integer := column + 1;
   begin 

      -- checks down to the right 
      while row_spot <= n and then column_spot <= n loop
      
         Put(Integer'Image(board(row_spot)(column_spot)) & " ");


         row_spot := row_spot + 1;
         column_spot := column_spot + 1;
         New_Line;
      end loop;

      --  reduced checking current position 
      row_spot := row - 1;
      column_spot := column + 1; 

      -- checks up and to the right
      while row_spot >= 1 and then column_spot <= n loop 
         Put(Integer'Image(board(row_spot)(column_spot)) & " ");

         row_spot := row_spot - 1;
         column_spot := column_spot + 1;
         New_Line;

      end loop;


      return isSafe;

   end isDiagonalsRigthSafe;

   function isDiagonalsLeftSafe(board : in column; column, row, n, queenType : in Integer) return Boolean is
      isSafe : Boolean := True;

      --  reduced checking current position 
      row_spot : Integer := row - 1;
      column_spot : Integer := column - 1;
   begin

      -- checks up and to the left
      while row_spot >= 1 and then column_spot >= 1 loop 
         Put(Integer'Image(board(row_spot)(column_spot)) & " ");

         row_spot := row_spot - 1;
         column_spot := column_spot - 1;
         New_Line;

      end loop;

      --  reduced checking current position 
      row_spot := row + 1;
      column_spot := column - 1; 

      -- checks down and to the left
      while row_spot <= n and then column_spot >= 1 loop 
         Put(Integer'Image(board(row_spot)(column_spot)) & " ");

         row_spot := row_spot + 1;
         column_spot := column_spot - 1;
         New_Line;

      end loop;

      return isSafe;

   end isDiagonalsLeftSafe;

   procedure placeQueen(n : in Integer; m : in Integer; board : in out column) is 

      whiteQueen : constant Integer := 1;
      blackQueen : constant Integer := 2;

      h : Boolean;
   begin 

      board(1)(1) := 1;
      board(2)(2) := 2;
      board(3)(3) := 3;
      board(1)(3) := 4;
      board(3)(1) := 9;
      board(3)(2) := 8;
      

      Put_Line(Boolean'Image( isLineSafe(board, 2, 2, n, blackQueen) ));


      if isLineSafe(board, 2, 2, n, blackQueen) then 
         board(2)(2) := blackQueen;
      end if;

      --  h := isDiagonalsRigthSafe(board, 2, 3, n, blackQueen);

      h := isDiagonalsLeftSafe(board, 3, 2, n, blackQueen);



   end placeQueen;


   begin 
      declare

         n : Integer := 0; -- chess board size max 10, i think min 3
         m : Integer := 0; -- number of queens max 4, min 1


         board : column := (others => (others => -1));

      begin 

      readBoardInfo(n, m);

      placeQueen (n, m, board);

      testArrays (n, board);
   end;

end QueenArmies;