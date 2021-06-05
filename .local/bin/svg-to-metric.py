#!/usr/bin/env python

import sys
import re

INCH_TO_METER = 0.0254
INCH_TO_MILLIMETER = 25.4

VIEW_BOX_PATTERN = r"viewBox=\"(.+?)\""

file_path = sys.argv[1]

scale = INCH_TO_MILLIMETER

with open(file_path, 'r+') as fh:
    content = fh.read()
    view_box_match = re.search(VIEW_BOX_PATTERN, content)

    if view_box_match:
        print("Old viewbox: " + view_box_match.group(1))

        # Update viewbox
        parts = view_box_match.group(1).split(" ")
        new_values = " ".join(map(lambda v: str(float(v) * scale), parts))
        new_view_box = "viewBox=\"{}\"".format(new_values)
        content = re.sub(VIEW_BOX_PATTERN, new_view_box, content)
        print("New viewbox: " + new_view_box)

        new_scale = "scale({}, -{})".format(scale, scale)
        content = content.replace("scale(1,-1)", new_scale)
        content = content.replace("scale(1, -1)", new_scale)
        content = content.replace("scale(1 -1)", new_scale)

        print(content[0:350])

        # Write to file
        fh.seek(0)
        fh.write(content)
        fh.truncate()


print("Done")
