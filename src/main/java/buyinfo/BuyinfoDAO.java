package buyinfo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import buy.Buy;
import buyinfo.Buyinfo;

public class BuyinfoDAO {

	private Connection conn;
	private ResultSet rs;
	
	public BuyinfoDAO() {
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

	public int getNext() { 
		   String SQL = "SELECT buyID FROM BUYINFO ORDER BY buyID DESC";
		   try {
			   PreparedStatement pstmt = conn.prepareStatement(SQL);
			   rs = pstmt.executeQuery();
			   if(rs.next()) {
				   return rs.getInt(1)+1; //반환
			   }
			   return 1; //첫 번째 게시물인 경우 
		   } catch(Exception e) {
			   e.printStackTrace();
		   }
		   return -1;
	   }
	
		public int write(int cosmeticID, String cosmeticName, String buyPrice, String cosmeticImage){ //게시글 작성 기능
			   String SQL = "INSERT INTO BUYINFO VALUES(?, ?, ?, ?, ?, ?, ?)";
			   try {
				   PreparedStatement pstmt = conn.prepareStatement(SQL); 
				   pstmt.setInt(1, getNext());
				   pstmt.setInt(2, cosmeticID);
				   pstmt.setString(3, cosmeticName);
				   pstmt.setString(4, buyPrice);
				   pstmt.setInt(5, 1);
				   pstmt.setInt(6, getNext());
				   pstmt.setString(7, cosmeticImage);
				   return pstmt.executeUpdate();
			   } catch(Exception e) {
				   e.printStackTrace();
			   }
			   return -1;
		   }
		
		public ArrayList<Buyinfo> getList(int pageNumber) {
			String SQL = "SELECT * FROM BUYINFO WHERE buyID < ? ORDER BY buyID DESC LIMIT 10";
			ArrayList<Buyinfo> list = new ArrayList<Buyinfo>();  
			try {
				  PreparedStatement pstmt = conn.prepareStatement(SQL); //현재 연결되어있는 conn객체를 이용해서 SQL을 문장을 실행 준비단계로 만들어준다. 
				  pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
				  rs = pstmt.executeQuery();
				  while (rs.next()) {
					  Buyinfo buyinfo = new Buyinfo(); 
					  buyinfo.setBuyID(rs.getInt(1));
					  buyinfo.setCosmeticID(rs.getInt(2));
					  buyinfo.setCosmeticName(rs.getString(3));
					  buyinfo.setBuyPrice(rs.getString(4));
					  buyinfo.setBuyCount(rs.getInt(5));
					  buyinfo.setOrderID(rs.getInt(6));
					  buyinfo.setCosmeticImage(rs.getString(7));
					  list.add(buyinfo);
				  }
			  } catch(Exception e) {
				  e.printStackTrace();
			  }
			   return list;
		}
		
		public boolean nextPage(int pageNumber) {
			String SQL = "SELECT * FROM BUYINFO WHERE buyID < ? AND buyinfoAvailable = 1";
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
		
	public Buyinfo getBuyinfo(int orderID) {
		String SQL = "SELECT * FROM BUYINFO WHERE orderID = ?";
		try {
			  PreparedStatement pstmt = conn.prepareStatement(SQL);
			  pstmt.setInt(1, orderID);
			  rs = pstmt.executeQuery();
			  if (rs.next()) {
				  Buyinfo buyinfo = new Buyinfo(); 
				  buyinfo.setBuyID(rs.getInt(1));
				  buyinfo.setCosmeticID(rs.getInt(2));
				  buyinfo.setCosmeticName(rs.getString(3));
				  buyinfo.setBuyPrice(rs.getString(4));
				  buyinfo.setBuyCount(rs.getInt(5));
				  buyinfo.setOrderID(rs.getInt(6));
				  buyinfo.setCosmeticImage(rs.getString(7));
				  return buyinfo;
			  }
		  } catch(Exception e) {
			  e.printStackTrace();
		  }
		   return null;
	}
	
	public int delete(int orderID) { //장바구니 삭제 기능
		   String SQL = "DELETE FROM BUYINFO WHERE orderID = ?";
		   try {
			   PreparedStatement pstmt = conn.prepareStatement(SQL); 
			   pstmt.setInt(1, orderID);
			   return pstmt.executeUpdate();
		   } catch(Exception e) {
			   e.printStackTrace();
		   }
		   return -1;
	}
	
	
	
	public ArrayList<Buyinfo> orderList(int pageNumber, ArrayList<Buy> orderlist) {
		ArrayList<Buyinfo> list = new ArrayList<Buyinfo>(); 
		for (int i = 0; i < orderlist.size(); i++) {
			String SQL = "select orderID, cosmeticName, buyPrice, buyCount, cosmeticImage from buyinfo where orderID = ?";
			try {
				  PreparedStatement pstmt = conn.prepareStatement(SQL); //현재 연결되어있는 conn객체를 이용해서 SQL을 문장을 실행 준비단계로 만들어준다. 
				  pstmt.setInt(1, orderlist.get(i).getOrderID());
				  rs = pstmt.executeQuery();
				  while (rs.next()) {
					  Buyinfo buyinfo = new Buyinfo(); 
					  buyinfo.setOrderID(rs.getInt(1));
					  buyinfo.setCosmeticName(rs.getString(2));
					  buyinfo.setBuyPrice(rs.getString(3));
					  buyinfo.setBuyCount(rs.getInt(4));
					  buyinfo.setCosmeticImage(rs.getString(5));
					  list.add(buyinfo);
				  }
			  } catch(Exception e) {
				  e.printStackTrace();
			  }
			}
		   return list;
		}
	
	
	
	public int pay(int orderID) { //결제완료
		   String SQL = "UPDATE BUYINFO SET buyinfoAvailable = 0 WHERE orderID = ?";
		   try {
			   PreparedStatement pstmt = conn.prepareStatement(SQL); 
			   pstmt.setInt(1, orderID);
			   return pstmt.executeUpdate();
		   } catch(Exception e) {
			   e.printStackTrace();
		   }
		   return -1;
	}
	
}
