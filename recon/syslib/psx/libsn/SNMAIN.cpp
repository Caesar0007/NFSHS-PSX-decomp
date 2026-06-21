/* syslib/psx/libsn/SNMAIN.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libsn.lib(SNMAIN.OBJ): the SN runtime.  __main is GCC's static-constructor invoker; here it
 *   is empty (NFS4 links no global C++ ctors through it).  The CRT entry point that follows it in the
 *   object (__SN_ENTRY_POINT/start @0x800E402C: set $sp, clear .bss from _bss_obj..._bss_objend, jump
 *   to main) is the target boot stub -- inherently machine code, not part of the recompilable tree. */

/* @0x800E4024 : __main -- no global constructors to run.
 * Definition is owned by syslib/psx/2mbyte/2mbyte.cpp; declared here only. */
extern "C" void __main(void);
