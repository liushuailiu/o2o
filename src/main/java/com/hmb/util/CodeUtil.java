package com.hmb.util;

import javax.servlet.http.HttpServletRequest;

public class CodeUtil {
	/**
	 * 验证码验证工具
	 * @param request
	 * @return
	 */
	public static boolean checkVerifyCode(HttpServletRequest request) {
		String verifyCodeExpected = (String) request.getSession().getAttribute(
				com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
		String verifyCodeActual = HttpServletRequestUtil.getString(request,
				"verifyCodeActual");
		return verifyCodeActual == null || !verifyCodeActual.equalsIgnoreCase(verifyCodeExpected);
	}
}
