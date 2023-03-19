package schedule;

import java.sql.Time;

public class LocationVO {
    private int idx;
    private String title;
    private String fromLoc;
    private String toLoc;
    private String distance;
    private String time;
    private String way;

    public LocationVO(){}

    public LocationVO(int idx, String title, String fromLoc, String toLoc, String distance, String time, String way) {
        this.idx = idx;
        this.title = title;
        this.fromLoc = fromLoc;
        this.toLoc = toLoc;
        this.distance = distance;
        this.time = time;
        this.way = way;
    }

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

    public String getFromLoc() {
        return fromLoc;
    }

    public void setFromLoc(String fromLoc) {
        this.fromLoc = fromLoc;
    }

    public String getToLoc() {
        return toLoc;
    }

    public void setToLoc(String toLoc) {
        this.toLoc = toLoc;
    }

    public String getDistance() {
        return distance;
    }

    public void setDistance(String distance) {
        this.distance = distance;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getWay() {
        return way;
    }

    public void setWay(String way) {
        this.way = way;
    }
}
