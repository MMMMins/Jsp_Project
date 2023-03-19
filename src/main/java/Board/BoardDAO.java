package Board;

import java.sql.*;
import java.util.ArrayList;

public class BoardDAO {
    private Connection conn;
    private Statement stat;
    private PreparedStatement pstat; // 사용자 값 입력시 처리
    private ResultSet rs;
    private String sqlQuery;

    private final String dbID = "root";
    private final String dbPwd = "test1234";
    private final String dbURL = "jdbc:mysql://localhost:3306/projectDB";

    public BoardDAO(){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPwd);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public String getDateNow(){
        sqlQuery = "SELECT NOW()";
        try{
            pstat = conn.prepareStatement(sqlQuery);
            rs = pstat.executeQuery();
            if(rs.next()){
                return rs.getString(1);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }

    public int getNextPage(){
        sqlQuery = "SELECT idx FROM board ORDER BY idx DESC";
        try{
            pstat = conn.prepareStatement(sqlQuery);
            rs = pstat.executeQuery();
            if(rs.next()){
                return rs.getInt(1) + 1;
            }
            return 1;
        }catch (Exception e){
            e.printStackTrace();
        }
        return -1;
    }

    public int insertBoard(BoardVO vo){
        sqlQuery = "INSERT INTO board VALUES(?,?,?,?,0,1)";
        try{
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setInt(1, vo.getIdx());
            pstat.setString(2, vo.getTitle());
            pstat.setString(3, vo.getId());
            pstat.setString(4, vo.getBoardData());
            int result = pstat.executeUpdate();
            return result;
        }catch (Exception e){
            e.printStackTrace();
        }
        return -1;
    }

    public ArrayList<BoardVO> getBoardList(int pageIdx){
        int pageNumber = getNextPage();
        sqlQuery = "SELECT * FROM board WHERE idx < ? AND statusBoard = 1 ORDER BY idx DESC LIMIT 10";
        ArrayList<BoardVO> list = new ArrayList<>();
        try{
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setInt(1,  pageNumber - (pageIdx - 1) * 10);
            rs = pstat.executeQuery();

            while(rs.next()){
                BoardVO bvo = new BoardVO();
                bvo.setIdx(rs.getInt("idx"));
                bvo.setTitle(rs.getString("title"));
                bvo.setId(rs.getString("id"));
                bvo.setBoardData(rs.getString("boardDate"));
                bvo.setReadCount(rs.getInt("readCount"));
                bvo.setStatusBoard(rs.getInt("statusBoard"));
                list.add(bvo);
            }
        }catch (Exception e){
                e.printStackTrace();
        }
        return list;
    }

    public boolean isPage(int pageIdx){
        sqlQuery = "SELECT * FROM board WHERE idx < ? AND statudBoard = 1";
        try{
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setInt(1, getNextPage() - (pageIdx - 1) * 10);
            rs = pstat.executeQuery();
            return rs.next();
        }catch (Exception e){
            e.printStackTrace();
        }
        return false;
    }

    public BoardVO getView(int idx){
        sqlQuery = "SELECT * FROM board WHERE idx = ?";
        BoardVO bvo = new BoardVO();
        try{
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setInt(1, idx);
            rs = pstat.executeQuery();
            if(rs.next()){
                bvo.setIdx(rs.getInt(1));
                bvo.setTitle(rs.getString(2));
                bvo.setId(rs.getString(3));
                bvo.setBoardData(rs.getString(4).substring(0,11));
                bvo.setReadCount(rs.getInt(5));
                bvo.setStatusBoard(rs.getInt(6));
            }
            return bvo;
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public int deletePage(int idx){
        sqlQuery = "UPDATE board SET statusBoard = 0 WHERE idx = ?";
        try{
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setInt(1, idx);
            return pstat.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        return -1;
    }

    public int updateReadCount(int idx){
        sqlQuery = "UPDATE board SET readCount = readCount + 1 WHERE idx = ?";
        try{
            pstat = conn.prepareStatement(sqlQuery);
            pstat.setInt(1, idx);
            return pstat.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        return - 1;
    }
}
