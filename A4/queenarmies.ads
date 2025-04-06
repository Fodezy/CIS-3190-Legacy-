--  Name: Eric Fode
--  Email: efode@uoguelp.ca
--  id: 1233839
--  Date Created: 31/03/2025
--  Date Completed: 05/04/2025

--  Course: CIS*3190 
--  Assignment: 4   

--  This file is used to share the functions and procedures needed in showboard from queensarmies, it also declares types here so they are accesssable in both files.

package QueenArmies is 

   type row is array(1 .. 10 ) of Integer; -- have min set to 3 max set to 10
   type column is array(1 .. 10) of row; -- same as row

   type single_set is array(1 .. 2) of Integer;
   type full_set is array(Positive range <>) of single_set;

   whiteQueen : constant Integer := 1;
   blackQueen : constant Integer := 2;

   procedure readBoardInfo(n: out Integer; m: out Integer);
   function placeQueen(n : in Integer; m : in Integer; board : in out column) return full_set;
   procedure testArrays(n : in Integer; board : in column);
end QueenArmies ;
