package com.itjob.demo.form;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class TantousyaForm {

	@NotEmpty(message = "担当者コードを入力してください!")
	@Size(min = 3, max = 3, message = "3桁半角英数字を入力してください!")
	@Pattern(regexp = "^[0-9]*$", message = "3桁半角英数字を入力してください!")
	private String tantousyaCode;

	@NotEmpty(message = "パスワードを入力してください!")
	@Size(min = 6, max = 6, message = "6桁半角英数字を入力してください!")
	@Pattern(regexp = "^[0-9]*$", message = "6桁半角英数字を入力してください!")
	private String password;
	private String tantousyaName;
	private String bumonCode;

	public String getTantousyaCode() {
		return tantousyaCode;
	}

	public void setTantousyaCode(String tantousyaCode) {
		this.tantousyaCode = tantousyaCode;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getTantousyaName() {
		return tantousyaName;
	}

	public void setTantousyaName(String tantousyaName) {
		this.tantousyaName = tantousyaName;
	}

	public String getBumonCode() {
		return bumonCode;
	}

	public void setBumonCode(String bumonCode) {
		this.bumonCode = bumonCode;
	}
}
