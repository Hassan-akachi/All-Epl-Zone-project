package com.pl.eplzone.model;

import jakarta.persistence.*;

@Entity
@Table(name = "prem_stats") // Maps to 'player_stats' table in database
public class Player {


    @Id
    @Column(name = "player")
    private String player;


    private Integer age;
    private Integer mp;
    private Integer starts;
    private Integer min;
    private Integer gls;
    private Integer ast;
    private Integer pk;

    private Integer crdy;


    private Integer crdr;

    private Double xg;
    private Double xag;

    private String nation;
    private String pos;
    private String team;


    public Player(String name) {
        this.player = name;
    }

    public Player(String player, Integer age, Integer mp, Integer starts, Integer min, Integer gls, Integer ast, Integer pk, Integer crdy, Integer crdr, Double xg, Double xag, String nation, String pos, String team) {
        this.player = player;
        this.age = age;
        this.mp = mp;
        this.starts = starts;
        this.min = min;
        this.gls = gls;
        this.ast = ast;
        this.pk = pk;
        this.crdy = crdy;
        this.crdr = crdr;
        this.xg = xg;
        this.xag = xag;
        this.nation = nation;
        this.pos = pos;
        this.team = team;
    }



    public Player() {

    }


    public String getPlayer() {
        return player;
    }

    public void setPlayer(String player) {
        this.player = player;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public Integer getMp() {
        return mp;
    }

    public void setMp(Integer mp) {
        this.mp = mp;
    }

    public Integer getStarts() {
        return starts;
    }

    public void setStarts(Integer starts) {
        this.starts = starts;
    }

    public Integer getMin() {
        return min;
    }

    public void setMin(Integer min) {
        this.min = min;
    }

    public Integer getGls() {
        return gls;
    }

    public void setGls(Integer gls) {
        this.gls = gls;
    }

    public Integer getAst() {
        return ast;
    }

    public void setAst(Integer ast) {
        this.ast = ast;
    }

    public Integer getPk() {
        return pk;
    }

    public void setPk(Integer pk) {
        this.pk = pk;
    }

    public Integer getCrdy() {
        return crdy;
    }

    public void setCrdy(Integer crdy) {
        this.crdy = crdy;
    }

    public Integer getCrdr() {
        return crdr;
    }

    public void setCrdr(Integer crdr) {
        this.crdr = crdr;
    }

    public Double getXg() {
        return xg;
    }

    public void setXg(Double xg) {
        this.xg = xg;
    }

    public Double getXag() {
        return xag;
    }

    public void setXag(Double xag) {
        this.xag = xag;
    }

    public String getNation() {
        return nation;
    }

    public void setNation(String nation) {
        this.nation = nation;
    }

    public String getPos() {
        return pos;
    }

    public void setPos(String pos) {
        this.pos = pos;
    }

    public String getTeam() {
        return team;
    }

    public void setTeam(String team) {
        this.team = team;
    }



    // String representation of Player object
    @Override
    public String toString() {
        return "Player{" +
                "player='" + player + '\'' +
                ", nation='" + nation + '\'' +
                ", pos='" + pos + '\'' +
                ", age=" + age +
                ", mp=" + mp +
                ", starts=" + starts +
                ", min=" + min +
                ", gls=" + gls +
                ", ast=" + ast +
                ", pk=" + pk +
                ", crdy=" + crdy +
                ", crdr=" + crdr +
                ", xg=" + xg +
                ", xag=" + xag +
                ", team='" + team + '\'' +
                '}';
    }
}