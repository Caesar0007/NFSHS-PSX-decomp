NL = chr(10)
C1 = ('          branchVoice = pSVar10;' + NL +
      '          __asm__("" : "+r"(branchVoice) : : "$2");' + NL +
      '          colourArg = (Car_tObj *)&(this->_base_Speaker).fColour;' + NL)
BASE = '          branchVoice = pSVar10;' + NL


def col(q):
    a = '(int)&(this->_base_Speaker).fColour'
    return ('          colourArg = (Car_tObj *)(%s & (%s | (int)%s));' + NL) % (a, a, q)


VARIANTS = [
    ("noclob_abs_bv", [(C1, BASE + col('branchVoice'))]),
    ("noclob_abs_ps", [(C1, BASE + col('pSVar10'))]),
    ("noclob_abs_this", [(C1, BASE + col('this'))]),
    ("noclob_absOR_bv", [(C1, BASE + ('          colourArg = (Car_tObj *)((int)&(this->_base_Speaker).fColour | ((int)&(this->_base_Speaker).fColour & (int)branchVoice));' + NL))]),
    ("keepclob_abs_bv", [(C1, C1.replace('          colourArg = (Car_tObj *)&(this->_base_Speaker).fColour;' + NL, col('branchVoice')))]),
]
