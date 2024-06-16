package com.tboard.vo;

import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;



@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Member implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String memberId;
	private String name;
	private String password;
	private String email;
	
	//로그인할때 사용할 생성자
	public Member(String memberId, String password) {
		this.memberId = memberId;
		this.password = password;
	}
}
