# 测试指令 2361
# 测试方法, 首选设置 a0的数值为-1,t1 为 -15 然后使用blez 循环逻辑右移,
# 然后再次设置 a0 的数值为 -1, t1的数值 -15, 使用算数右移

# SRLV(可变逻辑右移)
# SRAL(可变算术右移)
# BLEZ 小于等于0 转移


addi $t0, $zero, 1

addi $a0, $zero, -1
addi $t1, $zero, -15
loop_one:
syscall
srlv $a0, $a0, $t0
addi $t1, $t1, 1
blez $t1, loop_one


addi $a0, $zero, 0x8765
sll $a0, $a0, 16
addi $a0, $a0, 0x4321
addi $t1, $zero, -15
loop_two:
syscall
srav $a0, $a0, $t0
addi $t1, $t1, 1
blez $t1, loop_two


# SH 存储半字
addi $t1, $zero, 0x8765
sll $t1, $t1, 16
addi $t1, $t1, 0x4321
sw $t1, 0($zero) # 首先写入到达0 的位置为 87654321


# 读取低地址半字到 $a0
addi $t1, $zero, -15
loop_three:
add $t3, $zero, 0
lh $a0, 0($t3)
addi $t1, $t1, 1
syscall
blez $t1, loop_three


# 读取高地址半字到 $a0
addi $t1, $zero, -15
loop_four:
add $t3, $zero, 2
lh $a0, 0($t3)
syscall
addi $t1, $t1, 1
blez $t1, loop_four


# 终止
addi $v0, $zero, 10
syscall

