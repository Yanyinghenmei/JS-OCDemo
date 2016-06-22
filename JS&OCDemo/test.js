
// 计算阶乘
var factorial = function(n)  {
    return factorialOptimize(n, 1);
};

// 尾递归
var factorialOptimize = function(n, result) {
    
    if (n < 0)
        alert('输入错误!')
        return;
    
    if (n === 0)
        return 1;
    
    if (n === 1)
        return result
    
    // 返回函数引用
    return factorialOptimize(n - 1, n * result)
};

// alert(输入错误!)