package com.motiveon.security;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import com.motiveon.dto.EmployeeVO;

public class LoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
	private String logFileName;
	private String logSavedPath;

	public LoginSuccessHandler(String logFileName, String logSavedPath) {
		super();
		this.logFileName = logFileName;
		this.logSavedPath = logSavedPath;
	}

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {

		User user = (User) authentication.getDetails();
		EmployeeVO loginUser = user.getEmployeeVO();
		
		System.out.println("Authorities: " + loginUser.getAuthority());
		
		HttpSession session = request.getSession();
		session.setAttribute("loginUser", loginUser);
		session.setMaxInactiveInterval(100 * 60);

		// 로그인 정보를 스트링으로 저장.
		String tag = "[login:user]";
		String log = tag + loginUser.getEno() + "," + loginUser.getPhone() + "," + loginUser.getEmail() + ","
				+ request.getRemoteAddr() + "," + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

		File file = new File(logSavedPath);
		file.mkdirs();

		String logFilePath = logSavedPath + File.separator + logFileName;
		try (BufferedWriter out = new BufferedWriter(new FileWriter(logFilePath, true))) {
			out.write(log);
			out.newLine();
		}

		boolean isAdmin = loginUser.getAuthority().equals("ROLE_ADMIN");

		if (isAdmin) {
		    response.sendRedirect(request.getContextPath() + "/admin/main");
		} else {
		    response.sendRedirect(request.getContextPath() + "/index");
		}
	}
}