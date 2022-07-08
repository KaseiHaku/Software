rem ############################################### Foundation #############################################
@echo off               rem @ 表示不显示当前命令行， echo off 表示此语句后所有运行的命令都不显示命令行本身

rem ############################################### Frequently Used #############################################
^                       rem 转义字符
|                       rem 管道符
>                       rem 输出重定向符 
>nul                    rem 表示输出到空，即 不输出
||                      rem 逻辑或，前面成功，后面的就不执行
&&                      rem 逻辑与，前面的成功，后面的才执行

rem ############################################### Operator #############################################
+ - * / %

equ                 rem ==
neq                 rem !=
lss                 rem <
leq                 rem <=
gtr                 rem >
geq                 rem >=

and                 rem 与 &&
or                  rem 或 ||
not                 rem 非 !

&                   rem 位与
|                   rem 位或
^                   rem 位异或

rem ############################################### Command #############################################
help                                        rem 查看所有可用命令
help command                                rem 查看某一个命令的使用方式
command /?                                  rem 查看命令帮助

rem ################ Interaction Command
pause                                               rem 暂停，用户输入任意键继续执行


choice /C abc /N /CS /T 9999 /D b /M select:        rem # /C 选项列表，默认 YN
                                                    rem # /CS 选项列表区分大小写
                                                    rem # /N 不显示选项列表[a,b,c]
                                                    rem # /T 做出默认选择前，暂停的秒数，0~9999，0 表示直接选择默认值
                                                    rem # /D 超时默认选择的选项
                                                    rem # /M 显示的消息
                                                    rem # 选项1请选a，选项2请选b，选项3请选c。最大等待时间9999秒，超过默认选择b，/CS 选项区分大小写
echo %errorlevel%           rem # 获取 choice 返回值
                            rem # 用户选择列表中的第一个选项，返回 1，第二个选项返回 2，以此类推
                            rem # Ctrl+Break 或 Ctrl+C 返回 0
                            rem # 错误 返回 255
                            
set /p userInputVar=promptString        rem 等待用户输入一行字符串，并将该字符串赋值给变量 userInputVar
echo %userInputVar%
                                            

rem ################ General Command
cd e:\aa                                    rem 切换工作目录
cls                                         rem 清屏
copy e:\aa\bb*.txt c:\dir\                  rem 复制文件
xcopy /i /e /y E:\XML\Report* C:\XML\       rem 高级复制
                                            rem /i - 如果目标路径不存在且拷贝多个文件，则认为目标路径是文件夹。 
                                            rem /e - 拷贝目录和子目录，包括空的目录。 
                                            rem /y - 直接覆盖目标路径同名的文件而不提示。 
del e:\temporary\terrific* /s /q            rem 删除目录， /s 删除子目录下的文件； /q 安静模式
dir .                                       rem 列出目录内容 . 表示当前目录 .. 上级目录 
echo hello world                            rem 输出到屏幕
exit                                        rem 结束批处理，并退出
md e:\aa\bb                                 rem 在指定路径创建一个新目录
mkdir aa                                    rem 跟 md 命令一样
rmdir /s aa                                 rem 删除目录 /s 删除子目录
move aa bb                                  rem 移动文件或目录
pause                                       rem 暂停
ren aa.txt target.txt                       rem 文件重命名
start                                       rem 在新窗口中启动程序，或打开文档
type                                        rem 将文件或文件的内容打印到输出中

attrib                                      rem 显示或设置当前目录中的文件的属性
find                                        rem 在文件或输入中搜索字符串，输出匹配的行
findstr "str"                               rem 在文件中查找字符串，可以配合管道符 | 使用
tasklist                                    rem 查看进程列表
taskkill /s system /u domain\user_name /p password /t /f /im "vcSvcHst.exe" 
                                            rem /s: 远程系统 
                                            rem /u: [域名]\用户名。/u (/p)必须和/s连用。 
                                            rem /p: 密码 
                                            rem /t: 终止进程及其子进程 
                                            rem /f: 强制终止 
                                            rem /im: 进程名称

ipconfig
more
net
ping




                                            
set                                         rem 显示当前系统上的环境变量列表
tree e:\aa                                  rem 当前目录的所有子目录的树显示为递归或深度的任何级别
call                                        rem 调用另一个批处理文件
 



rem ############################################### Variable #############################################
rem ########## 命令行参数获取：
rem # %1~%9 表示命令行参数，%0 表示命令本身
rem # 假设命令行输入的是 shell> exe.bat a b c
rem # shift 克服命令行只能到 %9 的限制，shift 之后重新从 %0 开始计数
echo %0     rem 输出 exe.bat
echo %1     rem 输出 a
echo %2     rem 输出 b
echo %3     rem 输出 c

rem ########## 环境变量：
echo %JAVA_HOME%             rem 环境变量

rem ########## 自定义全局变量：
set str=string          rem 定义一个变量
set /A numVar=1         rem /A 表示该变量是数值
echo %numVar%           rem 调用变量

rem ########## 自定义局部变量：
setlocal                rem 表示是一个代码块，其中定义的变量，只在其中有效
    set localVar=fff    rem 定义一个局部变量
endlocal

rem ############################################### Variable Type #############################################
rem ################ 字符串相关处理
set a=          rem 创建一个空串
[%a%]==[]       rem 检查是否存在空字符串
set str=abcdefg
set str=%str%www.baidu      rem 字符串拼接
set str=%str:~-4%           rem ~-4 表示只想显示 str 变量的最后 4 个字符
set str=%str:~2,5%          rem 显示从左到右 2 到 5 个字符
set str=%str:~1,-1%         rem 显示字符串的第二个和最后第二个字符

set str=%str:is=%           rem 删除 str 中的 is 字符串
set str=%str:=%             rem 删除所有空格
set str=%str:needs=has%     rem 替换 str 中的 has 为 needs

rem ######## 字符串长度
set str=Hello World
call :strLen str strlen
echo String is %strlen% characters long
exit /b


rem ################ Array
set a[0]=1
set list=1 2 3 4
set person[0].name=kasei
set person[0].age=22
echo %a[0]%


rem ############################################### Flow Control #############################################
rem ################ if-else
rem # 值相等判断
if not "var"=="String" (    
    echo equals         
) else (
    echo not equals
) 

rem # 测试变量是否存在
if defined str (        
    echo the variable str is defined
) else (
    echo the variable str is not defined
)

rem # 测试文件是否存在
if not exist "./dfd/fd" (  
    echo file not exist
) else (
    echo file exist
)

rem # 根据上面一行命令的返回值，来执行不同的命令，(返回值必须按照从大到小的顺序排列)，
rem # 如果返回值等于指定的数字，则条件成立，运行命令，否则运行下一句。 
if errorlevel <数字，命令的返回值> echo ff goto end


rem ################ cycle
:LOOP_START
   if not "!%1:~%len%!"=="" set /A len+=1 & goto :strLen_Loop
(endlocal & set %2=%len%)
goto :LOOP_START

for /d /l /r /f %%item in (*.bat) do type %%item    rem 相当于 java 中的 foreach （）里的是集合
for /d e:\aa %%item in (*.txt) do command           rem /d 表示在 e:\aa 目录下的文件中，只有是目录的才赋值给 item
for /r e:\aa %%item in (*.class) do command         rem /r 表示在 e:\aa 目录及其子目录下都执行 *.class 的匹配，并把匹配结果赋值给 item
for /l %%item in(8,-2,1) do command                 rem /l 用于生成序列，从 8 开始每个减 2 直到小于 1，即序列为 8 6 4 2


rem /f 将每一行分成一个 item 返回，后面带的字符串用于表示怎么分割， skip 跳过前 n 行， eol 忽略 # 开头的行， delims 表示分割符，tokens 表示分割后 取哪些
for /f "tokens=3-5 delims= " %%i in ("string") do echo %%i %%j %%k rem i j k 必须按英文顺序
for /f "skip=2 eol=# tokens=2,3 delims= " %%i in (fileName) do echo %%i %%j     rem 对文件内容做处理
for /f "eol=# tokens=2,* delims= " %%i in ('commmand') do echo %%i %%j


rem ############################################### Function #############################################
:functionNamerem                        rem 函数定义
setlocal                                rem 表示是一个代码块，其中定义的变量，只在其中有效
    %~1                                 rem 获取函数第一个参数
    set "%~1=5"                         rem 设置返回值
endlocal
exit /b %ERRORLEVEL%

rem ################ 函数调用
call :functionName param1 param2        

rem ################ 获去函数返回值
echo %param1%                           

