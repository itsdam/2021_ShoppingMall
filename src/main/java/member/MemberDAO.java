package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import cosmetic.Cosmetic;


public class MemberDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public MemberDAO() {
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
	
	public int login(String memberID, String memberPassword) {
		String SQL = "SELECT memberPassword FROM MEMBER WHERE memberID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, memberID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getString(1).equals(memberPassword)) {
					return 1; //�α��� ����
				} else
					return 0; //��й�ȣ ����ġ
			}
			return -1; //���̵� ����
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return -2; //�����ͺ��̽� ����
	}
	
	public int join(Member member) {
		String SQL = "INSERT INTO MEMBER VALUES (?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, member.getMemberID());
			pstmt.setString(2, member.getMemberNumber());
			pstmt.setString(3, member.getMemberPassword());
			pstmt.setString(4, member.getMemberName());
			pstmt.setString(5, member.getMemberEmail());
			pstmt.setInt(6, getNext());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public String getName(String memberID) {
		String SQL = "select name from member where memberID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, memberID);
			rs = pstmt.executeQuery();
			if (rs.next()) return rs.getString(1);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return "";
	}
	
	public ArrayList<Member> getList(int pageNumber) {
		String SQL = "SELECT * FROM MEMBER WHERE memberNum < ? ORDER BY memberNum DESC LIMIT 10";
		ArrayList<Member> list = new ArrayList<Member>();  
		try {
			  PreparedStatement pstmt = conn.prepareStatement(SQL); //���� ����Ǿ��ִ� conn��ü�� �̿��ؼ� SQL�� ������ ���� �غ�ܰ�� ������ش�. 
			  pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			  rs = pstmt.executeQuery();
			  while (rs.next()) {
				  Member member = new Member(); 
				  member.setMemberID(rs.getString(1));
				  member.setMemberNumber(rs.getString(2));
				  member.setMemberPassword(rs.getString(3));
				  member.setMemberName(rs.getString(4));
				  member.setMemberEmail(rs.getString(5));
				  member.setMemberNum(rs.getInt(6));
				  list.add(member);
			  }
		  } catch(Exception e) {
			  e.printStackTrace();
		  }
		   return list;
		}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM MEMBER WHERE memberNum < ?";
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
	
	public int getNext() { 
		   String SQL = "SELECT memberNum FROM MEMBER ORDER BY memberNum DESC";
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

}
