import sys
import json

space_index = sys.argv[1]
displays = json.load(sys.stdin)
display = displays[len(displays) - 1]
spaces = display['spaces']

print(spaces[int(space_index) - 1])

