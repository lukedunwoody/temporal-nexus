rm_prev = global.settings_previous_room
global.lobby_previous_room = "settings"

selected = 0

setting[0] = "Music Enabled"
setting[1] = "Sound Effects Enabled"
setting[2] = "Input Device Type"
setting[3] = "Window Mode"
setting[4] = "Resolution"

option[0] = ["Disabled", "Enabled"]
option[1] = ["Disabled", "Enabled"]
option[2] = ["Keyboard and Mouse", "Controller"]
option[3] = ["Fullscreen", "Borderless", "Windowed"]
option[4] = ["1600x900", "1920x1080", "2560x1440", "3840x2160"]
window_sizes = [[1600, 900], [1920, 1080], [2560, 1440], [3840, 2160]]

selected0 = 1
selected1 = 1
selected2 = 0
selected3 = 2
selected4 = 2

settings = array_length(setting)

options0 = array_length(option[0])
options1 = array_length(option[1])
options2 = array_length(option[2])
options3 = array_length(option[3])
options4 = array_length(option[4])

previous_room = -1