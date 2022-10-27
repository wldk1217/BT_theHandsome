package com.theHandsome.persistence;

import static org.junit.Assert.fail;
import java.sql.Connection;
import java.sql.SQLException;
import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

/*****************************************************
 * @function : DataSourceTests
 * @author : 구영모, 김민선, 심지연
 * @Date : 2022.10.17
 *****************************************************/

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class DataSourceTests2 {
	
	@Setter( onMethod_ = { @Autowired} )
	private DataSource dataSource;
	
	@Setter( onMethod_ = { @Autowired} )
	private SqlSessionFactory sqlSessionFactory;
	
	@Test
	public void testConnection() {	
		
		try {
			SqlSession session = sqlSessionFactory.openSession();
			Connection con = dataSource.getConnection();
			log.info(session);
			log.info(con);
		} catch (SQLException e) {
			fail(e.getMessage());
		}//end try			
		
	}//end test
}//end class
