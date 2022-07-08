@echo off
rem 使用方法
rem 0. 如果未安装 jdk 请先安装 jdk
rem 1. 创建一个文件夹 Decompiler，并在 Decompiler 下创建一个 classes 和 source 两个子文件夹
rem 2. 将所有需要反编译的 .class 文件和 .jar 文件放在 classes 文件夹中
rem 3. 复制本 .bat 文件到 Decompiler 下
rem 4. 下载 procyon-decompiler-0.5.30.jar 放在 Decompiler 下，并重命名为 procyon-decompiler.jar
rem 5. 双击运行本 .bat 文件

rem .class 文件反编译
for /f %%a in ('dir .\classes\*.class /b /s') do (
    java -jar .\procyon-decompiler.jar %%a -o .\source
)

rem .jar 文件反编译
for /f %%a in ('dir .\classes\*.jar /b /s') do (
    java -jar .\procyon-decompiler.jar -jar %%a -o .\source
)

rem 将反编译出来的 unicode 格式的文件转化为 utf8 格式的文件，保证中文不乱码
for /f %%a in ('dir .\source\*.java /b /s') do (
    native2ascii -reverse -encoding utf8 %%a %%a
)

set /p userInputVar=输入任意字符串结束:
echo %userInputVar%
pause

