//package com.pl.eplzone.controller;
//
//import com.pl.eplzone.model.Player;
//import com.pl.eplzone.service.PlayerService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//
//import java.util.List;
//
//@RestController
//@RequestMapping(path = "api/v1/player")
//public class PlayerController {
//    private final PlayerService playerService;
//
//    @Autowired
//    public PlayerController(PlayerService playerService) {
//        this.playerService = playerService;
//    }
//
//
//    @GetMapping
//    public List<Player> getPlayers(
//            @RequestParam(required = false) String team,
//            @RequestParam(required = false) String name,
//            @RequestParam(required = false) String position,
//            @RequestParam(required = false) String nation
//    ) {
//
//        if (team != null && position !=null) {
//            return playerService.getPlayerByTeamAndPosition(team,position);
//        } else if (team != null) {
//            return playerService.getPlayerFromTeams(team);
//        } else if (name != null) {
//            return playerService.getPlayerByName(name);
//        } else if (position != null) {
//            return playerService.getPlayerByPosition(position);
//        } else if (nation != null) {
//            return playerService.getPlayerByNation(nation);
//        } else {
//            return playerService.getAllPlayers();
//        }
//
//
//    }
//
//
//    @PostMapping
//    public ResponseEntity<Player> addPlayer(@RequestBody Player player) {
//        Player createdPlayer = playerService.addPlayer(player);
//        return new ResponseEntity<>(createdPlayer, HttpStatus.CREATED);
//    }
//
//    @PutMapping
//    public ResponseEntity<Player> updatePlayer(@RequestBody Player player) {
//        Player updatedPlayer = playerService.updatePlayer(player);
//        if (updatedPlayer != null) {
//            return new ResponseEntity<>(updatedPlayer, HttpStatus.OK);
//        }
//       else{
//           return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//        }
//    }
//
//    @DeleteMapping("/{playerName}")
//    public ResponseEntity<String> deletePlayer(@PathVariable String player) {
//        playerService.deletePlayer(player);
//        return new ResponseEntity<>("Player deleted successfully",HttpStatus.OK);
//    }
//}




package com.pl.eplzone.controller;

import com.pl.eplzone.dto.PlayerRequestDTO;
import com.pl.eplzone.dto.PlayerResponseDTO;
import com.pl.eplzone.service.PlayerService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/players")
@Tag(name = "Player", description = "API for managing Premier League players")
public class PlayerController {

    private final PlayerService playerService;

    public PlayerController(PlayerService playerService) {
        this.playerService = playerService;
    }

    /**
     * Get all players with optional filters
     */
    @GetMapping
    @Operation(summary = "Get all players", description = "Retrieve all players with optional filters for team, position, and nation")
    public ResponseEntity<List<PlayerResponseDTO>> getPlayers(
            @Parameter(description = "Filter by team name")
            @RequestParam(required = false) String team,

            @Parameter(description = "Filter by player name")
            @RequestParam(required = false) String name,

            @Parameter(description = "Filter by position")
            @RequestParam(required = false) String position,

            @Parameter(description = "Filter by nation")
            @RequestParam(required = false) String nation
    ) {
        List<PlayerResponseDTO> players;

        // Handle different filter combinations
        if (name != null) {
            // If name is provided, return single player
            players = List.of(playerService.getPlayerByName(name));
        } else if (team != null && position != null) {
            // Filter by both team and position
            players = playerService.getPlayersByTeamAndPosition(team, position);
        } else if (team != null) {
            // Filter by team only
            players = playerService.getPlayersByTeam(team);
        } else if (position != null) {
            // Filter by position only
            players = playerService.getPlayersByPosition(position);
        } else if (nation != null) {
            // Filter by nation only
            players = playerService.getPlayersByNation(nation);
        } else {
            // No filters, return all players
            players = playerService.getAllPlayers();
        }

        return ResponseEntity.ok(players);
    }

    /**
     * Get player by ID
     */
    @GetMapping("/{id}")
    @Operation(summary = "Get player by ID", description = "Retrieve a specific player by their UUID")
    public ResponseEntity<PlayerResponseDTO> getPlayerById(
            @Parameter(description = "Player UUID")
            @PathVariable UUID id
    ) {
        PlayerResponseDTO player = playerService.getPlayerById(id);
        return ResponseEntity.ok(player);
    }

    /**
     * Search players with advanced filters
     */
    @GetMapping("/search")
    @Operation(summary = "Search players", description = "Advanced search with multiple optional criteria")
    public ResponseEntity<List<PlayerResponseDTO>> searchPlayers(
            @Parameter(description = "Filter by team name")
            @RequestParam(required = false) String team,

            @Parameter(description = "Filter by position")
            @RequestParam(required = false) String position,

            @Parameter(description = "Filter by nation")
            @RequestParam(required = false) String nation
    ) {
        List<PlayerResponseDTO> players = playerService.searchPlayers(team, position, nation);
        return ResponseEntity.ok(players);
    }

    /**
     * Get top scorers
     */
    @GetMapping("/top-scorers")
    @Operation(summary = "Get top scorers", description = "Retrieve players ordered by goals scored")
    public ResponseEntity<List<PlayerResponseDTO>> getTopScorers() {
        List<PlayerResponseDTO> players = playerService.getTopScorers();
        return ResponseEntity.ok(players);
    }

    /**
     * Get team top scorers
     */
    @GetMapping("/teams/{team}/top-scorers")
    @Operation(summary = "Get team top scorers", description = "Retrieve top scorers for a specific team")
    public ResponseEntity<List<PlayerResponseDTO>> getTeamTopScorers(
            @Parameter(description = "Team name")
            @PathVariable String team
    ) {
        List<PlayerResponseDTO> players = playerService.getTeamTopScorers(team);
        return ResponseEntity.ok(players);
    }

    /**
     * Create a new player
     */
    @PostMapping
    @Operation(summary = "Create a new player", description = "Add a new player to the database")
    public ResponseEntity<PlayerResponseDTO> createPlayer(
            @Valid @RequestBody PlayerRequestDTO playerRequestDTO
    ) {
        PlayerResponseDTO createdPlayer = playerService.createPlayer(playerRequestDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdPlayer);
    }

    /**
     * Update an existing player
     */
    @PutMapping("/{id}")
    @Operation(summary = "Update a player", description = "Update an existing player's information")
    public ResponseEntity<PlayerResponseDTO> updatePlayer(
            @Parameter(description = "Player UUID")
            @PathVariable UUID id,

            @Valid @RequestBody PlayerRequestDTO playerRequestDTO
    ) {
        PlayerResponseDTO updatedPlayer = playerService.updatePlayer(id, playerRequestDTO);
        return ResponseEntity.ok(updatedPlayer);
    }

    /**
     * Delete a player
     */
    @DeleteMapping("/{id}")
    @Operation(summary = "Delete a player", description = "Remove a player from the database")
    public ResponseEntity<Void> deletePlayer(
            @Parameter(description = "Player UUID")
            @PathVariable UUID id
    ) {
        playerService.deletePlayer(id);
        return ResponseEntity.noContent().build();
    }
}