# flutter 自定义组件写法实践

## 自定义组件一般都是共通组件，方便其它模块调用

## 以下几个问题是在实践中的一些总结

1. 考虑好组件的输入和输出，组件只做共通的事情
2. 组件是继承StatefulWidget还是StatelessWidget
3. 输入参数尽可能全面（例如disabled和callback是否需要包含）
4. 输入参数是否需要默认值
5. 输入参数是否是required
6. 输入参数类型是否指定，尽量不用dynamic
