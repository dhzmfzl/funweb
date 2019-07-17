package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	//디비연결 메서드 
	public Connection getConnection() throws Exception{
		//1단계 드라이버 로더
		Class.forName("com.mysql.jdbc.Driver");
		//2단계 디비연결
		String dbUrl="jdbc:mysql://localhost:3306/jspdb5";
		String dbUser="root";
		String dbPass="1234";
		Connection con=DriverManager.getConnection(dbUrl,dbUser,dbPass);
		return con;
		
//		Context init=new InitialContext();
//		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/mysqlDB"); //위치/이름
//		Connection con=ds.getConnection();
//		return con;
//		
	}
	
	// 회원가입(insert)하는 메서드
	public void insertMember(MemberBean mb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			// 디비연결, 외부파일, 예기치 못한 에러 발생 명령
			//1단계 드라이버 로더			//2단계 디비연결
			con=getConnection();
			 // 3단계 sql(insert) 만들고 실행할 객체 생성 
			 String sql="insert into member(id,pass,name,email,phone,mobile,post,address,address2,reg_date) values(?,?,?,?,?,?,?,?,?,?)";
			 pstmt=con.prepareStatement(sql);
			 pstmt.setString(1, mb.getId());
			 pstmt.setString(2, mb.getPass());
			 pstmt.setString(3, mb.getName());
			 pstmt.setString(4, mb.getEmail());
			 pstmt.setString(5, mb.getPhone());
			 pstmt.setString(6, mb.getMobile());
			 pstmt.setString(7, mb.getPost());
			 pstmt.setString(8, mb.getAddress());
			 pstmt.setString(9, mb.getAddress2());
			 pstmt.setTimestamp(10,mb.getReg_date());
			 // 4단계 sql 실행
			 pstmt.executeUpdate();
		} catch (Exception e) {
			// 예외(에러)가 발생하면 처리하는 곳 
			e.printStackTrace();
		}finally {
			// 예외발생 상관없이 처리되는 문장
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try{pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try{con.close();} catch(SQLException ex) {}
		}
	} // insertMember메서드
	
	// userCheck(함수처리할때 필요한 id,pass 가져가기)메서드
	public int userCheck(String id,String pass) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		// 아이디비밀번호 일치 1,비밀번호틀림 0, 아이디없음 -1
		int check=-1;
		try {
			//1단계 드라이버 로더			//2단계 디비연결
			con=getConnection();
			// 3단계 sql(select 조건 id=?) 만들고 실행할 객체 생성
			String sql="select * from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 4단계 : 결과저장 <= sql  구문 실행 select
			rs=pstmt.executeQuery();
			// 5단계 : select 결과를 비교 해서 일치여부 확인
			if(rs.next()){ //true이면 id.equals(rs.getString("id"))
				//다음행 이동시 데이터가 있으면, id가 있으면
				if(pass.equals(rs.getString("pass"))){
					// 비밀번호 일치하면  세션값 생성  main.jsp 이동
					check=1;
				}else{
					// "비밀번호 틀림" 뒤로이동
					check=0;
				}
			}else{
				// "아이디없음"  뒤로이동
				check=-1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			// 예외발생 상관없이 처리되는 문장
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try{pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try{con.close();} catch(SQLException ex) {}
		}
		return check;
	}
	
	//idcheck(id)
	public int idcheck(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		// 아이디 일치(아이디중복) 1 , 아이디없음 (아이디사용가능) 0
		int check=0;
		try {
			//1단계 드라이버 로더			//2단계 디비연결
			con=getConnection();
			// 3단계 sql(select 조건 id=?) 만들고 실행할 객체 생성
			String sql="select * from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 4단계 : 결과저장 <= sql  구문 실행 select
			rs=pstmt.executeQuery();
			// 5단계 : select 결과를 비교 해서 일치여부 확인
			if(rs.next()){ //true이면 id.equals(rs.getString("id"))
				//다음행 이동시 데이터가 있으면, id가 있으면, id중복이면
				check=1;
			}else{
				// "아이디없음, 아이디 사용가능"  
				check=0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			// 예외발생 상관없이 처리되는 문장
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try{pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try{con.close();} catch(SQLException ex) {}
		}
		return check;
	}
	
	public MemberBean getMember(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		MemberBean mb=new MemberBean();
		try {
			//1단계 드라이버 로더			//2단계 디비연결
			con=getConnection();
			// 3단계 sql(select) 만들고 실행할 객체 생성
			String sql="select * from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 4단계 : 결과저장 <= sql  구문 실행 select
			rs=pstmt.executeQuery();
			//5단계 : select 결과를 화면출력
			 // rs위치 다음행 이동
			if(rs.next()) {
				mb.setId(rs.getString("id"));
				mb.setName(rs.getString("name"));  
				mb.setEmail(rs.getString("email")); 
				mb.setPhone(rs.getString("phone")); 
				mb.setMobile(rs.getString("mobile"));
				mb.setAddress(rs.getString("address")); 
				mb.setAddress2(rs.getString("address2")); 
				mb.setPost(rs.getString("post"));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			// 예외발생 상관없이 처리되는 문장
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try{pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try{con.close();} catch(SQLException ex) {}
		}
		return mb;
	}
	
	// updateMember(mb)
	public void updateMember(MemberBean mb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1단계 드라이버 로더			//2단계 디비연결
			con=getConnection();
			//3단계 sql update
			String sql="update member set name=?, email=?, phone=?, mobile=?, post=?, address=?, address2=? where id=?";
//			String sql="update m_member set name=? where id=?";
	 		pstmt=con.prepareStatement(sql);
	 		pstmt.setString(1, mb.getName());
	 		pstmt.setString(2, mb.getEmail());
	 		pstmt.setString(3, mb.getPhone());
	 		pstmt.setString(4, mb.getMobile());
	 		pstmt.setString(5, mb.getPost());
	 		pstmt.setString(6, mb.getAddress());
	 		pstmt.setString(7, mb.getAddress2());
	 		pstmt.setString(8, mb.getId());
	 		//4단계 실행
	 		pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리작업
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try{pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try{con.close();} catch(SQLException ex) {}
		}
	}
	
	// deleteMember(mb)
	public void deleteMember(MemberBean mb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1단계 드라이버 로더			//2단계 디비연결
			con=getConnection();
			//3단계 sql delete
			String sql="delete from member where id=?";
	 		pstmt=con.prepareStatement(sql);
	 		pstmt.setString(1, mb.getId());
	 		//4단계 실행
	 		pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리작업
			if(rs!=null) try { rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try{pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try{con.close();} catch(SQLException ex) {}
		}
	}
	
	// getMemberList()
	public List getMemberList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List memberList = new ArrayList();
		try {
			// 1단계 드라이버 로더 //2단계 디비연결
			con = getConnection();
			// 3단계 sql(select) 만들고 실행할 객체 생성
			String sql = "select * from member";
			pstmt = con.prepareStatement(sql);
			// 4단계 : 결과저장 <= sql 구문 실행 select
			rs = pstmt.executeQuery();
			// 5단계 rs -> 첫행이동 => 한사람의 정보를 저장할 공간
			// MemberBean mb 객체생성 id변수 에 rs에서 가져온 id열 데이터저장
			// memberList 한칸에 한사람의 정보를 저장
			while (rs.next()) {
				// 한사람의 정보를 저장할 객체생성
				MemberBean mb = new MemberBean();
				System.out.println(mb);
				// 한사람의 객체생성한 기억장소에 저장
				mb.setId(rs.getString("id"));
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));
				mb.setReg_date(rs.getTimestamp("reg_date"));
				// 한사람의 정보를 배열 한칸에 저장
				memberList.add(mb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 마무리
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException ex) {
				}
		}
		return memberList;
	}

}//클래스

