package Board;

public class BoardVO {
    private int idx;
    private String title;
    private String id;
    private String boardData;
    private int readCount;
    private int statusBoard;

    public int getIdx() {
        return idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getBoardData() {
        return boardData;
    }

    public void setBoardData(String boardData) {
        this.boardData = boardData;
    }

    public int getReadCount() {
        return readCount;
    }

    public void setReadCount(int readCount) {
        this.readCount = readCount;
    }

    public int getStatusBoard() {
        return statusBoard;
    }

    public void setStatusBoard(int statusBoard) {
        this.statusBoard = statusBoard;
    }
}
