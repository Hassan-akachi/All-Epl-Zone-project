//package com.pl.eplzone.service;
//
//import com.pl.eplzone.model.Player;
//import com.pl.eplzone.repository.PlayerRepository;
//import jakarta.transaction.Transactional;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Component;
//import org.springframework.stereotype.Service;
//
//import java.util.List;
//import java.util.Optional;
//import java.util.stream.Collectors;
//
//@Service
//@Component
//public class PlayerService {
//
//
//    private PlayerRepository playerRepository;
//
//    @Autowired
//    public PlayerService(PlayerRepository playerRepository) {
//        this.playerRepository = playerRepository;
//    }
//
//    public List<Player> getAllPlayers() {
//        return playerRepository.findAll();
//    }
//
//    public List<Player> getPlayerByName(String name) {
//        return  playerRepository.findAll().stream()
//                .filter(player -> name.equals(player.getPlayer()))
//                .collect(Collectors.toList());
//    }
//
//
//    public List<Player> getPlayerFromTeams(String teamName) {
//        return  playerRepository.findAll().stream()
//                .filter(player -> teamName.equals(player.getTeam()))
//                .collect(Collectors.toList());
//    }
//
//    public List<Player> getPlayerByPosition(String searchText){
//        return  playerRepository.findAll().stream()
//                .filter(player ->
//                        player.getPos().toLowerCase().contains(searchText.toLowerCase()))
//                .collect(Collectors.toList());
//    }
//
//    public List<Player> getPlayerByNation(String searchText){
//        return  playerRepository.findAll().stream()
//                .filter(player ->
//                        player.getNation().toLowerCase().contains(searchText.toLowerCase()))
//                .collect(Collectors.toList());
//    }
//
//    public List<Player> getPlayerByTeamAndPosition(String team, String position){
//        return  playerRepository.findAll().stream()
//                .filter(player ->
//                        team.equals(player.getTeam()) && position.equals(player.getPos()))
//                .collect(Collectors.toList());
//    }
//
//    public  Player addPlayer(Player player){
//        playerRepository.save(player);
//        return player;
//    }
//
//    public Player updatePlayer(Player updatedplayer){
//        Optional<Player> existingPlayer = playerRepository.findByPlayer(updatedplayer.getPlayer());
//
//        if(existingPlayer.isPresent()){
//            Player playerToUpdate = existingPlayer.get();
//            playerToUpdate.setPlayer(updatedplayer.getPlayer());
//            playerToUpdate.setTeam(updatedplayer.getTeam());
//            playerToUpdate.setNation(updatedplayer.getNation());
//            playerToUpdate.setPos(updatedplayer.getPos());
//
//
//            playerRepository.save(playerToUpdate);
//            return playerToUpdate;
//        }
//        return null;
//    }
//
//    @Transactional
//    public void deletePlayer(String playerName){
//        playerRepository.deleteByPlayer(playerName);
//    }
//}





package com.pl.eplzone.service;

import com.pl.eplzone.dto.PlayerRequestDTO;
import com.pl.eplzone.dto.PlayerResponseDTO;
import com.pl.eplzone.exception.PlayerAlreadyExistsException;
import com.pl.eplzone.exception.PlayerNotFoundException;
import com.pl.eplzone.mapper.PlayerMapper;
import com.pl.eplzone.model.Player;
import com.pl.eplzone.repository.PlayerRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class PlayerService {

    private final PlayerRepository playerRepository;

    public PlayerService(PlayerRepository playerRepository) {
        this.playerRepository = playerRepository;
    }

    /**
     * Get all players
     */
    public List<PlayerResponseDTO> getAllPlayers() {
        List<Player> players = playerRepository.findAll();
        return players.stream()
                .map(PlayerMapper::toDTO)
                .collect(Collectors.toList());
    }

    /**
     * Get player by ID
     */
    public PlayerResponseDTO getPlayerById(UUID id) {
        Player player = playerRepository.findById(id)
                .orElseThrow(() -> new PlayerNotFoundException("Player not found with ID: " + id));
        return PlayerMapper.toDTO(player);
    }

    /**
     * Get player by name
     */
    public PlayerResponseDTO getPlayerByName(String name) {
        Player player = playerRepository.findByPlayer(name)
                .orElseThrow(() -> new PlayerNotFoundException("Player not found with name: " + name));
        return PlayerMapper.toDTO(player);
    }

    /**
     * Get players by team
     */
    public List<PlayerResponseDTO> getPlayersByTeam(String team) {
        List<Player> players = playerRepository.findByTeam(team);
        return players.stream()
                .map(PlayerMapper::toDTO)
                .collect(Collectors.toList());
    }

    /**
     * Get players by position
     */
    public List<PlayerResponseDTO> getPlayersByPosition(String position) {
        List<Player> players = playerRepository.findByPosContainingIgnoreCase(position);
        return players.stream()
                .map(PlayerMapper::toDTO)
                .collect(Collectors.toList());
    }

    /**
     * Get players by nation
     */
    public List<PlayerResponseDTO> getPlayersByNation(String nation) {
        List<Player> players = playerRepository.findByNationContainingIgnoreCase(nation);
        return players.stream()
                .map(PlayerMapper::toDTO)
                .collect(Collectors.toList());
    }

    /**
     * Get players by team and position
     */
    public List<PlayerResponseDTO> getPlayersByTeamAndPosition(String team, String position) {
        List<Player> players = playerRepository.findByTeamAndPos(team, position);
        return players.stream()
                .map(PlayerMapper::toDTO)
                .collect(Collectors.toList());
    }

    /**
     * Search players by multiple criteria
     */
    public List<PlayerResponseDTO> searchPlayers(String team, String position, String nation) {
        List<Player> players = playerRepository.searchPlayers(team, position, nation);
        return players.stream()
                .map(PlayerMapper::toDTO)
                .collect(Collectors.toList());
    }

    /**
     * Get top scorers
     */
    public List<PlayerResponseDTO> getTopScorers() {
        List<Player> players = playerRepository.findTopScorers();
        return players.stream()
                .map(PlayerMapper::toDTO)
                .collect(Collectors.toList());
    }

    /**
     * Get team top scorers
     */
    public List<PlayerResponseDTO> getTeamTopScorers(String team) {
        List<Player> players = playerRepository.findTeamTopScorers(team);
        return players.stream()
                .map(PlayerMapper::toDTO)
                .collect(Collectors.toList());
    }

    /**
     * Create a new player
     */
    @Transactional
    public PlayerResponseDTO createPlayer(PlayerRequestDTO playerRequestDTO) {
        // Check if player already exists
        if (playerRepository.existsByPlayer(playerRequestDTO.getPlayer())) {
            throw new PlayerAlreadyExistsException(
                    "A player with this name already exists: " + playerRequestDTO.getPlayer()
            );
        }

        // Create and save new player
        Player newPlayer = PlayerMapper.toModel(playerRequestDTO);
        Player savedPlayer = playerRepository.save(newPlayer);

        return PlayerMapper.toDTO(savedPlayer);
    }

    /**
     * Update an existing player
     */
    @Transactional
    public PlayerResponseDTO updatePlayer(UUID id, PlayerRequestDTO playerRequestDTO) {
        // Find existing player
        Player existingPlayer = playerRepository.findById(id)
                .orElseThrow(() -> new PlayerNotFoundException("Player not found with ID: " + id));

        // Check if the new name conflicts with another player
        if (playerRepository.existsByPlayerAndIdNot(playerRequestDTO.getPlayer(), id)) {
            throw new PlayerAlreadyExistsException(
                    "A player with this name already exists: " + playerRequestDTO.getPlayer()
            );
        }

        // Update player details
        PlayerMapper.updateModelFromDTO(existingPlayer, playerRequestDTO);

        // Save updated player
        Player updatedPlayer = playerRepository.save(existingPlayer);

        return PlayerMapper.toDTO(updatedPlayer);
    }

    /**
     * Delete a player by ID
     */
    @Transactional
    public void deletePlayer(UUID id) {
        if (!playerRepository.existsById(id)) {
            throw new PlayerNotFoundException("Player not found with ID: " + id);
        }
        playerRepository.deleteById(id);
    }
}
