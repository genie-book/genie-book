package kr.ac.spring.member.vo;

public class MemberVO {

	private String name;
	private String jumin;
	private String id;
	private String password;
	private String pwHint;
	private String pwHintAns;
	private String email;
	private int receive_email;
	private String authority;
	private String houseNum;
	private String phoneNum;
	private int enabled;
	private int cartId_mem;
	private int point;
	private int acc_Price;
	

	public int getAcc_Price() {
		return acc_Price;
	}
	public void setAcc_Price(int acc_Price) {
		this.acc_Price = acc_Price;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public int getCartId_mem() {
		return cartId_mem;
	}
	public void setCartId_mem(int cartId_mem) {
		this.cartId_mem = cartId_mem;
	}
	public String getPwHint() {
		return pwHint;
	}
	public void setPwHint(String pwHint) {
		this.pwHint = pwHint;
	}
	public String getPwHintAns() {
		return pwHintAns;
	}
	public void setPwHintAns(String pwHintAns) {
		this.pwHintAns = pwHintAns;
	}

	public int getReceive_email() {
		return receive_email;
	}
	public void setReceive_email(int receive_email) {
		this.receive_email = receive_email;
	}
	public String getHouseNum() {
		return houseNum;
	}
	public void setHouseNum(String houseNum) {
		this.houseNum = houseNum;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	public String getJumin() {
		return jumin;
	}
	public void setJumin(String jumin) {
		this.jumin = jumin;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public int getEnabled() {
		return enabled;
	}
	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}
	
	

	
}
