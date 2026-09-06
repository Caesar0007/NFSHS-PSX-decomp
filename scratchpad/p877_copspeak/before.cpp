/* ---- CopSpeak_PlayNextRequest__Fv  [COPSPEAK.CPP:1191-1238] SLD-VERIFIED ---- */
void CopSpeak_PlayNextRequest(void)

{
  /* SYM-CODEGEN-CARRIER: iVar3 -- indexing and advancing directly from
   * CopSpeak_gQueuePlay keeps 71 instructions but changes six oracle
   * allocation/scheduling instructions. */
  int iVar3;
  int handle;
  /* ORIGINAL-NAME-RECOVERED: next -- the same retail COPSPEAK.CPP object
   * records `next` for the wraparound queue-output quantity in
   * CopSpeak_DirectRequest, CopSpeak_GenericBankRequest, and CopSpeak_Request. */
  int next;
  CopSpeak_tRequest *r;

  iVar3 = CopSpeak_gQueuePlay;
  r = &CopSpeak_gQueue[iVar3];
  if (*(signed char *)&r->bank >= 0) {
    if (r->sfx == '\0') {
      if (CopSpeak_gSpchHandle != -1) {
        return;
      }
      CopSpeak_gCurrent = *r;
      handle = r->phrase;
      if (handle == -1) {
        handle = r->offset;
        handle = AudioCmn_GetAsyncSfx(*(signed char *)&r->bank,handle + 0x4000,true);
      }
      else {
        handle = AudioCmn_GetAsyncSfx(*(signed char *)&r->bank,handle,true);
      }
      if ((-1 < handle) || (*(signed char *)&r->bank == '\x03')) {
        CopSpeak_gSpchHandle = CopSpeak_Play(r,handle);
      }
    }
    CopSpeak_InitRequest(r);
    iVar3 = CopSpeak_gQueuePlay;
  }
  next = 0;
  if (iVar3 < 0x3f) {
    next = iVar3 + 1;
  }
  CopSpeak_gQueuePlay = next;
  return;
}
