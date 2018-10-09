# Multi Cycle CPU

- Initialization file is stored in `multicycle-cpu.srcs/sources_1/ip/Mem/memory.coe`
- And it represents the following assembly code:

```
lw $a0, 12($zero) # init $a0
lw $t1, 13($zero) # f[0] = 1
lw $t2, 13($zero) # f[1] = 1
lw $t3, 13($zero) # i = 1
lw $t4, 13($zero)
add $t5, $t2, $t1
add $t1, $t2, $zero
add $t2, $t5, $zero
add $t3, $t3, $t4
bne $t3, $a0, -5
add $v0, $t2, $zero
j 0
```
