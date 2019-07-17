package board;

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

import member.MemberBean;

public class BoardDAO {

	// 디비연결 메서드
	public Connection getConnection() throws Exception {
		//1단계 드라이버 로더
//		Class.forName("com.mysql.jdbc.Driver");
//		System.out.println("드라이버 로드 성공!");
//		//2단계 디비연결
//		String dbUrl="jdbc:mysql://localhost:3306/jspdb5";
//		 String dbUser="root";
//		 String dbPass="1234";
//		 Connection con=DriverManager.getConnection(dbUrl,dbUser,dbPass);
//		 System.out.println("DB 접속 성공!");
//		return con;
		
		

//		// context.xml 불러오기 위한 자바파일 객체생성
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/mysqlDB"); // 위치/이름
		Connection con = ds.getConnection();
		return con;
	}

	// insertBoard(bb) 메서드
	public void insertBoard(BoardBean bb, int BoardNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int num = 0;
		try {
			// 1단계 드라이버 로더 //2단계 디비연결
			con = getConnection();
			// 3단계 sql
			if(BoardNum ==1) {
			sql = "select max(num) from board";
			}
			else if(BoardNum ==2){
			sql = "select max(num) from board2";	
			}
			pstmt = con.prepareStatement(sql);
			// 4단계
			rs = pstmt.executeQuery();
			// 5단계
			if (rs.next()) {
				num = rs.getInt("max(num)") + 1;
			}
			// 3단계 sql (insert) now()
			if(BoardNum ==1) {
			sql = "insert into board(num,name,pass,subject,content,readcount,date,file) values(?,?,?,?,?,?,now(),?)";
			}
			else if(BoardNum == 2) {
			sql = "insert into board2(num,name,pass,subject,content,readcount,date,file) values(?,?,?,?,?,?,now(),?)";
			}
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num); // 첫번째 물음표,값
			pstmt.setString(2, bb.getName());// 두번째물음표,값
			pstmt.setString(3, bb.getPass());// 세번째물음표,값
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, 0); // readcount
			pstmt.setString(7, bb.getFile());
			// 4단계 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 마무리작업 // 기억장소 con pstmt rs 정리
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
	}

	// getBoardList() - board
	public List<BoardBean> getBoardList(int startRow, int pageSize, int boardNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		try {
			// 1단계 드라이버 로더 //2단계 디비연결
			con = getConnection();
			if(boardNum==1) {
			// 3단계 sql(select) 만들고 실행할 객체 생성
			sql = "select * from board order by num desc limit ?,?";
			}
			else if(boardNum==2) {
				
			sql = "select * from board2 order by num desc limit ?,?";	
			}
			else if(boardNum==3) {
				
			sql = "select * from board3 order by num desc limit ?,?";	
			}
//			String sql = null;
//			if(bb.getM() == null) {
//				sql = "select * from board order by num desc limit ?,?";
//			} else {
//				sql = "select * from m_board order by num desc limit ?,?";
//			}
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);
			// 4단계 : 결과저장 <= sql 구문 실행 select
			rs = pstmt.executeQuery();
			// 5단계 rs -> 첫행이동 => 한개의 글 정보를 저장할 공간
			// BoardBean mb 객체생성 id변수 에 rs에서 가져온 id열 데이터저장
			// boardList 한칸에 한사람의 정보를 저장
			while (rs.next()) {
				// 한개의 글 정보를 저장할 객체생성
				BoardBean bb = new BoardBean();
				// 한개의 글 객체생성한 기억장소에 저장
				bb.setNum(rs.getInt("num"));
				bb.setSubject(rs.getString("subject"));
				bb.setName(rs.getString("name"));
				bb.setDate(rs.getDate("date"));
				bb.setReadcount(rs.getInt("readcount"));
				// 한개의 글 정보를 배열 한칸에 저장
				boardList.add(bb);
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
		return boardList;
	}

	// getBoard(num)
	public BoardBean getBoard(int num, int boardNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardBean bb = null;
		String sql = null;
		try {
			// 1단계 드라이버 로더 //2단계 디비연결
			con = getConnection();
			// 3단계 sql(select) 만들고 실행할 객체 생성
			if(boardNum==1) {
			sql = "select * from board where num=?";	
				
			}else if(boardNum==2) {
				
			sql = "select * from board2 where num=?";	
			}
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 4단계 : 결과저장 <= sql 구문 실행 select
			rs = pstmt.executeQuery();
			// 5단계 : select 결과를 화면출력
			// rs위치 다음행 이동
			if (rs.next()) {
				bb = new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setSubject(rs.getString("subject"));
				bb.setName(rs.getString("name"));
				bb.setDate(rs.getDate("date"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setContent(rs.getString("content"));
				bb.setFile(rs.getString("file"));
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
		return bb;
	}

	// updateReadcount(num)
	public void updateReadcount(int num,int BoardNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			// 1단계 드라이버 로더 //2단계 디비연결
			con = getConnection();
			// 3단계 sql update set readcount=readcount+1
			if(BoardNum == 1) {
			sql = "update board set readcount=readcount+1 where num=?";
			}
			else if(BoardNum == 2) {
			sql = "update board2 set readcount=readcount+1 where num=?";

				
			}
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 4단계 실행
			pstmt.executeUpdate();
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
	}

	// numCheck(num,pass)
	public int numCheck(int num, String pass) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		// num 비밀번호 일치 1,비밀번호틀림 0, num없음 -1
		int check = -1;
		try {
			// 1단계 드라이버 로더 //2단계 디비연결
			con = getConnection();
			// 3단계 sql(select 조건 id=?) 만들고 실행할 객체 생성
			String sql = "select * from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 4단계 : 결과저장 <= sql 구문 실행 select
			rs = pstmt.executeQuery();
			// 5단계 : select 결과를 비교 해서 일치여부 확인
			if (rs.next()) { // true이면
				// 다음행 이동시 데이터가 있으면, num가 있으면
				if (pass.equals(rs.getString("pass"))) {
					// 비밀번호 일치하면
					check = 1;
				} else {
					// "비밀번호 틀림" 뒤로이동
					check = 0;
				}
			} else {
				// "num없음" 뒤로이동
				check = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
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
		return check;
	}

	// updateBoard(bb)
	public void updateBoard(BoardBean bb, int boardNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// 1단계 드라이버 로더 //2단계 디비연결
			con = getConnection();
			String sql = null;
			// 3단계 sql update
			if (boardNum == 1) {
				sql = "update board set name=?,subject=?,content=? where num=?";

				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bb.getName());
				pstmt.setString(2, bb.getSubject());
				pstmt.setString(3, bb.getContent());
				pstmt.setInt(4, bb.getNum());
			} else if (boardNum == 2) {
				sql = "update board2 set name=?,subject=?,content=?, file=? where num=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bb.getName());
				pstmt.setString(2, bb.getSubject());
				pstmt.setString(3, bb.getContent());
				pstmt.setString(4, bb.getFile());
				pstmt.setInt(5, bb.getNum());
			}
			// 4단계 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 마무리작업
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
	}


	// userCheck(함수처리할때 필요한 num,pass 가져가기)메서드
	public int userCheck(int num, String pass, int boardNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int check = -1;
		try {
			con = getConnection();
			// 3단계 sql(select 조건 id=?) 만들고 실행할 객체 생성
			if(boardNum == 1) {
				sql = "select * from board where num=?";
			} else if(boardNum == 2) {
				sql = "select * from board2 where num=?";	
			
			}
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 4단계 : 결과저장 <= sql 구문 실행 select
			rs = pstmt.executeQuery();
			// 5단계 : select 결과를 비교 해서 일치여부 확인
			if (rs.next()) { // true이면 id.equals(rs.getString("id"))
				// 다음행 이동시 데이터가 있으면, id가 있으면
				if (pass.equals(rs.getString("pass"))) {
					// 비밀번호 일치하면 세션값 생성 main.jsp 이동
					check = 1;
				} else {
					// "비밀번호 틀림" 뒤로이동
					check = 0;
				}
//			}else{
//				// "아이디없음"  뒤로이동
//				check=-1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
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
		return check;
	}

	// deleteboard(bb)
	public void deleteboard(BoardBean bb,int boardNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = getConnection();
			// 3단계 sql delete
			if(boardNum==1) {
				sql = "delete from board where num=?";
			} else if(boardNum==2) {
				
				sql = "delete from board2 where num=?";	
			}
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());
			// 4단계 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 마무리작업
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
	}

	// getBoardCount()
	public int getBoardCount(int boardNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		try {
			// 1,2 디비연결메서드 호출
			con = getConnection();
			// 3 sql select 객체생성
			if(boardNum ==1) {
			sql = "select count(*) from board";
			}
			else if(boardNum == 2) {
			sql = "select count(*) from board2";	
				
			}
			
			
			pstmt = con.prepareStatement(sql);
			// 4 rs = 실행
			rs = pstmt.executeQuery();
			// 5 rs 첫행이동 count = rs count(*) 가져와서 저장
			if (rs.next()) {
				count = rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
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
		return count;
	}

	// getBoardCount() search
	public int getBoardCount(String search,int boardNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		try {
			// 1,2 디비연결메서드 호출
			con = getConnection();
			// 3 sql select 객체생성
//			String sql="select count(*) from board where subject like '%search%'";
			if(boardNum==1) {
				sql = "select count(*) from board where subject like ?";
			}else if(boardNum==2) {
				sql = "select count(*) from board2 where subject like ?";
			}
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			// 4 rs = 실행
			rs = pstmt.executeQuery();
			// 5 rs 첫행이동 count = rs count(*) 가져와서 저장
			if (rs.next()) {
				count = rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
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
		return count;
	}

	// getBoardList() search
	public List<BoardBean> getBoardList(int startRow, int pageSize, String search, int boardNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		try {
			// 1단계 드라이버 로더 //2단계 디비연결
			con = getConnection();
			// 3단계 sql(select) 만들고 실행할 객체 생성
//			 String sql="select * from board order by num desc";
			if(boardNum==1) {
			sql = "select * from board where subject like ? order by num desc limit ?,?";
			}else if(boardNum==2) {
			sql = "select * from board2 where subject like ? order by num desc limit ?,?";
			}
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			pstmt.setInt(2, startRow - 1);
			pstmt.setInt(3, pageSize);
			// 4단계 : 결과저장 <= sql 구문 실행 select
			rs = pstmt.executeQuery();
			// 5단계 rs -> 첫행이동 => 한개의 글 정보를 저장할 공간 // BoardBean mb 객체생성 id변수 에 rs에서 가져온 id열
			// 데이터저장
			// boardList 한칸에 한사람의 정보를 저장
			while (rs.next()) {
				// 한개의 글 정보를 저장할 객체생성
				BoardBean bb = new BoardBean();
				// 한개의 글 객체생성한 기억장소에 저장
				bb.setNum(rs.getInt("num"));
				bb.setSubject(rs.getString("subject"));
				bb.setName(rs.getString("name"));
				bb.setDate(rs.getDate("date"));
				bb.setReadcount(rs.getInt("readcount"));
				// 한개의 글 정보를 배열 한칸에 저장
				boardList.add(bb);
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
		return boardList;
	}
	
	public void insertComment(int contentNum, String id, String comment) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// 디비연결, 외부파일, 예기치 못한 에러 발생 명령
			// 1단계 드라이버 로더 //2단계 디비연결
			con = getConnection();
			// 3단계 sql(insert) 만들고 실행할 객체 생성
			String sql = "insert into comment(contentnum, id, comment) values(?, ?, ?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, contentNum);
            pstmt.setString(2, id);
            pstmt.setString(3, comment);
			// 4단계 sql 실행
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			// 예외(에러)가 발생하면 처리하는 곳
			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
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
	}// insertComment메서드

	public List<BoardBean> getCommentList(int contentNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		List<BoardBean> commentList = new ArrayList<BoardBean>();
		try {
			// 1단계 드라이버 로더 //2단계 디비연결
			con = getConnection();
			// 3단계 sql(select) 만들고 실행할 객체 생성
			sql = "select * from comment where contentnum=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, contentNum);
			// 4단계 : 결과저장 <= sql 구문 실행 select
			rs = pstmt.executeQuery();
			// 5단계 rs -> 첫행이동 => 한개의 글 정보를 저장할 공간
			// BoardBean mb 객체생성 id변수 에 rs에서 가져온 id열 데이터저장
			// boardList 한칸에 한사람의 정보를 저장
			while (rs.next()) {
				// 한개의 글 정보를 저장할 객체생성
				BoardBean bb = new BoardBean();
				// 한개의 글 객체생성한 기억장소에 저장
				
				bb.setId(rs.getString("id"));
				bb.setComment(rs.getString("comment"));
				// 한개의 글 정보를 배열 한칸에 저장
				commentList.add(bb);
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
		return commentList;
	}
}