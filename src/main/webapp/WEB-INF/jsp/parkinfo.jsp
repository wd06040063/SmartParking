<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div  style="margin: 2%;background-color: #fff;">
<a id="parkInfo" href="" target="main"
   onclick="$('div#main').load(this.href);return false;"></a>
    <div class="tables">
            <table class="table" style="margin: 2%;width: 96%">
                <caption>
                    <div style="float: left; line-height: 10px; padding: 10px 10px;font-size:14px;font-weight: 600;color: #1E9FFF">停车位管理</div>
                    <div class="col-lg-6" style="width: 30%; float: left;">
                        <div class="input-group">
                            <input id="inputcardnum" placeholder="请输入卡号" type="text" class="form-control">
                            <span class="input-group-btn">
								<button class="btn btn-default btn1" type="button" onclick="checkOutByCardnum()">出库</button>
							</span>
                        </div>
                        <!-- /input-group -->
                    </div>
                </caption>
                <tr>
                    <th>车位号</th>
                    <th>状态</th>
                    <th>类型</th>
                    <th>操作</th>
                    <th>查看</th>
                </tr>
                <c:forEach items="${parkspaces.pages }" var="item">
                    <tr>
                        <td>${item.parkid }</td>
                        <td>${item.status==0?"空":"已停" }</td>
                        <td>${item.tag==1?"正常车位":item.tag==2?"临时车位":"紧急车位" }</td>
                        <td><c:if test="${item.status==0 }">
                            <input class="btn btn-default bt-blue" type="button"
                                   onclick="checkIn(${item.parkid},${item.id })" value="手动入库">
                            <button type="button" class="btn btn-default bt-purple" data-toggle="modal" data-target="#fileModal" onclick="fileUpload(${item.parkid})">
                                车牌识别
                            </button>
                            <button type="button" class="btn btn-default bt-purple" data-toggle="modal" data-target="#fileModal" onclick="fileUpload(${item.parkid})">
                                RFID识别
                            </button>
                        </c:if> <c:if test="${item.status!=0 }">
                            <input onclick="checkOut(${item.parkid})"
                                   class="btn btn-default bt-blue" type="button" value="出库"/>
                            <input onclick="addIllegal(${item.parkid})"
                                   class="btn btn-default bt-red" type="button" value="违规"/>
                        </c:if>
                        </td>

                        <td><input class="btn btn-default bt-green" type="button" onclick="checkDetail(${item.parkid})" value="查看"></td>
                    </tr>
                </c:forEach>
            </table>
    </div>
    <div class="page">
            <ul class="pagination">

                <li><a href="${APP_PATH }/index/findAllCar?tag=${parkspaces.tag}&&page=${parkspaces.current}"target="main"
                       onclick="$('div#main').load(this.href);return false;">&laquo;</a></li>
                <li><a href="${APP_PATH }/index/findAllCar?tag=${parkspaces.tag}&&page=${parkspaces.current+1}" target="main"
                       onclick="$('div#main').load(this.href);return false;">${parkspaces.current+1} </a></li>
                <c:if test="${parkspaces.current+1>=parkspaces.countPage}">
                    <li><a href="${APP_PATH }/index/findAllCar?tag=${parkspaces.tag}&&page=${parkspaces.current+1}" target="main"
                           onclick="$('div#main').load(this.href);return false;">&raquo;</a></li>
                </c:if>
                <c:if test="${parkspaces.current+1<parkspaces.countPage}">
                    <li><a href="${APP_PATH }/index/findAllCar?tag=${parkspaces.tag}&&page=${parkspaces.current+2}" target="main"
                           onclick="$('div#main').load(this.href);return false;">&raquo;</a></li>
                </c:if>
            </ul>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function(){
        var role=$("#role").val();
        if(role==3)
        {
            $("#depotcardIndex").click();
        }
    });
    $('#myModal').on('hidden.bs.modal', function () {
        $("#checkSubmit").show();
        $(".modal-body").empty();
        $("#loseSubmit").hide();
    })
    $('#myModal1').on('hidden.bs.modal', function () {
        $("#pay_zfb").show();
        $("#pay_cash").hide();
        $("#pay_wx").hide();
        $("#loseSubmit").hide();
    })
    /* 入库模态框显示*/
    function checkIn(parknum,id) {
        var tem=0;
        $.ajax({
            type: 'post',
            url: '${APP_PATH }/index/depot/checkTem',
            async:false,
            success: function (data) {
                if(data.code==100)
                {
                    tem=1;
                }
            }
        })

        var html = "<input id=\"id\" name=\"id\" value=\""+id+"\" hidden=\"hidden\"/>"
            +"<input id=\"parkNum\" name=\"parkNum\" value=\""+parknum+"\" hidden=\"hidden\"/><label>入库卡号：</label><div style=\"width: 30%;\">"
            + "<div class=\"input-group\">"
            + "<input id=\"cardNum\" name=\"cardNum\" placeholder=\"请输入卡号\" type=\"text\" class=\"form-control\">"
            + "</div>"
            + "</div>"
            + "<label>车牌号：</label><div style=\"width: 30%;\">"
            + "<div class=\"input-group\">"
            + "<input id=\"carNum\" name=\"carNum\" placeholder=\"请输入车牌号\" type=\"text\" class=\"form-control\">"
            + "</div></div>"
            + "<label>是否临时停车：</label>"
            +"<select onchange=\"changeParkTem()\" id=\"parkTem\" name=\"parkTem\" style=\"width:100px\" class=\"form-control\"> "
            +"<option value=\"0\">否</option>";
        if(tem==1)
        {
            html+="<option value=\"1\">是</option>";
        }
        html+="</select>";
        $("#myModalLabel").html("车辆入库");
        $("#checkSubmit").html("入库");
        $("#checkSubmit").attr("onclick","checkInSubmit()");
        $(".modal-body").append(html);
        $("#myModal").modal('show');
    }
    function changeParkTem(){
        var parkTem=$("#parkTem").val();
        if(parkTem==1)
        {
            $("#cardNum").val('');
            $('#cardNum').attr("readonly",true);
        }
        else{
            $('#cardNum').attr("readonly",false);
        }
    }
    /* 文件上传 */
    function fileUpload(parkId)
    {
        $("#parkid").val(parkId);
    }

    /* 自动入库提交 */
    function autoCheckInSubmit(){
        debugger;
        var parkid=$("#parkid").val();
        console.log("获取到的parkid="+parkid);
        $.ajaxFileUpload({
            type:'post',
            url:'${APP_PATH }/update/fileUpload',
            data:{id:parkid},
            secureuri : false,
            fileElementId:'fileupdate',
            dataType: 'json',//服务器返回的格式
            // async : false,
            contentType:'application/x-www-form-urlencoded',
            success:function(data){

                if(data.code==100)
                {
                    alert("车牌识别成功！识别车号为："+data.extend.vb_msg);
                    $("#fileModal").modal('hide');
                    $("#parkInfo").attr("href","${APP_PATH }/index/findAllCar");
                    $("#parkInfo").click();
                }else{
                    alert(data.extend.va_msg);
                }
            }

        })

    }

    /* 入库提交 */
    function checkInSubmit(){
        var parkTem=$("#parkTem option:selected").val();
        var carNum=$("#carNum").val();
        var cardNum=$("#cardNum").val();
        if(parkTem==0)
        {
            if(cardNum.trim()=='')
            {
                alert("请输入卡号!");
                return false;
            }
        }
        if(parkTem==1&&cardNum.trim()!='')
        {
            alert("有停车卡不能临时停车!");
        }
        if(carNum.trim()=='')
        {
            alert("请输入车牌号!");
            return false;
        }
        $.ajax({
            type:'post',
            url:'${APP_PATH }/index/check/checkIn',
            datatype:'text',
            data:$("#checkForm").serializeArray(),
            contentType:'application/x-www-form-urlencoded',
            success:function(data){
                console.log(data);
                if(data.code==100)
                {
                    alert("入库成功！");
                    $("#myModal").modal('hide');
                    $("#parkInfo").attr("href","${APP_PATH }/index/findAllCar");
                    $("#parkInfo").click();
                }else{
                    alert(data.extend.va_msg);
                }
            }
        })
    }
    /* 出库模态框显示 */
    function checkOut(parknum) {
        $.ajax({
            type:'get',
            url:'${APP_PATH }/index/check/findParkinfoByParknum',
            datatype:'json',
            data:{parkNum:parknum},
            success:function(data){
                debugger;
                if(data.code==100)
                {
                    var parkTem="否";
                    if(data.extend.parkInfo.parktem==1)
                    {
                        parkTem="是";
                    }
                    var html =
                        // 用什么方式支付
                        "<input id=\"payid\" name=\"payid\" value=\"9\" hidden=\"hidden\"/>"
                        // 需要支付金额
                        +"<input id=\"pay_money\" name=\"pay_money\" value=\"0\" hidden=\"hidden\"/>"
                        // 扣费还是月卡或年卡未到期 (0扣费，1不用扣费，9付钱)
                        +"<input id=\"pay_type\" name=\"pay_type\" value=\"9\" hidden=\"hidden\"/>"
                        +"<input id=\"parkNum\" name=\"parkNum\" value=\""+parknum+"\" hidden=\"hidden\"/><label>停车位：</label><div style=\"width: 30%;\">"
                        + "<div class=\"input-group\">"
                        + "<input id=\"parknum\" name=\"parknum\" value=\""+parknum+"\" type=\"text\" class=\"form-control\" readonly>"
                        + "</div>"
                        + "</div>"
                        +"<label>出库卡号：</label><div style=\"width: 30%;\">"
                        + "<div class=\"input-group\">"
                        + "<input id=\"cardNum\" name=\"cardNum\" value=\""+data.extend.parkInfo.cardnum+"\" type=\"text\" class=\"form-control\" readonly>"
                        + "</div>"
                        + "</div>"
                        + "<label>车牌号：</label><div style=\"width: 30%;\">"
                        + "<div class=\"input-group\">"
                        + "<input id=\"carNum\" name=\"carNum\" value=\""+data.extend.parkInfo.carnum+"\" type=\"text\" class=\"form-control\" readonly >"
                        + "</div></div>"
                    /* 				+ "<label>是否临时停车：</label><br>"
                                    +parkTem */
                    $("#myModalLabel").html("车辆出库");
                    $("#checkSubmit").html("出库");
                    $("#checkSubmit").attr("onclick","ispay("+parknum+")");
                    $(".modal-body").append(html);
                    $("#myModal").modal('show');
                }
            }
        })
    }
    /*显示支付宝支付*/
    function pay_zfb()
    {
        $("#pay_zfb").show();
        $("#pay_cash").hide();
        $("#pay_wx").hide();
        $("#payid").val(1);

    }
    /*显示微信支付*/
    function pay_wx()
    {
        $("#pay_cash").hide();
        $("#pay_zfb").hide();
        $("#pay_wx").show();
        $("#payid").val(2);
    }
    /*显示现金支付*/
    function pay_cash()
    {
        $("#pay_wx").hide();
        $("#pay_zfb").hide();
        $("#pay_cash").show();
        $("#payid").val(0);
    }
    /*是否扫码支付*/
    function ispay(parknum)
    {
        $.ajax({
            type:'post',
            url:'${APP_PATH }/index/check/ispay',
            datatype:'json',
            data:{parknum:parknum},
            success:function(data){
                if(data.code==100)
                {
                    $("#myModal1").modal('show');
                    $("#zfb_text").text(data.extend.money_pay);
                    $("#wx_text").text(data.extend.money_pay);
                    $("#cash_text").text(data.extend.money_pay);
                    $("#pay_money").val(data.extend.money_pay);
                    alert(data.extend.va_msg);
                }
                else{
                    alert(data.extend.money_pay);
                    $("#pay_type").val(data.extend.type);
                    $("#pay_money").val(data.extend.money_pay);
                    if(data.extend.type==9)
                    {
                        alert("系统出错！");
                        return false;
                    }
                    //直接用卡扣费
                    if(data.extend.type==0)
                    {
                        checkOutSubmit();
                    }
                    //月卡或年卡还没到期
                    else{
                        checkOutSubmit();
                    }
                }
                $("#paySubmit").attr("onclick","checkOutSubmit()");
            }
        })
    }
    /* 出库提交 */
    function checkOutSubmit(){
        $.ajax({
            type:'get',
            url:'${APP_PATH }/index/check/checkOut',
            datatype:'text',
            data:$("#checkForm").serializeArray(),
            contentType:'application/x-www-form-urlencoded',
            success:function(data){
                alert("出库成功！");
                $("#myModal").modal('hide');
                $("#payForm").modal('hide');
                $("#myModal1").modal('hide');

                $("#parkInfo").attr("href","${APP_PATH }/index/findAllCar");
                $("#parkInfo").click();
            }
        })
    }

    /* 通过卡号/车牌号出库模态框显示 */
    function checkOutByCardnum() {
        var cardnum=$("#inputcardnum").val();
        if(cardnum=="")
        {
            alert("输入不能为空!");
            return false;
        }
        $.ajax({
            type:'get',
            url:'${APP_PATH }/index/check/findParkinfoByCardnum',
            datatype:'json',
            data:{cardnum:cardnum},
            success:function(data){
                debugger;
                if(data.code==100)
                {
                    var parkTem="否";
                    if(data.extend.parkInfo.parktem==1)
                    {
                        parkTem="是";
                    }
                    var html = "<input id=\"parkNum\" name=\"parkNum\" value=\""+data.extend.parkInfo.parknum+"\" hidden=\"hidden\"/><label>车位号：</label><div style=\"width: 30%;\">"
                        + "<div class=\"input-group\">"
                        + "<input readonly id=\"parkNum\" name=\"parkNum\" value=\""+data.extend.parkInfo.parknum+"\" type=\"text\" class=\"form-control\">"
                        + "</div>"
                        + "</div>"
                        +"<label>出库卡号：</label><div style=\"width: 30%;\">"
                        + "<div class=\"input-group\">"
                        + "<input readonly id=\"cardNum\" name=\"cardNum\" value=\""+data.extend.parkInfo.cardnum+"\" type=\"text\" class=\"form-control\">"
                        + "</div>"
                        + "</div>"
                        + "<label>车牌号：</label><div style=\"width: 30%;\">"
                        + "<div class=\"input-group\">"
                        + "<input readonly id=\"carNum\" name=\"carNum\" value=\""+data.extend.parkInfo.carnum+"\" type=\"text\" class=\"form-control\">"
                        + "</div></div>"
                    /* 		+ "<label>是否临时停车：</label><br>"
                            +parkTem */
                    $("#myModalLabel").html("车辆出库");
                    $("#checkSubmit").html("出库");
                    $("#checkSubmit").attr("onclick","checkOutSubmit()");
                    $(".modal-body").append(html);
                    $("#myModal").modal('show');
                }
            }
        })
    }


    /* 查看详情模态框显示 */
    function checkDetail(parknum) {
        $.ajax({
            type:'get',
            url:'${APP_PATH }/index/check/findParkinfoDetailByParknum',
            datatype:'json',
            data:{parkNum:parknum},
            success:function(data){
                var username="";
                if(data.extend.user!=null){
                    username=data.extend.user.username;
                }
                if(data.code==100)
                {
                    var parkTem="否";
                    if(data.extend.parkInfo.parktem==1)
                    {
                        parkTem="是";
                    }
                    var html = "<label>停车位号：</label><div style=\"width: 30%;\">"
                        + "<div class=\"input-group\">"
                        + "<input value=\""+data.extend.parkInfo.parknum+"\" type=\"text\" class=\"form-control\" readonly  unselectable=\"on\">"
                        + "</div>"
                        + "</div>"
                        +"<label>停车用户：</label><div style=\"width: 30%;\">"
                        + "<div class=\"input-group\">"
                        + "<input value=\""+username+"\" type=\"text\" class=\"form-control\" readonly  unselectable=\"on\">"
                        + "</div>"
                        + "</div>"
                        +"<label>停车卡号：</label><div style=\"width: 30%;\">"
                        + "<div class=\"input-group\">"
                        + "<input value=\""+data.extend.parkInfo.cardnum+"\" type=\"text\" class=\"form-control\" readonly  unselectable=\"on\">"
                        + "</div>"
                        + "</div>"
                        + "<label>车牌号：</label><div style=\"width: 30%;\">"
                        + "<div class=\"input-group\">"
                        + "<input value=\""+data.extend.parkInfo.carnum+"\" type=\"text\" class=\"form-control\" readonly  unselectable=\"on\">"
                        + "</div></div>"
                        + "<label>停入时间：</label><div style=\"width: 30%;\">"
                        + "<div class=\"input-group\">"
                        + "<input value=\""+data.extend.parkin+"\" type=\"text\" class=\"form-control\" readonly  unselectable=\"on\">"
                        + "</div></div>"
                    /* 				+ "<label>是否临时停车：</label><br>"
                                    +parkTem */
                    $("#myModalLabel").html("停车位详情");
                    $("#checkSubmit").hide();
                    $(".modal-body").append(html);
                    $("#myModal").modal('show');
                }
                else{
                    alert("该停车位没有停车！");
                }
            }
        })
    }

    /* 违规模态框显示*/
    function addIllegal(parknum) {
        $.ajax({
            type:'get',
            url:'${APP_PATH }/index/check/findParkinfoByParknum',
            datatype:'json',
            data:{parkNum:parknum},
            success:function(data){
                var html ="<label>车位号：</label><div style=\"width: 30%;\">"
                    + "<div class=\"input-group\">"
                    +"<input readonly type=\"text\" class=\"form-control\" name=\"parknum\" value=\""+parknum+"\" />"
                    +"</div>"
                    +"</div>"
                    +"<label>入库卡号：</label><div style=\"width: 30%;\">"
                    + "<div class=\"input-group\">"
                    + "<input readonly id=\"cardNum\" name=\"cardNum\" value=\""+data.extend.parkInfo.cardnum+"\" placeholder=\"请输入卡号\" type=\"text\" class=\"form-control\">"
                    + "</div>"
                    + "</div>"
                    + "<label>车牌号：</label><div style=\"width: 30%;\">"
                    + "<div class=\"input-group\">"
                    + "<input readonly id=\"carNum\" name=\"carNum\" value=\""+data.extend.parkInfo.carnum+"\" placeholder=\"请输入车牌号\" type=\"text\" class=\"form-control\">"
                    + "</div></div>"
                    + "<label>违规原因：</label><div style=\"width: 30%;\">"
                    + "<div class=\"input-group\">"
                    + "<textarea id=\"illegalInfo\" name=\"illegalInfo\" placeholder=\"请输入违规原因\" type=\"text\" class=\"form-control\" ></textarea>"
                    + "</div></div>"
                    + "<label>是否临时停车：</label>"
                    +"<select id=\"parkTem\" name=\"parkTem\" style=\"width:100px\" class=\"form-control\"> "
                    +"<option value=\"0\">否</option><option value=\"1\">是</option> </select>";
                $("#myModalLabel").html("添加违规");
                $("#checkSubmit").html("添加");
                $("#checkSubmit").attr("onclick","illegalSubmit()");
                $(".modal-body").append(html);
                $("#myModal").modal('show');
            }
        })
    }


    /*查看停车情况*/
    function nowCar(){
        window.location.assign("${APP_PATH }index/line")
    }

    /* 违规提交*/
    function illegalSubmit()
    {
        $.ajax({
            type:'post',
            url:'${APP_PATH }/index/check/illegalSubmit',
            datatype:'text',
            data:$("#checkForm").serializeArray(),
            contentType:'application/x-www-form-urlencoded',
            success:function(data){
                if(data.code==100)
                {
                    alert(data.extend.va_msg);
                    $("#myModal").modal('hide');
                    window.location.href="${APP_PATH }/index/toindex";
                }else{
                    alert(data.extend.va_msg)
                }
            }
        })
    }


</script>
</html>