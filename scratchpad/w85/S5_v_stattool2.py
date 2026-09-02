OLD = """  {
  int one = 1;
  __asm__ ("" : "=r" (one) : "0" (one));
  if (nNumber != one) {
  for (i = 1; i < nNumber; i++) {
    nADummy = nTemp[i];
    nBDummy = nIndex[i];
    for (j = i - 1; j >= 0 && nADummy < nTemp[j]; j--) {
      nTemp[j + 1] = nTemp[j];
      nIndex[j + 1] = nIndex[j];
    }
    nTemp[j + 1] = nADummy;
    nIndex[j + 1] = (short)nBDummy;
  }
  }
  }"""

def body(counter, head):
    return head + """
  for (%s = 1; %s < nNumber; %s++) {
    nADummy = nTemp[%s];
    nBDummy = nIndex[%s];
    for (j = %s - 1; j >= 0 && nADummy < nTemp[j]; j--) {
      nTemp[j + 1] = nTemp[j];
      nIndex[j + 1] = nIndex[j];
    }
    nTemp[j + 1] = nADummy;
    nIndex[j + 1] = (short)nBDummy;
  }
  }""" % (counter, counter, counter, counter, counter, counter)

VARIANTS = [
 ("G block-scope k", OLD, body("k", "  {\n  int k;\n  if (nNumber != 1) {")),
 ("H not-equal-neg",  OLD, body("i", "  {\n  if (!(nNumber == 1)) {")),
 ("I yoda loop test", OLD, """  {
  if (nNumber != 1) {
  for (i = 1; nNumber > i; i++) {
    nADummy = nTemp[i];
    nBDummy = nIndex[i];
    for (j = i - 1; j >= 0 && nADummy < nTemp[j]; j--) {
      nTemp[j + 1] = nTemp[j];
      nIndex[j + 1] = nIndex[j];
    }
    nTemp[j + 1] = nADummy;
    nIndex[j + 1] = (short)nBDummy;
  }
  }
  }"""),
 ("J i=1 before guard", OLD, """  {
  i = 1;
  if (nNumber != 1) {
  for (; i < nNumber; i++) {
    nADummy = nTemp[i];
    nBDummy = nIndex[i];
    for (j = i - 1; j >= 0 && nADummy < nTemp[j]; j--) {
      nTemp[j + 1] = nTemp[j];
      nIndex[j + 1] = nIndex[j];
    }
    nTemp[j + 1] = nADummy;
    nIndex[j + 1] = (short)nBDummy;
  }
  }
  }"""),
 ("K i+=1", OLD, """  {
  if (nNumber != 1) {
  for (i = 1; i < nNumber; i += 1) {
    nADummy = nTemp[i];
    nBDummy = nIndex[i];
    for (j = i - 1; j >= 0 && nADummy < nTemp[j]; j--) {
      nTemp[j + 1] = nTemp[j];
      nIndex[j + 1] = nIndex[j];
    }
    nTemp[j + 1] = nADummy;
    nIndex[j + 1] = (short)nBDummy;
  }
  }
  }"""),
 ("L goto-skip", OLD, """  {
  if (nNumber == 1) goto SortDone;
  for (i = 1; i < nNumber; i++) {
    nADummy = nTemp[i];
    nBDummy = nIndex[i];
    for (j = i - 1; j >= 0 && nADummy < nTemp[j]; j--) {
      nTemp[j + 1] = nTemp[j];
      nIndex[j + 1] = nIndex[j];
    }
    nTemp[j + 1] = nADummy;
    nIndex[j + 1] = (short)nBDummy;
  }
SortDone: ;
  }"""),
 ("M j-first-decl-order", OLD, """  {
  if (nNumber != 1) {
  i = 1;
  for (; i < nNumber; i++) {
    nADummy = nTemp[i];
    nBDummy = nIndex[i];
    for (j = i - 1; j >= 0 && nADummy < nTemp[j]; j--) {
      nTemp[j + 1] = nTemp[j];
      nIndex[j + 1] = nIndex[j];
    }
    nTemp[j + 1] = nADummy;
    nIndex[j + 1] = (short)nBDummy;
  }
  }
  }"""),
]
