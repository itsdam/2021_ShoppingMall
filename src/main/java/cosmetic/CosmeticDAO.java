package cosmetic;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import cosmetic.Cosmetic;


public class CosmeticDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public CosmeticDAO() {
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
		   String SQL = "SELECT cosmeticID FROM COSMETIC ORDER BY cosmeticID DESC";
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
	
		public int write(String cosmeticKind,String cosmeticName,String cosmeticPrice,String cosmeticCount,
				String cosmeticImage, String cosmeticContent){ //게시글 작성 기능
			   String SQL = "INSERT INTO COSMETIC VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
			   try {
				   PreparedStatement pstmt = conn.prepareStatement(SQL); 
				   pstmt.setInt(1, getNext());
				   pstmt.setString(2, cosmeticKind);
				   pstmt.setString(3, cosmeticName);
				   pstmt.setString(4, cosmeticPrice);
				   pstmt.setString(5, cosmeticCount);
				   pstmt.setString(6, cosmeticImage);
				   pstmt.setString(7, cosmeticContent);
				   pstmt.setInt(8, 1);// rs= pstmt.executeQuery(); insert는 자동으로 해줌 
				   return pstmt.executeUpdate();
			   } catch(Exception e) {
				   e.printStackTrace();
			   }
			   return -1;
		   }
		
		public ArrayList<Cosmetic> getList(int pageNumber) {
			String SQL = "SELECT * FROM COSMETIC WHERE cosmeticID < ? AND cosmeticAvailable = 1 ORDER BY cosmeticID DESC LIMIT 10";
			ArrayList<Cosmetic> list = new ArrayList<Cosmetic>();  
			try {
				  PreparedStatement pstmt = conn.prepareStatement(SQL); //현재 연결되어있는 conn객체를 이용해서 SQL을 문장을 실행 준비단계로 만들어준다. 
				  pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
				  rs = pstmt.executeQuery();
				  while (rs.next()) {
					  Cosmetic cosmetic = new Cosmetic(); 
					  cosmetic.setCosmeticID(rs.getInt(1));
					  cosmetic.setCosmeticKind(rs.getString(2));
					  cosmetic.setCosmeticName(rs.getString(3));
					  cosmetic.setCosmeticPrice(rs.getString(4));
					  cosmetic.setCosmeticCount(rs.getString(5));
					  cosmetic.setCosmeticImage(rs.getString(6));
					  cosmetic.setCosmeticContent(rs.getString(7));
					  cosmetic.setCosmeticAvailable(rs.getInt(8));
					  list.add(cosmetic);
				  }
			  } catch(Exception e) {
				  e.printStackTrace();
			  }
			   return list;
		}
		
		public boolean nextPage(int pageNumber) {
			String SQL = "SELECT * FROM COSMETIC WHERE cosmeticID < ? AND cosmeticAvailable = 1";
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
		
	public Cosmetic getCosmetic(int cosmeticID) {
		String SQL = "SELECT * FROM COSMETIC WHERE cosmeticID = ?";
		try {
			  PreparedStatement pstmt = conn.prepareStatement(SQL);
			  pstmt.setInt(1, cosmeticID);
			  rs = pstmt.executeQuery();
			  if (rs.next()) {
				  Cosmetic cosmetic = new Cosmetic(); 
				  cosmetic.setCosmeticID(rs.getInt(1));
				  cosmetic.setCosmeticKind(rs.getString(2));
				  cosmetic.setCosmeticName(rs.getString(3));
				  cosmetic.setCosmeticPrice(rs.getString(4));
				  cosmetic.setCosmeticCount(rs.getString(5));
				  cosmetic.setCosmeticImage(rs.getString(6));
				  cosmetic.setCosmeticContent(rs.getString(7));
				  cosmetic.setCosmeticAvailable(rs.getInt(8));
				  return cosmetic;
			  }
		  } catch(Exception e) {
			  e.printStackTrace();
		  }
		   return null;
	}
	
	public int update(int cosmeticID, String cosmeticKind,String cosmeticName,String cosmeticPrice,String cosmeticCount,
					String cosmeticImage, String cosmeticContent) { //게시글 수정 기능
		   String SQL = "UPDATE COSMETIC SET cosmeticKind = ?, cosmeticName = ?, cosmeticPrice = ?, cosmeticCount = ?, cosmeticImage = ?, cosmeticContent = ? WHERE cosmeticID = ?";
		   try {
			   PreparedStatement pstmt = conn.prepareStatement(SQL); 
			   pstmt.setString(1, cosmeticKind);
			   pstmt.setString(2, cosmeticName);
			   pstmt.setString(3, cosmeticPrice);
			   pstmt.setString(4, cosmeticCount);
			   pstmt.setString(5, cosmeticImage);
			   pstmt.setString(6, cosmeticContent);
			   pstmt.setInt(7, cosmeticID);
			   return pstmt.executeUpdate();
		   } catch(Exception e) {
			   e.printStackTrace();
		   }
		   return -1;
	} 
	public int delete(int cosmeticID) { //게시글 삭제 기능
		   String SQL = "UPDATE COSMETIC SET cosmeticAvailable = 0 WHERE cosmeticID = ?";
		   try {
			   PreparedStatement pstmt = conn.prepareStatement(SQL); 
			   pstmt.setInt(1, cosmeticID);
			   return pstmt.executeUpdate();
		   } catch(Exception e) {
			   e.printStackTrace();
		   }
		   return -1;
	}
	
	public int getSrchCount (String srchKey, String srchText) { 
		String SQL = "select count(*) from cosmetic where cosmeticAvailable = 1 and " + srchKey + " like ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + srchText + "%");
			rs = pstmt.executeQuery();
			if (rs.next()) return rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 검색 결과 없음
	}
	
	public ArrayList<Cosmetic> getSrchList (String srchKey, String srchText, int pageNumber) {
		ArrayList<Cosmetic> searchList = new ArrayList<Cosmetic>();
		String SQL = "select * from cosmetic where cosmeticAvailable = 1 and " + srchKey + " like ? order by cosmeticID desc limit ?, 10";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + srchText + "%");
			pstmt.setInt(2, (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Cosmetic cosmetic = new Cosmetic();
				  cosmetic.setCosmeticID(rs.getInt(1));
				  cosmetic.setCosmeticKind(rs.getString(2));
				  cosmetic.setCosmeticName(rs.getString(3));
				  cosmetic.setCosmeticPrice(rs.getString(4));
				  cosmetic.setCosmeticCount(rs.getString(5));
				  cosmetic.setCosmeticImage(rs.getString(6));
				  cosmetic.setCosmeticContent(rs.getString(7));
				  cosmetic.setCosmeticAvailable(rs.getInt(8));
				searchList.add(cosmetic);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return searchList;
	}
	
	public boolean srchNextPage(String srchKey, String srchText, int pageNumber) {
		String SQL = "select * from cosmetic where cosmeticAvailable = 1 and " + srchKey + " like ? order by cosmeticID desc limit ?, 10";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + srchText + "%");
			pstmt.setInt(2, (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return false;
	}
	
	public ArrayList<Cosmetic> getCosmeticList(int pageNumber){
		String SQL = "select * from cosmetic where cosmeticAvailable = 1 order by cosmeticID desc limit ?, 10";
		ArrayList<Cosmetic> cosmeticList = new ArrayList<Cosmetic>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Cosmetic cosmetic = new Cosmetic();
				  cosmetic.setCosmeticID(rs.getInt(1));
				  cosmetic.setCosmeticKind(rs.getString(2));
				  cosmetic.setCosmeticName(rs.getString(3));
				  cosmetic.setCosmeticPrice(rs.getString(4));
				  cosmetic.setCosmeticCount(rs.getString(5));
				  cosmetic.setCosmeticImage(rs.getString(6));
				  cosmetic.setCosmeticContent(rs.getString(7));
				  cosmetic.setCosmeticAvailable(rs.getInt(8));
				cosmeticList.add(cosmetic);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}  
		return cosmeticList;
	}
	
	public int getTint (int cosmeticID, String cosmeticKind) { 
	String SQL = "select * from cosmetic where cosmeticKind = 'tint' and cosmeticID = ?";
	try {
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setInt(1, cosmeticID);
		  rs = pstmt.executeQuery();
		  if (rs.next()) {
			  Cosmetic cosmetic = new Cosmetic(); 
			  cosmetic.setCosmeticID(rs.getInt(1));
			  cosmetic.setCosmeticKind(rs.getString(2));
			  cosmetic.setCosmeticName(rs.getString(3));
			  cosmetic.setCosmeticPrice(rs.getString(4));
			  cosmetic.setCosmeticCount(rs.getString(5));
			  cosmetic.setCosmeticImage(rs.getString(6));
			  cosmetic.setCosmeticContent(rs.getString(7));
			  cosmetic.setCosmeticAvailable(rs.getInt(8));
			  return cosmeticID;
		  }
	} catch (Exception e) {
		e.printStackTrace();
	}
	return -1; // 검색 결과 없음
	}
	
	
	public ArrayList<Cosmetic> getKindList(int pageNumber, String cosmeticKind) {
		ArrayList<Cosmetic> list = new ArrayList<Cosmetic>();  
			String SQL = "SELECT * FROM COSMETIC WHERE cosmeticKind = ? ORDER BY cosmeticID DESC LIMIT 10";
			try {
				  PreparedStatement pstmt = conn.prepareStatement(SQL); //현재 연결되어있는 conn객체를 이용해서 SQL을 문장을 실행 준비단계로 만들어준다. 
				  pstmt.setString(1, cosmeticKind);
				  rs = pstmt.executeQuery();
				  while (rs.next()) {
					  Cosmetic cosmetic = new Cosmetic(); 
					  cosmetic.setCosmeticID(rs.getInt(1));
					  cosmetic.setCosmeticKind(rs.getString(2));
					  cosmetic.setCosmeticName(rs.getString(3));
					  cosmetic.setCosmeticPrice(rs.getString(4));
					  cosmetic.setCosmeticCount(rs.getString(5));
					  cosmetic.setCosmeticImage(rs.getString(6));
					  cosmetic.setCosmeticContent(rs.getString(7));
					  cosmetic.setCosmeticAvailable(rs.getInt(8));
					  list.add(cosmetic);
				  }
			  } catch(Exception e) {
				  e.printStackTrace();
			  }
			  return list;
}
}

//	public ArrayList<Cosmetic> getMyCosmeticList(String userID, int pageNumber){
//		String SQL = "select * from bbs where userID =? and bbsAvailable = 1 order by bbsID desc limit ?, 10";
//		ArrayList<Cosmetic> myCosmeticList = new ArrayList<Cosmetic>();
//		try {
//			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			pstmt.setString(1, userID);
//			pstmt.setInt(2, (pageNumber - 1) * 10);
//			rs = pstmt.executeQuery();
//			while (rs.next()) {
//				Bbs bbs = new Bbs();
//				bbs.setBbsID(rs.getInt(1));
//				bbs.setBbsTitle(rs.getString(2));
//				bbs.setUserID(rs.getString(3));
//				bbs.setBbsDate(rs.getString(4));
//				bbs.setBbsContent(rs.getString(5));
//				bbs.setBbsAvailable(rs.getInt(6));
//				myCosmeticList.add(bbs);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}  
//		return myBbsList;
//	}

//	public int getMyCount (String userID) { 
//		String SQL = "select count(*) from bbs where userID = ? and bbsAvailable = 1";
//		try {
//			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			pstmt.setString(1, userID);
//			rs = pstmt.executeQuery();
//			if (rs.next()) return rs.getInt(1);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return -1; // 검색 결과 없음
//	}

//	public boolean myNextPage(String userID, int pageNumber) {
//		String SQL = "select * from bbs where userID = ? and bbsAvailable = 1 order by bbsID desc limit ?, 10";
//		try {
//			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			pstmt.setString(1, userID );
//			pstmt.setInt(2, (pageNumber - 1) * 10);
//			rs = pstmt.executeQuery();
//			if (rs.next()) {
//				return true;
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		} 
//		return false;
//	}
//

