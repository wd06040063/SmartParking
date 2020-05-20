<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!DOCTYPE html>
<html>
<head>
	<title>智慧停车管理云平台</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- Bootstrap -->
	<link href="${APP_PATH }/bootstrap-3.3.5-dist/css/bootstrap.min.css"
		  rel="stylesheet" media="screen">
	<link href="${APP_PATH }/css/login.css" rel="stylesheet">
	<script src="${APP_PATH }/bootstrap-3.3.5-dist/js/jquery-3.0.0.min.js"></script>
	<script src="${APP_PATH }/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${APP_PATH }/js/DD_belatedPNG_0.0.8a.js"></script>
	<style>

		#cas{
			position: absolute;
		}
	</style>

	<script>
		function keyLogin(){
			if (event.keyCode===13)  //回车键的键值为13
				document.getElementById("input1").click(); //调用登录按钮的登录事件
		}

	</script>
</head>
<body onkeydown="keyLogin();">
<div style="width: 100%;height: 100%;background-image: url(${APP_PATH }/pic/login.png);position: absolute;background-size:100% 100% ">
	<canvas id="cas" width="840" height="945"></canvas>

	<script>
		function ChangeImg(){
			var img=document.getElementById("img1");
			//防止页面缓存
			img.src="${APP_PATH }/verifycode/getVerifyCodeImage.do"+ "?r="+Math.random();
		}
		DD_belatedPNG.fix('div, ul, img, li, input,p,ul,ol,h1,h2,h3,a,span,i');

		var canvas = document.getElementById("cas");
		var ctx = canvas.getContext("2d");

		resize();
		window.onresize = resize;

		function resize() {
			canvas.width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
			canvas.height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
		}

		var RAF = (function() {
			return window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || function(callback) {
				window.setTimeout(callback, 1000 / 60);
			};
		})();

		// 鼠标活动时，获取鼠标坐标
		var warea = {x: null, y: null, max: 20000};
		window.onmousemove = function(e) {
			e = e || window.event;

			warea.x = e.clientX;
			warea.y = e.clientY;
		};
		window.onmouseout = function(e) {
			warea.x = null;
			warea.y = null;
		};

		// 添加粒子
		// x，y为粒子坐标，xa, ya为粒子xy轴加速度，max为连线的最大距离
		var dots = [];
		for (var i = 0; i < 150; i++) {
			var x = Math.random() * canvas.width;
			var y = Math.random() * canvas.height;
			var xa = Math.random()*0.75 - 1;
			var ya = Math.random()*0.75 - 1;

			dots.push({
				x: x,
				y: y,
				xa: xa,
				ya: ya,
				max: 6000
			})
		}

		// 延迟100秒开始执行动画，如果立即执行有时位置计算会出错
		setTimeout(function() {
			animate();
		}, 100);

		// 每一帧循环的逻辑
		function animate() {
			ctx.clearRect(0, 0, canvas.width, canvas.height);

			// 将鼠标坐标添加进去，产生一个用于比对距离的点数组
			var ndots = [warea].concat(dots);

			dots.forEach(function(dot) {

				// 粒子位移
				dot.x += dot.xa;
				dot.y += dot.ya;

				// 遇到边界将加速度反向
				dot.xa *= (dot.x > canvas.width || dot.x < 0) ? -1 : 1;
				dot.ya *= (dot.y > canvas.height || dot.y < 0) ? -1 : 1;
				dot.strokeStyle = 'rgba(255,255,255,' + (ratio + 0.2) + ')';
				// 绘制点
				ctx.fillRect(dot.x - 0.5, dot.y - 0.5, 1, 1);

				// 循环比对粒子间的距离
				for (var i = 0; i < ndots.length; i++) {
					var d2 = ndots[i];

					if (dot === d2 || d2.x === null || d2.y === null) continue;
					var xc = dot.x - d2.x;
					var yc = dot.y - d2.y;

					// 两个粒子之间的距离
					var dis = xc * xc + yc * yc;

					// 距离比
					var ratio;

					// 如果两个粒子之间的距离小于粒子对象的max值，则在两个粒子间画线
					if (dis < d2.max) {

						// 如果是鼠标，则让粒子向鼠标的位置移动
						if (d2 === warea && dis > (d2.max / 2)) {
							dot.x -= xc * 0.03;
							dot.y -= yc * 0.03;
						}

						// 计算距离比
						ratio = (d2.max - dis) / d2.max;

						// 画线
						ctx.beginPath();
						ctx.lineWidth = ratio / 2;
						//线条颜色
						ctx.strokeStyle = 'rgba(255,255,255,' + (ratio + 0.2) + ')';
						ctx.fillStyle = '#fff';
						ctx.moveTo(dot.x, dot.y);
						ctx.lineTo(d2.x, d2.y);
						ctx.stroke();
					}
				}

				// 将已经计算过的粒子从数组中删除
				ndots.splice(ndots.indexOf(dot), 1);
			});

			RAF(animate);
		}
	</script>
	<div style="width: 700px;height: 360px;position: relative;top:16%;left: 28%">
		<form id="loginForm" class="form-horizontal" role="form" style="padding: 8% " action="${APP_PATH }/index/toindex" method="post">
			<div class="form-group" style="padding-bottom: 24px;text-align: center;">
				<h3 style="color:white;font-weight: 400;letter-spacing: 10px;">智慧停车管理云平台</h3>
			</div>
			<div class="form-group" style="padding:0 15% 0 20%">
				<%--@declare id="firstname"--%><label for="firstname" class="col-sm-2 control-label font" >账号</label>
				<div class="col-sm-8">
					<input type="text" class="form-control form-input" id="username" name="username"
						   placeholder="请输入账号" style="width: 100%;" onblur="checkUsernameExit(this)">
					<span style="color: white"></span>
				</div>
			</div>
			<div class="form-group" style="padding: 2% 15% 0 20%">
				<%--@declare id="lastname"--%><label for="lastname" class="col-sm-2 control-label font" >密码</label>
				<div class="col-sm-8">
					<input type="password" class="form-control form-input" id="password" name="password"
						   placeholder="请输入密码" style="width: 100%;" onblur="checkPasswordNull(this)">
					<span style="color: white"></span>
				</div>
			</div>
			<div class="form-group"style="padding:2% 15% 0 20% ">
				<label class="col-sm-2 control-label font">验证</label>
				<div class="col-sm-8" style="padding-right: 0">
					<img id="img1" title="点击获取新验证码" src="${APP_PATH }/verifycode/getVerifyCodeImage.do"  onclick="ChangeImg()" width="72" height="30" alt="" class="yanzhen-img" >

					<input type="text" placeholder="请输入验证码" name="code" id="code"
	                 onblur="checkVerifyCode(this)" class="form-input form-control yanzhen"style="float:left">
					<span style="color: white;float: left"></span>
				</div>


			</div>
			<div class="form-group" style="width: 70%;">
				<div class="col-sm-offset-2 col-sm-10">
					<button id="input1" type="button" onclick="submitForm()" class="btn btn-lg on" style="width: 40%">登录</button>
				</div>
			</div>
		</form>
	</div>
</div>
</body>

<script type="text/javascript">

	function submitForm()
	{
		var username = document.getElementById("username").value;
		if(username == null || username == ""){
			return false;
		}else{
		var data=$("#loginForm").serializeArray();
		$.ajax({
			type:'get',
			url:'${APP_PATH }/login/index',
			data:data,
			dataType:'json',
			success:function(result){
				if(result.code==200)
				{
					$("#password").next("span").text(result.extend.va_msg);

				}else if(result.code==211){
					$("#code").next("span").text(result.extend.va_msg);
					ChangeImg();
				}
				else{
					$("#password").next("span").text("");
					$("#loginForm").submit();
				}
			}
		});
	}
}
	function clearError(item)
	{
		$(item).next("span").text("");
	}

	function checkPasswordNull(item)
	{
		clearError(item);
		if(item.value=="")
		{
			$(item).next("span").text("密码不能为空");
		}
		else{
			$(item).next("span").text("");
		}
	}
	function checkVerifyCode(item)
	{
		clearError(item);
		if(item.value=="")
		{
			$(item).next("span").text("验证码不能为空");
		}
		else{
			clearError(item);

		}
	}
	function checkUsernameExit(item)
	{
		if(item.value=="")
		{
			$(item).next("span").text("用户名不能为空");
		}else{
			$.ajax({
				type:'get',
				url:'${APP_PATH }/login/checkUsernameExit',
				data:{username:item.value},
				dataType:'json',
				success:function(result){
					if(result.code==200)
					{
						$(item).next("span").text(result.extend.va_msg);
					}
					else{
						clearError(item);
					}
				}
			});
		}
	}
</script>
</html>
