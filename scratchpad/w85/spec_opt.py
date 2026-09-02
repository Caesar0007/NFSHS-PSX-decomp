D = {
 'o141': '  __asm__("" : : "r"(packetCell));\n',
 'o142': '  __asm__("" : "=r"(x) : "0"(x));\n  __asm__("" : "=r"(x) : "0"(x));\n',
 'o1008': '          __asm__("" : : "r"(lim), "r"(lim), "r"(lim), "r"(lim));\n',
 'o2545': '      __asm__("" : "+r"(selectedChar));\n',
 'o2865': '    __asm__("" : : "r"(row));\n',
 'o2867': '    __asm__("" : "=r"(columnx) : "0"(columnx));\n',
 'o3083': '  *(volatile short *)&this->fEnableVal = sVar2;\n',
 'o3131': '  __asm__("" : : "r"(sv));   /* 05C read-only fence: extends sv\'s live range past\n                                v\'s death so local_alloc hands v the lower reg */\n',
}
REPL = {
 'o3083': '  this->fEnableVal = sVar2;\n',
}
CASES = [("BASE", [])]
for k, v in D.items():
    CASES.append(("remove " + k, [(v, REPL.get(k, ''))]))
CASES.append(("remove ALL", [(v, REPL.get(k, '')) for k, v in D.items()]))
