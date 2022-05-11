package cart;

public class Cart {
	private int cartID;
	private String memberID;
	private int cosmeticID;
	private String cosmeticName;
	private String buyPrice;
	private int buyCount;
	private String cosmeticImage;
	
	public String getCosmeticImage() {
		return cosmeticImage;
	}
	public void setCosmeticImage(String cosmeticImage) {
		this.cosmeticImage = cosmeticImage;
	}
	public int getCartID() {
		return cartID;
	}
	public void setCartID(int cartID) {
		this.cartID = cartID;
	}
	public String getMemberID() {
		return memberID;
	}
	public void setMemberID(String memberID) {
		this.memberID = memberID;
	}
	public int getCosmeticID() {
		return cosmeticID;
	}
	public void setCosmeticID(int cosmeticID) {
		this.cosmeticID = cosmeticID;
	}
	public String getCosmeticName() {
		return cosmeticName;
	}
	public void setCosmeticName(String cosmeticName) {
		this.cosmeticName = cosmeticName;
	}
	public String getBuyPrice() {
		return buyPrice;
	}
	public void setBuyPrice(String buyPrice) {
		this.buyPrice = buyPrice;
	}
	public int getBuyCount() {
		return buyCount;
	}
	public void setBuyCount(int buyCount) {
		this.buyCount = buyCount;
	}

	
}
