package member;

import java.sql.Timestamp;

public class MemberBean {
	private String id;
	private String pass;
	private String name;
	private String email;
	private String address;
	private String address2;
	private String post;
	private String phone;
	private String mobile;
	private Timestamp reg_date;
	
	public String getId() {
		return id;
	}
	public String getPass() {
		return pass;
	}
	public String getName() {
		return name;
	}
	public String getEmail() {
		return email;
	}
	public String getAddress() {
		return address;
	}
	
	public String getAddress2() {
		return address2;
	}
	public String getPost() {
		return post;
	}
	public String getPhone() {
		return phone;
	}
	public String getMobile() {
		return mobile;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public void setPost(String post) {
		this.post = post;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	
	
	

}
