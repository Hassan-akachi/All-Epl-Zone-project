package com.pl.eplzone.service;

import com.pl.eplzone.model.Player;
import com.pl.eplzone.repository.PlayerRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Component
public class PlayerService {


    private PlayerRepository playerRepository;

    @Autowired
    public PlayerService(PlayerRepository playerRepository) {
        this.playerRepository = playerRepository;
    }

    public List<Player> getAllPlayers() {
        return playerRepository.findAll();
    }

    public List<Player> getPlayerByName(String name) {
        return  playerRepository.findAll().stream()
                .filter(player -> name.equals(player.getPlayer()))
                .collect(Collectors.toList());
    }


    public List<Player> getPlayerFromTeams(String teamName) {
        return  playerRepository.findAll().stream()
                .filter(player -> teamName.equals(player.getTeam()))
                .collect(Collectors.toList());
    }

    public List<Player> getPlayerByPosition(String searchText){
        return  playerRepository.findAll().stream()
                .filter(player ->
                        player.getPos().toLowerCase().contains(searchText.toLowerCase()))
                .collect(Collectors.toList());
    }

    public List<Player> getPlayerByNation(String searchText){
        return  playerRepository.findAll().stream()
                .filter(player ->
                        player.getNation().toLowerCase().contains(searchText.toLowerCase()))
                .collect(Collectors.toList());
    }

    public List<Player> getPlayerByTeamAndPosition(String team, String position){
        return  playerRepository.findAll().stream()
                .filter(player ->
                        team.equals(player.getTeam()) && position.equals(player.getPos()))
                .collect(Collectors.toList());
    }

    public  Player addPlayer(Player player){
        playerRepository.save(player);
        return player;
    }

    public Player updatePlayer(Player updatedplayer){
        Optional<Player> existingPlayer = playerRepository.findByPlayer(updatedplayer.getPlayer());

        if(existingPlayer.isPresent()){
            Player playerToUpdate = existingPlayer.get();
            playerToUpdate.setPlayer(updatedplayer.getPlayer());
            playerToUpdate.setTeam(updatedplayer.getTeam());
            playerToUpdate.setNation(updatedplayer.getNation());
            playerToUpdate.setPos(updatedplayer.getPos());


            playerRepository.save(playerToUpdate);
            return playerToUpdate;
        }
        return null;
    }

    @Transactional
    public void deletePlayer(String playerName){
        playerRepository.deleteByPlayer(playerName);
    }
}
