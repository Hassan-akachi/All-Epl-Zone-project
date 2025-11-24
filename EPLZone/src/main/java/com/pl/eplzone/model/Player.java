//package com.pl.eplzone.model;
//
//import jakarta.persistence.*;
//
//@Entity
//@Table(name = "prem_stats") // Maps to 'player_stats' table in database
//public class Player {
//
//
//    @Id
//    @Column(name = "player")
//    private String player;
//
//
//    private Integer age;
//    private Integer mp;
//    private Integer starts;
//    private Integer min;
//    private Integer gls;
//    private Integer ast;
//    private Integer pk;
//
//    private Integer crdy;
//
//
//    private Integer crdr;
//
//    private Double xg;
//    private Double xag;
//
//    private String nation;
//    private String pos;
//    private String team;
//
//
//    public Player(String name) {
//        this.player = name;
//    }
//
//    public Player(String player, Integer age, Integer mp, Integer starts, Integer min, Integer gls, Integer ast, Integer pk, Integer crdy, Integer crdr, Double xg, Double xag, String nation, String pos, String team) {
//        this.player = player;
//        this.age = age;
//        this.mp = mp;
//        this.starts = starts;
//        this.min = min;
//        this.gls = gls;
//        this.ast = ast;
//        this.pk = pk;
//        this.crdy = crdy;
//        this.crdr = crdr;
//        this.xg = xg;
//        this.xag = xag;
//        this.nation = nation;
//        this.pos = pos;
//        this.team = team;
//    }
//
//
//
//    public Player() {
//
//    }
//
//
//    public String getPlayer() {
//        return player;
//    }
//
//    public void setPlayer(String player) {
//        this.player = player;
//    }
//
//    public Integer getAge() {
//        return age;
//    }
//
//    public void setAge(Integer age) {
//        this.age = age;
//    }
//
//    public Integer getMp() {
//        return mp;
//    }
//
//    public void setMp(Integer mp) {
//        this.mp = mp;
//    }
//
//    public Integer getStarts() {
//        return starts;
//    }
//
//    public void setStarts(Integer starts) {
//        this.starts = starts;
//    }
//
//    public Integer getMin() {
//        return min;
//    }
//
//    public void setMin(Integer min) {
//        this.min = min;
//    }
//
//    public Integer getGls() {
//        return gls;
//    }
//
//    public void setGls(Integer gls) {
//        this.gls = gls;
//    }
//
//    public Integer getAst() {
//        return ast;
//    }
//
//    public void setAst(Integer ast) {
//        this.ast = ast;
//    }
//
//    public Integer getPk() {
//        return pk;
//    }
//
//    public void setPk(Integer pk) {
//        this.pk = pk;
//    }
//
//    public Integer getCrdy() {
//        return crdy;
//    }
//
//    public void setCrdy(Integer crdy) {
//        this.crdy = crdy;
//    }
//
//    public Integer getCrdr() {
//        return crdr;
//    }
//
//    public void setCrdr(Integer crdr) {
//        this.crdr = crdr;
//    }
//
//    public Double getXg() {
//        return xg;
//    }
//
//    public void setXg(Double xg) {
//        this.xg = xg;
//    }
//
//    public Double getXag() {
//        return xag;
//    }
//
//    public void setXag(Double xag) {
//        this.xag = xag;
//    }
//
//    public String getNation() {
//        return nation;
//    }
//
//    public void setNation(String nation) {
//        this.nation = nation;
//    }
//
//    public String getPos() {
//        return pos;
//    }
//
//    public void setPos(String pos) {
//        this.pos = pos;
//    }
//
//    public String getTeam() {
//        return team;
//    }
//
//    public void setTeam(String team) {
//        this.team = team;
//    }
//
//
//
//    // String representation of Player object
//    @Override
//    public String toString() {
//        return "Player{" +
//                "player='" + player + '\'' +
//                ", nation='" + nation + '\'' +
//                ", pos='" + pos + '\'' +
//                ", age=" + age +
//                ", mp=" + mp +
//                ", starts=" + starts +
//                ", min=" + min +
//                ", gls=" + gls +
//                ", ast=" + ast +
//                ", pk=" + pk +
//                ", crdy=" + crdy +
//                ", crdr=" + crdr +
//                ", xg=" + xg +
//                ", xag=" + xag +
//                ", team='" + team + '\'' +
//                '}';
//    }
//}



package com.pl.eplzone.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.UUID;

@Entity
@Table(name = "prem_stats")
public class Player {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;

    @NotNull
    @Column(name = "player", nullable = false)
    private String player;

    @Column(name = "nation")
    private String nation;

    @Column(name = "pos")
    private String pos;

    @Column(name = "age")
    private Integer age;

    @Column(name = "mp")
    private Integer mp;

    @Column(name = "starts")
    private Integer starts;

    @Column(name = "min", precision = 7, scale = 2)
    private BigDecimal min;

    @Column(name = "gls", precision = 5, scale = 2)
    private BigDecimal gls;

    @Column(name = "ast", precision = 5, scale = 2)
    private BigDecimal ast;

    @Column(name = "pk", precision = 5, scale = 2)
    private BigDecimal pk;

    @Column(name = "crdy", precision = 5, scale = 2)
    private BigDecimal crdy;

    @Column(name = "crdr", precision = 5, scale = 2)
    private BigDecimal crdr;

    @Column(name = "xg", precision = 5, scale = 2)
    private BigDecimal xg;

    @Column(name = "xag", precision = 5, scale = 2)
    private BigDecimal xag;

    @NotNull
    @Column(name = "team", nullable = false)
    private String team;

    // Constructors
    public Player() {
    }

    public Player(String player, String nation, String pos, Integer age, Integer mp,
                  Integer starts, BigDecimal min, BigDecimal gls, BigDecimal ast,
                  BigDecimal pk, BigDecimal crdy, BigDecimal crdr, BigDecimal xg,
                  BigDecimal xag, String team) {
        this.player = player;
        this.nation = nation;
        this.pos = pos;
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
        this.team = team;
    }

    // Getters and Setters
    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getPlayer() {
        return player;
    }

    public void setPlayer(String player) {
        this.player = player;
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

    public BigDecimal getMin() {
        return min;
    }

    public void setMin(BigDecimal min) {
        this.min = min;
    }

    public BigDecimal getGls() {
        return gls;
    }

    public void setGls(BigDecimal gls) {
        this.gls = gls;
    }

    public BigDecimal getAst() {
        return ast;
    }

    public void setAst(BigDecimal ast) {
        this.ast = ast;
    }

    public BigDecimal getPk() {
        return pk;
    }

    public void setPk(BigDecimal pk) {
        this.pk = pk;
    }

    public BigDecimal getCrdy() {
        return crdy;
    }

    public void setCrdy(BigDecimal crdy) {
        this.crdy = crdy;
    }

    public BigDecimal getCrdr() {
        return crdr;
    }

    public void setCrdr(BigDecimal crdr) {
        this.crdr = crdr;
    }

    public BigDecimal getXg() {
        return xg;
    }

    public void setXg(BigDecimal xg) {
        this.xg = xg;
    }

    public BigDecimal getXag() {
        return xag;
    }

    public void setXag(BigDecimal xag) {
        this.xag = xag;
    }

    public String getTeam() {
        return team;
    }

    public void setTeam(String team) {
        this.team = team;
    }

    @Override
    public String toString() {
        return "Player{" +
                "id=" + id +
                ", player='" + player + '\'' +
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