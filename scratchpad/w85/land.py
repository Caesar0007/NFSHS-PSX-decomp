SUBS = [
 ("    offset = *(volatile long *)&ofs;", "    offset = ofs;"),
 ("""        retry = retry + 1;
        __asm__("" : : "r"(retry));
        if (retry >= 4)
            break;
    }
    if (rslt == 0)
        rslt = 5;""",
  """        retry = retry + 1;
        if (retry >= 4)
            break;
    }
    if (rslt == 0)
        rslt = 5;"""),
]
