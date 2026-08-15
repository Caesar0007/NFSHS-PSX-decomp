/* vtables_tdialog.cpp -- #75 data-materialization: tDialog-family vtables (9).
 * Real nfs4-f.exe bytes; __vtbl_ptr_type; size = null-delimited rodata segment. @0xVA breadcrumbs.
 * NOT original layout (each obj owned its vtable in rodata); self-contained + faithful + links. */
#include "../../nfs4_types.h"
extern "C" int __pure_virtual(...);   /* @0x800e4354 (eaclib cfront runtime) */

/* w66-a2: retail's dtor slot holds the destructor's OWN address (verified in
 * asm/data/rdata_80010000_r0*.rodata.s: `.word ___<len><Class>`), so the slots
 * below name the real `___<len><Class>` symbols directly.  The former fabricated
 * per-class wrappers `static int wrap(X *p){ p->~X(); return 0; }` are gone: they
 * were an artifact of C++ forbidding `&Class::~Class`.  Each symbol is a real fn
 * (w65-a3's extern-"C" dtor device / a real out-of-line member dtor renamed
 * `_._`->`___` by build.py), defined in fedialog/fecars/femenu/fetourn/fetracks. */
extern "C" void ___17tDialogBackUpOnly(void *thisp);   /* ~tDialogBackUpOnly */
extern "C" void ___11tDialogBase(void *thisp);   /* ~tDialogBase */
extern "C" void ___11tDialogHelp(void *thisp);   /* ~tDialogHelp */
extern "C" void ___18tDialogInteractive(void *thisp);   /* ~tDialogInteractive */
extern "C" void ___20tDialogMessageString(void *thisp);   /* ~tDialogMessageString */
extern "C" void ___31tDialogMessageStringWithTimeout(void *thisp);   /* ~tDialogMessageStringWithTimeout */
extern "C" void ___21tDialogNoInputMessage(void *thisp);   /* ~tDialogNoInputMessage */
extern "C" void ___12tDialogYesNo(void *thisp);   /* ~tDialogYesNo */
extern "C" void ___15tDialogYesNoMem(void *thisp);   /* ~tDialogYesNoMem */
extern "C" void ___15tDialogYesNoTri(void *thisp);   /* ~tDialogYesNoTri */

__vtbl_ptr_type tDialogBase_vtable[12] = {   /* @0x800105b0 */
  {0, 0, (int (*)(...))0},                           /* @0x800105b0  null */
  {0, 0, (int (*)(...))&tScreen::GetShapeInfo},      /* @0x800105b8  GetShapeInfo__7tScreenRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreen::DrawBackground},    /* @0x800105c0  DrawBackground__7tScreen */
  {0, 0, (int (*)(...))&tScreen::DrawForeground},    /* @0x800105c8  DrawForeground__7tScreen */
  {0, 0, (int (*)(...))&___11tDialogBase},        /* @0x800105d0  ~tDialogBase */
  {0, 0, (int (*)(...))&tScreen::PreLoad},           /* @0x800105d8  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreen::Initialize},        /* @0x800105e0  Initialize__7tScreen */
  {0, 0, (int (*)(...))&tScreen::Cleanup},           /* @0x800105e8  Cleanup__7tScreen */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished}, /* @0x800105f0  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tDialogBase::ProcessInput},  /* @0x800105f8  ProcessInput__11tDialogBase7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&__pure_virtual},             /* @0x80010600  __pure_virtual */
  {0, 0, (int (*)(...))&tDialogBase::Draw},          /* @0x80010608  Draw__11tDialogBase */
};
__vtbl_ptr_type tDialogHelp_vtable[12] = {   /* @0x80010550 */
  {0, 0, (int (*)(...))0},                           /* @0x80010550  null */
  {0, 0, (int (*)(...))&tScreen::GetShapeInfo},      /* @0x80010558  GetShapeInfo__7tScreenRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreen::DrawBackground},    /* @0x80010560  DrawBackground__7tScreen */
  {0, 0, (int (*)(...))&tScreen::DrawForeground},    /* @0x80010568  DrawForeground__7tScreen */
  {0, 0, (int (*)(...))&___11tDialogHelp},        /* @0x80010570  ~tDialogHelp */
  {0, 0, (int (*)(...))&tScreen::PreLoad},           /* @0x80010578  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreen::Initialize},        /* @0x80010580  Initialize__7tScreen */
  {0, 0, (int (*)(...))&tScreen::Cleanup},           /* @0x80010588  Cleanup__7tScreen */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished}, /* @0x80010590  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tDialogBase::ProcessInput},  /* @0x80010598  ProcessInput__11tDialogBase7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tDialogHelp::CalculateDimensions}, /* @0x800105a0  CalculateDimensions__11tDialogHelp */
  {0, 0, (int (*)(...))&tDialogHelp::Draw},          /* @0x800105a8  Draw__11tDialogHelp */
};
__vtbl_ptr_type tDialogInteractive_vtable[12] = {   /* @0x800103d0 */
  {0, 0, (int (*)(...))0},                           /* @0x800103d0  null */
  {0, 0, (int (*)(...))&tScreen::GetShapeInfo},      /* @0x800103d8  GetShapeInfo__7tScreenRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreen::DrawBackground},    /* @0x800103e0  DrawBackground__7tScreen */
  {0, 0, (int (*)(...))&tScreen::DrawForeground},    /* @0x800103e8  DrawForeground__7tScreen */
  {0, 0, (int (*)(...))&___18tDialogInteractive}, /* @0x800103f0  ~tDialogInteractive */
  {0, 0, (int (*)(...))&tScreen::PreLoad},           /* @0x800103f8  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreen::Initialize},        /* @0x80010400  Initialize__7tScreen */
  {0, 0, (int (*)(...))&tScreen::Cleanup},           /* @0x80010408  Cleanup__7tScreen */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished}, /* @0x80010410  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tDialogBase::ProcessInput},  /* @0x80010418  ProcessInput__11tDialogBase7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tDialogMessageString::CalculateDimensions}, /* @0x80010420  CalculateDimensions__20tDialogMessageString */
  {0, 0, (int (*)(...))&tDialogMessageString::Draw}, /* @0x80010428  Draw__20tDialogMessageString */
};
__vtbl_ptr_type tDialogMessageString_vtable[12] = {   /* @0x800104f0 */
  {0, 0, (int (*)(...))0},                           /* @0x800104f0  null */
  {0, 0, (int (*)(...))&tScreen::GetShapeInfo},      /* @0x800104f8  GetShapeInfo__7tScreenRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreen::DrawBackground},    /* @0x80010500  DrawBackground__7tScreen */
  {0, 0, (int (*)(...))&tScreen::DrawForeground},    /* @0x80010508  DrawForeground__7tScreen */
  {0, 0, (int (*)(...))&___20tDialogMessageString}, /* @0x80010510  ~tDialogMessageString */
  {0, 0, (int (*)(...))&tScreen::PreLoad},           /* @0x80010518  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreen::Initialize},        /* @0x80010520  Initialize__7tScreen */
  {0, 0, (int (*)(...))&tScreen::Cleanup},           /* @0x80010528  Cleanup__7tScreen */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished}, /* @0x80010530  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tDialogBase::ProcessInput},  /* @0x80010538  ProcessInput__11tDialogBase7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tDialogMessageString::CalculateDimensions}, /* @0x80010540  CalculateDimensions__20tDialogMessageString */
  {0, 0, (int (*)(...))&tDialogMessageString::Draw}, /* @0x80010548  Draw__20tDialogMessageString */
};
/* tDialogMessageStringWithTimeout vtable @0x80010098 (M10): byte-identical to tDialogMessageString_vtable
 * EXCEPT slot 4 (dtor) = ~tDialogMessageStringWithTimeout (@0x80015760) vs ~tDialogMessageString. Verified
 * by per-slot fnptr compare against nfs4-f.exe @0x80010098 vs @0x800104F0 (11/12 identical). */
__vtbl_ptr_type tDialogMessageStringWithTimeout_vtable[12] = {   /* @0x80010098 */
  {0, 0, (int (*)(...))0},                           /* @0x80010098  null */
  {0, 0, (int (*)(...))&tScreen::GetShapeInfo},      /* @0x800100a0  GetShapeInfo__7tScreenRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreen::DrawBackground},    /* @0x800100a8  DrawBackground__7tScreen */
  {0, 0, (int (*)(...))&tScreen::DrawForeground},    /* @0x800100b0  DrawForeground__7tScreen */
  {0, 0, (int (*)(...))&___31tDialogMessageStringWithTimeout}, /* @0x800100b8  ~tDialogMessageStringWithTimeout (@0x80015760) */
  {0, 0, (int (*)(...))&tScreen::PreLoad},           /* @0x800100c0  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreen::Initialize},        /* @0x800100c8  Initialize__7tScreen */
  {0, 0, (int (*)(...))&tScreen::Cleanup},           /* @0x800100d0  Cleanup__7tScreen */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished}, /* @0x800100d8  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tDialogBase::ProcessInput},  /* @0x800100e0  ProcessInput__11tDialogBase7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tDialogMessageString::CalculateDimensions}, /* @0x800100e8  CalculateDimensions__20tDialogMessageString */
  {0, 0, (int (*)(...))&tDialogMessageString::Draw}, /* @0x800100f0  Draw__20tDialogMessageString */
};
__vtbl_ptr_type tDialogNoInputMessage_vtable[12] = {   /* @0x80010430 */
  {0, 0, (int (*)(...))0},                           /* @0x80010430  null */
  {0, 0, (int (*)(...))&tScreen::GetShapeInfo},      /* @0x80010438  GetShapeInfo__7tScreenRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreen::DrawBackground},    /* @0x80010440  DrawBackground__7tScreen */
  {0, 0, (int (*)(...))&tScreen::DrawForeground},    /* @0x80010448  DrawForeground__7tScreen */
  {0, 0, (int (*)(...))&___21tDialogNoInputMessage}, /* @0x80010450  ~tDialogNoInputMessage */
  {0, 0, (int (*)(...))&tScreen::PreLoad},           /* @0x80010458  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreen::Initialize},        /* @0x80010460  Initialize__7tScreen */
  {0, 0, (int (*)(...))&tScreen::Cleanup},           /* @0x80010468  Cleanup__7tScreen */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished}, /* @0x80010470  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tDialogNoInputMessage::ProcessInput}, /* @0x80010478  ProcessInput__21tDialogNoInputMessage7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tDialogMessageString::CalculateDimensions}, /* @0x80010480  CalculateDimensions__20tDialogMessageString */
  {0, 0, (int (*)(...))&tDialogMessageString::Draw}, /* @0x80010488  Draw__20tDialogMessageString */
};
__vtbl_ptr_type tDialogBackUpOnly_vtable[12] = {   /* @0x80010490 */
  {0, 0, (int (*)(...))0},                           /* @0x80010490  null */
  {0, 0, (int (*)(...))&tScreen::GetShapeInfo},      /* @0x80010498  GetShapeInfo__7tScreenRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreen::DrawBackground},    /* @0x800104a0  DrawBackground__7tScreen */
  {0, 0, (int (*)(...))&tScreen::DrawForeground},    /* @0x800104a8  DrawForeground__7tScreen */
  {0, 0, (int (*)(...))&___17tDialogBackUpOnly},  /* @0x800104b0  ~tDialogBackUpOnly */
  {0, 0, (int (*)(...))&tScreen::PreLoad},           /* @0x800104b8  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreen::Initialize},        /* @0x800104c0  Initialize__7tScreen */
  {0, 0, (int (*)(...))&tScreen::Cleanup},           /* @0x800104c8  Cleanup__7tScreen */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished}, /* @0x800104d0  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tDialogBackUpOnly::ProcessInput}, /* @0x800104d8  ProcessInput__17tDialogBackUpOnly7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tDialogMessageString::CalculateDimensions}, /* @0x800104e0  CalculateDimensions__20tDialogMessageString */
  {0, 0, (int (*)(...))&tDialogMessageString::Draw}, /* @0x800104e8  Draw__20tDialogMessageString */
};
__vtbl_ptr_type tDialogYesNo_vtable[12] = {   /* @0x80010370 */
  {0, 0, (int (*)(...))0},                           /* @0x80010370  null */
  {0, 0, (int (*)(...))&tScreen::GetShapeInfo},      /* @0x80010378  GetShapeInfo__7tScreenRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreen::DrawBackground},    /* @0x80010380  DrawBackground__7tScreen */
  {0, 0, (int (*)(...))&tScreen::DrawForeground},    /* @0x80010388  DrawForeground__7tScreen */
  {0, 0, (int (*)(...))&___12tDialogYesNo},       /* @0x80010390  ~tDialogYesNo */
  {0, 0, (int (*)(...))&tScreen::PreLoad},           /* @0x80010398  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreen::Initialize},        /* @0x800103a0  Initialize__7tScreen */
  {0, 0, (int (*)(...))&tScreen::Cleanup},           /* @0x800103a8  Cleanup__7tScreen */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished}, /* @0x800103b0  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tDialogYesNo::ProcessInput}, /* @0x800103b8  ProcessInput__12tDialogYesNo7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tDialogYesNo::CalculateDimensions}, /* @0x800103c0  CalculateDimensions__12tDialogYesNo */
  {0, 0, (int (*)(...))&tDialogYesNo::Draw},         /* @0x800103c8  Draw__12tDialogYesNo */
};
__vtbl_ptr_type tDialogYesNoTri_vtable[12] = {   /* @0x800102b0 */
  {0, 0, (int (*)(...))0},                           /* @0x800102b0  null */
  {0, 0, (int (*)(...))&tScreen::GetShapeInfo},      /* @0x800102b8  GetShapeInfo__7tScreenRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreen::DrawBackground},    /* @0x800102c0  DrawBackground__7tScreen */
  {0, 0, (int (*)(...))&tScreen::DrawForeground},    /* @0x800102c8  DrawForeground__7tScreen */
  {0, 0, (int (*)(...))&___15tDialogYesNoTri},    /* @0x800102d0  ~tDialogYesNoTri */
  {0, 0, (int (*)(...))&tScreen::PreLoad},           /* @0x800102d8  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreen::Initialize},        /* @0x800102e0  Initialize__7tScreen */
  {0, 0, (int (*)(...))&tScreen::Cleanup},           /* @0x800102e8  Cleanup__7tScreen */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished}, /* @0x800102f0  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tDialogYesNoTri::ProcessInput}, /* @0x800102f8  ProcessInput__15tDialogYesNoTri7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tDialogYesNo::CalculateDimensions}, /* @0x80010300  CalculateDimensions__12tDialogYesNo */
  {0, 0, (int (*)(...))&tDialogYesNo::Draw},         /* @0x80010308  Draw__12tDialogYesNo */
};
__vtbl_ptr_type tDialogYesNoMem_vtable[12] = {   /* @0x80010310 */
  {0, 0, (int (*)(...))0},                           /* @0x80010310  null */
  {0, 0, (int (*)(...))&tScreen::GetShapeInfo},      /* @0x80010318  GetShapeInfo__7tScreenRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreen::DrawBackground},    /* @0x80010320  DrawBackground__7tScreen */
  {0, 0, (int (*)(...))&tScreen::DrawForeground},    /* @0x80010328  DrawForeground__7tScreen */
  {0, 0, (int (*)(...))&___15tDialogYesNoMem},    /* @0x80010330  ~tDialogYesNoMem */
  {0, 0, (int (*)(...))&tScreen::PreLoad},           /* @0x80010338  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreen::Initialize},        /* @0x80010340  Initialize__7tScreen */
  {0, 0, (int (*)(...))&tScreen::Cleanup},           /* @0x80010348  Cleanup__7tScreen */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished}, /* @0x80010350  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tDialogYesNoMem::ProcessInput}, /* @0x80010358  ProcessInput__15tDialogYesNoMem7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tDialogYesNo::CalculateDimensions}, /* @0x80010360  CalculateDimensions__12tDialogYesNo */
  {0, 0, (int (*)(...))&tDialogYesNo::Draw},         /* @0x80010368  Draw__12tDialogYesNo */
};
