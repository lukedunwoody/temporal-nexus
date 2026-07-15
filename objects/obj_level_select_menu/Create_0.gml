selected = 0

row = [64, 160, 256]
column = [128, 320, 512]

rows = array_length(row)
columns = array_length(column)

header_rows = [16, 112, 208, 304]
header_content = ["1921", "1991", "2061", "???"]
header_color = [make_color_rgb(204, 204, 204), c_black, c_aqua, c_white]

level_amnt = rows * columns