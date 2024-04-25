ES6 Module = ESM = .mjs
CommonJS = CJS = .cjs

Node 模块加载逻辑：
    .mjs文件总是以 ES6 模块加载，
    .cjs文件总是以 CommonJS 模块加载，
    .js文件的加载取决于 package.json 里面 type 字段的设置。
    
    坑: 
        .cjs 中 require() 命令不能加载 .mjs 文件，加载方式为： (async () => {  await import('./my-app.mjs');})(); 
        .mjs 中可以通过  import 加载 .cjs 文件，但是只能整体加载，不能只加载单一的输出项。
            import packageMain from 'commonjs-package';     // 正确
            import { method } from 'commonjs-package';      // 报错
            
            加载单一输出项的方法：
                import packageMain from 'commonjs-package';const { method } = packageMain;
    
    同时要支持 CommonJS 和 ES6 两种格式：
        原始模块是 ES6：
            需要给出一个整体输出接口，比如 export default obj，使得 CommonJS 可以用 import() 进行加载。 // 导出为 CommonJS 模块
        
        原始模块是 CommonJS:
            import cjsModule from '../index.js';
            export const foo = cjsModule.foo;  // 重新导出为 ES6 模块
        
        package.json 文件的 exports 字段，指明两种格式模块各自的加载入口






