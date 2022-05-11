package buy;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import buy.Buy;
import buyinfo.Buyinfo;

public class BuyDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public BuyDAO() {
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
	
	 public String getDate() {//게시판을 작성할 때 현재 시간
		   String SQL = "SELECT NOW()";
		   try {
			   PreparedStatement pstmt = conn.prepareStatement(SQL);
			   rs = pstmt.executeQuery();
			   if(rs.next()) {
				   return rs.getString(1); //반환
			   }
		   } catch(Exception e) {
			   e.printStackTrace();
		   }
		   return "";
	   }

	
	public int getNext() { 
		   String SQL = "SELECT orderID FROM BUY ORDER BY orderID DESC";
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
	
		public int write(String memberID){ //게시글 작성 기능
			   String SQL = "INSERT INTO BUY VALUES(?, ?, ?)";
			   try {
				   PreparedStatement pstmt = conn.prepareStatement(SQL); 
				   pstmt.setInt(1, getNext());
				   pstmt.setString(2, memberID);
				   pstmt.setString(3, getDate());
				   return pstmt.executeUpdate();
			   } catch(Exception e) {
				   e.printStackTrace();
			   }
			   return -1;
		   }
		
		public ArrayList<Buy> getList(int pageNumber) {
			String SQL = "SELECT * FROM BUY WHERE orderID < ? ORDER BY orderID DESC LIMIT 10";
			ArrayList<Buy> list = new ArrayList<Buy>();  
			try {
				  PreparedStatement pstmt = conn.prepareStatement(SQL); //현재 연결되어있는 conn객체를 이용해서 SQL을 문장을 실행 준비단계로 만들어준다. 
				  pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
				  rs = pstmt.executeQuery();
				  while (rs.next()) {
					  Buy buy = new Buy(); 
					  buy.setOrderID(rs.getInt(1));
					  buy.setMemberID(rs.getString(2));
					  buy.setBuyDate(rs.getString(3));
					  list.add(buy);
				  }
			  } catch(Exception e) {
				  e.printStackTrace();
			  }
			   return list;
		}
		
		public boolean nextPage(int pageNumber) {
			String SQL = "SELECT * FROM BUY WHERE orderID < ? AND buyAvailable = 1";
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
		
	public Buy getBuy(int orderID) {
		String SQL = "SELECT * FROM BUY WHERE orderID = ?";
		try {
			  PreparedStatement pstmt = conn.prepareStatement(SQL);
			  pstmt.setInt(1, orderID);
			  rs = pstmt.executeQuery();
			  if (rs.next()) {
				  Buy buy = new Buy(); 
				  buy.setOrderID(rs.getInt(1));
				  buy.setMemberID(rs.getString(2));
				  buy.setBuyDate(rs.getString(3));
				  return buy;
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
	
	public ArrayList<Buy> getBuyList(int pageNumber){
		String SQL = "select * from cart order by orderID desc limit ?, 10";
		ArrayList<Buy> cartList = new ArrayList<Buy>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				  Buy buy = new Buy(); 
				  buy.setOrderID(rs.getInt(1));
				  buy.setMemberID(rs.getString(2));
				  buy.setBuyDate(rs.getString(3));
				  cartList.add(buy);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}  
		return cartList;
	}
	
	
	public int pay(int orderID) { //결제완료
		   String SQL = "UPDATE BUY SET buyAvailable = 0 WHERE orderID = ?";
		   try {
			   PreparedStatement pstmt = conn.prepareStatement(SQL); 
			   pstmt.setInt(1, orderID);
			   return pstmt.executeUpdate();
		   } catch(Exception e) {
			   e.printStackTrace();
		   }
		   return -1;
	}
	
	public ArrayList<Buy> orderList(int pageNumber) {
		String SQL = "select * from buy where orderID < ?";
		ArrayList<Buy> list = new ArrayList<Buy>(); 
		try {
			  PreparedStatement pstmt = conn.prepareStatement(SQL); //현재 연결되어있는 conn객체를 이용해서 SQL을 문장을 실행 준비단계로 만들어준다. 
			  pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			  rs = pstmt.executeQuery();
			  while (rs.next()) {	  
				  Buy buy = new Buy(); 
				  buy.setOrderID(rs.getInt(1));
				  buy.setMemberID(rs.getString(2));
				  buy.setBuyDate(rs.getString(3));
				  list.add(buy);
			  }
		  } catch(Exception e) {
			  e.printStackTrace();
		  }
		   return list;
	}
	
	public ArrayList<Buy> orderViewList(int pageNumber, String memberID) {
		String SQL = "select orderID, buyDate from buy where memberID = ?";
		ArrayList<Buy> list = new ArrayList<Buy>(); 
		try {
			  PreparedStatement pstmt = conn.prepareStatement(SQL); //현재 연결되어있는 conn객체를 이용해서 SQL을 문장을 실행 준비단계로 만들어준다. 
			  pstmt.setString(1, memberID);
			  rs = pstmt.executeQuery();
			  while (rs.next()) {	  
				  Buy buy = new Buy(); 
				  buy.setOrderID(rs.getInt(1));
				  buy.setBuyDate(rs.getString(2));
				  buy.setMemberID(memberID);
				  list.add(buy);
			  }
		  } catch(Exception e) {
			  e.printStackTrace();
		  }
		   return list;
	}
	

}
