with Ada.Wide_Text_IO; use Ada.Wide_Text_IO;
with Ada.Unchecked_Deallocation;

procedure ShowBoard is

    -- Define the access type for Wide_String
    type WS_Access is access Wide_String;

    -- Instantiate the generic deallocation procedure
    procedure Free_Wide_String is new Ada.Unchecked_Deallocation(Wide_String, WS_Access);

    -- queen unicode characters (see: https://www.wikiwand.com/en/articles/Chess_symbols_in_Unicode)
    White_Queen : constant Wide_String := "♕";
    Black_Queen : constant Wide_String := "♛";

    -- chess board box drawing characters (see: https://www.wikiwand.com/en/articles/Box-drawing_characters)
    Horz_Wall : constant Wide_String := "│";
    Vert_Wall : constant Wide_String := "─";
    Rigth_Wall : constant Wide_String := "┤";
    Left_Wall : constant Wide_String := "├";
    Top_Wall : constant Wide_String := "┬";
    Bottom_Wall : constant Wide_String := "┴";

    Top_Left_Corner : constant Wide_String := "┌";
    Top_Right_Corner : constant Wide_String := "┐";
    Bottom_Left_Corner : constant Wide_String := "└";
    Bottom_Right_Corner : constant Wide_String := "┘";
    Cross : constant Wide_String := "┼";

    Blank : constant Wide_String := " ";
    Tile : constant Wide_String := "◼";

    -- array types to store dynamic unicode grid 
    type cell_line is array (1 .. 41) of WS_Access;  -- allows for a max up to ten boxes 
    type cell_column is array (1 .. 3) of cell_line; -- 3 columns per box

    type chess_board is array (1 .. 10) of cell_column; -- max 10 columns

    -- Free a single cell
    --  procedure freeIndividualCell(column : in out WS_Access) is 
    --  begin 
    --      if cellBoxElement /= null then 
    --          Free_Wide_String(cellBoxElement);
    --          cellBoxElement := null;
    --      end if; 
    --  end freeIndividualCell;

    function buildTopRow(N : in Integer) return cell_column is
        totalCell : constant Integer := 4 * N + 1;
        cellIndex : Integer;
        line : cell_line;
        column : cell_column;
    begin

        line(1) := new Wide_String'(Top_Left_Corner);
        for i in 2 .. (totalCell - 1) loop 
            if (i - 1) mod 4 = 0 then 
                line(i) := new Wide_String'(Top_Wall);
            else 
                line(i) := new Wide_String'(Vert_Wall);
            end if;
        end loop;
        line(totalCell) := new Wide_String'(Top_Right_Corner);

        column(1) := line;

        for i in 1 .. totalCell loop 
            if (i -1) mod 4 = 0 or i = 1 then 
                line(i) := new Wide_String'(Horz_Wall);   
            else 
                cellIndex := (i - 1) / 4 + 1;
                if(cellIndex mod 2 /= 0 and then i mod 2 /= 0) then 
                    line(i) := new Wide_String'(Tile);
                else 
                    line(i) := new Wide_String'(Blank);
                end if;
            end if;
        end loop;

        column(2) := line;

        line(1) := new Wide_String'(Left_Wall);
        for i in 2 .. totalCell loop 
            if (i - 1) mod 4 = 0 then 
                line(i) := new Wide_String'(cross);
            else 
                line(i) := new Wide_String'(Vert_Wall);
            end if;
        end loop;
        line(totalCell) := new Wide_String'(Rigth_Wall);

        column(3) := line;

        return column;

    end buildTopRow;



    function buildBottomRow(N : in Integer) return cell_column is
        totalCell : constant Integer := 4 * N + 1;
        tileConditional : Integer := 1;  -- if N is odd start on cell 1, is even start on cell 2
        cellIndex : Integer;
        line : cell_line;
        column : cell_column;
    begin 

        if(N mod 2 = 0) then -- if N is even  
            tileConditional := 2;
        end if;
        

        for i in 1 .. totalCell loop 
            if (i - 1) mod 4 = 0 or i = 1 then 
                line(i) := new Wide_String'(Horz_Wall);
            else 
                cellIndex := (i - 1) / 4 + 1;

                if(tileConditional = 1) then -- start on cell one, print on all odd cells 
                    if(cellIndex mod 2 /= 0 and then i mod 2 /= 0) then 
                        line(i) := new Wide_String'(Tile);
                    end if;
                elsif(tileConditional = 2) then -- start on cell two, print on all even cells 
                    if(cellIndex mod 2 = 0 and then i mod 2 /= 0) then 
                        line(i) := new Wide_String'(Tile);
                    end if;                
                else
                    line(i) := new Wide_String'(Blank);
                end if;                
            end if;
        end loop;

        column(1) := line;

        line(1) := new Wide_String'(Bottom_Left_Corner);
        for i in 2 .. totalCell loop 
            if (i - 1) mod 4 = 0 then 
                line(i) := new Wide_String'(Bottom_Wall);
            else 
                line(i) := new Wide_String'(Vert_Wall);
            end if;
        end loop;
        line(totalCell) := new Wide_String'(Bottom_Right_Corner);

        column(2) := line;


        return column;

    end buildBottomRow;

    function buildMiddleRow(N : in Integer; tileType: in Integer) return cell_column is
        totalCell : Integer := 4 * N + 1;
        tileConditional : Integer := 1;  -- if N is even start on cell 1, if odd start on cell 2
        cellIndex : Integer;
        line : cell_line;
        column : cell_column;
    begin 

        if(tileType mod 2 = 0) then 
            tileConditional := 2;
        end if;


        for i in 1 .. totalCell loop 
            if (i - 1) mod 4 = 0 or i = 1 then 
                line(i) := new Wide_String'(Horz_Wall);
            else 
                cellIndex := (i - 1) / 4 + 1;

                if(tileConditional = 1) then -- start on cell one, print on all odd cells 
                    if(cellIndex mod 2 /= 0 and then i mod 2 /= 0) then 
                        line(i) := new Wide_String'(Tile);
                    end if;
                elsif(tileConditional = 2) then -- start on cell two, print on all even cells 
                    if(cellIndex mod 2 = 0 and then i mod 2 /= 0) then 
                        line(i) := new Wide_String'(Tile);
                    end if;                
                else
                    line(i) := new Wide_String'(Blank);
                end if;                
            end if;
        end loop;

        column(1) := line;

        line(1) := new Wide_String'(Left_Wall);
        for i in 2 .. totalCell loop 
            if (i - 1) mod 4 = 0 then 
                line(i) := new Wide_String'(Cross);
            else 
                line(i) := new Wide_String'(Vert_Wall);
            end if;
        end loop;
        line(totalCell) := new Wide_String'(Rigth_Wall);

        column(2) := line;

        return column;


    end buildMiddleRow;


    -- rowType: 
        -- 1: Top Row
        -- 2: Middle Row
        -- 3. Bottom Row
    -- size: 
        -- size of the chess board: N x N --> size x size
    function buildRowType(rowType : in Integer; size : In Integer; tileType: in Integer) return cell_column is
        column : cell_column;
    begin 

        case rowType is
            when 1 =>
                column := buildTopRow(size);
            when 2 => 
                column := buildMiddleRow(size, tileType);
            when 3 => 
                column := buildBottomRow(size);
            when others =>
                put("Out of Range");
        end case;

        
        
        return column;
    end buildRowType;

    -- used to deal with empty elements within type column as all but the first column will have 2 elements leaving the 3rd blank
    function isRowEmpty(line : cell_line) return Boolean is 
    begin 
        for I in line'Range loop
            if line(I) /= null then 
                return True;
            end if;
        end loop;

        return False;
    end isRowEmpty;

    begin
        declare 
            N : constant Integer := 10;

            --  colOne : cell_column := buildRowType(1, N);
            --  colTwo : cell_column;
            --  colThree : cell_column := buildRowType(3, N);
            board : chess_board := (others => (others => (others => null)));
            --  board : chess_board;


        begin

            board(1) := buildRowType(1, N, 1);
            for I in 2 .. (N - 1) loop
                board(I) := buildRowType(2, N, I);
            end loop;
            board(N) := buildRowType(3, N, 1);

            for Box in 1 .. N loop
                -- For each cell_column (box) in the chess board:
                for Row in board(Box)'Range loop
                    if isRowEmpty (board(Box)(Row)) then 
                        -- For each cell_line (i.e. a horizontal row within the cell column)
                        for Col in board(Box)(Row)'Range loop
                            if board(Box)(Row)(Col) /= null then
                                Put(board(Box)(Row)(Col).all);
                            else
                                Put(" ");
                            end if;
                        end loop;
                        New_Line;
                    end if;
                end loop;
            end loop;

        end;
end ShowBoard;
