package cart;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import cart.Cart;
import cosmetic.Cosmetic;

public class CartDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public CartDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=Asia/Seoul";
			String dbID = "root";
			String dbPassword = "tooj0521^^";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	 public String getDate() {//�Խ����� �ۼ��� �� ���� �ð�
		   String SQL = "SELECT NOW()";
		   try {
			   PreparedStatement pstmt = conn.prepareStatement(SQL);
			   rs = pstmt.executeQuery();
			   if(rs.next()) {
				   return rs.getString(1); //��ȯ
			   }
		   } catch(Exception e) {
			   e.printStackTrace();
		   }
		   return "";
	   }

	
	public int getNext() { 
		   String SQL = "SELECT cartID FROM CART ORDER BY cartID DESC";
		   try {
			   PreparedStatement pstmt = conn.prepareStatement(SQL);
			   rs = pstmt.executeQuery();
			   if(rs.next()) {
				   return rs.getInt(1)+1; //��ȯ
			   }
			   return 1; //ù ��° �Խù��� ��� 
		   } catch(Exception e) {
			   e.printStackTrace();
		   }
		   return -1;
	   }
	
		public int write(int cartID, String memberID, int cosmeticID, String cosmeticName, String buyPrice, int buyCount, String cosmeticImage){ //�Խñ� �ۼ� ���
			   String SQL = "INSERT INTO CART VALUES(?, ?, ?, ?, ?, ?, ?)";
			   try {
				   PreparedStatement pstmt = conn.prepareStatement(SQL); 
				   pstmt.setInt(1, getNext());
				   pstmt.setString(2, memberID);
				   pstmt.setInt(3, cosmeticID);
				   pstmt.setString(4, cosmeticName);
				   pstmt.setString(5, buyPrice);
				   pstmt.setInt(6, 1);
				   pstmt.setString(7, cosmeticImage);
				   return pstmt.executeUpdate();
			   } catch(Exception e) {
				   e.printStackTrace();
			   }
			   return -1;
		   }
		
		public ArrayList<Cart> getList(int pageNumber) {
			String SQL = "SELECT * FROM CART WHERE cartID < ? ORDER BY cartID DESC LIMIT 10";
			ArrayList<Cart> list = new ArrayList<Cart>();  
			try {
				  PreparedStatement pstmt = conn.prepareStatement(SQL); //���� ����Ǿ��ִ� conn��ü�� �̿��ؼ� SQL�� ������ ���� �غ�ܰ�� ������ش�. 
				  pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
				  rs = pstmt.executeQuery();
				  while (rs.next()) {
					  Cart cart = new Cart(); 
					  cart.setCartID(rs.getInt(1));
					  cart.setMemberID(rs.getString(2));
					  cart.setCosmeticID(rs.getInt(3));
					  cart.setCosmeticName(rs.getString(4));
					  cart.setBuyPrice(rs.getString(5));
					  cart.setBuyCount(rs.getInt(6));
					  cart.setCosmeticImage(rs.getString(7));
					  list.add(cart);
				  }
			  } catch(Exception e) {
				  e.printStackTrace();
			  }
			   return list;
		}
		
		public boolean nextPage(int pageNumber) {
			String SQL = "SELECT * FROM CART WHERE cartID < ?";
			try {
				  PreparedStatement pstmt = conn.prepareStatement(SQL);
				  pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
				  rs = pstmt.executeQuery();
				  if (rs.next()) {
					  return true;
				  }
			  } catch(Exception e) {
				  e.printStackTrace();
			  }
			   return false;
	}
		
	public Cart getCart(int cartID) {
		String SQL = "SELECT * FROM CART WHERE cartID = ?";
		try {
			  PreparedStatement pstmt = conn.prepareStatement(SQL);
			  pstmt.setInt(1, cartID);
			  rs = pstmt.executeQuery();
			  if (rs.next()) {
				  Cart cart = new Cart(); 
				  cart.setCartID(rs.getInt(1));
				  cart.setMemberID(rs.getString(2));
				  cart.setCosmeticID(rs.getInt(3));
				  cart.setCosmeticName(rs.getString(4));
				  cart.setBuyPrice(rs.getString(5));
				  cart.setBuyCount(rs.getInt(6));
				  cart.setCosmeticImage(rs.getString(7));
				  return cart;
			  }
		  } catch(Exception e) {
			  e.printStackTrace();
		  }
		   return null;
	}
	
	public int delete(int cartID) { //��ٱ��� ���� ���
		   String SQL = "DELETE FROM CART WHERE cartID = ?";
		   try {
			   PreparedStatement pstmt = conn.prepareStatement(SQL); 
			   pstmt.setInt(1, cartID);
			   return pstmt.executeUpdate();
		   } catch(Exception e) {
			   e.printStackTrace();
		   }
		   return -1;
	}
	
	public ArrayList<Cart> getCartList(int pageNumber){
		String SQL = "select * from cart order by cartID desc limit ?, 10";
		ArrayList<Cart> cartList = new ArrayList<Cart>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				  Cart cart = new Cart(); 
				  cart.setCartID(rs.getInt(1));
				  cart.setMemberID(rs.getString(2));
				  cart.setCosmeticID(rs.getInt(3));
				  cart.setCosmeticName(rs.getString(4));
				  cart.setBuyPrice(rs.getString(5));
				  cart.setBuyCount(rs.getInt(6));
				  cart.setCosmeticImage(rs.getString(7));
				  cartList.add(cart);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}  
		return cartList;
	}
}
