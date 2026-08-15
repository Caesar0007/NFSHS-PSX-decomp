# maspsx AKA "Modern ASPSX"

The goal of `maspsx` is to facilitate the replacement of the combination of `ASPSX.EXE` + [psyq-obj-parser](https://github.com/grumpycoders/pcsx-redux/tree/main/tools/psyq-obj-parser) when attempting to generate byte-perfect ELF objects.

`maspsx` takes the assembly code output of `gcc` and massages it such that it can be assembled via GNU `as` to the equivalent object as what the original PSYQ SDK would create.

`ASPSX` does not appear to do very much in terms of code *optimisation*, therefore the belief is that this will be a straightforward process.

There are a number of reasons why using `maspsx` with GNU `as` is preferable to the original toolchain:
 - No need to run 16-bit DOS or 32-bit Windows applications
   - Native, vanilla, [gcc](https://github.com/decompals/old-gcc) versions make `dosemu2` and `wine` unnecessary.
 - Decomp tooling expects ELF objects
 - Support for line numbers in diff!
   - Pass `-gcoff` to gcc to get line numbers in [asm-differ](https://github.com/simonlindholm/asm-differ)


## Usage

`maspsx` supports the following arguments:

### `--aspsx-version`
**EXPERIMENTAL** There are slight nuances in behaviour across `ASPSX` versions. In order to emulate the correct behaviour, pass the `ASPSX` version to `maspsx`, e.g. `--aspsx-version=2.78`.

### `--run-assembler`
The default behaviour of `maspsx` is to write the output to stdout, by passing `--run-assembler`, `maspsx` will run `mipsel-linux-gnu-as` directly.

### `--gnu-as-path`
If `mipsel-linux-gnu-as` isn't on your path, or you want to use a different assembler (e.g. `mips-linux-gnu-as`), specify the **full path** here.

### `--dont-force-G0`
Current understanding is that `-G0` needs to be passed to GNU `as` in order to get correct behaviour. If you need to pass a non-zero value for `-G` to the GNU assembler, use this flag.

### `--expand-div`
If you need `maspsx` to expand `div/divu` and `rem/remu` ops, pass `--expand-div` to `maspsx`. There is already handling for partial div expansion (i.e. where `-0` was passed to `ASPSX.EXE`).

### `--macro-inc`
Get `maspsx` to add an `include "macro.inc"` statement to the output.

### `--use-comm-section`
Put any common symbols (in C, this means non-`static` global variables without an initializer) in the `.comm` section (which is the default ccpsx behaviour).

### `--use-comm-for-lcomm`
Also put `.lcomm`-declared symbols (in C, this means `static` variables without an initializer) in the `.comm` section.
This can be convenient with games using non-zero `-G` in situations where a variable needs to be marked `static` to get code generation to match, but you don't want to migrate `.sdata`/`.sbss` to that .c file yet.
**NOTE:** This also makes the symbols *global* (unlike regular `static` behaviour).

### `-G`
**EXPERIMENTAL** If your project uses `$gp`, maspsx needs to be explicitly passed a non-zero value for `-G`.


## Known Differences

| Behavior / Version            | 1.05/1.07      | 2.05/2.08      | 2.21          | 2.30/2.34      | 2.56           | 2.67           | 2.77/2.79      | 2.81/2.86      |
|:------------------------------|:--------------:|:--------------:|:-------------:|:--------------:|:--------------:|:--------------:|:--------------:|:--------------:|
| div uses tge not break        | :white_circle: | :green_circle: |:white_circle: | :white_circle: | :white_circle: | :white_circle: | :white_circle: | :white_circle: |
| add nop before $at expansion  | :green_circle: | :green_circle: |:green_circle: | :white_circle: | :white_circle: | :white_circle: | :white_circle: | :white_circle: |
| use addiu in $at expansion    | :green_circle: | :green_circle: |:green_circle: | :white_circle: | :white_circle: | :white_circle: | :white_circle: | :white_circle: |
| li 1 expands to ori 1         | :green_circle: | :green_circle: |:green_circle: | :green_circle: | :white_circle: | :white_circle: | :white_circle: | :white_circle: |
| use $at for sltu < 0          | :green_circle: | :green_circle: |:green_circle: | :green_circle: | :green_circle: | :green_circle: | :white_circle: | :white_circle: |
| supports `-0` argument        | :white_circle: | :white_circle: |:white_circle: | :green_circle: | :green_circle: | :green_circle: | :green_circle: | :green_circle: |
| mflo+mfhi / mult+div inst gap | :white_circle: | :white_circle: |:white_circle: | :green_circle: | :green_circle: | :green_circle: | :green_circle: | :green_circle: |
| support for %hi/%lo macros    | :white_circle: | :white_circle: |:white_circle: | :white_circle: | :white_circle: | :green_circle: | :green_circle: | :green_circle: |
| use $gp for symbol+offset     | :white_circle: | :white_circle: |:white_circle: | :white_circle: | :white_circle: | :white_circle: | :green_circle: | :green_circle: |
| use $gp for la                | :white_circle: | :white_circle: |:white_circle: | :white_circle: | :white_circle: | :white_circle: | :white_circle: | :green_circle: |


## `INCLUDE_ASM` reordering workaround hack

Whenever compiling with non-zero `-G` value, some versions of `gcc` reorder all functions to appear *after* data definitions in the output assembly. Unfortunately, this also causes functions to be placed *after* `__asm__` statements, thus breaking the usual implementation of the `INCLUDE_ASM` macro.

This can be worked around with maspsx by wrapping each `__asm__` statement in a function whose name starts with `__maspsx_include_asm_hack`, and appending `# maspsx-keep` to each line of the `__asm__` statement. Thus a working version of `INCLUDE_ASM` would look like:
````
#define INCLUDE_ASM(FOLDER, NAME) \
    void __maspsx_include_asm_hack_##NAME() { \
        __asm__( \
            ".text # maspsx-keep \n" \
            "\t.align\t2 # maspsx-keep\n" \
            "\t.set noreorder # maspsx-keep\n" \
            "\t.set noat # maspsx-keep\n" \
            ".include \""FOLDER"/"#NAME".s\" # maspsx-keep\n" \
            "\t.set reorder # maspsx-keep\n" \
            "\t.set at # maspsx-keep\n" \
        ); \
    }
````

## Examples

Projects that use `maspsx` include:
  - [Castlevania: Symphony of the Night Decompilation](https://github.com/Xeeynamo/sotn-decomp)
  - [open-ribbon](https://github.com/open-ribbon/open-ribbon)
  - [Evo's Space Adventures](https://github.com/mkst/esa)
  - [Croc: Legend of the Gobbos](https://github.com/Xeeynamo/croc)
  - [Legacy of Kain: Soul Reaver](https://github.com/FedericoMilesi/soul-re)
  - [Silent Hill](https://github.com/Vatuu/silent-hill-decomp)
  - [Rayman 1](https://github.com/fuerchter/rayman-ps1-decomp)
  - [Spyro The Dragon](https://github.com/TheMobyCollective/spyro-1)
  - [MediEvil 1](https://github.com/MediEvilDecompilation/medievil-decomp)


## Bugs

This project is a work-in-progress. If you encounter scenarios where `maspsx` output differs from the original PSYQ toolchain please create a [GitHub Issue](https://github.com/mkst/maspsx/issues/new) - ideally with a link to a [decomp.me](https://decomp.me/) scratch that demonstrates the problem.
