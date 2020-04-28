<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>基于java的停车场管理系统</title>
	<!-- Bootstrap -->
	<link href="${APP_PATH }/bootstrap-3.3.5-dist/css/bootstrap.min.css"
		  rel="stylesheet" media="screen">
	<link href="${APP_PATH }/bootstrap-3.3.5-dist/css/bootstrap-datetimepicker.min.css"
		  rel="stylesheet" media="screen">
	<link href="${APP_PATH }/bootstrap-3.3.5-dist/css/fileinput.css"
		  rel="stylesheet" media="screen">
	<script src="${APP_PATH }/bootstrap-3.3.5-dist/js/jquery-3.0.0.min.js"></script>
	<script src="${APP_PATH }/bootstrap-3.3.5-dist/js/fileinput.js"></script>
	<script src="${APP_PATH }/bootstrap-3.3.5-dist/js/zh.js"></script>
	<script src="${APP_PATH }/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
	<script src="${APP_PATH }/bootstrap-3.3.5-dist/js/bootstrap-datetimepicker.min.js"></script>
	<script src="${APP_PATH }/bootstrap-3.3.5-dist/js/bootstrap-datetimepicker.zh-CN.js"></script>
	<style type="text/css">
		a:link {
			text-decoration: none;
		}
		a:visited {
			text-decoration: none;
		}
		a:hover {
			text-decoration: none;
		}
		a:active {
			text-decoration: none;
		}
		.nav .open>a, .nav .open>a:focus, .nav .open>a:hover {
			background-color: #579ec8;
		}
		.nav>li>a:focus, .nav>li>a:hover {
			background-color: #579ec8;
		}
		.topscan {
			width: 100%;
			min-height: 55px;
			background-color: #79d39b;
			position: relative;
		}
		.top-left {
			color: white;
			line-height: 20px;
			padding: 15px 10px;
			float: left;
		}
		.user-click {
			float: right;
			padding-right: 40px;
		}
		.dropdown-menu{
			background-color: #79d39b;
		}
		.leftscan a:hover {
			color: #1963aa;
			background-color: white;
			display: block;
			background-color: white;
		}
		.leftscan a {
			color: #585858;
			display: block;
			height: 38px;
			line-height: 36px;
			display: block;
		}
		.leftscan li {
			border-top: 1px solid #ccc;
			border-bottom: 1px solid #ccc;
			border-left: 1px solid #ccc;
			border-right: hidden;
		}
		body {
			width: 100%;
			height: 100%;
			margin: 0;
			padding: 0;
			background-color: #e4e6e9;
		}
		ul, li {
			margin: 0;
			padding: 0;
			text-align: center;
		}
		td {
			text-align: center;
		}
		tr {
			text-align: center;
		}
		th {
			text-align: center;
		}
	</style>
</head>
<body>
<div class="topscan">
	<div class="top-left"><span class="glyphicon glyphicon-home"></span><b> 基于java的停车场管理系统</b></div>

	<div class="user-click">
		<ul class="nav navbar-nav">
			<li class="dropdown"><a href="#" class="dropdown-toggle"
									data-toggle="dropdown" style="color: white;"> <span class="glyphicon glyphicon-user"></span>欢迎,
				${sessionScope.user.name } <b class="caret"></b>
			</a>
				<ul class="dropdown-menu">
					<li><a href="${APP_PATH }/index/exit"><span class="glyphicon glyphicon-remove"></span>注销</a></li>
				</ul></li>
		</ul>
	</div>
</div>
<div>
	<div class="leftscan"
		 style="width: 20%; min-height: 100%; float: left; background-color: #eee;">
		<ul style="list-style: none; color: #1963aa;">
			<li><a id="todata" href="${APP_PATH }/index/toindex"
			><span class="glyphicon glyphicon-credit-card"></span> 首页</a></li>
			<c:if test="${sessionScope.user.role!=3 }">
				<li><a id="parkInfo" href="${APP_PATH }/index/findAllCar?tag=0" target="main"
					   onclick="$('div#main').load(this.href);return false;"><span class="glyphicon glyphicon-log-in"></span> 停车位管理</a></li>
			</c:if>
			<li><a id="depotcardIndex" href="${APP_PATH }/index/toDepotcardIndex" target="main"
				   onclick="$('div#main').load(this.href);return false;"><span class="glyphicon glyphicon-credit-card"></span> 停车卡管理</a></li>
			<li><a href="${APP_PATH }/index/findAllCoupon" target="main"
				   onclick="$('div#main').load(this.href);return false;"><span class="	glyphicon glyphicon-usd"></span> 优惠券管理</a></li>
			<li><a href="${APP_PATH }/index/findAllEmail" target="main"
				   onclick="$('div#main').load(this.href);return false;"><span class="	glyphicon glyphicon-send"></span> 邮箱管理</a></li>
			<li><a href="${APP_PATH }/index/findAllIllegalinfo" target="main"
				   onclick="$('div#main').load(this.href);return false;"><span class="glyphicon glyphicon-th-large"></span> 违规管理</a></li>
			<c:if test="${sessionScope.user.role==1 }">
				<li><a href="${APP_PATH }/index/findAllIncome" target="main"
					   onclick="$('div#main').load(this.href);return false;"><span class="glyphicon glyphicon-yen"></span> 收入管理</a></li>
			</c:if>
			<li><a href="${APP_PATH }/index/findAllUser" target="main"
				   onclick="$('div#main').load(this.href);return false;"><span class="	glyphicon glyphicon-user"></span> 用户管理</a></li>
			<li><a href="${APP_PATH }/index/findAllDepot" target="main"
				   onclick="$('div#main').load(this.href);return false;"><span class="glyphicon glyphicon-tags"></span> 历史停车</a></li>
			<c:if test="${sessionScope.user.role==1 }">
				<li><a href="${APP_PATH }/index/system" target="main"
					   onclick="$('div#main').load(this.href);return false;"><span class="	glyphicon glyphicon-circle-arrow-down"></span> 导出功能</a></li>
			</c:if>

		</ul>
	</div>
	<div id="main"
		 style="float: left; width: 80%; min-height: 100%; margin-right: 0; border: 1px solid #ccc; background-color: white;">
	</div>
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
</div>

</body>

</html>