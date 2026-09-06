/* ---- CopSpeak_Flush__Fv  [COPSPEAK.CPP:1257-1259] SLD-VERIFIED ---- */
void CopSpeak_Flush(void)

{
  /* SYM-CODEGEN-CARRIER: request -- retaining the queue-entry base pointer
     preserves the retail signed-byte store while SYM records only i. */
  CopSpeak_tRequest *request;

  for (int i = CopSpeak_gQueuePlay; i != CopSpeak_gQueueHead;
       i = i < 0x3f ? i + 1 : 0) {
    request = &CopSpeak_gQueue[i];
    *(signed char *)&request->bank = -1;
  }
  return;
}
