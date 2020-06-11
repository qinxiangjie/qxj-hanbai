package com.itjob.demo.bean;

import org.springframework.stereotype.Component;

@Component
public class Shouhin {
	private String shouhinCode;
	private String shouhinmei;
	private int uriageTanka;
	private String tani;
	private String shiireTanka;
	private String shiiresakiCode;
	private int zaikosuu;
	private int anzenZaikosuu;
	private String hacchuuTani;
	private String hacchuuHuragu;
	private String kingaku;
	private String uriageSuuryou;
	private int updateZaikosuu;
	private Shiiresaki shiiresaki;

	public int getUpdateZaikosuu() {
		return updateZaikosuu;
	}

	public void setUpdateZaikosuu(int updateZaikosuu) {
		this.updateZaikosuu = updateZaikosuu;
	}

	public String getShouhinCode() {
		return shouhinCode;
	}

	public void setShouhinCode(String shouhinCode) {
		this.shouhinCode = shouhinCode;
	}

	public String getShouhinmei() {
		return shouhinmei;
	}

	public void setShouhinmei(String shouhinmei) {
		this.shouhinmei = shouhinmei;
	}

	public int getUriageTanka() {
		return uriageTanka;
	}

	public void setUriageTanka(int uriageTanka) {
		this.uriageTanka = uriageTanka;
	}

	public String getTani() {
		return tani;
	}

	public void setTani(String tani) {
		this.tani = tani;
	}

	public String getShiireTanka() {
		return shiireTanka;
	}

	public void setShiireTanka(String shiireTanka) {
		this.shiireTanka = shiireTanka;
	}

	public String getShiiresakiCode() {
		return shiiresakiCode;
	}

	public void setShiiresakiCode(String shiiresakiCode) {
		this.shiiresakiCode = shiiresakiCode;
	}

	public int getZaikosuu() {
		return zaikosuu;
	}

	public void setZaikosuu(int zaikosuu) {
		this.zaikosuu = zaikosuu;
	}

	public int getAnzenZaikosuu() {
		return anzenZaikosuu;
	}

	public void setAnzenZaikosuu(int anzenZaikosuu) {
		this.anzenZaikosuu = anzenZaikosuu;
	}

	public String getHacchuuTani() {
		return hacchuuTani;
	}

	public void setHacchuuTani(String hacchuuTani) {
		this.hacchuuTani = hacchuuTani;
	}

	public String getHacchuuHuragu() {
		return hacchuuHuragu;
	}

	public void setHacchuuHuragu(String hacchuuHuragu) {
		this.hacchuuHuragu = hacchuuHuragu;
	}

	public String getKingaku() {
		return kingaku;
	}

	public void setKingaku(String kingaku) {
		this.kingaku = kingaku;
	}

	public String getUriageSuuryou() {
		return uriageSuuryou;
	}

	public void setUriageSuuryou(String uriageSuuryou) {
		this.uriageSuuryou = uriageSuuryou;
	}

	public Shiiresaki getShiiresaki() {
		return shiiresaki;
	}

	public void setShiiresaki(Shiiresaki shiiresaki) {
		this.shiiresaki = shiiresaki;
	}
}