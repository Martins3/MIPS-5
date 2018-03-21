1. 当前的WB 操作是否会去执行的

2. 是　使用PC + 4 or PC

3. if current is bubble what would happened !

4. if we already jump, what wound happen !
    1. should not be any problem, if we use the the PC of wb

5. if it's bubble, pc will be clear, what can we do ?
    1. make a new buffer for pc ?

6. W pc finished, but what to do with eret !
    1. when eret, clear former data !
    2. set the pc 

7. 如果当前为气泡，那么中断的除法信号会延迟的，　但是如果当前的信号的eret , 可以知道当前一定
不是气泡的

# 操作
1. 添加的一个指示灯用于判断当前的是否为气泡
    1. 气泡的插入的位置是：
        1. 数据冲突 load use 的位置 一个清除　
        2. 控制冲突                两个清除
    2. 在最开始的位置添加，　之后依次保持  
2. 在wb 阶段的保存npc

3. 在pc 的位置添加控制器，　实现对于对于返回的识别

4. interrupt 的控件复制过来！

5. 