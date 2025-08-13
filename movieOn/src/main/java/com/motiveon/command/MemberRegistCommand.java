	package com.motiveon.command;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.motiveon.dto.EmployeeVO;

public class MemberRegistCommand {

	private int eno; // 사번
	private int dno; // 부서번호
	private int birth; // 생년월일 (예: 19901225)
	private String email;  // 이메일
	private String name;   // 이름
	private MultipartFile photoFile; // 사진 파일
	private String ppscode; // 주민번호 or 내부코드
	private String job;     // 직급
	private String[] phone; // 전화번호 (3조각)
	private String pwd;     // 비밀번호
	private int signtype;   // 서명 방식
	private MultipartFile signFile; // 서명 이미지
	private String condition; // 조건 또는 상태
	private List<String> authorities; // 권한

	// Getter & Setter 생략 없이 모두 작성
	public int getEno() {
		return eno;
	}
	public void setEno(int eno) {
		this.eno = eno;
	}
	public int getDno() {
		return dno;
	}
	public void setDno(int dno) {
		this.dno = dno;
	}
	public int getBirth() {
		return birth;
	}
	public void setBirth(int birth) {
		this.birth = birth;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public MultipartFile getPhotoFile() {
		return photoFile;
	}
	public void setPhotoFile(MultipartFile photoFile) {
		this.photoFile = photoFile;
	}
	public String getPpscode() {
		return ppscode;
	}
	public void setPpscode(String ppscode) {
		this.ppscode = ppscode;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public String[] getPhone() {
		return phone;
	}
	public void setPhone(String[] phone) {
		this.phone = phone;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public int getSigntype() {
		return signtype;
	}
	public void setSigntype(int signtype) {
		this.signtype = signtype;
	}
	public MultipartFile getSignFile() {
		return signFile;
	}
	public void setSignFile(MultipartFile signFile) {
		this.signFile = signFile;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public List<String> getAuthorities() {
		return authorities;
	}
	public void setAuthorities(List<String> authorities) {
		this.authorities = authorities;
	}

	// VO로 변환
	public EmployeeVO toEmployeeVO() {
		EmployeeVO employee = new EmployeeVO();
		employee.setEno(eno);
		employee.setDno(dno);
		employee.setBirth(birth);
		employee.setEmail(email);
		employee.setName(name);
		employee.setPpscode(ppscode);
		employee.setJob(job);
		employee.setPwd(pwd);
		employee.setSigntype(signtype);
		employee.setCondition(condition);
		employee.setEnabled(1);
		employee.setAuthorities(authorities);

		// 전화번호 조합
		if (phone != null) {
			StringBuilder phoneTemp = new StringBuilder();
			for (String p : phone) {
				phoneTemp.append(p);
			}
			employee.setPhone(phoneTemp.toString());
		}

		// 사진 경로 및 서명 경로는 Controller에서 업로드 처리 후 set 필요
		// 예:
		// member.setPhoto("/images/uploaded/xxx.jpg");
		// member.setSignpath("/signs/uploaded/yyy.png");

		return employee;
	}
}