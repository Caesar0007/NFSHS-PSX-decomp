# SYM-to-source declaration audit

Target: `C:\Temp\nfs4-decomp\recon\frontend\common`
Trusted SYM: `C:\Temp\claud\dumpsym_clean\dumpsym_src\nfs4-f-v3.txt`

This is a review queue, not an auto-fix list. Missing retail names are
strong evidence; extra source names can be matching carriers or decompiler
temporaries and must be tested against the function oracle before removal.
GCC-v2-mangled function/EXT names are used only as linkage keys; source
functions are mapped to their demangled C++ names and class scopes.

## Summary

- SYM functions in target TUs: 838
- Mapped to reconstructed definitions: 833 (792 demangled class/name maps)
- Source definitions still using mangled linkage identifiers: 0
- Explicit deleting-destructor ABI carriers: 41
- Explicit cross-TU ownership closures: 0
- Declaration-clean mapped functions: 781
- Missing SYM names: 0
- Extra source-local names: 46
- Type-comparison findings: 9
- Recognized ABI/debug-equivalent type encodings: 249
  (generic-function-pointer=12, promoted-stack-argument=28, reference-as-pointer=209)
- Function storage-class findings: 9
- Implicit aggregate special members (source body correctly absent): 2
- Explicit oracle-receipted carrier mappings: 3
- Explicit restored inline-local mappings: 64
- Explicit restored macro-local mappings: 0
- Explicit compact static-local mappings: 0
- Exact cross-build/canonical name recoveries: 0
- Explicit linkage-proven ABI parameters omitted from SYM: 22
- Explicit source-only codegen carriers: 476
- Explicit oracle-proven function type overrides: 0
- Functions needing mapping review: 3
- SYM object-owned data records in target TUs: 190
- Compact address-only data records mapped by exact name+VA: 159
- Mapped source global definitions: 171
- Special SYM vtable records mapped: 0/0
- Blob-backed object globals: 19
- Missing/extra global definitions: 0/0
- Global storage-class findings: 0
- Explicit oracle-proven global storage overrides: 0
- Global type findings: 0
- Recognized global debug-equivalent types: 0
  (none)
- Explicit measured global array carriers: 0
- Explicit source-only global/data-layout carriers: 0
- Explicit host-only fallback globals: 0
- Explicit linker-folded shared common globals: 0
- Explicit oracle-proven global type overrides: 2

## Review queue

### `_._31tDialogMessageStringWithTimeout` (0x80015760, fedialog.h:68, map=header-owner)

- Storage: SYM STAT vs source EXT

### `_._15tDialogYesNoTri` (0x80019ec4, fedialog.h:1036, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._15tDialogYesNoMem` (0x80019ee4, fedialog.h:1047, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._12tDialogYesNo` (0x80019f04, fedialog.h:1054, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._18tDialogInteractive` (0x80019f24, fedialog.h:1061, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`
- Storage: SYM STAT vs source EXT

### `_._21tDialogNoInputMessage` (0x80019f44, fedialog.h:1070, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._17tDialogBackUpOnly` (0x80019f64, fedialog.h:1081, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._20tDialogMessageString` (0x80019f84, fedialog.h:1087, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._11tDialogHelp` (0x80019fa4, fedialog.h:1098, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._11tDialogBase` (0x80019fc4, fedialog.h:1113, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._29tMenuItemOptionsTwoItemChoice` (0x8001bf00, femenuextended.h:1261, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._31tMenuItemOptionsLeftRightChoice` (0x8001bf20, femenuextended.h:1272, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `Draw__27tMenuItemGoToMenuNFS4Buttonb` (0x8001bf40, femenuextended.h:1278, map=header-owner-signature)

- Extra source locals: `selected`

### `_._35tInsideBoxControllerLeftRightSlider` (0x80020bb8, femenuoptions.h:3264, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._19tMemoryCardMenuItem` (0x80020bd8, femenuoptions.h:3272, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._27tMenuItemGoToMenuButtonFade` (0x80020bf8, femenuoptions.h:3277, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._17tUserNameMenuItem` (0x80020c18, femenuoptions.h:3282, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._34tMenuItemControllerLeftRightChoice` (0x80020c38, femenuoptions.h:3287, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._29tMenuItemOnOffLeftRightChoice` (0x80020c58, femenuoptions.h:3292, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._31tMenuItemDisplayLeftRightChoice` (0x80020c78, femenuoptions.h:3297, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._25tMenuItemSlidingActivated` (0x80020c98, femenuoptions.h:3302, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._22tMenuItemLeftRightFade` (0x80020cb8, femenuoptions.h:3307, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `GetPSXPadValue__Fii` (0x80027194, front.cpp:643, map=exact)

- Extra source locals: `padBase`

### `Front_BuildStream__FPi` (0x8002a738, front.cpp:2744, map=exact)

- Extra source locals: `t`

### `TransitionIsFinished__32tBlankMenuItemGoToMenuNFS4Button` (0x800321c0, femenuoptions.h:3522, map=header-owner)

- Storage: SYM STAT vs source EXT

### `Draw__32tBlankMenuItemGoToMenuNFS4Buttoniib` (0x800321c8, femenuoptions.h:3539, map=header-owner-signature)

- Storage: SYM STAT vs source EXT

### `Draw__32tBlankMenuItemGoToMenuNFS4Buttonb` (0x800321d0, femenuoptions.h:3540, map=header-owner-signature)

- Storage: SYM STAT vs source EXT

### `_._32tBlankMenuItemGoToMenuNFS4Button` (0x800321d8, femenuoptions.h:3549, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`
- Storage: SYM STAT vs source EXT

### `TransitionIsFinished__33tBlankMenuItemNFS4LeftRightChoice` (0x800321f8, femenuextended.h:3554, map=header-owner)

- Storage: SYM STAT vs source EXT

### `Draw__33tBlankMenuItemNFS4LeftRightChoiceiib` (0x80032200, femenuextended.h:3560, map=header-owner)

- Storage: SYM STAT vs source EXT

### `_._33tBlankMenuItemNFS4LeftRightChoice` (0x80032208, femenuextended.h:3569, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`
- Storage: SYM STAT vs source EXT

### `DrawBackground__11tScreenMain` (0x800379c0, screenmain.cpp:390, map=exact)

- Extra source locals: `curMenu`

### `_._11tScreenMain` (0x80038b44, screenmain.h:908, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._16tScreenPinkSlips` (0x800397cc, screenpinkslips.h:386, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._24tScreenPinkSlipStandings` (0x8003a88c, screenpost.h:587, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._31tScreenTournamentStandings3item` (0x8003a8ac, screenpost.h:597, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._26tScreenTournamentStandings` (0x8003a8cc, screenpost.h:607, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `DrawOverlay__16tScreenCarSelectP8tOverlay` (0x8003ad00, screencarselect.cpp:202, map=exact)

- Extra source locals: `curItem`

### `_._25tScreenPinkSlipsCarSelect` (0x8003f6d0, screencarselect.h, map=unmapped)

- Mapping: unresolved; inspect constructor/operator/overload spelling.

### `_._25tScreenCarSelectTwoPlayer` (0x8003f714, screencarselect.h, map=unmapped)

- Mapping: unresolved; inspect constructor/operator/overload spelling.

### `_._20tScreenCarSelectDuel` (0x8003f758, screencarselect.h:2825, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._17tScreenTrophyInfo` (0x800415e0, screentrophyinfo.h:215, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._18tScreenTrackSelect` (0x800421d4, screentracks.h:518, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._16tScreenTrackInfo` (0x80042628, screentrackinfo.h:127, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._19tScreenTrackRecords` (0x800430f8, screentrackrecords.h:243, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._23tScreenControllerConfig` (0x8004590c, screencontroller.h, map=unmapped)

- Mapping: unresolved; inspect constructor/operator/overload spelling.

### `_._14tScreenDisplay` (0x80045a04, screendisplay.h:46, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._12tScreenAudio` (0x800462fc, screenaudio.h:363, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._14tScreenMemcard` (0x80047e3c, screenmemcard.h:1066, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._25tScreenTournamentCongrats` (0x800497a0, screencongrats.h:972, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._23tScreenBeTheCopCongrats` (0x800497c0, screencongrats.h:980, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._23tScreenPinkSlipCongrats` (0x800497e0, screencongrats.h:988, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._23tScreenTournamentTrophy` (0x80049800, screencongrats.h:996, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._15tScreenCongrats` (0x80049820, screencongrats.h:1004, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._15tScreenUserName` (0x8004b7d4, screenusername.h:397, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

## Implicit aggregate special members

- `__11tAllScreens` (0x8002baf4, `front.cpp`): implicit `tAllScreens` constructor; emitted from the aggregate member graph at the recorded declaration line, so an explicit source body would be incorrect.
- `_._11tAllScreens` (0x8002bf0c, `front.cpp`): implicit `tAllScreens` destructor; emitted from the aggregate member graph at the recorded declaration line, so an explicit source body would be incorrect.
## Explicit SYM carrier/optimization mappings

- `FECheat_HandleActivation__F10tCheatCode`: `num`
- `SetupCurrCredit__14tCreditManager`: `lasttick`
- `DrawBackground__25tScreenCarSelectTwoPlayer`: `carInfo`

## Explicit restored inline-local mappings

- `DrawHelpIcons__14tFEApplication`: `this` from `HasOptionsMenu`
- `MainLoop__14tFEApplicationP5tMenu`: `this` from `IsVisible`, `this` from `SetString`
- `CalculateDimensions__11tDialogHelp`: `this` from `CanContinue`, `this` from `HasFlag`, `this` from `HasFlag`
- `Draw__11tDialogHelp`: `this` from `CalculateDimensionsVirtual`
- `Run__18tDialogInteractive`: `player` from `DialogCanProcessCircle`, `this` from `CalculateDimensionsVirtual`, `this` from `IsVisible`, `this` from `ProcessInputVirtual`
- `Draw__12tDialogYesNo`: `this` from `CalculateDimensionsVirtual`
- `FECheat_ActivateCheat__FPc`: `this` from `SetString`
- `ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand`: `this` from `IsDisabled`
- `ProcessInput__24tMenuItemLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand`: `this` from `IsDisabled`
- `GenericMenuSaveGame__Fi`: `this` from `SetMessage`, `this` from `SetMessage`, `this` from `SetString`
- `MenuExtended_GoToRace__FR12tMenuCommand`: `this` from `MessagePopup`, `this` from `SetString`, `this` from `SetString`, `this` from `SetString`, `this` from `SetString`
- `MenuExtended_GoTo2PlayerRace__FR12tMenuCommand`: `this` from `CurrentPlayer`, `this` from `CurrentPlayer`, `this` from `MessagePopup`, `this` from `SetString`, `this` from `SetString`, `this` from `SetString`
- `MenuExtended_GoToTournTrackInfo__FR12tMenuCommand`: `this` from `SetString`
- `MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand`: `this` from `SetString`
- `MenuExtended_EnterUserName__FR12tMenuCommand`: `data` from `SetUserNameData`, `m` from `SetCallingMenu`, `this` from `SetCallingMenu`, `this` from `SetUserNameData`
- `MenuExtended_SellCar__FR12tMenuCommand`: `this` from `SetString`
- `MenuExtended_LoadGame__FR12tMenuCommand`: `this` from `SetChoices`
- `MenuExtended_PostGameMenu__FR12tMenuCommand`: `this` from `SetDrawMoney`
- `MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand`: `m` from `SetCallingMenu`, `this` from `SetCallingMenu`, `this` from `SetPostGameNameData`
- `__15tGlobalMenuDefs`: `child` from `A1_SetChildMenu`
- `Confirm__Fii`: `this` from `SetString`
- `SaveGame__Fs`: `this` from `SetString`
- `LoadGame__FsbT1`: `this` from `SetString`, `this` from `SetString`
- `ProcessInput__16tScreenCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand`: `this` from `SetTextDescription`
- `DrawBackground__16tScreenCarSelect`: `this` from `GetPlayer`
- `DrawSliders__16tScreenCarSelectR8tCarInfoss`: `carInfo` from `CarStatValue`, `carStat` from `CarStatValue`, `result` from `CarStatValue`
- `DrawForeground__20tScreenCarSelectDuel`: `carInfo` from `CarStatValue`, `carStat` from `CarStatValue`, `result` from `CarStatValue`
- `GetCar__25tScreenCarSelectTwoPlayerR8tCarInfo`: `this` from `GetPlayer`
- `DrawForeground__25tScreenCarSelectTwoPlayer`: `carInfo` from `CarStatValue`, `carStat` from `CarStatValue`, `result` from `CarStatValue`
- `GetCar__25tScreenPinkSlipsCarSelectR8tCarInfo`: `this` from `GetPlayer`
- `DoMemCardStuff__25tScreenPinkSlipsCarSelect`: `this` from `GetPlayer`
- `SetDialog__25tScreenPinkSlipsCarSelect`: `this` from `GetPlayer`
- `SetCurrentController__23tScreenControllerConfigb`: `this` from `SetString`
- `DrawController__23tScreenControllerConfig`: `range` from `ControllerTwistRange`
- `DrawForeground__23tScreenControllerConfig`: `this` from `IsVisible`

## Explicit compact static-local mappings


## Exact cross-build/canonical name recoveries


## Explicit restored macro-local mappings


## Explicit linkage-proven ABI parameters omitted from SYM

- `ProcessInput__11tDialogBase7tPlayerR13tInputKeyTypeR12tMenuCommand`: `command`, `fromPlayer`
- `Draw__31tMenuItemDisplayLeftRightChoiceiib`: `selected`
- `Draw__29tMenuItemOnOffLeftRightChoiceiib`: `selected`
- `Draw__29tMenuItemLeftRightAudioSlideriib`: `selected`
- `ProcessInput__18tInsideBoxSongMenu7tPlayerR13tInputKeyTypeR12tMenuCommand`: `command`, `fromPlayer`
- `Draw__34tMenuItemControllerLeftRightChoiceiib`: `selected`
- `Draw__25tInsideBoxLeftRightSlideriiib`: `selected`
- `ProcessInput__22tInsideBoxTwoWaySlider7tPlayerR13tInputKeyTypeR12tMenuCommand`: `command`, `fromPlayer`
- `Draw__22tInsideBoxTwoWaySlideriiib`: `selected`
- `ProcessInput__17tUserNameMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand`: `command`, `fromPlayer`
- `Draw__17tUserNameMenuItemb`: `selected`
- `Draw__19tMemoryCardMenuItemb`: `selected`
- `ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand`: `command`
- `ProcessInput__24tMenuItemLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand`: `command`
- `MenuExtended_SellCar__FR12tMenuCommand`: `command`
- `MenuExtended_BuyCar__FR12tMenuCommand`: `command`
- `ProcessInput__18tScreenTrackSelect7tPlayerR13tInputKeyTypeR12tMenuCommand`: `command`, `player`

## Explicit source-only codegen carriers

- `Redraw__14tFEApplication`: `globalMenuDefs`, `pal2`, `pc`
- `DisplayHelp__14tFEApplications`: `this_tDialogHelp`
- `RunDemoVideo__14tFEApplication`: `largest`, `menu`, `vtbl`
- `MainLoop__14tFEApplicationP5tMenu`: `currentTicks`, `helpDialog`, `memcardDialog`
- `RunPostGame__14tFEApplication`: `item`, `screen`
- `CalcUsedPrice__11tCarManagers`: `carID`, `upgrades`
- `SellCar__11tCarManagerss`: `lastSlotOffset`, `newSelection`, `numCars`, `playerFrontEnd`, `previousSlotOffset`, `removedSlotOffset`, `selectedSlotOffset`
- `RemoveFromPinkSlipsList__11tCarManagerss`: `lastSlotOffset`, `newSelection`, `numCars`, `playerFrontEnd`, `previousSlotOffset`, `removedSlotOffset`, `selectedSlotOffset`
- `GetStockCar__11tCarManagersR8tCarInfo`: `viewable`
- `GetNumTourneyCars__11tCarManagers`: `carID`
- `ValidCar__16tListIteratorCar7tPlayerc`: `carClass`
- `Increment__21tListIteratorCarColor7tPlayer`: `fNumColors`, `notWrapped`
- `Draw__11tDialogHelp`: `bufferPtr`, `firstTick`, `loadedTicks`
- `MenuNFS4_DrawTextBox__FiR4RECTissbT5`: `fade`, `selFade`, `textType`
- `Draw__9tMenuNFS4`: `iVar3`, `iVar4`
- `TransitionOff__12tMenuOptions`: `iVar1`
- `TransitionOn__12tMenuOptions`: `enterTicks`, `itemCursor`
- `SubtractiveBox__Fiiiiiiii`: `packetCell`
- `UpdateTransition__27tMenuItemGoToMenuButtonFadeb`: `iVar2`
- `UpdateTransition__22tMenuItemLeftRightFadeb`: `iVar2`
- `UpdateTransition__12tOptionsMenu`: `adjusted`, `citem`, `entry`, `item`
- `Draw__12tOptionsMenu`: `adjusted`, `entry`
- `ProcessInput__14tInsideBoxMenu7tPlayerR13tInputKeyTypeR12tMenuCommand`: `tVar2`
- `Draw__14tInsideBoxMenusssss`: `entry10`, `entry6`
- `UpdateTransition__20tMenuItemSlidingMenub`: `iVar2`
- `UpdatefOpenHeight__20tMenuItemSlidingMenub`: `closeH`, `cur`, `fade`, `fadeOut`, `lim`, `newFade`, `shrinkH`, `slide`
- `Draw__20tMenuItemSlidingMenuiib`: `drawX`, `drawY`
- `UpdatefOpenHeight__25tMenuItemSlidingActivatedb`: `arg1`, `iVar2`, `iVar4`
- `UpdateTransition__25tMenuItemSlidingActivatedb`: `iVar2`
- `Draw__31tMenuItemDisplayLeftRightChoiceiib`: `x`, `y`
- `Draw__29tMenuItemOnOffLeftRightChoiceiib`: `x`, `y`
- `Draw__29tMenuItemLeftRightAudioSlideriib`: `brightTextColor`, `rgbVals`
- `UpdateTransition__29tMenuItemLeftRightAudioSliderb`: `iVar1`
- `Draw__18tInsideBoxSongMenusssss`: `drawBaseY`, `fadeValue`, `fe`, `slide`, `width`
- `Draw__34tMenuItemControllerLeftRightChoiceiib`: `w`, `x`, `y`
- `Draw__22tInsideBoxTwoWaySlideriiib`: `fWidth`, `selection`
- `Calibrate__22tInsideBoxTwoWaySlider`: `app`, `minimum`, `padBase`, `padInfo`, `screen`, `value`
- `ProcessInput__17tUserNameMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand`: `character`, `column`, `lastColumn`, `rowBase`, `rowOffset`, `selectedChar`, `soundId`, `stringLength`
- `Draw__17tUserNameMenuItemb`: `boxRight`, `columnx`, `menuStartY`, `right`, `row`
- `TransitionOn__17tUserNameMenuItem`: `dst`
- `UpdateTransition__17tUserNameMenuItemb`: `iVar2`
- `Draw__19tMemoryCardMenuItemb`: `less`, `sVar2`, `sv`, `v`
- `FETextRender_WordWrapTextRGBJustify__FPcR4RECTiiib`: `pixels`
- `TextValue__18tListIteratorTrack7tPlayer`: `trackEntry`, `uVar1`
- `DrawTVLines__FR9tTVConfig`: `abe`
- `DrawTV__FR9tTVConfig`: `noiseHeight`, `noiseShapeY`, `packetPtrSlot`, `rgbMask`
- `FECheat_HandleActivation__F10tCheatCode`: `placement`, `placements`
- `FECheat_ActivateCheat__FPc`: `dlgThis`, `feApp`, `wordText`
- `FEInput_GetNoDebounceKey__Fii`: `result`
- `Draw__9tMenuItemiib`: `x`, `y`
- `Draw__9tMenuItemiiib`: `w`
- `ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand`: `frameFiller`
- `Draw__24tMenuItemLeftRightChoiceb`: `x`, `y`
- `ProcessInput__24tMenuItemLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand`: `frameFiller`, `sound`, `volume`
- `DrawSlider__FsssssssssbT9ss`: `greenVal`, `greenVal2`, `redVal`, `redVal2`
- `ProcessInput__23tMenuItemGoToMenuButton7tPlayerR13tInputKeyTypeR12tMenuCommand`: `frameFiller`
- `GoNonInterlaced__7tScreen`: `backView`, `displayEnv`, `displayHeight`, `frontView`, `playerViewIndex`, `viewHeight`, `viewTable`
- `TransitionOff__7tScreen22tScreen_TransitionTypeP5tMenu`: `arg2`, `iVar1`
- `TransitionOn__7tScreen22tScreen_TransitionTypeP5tMenu`: `arg2`, `iVar1`
- `UpdateTransition__7tScreen`: `fadeValue`, `transitionValue`
- `GetPSXPadValue__Fii`: `acc1`, `acc2`
- `SetPads__Fv`: `waiting`
- `Front_Menu__F21tFront_ProcessingType`: `needCar`, `one`
- `Front_GetLapsForType__Fv`: `uVar1`
- `Front_InitTourneyTraffic__FR9tFEStream`: `maxTraffic`, `tourn`
- `Front_InitOpponentCars__FR9tFEStream`: `numRacers`, `numRacers2`
- `Front_AppendCopData__FPiR9tFEStream`: `carInfo`
- `Front_AppendPerpData__FPiR9tFEStream`: `carInfo`, `carManagerPtr`
- `Front_AppendTrafficData__FPiR9tFEStream`: `carInfo`, `traffic`
- `Front_AppendTrackData__FPiR9tFEStream`: `speedMode`
- `Front_EnableLocalSpeech__Fv`: `lang`
- `Front_BuildStream__FPi`: `randomSeed`
- `MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand`: `carSelectScreen`, `dialog`, `menuDefinitions`, `nextMenu`, `screenState`
- `AskTheUserToSaveTheGame__Fv`: `dlgThis`
- `MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand`: `menuDefsBase`
- `MenuExtended_GoToCarSelect__FR12tMenuCommand`: `dialog`, `nextMenu`, `screen`, `state`
- `MenuExtended_GoToUpgrades__FR12tMenuCommand`: `menuDefsBase`
- `GenericMenuSaveGame__Fi`: `app`, `noInput`
- `PinkSlipsPreSave__Fv`: `dlgThis`
- `MenuExtended_GoToTournTrackInfo__FR12tMenuCommand`: `frontEndBase`, `frontEndState`, `manager`, `menus`, `selectedTourney`
- `MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand`: `frontEndState`, `manager`, `menus`, `selectedTourney`
- `MenuExtended_EnterUserName__FR12tMenuCommand`: `defs`, `player`
- `MenuExtended_GoToShowroom__FR12tMenuCommand`: `menuDefsBase`
- `MenuExtended_GoToDealerShowroom__FR12tMenuCommand`: `menuDefsBase`
- `MenuExtended_BuyCar__FR12tMenuCommand`: `dialogAnchor`, `pp`
- `GenericMenuLoadGame__Fi`: `app`, `mc`
- `MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand`: `defs`
- `MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand`: `defs`
- `MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand`: `dialogAnchor`, `dlgThis2`, `dlgThis3`, `menuDefsBase`, `playerNum`
- `MenuExtended_GoToGarage__FR12tMenuCommand`: `garageIterator`
- `MenuExtended_ExitTourney__FR12tMenuCommand`: `dialog`
- `MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand`: `dlgThis`, `menuDefsBase`, `msg`
- `__15tGlobalMenuDefs`: `garageCarItem`, `memoryMenu`, `userNameMenu`
- `Initialize__18tTournamentManager`: `numCars`
- `LoadDescription__18tTournamentManager`: `tourneyDef`, `trackId`, `trnId`
- `StartNewTournament__18tTournamentManagerUcUc`: `fRandOption`, `fTrackOption`, `numCompetitors`, `tourneyDef`, `tourneyDefLocal`, `tourneyInfoOffset`, `trackOffset`
- `IsTournamentFinished__18tTournamentManager`: `currentTourney`
- `tournPointsCompare__FPcT0`: `comps`, `tm`
- `CalcTrackFinishDamageBill__18tTournamentManagerbRlT2`: `mask`
- `UpdateTrackFinishPoints__18tTournamentManager`: `comp`, `knockout`, `next`, `rankVal`, `ranked`, `ranking`, `stats`
- `UpdateCarLineup__18tTournamentManager`: `numCompetitors`
- `GetTournamentFinishPrize__18tTournamentManagers`: `tourn`
- `PlayerRanking__18tTournamentManagers`: `numCompetitors`
- `GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci`: `best`, `t`
- `Confirm__Fii`: `dialog`, `dialogVtable`, `displayDialog`, `feApp`, `messageDialog`, `messageText`, `noInputDialog`
- `SaveGame__Fs`: `displayDialog`, `dlgmsg`, `message`, `status`, `wd`
- `LoadGame__FsbT1`: `cardshifted`, `dialogBase`, `dialogText`, `dlgmsg`
- `SavePinkSlipsCars__Fss`: `cardInfo`
- `Init__14tCreditManageri`: `arg1`
- `Draw__14tCreditManagerb`: `mainScreen`
- `SetupCurrCredit__14tCreditManager`: `advanceRequested`, `backgroundReady`, `currentCredit`, `inputPressed`, `nextCredit`, `startTicksSnapshot`, `textFade`
- `DrawCurrCredit__14tCreditManager`: `tag`
- `TurnOff__10tVideoWall`: `tickCounter`
- `TurnOn__10tVideoWall`: `tickCounter`
- `DrawDropShadow__11tScreenMain`: `addrMask`, `addr_24`, `palTag`, `pal_link`, `tagMask`
- `DrawBackground__11tScreenMain`: `animationFrame`, `elapsedTicks`, `nextAnimation`, `startMovie`, `videoY`
- `DrawBackground__16tScreenPinkSlips`: `currentItem`, `movieVramX`, `rx`, `ry`, `selected`, `trackIndex`
- `ProcessInput__16tScreenPinkSlips7tPlayerR13tInputKeyTypeR12tMenuCommand`: `defs`
- `DrawBackground__26tScreenTournamentStandings`: `lastRacer`, `numRacers`, `type`
- `DrawCar__FR8tCarInfossffcbUl7tPlayer`: `signedTicks`
- `Cleanup__16tScreenCarSelect`: `vtbl`
- `DrawOverlay__16tScreenCarSelectP8tOverlay`: `flags`, `tournamentMoney`, `xPos`, `yOffset`
- `GetShapeInfo__16tScreenCarSelectRsT1PPcT3`: `vtbl`
- `DrawVideoWall__16tScreenCarSelects`: `vtbl`
- `GetCar__16tScreenCarSelectR8tCarInfo`: `color`
- `DrawBackground__16tScreenCarSelect`: `canUpload`
- `DrawForeground__16tScreenCarSelect`: `currentItemValue`, `fadeBase`, `overlayDirection`, `shapeFade`, `shapeTicks`, `textBase`, `validCarValue`
- `PreLoad__20tScreenCarSelectDuel`: `useDefault`
- `DrawVideoWall__20tScreenCarSelectDuels`: `vtbl`
- `GetShapeInfo__20tScreenCarSelectDuelRsT1PPcT3`: `vtbl`
- `UpdateVideoWall__20tScreenCarSelectDuelR8tCarInfo`: `country`
- `DrawBackground__20tScreenCarSelectDuel`: `elapsed`, `p1Ready`, `p2Ready`
- `GetCar__25tScreenCarSelectTwoPlayerR8tCarInfo`: `player`
- `DrawVideoWall__25tScreenCarSelectTwoPlayers`: `videoOffset`
- `UpdateVideoWall__25tScreenCarSelectTwoPlayerR8tCarInfo`: `country`
- `DrawBackground__25tScreenCarSelectTwoPlayer`: `elapsed`, `loading`, `player`, `uploadReady`, `uploadY`, `vtbl`
- `DoMemCardStuff__25tScreenPinkSlipsCarSelect`: `cardInfo`, `pinkState`, `resultState`, `resultStatePtr`, `stateBase`
- `SetDialog__25tScreenPinkSlipsCarSelect`: `dlg`, `wordnum`
- `GetShapeInfo__18tScreenTournSelectRsT1PPcT3`: `fe`, `trophyTourn`, `useSpecial`
- `Initialize__18tScreenTournSelect`: `fe`, `tvIdx`, `useSpecial`
- `DrawBackground__18tScreenTournSelect`: `descriptionText`, `fe`, `number`, `shapeX`, `tournament`, `tvIdx`
- `GetShapeInfo__17tScreenTrophyRoomRsT1PPcT3`: `cur`
- `Initialize__17tScreenTrophyRoom`: `curIdx`, `loopFe`, `place`, `placement`, `tournIdx`, `tourney`
- `DrawBackground__17tScreenTrophyRoom`: `currentTourn`, `drawFlagsPtr`, `feTier`, `selectedTourn`, `tourn`
- `LoadTrophy__17tScreenTrophyRoom`: `tierIdx`, `tourn`
- `GetShapeInfo__17tScreenTrophyInfoRsT1PPcT3`: `currentTourn`, `feTier`, `idx`, `placement`
- `DrawBackground__17tScreenTrophyInfo`: `currentTourn`, `feTier`, `tourn`, `tournID`
- `DrawBackground__18tScreenTrackSelect`: `packetPtrSlot`, `shapeX`, `startTicks`, `videoWall`, `videoY`
- `ProcessInput__18tScreenTrackSelect7tPlayerR13tInputKeyTypeR12tMenuCommand`: `ptVar1`
- `DrawBackground__16tScreenTrackInfo`: `highlighted`, `screenInfo`, `state`, `trackList`
- `ProcessInput__16tScreenTrackInfo7tPlayerR13tInputKeyTypeR12tMenuCommand`: `fee`
- `SetActuators__23tScreenControllerConfigi`: `pulse`, `tickValue`
- `AnimKeyPoints__23tScreenControllerConfigbT1`: `result`
- `CheckConfigs__23tScreenControllerConfig`: `arrowFadeBelowHalf`, `currentControllerForSwap`, `currentControllerSnapshot`, `previousControllerSnapshot`
- `SetCurrentController__23tScreenControllerConfigb`: `dialog`, `dialogIsIdle`, `menuDefinitions`, `previousNegconChoice`
- `DrawController__23tScreenControllerConfig`: `controller`, `controllerOffset`, `haloX`, `iy`, `modeBase`, `offsets`, `rangeValue`, `row`, `shockImpactActive`, `shockModeActive`, `x`, `xOffset`
- `DrawBackground__23tScreenControllerConfig`: `om`
- `DrawForeground__23tScreenControllerConfig`: `copyCount`, `dialog`, `flag`, `selectedConfig`, `textLength`, `textLocationIn`, `textLocationOut`, `textWidth`
- `Initialize__23tScreenControllerConfig`: `b`, `mode`
- `PlaySound__12tScreenAudio`: `validItem`
- `DrawForeground__12tScreenAudio`: `fadeCalc`
- `DrawBackground__12tScreenAudio`: `displayPercent`, `fadeValue`, `optionsMenu`
- `Initialize__12tScreenAudio`: `menus`
- `Cleanup__12tScreenAudio`: `info`
- `DrawIcon__14tScreenMemcardP8shapetbliiiis`: `u`
- `LoadIcon__14tScreenMemcardi`: `cardInfo`, `one`, `pulled`
- `DrawVerticalLine__14tScreenMemcardssss`: `innerHeight`, `pos`, `shifted`, `test`
- `DrawHorizontalLine__14tScreenMemcardssss`: `pos`, `shifted`, `test`, `width`
- `PlaceIcons__14tScreenMemcardii`: `animFrame`, `nfs4Icon`, `numIcons`, `savedY`, `tickFrame`, `tickPtr`
- `DrawBackground__14tScreenMemcard`: `extraY`, `gouraudX`, `gouraudY`, `h`, `startX`, `startY`, `w`
- `DrawForeground__14tScreenMemcard`: `fade`
- `Initialize__14tScreenMemcard`: `feApp`, `menus`, `msgId`
- `Cleanup__14tScreenMemcard`: `iconTable`, `menus`
- `GetShapeInfo__15tScreenCongratsRsT1PPcT3`: `numRanked`
- `DrawBackground__15tScreenCongrats`: `spinTicks`, `vtbl`
- `CalculatePrizes__15tScreenCongrats`: `carCXBits`, `carCYBits`
- `Initialize__15tScreenCongrats`: `vtbl`
- `ProcessInput__15tScreenCongrats7tPlayerR13tInputKeyTypeR12tMenuCommand`: `bConsumeKey`
- `CalculatePrizes__23tScreenPinkSlipCongrats`: `player`
- `CalculatePrizes__23tScreenTournamentTrophy`: `carCXBits`, `cashAwarded`, `knockout`, `ranked`
- `StatChk_SaveRecordLapTime__FP10Car_tStatsss`: `newBestLap`
- `StatChk_SaveTopTime__FP10Car_tStatss`: `uRecSz`
- `Stattool_nCreateIndex__FiPiPs`: `one`
- `Stattool_ParseTime__FiPc`: `min`, `sec`
- `Stattool_CheckForHumanCar__FP10Car_tStats`: `nNumCars`
- `Stattool_GetAINameFromPersonality__F14tPersonalities`: `namePtr`
- `DrawBackground__15tScreenUserName`: `fadeboxv`, `gridposv`
- `CalcOnOffFade__F13tMenuTextTypesssRiT4`: `baseA`, `baseB`, `baseC`

## Explicit oracle-proven function type overrides


## Object-owned global/storage review

- `screenmemcard.cpp` blob-backed definitions: `EXTRAYATTOP`, `GRIDMEMCARDGOURAUDBIT_X`, `GRIDMEMCARDGOURAUDBIT_Y`, `GRIDMEMCARD_HEIGHT`, `GRIDMEMCARD_STARTX`, `GRIDMEMCARD_STARTY`, `GRIDMEMCARD_WIDTH`, `MEMCARDICONOFFX`, `MEMCARDICONOFFY`, `MEMCARD_DELTAX`, `MEMCARD_DELTAY`, `kMemCardMessage1X`, `kMemCardMessage1Y`, `kMemCardMessageH`, `kMemCardMessageH1`, `kMemCardMessageX`, `kMemCardMessageY`
- `statchk.cpp` blob-backed definitions: `NewBestLap`, `NewRecords`
- No ownership, storage-class, or type findings.
