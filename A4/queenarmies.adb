--  Name: Eric Fode
--  Email: efode@uoguelp.ca
--  id: 1233839
--  Date Created: 31/03/2025
--  Date Completed: 05/04/2025

--  Course: CIS*3190 
--  Assignment: 4   

--  This file is used to preform user input validaton, the logic and computes the algorithm for safe placement of the queens, and returns a set of tuples corresponding to each queen spot 
--  This file invloves reading in the user input and:
--    1. validate if n is within 3 and 10, if not re asks the user for new value 
--    2. validate if m is within 1 and 4, if not re ask the user for a new value
--    3. if the two values provide no solution, tell them and reprompt for a new m value 

--  Next it will preform the logic to find the spots to place the queens. It makes use of helper functions that check 
--  1. The row and column if it is safe
--  Each diagonal if it is safe
--  If it is it calls its self again for the next queen position and does the same checks. If all queens are placed return a set of tuples containing the spot for each queen 
--  If a queen cannot be placed it back tracks and removes the last queen placed and finds the next spot to place it, then repeats the checks going until the last queen is placed
--  It will keep backtracking until either all queens are placed or it tries every spot, the second case should never happen as I validate the combo at the start 
--  This function returns true when a queen is placed and recalls, when all placed return true and dont recall, when no solution return false.
--  Checks return of this function and returns the set of spots.

with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;

package body QueenArmies is 

   type m_allowed_array is array(3 .. 10) of Integer;
   mAllowed : constant m_allowed_array := (3 => 1, 4 => 2, 5 => 4, 6 => 4, 7 => 4, 8 => 4, 9 => 4, 10 => 4);

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

   procedure validateCombo(n : in Integer; m : in out Integer) is 
   begin

      while (m > mAllowed(n)) loop
         New_Line;
         Put_Line ("Combo not allowed, Please Pick New Value for M");
         Put_Line ("Please Pick the Number of Queens on the board (1 to 4)");
         Put("M: ");
         Get(m);

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

   end validateCombo;

   procedure readBoardInfo(n: out Integer; m : out Integer) is
   begin 

      New_Line;
      Put_Line ("Welcome to CHESS ARMIES OF QUEENS");
      Put_Line ("The goal of Peaceful Armies of Queens is to arrange m black queens and m white queens on an n-by-n square grid, (the board),");
      Put_Line("so that no queen attacks another of a different colour.");
      New_Line;

      Put_Line ("Please Pick the size of the board (3 to 10)");
      Put("N: ");
      Get(n);

      while ( not validateN(n)) loop 
         New_Line;
         Put_Line ("Invalid Input for N (3 to 10)");
         Put_Line ("Please enter new value for N");
         Put ("N: ");
         Get (n);
      end loop;

      Put_Line ("Please Pick the Number of Queens on the board (1 to 4)");
      Put("M: ");
      Get(m);

      while ( not validateM(m)) loop 
         New_Line;
         Put_Line ("Invalid Input for M ( 1 to 4)");
         Put_Line ("Please enter new value for M");
         Put ("M: ");
         Get (m);
      end loop;

      validateCombo(n, m);

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
      
         row_spot := row_spot + 1;
         column_spot := column_spot + 1;
         --  New_Line;
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

         row_spot := row_spot - 1;
         column_spot := column_spot + 1;

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

         row_spot := row_spot - 1;
         column_spot := column_spot - 1;

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

         row_spot := row_spot + 1;
         column_spot := column_spot - 1;

      end loop;

      return isSafe;

   end isDiagonalsLeftSafe;

   function isDiagonalsSafe(board : in column; row, column, n, queenType : in Integer) return Boolean is
      isSafe : Boolean := False;
   begin

      if isDiagonalsLeftSafe(board, row, column, n, queenType) and then isDiagonalsRigthSafe(board, row, column, n, queenType) then 
         isSafe := True;
      end if;

      return isSafe;
   end isDiagonalsSafe;

   function isSpotSafe(board : in column; row, column, n, queenType : in Integer) return Boolean is
      isSafe : Boolean := False;
   begin 
      if isLineSafe (board, row, column, n, queenType) and then isDiagonalsSafe (board, row, column, n, QueenType) then
         isSafe := True;
      end if;

      return isSafe;

   end isSpotSafe;

   function placeQueen(n : in Integer; m : in Integer; board : in out column) return full_set is 

      whiteQueen : constant Integer := 1;
      blackQueen : constant Integer := 2;
      totalQueens : constant Integer := 2 * m;

      --  singleSet : single_set := (0, 0);
      fullSet : full_set(1 .. 8) := (others => (others => 0));

      --  h : Boolean;

      function replaceQueen(queen : in Integer) return Boolean is 

         queenType : Integer := 0;
      begin 

         --  base case: when all queens have been placed 
         if queen > totalQueens then 
            return true;
         else 
            if queen mod 2 = 1 then 
               queenType := whiteQueen;
            else 
               queenType := blackQueen;
            end if;

            for i in 1 .. n loop
               for j in 1 .. n loop
               if board(i)(j) = 0 and then isSpotSafe (board,i ,j, n, queenType) then 
                     board(i)(j) := queenType;
                     fullSet(queen)(1) := i;
                     fullSet(queen)(2) := j;
                     if replaceQueen (queen + 1) then 
                        return true;
                     else 
                        board(i)(j) := 0;
                     end if;                     
                  end if;
               end loop;
            end loop;

            return False;
         end if;

      end replaceQueen;

   begin 

      if replaceQueen(1) then 
         return fullSet;
      else 
         fullSet := (others => (others => 0));
         return fullSet;
      end if;

   end placeQueen;

end QueenArmies;
