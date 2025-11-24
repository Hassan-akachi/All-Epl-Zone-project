package com.pl.eplzone.mapper;

import com.pl.eplzone.dto.PlayerRequestDTO;
import com.pl.eplzone.dto.PlayerResponseDTO;
import com.pl.eplzone.model.Player;

import java.time.LocalDate;

public class PlayerMapper {

    // Convert Player entity to PlayerResponseDTO
    public static PlayerResponseDTO toDTO(Player player) {
        if (player == null) {
            return null;
        }

        PlayerResponseDTO dto = new PlayerResponseDTO();
        dto.setId(player.getId() != null ? player.getId().toString() : null);
        dto.setPlayer(player.getPlayer());
        dto.setNation(player.getNation());
        dto.setPos(player.getPos());
        dto.setAge(player.getAge());
        dto.setMp(player.getMp());
        dto.setStarts(player.getStarts());
        dto.setMin(player.getMin());
        dto.setGls(player.getGls());
        dto.setAst(player.getAst());
        dto.setPk(player.getPk());
        dto.setCrdy(player.getCrdy());
        dto.setCrdr(player.getCrdr());
        dto.setXg(player.getXg());
        dto.setXag(player.getXag());
        dto.setTeam(player.getTeam());

        return dto;
    }

    // Convert PlayerRequestDTO to Player entity
    public static Player toModel(PlayerRequestDTO dto) {
        if (dto == null) {
            return null;
        }

        Player player = new Player();
        player.setPlayer(dto.getPlayer());
        player.setNation(dto.getNation());
        player.setPos(dto.getPos());
        player.setAge(dto.getAge());
        player.setMp(dto.getMp());
        player.setStarts(dto.getStarts());
        player.setMin(dto.getMin());
        player.setGls(dto.getGls());
        player.setAst(dto.getAst());
        player.setPk(dto.getPk());
        player.setCrdy(dto.getCrdy());
        player.setCrdr(dto.getCrdr());
        player.setXg(dto.getXg());
        player.setXag(dto.getXag());
        player.setTeam(dto.getTeam());

        return player;
    }

    // Update existing Player entity from PlayerRequestDTO
    public static void updateModelFromDTO(Player player, PlayerRequestDTO dto) {
        if (player == null || dto == null) {
            return;
        }

        player.setPlayer(dto.getPlayer());
        player.setNation(dto.getNation());
        player.setPos(dto.getPos());
        player.setAge(dto.getAge());
        player.setMp(dto.getMp());
        player.setStarts(dto.getStarts());
        player.setMin(dto.getMin());
        player.setGls(dto.getGls());
        player.setAst(dto.getAst());
        player.setPk(dto.getPk());
        player.setCrdy(dto.getCrdy());
        player.setCrdr(dto.getCrdr());
        player.setXg(dto.getXg());
        player.setXag(dto.getXag());
        player.setTeam(dto.getTeam());
    }
}