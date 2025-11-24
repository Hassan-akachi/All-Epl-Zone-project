package com.pl.eplzone.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.DecimalMin;
import java.math.BigDecimal;

public class PlayerRequestDTO {

    @NotBlank(message = "Player name is required")
    private String player;

    private String nation;

    private String pos;

    @Min(value = 15, message = "Age must be at least 15")
    private Integer age;

    @Min(value = 0, message = "Matches played cannot be negative")
    private Integer mp;

    @Min(value = 0, message = "Starts cannot be negative")
    private Integer starts;

    @DecimalMin(value = "0.0", message = "Minutes cannot be negative")
    private BigDecimal min;

    @DecimalMin(value = "0.0", message = "Goals cannot be negative")
    private BigDecimal gls;

    @DecimalMin(value = "0.0", message = "Assists cannot be negative")
    private BigDecimal ast;

    @DecimalMin(value = "0.0", message = "Penalties cannot be negative")
    private BigDecimal pk;

    @DecimalMin(value = "0.0", message = "Yellow cards cannot be negative")
    private BigDecimal crdy;

    @DecimalMin(value = "0.0", message = "Red cards cannot be negative")
    private BigDecimal crdr;

    @DecimalMin(value = "0.0", message = "Expected goals cannot be negative")
    private BigDecimal xg;

    @DecimalMin(value = "0.0", message = "Expected assists cannot be negative")
    private BigDecimal xag;

    @NotBlank(message = "Team is required")
    private String team;

    // Getters and Setters
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
}