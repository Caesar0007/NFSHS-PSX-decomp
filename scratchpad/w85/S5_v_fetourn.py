OLD = '    do {\n      rankVal = this->fRanking[i];\n      int next;\n      __asm__("" : "=r"(next) : "0"(i + 1), "r"(rankVal));\n      char *ranked = (char *)this + rankVal * (int)sizeof(tCompetitor);\n      i = next;\n      ranked[294] = (uchar)i;\n    } while (i < 6);'
VARIANTS = [
  ('P1 natural', OLD, '    do {\n      rankVal = this->fRanking[i];\n      char *ranked = (char *)this + rankVal * (int)sizeof(tCompetitor);\n      i = i + 1;\n      ranked[294] = (uchar)i;\n    } while (i < 6);'),
  ('P2 incr first', OLD, '    do {\n      rankVal = this->fRanking[i];\n      i = i + 1;\n      ((char *)this + rankVal * (int)sizeof(tCompetitor))[294] = (uchar)i;\n    } while (i < 6);'),
  ('P3 next local plain', OLD, '    do {\n      rankVal = this->fRanking[i];\n      int next = i + 1;\n      char *ranked = (char *)this + rankVal * (int)sizeof(tCompetitor);\n      i = next;\n      ranked[294] = (uchar)i;\n    } while (i < 6);'),
  ('P4 store then incr', OLD, '    do {\n      rankVal = this->fRanking[i];\n      char *ranked = (char *)this + rankVal * (int)sizeof(tCompetitor);\n      ranked[294] = (uchar)(i + 1);\n      i = i + 1;\n    } while (i < 6);'),
]
