# todo
1. 全相连并发比较 如何实现 ？
2. 淘汰策略如何实现 ？

3. BHT 放置到取指令阶段的， 利用pc 的值进行的全相连比较
    1. id read and exe write ?
    

4. 原理
    1. 查询的时候会计算出来的npc, 根据表项中间的内容实现预先的进行的加入数值
    ，发现预测成功的时候， 可以不用bubble, 预测失败的时候
    2. 仅仅分析出来npc 就可以？
        1. 发现的当前指令为跳转指令， 修改当前的npc
        2. 为什么并行操作， 执行到当前的指令， 那么就是总会为处理
        3. 此处npc马上决定下一跳的 npc
            1. add a new choose to in_pc
            2. calculate a new pc_4
                1. we can find the real npc if we have the real pc_4
                3. create a new pc_4 used for reading next instruction
            4. 需要一条pc + 4 和 已经加载的指令的pc ins_pc
            5. if ins_pc 和 计算出来的pc 不一致， 然后才会 bubble
    3. 维护表格
        2. 如何取出表格， 更新表格， 指令是否跳转 ？
        1. 更新的逻辑是什么 ？
            1. 什么时候设置valid 位置， 
    


# todo
1. 创建的出来的BHT 表格
    1. 
2. 更新bubble的逻辑
    1. 判断npc 和 next_ins_pc 是否相等
3. 增加两个缓冲区间存储 next_ins_pc 的内容
4. 更新pc_in 的逻辑
    1. 当出现的ctrl_clash 的时候， 使用npc, 否则使用查询的表格中间的结果

5. 使用pc 作为当前的指令映射地址 