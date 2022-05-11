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
}
