# MIPS-Multi-Cycle-CPU
## 注意事项
* 不支持异常
* 采用有限状态机与逻辑电路相结合的方式构建控制模块，减少至11个状态
* 数据存储均在时钟下降沿触发
* 为防止险象的发生，在时钟上升沿进行状态的跳转
## 如何使用
在*test.txt*中写入16进制指令序列，仿真*mips_tb.v*即可。
## 支持的指令
MIPS-C2＝{LB、LBU、LH、LHU、LW、SB、SH、SW、ADD、ADDU、SUB、SUBU、SLL、SRL、SRA、SLLV、SRLV、SRAV、AND、OR、XOR、NOR、SLT、SLTU、ADDI、ADDIU、ANDI、ORI、XORI、LUI、SLTI、SLTIU、BEQ、BNE、BLEZ、BGTZ、BLTZ、BGEZ、J、JAL、JALR、JR}</br></br>
R-type={ADD、ADDU、SUB、SUBU、SLL、SRL、SRA、SLLV、SRLV、SRAV、AND、OR、XOR、NOR、SLT、SLTU}</br></br>
I-type={ADDI、ADDIU、ANDI、ORI、XORI、LUI、SLTI、SLTIU}</br></br>
Save={SB、SH、SW}</br></br>
Load={LB、LBU、LH、LHU、LW}</br></br>
Branch={BEQ、BNE、BLEZ、BGTZ、BLTZ、BGEZ}</br></br>
Jump={J、JAL}</br></br>
Jump Register={JALR、JR}</br></br>
## 状态含义
|状态|指令|执行内容|
|:-:|:-:|:-:|
|0|MIPS-C2|开始周期，无具体执行内容|
|1|MIPS-C2|取指令，并将其写入IR;</br>PC+4|
|2|MIPS-C2|译码，读取寄存器中的rs，rt备用;</br>计算b型指令跳转地址备用|
|3|R-type、I-type|ALU执行运算，结果存入ALUout|
|4|R-type、I-type|将ALUot中的内容写回寄存器|
|5|Load&Save|数据内存寻址|
|6|Save|向数据内存写入数据|
|7|Load|从数据内存读取数据，并存入MDR|
|8|Load|将MDR中的数据写入寄存器中|
|9|Branch|ALU判断是否满足跳转条件，若是则跳转|
|10|Jump|将target部分写入PC;JAL还需将PC写入$ra|
|11|Jump Register|将($rs)写入PC;JALR还需将PC写入$rd|
## 状态的跳转规则
|状态|指令|跳转至|
|:-:|:-:|:-:|
|0|MIPS-C2|1|
|1|MIPS-C2|2|
|2|MIPS-C2|3(R、I-type)、5(S&L)、9(branch)、</br>10(jump)、11(jump register)|
|3|R-type、I-type|4|
|4|R-type、I-type|1|
|5|Load&Save|6(save)、7(load)|
|6|Save|1|
|7|Load|8|
|8|Load|1|
|9|Branch|1|
|10|Jump|1|
|11|Jump Register|1|
## 控制信号的含义
|信号|信号的含义|信号内容|
|:-:|:-:|:-:|
|IRWr|IR写入控制|0:不可写</br>1:可写|
|RFWr|RF写入控制|0:不可写</br>1:可写|
|DMWr|DM写入控制|0:不可写</br>1:可写|
|PCWrite|PC写入控制|0:不可写</br>1:可写|
|PCWriteCond|PC条件写入控制|0:不可写</br>1:可写(需同时满足跳转条件)|
|RegWAd|寄存器写入地址选择|0:rt部分</br>1:rd部分</br>2:立即数31|
|RegWDa|寄存器写入数据选择|0:ALU输出寄存器</br>1:数据内存输出</br>2:PC|
|PCSource|PC写入数据选择|0:ALU直接输出</br>1:ALU输出寄存器</br>2:J型指令低26位|
|ALUOp|ALU控制指令|详见*alu_def.v*|
|ALUSrcA|ALU输入1数据选择|0:PC</br>1:寄存器输出</br>2:shamt|
|ALUSrcB|ALU输入2数据选择|0:寄存器输出</br>1:立即数4</br>2:符号扩展</br>3:符号扩展左移两位</br>4:无符号扩展|
## 各模块功能
|模块|模块功能|
|:-:|:-:|
|ALU.v|运算单元|
|alu_def.v|运算单元的指令宏定义|
|B.v|branch指令判断部分的逻辑处理|
|BE.v|save指令数据内存操作码生成器|
|ctrl.v|控制单元|
|dm.v|数据内存|
|flopr.v|简单触发器(时钟下降沿触发)|
|im.v|指令内存|
|LHANDLE.v|数据内存读取附加处理模块|
|mips.v|CPU整体控制|
|mips_tb.v|测试模块|
|mux.v|多路选择器|
|PC.v|PC存储器|
|RF.v|寄存器|
|SE.v|符号扩展|
|UE.v|无符号扩展|