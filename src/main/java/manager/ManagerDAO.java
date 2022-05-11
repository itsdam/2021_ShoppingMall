package manager;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ManagerDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public ManagerDAO() {
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
	
	public int login(String managerID, String managerPassword) {
		String SQL = "SELECT managerPassword FROM MANAGER WHERE managerID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, managerID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getString(1).equals(managerPassword)) {
					return 1; //로그인 성공
				} else
					return 0; //비밀번호 불일치
			}
			return -1; //아이디가 없음
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return -2; //데이터베이스 오류
	}
}
