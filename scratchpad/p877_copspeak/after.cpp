/* ---- CopSpeak_PlayNextRequest__Fv  [COPSPEAK.CPP:1191-1238] SLD-VERIFIED ---- */
/* P877: one value chain through the already recovered `next` replaces the
 * unrecorded iVar3 queue index.  The conditional expression preserves retail's
 * separate input/output registers; in-place if/else was FAIL 8 (71/71), while
 * the ternary is PASS 71/71 with an exact debug twin. */
void CopSpeak_PlayNextRequest(void)

{
  CopSpeak_tRequest *r;
  int handle;
  /* ORIGINAL-NAME-RECOVERED: next -- the same retail COPSPEAK.CPP object
   * records `next` for the wraparound queue-output quantity in
   * CopSpeak_DirectRequest, CopSpeak_GenericBankRequest, and CopSpeak_Request. */
  int next;

  r = &CopSpeak_gQueue[next = CopSpeak_gQueuePlay];
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
    next = CopSpeak_gQueuePlay;
  }
  CopSpeak_gQueuePlay = next = next < 0x3f ? next + 1 : 0;
  return;
}
