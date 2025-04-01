with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;

procedure QueenArmies is 

   type row is array(1 .. 10 ) of Integer; -- have min set to 3 max set to 10
   type column is array(1 .. 10) of row; -- same as row

   type set is array(1 .. 2) of Integer;
   type full_set is array(Positive range <>) of set;

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



   while( n < 2 * m) loop

      New_Line; New_Line;
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

   function isAccrossLineSafe(board : in column; row, n, queenType : in Integer) return Boolean is
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

   function isDownLineSafe(board : in column; column, n, queenType : in Integer) return Boolean is
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

   function isLineSafe(board : in column; row, column, n, queenType : in Integer) return Boolean is
      isSafe : Boolean := False;
   begin

      if isAccrossLineSafe (board, row, n , queenType) and then isDownLineSafe (board, column, n, queenType) then 
         isSafe := True;
      end if;

      return isSafe;

   end isLineSafe;

   function isDiagonalsRigthSafe(board : in column; row, column, n, queenType : in Integer) return Boolean is
      isSafe : Boolean := True;

      --  reduced checking current position 
      row_spot : Integer := row + 1;
      column_spot : Integer := column + 1;
   begin 

      -- checks down to the right 
      while row_spot <= n and then column_spot <= n loop

         if queenType = 1 then 
            if board(row_spot)(column_spot) = 2 then 
               isSafe := False;
            end if;
         else 
            if board(row_spot)(column_spot) = 1 then 
               isSafe := False;
            end if; 
         end if;
      
         --  Put(Integer'Image(board(row_spot)(column_spot)) & " ");


         row_spot := row_spot + 1;
         column_spot := column_spot + 1;
         New_Line;
      end loop;

      --  reduced checking current position 
      row_spot := row - 1;
      column_spot := column + 1; 

      -- checks up and to the right
      while row_spot >= 1 and then column_spot <= n loop 

         if queenType = 1 then 
            if board(row_spot)(column_spot) = 2 then 
               isSafe := False;
            end if;
         else 
            if board(row_spot)(column_spot) = 1 then 
               isSafe := False;
            end if; 
         end if;
         --  Put(Integer'Image(board(row_spot)(column_spot)) & " ");

         row_spot := row_spot - 1;
         column_spot := column_spot + 1;
         --  New_Line;

      end loop;


      return isSafe;

   end isDiagonalsRigthSafe;

   function isDiagonalsLeftSafe(board : in column; row, column, n, queenType : in Integer) return Boolean is
      isSafe : Boolean := True;

      --  reduced checking current position 
      row_spot : Integer := row - 1;
      column_spot : Integer := column - 1;
   begin

      -- checks up and to the left
      while row_spot >= 1 and then column_spot >= 1 loop 


         if queenType = 1 then 
            if board(row_spot)(column_spot) = 2 then 
               isSafe := False;
            end if;
         else 
            if board(row_spot)(column_spot) = 1 then 
               isSafe := False;
            end if; 
         end if;
         --  Put(Integer'Image(board(row_spot)(column_spot)) & " ");

         row_spot := row_spot - 1;
         column_spot := column_spot - 1;
         --  New_Line;

      end loop;

      --  reduced checking current position 
      row_spot := row + 1;
      column_spot := column - 1; 

      -- checks down and to the left
      while row_spot <= n and then column_spot >= 1 loop 


         if queenType = 1 then 
            if board(row_spot)(column_spot) = 2 then 
               isSafe := False;
            end if;
         else 
            if board(row_spot)(column_spot) = 1 then 
               isSafe := False;
            end if; 
         end if;
         --  Put(Integer'Image(board(row_spot)(column_spot)) & " ");

         row_spot := row_spot + 1;
         column_spot := column_spot - 1;
         --  New_Line;

      end loop;

      return isSafe;

   end isDiagonalsLeftSafe;

   function isDiagonalsSafe(board : in column; column, row, n, queenType : in Integer) return Boolean is
      isSafe : Boolean := False;
   begin

      if isDiagonalsLeftSafe(board, column, row, n, queenType) and then isDiagonalsRigthSafe(board, column, row, n, queenType) then 
         isSafe := True;
      end if;

      return isSafe;
   end isDiagonalsSafe;

   function placeQueen(n : in Integer; m : in Integer; board : in out column) return full_set is 

      whiteQueen : constant Integer := 1;
      blackQueen : constant Integer := 2;

      singleSet : set := (0, 0);
      fullSet : full_set(1 .. 8) := (others => (others => 0));

      h : Boolean;
   begin 

      for Q in 1 .. (m * 2) loop 
         boardLoop: for i in 1 .. n loop
            for j in 1 .. n loop 

            if Q mod 2 = 1 then -- when on odd numbers place white queen

               if isLineSafe(board, i, j, n, whiteQueen) and then isDiagonalsSafe(board, i, j, n, whiteQueen) then 
                  if board(i)(j) /= whiteQueen then 
                     board(i)(j) := whiteQueen;

                     singleSet(1) := i;
                     singleSet(2) := j;
                     Put_Line ("White:" & Integer'Image(i) & " "  & Integer'Image(j));
                     exit boardLoop;
                  end if; 
               end if;

            else 

               if isLineSafe(board, i, j, n, blackQueen) and then isDiagonalsSafe(board, i, j, n, blackQueen) then 
                  if board(i)(j) /= blackQueen then 
                     board(i)(J) := blackQueen;

                     singleSet(1) := i;
                     singleSet(2) := j;
                     Put_Line ("Black:" & Integer'Image(i) & " "  & Integer'Image(j));
                     Put_Line (Integer'Image(board(i)(J)));
                     exit boardLoop;
                  end if;
               end if;

            end if;

            end loop;
         end loop boardLoop;

         fullSet(Q) := singleSet;

         --  Put_Line ("Values for I:" & Integer'Image(fullSet(Q)(1)));
         --  Put_Line ("Values for J:" & Integer'Image(fullSet(Q)(2)));

      end loop;

      return fullSet;


   end placeQueen;


   begin 
      declare

         n : Integer := 0; -- chess board size max 10, i think min 3
         m : Integer := 0; -- number of queens max 4, min 1

         set : full_set(1 .. 8); -- 8 should be max allowed 
         board : column := (others => (others => 0));

      begin 

      readBoardInfo(n, m);

      set := placeQueen (n, m, board);

      for i in set'Range loop 
         Put_Line ("Values for I:" & Integer'Image(set(i)(1)));
         Put_Line ("Values for J:" & Integer'Image(set(i)(2)));
         New_Line;
      end loop;

      testArrays (n, board);
   end;

end QueenArmies;