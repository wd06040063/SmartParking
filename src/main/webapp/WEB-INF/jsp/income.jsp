<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div  style="margin: 2%;background-color: #fff;">
<a id="findAllIncome" href="" target="main"
	onclick="$('div#main').load(this.href);return false;"></a>

<form id="queryIncomes">
	<div class="tables">
	<table class="table"style="margin: 2%;width: 96%">
				<caption>
					<div style="float: left; line-height: 10px; padding: 10px 10px;font-size:14px;font-weight: 600;color: #1E9FFF">收入管理</div>
					<div style="float: left;">

							<form class="layui-form layui-col-space5">
								<div class="layui-inline layui-show-xs-block">
									<input class="layui-input" autocomplete="off" placeholder="开始日" name="start" id="start"></div>
								<div class="layui-inline layui-show-xs-block">
									<input class="layui-input" autocomplete="off" placeholder="截止日" name="end" id="end"></div>

							</form>

					</div>
					<div class="col-lg-6" style="width: 30%; float: left;">
						<div class="input-group">
							<input id="content"  placeholder="卡号/车牌号" type="text" class="form-control" > <span
								class="input-group-btn">
								<button onclick="findByCondition()" class="btn btn-default btn1" type="button">查询</button>
							</span>
						</div>
						<!-- /input-group -->
					</div>

					<div class="dropdown" style="float: right; margin-right: 10%">
				
		<!-- <button onclick="findByCondition()" class="btn btn-default" type="button">收入分析</button> -->
				<!--<input type="button" value="收入分析" onclick="newDoc()" class="btn btn-default">

			<button type="button" class="btn dropdown-toggle" id="dropdownMenu1"
				data-toggle="dropdown">
				<span id="income_method">收入方式</span><span class="caret"></span>
			</button>
			<input type="hidden" id="income_method_num" value="9" />
			<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
				<li role="presentation" onclick="chooseMethod(0)">现金</li>
				<li role="presentation" onclick="chooseMethod(2)">微信</li>
				<li role="presentation" onclick="chooseMethod(1)">支付宝</li>
			</ul>-->
		</div>
				</caption>
				<tr>
					<th>序号</th>
					<th>车牌号</th>
					<th>停车卡号</th>
					<th>收入</th>
					<th>收入方式</th>
					<th>收入来源</th>
					<th>收入时间</th>
					<th>时长</th>
					<th>违规</th>
					<td>操作</td>
				</tr>
				<c:forEach items="${incomes.pages }" var="item" varStatus="status">
					<tr>
						<td>${status.index+1 }</td>
						<td>${item.carnum }</td>
						<td>${item.cardnum }</td>
						<td>${item.money }</td>
						<td>${item.method==0?'现金':item.method==1?'支付宝':item.method==2?'微信':'扣卡费' }</td>
						<td>${item.source==0?'充值':'出库' }</td>
						<td>${item.time }</td>
						<td>${item.duration }</td>
						<td>${item.isillegal }</td>
						<td><input class="btn btn-default bt-green" type="button" onclick="findIncomeInfo(${item.id })" value="查看"></td>
					</tr>
					</c:forEach>
			</table>
		<div class="page">
			<ul class="pagination">
				
				<li><a href="${APP_PATH }/index/findAllIncome?tag=${incomes.tag}&&page=${incomes.current}"
				target="main"
					onclick="$('div#main').load(this.href);return false;">&laquo;</a></li>
				<li><a href="${APP_PATH }/index/findAllIncome?tag=${incomes.tag}&&page=${incomes.current+1}"
				target="main"
					onclick="$('div#main').load(this.href);return false;">${incomes.current+1}</a></li>
				<c:if test="${incomes.current+1>=incomes.countPage}">
				<li><a href="${APP_PATH }/index/findAllIncome?tag=${incomes.tag}&&page=${incomes.current+1}"
				target="main"
					onclick="$('div#main').load(this.href);return false;">&raquo;</a></li>
				</c:if>
				<c:if test="${incomes.current+1<incomes.countPage}">
				<li><a href="${APP_PATH }/index/findAllIncome?tag=${incomes.tag}&&page=${incomes.current+2}"
				target="main"
					onclick="$('div#main').load(this.href);return false;">&raquo;</a></li>
				</c:if>
			</ul>
		</div>
			<div class="income-ad" >
					总收入：${countMoney}元<br>
					</div>
	</div>
</form>
</div>
<script>layui.use('laydate',
		function() {
			var laydate = layui.laydate;

			//执行一个laydate实例
			laydate.render({
				elem: '#start' //指定元素
			});

			//执行一个laydate实例
			laydate.render({
				elem: '#end' //指定元素
			});

		});</script>
<script>layui.use('table',
		function() {
			var table = layui.table;

			//监听单元格编辑
			table.on('edit(test)',
					function(obj) {
						var value = obj.value //得到修改后的值
								,
								data = obj.data //得到所在行所有键值
								,
								field = obj.field; //得到字段
						layer.msg('[ID: ' + data.id + '] ' + field + ' 字段更改为：' + value);
					});

			//头工具栏事件
			table.on('toolbar(test)',
					function(obj) {
						var checkStatus = table.checkStatus(obj.config.id);
						switch (obj.event) {
							case 'getCheckData':
								var data = checkStatus.data;
								layer.alert(JSON.stringify(data));
								break;
							case 'getCheckLength':
								var data = checkStatus.data;
								layer.msg('选中了：' + data.length + ' 个');
								break;
							case 'isAll':
								layer.msg(checkStatus.isAll ? '全选': '未全选');
								break;
						};
					});
		});</script>
<script>var _hmt = _hmt || []; (function() {
	var hm = document.createElement("script");
	hm.src = "https://hm.baidu.com/hm.js?b393d153aeb26b46e9431fabaf0f6190";
	var s = document.getElementsByTagName("script")[0];
	s.parentNode.insertBefore(hm, s);
})();</script>

<script type="text/javascript">
$('#datetimepickerStart').datetimepicker({
    format: 'yyyy-mm-dd hh:ii'
});
$('#datetimepickerEnd').datetimepicker({
    format: 'yyyy-mm-dd hh:ii'
});
	//查看详情
	function findIncomeInfo(item){
		$.ajax({
			type:'post',
			datatype:'json',
			data:{id:item},
			url:'${APP_PATH }/index/income/findIncomeInfo',
			success:function(data){
				if(data.code==100)
					{
					var source="";
					var method="";
					if(data.extend.income.source==0)
						{
						source="充值";
						}else{
						source="出库";
						}
					if(data.extend.income.method==0){
						method="现金";
					}else if(data.extend.income.method==1){
						method="支付宝";
					}else {
						method="微信";
					}
					var html = "<label>车牌号：</label><div style=\"width: 30%;\">"
						+ "<div class=\"input-group\">"
						+ "<input value=\""+data.extend.income.carnum+"\" type=\"text\" class=\"form-control\" readonly  unselectable=\"on\">"
						+ "</div>"
						+ "</div>"
						+"<label>停车卡号：</label><div style=\"width: 30%;\">"
						+ "<div class=\"input-group\">"
						+ "<input value=\""+data.extend.income.cardnum+"\" type=\"text\" class=\"form-control\" readonly  unselectable=\"on\">"
						+ "</div>"
						+ "</div>"
						+"<label>收入：</label><div style=\"width: 30%;\">"
						+ "<div class=\"input-group\">"
						+ "<input value=\""+data.extend.income.money+"\" type=\"text\" class=\"form-control\" readonly  unselectable=\"on\">"
						+ "</div>"
						+ "</div>"
						+ "<label>收入来源：</label><div style=\"width: 30%;\">"
						+ "<div class=\"input-group\">"
						+ "<input value=\""+source+"\" type=\"text\" class=\"form-control\" readonly  unselectable=\"on\">"
						+ "</div></div>"
						+ "<label>收入方式：</label><div style=\"width: 30%;\">"
						+ "<div class=\"input-group\">"
						+ "<input value=\""+method+"\" type=\"text\" class=\"form-control\" readonly  unselectable=\"on\">"
						+ "</div></div>";
						$("#myModalLabel").html("收入详情");
						$("#checkSubmit").hide();
						$(".modal-body").append(html);
						$("#myModal").modal('show');
					}
				else{
					alert(data.extend.va_msg);
					return false;
				}
			}
		})
	}
	
	function findByCondition()
	{
		var datetimepickerStart=$("#datetimepickerStart").val();
		var datetimepickerEnd=$("#datetimepickerEnd").val();
		var num=$("#income_method_num").val();
		var content=$("#content").val();
		if(num==null)
			{
			num=9;
			}
		$("#findAllIncome").attr("href","${APP_PATH }/index/findAllIncome?content="+content+"&&startTime="+datetimepickerStart+"&&endTime="+datetimepickerEnd+"&&num="+num);
		$("#findAllIncome").click();
	}

	function newDoc()
 {
 window.location.assign("${APP_PATH }/index/incomeCharts")
 }
	
	function chooseMethod(item)
	{
		if(item==0)
		{
			$("#income_method").text("现金");
			$("#income_method_num").val(0);
		}
		else if(item==1)
		{
			$("#income_method").text("支付宝");
			$("#income_method_num").val(1);
		}
		else
		{
			if(item==2)
			{
			$("#income_method").text("微信");
			$("#income_method_num").val(2);
			}
		}
	}

</script>