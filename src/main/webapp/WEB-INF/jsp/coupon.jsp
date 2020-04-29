<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div  style="margin: 2%;background-color: #fff;">
<a id="findAllCoupon" href="" target="main"
	onclick="$('div#main').load(this.href);return false;"></a>
	<div class="tables">
	<table class="table" style="margin: 2%;width: 96%">
				<caption>
					<div style="float: left; line-height: 10px; padding: 10px 10px;font-size:14px;font-weight: 600;color: #1E9FFF">优惠券管理</div>
					<div class="col-lg-6" style="width: 30%; float: left;">
						<div class="input-group">
							<c:if test="${sessionScope.user.role!=3 }">
							<input id="name" placeholder="优惠券号/停车卡号" type="text" class="form-control" > 
							</c:if>
							<c:if test="${sessionScope.user.role==3 }">
							<input id="name" placeholder="优惠券号" type="text" class="form-control" > 
							</c:if>
							<span
								class="input-group-btn">
								<button class="btn btn-default btn1" onclick="findCouponByName()" type="button">查询</button>
							</span>
							<a id="findAllCoupon" href="" target="main"
					onclick="$('div#main').load(this.href);return false;"></a>
						</div>
						<!-- /input-group -->
					</div>
					<c:if test="${sessionScope.user.role==1 }">
					<button class="btn btn-default bt-blue" onclick="addCoupon()" type="button">生成优惠券</button>
					</c:if>
				</caption>
				<tr>
					<th>序号</th>
					<th>优惠券号</th>
					<th>优惠金额</th>
					<th>停车卡号</th>
					<th>过期时间</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${couponDatas.pages }" var="item" varStatus="status">
					<tr>
						<td>${status.index+1 }</td>
						<td>${item.couponNum }</td>
						<td>${item.money }</td>
						<td>${item.cardnum }</td>
						<td>${item.time }</td>
						<td><input class="btn btn-default bt-blue" style="margin-right: 4px" type="button" onclick="findCouponById(${item.id })" value="查看"><input class="btn btn-default bt-red" type="button" onclick="deleteCouponInfo(${item.id})" value="删除"></td>
					</tr>
					</c:forEach>
			</table>
	</div>
	<div class="page">
			<ul class="pagination">
				
				<li><a href="${APP_PATH }/index/findAllCoupon?page=${couponDatas.current}&&name=${couponDatas.extra}"
				target="main"
					onclick="$('div#main').load(this.href);return false;">&laquo;</a></li>
				<li><a href="${APP_PATH }/index/findAllCoupon?page=${couponDatas.current+1}&&name=${couponDatas.extra}"
				target="main"
					onclick="$('div#main').load(this.href);return false;">${couponDatas.current+1}</a></li>
				<c:if test="${couponDatas.current+1>=couponDatas.countPage}">
				<li><a href="${APP_PATH }/index/findAllCoupon?page=${couponDatas.current+1}&&name=${couponDatas.extra}"
				target="main"
					onclick="$('div#main').load(this.href);return false;">&raquo;</a></li>
				</c:if>
				<c:if test="${couponDatas.current+1<couponDatas.countPage}">
				<li><a href="${APP_PATH }/index/findAllCoupon?page=${couponDatas.current+2}&&name=${couponDatas.extra}"
				target="main"
					onclick="$('div#main').load(this.href);return false;">&raquo;</a></li>
				</c:if>
			</ul>
	</div>
</div>
<script type="text/javascript">
	function findCouponByName()
	{
		var name=$("#name").val();
				$("#findAllCoupon").attr("href","${APP_PATH }/index/findAllCoupon?name="+name);
				$("#findAllCoupon").click();
		
	}
	
	//查看详情
	function findCouponById(item){
		$.ajax({
			type:'post',
			datatype:'json',
			data:{id:item},
			url:'${APP_PATH }/index/coupon/findCouponById',
			success:function(data){
				if(data.code==100)
					{
					var html = "<label>优惠券码：</label><div style=\"width: 30%;\">"
						+ "<div class=\"input-group\">"
						+ "<input value=\""+data.extend.coupon.couponNum+"\" type=\"text\" class=\"form-control\" readonly  unselectable=\"on\">"
						+ "</div>"
						+ "</div>"
						+"<label>停车卡号：</label><div style=\"width: 30%;\">"
						+ "<div class=\"input-group\">"
						+ "<input value=\""+data.extend.coupon.cardnum+"\" type=\"text\" class=\"form-control\" readonly  unselectable=\"on\">"
						+ "</div>"
						+ "</div>"
						+"<label>优惠金额：</label><div style=\"width: 30%;\">"
						+ "<div class=\"input-group\">"
						+ "<input value=\""+data.extend.coupon.money+"\" type=\"text\" class=\"form-control\" readonly  unselectable=\"on\">"
						+ "</div>"
						+ "</div>";
						$("#myModalLabel").html("优惠券详情");
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
	
	/* 删除违规模态框显示*/
	function deleteCouponInfo(item) {
		var html = "<label>确认删除该优惠券吗？</label><div style=\"width: 30%;\">";
		$("#myModalLabel").html("删除违规");
		$("#checkSubmit").html("删除");
		$("#checkSubmit").attr("onclick","deleteCoupon("+item+")");
		$(".modal-body").append(html);
		$("#myModal").modal('show'); 
	}
		//删除优惠券
	function deleteCoupon(item)
	{
		$.ajax({
			type:'post',
			datatype:'json',
			data:{id:item},
			url:'${APP_PATH }/index/coupon/deleteCoupon',
			success:function(data){
				alert(data.extend.va_msg);
				if(data.code==100)
					{
					$("#myModal").modal('hide');
					$("#findAllCoupon").attr("href","${APP_PATH }/index/findAllCoupon");
					$("#findAllCoupon").click();
					}else{
						return false;
					}
				
			}
		})
	}
		
		function addCoupon()
		{
			var html = "<label>优惠券金额：</label><div style=\"width: 30%;\">"
				+ "<div class=\"input-group\">"
				+ "<input id=\"money\" name=\"money\" type=\"text\" class=\"form-control\" unselectable=\"on\">"
				+ "</div>"
				+ "</div>"
				+ "<label>优惠券数量：</label><div style=\"width: 30%;\">"
				+ "<div class=\"input-group\">"
				+ "<input id=\"count\" name=\"count\" type=\"text\" class=\"form-control\" unselectable=\"on\">"
				+ "</div></div>";
				$("#myModalLabel").html("添加优惠券");
				$("#checkSubmit").html("添加");
				$("#checkSubmit").attr("onclick","addCouponSubmit()");
				$(".modal-body").append(html);
				$("#myModal").modal('show');
		}
		
		function addCouponSubmit()
		{
			$.ajax({
				type:'post',
				url:'${APP_PATH }/index/coupon/setCoupon',
				datatype:'json',
				data:$("#checkForm").serializeArray(),
				success:function(data){
					if(data.code==100){
						alert("添加成功!");
						$("#myModal").modal('hide');
						$("#findAllCoupon").attr("href","${APP_PATH }/index/findAllCoupon");
						$("#findAllCoupon").click();
					}else{
						alert(data.extend.va_msg);
					}
				}
			})
		}
</script>