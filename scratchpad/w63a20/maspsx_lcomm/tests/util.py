def strip_comments(lines):
    res = []
    for line in lines:
        if line.startswith("#"):
            continue
        if "#" in line:
            line, *_ = line.split("#")
        res.append(line.strip())
    return res
