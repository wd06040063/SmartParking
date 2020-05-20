<%@ page language="java" import="java.util.*" pageEncoding="utf8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>识别成功</title>
    <link rel="stylesheet" type="text/css" href="${APP_PATH}css/htmleaf-demo.css">
    <link rel="stylesheet" href="${APP_PATH}/css/style.css">
    <!--[if IE]>
    <script src="http://libs.useso.com/js/html5shiv/3.7/html5shiv.min.js"></script>
    <![endif]-->
</head>
<body>
<%
    response.setHeader("refresh", "3;url="+request.getContextPath()+"/index/toindex");
%>
<div class="htmleaf-container">
    <header class="htmleaf-header">
        <h1>车牌识别成功！ <span><span class="time"></span>秒后自动跳转至首页..........</span></h1>
        <div class="htmleaf-links">
            <a class="htmleaf-icon icon-htmleaf-home-outline" href="${APP_PATH }/index/toindex" title="主页" ><span> 主页</span></a>
            <a class="htmleaf-icon icon-htmleaf-arrow-forward-outline" href="#" title="返回" target=""><span> 返回</span></a>
        </div>
    </header>

</div>
<nav class="shelf">
    <a class="book home-page">Home page</a>
    <a class="book about-us">About us</a>
    <a class="book contact">Contact</a>
    <a class="book faq">F.A.Q.</a>

    <span class="book not-found"></span>

    <span class="door left"></span>
    <span class="door right"></span>
</nav>


</body>
<script type="text/javascript">
    var timeEle = document.querySelector('.time'),
        count   = 3
    timeEle.innerHTML = count;
    // 设置计时器
    var judge = setInterval(function() {
        count--;
        if (!count) {
            // 清除计时器
            clearInterval(judge);
        };
        // 标签当中显示时间
        timeEle.innerHTML = count;
    }, 1000);
</script>
</html>
