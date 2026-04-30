{{ . }}           // 当前对象
{{ .Field }}      // 访问字段
{{ .Method }}     // 调用方法
{{ $var }}        // 访问变量
{{ "string" }}    // 字符串字面量
{{ 123 }}         // 数字字面量
{{ true }}        // 布尔字面量
{{/* 这是注释，不会输出 */}}

/******************************* 变量 *******************************/
{{ $name := "Alice" }}    // 定义变量
{{ $name = "Bob" }}        // 赋值
{{ $name }}              // 使用变量

/******************************* 条件 *******************************/
{{ if .Condition }}
    条件为真时输出
{{ else if .OtherCondition }}
    另一个条件
{{ else }}
    条件为假时输出
{{ end }}

/******************************* 循环 *******************************/
// 遍历切片或数组
{{ range .Items }}
    {{ . }}           // . 代表当前元素
{{ end }}

// 带索引
{{ range $index, $element := .Items }}
    Index: {{ $index }}, Value: {{ $element }}
{{ end }}

// 遍历 map
{{ range $key, $value := .Map }}
    {{ $key }}: {{ $value }}
{{ end }}

// 空值处理
{{ range .Items }}
    {{ . }}
{{ else }}
    没有数据
{{ end }}

/******************************* 管道 *******************************/
{{ .Name | printf "Hello, %s" }}
{{ 16 | printf "%x" }}        // 输出: 10
{{ .Age | add 10 | multiply 2 }}

/******************************* 内置函数 *******************************/
eq	    等于	      {{ eq .A .B }}
ne	    不等于	    {{ ne .A .B }}
lt	    小于	      {{ lt .A .B }}
le	    小于等于	  {{ le .A .B }}
gt	    大于	      {{ gt .A .B }}
ge	    大于等于	  {{ ge .A .B }}
and	    逻辑与	    {{ and .A .B }}
or	    逻辑或	    {{ or .A .B }}
not	    逻辑非	    {{ not .Condition }}
len	    长度	      {{ len .Array }}
index	  索引访问	  {{ index .Array 2 }}
printf	格式化	    {{ printf "%.2f" .Price }}
println	打印换行	  {{ println "Hello" }}

// 逻辑运算
// (A && B) || C
{{ or (and .A .B) .C }}
// A && (B || C)
{{ and .A (or .B .C) }}
// (A || B) && (C || D)
{{ and (or .A .B) (or .C .D) }}
// (A && B) || C
{{ .A | and .B | or .C }}    // 注意：管道方式从左到右执行，等同于 ((.A && .B) || .C)

// 字符串函数
{{ "hello" | upper }}          // HELLO
{{ "HELLO" | lower }}          // hello
{{ " hello " | trim }}         // hello
{{ "hello world" | title }}    // Hello World
{{ "hello" | repeat 3 }}       // hellohellohello
{{ "hello world" | contains "world" }} // true

// 时间函数
{{ .CreatedAt | formatTime "2006-01-02 15:04:05" }}

/******************************* 模板 *******************************/
// 定义模板
{{ define "header" }}
    <h1>{{ .Title }}</h1>
{{ end }}

// 使用模板并传递数据
{{ template "header" . }}                    // 传递整个上下文
{{ template "user" .User }}                  // 传递子对象
{{ template "item" (dict "Name" .Name "Price" .Price) }} // 传递 map

// 或使用 block（带默认内容）
{{ block "content" . }}
    默认内容
{{ end }}




