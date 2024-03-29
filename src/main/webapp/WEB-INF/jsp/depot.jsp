<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div  style="margin: 2%;background-color: #fff;">
	<div class="tables">
		<table class="table"style="margin: 2%;width: 96%">
			<caption>
				<div style="float: left; line-height: 10px; padding: 10px 10px;font-size:14px;font-weight: 600;color: #1E9FFF">历史停车管理</div>
				<div class="col-lg-6" style="width: 30%; float: left;">
					<div class="input-group">
						<c:if test="${sessionScope.user.role!=3 }">
							<input id="number" placeholder="请输入车位号/卡号/车牌号" type="text" class="form-control" >
						</c:if>
						<c:if test="${sessionScope.user.role==3 }">
							<input id="number" placeholder="车牌号" type="text" class="form-control" >
						</c:if>
						<span
								class="input-group-btn">
								<button class="btn btn-default btn1" onclick="findDepotNum()" type="button">查询</button>
								<a id="findAllDepot" href="" target="main"
								   onclick="$('div#main').load(this.href);return false;"></a>
							</span>
					</div>
					<!-- /input-group -->
				</div>
			</caption>
			<tr>
				<th>序号</th>
				<th>车位号</th>
				<th>卡号</th>
				<th>车牌号</th>
				<th>入库时间</th>
				<th>出库时间</th>
				<th>查看</th>
			</tr>
			<c:forEach items="${parkinfoallDatas.pages }" var="item" varStatus="status">
				<tr>
					<td style="vertical-align:middle">${status.index+1 }</td>
					<td style="vertical-align:middle">${item.parknum }</td>
					<td style="vertical-align:middle">${item.cardnum }</td>
					<td style="vertical-align:middle">${item.carnum }</td>
					<td style="vertical-align:middle">${item.parkin }</td>
					<td style="vertical-align:middle">${item.parkout }</td>
					<td style="vertical-align:middle"><input class="x-admin-sm layui-btn bt-blue1" onclick="findParkinfoById(${item.id})" type="button" value="查看"></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div class="page">
		<ul class="pagination">

			<li><a href="${APP_PATH }/index/findAllDepot?tag=${parkinfoallDatas.tag}&&page=${parkinfoallDatas.current}&&name=${parkinfoallDatas.extra}"
				   target="main"
				   onclick="$('div#main').load(this.href);return false;">&laquo;</a></li>
			<li><a href="${APP_PATH }/index/findAllDepot?tag=${parkinfoallDatas.tag}&&page=${parkinfoallDatas.current+1}&&name=${parkinfoallDatas.extra}"
				   target="main"
				   onclick="$('div#main').load(this.href);return false;">${parkinfoallDatas.current+1}</a></li>
			<c:if test="${parkinfoallDatas.current+1>=parkinfoallDatas.countPage}">
				<li><a href="${APP_PATH }/index/findAllDepot?tag=${parkinfoallDatas.tag}&&page=${parkinfoallDatas.current+1}&&name=${parkinfoallDatas.extra}"
					   target="main"
					   onclick="$('div#main').load(this.href);return false;">&raquo;</a></li>
			</c:if>
			<c:if test="${parkinfoallDatas.current+1<parkinfoallDatas.countPage}">
				<li><a href="${APP_PATH }/index/findAllDepot?tag=${parkinfoallDatas.tag}&&page=${parkinfoallDatas.current+2}&&name=${parkinfoallDatas.extra}"
					   target="main"
					   onclick="$('div#main').load(this.href);return false;">&raquo;</a></li>
			</c:if>
		</ul>
	</div>

</div>
<script type="text/javascript">
	//查看详情
	function findParkinfoById(item){
		$.ajax({
			type:'post',
			datatype:'json',
			data:{id:item},
			url:'${APP_PATH }/index/depot/findParkinfoById',
			success:function(data){
				if(data.code==100)
					{
					var html = "<label>车牌号：</label><div style=\"width: 30%;\">"
						+ "<div class=\"input-group\">"
						+ "<input value=\""+data.extend.parkinfoall.carnum+"\" type=\"text\" class=\"form-control\" readonly  unselectable=\"on\">"
						+ "</div>"
						+ "</div>"
						+"<label>停车卡号：</label><div style=\"width: 30%;\">"
						+ "<div class=\"input-group\">"
						+ "<input value=\""+data.extend.parkinfoall.cardnum+"\" type=\"text\" class=\"form-control\" readonly  unselectable=\"on\">"
						+ "</div>"
						+ "</div>"
						+"<label>入库时间：</label><div style=\"width: 30%;\">"
						+ "<div class=\"input-group\">"
						+ "<input value=\""+data.extend.parkinfoall.parkin+"\" type=\"text\" class=\"form-control\" readonly  unselectable=\"on\">"
						+ "</div>"
						+ "</div>"
						+ "<label>出库时间：</label><div style=\"width: 30%;\">"
						+ "<div class=\"input-group\">"
						+ "<input value=\""+data.extend.parkinfoall.parkout+"\" type=\"text\" class=\"form-control\" readonly  unselectable=\"on\">"
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
	
	
	function findDepotNum()
	{
		var number=$("#number").val();
				$("#findAllDepot").attr("href","${APP_PATH }/index/findAllDepot?name="+number);
				$("#findAllDepot").click();
		
	}
</script>