<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 2020/4/26
  Time: 11:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!doctype html>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>智慧停车</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />

    <!-- Bootstrap -->
    <link href="${APP_PATH }/bootstrap-3.3.5-dist/css/bootstrap.min.css"
          rel="stylesheet" media="screen">
    <link href="${APP_PATH }/bootstrap-3.3.5-dist/css/bootstrap-datetimepicker.min.css"
          rel="stylesheet" media="screen">
    <link href="${APP_PATH }/bootstrap-3.3.5-dist/css/fileinput.css"
          rel="stylesheet" media="screen">
    <link rel="stylesheet" href="${APP_PATH }/css/font.css">
    <link rel="stylesheet" href="${APP_PATH }/css/xadmin.css">
    <link rel="stylesheet" href="${APP_PATH }/css/diy.css">
    <script src="${APP_PATH }/bootstrap-3.3.5-dist/js/jquery-3.0.0.min.js"></script>
    <script src="${APP_PATH }/bootstrap-3.3.5-dist/js/fileinput.js"></script>
    <script src="${APP_PATH }/bootstrap-3.3.5-dist/js/zh.js"></script>
    <script src="${APP_PATH }/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
    <script src="${APP_PATH }/bootstrap-3.3.5-dist/js/bootstrap-datetimepicker.min.js"></script>
    <script src="${APP_PATH }/bootstrap-3.3.5-dist/js/bootstrap-datetimepicker.zh-CN.js"></script>
    <!-- <link rel="stylesheet" href="./css/theme5.css"> -->
    <script src="${APP_PATH }/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${APP_PATH }/js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script>
        // 是否开启刷新记忆tab功能
        // var is_remember = false;
    </script>

</head>
<body class="index">
<!-- 顶部开始 -->
<div class="container">
    <div class="logo">
        <a href="./index.html">停车管理</a></div>
    <div class="left_open">
        <a><i title="展开左侧栏" class="iconfont">&#xe699;</i></a>
    </div>
    <ul class="layui-nav left fast-add" lay-filter="">

    </ul>
    <ul class="layui-nav right" lay-filter="">
        <li class="layui-nav-item">
            <a href="javascript:;"><img src="${APP_PATH }/pic/head.png" class="head" alt="">admin</a>
            <dl class="layui-nav-child">
                <!-- 二级菜单 -->
                <dd>
                    <a onclick="xadmin.open('个人信息','http://www.baidu.com')">个人信息</a></dd>
                <dd>
                    <a onclick="xadmin.open('切换帐号','http://www.baidu.com')">切换帐号</a></dd>
                <dd>
                    <a href="./login.html">退出</a></dd>
            </dl>
        </li>

    </ul>
</div>
<!-- 顶部结束 -->
<!-- 中部开始 -->
<!-- 左侧菜单开始 -->
<div class="left-nav">
    <div class="left-message">
        <img src="${APP_PATH }/pic/head.png" alt="">
        <span>昵称</span>
        <a href="#">退出</a>
    </div>
    <div id="side-nav">
        <ul id="nav">
            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="首页">&#xe696;</i>
                    <cite>首页</cite>
                    </a>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="停车位管理">&#xe6a9;</i>
                    <cite>车位管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i></a>
                <ul class="sub-menu">
                    <li>
                        <a onclick="xadmin.add_tab('所有车位','parkinfo.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>所有车位</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('临时车位','parkinfo.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>临时车位</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('紧急车位','order-list1.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>紧急车位</cite></a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="停车卡管理">&#xe723;</i>
                    <cite>停车卡管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i></a>
                <ul class="sub-menu">
                    <li>
                        <a onclick="xadmin.add_tab('停车卡用户管理','coupon.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>停车卡用户管理</cite></a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="优惠券管理">&#xe75f;</i>
                    <cite>优惠券管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i></a>
                <ul class="sub-menu">
                    <li>
                        <a onclick="xadmin.add_tab('优惠券列表','city.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>优惠券列表</cite></a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="违规管理">&#xe6b6;</i>
                    <cite>违规管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i></a>
                <ul class="sub-menu">
                    <li>
                        <a onclick="xadmin.add_tab('三级地区联动','city.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>违规车辆列表</cite></a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="城市联动">&#xe70c;</i>
                    <cite>收入管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i></a>
                <ul class="sub-menu">
                    <li>
                        <a onclick="xadmin.add_tab('三级地区联动','city.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>收入列表</cite></a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="管理员管理">&#xe726;</i>
                    <cite>用户管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i></a>
                <ul class="sub-menu">
                    <li>
                        <a onclick="xadmin.add_tab('管理员列表','admin-list.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>用户列表</cite></a>
                    </li>

                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="系统统计">&#xe6ce;</i>
                    <cite>邮箱管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i></a>
                <ul class="sub-menu">
                    <li>
                        <a onclick="xadmin.add_tab('拆线图','echarts1.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>邮箱列表</cite></a>
                    </li>

                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="历史停车">&#xe6b4;</i>
                    <cite>历史停车</cite>
                    <i class="iconfont nav_right">&#xe697;</i></a>
                <ul class="sub-menu">
                    <li>
                        <a onclick="xadmin.add_tab('历史停车列表','unicode.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>历史停车列表</cite></a>
                    </li>
                </ul>
            </li>

        </ul>
    </div>
</div>
<!-- <div class="x-slide_left"></div> -->
<!-- 左侧菜单结束 -->
<!-- 右侧主体开始 -->
<div class="page-content">
    <div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">


        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <iframe src='${APP_PATH }/visualization.html' frameborder="0" scrolling="yes" class="x-iframe"></iframe>
            </div>
        </div>
        <div id="tab_show"></div>
    </div>
</div>
<div class="page-content-bg"></div>
<style id="theme_style"></style>
<!-- 右侧主体结束 -->
<!-- 中部结束 -->



<form id="checkForm">
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">×</button>
                    <h4 class="modal-title" id="myModalLabel"></h4>
                </div>
                <div class="modal-body"></div>
                <div class="modal-footer">
                    <button id="loseSubmit" style="display:none" type="button" class="btn btn-primary">更换卡</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                    <button id="checkSubmit" type="button" class="btn btn-primary">提交更改</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
</form>
<%--自动识别车辆牌照悬浮栏--%>
<div class="modal fade" id="fileModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog " role="document" style="width:900px" >
        <div class="modal-content" >
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">上传车辆车牌照片</h4>
            </div>
            <form action="${pageContext.request.contextPath}/fileUpload1" method="POST" enctype="multipart/form-data"  id="fileUploadForm">
                <div class="modal-body" >
                    <input  id='id' name='id' value='$(id)' type='hidden'>
                    <input type="file" name="file" class="file" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary"  >上传云端识别</button>
                </div>
            </form>

        </div>
    </div>
</div>
<%--支付悬浮框--%>
<div id="payForm">
    <div class="modal fade" id="myModal1" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">×</button>
                    <h4 class="modal-title" id="myModalLabel">
                        <button type="button" onclick="pay_zfb()" style="width: 30%" class="btn btn-default" >支付宝
                        </button>
                        <button type="button" onclick="pay_wx()" style="width: 30%" class="btn btn-default" >微信
                        </button>
                        <button type="button" onclick="pay_cash()" style="width: 30%" class="btn btn-default" >现金
                        </button>
                    </h4>
                </div>
                <div class="modal-body1">
                    <div id="pay_zfb">
                        <h4>支付宝：<span id="zfb_text"></span>元</h4>
                        <img alt="" style="width: 300px;height: 300px;margin-left: 20%" src="${APP_PATH }/pic/zfb.png">
                    </div>
                    <div id="pay_wx" hidden="hidden">
                        <h4>微信：<span id="wx_text"></span>元</h4>
                        <img alt="" style="width: 300px;height: 300px;margin-left: 20%" src="${APP_PATH }/pic/wx.png">
                    </div>
                    <div id="pay_cash" hidden="hidden">
                        <h4>现金：<span id="cash_text"></span>元</h4>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                    <button id="paySubmit" type="button" onclick="" class="btn btn-primary">支付</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
    </div>
</div>
</body>

</html>