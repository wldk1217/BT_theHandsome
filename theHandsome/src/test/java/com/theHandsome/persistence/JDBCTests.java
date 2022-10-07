package com.theHandsome.persistence;

import static org.junit.Assert.fail;
import org.junit.Test;
import lombok.extern.log4j.Log4j;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@Log4j
public class JDBCTests {
	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}// end static

	@Test
	public void TestConnection() {
	
		Connection con = null;
		try {
			String url = 
			"jdbc:log4jdbc:oracle:thin:@hd_high?TNS_ADMIN=C:\\dev\\OracleWallet\\Wallet_hd";
			String uid = "handsome";
			String pwd = "xxxxxxAt21cc";
			String driver = "oracle.jdbc.driver.OracleDriver";
			Class.forName(driver);
			con = DriverManager.getConnection(url, uid, pwd);
			System.out.println(con);
		
		} catch (Exception e) {
			e.printStackTrace();
			
		} // end try	
			
	}//end test
}// end class
