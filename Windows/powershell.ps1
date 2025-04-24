# 注释

# 列出所有可用命令
get-command
get-command | findstr /I "substr"


# 脚本启动参数
# 可以通过 `$args` 数组或者定义参数名接收外部传入的参数
param(
   [string]$ComputerName = "localhost",
   [int]$PortNumber
)
Test-NetConnection -ComputerName $ComputerName -Port $PortNumber


# 变量：无需创建，直接赋值即可
$myVariable = "Hello, World!"

# 条件
if ($myVariable -eq "Hello, World!") {
   Write-Host "The variable matches the string."
} else {
   Write-Host "The variable does not match the string."
}

# 循环
foreach ($item in $array) {
   Write-Output $item
}

 for ($i = 1; $i -le 10; $i++) {
   Write-Host $i
}

# 函数
function MyFunction {
   param($input)
   Write-Host "Processing $input..."
}



# 管道操作
Get-Service | Where-Object Status -eq 'Running'
