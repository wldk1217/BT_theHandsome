package com.thehandsome.domain;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class test {

	// �γ��� 30�� �̻� �ҿ�˴ϴ�..........
	public static void main(String[] args) {
		Connection con = null;
		Statement stmt = null;
		ResultSet rset = null;
		try {
			String url = 
			"jdbc:oracle:thin:@hd_high?TNS_ADMIN=C:\\\\Dev\\\\OracleWallet\\\\Wallet_hd";
			String uid = "handsome";
			String pwd = "xxxxxxAt21cc";
			String driver = "oracle.jdbc.driver.OracleDriver";
			Class.forName(driver);
			con = DriverManager.getConnection(url, uid, pwd);
			System.out.println(con);
			System.out.println("ATP ����� ����Ǿ����ϴ�.");
			stmt = con.createStatement();
			String sql ="SELECT * FROM test";
			rset = stmt.executeQuery(sql);
			while (rset.next()) {
				System.out.print(rset.getInt(1) + " ");
			}//end while
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("���ῡ �����Ͽ����ϴ�.");
		} // end try

	}// end main

}// end class

