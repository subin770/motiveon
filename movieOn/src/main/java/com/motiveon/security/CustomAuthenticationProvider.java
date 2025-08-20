package com.motiveon.security;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.motiveon.dto.EmployeeVO;
import com.motiveon.service.EmployeeService;

public class CustomAuthenticationProvider implements AuthenticationProvider {

	private EmployeeService employeeService;

	public CustomAuthenticationProvider(EmployeeService employeeService) {
		this.employeeService = employeeService;
	}

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		// principal은 eno를 문자열로 받음
		String enoStr = (String) authentication.getPrincipal();
		String login_pwd = (String) authentication.getCredentials();

		int eno;
		try {
			eno = Integer.parseInt(enoStr); // 문자열 eno -> int eno 변환
		} catch (NumberFormatException e) {
			throw new BadCredentialsException("유효하지 않은 사원번호입니다.");
		}

		try {
			EmployeeVO employee = employeeService.getEmployee(eno); // int eno로 DB 조회

			if (employee == null)
				throw new UsernameNotFoundException("존재하지 않는 사원번호입니다.");
			if (!employee.getPwd().equals(login_pwd))
				throw new BadCredentialsException("패스워드가 일치하지 않습니다.");

			List<String> roles = new ArrayList<String>();

			if (employee.getAuthority() == null) {
				roles.add("ROLE_USER"); // 기본 권한
			}else {
				roles.add(employee.getAuthority());
				
			}

			UserDetails authUser = new User(employee); // UserDetails 구현체

			boolean invalidCheck = authUser.isAccountNonExpired() && authUser.isAccountNonLocked()
					&& authUser.isCredentialsNonExpired() && authUser.isEnabled();

			if (!invalidCheck)
				throw new InsufficientAuthenticationException("유효하지 않는 계정입니다.");

			UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(authUser.getUsername(),
					authUser.getPassword(), authUser.getAuthorities());
			result.setDetails(authUser);

			return result;

		} catch (SQLException e) {
			e.printStackTrace();
			throw new AuthenticationServiceException("서버 장애로 서비스가 불가합니다.");
		}
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}

}