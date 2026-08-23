<<<OLD
  __asm__("" : : "r"(sourceB), "r"(sourceB));
===NEW
  __asm__("" : : "r"(newR));
>>>
<<<OLD
  newColor.b = (u_char)(newB & ~7);
  newColor.g = (u_char)(newG & ~7);
  newColor.r = (u_char)(newR & ~7);
  newR = newColor.r;
===NEW
  newColor.r = (u_char)(newR & ~7);
  newColor.g = (u_char)(newG & ~7);
  newColor.b = (u_char)(newB & ~7);
>>>
