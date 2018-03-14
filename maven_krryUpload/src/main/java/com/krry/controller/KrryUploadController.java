package com.krry.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.json.JSONException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.krry.util.UploadUtil;

/**
 * 文件上传类
 * KrryUploadController
 * @author krry
 * @version 1.0.0
 *
 */
@Controller
@RequestMapping("/upload")
public class KrryUploadController {
	
	/**
	 * 单文件上传
	 * @param file
	 * @param request
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 * @throws JSONException
	 */
	@ResponseBody
	@RequestMapping(value = "/file")
	public String krryupload(@RequestParam("doc") MultipartFile file, HttpServletRequest request) throws IllegalStateException, IOException, JSONException{

		//调用工具类完成上传，返回相关数据到页面
		return UploadUtil.simUpload(file, request);
	}
	
	/**
	 * 多文件上传
	 * @param file
	 * @param request
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 * @throws JSONException
	 */
	// 这里的MultipartFile[] file表示前端页面上传过来的多个文件，file对应页面中多个file类型的input标签的name，但框架只会将一个文件封装进一个MultipartFile对象，
  // 并不会将多个文件封装进一个MultipartFile[]数组，直接使用会报[Lorg.springframework.web.multipart.MultipartFile;.<init>()错误，
  // 所以需要用@RequestParam校正参数（参数名与MultipartFile对象名一致），当然也可以这么写：@RequestParam("file") MultipartFile[] files。
	@ResponseBody
	@RequestMapping(value = "/mutl")
	public List<HashMap<String, Object>> krryuploadMutl(@RequestParam("doc") MultipartFile[] file, HttpServletRequest request) throws IllegalStateException, IOException, JSONException{
		//调用工具类完成上传，返回相关数据到页面
		return UploadUtil.mutlUpload(file, request);
	}
}


