 /** 打包体积优化 
  * 1. 使用插件分析，到底哪里导致打包体积大，例如: webpack-bundle-analyzer
  * 
  * artifice(手段)：
  *  1. 只打包想要的 module；例如: 使用 ContextReplacementPlugin
  *  2. 排除掉不想要的 module；例如: 使用 IgnorePlugin
  *  3. 使用 xxx.min.js 来替换原来的 xxx.js
  *  4. 提取公共代码，防止重复打包
  * */   
 
/ ** 打包速度优化 
  * 1. 找到插件，分析出哪个环节打包慢，例如: speed-measure-webpack-plugin
  * artifice：
  *  1. 优化依赖搜索时间
  *     loader: 使用时，test, include, exclude 的匹配项目最好精确
  *     resolve.module: 配置需要额外查找的目录
  *     resolve.alias: 使用别名，减少递归解析次数
  *     resolve.extensions: 
  *          列表尽量小，减少匹配次数
  *          常用后缀，放最前面
  *          源码中导入语句，尽可能带上后缀，避免使用该选项进行匹配
  *     resolve.mainFields: 三方模块，针对不同的环境，可能提供多套代码，例如:ES5,ES6；webpack 优先采用在前面的匹配项
  *     module.noParse: 
  *          该配置项让 webpack 忽略对部分没有采用模块化的文件的递归解析操作，
  *          因为 JQuery，ChartJS 等并没有模块化，让 webpack 解析这些文件没有意义
  *  2. 优化解析（使用 loader 将所有文件，转换成浏览器能识别的格式）时间，例如： thread-loader（多线程解析）
  *  3. 优化打包（将多个 js 文件压缩成一个）时间
  *     terser-webpack-plugin
  *  4. 优化修改后二次打包时间，即：只打包修改过的 module；
  *     HardSourceWebpackPlugin 
  * */
