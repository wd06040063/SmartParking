<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
	<style>
		.btn-l{
			background-color: white;
			margin: 10% 15% ;
			padding: 5%;
			border: white solid 2px;
			border-radius: 20px;
			font-size: 32px;
			width: 25%;
			transition: all 0.3s;
		}
		.btn-l i{
			transition: all 0.3s;
			padding: 10% 15%;
		}
		.btn-l span{
			float: left;
			padding: 20% 15% 0 15%;
		}
		.btn-l:hover{
			border: rgba(77, 161, 255, 0.48) solid 2px;
		}
		.btn-l:hover>i{
			color: #1E9FFF;
		}
	</style>
</head>
<body>
<a id="exportIncomeA" href=""></a>
<button class="btn btn-l"  onclick="exportIncome()" type="button"> <i class="iconfont" style="font-size: 100px;">&#xe6a2;</i><span>导出收入</span></button>
<button class="btn btn-l" style="margin-left: 0" onclick="setCharge()" type="button"><i class="iconfont " style="font-size: 100px;">&#xe758;</i><span>设置收费</span></button>
</body>
<script type="text/javascript">
	function exportIncome()
	{
		var html = "<label>开始时间：</label><div style=\"width: 30%;\">"
				+ "<div class=\"input-group\">"
				+ "<input type=\"text\" value=\"\" placeholder=\"开始时间\" id=\"datetimepickerStart\"/>"
				+ "</div>"
				+ "</div>"
				+ "<label>结束时间：</label><div style=\"width: 30%;\">"
				+ "<div class=\"input-group\">"
				+ "<input type=\"text\" value=\"\" placeholder=\"结束时间\" id=\"datetimepickerEnd\"/>"
				+ "</div></div>";
		$("#myModalLabel").html("导出收入");
		$("#checkSubmit").html("导出");
		$("#checkSubmit").attr("onclick","exportIncomeSubmit()");
		$(".modal-body").append(html);
		$("#myModal").modal('show');
		$('#datetimepickerStart').datetimepicker({
			format: 'yyyy-mm-dd hh:ii'
		});
		$('#datetimepickerEnd').datetimepicker({
			format: 'yyyy-mm-dd hh:ii'
		});
	}
	function exportIncomeSubmit()
	{
		var datetimepickerStart=$("#datetimepickerStart").val();
		var datetimepickerEnd=$("#datetimepickerEnd").val();
		$("#myModal").modal('hide');
		window.location="${APP_PATH }/index/exportIncome?datetimepickerStart="+datetimepickerStart+"&&datetimepickerEnd="+datetimepickerEnd;
	}
	function setCharge()
	{
		var html = "<label>时收费</label><div style=\"width: 30%;\">"
				+ "<div class=\"input-group\">"
				+ "<input id=\"hourmoney\" name=\"hourmoney\" type=\"text\" class=\"form-control\" unselectable=\"on\">"
				+ "</div>"
				+ "</div>"
				+"<label>月收费</label><div style=\"width: 30%;\">"
				+ "<div class=\"input-group\">"
				+ "<input id=\"monthcard\" name=\"monthcard\" type=\"text\" class=\"form-control\" unselectable=\"on\">"
				+ "</div>"
				+ "</div>"
				+ "<label>年收费：</label><div style=\"width: 30%;\">"
				+ "<div class=\"input-group\">"
				+ "<input id=\"yearcard\" name=\"yearcard\" type=\"text\" class=\"form-control\" unselectable=\"on\">"
				+ "</div></div>"
				+"<label>违规收费</label><div style=\"width: 30%;\">"
				+ "<div class=\"input-group\">"
				+ "<input id=\"illegal\" name=\"illegal\" type=\"text\" class=\"form-control\" unselectable=\"on\">"
				+ "</div>"
				+ "</div>"
		$("#myModalLabel").html("设置收费（空为不修改）");
		$("#checkSubmit").html("设置");
		$("#checkSubmit").attr("onclick","setChargeSubmit()");
		$(".modal-body").append(html);
		$("#myModal").modal('show');
	}
	function setChargeSubmit()
	{
		$.ajax({
			type:'post',
			url:'${APP_PATH }/index/setSystem',
			datatype:'json',
			data:$("#checkForm").serializeArray(),
			success:function(data){
				if(data.code==100){
					alert("设置成功!");
					$("#myModal").modal('hide');
				}else{
					alert("设置失败!");
				}
			}
		})
	}
</script>
</html>