ROWS = 9
COLUMNS = 9

def is_good (grid, row, column, digit)
    for i in 0..COLUMNS - 1 do
        if grid[row][i] == digit
            return false
        end
    end

    for i in 0..ROWS - 1 do
        if grid[i][column] == digit
            return false
        end
    end

    sub_grid3x3 = 3
    startRow = row - row % sub_grid3x3
    startCol = column - column % sub_grid3x3
    for i in 0..sub_grid3x3 - 1 do
        for j in 0..sub_grid3x3 - 1 do
            if (grid[i + startRow][j + startCol] == digit)
                return false
            end
        end
    end
    true
end

def calc_sudoku(grid, row, column)
    if (row == ROWS-1 && column == COLUMNS)
        return true
    end

    if column == COLUMNS
        column = 0
        row += 1
    end

    if (grid[row][column] != 0)
        return calc_sudoku(grid, row, column + 1)
    end

    for digit in 1..9 do
        if (is_good(grid, row, column, digit))
            grid[row][column] = digit

            if (calc_sudoku(grid, row, column + 1))
                return true
            end
        end

        grid[row][column] = 0
    end

    false
end

def print_grid(grid)
    for i in 0..ROWS - 1 do
        for j in 0..COLUMNS - 1 do
            print "#{grid[i][j]} "
        end
        puts
    end
    puts
end

def read_from_file(grid, filename)
    file = File.open(filename)

    i = 0
    while i < 9 do
        line = file.readline.to_s.split(",")
        j = 0
        for value in line do
            grid[i][j] = value.to_i
            j += 1
        end
        i += 1
    end

    file.close
    grid
end

def run
    grid = Array.new(9) {Array.new(9)}
    sudoky_sources_file = "sudoky_sources.txt"

    if File.file?(sudoky_sources_file)
        read_from_file(grid, sudoky_sources_file)
    else
        puts "[::IOError::] => Cannot find or open file!"
    end

    calc_sudoku(grid, 0, 0)
    print_grid(grid)

end

run


