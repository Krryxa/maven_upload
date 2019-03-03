<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+path+"/";
	pageContext.setAttribute("basePath", basePath);
%>
<!DOCTYPE HTML>
<html>
  <head>
  	<title>文件上传</title>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<meta name="keywords" content="keyword1,keyword2,keyword3">
	<meta name="description" content="This is my page">
	<style>
		*{padding: 0;margin:0}
		ul,li{list-style:none;}
		a{color:#333;text-decoration: none;}
		.hidden{display:hidden;}
		input{border:0;outline:0;margin-bottom:10px;}
		img{vertical-align: middle;}
		.clear{clear:both;}
		body{font-size:14px;font-family: "微软雅黑";background:#333}
		.buttons{    display: block;
				    width: 80px;
				    height: 26px;
				    color: black;
				    background: #ffffff;
				    font-size: 14px;
				    font-family: "微软雅黑";
				    margin: 0 auto;
				    cursor: pointer;
				    margin-bottom: 10px;}
		
		.container{width:1080px;margin:80px auto;}
		
		.formbox{float:left;text-align:center;width:300px;}
		.title{color:#fff;font-size:24px;margin-bottom:20px;}
		.formbox .f_btn{width:100px;height:40px;background:#0c0;color:#fff;font-size:14px;font-family:"微软雅黑";cursor:pointer;font-weight:bold;}
		.massage p{color:#fff;text-align:left;height:24px;}
		.sinimg{width:300px;height:300px;line-height:300px;color:#fff;}

		.formmutibox{float:left;width: 342px;margin: 0 24px 0;text-align:center;}
		.formmutibox .title{color:#fff;font-size:24px;margin-bottom:20px;}
		.formmutibox .f_btn{width:100px;height:40px;background:#0c0;color:#fff;font-size:14px;font-family:"微软雅黑";cursor:pointer;font-weight:bold;}
		.files table td{color:#fff;width:135px;}
		
		::-webkit-scrollbar{width: 10px;height: 10px;}
		::-webkit-scrollbar-track{background: 0 0;}
		::-webkit-scrollbar-track-piece{background:#fff;}
		::-webkit-scrollbar-thumb{background-color: #a2a2a2; border-radius: 5px;}
		::-webkit-scrollbar-thumb:hover{background-color: #868686;}
		::-webkit-scrollbar-corner{background:#212121;}
		::-webkit-scrollbar-resizer{background:#FF0BEE;}
		scrollbar{-moz-appearance:none !important;background:rgb(0,255,0) !important;}
		scrollbarbutton{-moz-appearance:none !important;background-color:rgb(0,0,255) !important;}
		scrollbarbutton:hover{-moz-appearance:none !important;background-color:rgb(255,0,0) !important;}
		/* 隐藏上下箭头 */
		scrollbarbutton{display:none !important;}
		/* 纵向滚动条宽度 */
		scrollbar[orient="vertical"]{min-width:12px !important;}
	</style>
  </head>
  <body>
  	<div class="container">
		<!--单文件上传-->
		<div class="formbox">
			<p class="title">单个文件上传</p>
			<input type="file" id="fileupone" name="fileup" accept="image/jpeg,image/png" onchange="uploadFile(this)"/>
			<div class="massage">
				<p>文件名：<span class="filename"></span></p>
				<p>大小：<span class="filesize"></span></p>
				<p>文件格式：<span class="fileext"></span></p>
				<p>预览：</p>
				<div class="sinimg">
					预览图
				</div>
			</div>
		</div>
		
		<!--多文件上传-->
		<div class="formmutibox">
			<p class="title">多文件上传（单选）</p>
			<input type="file" class="fileupon11" accept="image/jpeg,image/png" />
			<input type="file" class="fileupon12" accept="image/jpeg,image/png" />
			<input type="file" class="fileupon13" accept="image/jpeg,image/png" />
			<input type="button" class="buttons" value="提交" onclick="multipartone()"/>
			<!--files start-->
			<div class="files">
				<table>
					<thead>
						<tr>
							<td class="filelook2">文件预览</td>
							<td class="filename2">文件名</td>
							<td class="filesize2">大小</td>
						</tr>
					</thead>
					<tbody id="f_tbody">
					</tbody>
				</table>
			</div>
		</div>
	
	  	<!--多文件上传-->
		<div class="formmutibox">
			<p class="title">多文件上传（多选）</p>
			<input type="file" class="fileupon33" name="fileupmulti" accept="image/jpeg,image/png" onchange="mutiFiles(this)" multiple/>
			<!--files start-->
			<div class="files">
				<table>
					<thead>
						<tr>
							<td class="filelook33">文件预览</td>
							<td class="filename33">文件名</td>
							<td class="filesize33">大小</td>
						</tr>
					</thead>
					<tbody id="f_tbody_m">
					</tbody>
				</table>
			</div>
		</div>
	  	<div class="clear"></div>
	</div>
  	
  	<script type="text/javascript" src="${basePath}/resource/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript">var basePath = "${basePath}";</script>
  	<script type="text/javascript">
  	
	  	//单文件上传
		function uploadFile(obj){
			//创建一个FormData对象：用一些键值对来模拟一系列表单控件：即把form中所有表单元素的name与value组装成一个queryString
		    var form = new FormData();
			var fileObj = obj.files[0];
			form.append("doc",fileObj);

			$.ajax({
				type:"post",
				data:form,
				url:basePath+"/upload/file",
                contentType: false, //必须false才会自动加上正确的Content-Type
                /*
             	   必须false才会避开jQuery对 formdata 的默认处理
             	  XMLHttpRequest会对 formdata 进行正确的处理
                */
                processData: false,
				success:function(data){
					var jdata = eval("("+data+")");
					$(".filename").text(jdata.oldname);
					$(".filesize").text(jdata.size);
					$(".fileext").text(jdata.ext);
					var imgString = "<img alt='预览图' src='"+jdata.url+"' width='300'>";
					$(".sinimg").html(imgString);
					//清除文件表单
					$("#fileupone").val("");
				}
			});
		}
	  	
	  	//多文件上传(单选)
	  	function multipartone(){
	  		var file1 = $(".fileupon11").get(0).files[0];
	  		var file2 = $(".fileupon12").get(0).files[0];
	  		var file3 = $(".fileupon13").get(0).files[0];
	  		//如果都是空，则直接退出
	  		if(isEmpty(file1) && isEmpty(file2) && isEmpty(file3)) return;
	  		
	  		var form = new FormData();
	  		//用同一个名字，注入到controller层的参数数组
			form.append("doc",file1);
			form.append("doc",file2);
			form.append("doc",file3);

			$.ajax({
				type:"post",
				data:form,
				url:basePath+"/upload/mutl",
                contentType: false, //必须false才会自动加上正确的Content-Type
                /*
             	   必须false才会避开jQuery对 formdata 的默认处理
             	  XMLHttpRequest会对 formdata 进行正确的处理
                */
                processData: false,
				success:function(data){
					var len = data.length;
					for(var i = 0;i < len;i++){
						var datajson = data[i];
						$("#f_tbody").append("<tr class='f_item'>"+
								"<td><img src='"+datajson.url+"' alt='预览图像' width='40' height='40' /></td>"+
								"<td>"+datajson.oldname+"</td>"+
								"<td>"+datajson.size+"</td>"
							);
					}
					//清除文件表单
					$(".fileupon11").val("");
					$(".fileupon12").val("");
					$(".fileupon13").val("");
				}
			});
	  	}
	  	
	  	//多文件上传(多选)
	  	function mutiFiles(obj){
	  		var form = new FormData();
			var fileObj = obj.files;
			var length = fileObj.length;
			//将fileObj转换成数组
			//var filese = Array.from(fileObj);
			for(var i = 0;i < length;i++){
				form.append("doc",fileObj[i]);
			}
			$.ajax({
				type:"post",
				data:form,
				url:basePath+"/upload/mutl",
                contentType: false, //必须false才会自动加上正确的Content-Type
                /*
             	   必须false才会避开jQuery对 formdata 的默认处理
             	  XMLHttpRequest会对 formdata 进行正确的处理
                */
                processData: false,
				success:function(data){
					var len = data.length;
					for(var i = 0;i < len;i++){
						var datajson = data[i];
						$("#f_tbody_m").append("<tr class='f_item'>"+
								"<td><img src='"+datajson.url+"' alt='预览图像' width='40' height='40' /></td>"+
								"<td>"+datajson.oldname+"</td>"+
								"<td>"+datajson.size+"</td>"
							);
					}
					//清除文件表单
					$(".fileupon33").val("");
				}
			});
	  	}
	  	
	  	/**
		 * 判断非空
		 * 
		 * @param val
		 * @returns {Boolean}
		 */
		function isEmpty(val) {
			val = $.trim(val);
			if (val == null)
				return true;
			if (val == undefined || val == 'undefined')
				return true;
			if (val == "")
				return true;
			if (val.length == 0)
				return true;
			if (!/[^(^\s*)|(\s*$)]/.test(val))
				return true;
			return false;
		}
  	</script>
  </body>
</html>


