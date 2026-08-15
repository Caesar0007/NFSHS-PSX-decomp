NL = chr(13) + chr(10)
ENV = {}

# main-loop declaration group, currently at case-0 scope (spans the alt block too)
DECLS = ("    u_int *prim;" + NL +
         "    int facet;" + NL +
         "    int id0;" + NL +
         "    int id1;" + NL +
         "    int id2;" + NL +
         "    int otzSum;" + NL +
         "    if ((envmap & 2U) == 0) {" + NL +
         "      iVar7 = facetIdx * 0xc;" + NL)

IN_IF = ("    if ((envmap & 2U) == 0) {" + NL +
         "      u_int *prim;" + NL +
         "      int facet;" + NL +
         "      int id0;" + NL +
         "      int id1;" + NL +
         "      int id2;" + NL +
         "      int otzSum;" + NL +
         "      iVar7 = facetIdx * 0xc;" + NL)

IN_IF_IDS_ONLY = ("    u_int *prim;" + NL +
                  "    int facet;" + NL +
                  "    int otzSum;" + NL +
                  "    if ((envmap & 2U) == 0) {" + NL +
                  "      int id0;" + NL +
                  "      int id1;" + NL +
                  "      int id2;" + NL +
                  "      iVar7 = facetIdx * 0xc;" + NL)

# body of the main while loop starts here
WHILE_HEAD = ("      iVar7 = facetIdx * 0xc;" + NL + "      while( true ) {" + NL +
              "        facetIdx = facetIdx - 1;" + NL +
              "        iVar7 = iVar7 + -0xc;" + NL +
              "        if (facetIdx == 0xffffffff) {" + NL +
              "          return;" + NL +
              "        }" + NL +
              "        facet = (int)obj->facet + iVar7;" + NL +
              "        id0 = *(u_char *)(facet + 3);" + NL +
              "        id1 = *(u_char *)(facet + 4);" + NL +
              "        id2 = *(u_char *)(facet + 5);" + NL)

WHILE_HEAD_LOCAL = ("      iVar7 = facetIdx * 0xc;" + NL + "      while( true ) {" + NL +
                    "        int id0;" + NL +
                    "        int id1;" + NL +
                    "        int id2;" + NL +
                    "        facetIdx = facetIdx - 1;" + NL +
                    "        iVar7 = iVar7 + -0xc;" + NL +
                    "        if (facetIdx == 0xffffffff) {" + NL +
                    "          return;" + NL +
                    "        }" + NL +
                    "        facet = (int)obj->facet + iVar7;" + NL +
                    "        id0 = *(u_char *)(facet + 3);" + NL +
                    "        id1 = *(u_char *)(facet + 4);" + NL +
                    "        id2 = *(u_char *)(facet + 5);" + NL)

DECLS_NOIDS = ("    u_int *prim;" + NL +
               "    int facet;" + NL +
               "    int otzSum;" + NL +
               "    if ((envmap & 2U) == 0) {" + NL)

PATCHES = [
    ("ctl", [(DECLS, DECLS)]),
    ("d1_group_into_if", [(DECLS, IN_IF)]),
    ("d2_ids_into_if", [(DECLS, IN_IF_IDS_ONLY)]),
    ("d3_ids_into_while", [(DECLS, DECLS_NOIDS), (WHILE_HEAD, WHILE_HEAD_LOCAL)]),
    ("d4_ids_into_while_only", [(WHILE_HEAD, WHILE_HEAD_LOCAL)]),
]
