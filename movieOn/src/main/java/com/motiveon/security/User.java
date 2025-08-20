package com.motiveon.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.motiveon.dto.EmployeeVO;

public class User implements UserDetails {

private EmployeeVO employee;
	
	public User(EmployeeVO employee) {
		this.employee = employee;
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
		
		List<String> authorities = new ArrayList<String>();
		authorities.add(employee.getAuthority());
		
		if(authorities!=null) for(String authority : authorities) {
			roles.add(new SimpleGrantedAuthority(authority));
		} 
		
		return roles;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return employee.getPwd();
	}

	@Override
	public String getUsername() {
	    return String.valueOf(employee.getEno());  // int -> String 변환
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return employee.getEnabled()!=4;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return employee.getEnabled()!=3;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return employee.getEnabled()!=2;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return employee.getEnabled()!=0;
	}
	
	public EmployeeVO getEmployeeVO() {
		return this.employee;
	}

}
