
$(function() {
	var currPage=1;
	var count;
		// 左侧导航栏控制
		$("ul li[class!='active']").hide();
		$("table").hide();
		$("div#title").hide();
		$("ul li:first-child").click(
				function() {
					if ($(this).next().is(":hidden")) {
						$(this).nextAll().show();
						$(this).parent().siblings().children(
								"li[class!='active']").hide();
					} else {
						$(this).nextAll().hide();
					}
				});
		
		// ------------------------------------------
		// 商品种类操作
		$("a.li11").click(function(){  // 商品种类表格初始化
			$("div#title").hide();
			$("table.li11").show().siblings().hide();
			// 移除原先的记录
			$("button.li111").parent().parent().siblings().remove();
			// 添加第一行元素
			$("button.li111").parent().parent().before('<tr><th>商品种类编号</th><th>商品种类名称</th><th>操作</th></tr>');
		
			$.post("SearchProductType",function(msg){
				if(msg!=null){
					$.each(msg,function(i,list){
						$("button.li111").parent().parent().before("<tr><td>"+list.productTypeId+"</td><td>"+list.productType+"</td><td><button class='li112 btn-danger'>删除</button></td></tr>");
					});
			}
				
			// 删除商品种类事件
			$("button.li112").click(function(){ 
				var productTypeId=$(this).parent().prev().prev().text();
				$.post("DeleteProductType",{"productTypeId":productTypeId},"text");
				$(this).parent().parent().hide();  // 隐藏该行
			});
			},"json");
		});
		
		$("button.li111").click(  // 增加商品种类操作
				function() {
					var productTypeId = $(this).parent().parent().find(
							"input[name='productTypeId']").val();
					var productType = $(this).parent().parent().find(
							"input[name='productType']").val();
					$.post("InsertProductType", {
						"productTypeId" : productTypeId,
						"productType" : productType
					}, function(msg) {
						if (msg == "true") {
							$("button.li111").parent().parent().before("<tr><td>"+productTypeId+"</td><td>"+productType+"</td><td><button class='li112 btn-danger'>删除</button></td></tr>");
							$("input[name='productTypeId']").val("");
							$("input[name='productType']").val("");
						}else{
							alert("您插入的数据有误");
						}
						
						// 删除商品种类事件
						$("button.li112").click(function(){ 
							var productTypeId=$(this).parent().prev().prev().text();
							var msg=$.post("DeleteProductType",{"productTypeId":productTypeId},"text");
							$(this).parent().parent().hide();  // 隐藏该行
						});
					}, "text");
				});
		
		
		$(".middle-right-table").find("input[name='productTypeId']").blur(function(){ 
			var productTypeId =$(this).val();
			if(productTypeId=="" || isNaN(productTypeId)){  // 判断文本框是否为空和输入的是否为数字
				$(this).addClass("red");
			}else{
				$(this).removeClass("red");
			}
		});
		// ————————————————————————————————————————————————————
		
		
		
		// 商品管理
		$("a.li21").click(function(e){  // 商品表格初始化
			$("div#title").show();
			$("table.li21").show().siblings().hide();
			// 移除原先的记录
			$("button.li211").parent().parent().siblings().remove();
			// 添加第一行元素
			$("button.li211").parent().parent().before('<tr><th>商品编号</th><th>商品名称</th><th>商品单价</th><th>商品库存</th><th>商品描述</th><th>商品类型</th><th>商品图片</th><th>操作</th></tr>');
			$.post("SearchProduct",{"currPage":currPage},function(msg){
				if(msg!=null){
					count=msg.p;
					$.each(msg.l,function(i,list){
						$("button.li211").parent().parent().before("<tr><td>"+list.productId+"</td><td>"+list.productName+"</td><td><input type='text' class='form-control col-sm-1' name='changePrice' value='"+list.productPrice+"'></td><td><input type='text' class='form-control col-sm-1'  name='changeInventory' value='"+list.productInventory+"'></td><td><textarea cols='20' rows='3' disabled>"+list.productDetail+"</textarea></td><td>"+list.productTypeInfo.productType+"</td><td><img style='height:50px;width:50px' src='images/"+list.defaultImg+"'></td><td><button class='li212 btn-danger'>删除</button></td></tr>");
					});
				}
				
				// 添加商品单价和库存修改事件
				$("input[name='changeInventory']").blur(function(){ 
					var productId=$(this).parent().parent().find("td:eq(0)").text();
					var productInventory =$(this).val();
					if(productInventory!="" && !isNaN(productInventory) && productInventory>0){  // 判断文本框是否为空和输入的是否为数字
						$(this).removeClass("red");
						$.post("UpdateProductInventory",{"productId":productId,"productInventory":productInventory},function(msg){// 更新数据库数据
							if(msg=="true"){
								alert("成功更新商品库存!");
							}else{
								alert("请正确输入库存信息!");
							}
						},"text");
					}else{
						$(this).addClass("red");
					}
				});
				
				$("input[name='changePrice']").blur(function(){ 
					var productId=$(this).parent().parent().find("td:eq(0)").text();
					var productPrice =$(this).val();
					if(productPrice!="" && !isNaN(productPrice) && productPrice>0){  // 判断文本框是否为空和输入的是否为数字
						$(this).removeClass("red");
						$.post("UpdateProductPrice",{"productId":productId,"productPrice":productPrice},function(msg){// 更新数据库数据
							if(msg=="true"){
								alert("成功更新商品单价!");
							}else{
								alert("请正确输入单价信息!");
							}
						},"text");
					}else{
						$(this).addClass("red");
					}
				});
				
				
				
				// 添加删除商品事件
				$("button.li212").click(function(){ 
					var productId=$(this).parent().parent().find("td:first").text();
					$.post("DeleteProduct",{"productId":productId});
					// $(this).parent().parent().hide(); //隐藏该行
					$("a.li21").trigger("click");
				});
					},"json");
			 
			// 商品类型下拉框加载
			$.post("SearchProductType",function(msg){
				$("select[name='productType']").children().detach();
				if(msg!=null){
					$.each(msg,function(i,list){
						$("select[name='productType']").append("<option>"+list.productType+"</option>");
					});
				}
			},"json");
			
		});
		
		
		// 分页查询
		$("#prev").click(function(){
			currPage= currPage==1?1:currPage-1;
			$("a.li21").trigger("click");
		});
		$("#next").click(function(){
			var lastPage= count%5==0?parseInt(count/5):parseInt(count/5)+1;
			currPage= currPage==lastPage?lastPage:currPage+1; 
			$("a.li21").trigger("click");
		});
		$("#home").click(function(){
			currPage=1; 
			$("a.li21").trigger("click");
		});
		
		var productType;// 下拉列表事件
		$("select[name='productType']").click(function(){
			productType=$('select option:selected').text();
		});
		var defaultImg; // 图片选中事件
		$("input[name='defaultImg']").change(function(){
			defaultImg=$(this).val();
		});
		$("button.li211").click(  // 增加商品操作
				function() {
					var productId = $("input[name='productId']").val();
					var productName = $("input[name='productName']").val();
					var productPrice = $("input[name='productPrice']").val();
					var productInventory = $("input[name='productInventory']").val();
					var productDetail = $("textarea[name='productDetail']").val();
					$.post("InsertProduct", {
						"productId" : productId,
						"productName" : productName,
						"productPrice":productPrice,
						"productInventory":productInventory,
						"productDetail":productDetail,
						"productType":productType,
						"defaultImg":defaultImg
					}, function(msg) {
						if ( msg=="true") {
							alert("成功添加记录！");
							$("input").val("");
							$("textarea[name='productDetail']").val("");
							count=count+1;
							var lastPage= count%5==0?parseInt(count/5):parseInt(count/5)+1;
							currPage=lastPage;
							$("a.li21").trigger("click");
						}else{
							alert("您插入的数据有误！");
						}
					}, "text");
				});
		
		
		$("input[name='productId']").blur(function(){ 
			var productId =$(this).val();
			if(productId=="" || isNaN(productId)){  // 判断文本框是否为空和输入的是否为数字
				$(this).addClass("red");
			}else{
				$(this).removeClass("red");
			}
		});
		
		$("input[name='productInventory']").blur(function(){ 
			var productInventory =$(this).val();
			if(productInventory=="" || isNaN(productInventory)){  // 判断文本框是否为空和输入的是否为数字
				$(this).addClass("red");
			}else{
				$(this).removeClass("red");
			}
		});
		
		$("input[name='productPrice']").blur(function(){ 
			var productPrice =$(this).val();
			if(productPrice=="" || isNaN(productPrice)){  // 判断文本框是否为空和输入的是否为数字
				$(this).addClass("red");
			}else{
				$(this).removeClass("red");
			}
		});
		// -------------------------------------------------------
		
		// 用户订单管理
		$("a.li31").click(function(){
			$("div#title").hide(); // 隐藏分页查询按钮
			$("table.li31").show().siblings().hide();
			// 移除原先的记录,除了表头
			$("table.li31").find("tr:gt(0)").remove();
			$.post("ManageOrderinfo",function(msg){
				if(msg!=null){
					$.each(msg,function(i,list){
						var c=1;
						$.each(list.orderItemList,function(j,li){
							if(c==1){
								$("table.li31").append("<tr><td rowspan="+list.orderItemList.length+">"+list.orderId+"</td><td rowspan="+list.orderItemList.length+">"+list.orderDate+"</td><td>"+li.productInfo.productName+"</td><td><img style='height:50px;width:50px' src='images/"+li.productInfo.defaultImg+"'></td><td rowspan="+list.orderItemList.length+">"+list.addressInfo.province+list.addressInfo.city+list.addressInfo.area+list.addressInfo.street+"</td><td rowspan="+list.orderItemList.length+">"+list.userInfo.userName+"</td><td rowspan="+list.orderItemList.length+">"+list.userInfo.phoneNumber+"</td><td rowspan="+list.orderItemList.length+">"+list.orderPrice+"</td><td rowspan="+list.orderItemList.length+">"+list.orderStatusInfo.orderStatus+"</td></tr>");
								c=c+1;
							}else{
								$("table.li31").append("<tr><td>"+li.productInfo.productName+"</td><td><img style='height:50px;width:50px' src='images/"+li.productInfo.defaultImg+"'></td></tr>");
							}
						});
					});
				}
			},"json");
		});
		
		// ----------------------------------------------

		// 用户管理
		$("a.li41").click(function(){  // 用户表格初始化
			$("div#title").hide(); // 隐藏分页查询按钮
			$("table.li41").show().siblings().hide();
			// 移除原先的记录,除了表头
			$("table.li41").find("tr:gt(0)").remove();
			$.post("ManageUserInfo",function(msg){
				if(msg!=null){
					$.each(msg,function(i,list){
						$("table.li41").append("<tr><td>"+list.userId+"</td><td>"+list.userName+"</td><td>"+list.userPass+"</td><td>"+list.email+"</td><td>"+list.phoneNumber+"</td></tr>");
						if("已锁定" == list.userStatus){
							$("table.li41").find("tr:last-child").append("<td><button class='li411 btn-danger'>"+list.userStatus+"</button></td>");
						}else{
							$("table.li41").find("tr:last-child").append("<td><button class='li411 btn-success'>"+list.userStatus+"</button></td>");
						}
					});
				}
				
			// 锁定用户事件
			$("button.li411").click(function(){ 
				var userId=$(this).parent().parent().find("td:first-child").text();
				var userStatus=$(this).text();
				$.post("LockUser",{"userId":userId,"userStatus":userStatus},function(msg){
					$("a.li41").trigger("click");
				});
			});
			
			},"json");
			
		});
			
// $("table.li41").datagrid({
// title: "用户信息管理",
// border: true,
// locale: "zh_CN",
// striped: true,
// collapsible: false,
// url: "ManagementServlet?action=userManage",
// queryParams: {searchText: ""},
// toolbar: '#toolbar',
// pagination: true,//表示在datagrid设置分页
// rownumbers: false,
// singleSelect: true,
// });
			// $("table.li41").datagrid('reload');
			
		// });
	});